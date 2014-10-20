-- Russian translator required

-------------
-- ЯUSSIAИ --
-------------
-- Last update: 09.10.2014 - 09:41
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
    HEALBOT_DRUID                           = "Друид"
    HEALBOT_HUNTER                          = "Охотник"
    HEALBOT_MAGE                            = "Маг"
    HEALBOT_PALADIN                         = "Паладин"
    HEALBOT_PRIEST                          = "Жрец"
    HEALBOT_ROGUE                           = "Разбойник"
    HEALBOT_SHAMAN                          = "Шаман"
    HEALBOT_WARLOCK                         = "Чернокнижник"
    HEALBOT_WARRIOR                         = "Воин"
    HEALBOT_DEATHKNIGHT                     = "Рыцарь cмерти"
    HEALBOT_MONK                            = "Монах"

    HEALBOT_DISEASE                         = "Болезнь"
    HEALBOT_MAGIC                           = "Магия"
    HEALBOT_CURSE                           = "Проклятие"
    HEALBOT_POISON                          = "Яд"

    HB_TOOLTIP_OFFLINE                      = PLAYER_OFFLINE
    HB_OFFLINE                              = PLAYER_OFFLINE -- has gone offline msg
    HB_ONLINE                               = GUILD_ONLINE_LABEL -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot"
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION
    HEALBOT_LOADED                          = " загружен."

    HEALBOT_ACTION_OPTIONS                  = "Настройки"

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON
    HEALBOT_OPTIONS_DEFAULTS                = "По умолчанию"
    HEALBOT_OPTIONS_CLOSE                   = "Закрыть"
    HEALBOT_OPTIONS_HARDRESET               = "Перезагрузить UI"
    HEALBOT_OPTIONS_SOFTRESET               = "Сбросить HB"
    HEALBOT_OPTIONS_TAB_GENERAL             = "Общее"
    HEALBOT_OPTIONS_TAB_SPELLS              = "Заклинания"
    HEALBOT_OPTIONS_TAB_HEALING             = "Исцеление"
    HEALBOT_OPTIONS_TAB_CDC                 = "Излечение"
    HEALBOT_OPTIONS_TAB_SKIN                = "Стили"
    HEALBOT_OPTIONS_TAB_TIPS                = "Подсказки"
    HEALBOT_OPTIONS_TAB_BUFFS               = "Баффы"

    HEALBOT_OPTIONS_BARALPHA                = "Прозрачность активных"
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Прозрачность входящего исцеления"
    HEALBOT_OPTIONS_BARALPHABACK            = "Прозрачность фона"
    HEALBOT_OPTIONS_BARALPHAEOR             = "Прозрачность вне досягаемости"
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Закрепить позицию"
    HEALBOT_OPTIONS_AUTOSHOW                = "Закрывать автоматически"
    HEALBOT_OPTIONS_PANELSOUNDS             = "Звук при открытии"
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Скрыть кнопку настроек"
    HEALBOT_OPTIONS_PROTECTPVP              = "Избегать PvP"
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Настройки чата"

    HEALBOT_OPTIONS_FRAMESCALE              = "Масштаб окна"
    HEALBOT_OPTIONS_SKINTEXT                = "Стиль"
    HEALBOT_SKINS_STD                       = "Стандарт"
    HEALBOT_OPTIONS_SKINTEXTURE             = "Текстура"
    HEALBOT_OPTIONS_SKINHEIGHT              = "Высота"
    HEALBOT_OPTIONS_SKINWIDTH               = "Ширина"
    HEALBOT_OPTIONS_SKINNUMCOLS             = "Колонок"
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "Групп в колонке"
    HEALBOT_OPTIONS_SKINBRSPACE             = "Промежуток строк"
    HEALBOT_OPTIONS_SKINBCSPACE             = "Промежуток рядов"
    HEALBOT_OPTIONS_EXTRASORT               = "Сортировать панели по"
    HEALBOT_SORTBY_NAME                     = "Имя"
    HEALBOT_SORTBY_CLASS                    = "Класс"
    HEALBOT_SORTBY_GROUP                    = "Группа"
    HEALBOT_SORTBY_MAXHEALTH                = "Максимум здоровья"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Новый Дебафф"
    HEALBOT_OPTIONS_DELSKIN                 = "Удалить"
    HEALBOT_OPTIONS_NEWSKINTEXT             = "Новый стиль"
    HEALBOT_OPTIONS_SAVESKIN                = "Сохранить"
    HEALBOT_OPTIONS_SKINBARS                = "Опции панели"
    HEALBOT_SKIN_ENTEXT                     = "Активный"
    HEALBOT_SKIN_DISTEXT                    = "Не активный"
    HEALBOT_SKIN_DEBTEXT                    = "Дебафф"
    HEALBOT_SKIN_BACKTEXT                   = "Фон"
    HEALBOT_SKIN_BORDERTEXT                 = "Рамка"
    HEALBOT_OPTIONS_SKINFONT                = "Шрифт"
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Размер шрифта"
    HEALBOT_OPTIONS_SKINFOUTLINE            = "Контур шрифта"
    HEALBOT_OPTIONS_BARALPHADIS             = "Прозрачностьть откл."
    HEALBOT_OPTIONS_SHOWHEADERS             = "Показывать заголовки"

    HEALBOT_OPTIONS_ITEMS                   = "Предметы"

    HEALBOT_OPTIONS_COMBOCLASS              = "Клавиши для"
    HEALBOT_OPTIONS_CLICK                   = "Клик"
    HEALBOT_OPTIONS_SHIFT                   = "Shift"
    HEALBOT_OPTIONS_CTRL                    = "Ctrl"
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Всегда включено"

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Без сообщений"
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Оповещать себя"
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Оповещать цель"
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Оповещать группу"
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Оповещать рейд"
    HEALBOT_OPTIONS_CASTNOTIFY6             = "Оповещать в канал"
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Оповещать только о воскрешении"

    HEALBOT_OPTIONS_CDCBARS                 = "Цвет полос"
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "На полосе здоровья"
    HEALBOT_OPTIONS_CDCSHOWABARS            = "На полосе угрозы"
    HEALBOT_OPTIONS_CDCWARNINGS             = "Предупреждения о дебафах"
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Показывать дебафф"
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Отображать предупреждение при дебаффе"
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Звук при дебаффе"
    HEALBOT_OPTIONS_SOUND                   = "Звук"

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Панели исцелений"
    HEALBOT_OPTIONS_SELFHEALS               = "Игрок"
    HEALBOT_OPTIONS_PETHEALS                = "Питомцы"
    HEALBOT_OPTIONS_GROUPHEALS              = "Группа"
    HEALBOT_OPTIONS_TANKHEALS               = "Главные танки"
    HEALBOT_OPTIONS_PRIVATETANKS            = "Личные танки"
    HEALBOT_OPTIONS_TARGETHEALS             = "Цели"
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Рейд"
    HEALBOT_OPTIONS_EMERGFILTER             = "Рейдовые полосы для"
    HEALBOT_OPTIONS_EMERGFCLASS             = "Настроить классы для"
    HEALBOT_OPTIONS_COMBOBUTTON             = "Кнопка"
    HEALBOT_OPTIONS_BUTTONLEFT              = "Левая"
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Средняя"
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Правая"
    HEALBOT_OPTIONS_BUTTON4                 = "Кнопка4"
    HEALBOT_OPTIONS_BUTTON5                 = "Кнопка5"
    HEALBOT_OPTIONS_BUTTON6                 = "Кнопка6"
    HEALBOT_OPTIONS_BUTTON7                 = "Кнопка7"
    HEALBOT_OPTIONS_BUTTON8                 = "Кнопка8"
    HEALBOT_OPTIONS_BUTTON9                 = "Кнопка9"
    HEALBOT_OPTIONS_BUTTON10                = "Кнопка10"
    HEALBOT_OPTIONS_BUTTON11                = "Кнопка11"
    HEALBOT_OPTIONS_BUTTON12                = "Кнопка12"
    HEALBOT_OPTIONS_BUTTON13                = "Кнопка13"
    HEALBOT_OPTIONS_BUTTON14                = "Кнопка14"
    HEALBOT_OPTIONS_BUTTON15                = "Кнопка15"

    HEALBOT_CLASSES_ALL                     = "Все классы"
    HEALBOT_CLASSES_MELEE                   = "Ближний бой"
    HEALBOT_CLASSES_RANGES                  = "Дальний бой"
    HEALBOT_CLASSES_HEALERS                 = "Целители"
    HEALBOT_CLASSES_CUSTOM                  = "Пользовательские"

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Показывать подсказки"
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Расширенная информация о заклинании"
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Восстановление заклинания"
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Информация о цели"
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Рекомендации о периодическом лечении"
    HEALBOT_TOOLTIP_POSDEFAULT              = "По умолчанию"
    HEALBOT_TOOLTIP_POSLEFT                 = "Слева от Healbot'a"
    HEALBOT_TOOLTIP_POSRIGHT                = "Справа от Healbot'a"
    HEALBOT_TOOLTIP_POSABOVE                = "Над Healbot'ом"
    HEALBOT_TOOLTIP_POSBELOW                = "Под Healbot'ом"
    HEALBOT_TOOLTIP_POSCURSOR               = "Под курсором"
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Рекомендации по HoT-ам"
    HEALBOT_TOOLTIP_NONE                    = "нет доступных"
    HEALBOT_TOOLTIP_CORPSE                  = "Труп "
    HEALBOT_TOOLTIP_CD                      = " (КД "
    HEALBOT_TOOLTIP_SECS                    = "с)"
    HEALBOT_WORDS_SEC                       = "сек"
    HEALBOT_WORDS_CAST                      = "Применение"
    HEALBOT_WORDS_UNKNOWN                   = "Неизвестно"
    HEALBOT_WORDS_YES                       = "Да"
    HEALBOT_WORDS_NO                        = "Нет"
    HEALBOT_WORDS_THIN                      = "Тонкий"
    HEALBOT_WORDS_THICK                     = "Толстый"

    HEALBOT_WORDS_NONE                      = "Нет"
    HEALBOT_OPTIONS_ALT                     = "Alt"
    HEALBOT_DISABLED_TARGET                 = "Цель"
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Класс на панели"
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Здоровье на панели"
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Включая входящее исцеление"
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Разделять входящие исцеления"
    HEALBOT_OPTIONS_BARHEALTH1              = "в числах"
    HEALBOT_OPTIONS_BARHEALTH2              = "в процентах"
    HEALBOT_OPTIONS_TIPTEXT                 = "Информация в подсказке"
    HEALBOT_OPTIONS_POSTOOLTIP              = "Подсказка"
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Имена на панели"
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Текст по цвету класса"
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Включая рейд-группы"

    HEALBOT_ONE                             = "1"
    HEALBOT_TWO                             = "2"
    HEALBOT_THREE                           = "3"
    HEALBOT_FOUR                            = "4"
    HEALBOT_FIVE                            = "5"
    HEALBOT_SIX                             = "6"
    HEALBOT_SEVEN                           = "7"
    HEALBOT_EIGHT                           = "8"

    HEALBOT_OPTIONS_SETDEFAULTS             = "По умолчанию"
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Сброс всех настроек на стандартные"
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "ПКМ открывает настройки"

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "Настройки заголовков"
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Настройки иконок"
    HEALBOT_SKIN_HEADERBARCOL               = "Цвет панелей"
    HEALBOT_SKIN_HEADERTEXTCOL              = "Цвет текста"
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Заклинание"
    HEALBOT_OPTIONS_BUFFSTEXT2              = "Проверять"
    HEALBOT_OPTIONS_BUFFSTEXT3              = "Цвета панелей"
    HEALBOT_OPTIONS_BUFF                    = "Бафф"
    HEALBOT_OPTIONS_BUFFSELF                = "на себя"
    HEALBOT_OPTIONS_BUFFPARTY               = "на группу"
    HEALBOT_OPTIONS_BUFFRAID                = "на рейд"
    HEALBOT_OPTIONS_MONITORBUFFS            = "Следить за отсутствием баффов"
    HEALBOT_OPTIONS_MONITORBUFFSC           = "также в бою"
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "УмныйКаст вне боя"
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Включая заклинания"
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Снять дебафф"
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Применить бафф"
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Заклинания исцеления"
    HEALBOT_OPTIONS_BAR2SIZE                = "Размер полосы энергии"
    HEALBOT_OPTIONS_SETSPELLS               = "Заклинания для"
    HEALBOT_OPTIONS_ENABLEDBARS             = "Активных панелей в любом состоянии"
    HEALBOT_OPTIONS_DISABLEDBARS            = "Неактивных панелей вне боя"
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Следить за снятием дебафов"
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Заклинание снимающее дебаффы"

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Игнорировать:"
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "По классам"
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Замедления"
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Короткого действия"
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Не вредоносные"
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "Когда кд на диспелл > 1.5 сек (ГКД)"
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "Когда источник известен как друг"

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Частота проверки дальности, аур и аггро"

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Скрыть окна группы"
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Включая игрока и цель"
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Отключить HealBot"

    HEALBOT_ASSIST                          = "Помощник"
    HEALBOT_FOCUS                           = "Фокус"
    HEALBOT_MENU                            = "Меню"
    HEALBOT_MAINTANK                        = "Главный Танк"
    HEALBOT_STOP                            = "Стоп"
    HEALBOT_TELL                            = "Сказать"

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Показывать кнопку у мини-карты"
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Показывать HoT'ы"
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Показывать цель рейда"
    HEALBOT_OPTIONS_HOTONBAR                = "На панели"
    HEALBOT_OPTIONS_HOTOFFBAR               = "Вне панели"
    HEALBOT_OPTIONS_HOTBARRIGHT             = "Справа"
    HEALBOT_OPTIONS_HOTBARLEFT              = "Слева"

    HEALBOT_ZONE_AB                         = GetMapNameByID(461) or "Низина Арати"
    HEALBOT_ZONE_AV                         = GetMapNameByID(401) or "Альтеракская долина"
    HEALBOT_ZONE_ES                         = GetMapNameByID(482) or "Око Бури"
    HEALBOT_ZONE_IC                         = GetMapNameByID(540) or "Остров Завоеваний"
    HEALBOT_ZONE_SA                         = GetMapNameByID(512) or "Берег Древних"

    HEALBOT_OPTION_AGGROTRACK               = "Следить за аггро"
    HEALBOT_OPTION_AGGROBAR                 = "Панель"
    HEALBOT_OPTION_AGGROTXT                 = ">> Текст <<"
    HEALBOT_OPTION_AGGROIND                 = "Индикатор"
    HEALBOT_OPTION_BARUPDFREQ               = "Частота обновления"
    HEALBOT_OPTION_USEFLUIDBARS             = "Использовать плавные полосы"
    HEALBOT_OPTION_CPUPROFILE               = "Использовать CPU-профайлер (Инфо об использовании CPU)"
    HEALBOT_OPTIONS_RELOADUIMSG             = "Для того, чтобы настройки вступили в силу, необходима перезагрузка интерфейса. Готовы?"

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE                        = "PvE"
    HEALBOT_OPTIONS_ANCHOR                  = "Якорь окна"
    HEALBOT_OPTIONS_BARSANCHOR              = "Якорь полос"
    HEALBOT_OPTIONS_TOPLEFT                 = "Слева Сверху"
    HEALBOT_OPTIONS_BOTTOMLEFT              = "Слева Снизу"
    HEALBOT_OPTIONS_TOPRIGHT                = "Справа Сверху"
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Справа Снизу"
    HEALBOT_OPTIONS_TOP                     = "Сверху"
    HEALBOT_OPTIONS_BOTTOM                  = "Снизу"

    HEALBOT_PANEL_BLACKLIST                 = "Черный Список"

    HEALBOT_WORDS_REMOVEFROM                = "Снять с"
    HEALBOT_WORDS_ADDTO                     = "Наложить на"
    HEALBOT_WORDS_INCLUDE                   = "Включая"

    HEALBOT_OPTIONS_TTALPHA                 = "Прозрачность"
    HEALBOT_TOOLTIP_TARGETBAR               = "Панель цели"
    HEALBOT_OPTIONS_MYTARGET                = "Мои цели"

    HEALBOT_DISCONNECTED_TEXT               = "<ОФФ>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Показывать мои баффы"
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "Постоянно обновлять"
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Показать бафф до того, как он кончится"
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Короткие баффы"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Длинные баффы"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Cообщение"
    HEALBOT_WORDS_YOU                       = "вы"
    HEALBOT_NOTIFYOTHERMSG                  = "Применяется #s на #n"

    HEALBOT_OPTIONS_HOTPOSITION             = "Позиция иконки"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Текст иконки"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Стаки"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Длительность"
    HEALBOT_OPTIONS_ICONSCALE               = "Масштаб иконки"
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Масштаб текста иконки"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Размер полосы угрозы"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Текст в 2 строки"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Выравнивание текста"
    HEALBOT_VEHICLE                         = "Транспорт"
    HEALBOT_WORDS_ERROR                     = "Ошибка"
    HEALBOT_SPELL_NOT_FOUND                 = "Заклинание не найдено"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Скрыть подсказки в бою"
    HEALBOT_OPTIONS_ENABLELIBQH             = "Включить fastHealth"

    HEALBOT_OPTIONS_BUFFNAMED               = "введите имя игрока для наблюдения:\n\n"
    HEALBOT_WORD_ALWAYS                     = "Всегда"
    HEALBOT_WORD_SOLO                       = "Соло"
    HEALBOT_WORD_NEVER                      = "Никогда"
    HEALBOT_SHOW_CLASS_AS_ICON              = "как иконку"
    HEALBOT_SHOW_CLASS_AS_TEXT              = "как текст"
    HEALBOT_SHOW_ROLE                       = "показывать роль"

    HEALBOT_SHOW_INCHEALS                   = "Показывать входящее исцеление"

    HEALBOT_HELP = {
        [1] = "[HealBot] /hb h -- показать справку",
        [2] = "[HealBot] /hb o -- переключение настроек",
        [3] = "[HealBot] /hb t -- Вкл/Выкл HealBot",
        [4] = "[HealBot] /hb bt -- Вкл/Выкл отслеживание баффов",
        [5] = "[HealBot] /hb dt -- Вкл/Выкл отслеживание дебаффов",
        [6] = "[HealBot] /hb skin <skinName> -- сменить стиль",
        [7] = "[HealBot] /hb d -- сбросить настройки на стандартные",
        [8] = "[HealBot] /hb spt -- Self Pet toggle",
        [9] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
        [10] = "[HealBot] /hb hs -- показать дополнительные слэш команды",
    }

    HEALBOT_HELP2 = {
        [1] = "[HealBot] /hb rtb -- Вкл/Выкл ограничение панели цели до ЛКМ=УмныйКаст и ПКМ=добавить/удалить мою цель",
        [2] = "[HealBot] /hb aggro 2 <n> -- Установить уровень аггро 2 в процентах от угрозы <n>",
        [3] = "[HealBot] /hb aggro 3 <n> -- Установить уровень аггро 3 в процентах от угрозы <n>",
        [4] = "[HealBot] /hb tr <Role> -- Установить высшый приоритет дял роли при дополнительной сортировке по ролям. Возможные роли: 'TANK', 'HEALER', 'DPS'",
        [5] = "[HealBot] /hb use10 -- Автоматически использовать инженерный слот 10",
        [6] = "[HealBot] /hb pcs <n> -- Установить размер индикатора зарядов Энергии Света в <n>, по умолчанию 7 ",
        [7] = "[HealBot] /hb hrfm -- Сменить метод скрытия рейдовых фреймов Blizzard, отключить совсем или спрятать",
        [8] = "[HealBot] /hb ws -- Переключить отображение иконки Ослабевшей Души вместо Слово Силы: Щит с минусом",
        [9] = "[HealBot] /hb rld <n> -- Время в секундах, в течение которого имена игроков остаются зелеными после воскрешения",
        [10] = "[HealBot] /hb shhp <n> -- Показывать бафф Гимн Надежды только когда мана меньше <n>",
        [11] = "[HealBot] - Также смотрите Команды в основной вкладке настроек",
    }

    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Выделять активную полосу"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Выделять цель"
    HEALBOT_OPTIONS_TESTBARS                = "Тестовые полосы"
    HEALBOT_OPTION_NUMBARS                  = "Количество полос"
    HEALBOT_OPTION_NUMTANKS                 = "Количество танков"
    HEALBOT_OPTION_NUMMYTARGETS             = "Количество моих целей"
    HEALBOT_OPTION_NUMHEALERS               = "Количество целителей"
    HEALBOT_OPTION_NUMPETS                  = "Количество питомцев"
    HEALBOT_WORD_TEST                       = "Тест"
    HEALBOT_WORD_OFF                        = "Выкл"
    HEALBOT_WORD_ON                         = "Вкл"

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Защита"
    HEALBOT_OPTIONS_TAB_CHAT                = "Чат"
    HEALBOT_OPTIONS_TAB_HEADERS             = "Заголовки"
    HEALBOT_OPTIONS_TAB_BARS                = "Полосы"
    HEALBOT_OPTIONS_TAB_ICONS               = "Иконки"
    HEALBOT_OPTIONS_TAB_WARNING             = "Оповещене"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Стандартный стиль для"
    HEALBOT_OPTIONS_INCHEAL                 = "Входящее исцеление"
    HEALBOT_WORD_ARENA                      = "Арена"
    HEALBOT_WORD_BATTLEGROUND               = "Поле боя"
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Настройки текста"
    HEALBOT_WORD_PARTY                      = "Группа"
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Авто\nЦель"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Авто Аксессуар"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Количество групп в колонке"

    HEALBOT_OPTIONS_MAINSORT                = "Основная сортировка"
    HEALBOT_OPTIONS_SUBSORT                 = "Дополнительная сортировка"
    HEALBOT_OPTIONS_SUBSORTINC              = "Также сортировать:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Применить\nкогда"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Нажата"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Отпущена"

    HEALBOT_INFO_ADDONCPUUSAGE              = "= Использование CPU аддоном (в сек.) ="
    HEALBOT_INFO_ADDONCOMMUSAGE             = "= Использование траффика аддоном ="
    HEALBOT_WORD_HEALER                     = "Лекарь"
    HEALBOT_WORD_DAMAGER                    = "ДД"
    HEALBOT_WORD_TANK                       = "Танк"
    HEALBOT_WORD_LEADER                     = "Лидер"
    HEALBOT_WORD_VERSION                    = "Версия"
    HEALBOT_WORD_CLIENT                     = "Клиент"
    HEALBOT_WORD_ADDON                      = "Аддон"
    HEALBOT_INFO_CPUSECS                    = "CPU сек"
    HEALBOT_INFO_MEMORYMB                   = "Память MБ"
    HEALBOT_INFO_COMMS                      = "Траффик КБ"

    HEALBOT_WORD_STAR                       = "Звезда"
    HEALBOT_WORD_CIRCLE                     = "Круг"
    HEALBOT_WORD_DIAMOND                    = "Ромб"
    HEALBOT_WORD_TRIANGLE                   = "Треугольник"
    HEALBOT_WORD_MOON                       = "Луна"
    HEALBOT_WORD_SQUARE                     = "Квадрат"
    HEALBOT_WORD_CROSS                      = "Крест"
    HEALBOT_WORD_SKULL                      = "Череп"

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Принять стиль [HealBot]: "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " от "
    HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Поделиться с"

    HEALBOT_CHAT_ADDONID                    = "[HealBot]  "
    HEALBOT_CHAT_NEWVERSION1                = "Доступна новая версия"
    HEALBOT_CHAT_NEWVERSION2                = "на "..HEALBOT_ABOUT_URL
    HEALBOT_CHAT_SHARESKINERR1              = " Не найден расшаренный стиль"
    HEALBOT_CHAT_SHARESKINERR3              = " не найден для отправки"
    HEALBOT_CHAT_SHARESKINACPT              = "Расшаренный стиль от "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Стиль по умолчанию"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Пользовательские дебаффы сброшены"
    HEALBOT_CHAT_CHANGESKINERR1             = "Неизвестный стиль: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2             = "Известные стили:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Текущее заклинание скопировано на все наборы талантов"
    HEALBOT_CHAT_UNKNOWNCMD                 = "Неизвестная команда: /hb "
    HEALBOT_CHAT_ENABLED                    = "Вхожу в активное состояние"
    HEALBOT_CHAT_DISABLED                   = "Вхожу в отключенное состояние"
    HEALBOT_CHAT_SOFTRELOAD                 = "Запрошен перезапуск HealBot'а"
    HEALBOT_CHAT_HARDRELOAD                 = "Запрошена перезагрузка UI"
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "Заклинания сброшены"
    HEALBOT_CHAT_CONFIRMCURESRESET          = "Диспеллы сброшены"
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Бафы сброшены"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Не удалось получить все настройки стиля - Возможно отсутствует SharedMedia, скачайте на curse.com"
    HEALBOT_CHAT_MACROSOUNDON               = "Звук не отключен при использования авто-аксессуара"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Звук отключен при использования авто-аксессуара"
    HEALBOT_CHAT_MACROERRORON               = "Ошибки не отключены при использования авто-аксессуара"
    HEALBOT_CHAT_MACROERROROFF              = "Ошибки отключены при использования авто-аксессуара"
    HEALBOT_CHAT_ACCEPTSKINON               = "Общие стили - Показывать окно приема стиля когда кто-то делится с вами стилем"
    HEALBOT_CHAT_ACCEPTSKINOFF              = "Общие стили - Всегда игнорировать общие стили от всех"
    HEALBOT_CHAT_USE10ON                    = "Авто-Аксессуар - Use10 вкл - Вы должны выбрать существующий авто-аксессуар"
    HEALBOT_CHAT_USE10OFF                   = "Авто-Аксессуар - Use10 выкл"
    HEALBOT_CHAT_SKINREC                    = " получен стиль от "

    HEALBOT_OPTIONS_SELFCASTS               = "Только на себя"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Показывать иконку"
    HEALBOT_OPTIONS_ALLSPELLS               = "Все заклинания"
    HEALBOT_OPTIONS_DOUBLEROW               = "Двойной ряд"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Под панелью"
    HEALBOT_OPTIONS_OTHERSPELLS             = "Другие заклинания"
    HEALBOT_WORD_MACROS                     = "Макросы"
    HEALBOT_WORD_SELECT                     = "Выбрать"
    HEALBOT_OPTIONS_QUESTION                = "?"
    HEALBOT_WORD_CANCEL                     = "Отмена"
    HEALBOT_WORD_COMMANDS                   = "Команды"
    HEALBOT_OPTIONS_BARHEALTH3              = "как здоровье"
    HEALBOT_SORTBY_ROLE                     = "Роль"
    HEALBOT_WORD_DPS                        = "DPS"
    HEALBOT_CHAT_TOPROLEERR                 = " роль не действительна в данном контексте - используйте 'TANK', 'DPS' или 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE                 = "Самая приоритетная роль "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Игроки будут отображаться первыми в Доп.Сортировке"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Игроки будут отображаться как обычно в Доп.Сортировке"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Показывать Проверку готовности"
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Сначала вы"
    HEALBOT_WORD_FILTER                     = "Фильтр"
    HEALBOT_OPTION_AGGROPCTBAR              = "Двигать панель"
    HEALBOT_OPTION_AGGROPCTTXT              = "Показать текст"
    HEALBOT_OPTION_AGGROPCTTRACK            = "Следить за %"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Низкая угроза"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - Высокая угроза"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Танкование"
    HEALBOT_OPTIONS_AGGROALERT              = "Уровень сигнала на панели"
    HEALBOT_OPTIONS_AGGROINDALERT           = "Уровень сигнала на индикаторе"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Показать подробности о наблюдаемом HoT'е"
    HEALBOT_WORDS_MIN                       = "мин"
    HEALBOT_WORDS_MAX                       = "макс"
    HEALBOT_CHAT_SELFPETSON                 = "Свой Питомец включен"
    HEALBOT_CHAT_SELFPETSOFF                = "Свой Питомец выключен"
    HEALBOT_WORD_PRIORITY                   = "Приоритет"
    HEALBOT_VISIBLE_RANGE                   = "В пределах 100 ярдов"
    HEALBOT_SPELL_RANGE                     = "В пределах действия заклинания"
    HEALBOT_WORD_RESET                      = "Сброс"
    HEALBOT_HBMENU                          = "HBmenu"
    HEALBOT_ACTION_HBFOCUS                  = "Левый клик - установить\nфокус на цель"
    HEALBOT_WORD_CLEAR                      = "Очистить"
    HEALBOT_WORD_SET                        = "Установить"
    HEALBOT_WORD_HBFOCUS                    = "Фокус HealBot"
    HEALBOT_WORD_OUTSIDE                    = "Внешний мир"
    HEALBOT_WORD_ALLZONE                    = "Все зоны"
    HEALBOT_OPTIONS_TAB_ALERT               = "Тревога"
    HEALBOT_OPTIONS_TAB_SORT                = "Сортировка"
    HEALBOT_OPTIONS_TAB_HIDE                = "Скрыть"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Угроза"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Текст иконки"
    HEALBOT_OPTIONS_TAB_TEXT                = "Текст панели"
    HEALBOT_OPTIONS_AGGRO3COL               = "Цвет полосы\nугрозы"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Частота мерцания"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Прозрачность мерцания"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Показывать длительность от"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Оповещение об окончании на"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Сброс своих дебафов"
    HEALBOT_CMD_RESETSKINS                  = "Сброс стилей"
    HEALBOT_CMD_CLEARBLACKLIST              = "Очистить черный список"
    HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Вкл/Выкл приём шкурок от других"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Вкл/Выкл игнорирование транспорта"
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Игнорирую транспорт"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Больше не игнорирую транспорт"
    HEALBOT_CMD_COPYSPELLS                  = "Копировать данное заклинание во все наборы"
    HEALBOT_CMD_RESETSPELLS                 = "Сброс заклинаний"
    HEALBOT_CMD_RESETCURES                  = "Сброс диспеллов"
    HEALBOT_CMD_RESETBUFFS                  = "Сброс баффов"
    HEALBOT_CMD_RESETBARS                   = "Сброс позиций панелей"
    HEALBOT_CMD_SUPPRESSSOUND               = "Вкл/Выкл подавление звука при использовании авто-аксессуара"
    HEALBOT_CMD_SUPPRESSERRORS              = "Вкл/Выкл подавление ошибок при использовании авто-аксессуара"
    HEALBOT_OPTIONS_COMMANDS                = "Команды HealBot"
    HEALBOT_WORD_RUN                        = "Пуск"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Использовать колесико мыши"
    HEALBOT_OPTIONS_MOUSEUP                 = "Колесико вверх"
    HEALBOT_OPTIONS_MOUSEDOWN               = "Колесико вниз"
    HEALBOT_CMD_DELCUSTOMDEBUFF9            = "Удалить пользовательские дебаффы с приоритетом 9"
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Удалить пользовательские дебаффы с приоритетом 10"
    HEALBOT_CMD_DELCUSTOMDEBUFF11           = "Удалить пользовательские дебаффы с приоритетом 11"
    HEALBOT_CMD_DELCUSTOMDEBUFF12           = "Удалить пользовательские дебаффы с приоритетом 12"
    HEALBOT_ACCEPTSKINS                     = "Принимать Стили от других"
    HEALBOT_SUPPRESSSOUND                   = "Авто-Аксессуар: подавлять звуки"
    HEALBOT_SUPPRESSERROR                   = "Авто-Аксессуар: подавлять ошибки"
    HEALBOT_OPTIONS_CRASHPROT               = "Защита от сбоев"
    HEALBOT_CP_MACRO_LEN                    = "Имя макроса должно быть от 1 до 14 символов"
    HEALBOT_CP_MACRO_BASE                   = "Основное имя макроса"
    HEALBOT_CP_MACRO_SAVE                   = "Последнее сохранение в: "
    HEALBOT_CP_STARTTIME                    = "Врямя ожидания входа в систему"
    HEALBOT_WORD_RESERVED                   = "Зарезаервировано"
    HEALBOT_OPTIONS_COMBATPROT              = "Защита в бою"
    HEALBOT_COMBATPROT_PARTYNO              = "панелей зарезервировано для Группы"
    HEALBOT_COMBATPROT_RAIDNO               = "панелей зарезервировано для Рейда"

    HEALBOT_WORD_HEALTH                     = "Здоровье"
    HEALBOT_OPTIONS_DONT_SHOW               = "Не показывать"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "То же, что и здоровье (текущее здоровье)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "То же, что и здоровье (будущее здоровье)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "Будущее здоровье"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Цвет полосы здоровья"
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Цвет фона"
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Цвет входящего исцеления"
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Цель: всегда показывать"
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Фокус: всегда показывать"
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Питомцы: группировать по 5"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Использовать стандартную подсказку"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Показывать полосу энергии"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Показывать энергию света"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Показывать энергию чи"
    HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Обратить длительность"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "только в соло"
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Все Болезни"
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Все Магические"
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Все Проклятия"
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Все Яды"
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Источник"

    HEALBOT_BLIZZARD_MENU                   = "Меню Blizzard"
    HEALBOT_HB_MENU                         = "Меню Healbot"
    HEALBOT_FOLLOW                          = "Следовать"
    HEALBOT_TRADE                           = "Обмен"
    HEALBOT_PROMOTE_RA                      = "Назначить помощником"
    HEALBOT_DEMOTE_RA                       = "Разжаловать помощника"
    HEALBOT_TOGGLE_ENABLED                  = "Активировать/Деактикировать"
    HEALBOT_TOGGLE_MYTARGETS                = "Вкл/Выкл мои цели"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Вкл/Выкл личных танков"
    HEALBOT_RESET_BAR                       = "Сброс панели"
    HEALBOT_HIDE_BARS                       = "Скрыть полосы дальше 100 метров"
    HEALBOT_RANDOMMOUNT                     = "Случайный транспорт"
    HEALBOT_RANDOMGOUNDMOUNT                = "Случайный наземный транспорт"
    HEALBOT_RANDOMPET                       = "Случайный спутник"
    HEALBOT_ZONE_AQ40                       = "Ан'Кираж"
    HEALBOT_ZONE_VASHJIR1                   = "Лес Келп'тар"
    HEALBOT_ZONE_VASHJIR2                   = "Мерцающий простор"
    HEALBOT_ZONE_VASHJIR3                   = "Бездонные глубины"
    HEALBOT_ZONE_VASHJIR                    = "Вайш'ир"
    HEALBOT_RESLAG_INDICATOR                = "Оставлять имя зеленым после воскрешения"
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Оставлять имя зеленым после воскрешения должно быть от 1 до 30"
    HEALBOT_FRAMELOCK_BYPASS_OFF            = "Обход блокировки окон выключен"
    HEALBOT_FRAMELOCK_BYPASS_ON             = "Обход вбокировки окон (Ctl+Alt+Left) включен"
    HEALBOT_RESTRICTTARGETBAR_ON            = "Панель ограниченной цели включена"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Панель ограниченной цели выключена"
    HEALBOT_AGGRO2_ERROR_MSG                = "Для установки уровня аггро 2, процент угрозы дожен быть между 25 и 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "Для установки уровня аггро 3, процент угрозы дожен быть между 75 and 100"
    HEALBOT_AGGRO2_SET_MSG                  = "Уровень аггро 2 установлен на процент угрозы "
    HEALBOT_AGGRO3_SET_MSG                  = "Уровень аггро 3 установлен на процент угрозы "
    HEALBOT_WORD_THREAT                     = "Угроза"
    HEALBOT_AGGRO_ERROR_MSG                 = "Неправильный уровень аггро - используйте 2 или 3"

    HEALBOT_OPTIONS_QUERYTALENTS            = "Запрашивать данные о талантах"
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Индикатор малого запаса маны"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Не показывать"
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Игнорировать события аур при отдыхе"

    HEALBOT_WORD_ENABLE                     = "Включить"
    HEALBOT_WORD_DISABLE                    = "Выключить"

    HEALBOT_OPTIONS_MYCLASS                 = "Мой Класс"

    HEALBOT_OPTIONS_CONTENT_ABOUT           = "        Информация"
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Колесико мыши"
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Тест"
    HEALBOT_OPTIONS_CONTENT_USAGE           = "        Производительность"
    HEALBOT_OPTIONS_REFRESH                 = "Обновить"

    HEALBOT_CUSTOM_CATEGORY                 = "Категория"
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Свой"
    HEALBOT_CUSTOM_CAT_02                   = "А-Б"   -- ****************************************************
    HEALBOT_CUSTOM_CAT_03                   = "В-Г"   -- Custom Debuff Categories can be translated
    HEALBOT_CUSTOM_CAT_04                   = "Д-Е"   --
    HEALBOT_CUSTOM_CAT_05                   = "Ж-З"   -- If translating into a language with a completely different alphabet,
    HEALBOT_CUSTOM_CAT_06                   = "И-К"   -- the descriptions of HEALBOT_CUSTOM_CAT_02 - HEALBOT_CUSTOM_CAT_14 can be changed.
    HEALBOT_CUSTOM_CAT_07                   = "Л-М"   -- Just ensure all 13 variables are used
    HEALBOT_CUSTOM_CAT_08                   = "Н-О"   --
    HEALBOT_CUSTOM_CAT_09                   = "П-Р"   -- Setting debuffs in HEALBOT_CUSTOM_DEBUFF_CATS,
    HEALBOT_CUSTOM_CAT_10                   = "С-Т"   -- The only rule is the category number needs to match the last digits of the variable names, for example:
    HEALBOT_CUSTOM_CAT_11                   = "У-Ф"   -- If HEALBOT_DEBUFF_AGONIZING_FLAMES starts with an T in a different region
    HEALBOT_CUSTOM_CAT_12                   = "Х-Ц"   -- the category would be 11, simply change the 2 to 11.
    HEALBOT_CUSTOM_CAT_13                   = "Ч-Щ"   --
    HEALBOT_CUSTOM_CAT_14                   = "Э-Я"   -- ****************************************************

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Все"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Враг"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Друг"

    HEALBOT_CUSTOM_DEBUFF_CATS = {
             -- Defaults
            [HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT]  = 1,
            [HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE]     = 1,
            [HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT]     = 1,
            [HEALBOT_CUSTOM_CAT_CUSTOM_MISC]       = 1,

            --Class Profession Debuffs
            [HEALBOT_DARK_BARGAIN]             = 10, --Warlock
            [HEALBOT_SHROUD_OF_PURGATORY]      = 9, --Death Knight
            [HEALBOT_DEBUFF_ROCKET_FUEL_LEAK]  = 11, --Engineering

            --Scenario, Proving Grounds
            [HEALBOT_DEBUFF_CHOMP]             = 13, -- Healer Challenge 
            [HEALBOT_DEBUFF_LAVA_BURNS]        = 3, -- Healer Challenge 

            --[[World Bosses
            Sha of Anger]]
            [HEALBOT_DEBUFF_SEETHE]             = 2, -- Sha of Anger      
            [HEALBOT_DEBUFF_AGGRESSIVE_BEHAVIOR] = 2, -- Sha of Anger      
            --HEALBOT_DEBUFF_BITTER_THOUGHTS]      = 2, -- Sha of Anger 
            --Oondasta
            [HEALBOT_DEBUFF_CRUSH]             = 10, -- Oondasta    
            --Nalak, the Storm Lord
            [HEALBOT_DEBUFF_LIGHTNING_TETHER]  = 9, -- Nalak, the Storm Lord      
            [HEALBOT_DEBUFF_STORMCLOUD]        = 3, -- Nalak, the Storm Lord 
            --Celestials
            [HEALBOT_DEBUFF_SPECTRAL_SWIPE]    = 9, --Xuen   
            --[HEALBOT_DEBUFF_JADEFLAME_BUFFET]  = 6, --Chi Ji       
            --Ordos
            [HEALBOT_DEBUFF_BURNING_SOUL]      = 9, --Ordos            
            [HEALBOT_DEBUFF_POOL_OF_FIRE]      = 8, --Ordos       
            [HEALBOT_DEBUFF_ANCIENT_FLAME]     = 4, --Ordos        

            --[[Updated 5.2 Mists of Pandaria Expansion by Ariá - Silvermoon EU
            = GetMapNameByID(896) or "--Mogu'shan Vaults"]]
            [HEALBOT_DEBUFF_SUNDERING_BITE]    = 9, -- Trash       
            [HEALBOT_DEBUFF_FULLY_PETRIFIED]   = 9, -- Trash
            [HEALBOT_DEBUFF_FOCUSED_ASSAULT]   = 10, -- Trash        
            [HEALBOT_DEBUFF_GROUND_SLAM]       = 11, -- Trash         
            [HEALBOT_DEBUFF_IMPALE]            = 9, -- Trash         
            [HEALBOT_DEBUFF_PYROBLAST]         = 8, -- Trash              
            [HEALBOT_DEBUFF_TROLL_RUSH]        = 10, -- Trash
            [HEALBOT_DEBUFF_SUNDER_ARMOR]      = 9, -- Trash           
            [HEALBOT_DEBUFF_AMETHYST_POOL]     = 1, -- The Stone Guard         
            [HEALBOT_DEBUFF_REND_FLESH]        = 9, -- The Stone Guard     
            [HEALBOT_DEBUFF_LIVING_AMETHYST]   = 5, -- The Stone Guard Heroic     
            [HEALBOT_DEBUFF_LIVING_COBALT]     = 5, -- The Stone Guard Heroic     
            [HEALBOT_DEBUFF_LIVING_JADE]       = 5, -- The Stone Guard Heroic     
            [HEALBOT_DEBUFF_LIVING_JASPER]     = 5, -- The Stone Guard Heroic
            --[HEALBOT_DEBUFF_JASPER_CHAINS]     = 6, -- The Stone Guard            
            [HEALBOT_DEBUFF_LIGHTNING_LASH]    = 6, -- Feng the Accursed  
            [HEALBOT_DEBUFF_LIGHTNING_CHARGE]  = 9, -- Feng the Accursed   
            [HEALBOT_DEBUFF_FLAMING_SPEAR]     = 9, -- Feng the Accursed    
            [HEALBOT_DEBUFF_WILDFIRE_SPARK]    = 6, -- Feng the Accursed   
            [HEALBOT_DEBUFF_ARCANE_SHOCK]      = 13, -- Feng the Accursed   
            [HEALBOT_DEBUFF_ARCANE_RESONANCE]  = 9, -- Feng the Accursed    
            [HEALBOT_DEBUFF_SHADOWBURN]        = 8, -- Feng the Accursed Heroic      
            --[HEALBOT_DEBUFF_EPICENTRE          = 4, -- Feng the Accursed         
            [HEALBOT_DEBUFF_VOODOO_DOLL]       = 6, -- Gara'jal the Spiritbinder 
            --[[[HEALBOT_DEBUFF_CROSSED_OVER]      = 3, -- Gara'jal the Spiritbinder 
            [HEALBOT_DEBUFF_SOUL_SEVER]        = 11, -- Gara'jal the Spiritbinder]]
            [HEALBOT_DEBUFF_PINNED_DOWN]       = 9, -- The Spirit Kings
            [HEALBOT_DEBUFF_UNDYING_SHADOWS]   = 2, -- The Spirit Kings 
            --[[[HEALBOT_DEBUFF_PILLAGED]          = 9, -- The Spirit Kings
            [HEALBOT_DEBUFF_ROBBED_BLIND]      = 10, -- The Spirit Kings Heroic]]
            --[HEALBOT_DEBUFF_OVERCHARGED]       = 9, -- Elegon  
            [HEALBOT_DEBUFF_FOCUSED_ASSAULT]   = 10, -- Will of the Emporer
            [HEALBOT_DEBUFF_ENERGIZING_SMASH]  = 14, -- Will of the Emporer 
            [HEALBOT_DEBUFF_IMPEDING_THRUST]   = 8, -- Will of the Emporer   
            [HEALBOT_DEBUFF_FOCUSED_DEFENSE]   = 11, -- Will of the Emporer 
            [HEALBOT_DEBUFF_DEVASTATING_ARC]   = 9, -- Will of the Emporer 
            [HEALBOT_DEBUFF_STOMP]             = 10, -- Will of the Emporer      
            --[[[HEALBOT_DEBUFF_FOCUSED_ENERGY]    = 4, -- Will of the Emporer Heroic
            [HEALBOT_DEBUFF_TITAN_GAS]         = 11, -- Will of the Emporer]]
            
            --= GetMapNameByID(897) or "--Heart of Fear"
            [HEALBOT_DEBUFF_ARTERIAL_BLEEDING] = 2, -- Trash         
            [HEALBOT_DEBUFF_DISMANTLED_ARMOR] = 4, -- Trash          
            [HEALBOT_DEBUFF_STUNNING_STRIKE]  = 8, -- Trash         
            [HEALBOT_DEBUFF_GALE_FORCE_WINDS] = 11, -- Trash 
            [HEALBOT_DEBUFF_MORTAL_REND]      = 3, -- Trash        
            [HEALBOT_DEBUFF_GRIEVOUS_WHIRL]   = 11, -- Trash        
            [HEALBOT_DEBUFF_BURNING_STING]    = 9, -- Trash         
            [HEALBOT_DEBUFF_SLAM]             = 7, -- Trash 
            [HEALBOT_DEBUFF_ZEALOUS_PARASITE] = 8, -- Trash
            [HEALBOT_DEBUFF_EXHALE]           = 3, -- Imperial Vizier Zor'lok       
            [HEALBOT_DEBUFF_CONVERT]          = 8, -- Imperial Vizier Zor'lok          
            --[HEALBOT_DEBUFF_PHEROMONES_OF_ZEAL] = 9, -- Imperial Vizier Zor'lok  
            [HEALBOT_DEBUFF_OVERWHELMING_ASSAULT] = 10, -- Blade Lord Ta'yak      
            [HEALBOT_DEBUFF_WIND_STEP]        = 13, -- Blade Lord Ta'yak             
            [HEALBOT_DEBUFF_UNSEEN_STRIKE]    = 8, -- Blade Lord Ta'yak  
            [HEALBOT_DEBUFF_PHEROMONES]       = 11, -- Garalon            
            --[HEALBOT_DEBUFF_PUNGENCY]          = 9, -- Garalon
            [HEALBOT_DEBUFF_AMBER_PRISON]     = 14, -- Wind Lord Mel'jarak        
            [HEALBOT_DEBUFF_CORROSIVE_RESIN]  = 4, -- Wind Lord Mel'jarak       
            [HEALBOT_DEBUFF_KORTHIK_STRIKE]   = 11, -- Wind Lord Mel'jarak 
            [HEALBOT_DEBUFF_RESHAPE_LIFE]     = 3, -- Amber-Shaper Un'sok      
            [HEALBOT_DEBUFF_PARASITIC_GROWTH] = 9, -- Amber-Shaper Un'sok        
            [HEALBOT_DEBUFF_FLING]            = 2, -- Amber-Shaper Un'sok      
            [HEALBOT_DEBUFF_AMBER_GLOBULE]    = 14, -- Amber-Shaper Un'sok Heroic 
            [HEALBOT_DEBUFF_EYES_OF_THE_EMPRESS] = 3, -- Grand Empress Shek'zeer 
            [HEALBOT_DEBUFF_CRY_OF_TERROR]    = 6, -- Grand Empress Shek'zeer       
            [HEALBOT_DEBUFF_STICKY_RESIN]     = 7, -- Grand Empress Shek'zeer           
            [HEALBOT_DEBUFF_POISON_BOMB]      = 14, -- Grand Empress Shek'zeer            
            [HEALBOT_DEBUFF_POISON_DRENCHED_ARMOR] = 9, -- Grand Empress Shek'zeer    
            [HEALBOT_DEBUFF_VISIONS_OF_DEMISE] = 3, -- Grand Empress Shek'zeer  
            [HEALBOT_DEBUFF_HEART_OF_FEAR]    = 10, -- Grand Empress Shek'zeer Heroic                
            
            --= GetMapNameByID(886) or "--Terrace of Endless Spring"
            [HEALBOT_DEBUFF_TOUCH_OF_SHA]      = 9, -- Protectors of the Endless      
            [HEALBOT_DEBUFF_DEFILED_GROUND]    = 8, -- Protectors of the Endless       
            --[HEALBOT_DEBUFF_OVERWHELMING_CORRUPTION] = 9, -- Protectors of the Endless 
            [HEALBOT_DEBUFF_SHADOW_BREATH]     = 10, -- Tsulong     
            --[HEALBOT_DEBUFF_DREAD_SHADOWS]     = 3, -- Tsulong       
            [HEALBOT_DEBUFF_SPRAY]             = 2, -- Lei Shi       
            [HEALBOT_DEBUFF_SCARY_FOG]         = 5, -- Lei Shi Heroic     
            [HEALBOT_DEBUFF_PENETRATING_BOLT]  = 9, -- Sha of Fear              
            [HEALBOT_DEBUFF_NAKED_AND_AFRAID]  = 8, -- Sha of Fear Heroic 
            [HEALBOT_DEBUFF_HUDDLE_IN_TERROR]  = 8, -- Sha of Fear Heroic 
            [HEALBOT_DEBUFF_CHAMPION_OF_THE_LIGHT] = 3, -- Sha of Fear Heroic 
            [HEALBOT_DEBUFF_OMINOUS_CACKLE]    = 5, -- Sha of Fear 
            --[HEALBOT_DEBUFF_DREAD_SPRAY]       = 3, -- Sha of Fear 
            
            --[[Updated 5.3 Mists of Pandaria Expansion by Ariá - Silvermoon EU      
            = GetMapNameByID(930) or "--Throne of Thunder"]]
            [HEALBOT_DEBUFF_WOUNDING_STRIKE]   = 9, -- Trash
            [HEALBOT_DEBUFF_STORM_ENERGY]      = 14, -- Trash
            [HEALBOT_DEBUFF_ANCIENT_VENOM]     = 4, -- Trash 
            [HEALBOT_DEBUFF_TORMENT]           = 10, -- Trash
            [HEALBOT_DEBUFF_CRUSH_ARMOR]       = 10, -- Trash
            [HEALBOT_DEBUFF_STORMCLOUD]        = 3, -- Trash
            [HEALBOT_DEBUFF_SLASHING_TALONS]   = 9, -- Trash
            [HEALBOT_DEBUFF_SHALE_SHARDS]      = 8, -- Trash
            [HEALBOT_DEBUFF_CHOKING_MISTS]     = 11, -- Trash
            [HEALBOT_DEBUFF_CORROSIVE_BREATH]  = 4, -- Trash
            [HEALBOT_DEBUFF_COCOON]            = 6, -- Trash   
            [HEALBOT_DEBUFF_CHOKING_GAS]       = 11, -- Trash
            [HEALBOT_DEBUFF_GNAWED_UPON]       = 3, -- Trash
            [HEALBOT_DEBUFF_RETRIEVE_SPEAR]    = 3, -- Trash
            [HEALBOT_DEBUFF_STATIC_WOUND]      = 10, -- Jin'rokh the Breaker
            [HEALBOT_DEBUFF_THUNDERING_THROW]  = 3, -- Jin'rokh the Breaker
            [HEALBOT_DEBUFF_FOCUSED_LIGHTNING] = 10, -- Jin'rokh the Breaker
            --[HEALBOT_DEBUFF_ELECTRIFIED_WATERS] = 14, -- Jin'rokh the Breaker 
            [HEALBOT_DEBUFF_TRIPLE_PUNCTURE]   = 10, -- Horridon
            [HEALBOT_DEBUFF_RENDING_CHARGE]    = 9, -- Horridon
            [HEALBOT_DEBUFF_FROZEN_BOLT]       = 7, -- Horridon
            [HEALBOT_DEBUFF_FRIGID_ASSAULT]    = 7, -- Council of Elders 
            [HEALBOT_DEBUFF_BITING_COLD]       = 10, -- Council of Elders    
            [HEALBOT_DEBUFF_FROSTBITE]         = 8, -- Council of Elders  
            [HEALBOT_DEBUFF_BODY_HEAT]         = 5, -- Council of Elders Heroic
            [HEALBOT_DEBUFF_MARKED_SOUL]       = 7, -- Council of Elders
            [HEALBOT_DEBUFF_SOUL_FRAGMENT]     = 11, -- Council of Elders Heroic
            --[HEALBOT_DEBUFF_SHADOWED_SOUL]     = 11, -- Council of Elders Heroic
            [HEALBOT_DEBUFF_ENTRAPPED]         = 3, -- Council of Elders Magic
            [HEALBOT_DEBUFF_QUAKE_STOMP]       = 3, -- Tortos
            [HEALBOT_DEBUFF_CRYSTAL_SHELL]     = 6, -- Tortos
            [HEALBOT_DEBUFF_CRYSTAL_SHELL_FULL_CAPACITY] = 6, -- Tortos 
            [HEALBOT_DEBUFF_IGNITE_FLESH]      = 10, -- Megaera  
            [HEALBOT_DEBUFF_ARCTIC_FREEZE]     = 2, -- Megaera  
            [HEALBOT_DEBUFF_ROT_ARMOR]         = 3, -- Megaera 
            [HEALBOT_DEBUFF_TORRENT_OF_ICE]    = 7, -- Megaera
            --[HEALBOT_DEBUFF_ICY_GROUND]        = 6, -- Megaera        
            [HEALBOT_DEBUFF_TALON_RAKE]        = 8, -- Ji-Kun
            [HEALBOT_DEBUFF_INFECTED_TALONS]   = 5, -- ji-Kun
            [HEALBOT_DEBUFF_FEED_POOL]         = 6, -- ji-Kun
            [HEALBOT_DEBUFF_SLIMED]            = 3, -- ji-Kun      
            [HEALBOT_DEBUFF_SERIOUS_WOUND]     = 10, -- Durumu the Forgotten
            [HEALBOT_DEBUFF_ARTERIAL_CUT]      = 9, -- Durumu the Forgotten
            [HEALBOT_DEBUFF_LINGERING_GAZE]    = 4, -- Durumu the Forgotten
            [HEALBOT_DEBUFF_LIFE_DRAIN]        = 9, -- Durumu the Forgotten
            --[[[HEALBOT_DEBUFF_BLUE_RAY_TRACKING] = 2, -- Durumu the Forgotten       
            [HEALBOT_DEBUFF_BLUE_RAYS]         = 2, -- Durumu the Forgotten       
            [HEALBOT_DEBUFF_INFRARED_TRACKING] = 6, -- Durumu the Forgotten       
            [HEALBOT_DEBUFF_INFRARED_LIGHT]    = 6, -- Durumu the Forgotten       
            [HEALBOT_DEBUFF_BRIGHT_LIGHT]      = 2,]] -- Durumu the Forgotten 
            [HEALBOT_DEBUFF_MALFORMED_BLOOD]   = 6, -- Primordius
            [HEALBOT_DEBUFF_VOLATILE_PATHOGEN] = 3, -- Primordius
            [HEALBOT_DEBUFF_CRIMSON_WAKE]      = 2, -- Dark Animus
            [HEALBOT_DEBUFF_EXPLOSIVE_SLAM]    = 3, -- Dark Animus
            [HEALBOT_DEBUFF_ANIMA_RING]        = 6, -- Dark Animus
            [HEALBOT_DEBUFF_TOUCH_OF_ANIMUS]   = 6, -- Dark Animus
            --[HEALBOT_DEBUFF_ANIMA_FONT]        = 2, -- Dark Animus
            [HEALBOT_DEBUFF_SCORCHED]          = 8, -- Iron Qon
            [HEALBOT_DEBUFF_FREEZE]            = 12, -- Iron Qon
            --[HEALBOT_DEBUFF_STORM_CLOUD]       = 3, -- Iron Qon
            --[HEALBOT_DEBUFF_ARCING_LIGHTNING]  = 2, -- Iron Qon   
            [HEALBOT_DEBUFF_FAN_OF_FLAMES]     = 9, -- Twin Consorts 
            [HEALBOT_DEBUFF_BEAST_OF_NIGHTMARES] = 13, -- Twin Consorts
            [HEALBOT_DEBUFF_CORRUPTED_HEALING] = 6, -- Twin Consorts 
            --[HEALBOT_DEBUFF_FLAMES_OF_PASSION] = 4, -- Twin Consorts
            [HEALBOT_DEBUFF_DECAPITATE]        = 8, -- Lei Shen 
            [HEALBOT_DEBUFF_STATIC_SHOCK]      = 10, -- Lei Shen
            [HEALBOT_DEBUFF_OVERCHARGED]       = 9, -- Lei Shen
            [HEALBOT_DEBUFF_HELM_OF_COMMAND]   = 13, -- Lei Shen Heroic
            [HEALBOT_DEBUFF_ELECTRICAL_SHOCK]  = 14, -- Lei Shen 
            --[[[HEALBOT_DEBUFF_CRASHING_THUNDER]  = 3, -- Lei Shen
            [HEALBOT_DEBUFF_DISCHARGED_ENERGY] = 3, -- Lei Shen        
            [HEALBOT_DEBUFF_WINDBURN]          = 13, -- Lei Shen]]
            [HEALBOT_DEBUFF_UNSTABLE_VITA]     = 8, -- Ra-Den
            [HEALBOT_DEBUFF_VITA_SENSITIVITY]  = 3, -- Ra-Den
            
            --[[Updated 5.4 Mists of Pandaria Expansion by Ariá - Silvermoon EU                 
            = GetMapNameByID(953) or "--Siege of Orgrimmar"]]                       
            [HEALBOT_DEBUFF_LOCKED_ON]         = 10, -- Trash        
            [HEALBOT_DEBUFF_OBLITERATING_STRIKE] = 11,-- Trash
            [HEALBOT_DEBUFF_PIERCE]            = 9, --Trash 
            [HEALBOT_DEBUFF_BLOOD_OF_YSHAARJ]  = 6, -- Trash
            [HEALBOT_DEBUFF_REAPING_WHIRLWIND] = 9, -- Trash 
            [HEALBOT_DEBUFF_FIRE_PIT]          = 6, -- Trash
            [HEALBOT_DEBUFF_OVERCONFIDENCE]    = 10, -- Trash            
            [HEALBOT_DEBUFF_JEALOUSY]          = 9, -- Trash            
            [HEALBOT_DEBUFF_GROWING_OVERCONFIDENCE] = 9, -- Trash
            [HEALBOT_DEBUFF_BRIBE]             = 9, -- Trash 
            [HEALBOT_DEBUFF_INTIMIDATING_SHOUT] = 11, -- Trash
            [HEALBOT_DEBUFF_FULL_OF_MEAT]      = 4, -- Trash
            [HEALBOT_DEBUFF_SCORCHED_EARTH]    = 8, -- Trash
            [HEALBOT_DEBUFF_DREAD_HOWL]        = 5, -- Trash  
            [HEALBOT_DEBUFF_SLOW_AND_STEADY]   = 7, -- Trash 
            [HEALBOT_DEBUFF_RESONATING_AMBER]  = 9, -- Trash 
            [HEALBOT_DEBUFF_CORROSIVE_BLAST]   = 6, -- Immerseus 
            [HEALBOT_DEBUFF_SHA_POOL]          = 8, -- Immerseus
            --[HEALBOT_DEBUFF_SHA_SPLASH]        = 11, -- Immerseus  
            [HEALBOT_DEBUFF_NOXIOUS_POISON]    = 9, -- The Fallen Protectors       
            [HEALBOT_DEBUFF_DEFILED_GROUND]    = 8, -- The Fallen Protectors                  
            [HEALBOT_DEBUFF_VENGEFUL_STRIKES]  = 7, -- The Fallen Protectors     
            [HEALBOT_DEBUFF_CORRUPTION_KICK]   = 8, -- The Fallen Protectors    
            [HEALBOT_DEBUFF_GARROTE]           = 3, -- The Fallen Protectors     
            [HEALBOT_DEBUFF_GOUGE]             = 9, -- The Fallen Protectors    
            [HEALBOT_DEBUFF_MARK_OF_ANGUISH]   = 5, -- The Fallen Protectors         
            [HEALBOT_DEBUFF_SHA_SEAR]          = 8, -- The Fallen Protectors
            [HEALBOT_DEBUFF_FIXATE]            = 10, -- The Fallen Protectors
            --[[[HEALBOT_DEBUFF_DEBILITATION]      = 3, -- The Fallen Protectors
            HEALBOT_DEBUFF_SHADOWED_WEAKNESS]  = 11, -- The Fallen Protectors
            [HEALBOT_DEBUFF_CORRUPTED_BREW]    = 3, -- The Fallen Protectors]]               
            [HEALBOT_DEBUFF_SELF_DOUBT]        = 10, -- Norushen
            [HEALBOT_DEBUFF_BOTTOMLESS_PIT]    = 2, -- Norushen
            [HEALBOT_DEBUFF_DISHEARTENING_LAUGH] = 11, -- Norushen  
            --[[[HEALBOT_DEBUFF_DESPAIR]             = 3, -- Norushen 
            [HEALBOT_DEBUFF_TEST_OF_SERENITY]  = 11, -- Norushen       
            [HEALBOT_DEBUFF_TEST_OF_RELIANCE]  = 11, -- Norushen       
            [HEALBOT_DEBUFF_TEST_OF_CONDIDENCE] = 11,]] -- Norushen  
            [HEALBOT_DEBUFF_WOUNDED_PRIDE]     = 11, -- Sha of Pride
            [HEALBOT_DEBUFF_CORRUPTED_PRISON]  = 8, -- Sha of Pride  
            [HEALBOT_DEBUFF_BANISHMENT]        = 6, -- Sha of Pride Heroic            
            [HEALBOT_DEBUFF_REACHING_ATTACK]   = 2, -- Sha of Pride 
            [HEALBOT_DEBUFF_AURA_OF_PRIDE]     = 2, -- Sha of Pride 
            [HEALBOT_DEBUFF_MARK_OF_ARROGANCE] = 5, -- Sha of Pride Magic   
            [HEALBOT_DEBUFF_FRACTURE]          = 10, -- Galakras
            [HEALBOT_DEBUFF_POISON_CLOUD]      = 14, -- Galakras
            --[[[HEALBOT_DEBUFF_FLAME_ARROWS]      = 4, -- Galakras
            [HEALBOT_DEBUFF_FLAMES_OF_GALAKROND] = 4, -- Galakras]]
            [HEALBOT_DEBUFF_LASER_BURN]        = 7, -- Iron Juggernaut
            [HEALBOT_DEBUFF_IGNITE_ARMOUR]     = 9, -- Iron Juggernaut
            [HEALBOT_DEBUFF_EXPLOSIVE_TAR]     = 3, -- Iron Juggernaut
            [HEALBOT_DEBUFF_CUTTER_LASER_TARGET] = 12, -- Iron Juggernaut
            [HEALBOT_DEBUFF_REND]              = 6, -- Kor'kron Dark Shaman
            [HEALBOT_DEBUFF_FROSTSTORM_STRIKE] = 11, -- Kor'kron Dark Shaman
            [HEALBOT_DEBUFF_TOXIC_MIST]        = 10, -- Kor'kron Dark Shaman
            [HEALBOT_DEBUFF_IRON_PRISON]       = 5, -- Kor'kron Dark Shaman Heroic
            --[HEALBOT_DEBUFF_FOUL_GEYSER]       = 4, -- Kor'kron Dark Shaman
            --[HEALBOT_DEBUFF_TOXICITY]          = 11, -- Kor'kron Dark Shaman
            [HEALBOT_DEBUFF_SUNDERING_BLOW]    = 9, -- General Nazgrim
            [HEALBOT_DEBUFF_BONECRACKER]       = 6, -- General Nazgrim
            [HEALBOT_DEBUFF_ASSASSINS_MARK]    = 5, -- General Nazgrim
            [HEALBOT_DEBUFF_HUNTERS_MARK]      = 7, -- General Nazgrim Heroic
            [HEALBOT_DEBUFF_FATAL_STRIKE]      = 11, -- Malkorok                         
            [HEALBOT_WEEK_ANCIENT_BARRIER]     = 10, -- Malkorok       
            [HEALBOT_ANCIENT_BARRIER]          = 4, -- Malkorok 
            [HEALBOT_STRONG_ANCIENT_BARRIER]   = 10, -- Malkorok   
            --[[HEALBOT_DEBUFF_ANCIENT_MIASMA]    = 2, -- Malkorok               
            [HEALBOT_DEBUFF_LANGUISH]          = 7, -- Malkorok Heroic]] 
            [HEALBOT_DEBUFF_SET_TO_BLOW]       = 3, -- Spoils of Pandaria
            [HEALBOT_DEBUFF_CARNIVOROUS_BITE]  = 11, -- Spoils of Pandaria
            [HEALBOT_DEBUFF_ENCAPSULATED_PHEROMONES] = 6, -- Spoils of Pandaria
            [HEALBOT_DEBUFF_KEG_TOSS]          = 2, -- Spoils of Pandaria
            [HEALBOT_DEBUFF_GUSTING_BOMB]      = 11, -- Spoils of Pandaria 
            --[HEALBOT_DEBUFF_UNSTABLE_DEFENSE_SYSTEMS] = 12, -- Spoils of Pandaria 
            [HEALBOT_DEBUFF_PANIC]             = 9, -- Thok the Bloodthirsty      
            [HEALBOT_DEBUFF_TAIL_LASH]         = 11, -- Thok the Bloodthirsty     
            [HEALBOT_DEBUFF_FIXATE]            = 10, -- Thok the Bloodthirsty     
            [HEALBOT_DEBUFF_ACID_BREATH]       = 6, -- Thok the Bloodthirsty     
            [HEALBOT_DEBUFF_FREEZING_BREATH]   = 7, -- Thok the Bloodthirsty         
            [HEALBOT_DEBUFF_SCORCHING_BREATH]  = 8, -- Thok the Bloodthirsty    
            --[[[HEALBOT_DEBUFF_BURNING_BLOOD]     = 2, -- Thok the Bloodthirsty 
            [HEALBOT_DEBUFF_ICY_BLOOD]         = 6, -- Thok the Bloodthirsty
            [HEALBOT_DEBUFF_BLOODIED]          = 2, -- Thok the Bloodthirsty]]     
            [HEALBOT_DEBUFF_ELECTROSTATIC_CHARGE] = 14, --Siegecrafter Blackfuse
            [HEALBOT_DEBUFF_OVERLOAD]          = 9, -- Siegecrafter Blackfuse           
            [HEALBOT_DEBUFF_SUPERHEATED]       = 4, -- Siegecrafter Blackfuse          
            --HEALBOT_DEBUFF_MAGNETIC_CRUSH]    = 8, -- Siegecrafter Blackfuse 
            [HEALBOT_DEBUFF_MUTATE]            = 7, -- Paragons of the Klaxxi
            [HEALBOT_DEBUFF_EXPOSED_VEINS]     = 8, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_GOUGE]             = 9, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_CAUSTIC_BLOOD]     = 4, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_TENDERZING_STRIKES] = 9, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_MEZMERIZE]         = 8, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_SHIELD_BASH]       = 11, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_CAUSTIC_AMBER]     = 5, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_HEWN]              = 7, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_GENETIC_ALTERATION] = 3, -- Paragons of the Klaxxi
            [HEALBOT_DEBUFF_INJECTION]         = 6, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_AIM]               = 9, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_WHIRLING]          = 3, -- Paragons of the Klaxxi
            [HEALBOT_DEBUFF_FIERY_EDGE]        = 8, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_FEED]              = 6, -- Paragons of the Klaxxi 
            [HEALBOT_DEBUFF_NOXIOUS_VAPORS]    = 14, -- Paragons of the Klaxxi
            [HEALBOT_DEBUFF_CANNED_HEAT]       = 6, -- Paragons of the Klaxxi Heroic      
            [HEALBOT_DEBUFF_EERIE_FOG]         = 5, -- Paragons of the Klaxxi Heroic
            --[[[HEALBOT_DEBUFF_CHILLED_TO_THE_BONE] = 3, -- Paragons of the Klaxxi Heroic 
            [HEALBOT_DEBUFF_HUNGER]            = 5, -- Paragons of the Klaxxi]]
            [HEALBOT_DEBUFF_HAMSTRING]         = 9, -- Garrosh Hellscream   
            [HEALBOT_DEBUFF_EMBODIED_DOUBT]    = 3, -- Garrosh Hellscream
            [HEALBOT_DEBUFF_TOUCH_OF_YSHAARJ]  = 6, -- Garrosh Hellscream 
            [HEALBOT_DEBUFF_EMPOWERED_TOUCH_OF_YSHAARJ] = 11, -- Garrosh Hellscream
            [HEALBOT_DEBUFF_GRIPPING_DESPAIR]  = 8, -- Garrosh Hellscream
            [HEALBOT_DEBUFF_EMPOWERED_GRIPPING_DESPAIR] = 11, -- Garrosh Hellscream
            [HEALBOT_DEBUFF_MALICE]            = 5, -- Garrosh Hellscream Heroic
            [HEALBOT_DEBUFF_MALICIOUS_BLAST]   = 3, -- Garrosh Hellscream Heroic 
            [HEALBOT_DEBUFF_FIXATE]            = 10, -- Garrosh Hellscream Heroic 
            [HEALBOT_DEBUFF_NAPALM]            = 8, -- Garrosh Hellscream Heroic
            --[HEALBOT_DEBUFF_EXPLOSIVE_DESPAIR] = 3, -- Garrosh Hellscream
            [HEALBOT_DEBUFF_FAITH]             = 3, -- Garrosh Hellscream Buff
            [HEALBOT_DEBUFF_HOPE]              = 8, -- Garrosh Hellscream Buff 
            [HEALBOT_DEBUFF_COURAGE]           = 12, -- Garrosh Hellscream Buff 
            --[HEALBOT_DEBUFF_DESECRATED]        = 3, -- Garrosh Hellscream]] 
    }

    HEALBOT_ABOUT_DESC1                     = "Добавляет окно со стилизуемыми панелями для исцеления, рассеивания, наложения баффов и отслеживания аггро."
    HEALBOT_ABOUT_WEBSITE                   = "Сайт:"
    HEALBOT_ABOUT_AUTHORH                   = "Автор:"
    HEALBOT_ABOUT_AUTHORD                   = "Strife"
    HEALBOT_ABOUT_CATH                      = "Категория:"
    HEALBOT_ABOUT_CATD                      = "Unit Frames, Buffs and Debuffs, Combat:Healer"
    HEALBOT_ABOUT_CREDITH                   = "Благодарности:"
    HEALBOT_ABOUT_CREDITD                   = "Acirac, Kubik, Von, Aldetal, Brezza, Moonlight Han Xing, CTShammy, Hermis, Ariá, Snaomi"  -- Anyone taking on translations (if required), feel free to add yourself here.
    HEALBOT_ABOUT_LOCALH                    = "Локализации:"
    HEALBOT_ABOUT_LOCALD                    = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW"
    HEALBOT_ABOUT_FAQH                      = "Часто Задаваемые Вопросы"
    HEALBOT_ABOUT_FAQ_QUESTION              = "Вопрос"
    HEALBOT_ABOUT_FAQ_ANSWER                = "Ответ"

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
                                              "1: On the spells tab: Turn on Always Use Enabled \n" ..
                                              "2: On the spells tab: Turn off SmartCast \n\n" ..
                                              "Note: It is expected that most users will want to \n"..
                                              "turn SmartCast back on \n\n" ..
                                              "Note: It is expected that experienced users will want to \n" ..
                                              "turn off Always Use Enabled  \n" ..
                                              "and set the spells for disabled bars"

    HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "You are monitoring for missing buffs \n\n" ..
                                              "This can be turned off on the buffs tab \n" ..
                                              "Alternatively click on the bar and cast the buff",
                                      [2]   = "This is blizzard functionality, not Healbot \n\n" ..
                                              "Using the standard blizzard frames, \n" ..
                                              "try casting a spell thats on Cooldown \n" ..
                                              "Notice how the cursor turns blue. \n\n" ..
                                              "On the spells tab, use Avoid Blue Cursor",
                                      [3]   = "Yes \n\n"..
                                              "Paladin Hand of Salvation cooldown macro example: \n\n" ..
                                              "#show Hand of Salvation \n" ..
                                              '/script local n=UnitName("hbtarget"); ' .. "\n" ..
                                              'if GetSpellCooldown("Hand of Salvation")==0 then ' .. " \n" ..
                                              'SendChatMessage("Hand of Salvation on "..n,"YELL") ' .. "\n" ..
                                              'SendChatMessage("Hand of Salvation!","WHISPER",nil,n) ' .. "\n" ..
                                              "end; \n" ..
                                              "/cast [@hbtarget] Hand of Salvation",
                                      [4]   = "Yes \n\n"..
                                              "Preist Flash Heal, example using both trinkets: \n\n" ..
                                              "#show Flash Heal \n" ..
                                              "/script UIErrorsFrame:Hide() \n" ..
                                              "/console Sound_EnableSFX 0 \n" ..
                                              "/use 13 \n" ..
                                              "/use 14 \n" ..
                                              "/console Sound_EnableSFX 1 \n" ..
                                              "/cast [@hbtarget] Flash Heal \n" ..
                                              "/script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                      [5]   = "1: On the Mouse Wheel tab: Turn off Use Mouse Wheel \n" ..
                                              "2: Bind your macros to blizzard's bindings with\n[@mouseover] \n\n\n" ..
                                              "Eample macro: \n\n" ..
                                              "#showtooltip Flash Heal \n" ..
                                              "/cast [@mouseover] Flash Heal \n",
                                      [6]   = "Yes \n\n\n"..
                                              "With Headers: \n" ..
                                              "1: On the Skins>Headers tab, switch on Show Headers \n" ..
                                              "2: On the Skins>Bars tab, set Number of Groups per\ncolumn \n\n" ..
                                              "Without Headers: \n" ..
                                              "1: On the Skins>Bars tab, switch on Use Groups per\nColumn \n" ..
                                              "2: On the Skins>Bars tab, set Number of Groups per\ncolumn ",
                                      [7]   = "Yes \n\n"..
                                              "1: On the Skins>Healing>Alert tab, set Alert Level to 0 \n" ..
                                              "2: On the Skins>Aggro tab, turn off the Aggro Monitor \n" ..
                                              "3: On the Skins>Bars tab, set Disabled opacity to 0 \n" ..
                                              "4: On the Skins>Bars tab, set Background opacity to 0 \n" ..
                                              "5: On the Skins>Bar Text tab, click on the bar Disabled \n" ..
                                              "and set the Disabled text opacity to 0 \n" ..
                                              "6: On the Skins>General tab, click on the bar\n" ..
                                              "Background and set the Background opacity to 0 \n" ..
                                              "7: On the Cure tab, Turn on debuff monitoring",
                                      [8]   = "Yes \n\n"..
                                              "1: On the Skins>Bars tab, set Incoming Heals to Dont\nShow\n" ..
                                              "2: On the Skins>Bar Text tab, \n" ..
                                              "set Show Health on Bar to No Incoming Heals",
                                      [9]   = "This has been present since a change in WoW 3.2, \n" ..
                                              "it can affects characters with weird letters in their name \n\n" ..
                                              "If your on Vista or Win7, try the follow: \n"..
                                              "change system locale to English\n(for non-unicode programs) \n" ..
                                              "in Control Panel > Region and Language >\nAdministrative Tab",
                                      [10]   = "On the spells tab turn on Always Use Enabled \n\n" ..
                                              "Some my also want to set the Alert Level to 100 \n" ..
                                              "This can be done on the Skins>Healing>Alert tab",
                                      [11]  = "Disable for a character: \n\n" ..
                                              "1: Open the General tab \n" ..
                                              "2: Turn on the Disable option \n\n\n" ..
                                              "Disable when solo: \n\n" ..
                                              "1: Open the General tab \n" ..
                                              "2: To the right of the Disable option, Select only when\nsolo \n" ..
                                              "3: Turn on the Disable option",
                                      [12]  = "Change the Bars Anchor setting on the Skins>General\ntab  \n\n" ..
                                              "Top Right: the bars will grow Down and Left \n" ..
                                              "Top Left: the bars will grow Down and Right \n" ..
                                              "Bottom Right: the bars will grow Up and Left \n" ..
                                              "Bottom Left: the bars will grow Up and Right",
                                      [13]  = "My Targets allows you to create a list of Targets you \n" ..
                                              "want to group separately from others, similar to the\nMT group \n\n" ..
                                              "The following options are available for \n" ..
                                              "adding/removing people to/from the My Targets group \n\n" ..
                                              "- Shift+Ctrl+Alt+Right click on the bar \n" ..
                                              '- Use the Healbot Menu, enter "hbmenu" on the spells\ntab ' .. "\n" ..
                                              "- Use the Mouse Wheel, set on the Mouse Wheel tab",
                                      [14]  = "Private Tanks can be added to the Main Tanks list, \n" ..
                                              "the Private tanks are only visible in your Healbot \n" ..
                                              "and do not affect other players or addons \n\n" ..
                                              "The following options are available for \n" ..
                                              "adding/removing people to/from the Tanks list \n\n" ..
                                              '- Use the Healbot Menu, enter "hbmenu" on the spells\ntab ' .. "\n" ..
                                              "- Use the Mouse Wheel, set on the Mouse Wheel tab",
                                      [15]  = "Yes \n\n"..
                                              "1: On the Skins>Healing tab, turn on Focus \n" ..
                                              "2: set your focus on the NPC (or PC not in raid/party) \n" ..
                                              "Healbot will create a bar in your My Targets list \n\n" ..
                                              "Note: If in a combat situation where you zone in and out\nwhile \n" ..
                                              "in combat and need to reset focus on an NPC \n" ..
                                              "on the Skins>Healing tab set Focus: always show to on \n" ..
                                              "This will keep the bar available during combat. \n\n" ..
                                              "Note: The HealBot Menu has the option\n'Set HealBot Focus' \n" ..
                                              "This can make setting focus easy on NPC's and \n" ..
                                              "serves as a reminder to set focus. \n\n" ..
                                              "Enter 'hbmenu' on the spells tab to use HealBot Menu \n" ..
                                              "or use the Mouse Wheel tab to and set HealBot Menu",
                                      [16]  = "1: On the Skins>Bars tab, adjust the disabled bar\nopacity \n" ..
                                              "2: On the Skins>Bars Text tab, adjust the disabled text \n" ..
                                              "opacity to do this click on the bar labeled Disabled. \n\n" ..
                                              "Some my also want to set the Alert Level to 100 \n" ..
                                              "This can be done on the Skins>Healing>Alert tab",
                                      [17]  = "Actually Healbot is casting exacly as the setup. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                      [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  }

    HEALBOT_OPTIONS_SKINAUTHOR              = "Автор Стиля:"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Избегать\nСинего Курсора"
    HEALBOT_PLAYER_OF_REALM                 = "-"

    HEALBOT_OPTIONS_LANG                    = "Язык"

    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN - by Ydzzs)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK - by Strife)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS - by Strife)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR - by Kubik)"
    HEALBOT_OPTIONS_LANG_DEDE               = "German (deDE - by Snaomi)"
    HEALBOT_OPTIONS_LANG_GRGR               = "Greek (grGR - by Snaomi)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU - by Von)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR - translator required)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT - by Brezza)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR - by Aldetal)"
    HEALBOT_OPTIONS_LANG_RURU               = "Русский (ruRU - translator required)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES - translator required)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW - translator required)"

    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Не удалось загрузить аддон для локализации"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Причина ошибки:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Учтите, что в текущей версии это единственное предупреждение для"

    HEALBOT_OPTIONS_ADDON_FAIL              = "Не удалось загрузить аддон HealBot"

    HEALBOT_OPTIONS_IN_A_GROUP              = "Только в составе Группы или Рейда"

    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "    " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "    " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_PROT      = "    " .. HEALBOT_OPTIONS_TAB_PROTECTION
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "    " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "    " .. HEALBOT_SKIN_DEBTEXT
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "    " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "    " .. HEALBOT_OPTIONS_TAB_WARNING

    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Эффекты поглощения"
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Прозрачность эффектов поглощения"
    HEALBOT_OPTIONS_OUTLINE                 = "Границы"
    HEALBOT_OPTIONS_FRAME                   = "Окно"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. "Окна"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Настройки окон"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Установить позицию подсказки"
    HEALBOT_OPTIONS_FRAME_TITLE             = "Заголовок окна"
    HEALBOT_OPTIONS_FRAME_TITLE_SHOW        = "Показывать заголовок"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Направление расширения"
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Горизонтально"
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Вертикально"
    HEALBOT_OPTIONS_FONT_OFFSET             = "Сдвиг шрифта"
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Назначить группы исцеления"
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Игнорирую транспорт"
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "Не игнорирую транспорт"
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Вкл/Выкл игнорирование транспорта"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Скрыть панели боссов"
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Скрыть рейдовые панели"
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Профиль"
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Группы исцеления"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Цвета панелей"
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Применить текущие настрокий ко всем окнам"
    HEALBOT_WORDS_PROFILE                   = "Профиль"
    HEALBOT_SHARE_SCREENSHOT                = "Скриншот сохранен"
    HEALBOT_SHARE_INSTRUCTION               = "Посетите сайт для получения инструкций о том, как поделиться "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "Использовать окно"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Включая мою цель"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Включая цели танков"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Настройки врага"
    HEALBOT_OPTIONS_SHARE_OPT               = "Настройки общего доступа"
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Поделиться"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Враг"
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "Загрузить стиль"
    HEALBOT_ENEMY_NO_TARGET                 = "Нет цели"
    HEALBOT_OPTIONS_ENEMYBARS               = "Панелей врагов в любом состоянии"
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Вредоносные заклинания"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Включая цели моих целей"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Количество Боссов"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Скрыть панели вне боя"
    HEALBOT_ENEMY_EXISTS_SHOW               = "Только при входе в бой".."\n".."показывать при выходе"
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Цели игроков"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Панели боссов"
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Цель: Показывать только дружественную"
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "Фокус: Показывать только дружественный"
    HEALBOT_OPTIONS_PROFILE                 = "Профиль для".."\n".."Закл/Баффов/Диспеллов"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Персонаж"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Класс"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Уровень Тревоги - В Бою"
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Уровень Тревоги - Вне Боя"
    HEALBOT_OPTION_NUMENEMYS                = "Количество врагов"
    HEALBOT_WORD_AUTO                       = "Авто"
    HEALBOT_OPTIONS_ENABLEAUTOCOMBAT        = "Включить HealBot autoCombat"
    HEALBOT_WORDS_REMOVETEMPCUSTOMNAME      = "Удалить временное польз. имя"
    HEALBOT_WORDS_REMOVEPERMCUSTOMNAME      = "Удалить постоянное польз. имя"
    HEALBOT_WORDS_ADDTEMPCUSTOMNAME         = "Добавить временное польз. имя"
    HEALBOT_WORDS_ADDPERMCUSTOMNAME         = "Добавить постоянное польз. имя"
    HEALBOT_OPTIONS_ENABLELIBUTF8           = "Включить библиотеку UTF8"
    HEALBOT_OPTIONS_SHOWDIRECTION           = "Показывать направление вне досягаемости"
    HEALBOT_OPTIONS_SHOWDIRECTIONMOUSE      = "Только при наведении курсора"
    HEALBOT_LDB_LEFT_TOOLTIP                = "|cffffff00 ЛКМ:|r Вкл/Выкл панель опций HealBot"
    HEALBOT_LDB_SHIFTLEFT_TOOLTIP           = "|cffffff00 Shift-ЛКМ:|r Переключить стиль HealBot"
    HEALBOT_LDB_RIGHT_TOOLTIP               = "|cffffff00 ПКМ:|r Сбросить HealBot"
    HEALBOT_LDB_SHIFTRIGHT_TOOLTIP          = "|cffffff00 Shift-ПКМ:|r Вкл/Выкл HealBot"
end
