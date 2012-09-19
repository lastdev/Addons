------------
-- RUSSIAN --
------------
--Last update: 21.03.2011 - 11:15

if (GetLocale() == "ruRU") then

-------------------
-- Compatibility --
-------------------

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

HEALBOT_DISEASE                         = "Болезнь";
HEALBOT_MAGIC                           = "Магия";
HEALBOT_CURSE                           = "Проклятие";
HEALBOT_POISON                          = "Яд";
-- HEALBOT_DISEASE_en                      = "Disease";  -- Do NOT localize this value.
-- HEALBOT_MAGIC_en                        = "Magic";  -- Do NOT localize this value.
-- HEALBOT_CURSE_en                        = "Curse";  -- Do NOT localize this value.
-- HEALBOT_POISON_en                       = "Poison";  -- Do NOT localize this value.
-- HEALBOT_CUSTOM_en                       = "Custom";  -- Do NOT localize this value. 


-- Debuffs
HEALBOT_DEBUFF_ANCIENT_HYSTERIA         = "Древняя истерия";
HEALBOT_DEBUFF_IGNITE_MANA              = "Воспламенение маны";
HEALBOT_DEBUFF_TAINTED_MIND             = "Запятнанный разум";
HEALBOT_DEBUFF_VIPER_STING              = "Укус гадюки";
HEALBOT_DEBUFF_SILENCE                  = "Безмолвие";
HEALBOT_DEBUFF_MAGMA_SHACKLES           = "Оковы магмы";
HEALBOT_DEBUFF_FROSTBOLT                = "Ледяная стрела";
HEALBOT_DEBUFF_HUNTERS_MARK             = "Метка охотника";
HEALBOT_DEBUFF_SLOW                     = "Замедление";
HEALBOT_DEBUFF_ARCANE_BLAST             = "Чародейская вспышка";
HEALBOT_DEBUFF_IMPOTENCE                = "Проклятие бессилия";
HEALBOT_DEBUFF_DECAYED_STR              = "Ослабление силы";
HEALBOT_DEBUFF_DECAYED_INT              = "Угасание интеллекта";
HEALBOT_DEBUFF_CRIPPLE                  = "Увечье";
HEALBOT_DEBUFF_CHILLED                  = "Окоченение";
HEALBOT_DEBUFF_CONEOFCOLD               = "Конус холода";
HEALBOT_DEBUFF_CONCUSSIVESHOT           = "Шокирующий выстрел";
HEALBOT_DEBUFF_THUNDERCLAP              = "Раскат грома";
HEALBOT_DEBUFF_HOWLINGSCREECH           = "Визгливый вой";
HEALBOT_DEBUFF_DAZED                    = "Головокружение";
HEALBOT_DEBUFF_UNSTABLE_AFFL            = "Нестабильное колдовство";
HEALBOT_DEBUFF_DREAMLESS_SLEEP          = "Мирный сон";
HEALBOT_DEBUFF_GREATER_DREAMLESS        = "Больший мирный сон";
HEALBOT_DEBUFF_MAJOR_DREAMLESS          = "Старший мирный сон";
HEALBOT_DEBUFF_FROST_SHOCK              = "Ледяной шок";

HB_TOOLTIP_MANA                         = "^Мана: (%d+)$";
HB_TOOLTIP_INSTANT_CAST                 = SPELL_CAST_TIME_INSTANT_NO_MANA;
HB_TOOLTIP_CAST_TIME                    = "Применение: (%d+.?%d*) сек";
HB_TOOLTIP_CHANNELED                    = SPELL_CAST_CHANNELED;
HB_TOOLTIP_OFFLINE                      = PLAYER_OFFLINE;
HB_OFFLINE                              = PLAYER_OFFLINE; -- has gone offline msg
HB_ONLINE                               = GUILD_ONLINE_LABEL; -- has come online msg

-----------------
-- Translation --
-----------------

HEALBOT_ADDON                           = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED                          = " загружен.";

HEALBOT_ACTION_OPTIONS                  = "Настройки";

HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS                = "Стандарт";
HEALBOT_OPTIONS_CLOSE                   = "Закрыть";
HEALBOT_OPTIONS_HARDRESET               = "Перез.UI"
HEALBOT_OPTIONS_SOFTRESET               = "СбросHB"
HEALBOT_OPTIONS_INFO                    = "Инфо"
HEALBOT_OPTIONS_TAB_GENERAL             = "Общее";
HEALBOT_OPTIONS_TAB_SPELLS              = "Заклинания";
HEALBOT_OPTIONS_TAB_HEALING             = "Исцеление";
HEALBOT_OPTIONS_TAB_CDC                 = "Излечение";
HEALBOT_OPTIONS_TAB_SKIN                = "Шкурки";
HEALBOT_OPTIONS_TAB_TIPS                = "Tips";
HEALBOT_OPTIONS_TAB_BUFFS               = "Бафы";

HEALBOT_OPTIONS_BARALPHA                = "Прозрач-ть включеных";
HEALBOT_OPTIONS_BARALPHAINHEAL          = "Прозр-ть вход-го исцеления";
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
HEALBOT_SKIN_DISABLED                   = HEALBOT_SKIN_DISTEXT
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

HEALBOT_OPTIONS_RANGECHECKFREQ          = "Проверка досягаемости";

HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Скрыть окна группы";
HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Включая игрока и цель";
HEALBOT_OPTIONS_DISABLEHEALBOT          = "Отключить HealBot";

HEALBOT_OPTIONS_CHECKEDTARGET           = "Проверен";

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
HEALBOT_ZONE_WG                         = "Ущелье Песни Войны";

HEALBOT_OPTION_AGGROTRACK               = "Монитор агрессии";
HEALBOT_OPTION_AGGROBAR                 = "Мигание";
HEALBOT_OPTION_AGGROTXT                 = ">> Показ текста <<";
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

HEALBOT_BALANCE                         = "Баланс";
HEALBOT_FERAL                           = "Сила зверя";
HEALBOT_RESTORATION                     = "Исцеление";
HEALBOT_SHAMAN_RESTORATION              = "Исцеление";
HEALBOT_ARCANE                          = "Тайная магия";
HEALBOT_FIRE                            = "Огонь";
HEALBOT_FROST                           = "Лед";
HEALBOT_DISCIPLINE                      = "Послушание";
HEALBOT_HOLY                            = "Свет";
HEALBOT_SHADOW                          = "Темная магия";
HEALBOT_ASSASSINATION                   = "Убийство";
HEALBOT_COMBAT                          = "Бой";
HEALBOT_SUBTLETY                        = "Скрытность";
HEALBOT_ARMS                            = "Оружие";
HEALBOT_FURY                            = "Неистовство";
HEALBOT_PROTECTION                      = "Защита";
HEALBOT_BEASTMASTERY                    = "Чувство зверя";
HEALBOT_MARKSMANSHIP                    = "Стрельба";
HEALBOT_SURVIVAL                        = "Выживание";
HEALBOT_RETRIBUTION                     = "Возмездие";
HEALBOT_ELEMENTAL                       = "Укрощение стихии";
HEALBOT_ENHANCEMENT                     = "Совершенствование";
HEALBOT_AFFLICTION                      = "Колдовство";
HEALBOT_DEMONOLOGY                      = "Демонология";
HEALBOT_DESTRUCTION                     = "Разрушение";
HEALBOT_BLOOD                           = "Кровь";
HEALBOT_UNHOLY                          = "Нечестивость";

HEALBOT_OPTIONS_VISIBLERANGE            = "Отключать панель когда расстояние больше 100 метров";
HEALBOT_OPTIONS_NOTIFY_HEAL_MSG         = "Сообщения о исцелении";
HEALBOT_OPTIONS_NOTIFY_MSG              = "Cообщения";
HEALBOT_WORDS_YOU                       = "вы";
HEALBOT_NOTIFYHEALMSG                   = "Применяется #s для исцеления #n на #h";
HEALBOT_NOTIFYOTHERMSG                  = "Применяется #s на #n";

HEALBOT_OPTIONS_HOTPOSITION             = "Позиция иконки";
HEALBOT_OPTIONS_HOTSHOWTEXT             = "Текст иконки";
HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Подсчёт";
HEALBOT_OPTIONS_HOTTEXTDURATION         = "Длительность";
HEALBOT_OPTIONS_ICONSCALE               = "Масштаб";
HEALBOT_OPTIONS_ICONTEXTSCALE           = "Масштаб текста иконки";

HEALBOT_SKIN_FLUID                      = "Fluid";
HEALBOT_SKIN_VIVID                      = "Vivid";
HEALBOT_SKIN_LIGHT                      = "Light";
HEALBOT_SKIN_SQUARE                     = "Квадраты";
HEALBOT_OPTIONS_AGGROBARSIZE            = "Размер полосы угрозы";
HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Текст в 2 строки";
HEALBOT_OPTIONS_TEXTALIGNMENT           = "Выравнивание текста";
HEALBOT_OPTIONS_ENABLELIBQH             = "Включить libQuickHealth";
HEALBOT_VEHICLE                         = "Транспорт";
HEALBOT_OPTIONS_UNIQUESPEC              = "Спец. заклинание для другой спецификации";
HEALBOT_WORDS_ERROR				        = "Ошибка";
HEALBOT_SPELL_NOT_FOUND			        = "Заклинание не найдено";
HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Скрыть подсказки в бою";

HEALBOT_OPTIONS_BUFFNAMED               = "Для наблюдения, введите имя игрока:\n\n";
HEALBOT_WORD_ALWAYS                     = "Всегда";
HEALBOT_WORD_SOLO                       = "В одиночку";
HEALBOT_WORD_NEVER                      = "Никогда";
HEALBOT_SHOW_CLASS_AS_ICON              = "как иконку";
HEALBOT_SHOW_CLASS_AS_TEXT              = "как текст";

HEALBOT_SHOW_INCHEALS                   = "Входящее исцеление";
HEALBOT_D_DURATION                      = "Длительность прямых";
HEALBOT_H_DURATION                      = "Длительность ИзВя";
HEALBOT_C_DURATION                      = "Длительность потоковых";

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- показать справку",
               [2] = "[HealBot] /hb o -- переключение настроек",
               [3] = "[HealBot] /hb ri -- сбросить HealBot",
               [4] = "[HealBot] /hb t -- переключения Healbot из состояния включен в выключен и обратно",
               [5] = "[HealBot] /hb bt -- переключения мониторинга бафов из состояния включен в выключен и обратно",
               [6] = "[HealBot] /hb dt -- переключения мониторинга дебафов из состояния включен в выключен и обратно",
               [7] = "[HealBot] /hb skin <skinName> -- сменить шкурку",
               [8] = "[HealBot] /hb hs -- показать дополнительные слэш команды",
              }

HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- сброс настроек на стандартные значения",
                [2] = "[HealBot] /hb ui -- перезагрузить UI",
                [3] = "[HealBot] /hb ri -- сбросить HealBot",
                [4] = "[HealBot] /hb tr <Role> -- установите наивысший приоритет по роли для под-сортировке по роли. Дествующие роли 'TANK', 'HEALER' или 'DPS'",
                [5] = "[HealBot] /hb use10 -- австоматически использовать Инженерный слот 10",
                [6] = "[HealBot] /hb pcs <n> -- регулировка размера индикатора заряда энергии света на <n>, Значение по умолчанию 7 ",
                [7] = "[HealBot] /hb info -- показать инф. окно",
                [8] = "[HealBot] /hb spt -- переключение своего питомца",
                [9] = "[HealBot] /hb ws -- переключение сокрытия/показа иконки Ослабленная душа вместо СС:Щ с -",
               [10] = "[HealBot] /hb rld <n> -- In seconds, how long the players name stays green after a res",
               [11] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
               [12] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
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

HEALBOT_INFO_INCHEALINFO                = "== Инфо входящего исцеления ==";
HEALBOT_INFO_ADDONCPUUSAGE              = "== Исп. CPU аддоном в секундах ==";
HEALBOT_INFO_ADDONCOMMUSAGE             = "== Исп. коммуникации аддоном ==";
HEALBOT_WORD_HEALER                     = "Лекарь";
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
HEALBOT_CHAT_NEWVERSION2                = "на http://healbot.alturl.com";
HEALBOT_CHAT_SHARESKINERR1              = " Skin not found for Sharing";
HEALBOT_CHAT_SHARESKINERR3              = " not found for Skin Sharing";
HEALBOT_CHAT_SHARESKINACPT              = "Share Skin accepted from ";
HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Шкурка по умолчанию";
HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Пользовательский дебаф сброшен";
HEALBOT_CHAT_CHANGESKINERR1             = "неизвестная шкурка: /hb skin ";
HEALBOT_CHAT_CHANGESKINERR2             = "Действительные шкурки:  ";
HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Текущее заклинания скопировано на все наборы талантов";
HEALBOT_CHAT_UNKNOWNCMD                 = "Неизвестная слэш команда: /hb ";
HEALBOT_CHAT_ENABLED                    = "Entering enabled state";
HEALBOT_CHAT_DISABLED                   = "Entering disabled state";
HEALBOT_CHAT_SOFTRELOAD                 = "Reload healbot requested";
HEALBOT_CHAT_HARDRELOAD                 = "Reload UI requested";
HEALBOT_CHAT_CONFIRMSPELLRESET          = "Заклинания сброшены";
HEALBOT_CHAT_CONFIRMCURESRESET          = "Лечения сброшены";
HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Бафы сброшены";
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Unable to receive all Skin settings - Possibly missing SharedMedia, see HealBot/Docs/readme.html for links";
HEALBOT_CHAT_MACROSOUNDON               = "Sound not suppressed when using auto trinkets";
HEALBOT_CHAT_MACROSOUNDOFF              = "Sound suppressed when using auto trinkets";
HEALBOT_CHAT_MACROERRORON               = "Errors not suppressed when using auto trinkets";
HEALBOT_CHAT_MACROERROROFF              = "Errors suppressed when using auto trinkets";
HEALBOT_CHAT_ACCEPTSKINON               = "Share Skin - Show accept skin popup when someone shares a skin with you";
HEALBOT_CHAT_ACCEPTSKINOFF              = "Share Skin - Always ignore share skins from everyone";
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
HEALBOT_WORD_DPS                        = "DPS";
HEALBOT_CHAT_TOPROLEERR                 = " роль не действительна в данном контексте - используйте 'TANK', 'DPS' или 'HEALER'";
HEALBOT_CHAT_NEWTOPROLE                 = "Highest top role is now ";
HEALBOT_CHAT_SUBSORTPLAYER1             = "Player will be set to first in SubSort";
HEALBOT_CHAT_SUBSORTPLAYER2             = "Player will be sorted normally in SubSort";
HEALBOT_OPTIONS_SHOWREADYCHECK          = "Проверка готовности";
HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Сначало вы";
HEALBOT_WORD_FILTER                     = "Фильтр";
HEALBOT_OPTION_AGGROPCTBAR              = "Двигать";
HEALBOT_OPTION_AGGROPCTTXT              = "Показ. текст";
HEALBOT_OPTION_AGGROPCTTRACK            = "Следить в %";
HEALBOT_OPTIONS_ALERTAGGROLEVEL0        = "0 - имея низкую угрозы и ничего не танкуя";
HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - имея высокую угрозу и ничего не танкуя";
HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - опасное танкования, не наивысшая угроза на существе";
HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - безопасное танкованин по крайней мере одно существо";
HEALBOT_OPTIONS_AGGROALERT              = "Уровент сигнала об угрозе";
HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Показать подробности о наблюдаемом ИзВ";
HEALBOT_WORDS_MIN                       = "мин";
HEALBOT_WORDS_MAX                       = "макс";
HEALBOT_WORDS_R                         = "R";
HEALBOT_WORDS_G                         = "G";
HEALBOT_WORDS_B                         = "B";
HEALBOT_CHAT_SELFPETSON                 = "Self Pet switched on";
HEALBOT_CHAT_SELFPETSOFF                = "Self Pet switched off";
HEALBOT_WORD_PRIORITY                   = "Приоритет";
HEALBOT_VISIBLE_RANGE                   = "В пределах 100 метров";
HEALBOT_SPELL_RANGE                     = "В пределах действия заклинания";
HEALBOT_CUSTOM_CATEGORY                 = "Категория";
HEALBOT_CUSTOM_CAT_CUSTOM               = "Свой";
HEALBOT_CUSTOM_CAT_CLASSIC              = "Classic";
HEALBOT_CUSTOM_CAT_TBC_OTHER            = "TBC - Другое";
HEALBOT_CUSTOM_CAT_TBC_BT               = "TBC - Черный храм";
HEALBOT_CUSTOM_CAT_TBC_SUNWELL          = "TBC - Солнечный Колодец";
HEALBOT_CUSTOM_CAT_LK_OTHER             = "WotLK - Другое";
HEALBOT_CUSTOM_CAT_LK_ULDUAR            = "WotLK - Ульдуар";
HEALBOT_CUSTOM_CAT_LK_TOC               = "WotLK - Испытание крестоносца";
HEALBOT_CUSTOM_CAT_LK_ICC_LOWER         = "WotLK - ЦЛК Нижний ярус";
HEALBOT_CUSTOM_CAT_LK_ICC_PLAGUEWORKS   = "WotLK - ЦЛК Чумодельня";
HEALBOT_CUSTOM_CAT_LK_ICC_CRIMSON       = "WotLK - ЦЛК Багровый зал";
HEALBOT_CUSTOM_CAT_LK_ICC_FROSTWING     = "WotLK - ЦЛК Залы Ледокрылых";
HEALBOT_CUSTOM_CAT_LK_ICC_THRONE        = "WotLK - ЦЛК Ледяной Трон";
HEALBOT_CUSTOM_CAT_LK_RS_THRONE         = "WotLK - Рубиновое святилище"
HEALBOT_CUSTOM_CAT_CATA_OTHER           = "Cata - Другое";
HEALBOT_CUSTOM_CAT_CATA_PARTY           = "Cata - Группа";
HEALBOT_CUSTOM_CAT_CATA_RAID            = "Cata - Рейд";
HEALBOT_WORD_RESET                      = "Сброс";
HEALBOT_HBMENU                          = "HBmenu";
HEALBOT_ACTION_HBFOCUS                  = "Левый клик - установить\nфокус на цель";
HEALBOT_WORD_CLEAR                      = "Очистить";
HEALBOT_WORD_SET                        = "Установить";
HEALBOT_WORD_HBFOCUS                    = "Фокус HealBot";
HEALBOT_WORD_OUTSIDE                    = "Внешний мир";
HEALBOT_WORD_ALLZONE                    = "Все зоны";
HEALBOT_WORD_OTHER                      = "Другие";
HEALBOT_OPTIONS_TAB_ALERT               = "Тревога";
HEALBOT_OPTIONS_TAB_SORT                = "Сорт";
HEALBOT_OPTIONS_TAB_HIDE                = "Скрыть"
HEALBOT_OPTIONS_TAB_AGGRO               = "Угроза";
HEALBOT_OPTIONS_TAB_ICONTEXT            = "Текст иконки";
HEALBOT_OPTIONS_TAB_TEXT                = "Текст панели";
HEALBOT_OPTIONS_AGGROBARCOLS            = "Цвета полосы угрозы";
HEALBOT_OPTIONS_AGGRO1COL               = "Высокая\nугроза";
HEALBOT_OPTIONS_AGGRO2COL               = "Опасное\nтанкование";
HEALBOT_OPTIONS_AGGRO3COL               = "Безопастное\nтанкование";
HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Частота сверкания";
HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Прозрачность сверкания";
HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Длительность от";
HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Оповещение длительности от";
HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Сброс своих дебафов";
HEALBOT_CMD_RESETSKINS                  = "Сброс шкурок";
HEALBOT_CMD_CLEARBLACKLIST              = "Очистить черный список";
HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Переключение приёма шкурок от других";
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
HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Delete custom debuffs on priority 10";
HEALBOT_ACCEPTSKINS                     = "Принемать шкурки от других";
HEALBOT_SUPPRESSSOUND                   = "Авто-Аксессуар: Подавлять звуки";
HEALBOT_SUPPRESSERROR                   = "Авто-Аксессуар: Подавлять ошибки";
HEALBOT_OPTIONS_CRASHPROT               = "Crash Protection";
HEALBOT_CP_MACRO_LEN                    = "Macro name must be between 1 and 14 characters";
HEALBOT_CP_MACRO_BASE                   = "Base macro name";
HEALBOT_CP_MACRO_SAVE                   = "Last saved at: ";
HEALBOT_CP_STARTTIME                    = "Protect duration on logon";
HEALBOT_WORD_RESERVED                   = "Reserved";
HEALBOT_OPTIONS_COMBATPROT              = "Combat Protection";
HEALBOT_COMBATPROT_PARTYNO              = "bars Reserved for Party";
HEALBOT_COMBATPROT_RAIDNO               = "bars Reserved for Raid";

HEALBOT_WORD_HEALTH                     = "Здоровье";
HEALBOT_OPTIONS_DONT_SHOW               = "Не показывать";
HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Same as health (current health)";
HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Same as health (future health)";
HEALBOT_OPTIONS_FUTURE_HLTH             = "Future health";
HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Цвет полосы здоровья";
HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Цвет входящего исцеления";
HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Цель: всегда показ.";
HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Фокус: всегда показ.";
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Питомцы: группы из 5и"
HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Исп. игровую подсказку";
HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Показ. знач. энергии";
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Показ. энергию света";

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
HEALBOT_ZONE_THEOCULUS                  = "Окулус"
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

end
