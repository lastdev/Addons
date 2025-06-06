if GetLocale() ~= "ruRU" then return end
if not DBM_COMMON_L then DBM_COMMON_L = {} end

local CL = DBM_COMMON_L

--General
CL.NONE						= "Нет"
CL.RANDOM		  			= "Случайно"
CL.UNKNOWN					= "неизвестно"
CL.NEXT						= "След. %s"
CL.COOLDOWN					= "Восст. %s"
CL.INCOMING					= "Прибытие %s"
CL.INTERMISSION				= "Переходная фаза"
CL.NO_DEBUFF				= "Нет %s"
CL.ALLY						= "Союзник"
CL.ALLIES					= "Союзники"
CL.TANK						= "Танк"
CL.CLEAR					= "Очищен"
CL.SAFE						= "Безопасно"
CL.NOTSAFE					= "Не безопасно"
CL.SEASONAL					= "Сезонный"
CL.FULLENERGY				= "Полная энергия"
--Movements/Places
CL.UP						= "Наверх"
CL.DOWN						= "Вниз"
CL.LEFT						= "Налево"
CL.RIGHT					= "Направо"
CL.CENTER					= "Центр"
CL.BOTH						= "Оба"
CL.BEHIND		 			= "Сзади"
CL.BACK						= "Назад"
CL.SIDE						= "Сторона"
CL.TOP						= "Верх"
CL.BOTTOM					= "Низ"
CL.MIDDLE					= "Середина"
CL.FRONT					= "Вперёд"
CL.EAST						= "Восток"
CL.WEST						= "Запад"
CL.NORTH					= "Север"
CL.SOUTH					= "Юг"
CL.NORTHEAST				= "Северо-Восток"
CL.SOUTHEAST				= "Юго-Восток"
CL.SOUTHWEST				= "Юго-Запад"
CL.NORTHWEST				= "Северо-Запад"
CL.OUTSIDE					= "Снаружи"
CL.INSIDE					= "Внутри"
CL.SHIELD					= "Защита"
CL.PILLAR					= "Столп"
CL.SHELTER					= "Укрытие"
CL.EDGE						= "Край комнаты"
CL.FAR_AWAY					= "Далеко"
CL.PIT						= "Лунка"
CL.TOTEM					= "Тотем"
CL.TOTEMS					= "Тотемы"
CL.HORIZONTAL				= "Горизонтально"
CL.VERTICAL					= "Вертикально"
--Mechanics
CL.BOMB						= "Бомба"
CL.BOMBS					= "Бомбы"
CL.BALLS					= "Шары"
CL.ORB						= "Сфера"
CL.ORBS						= "Сферы"
CL.RING						= "Кольцо"
CL.RINGS					= "Кольца"
CL.CHEST					= "сундука"
CL.ADD						= "Адд"
CL.ADDS						= "Адды"
CL.ADDCOUNT					= "Адд %s"
CL.BIG_ADD					= "Большой адд"
CL.BIG_ADDS					= "Большие адды"
CL.BOSS						= "Босс"
CL.ENEMIES					= "Противники"
CL.BREAK_LOS				= "Преграда"--По идее так будет правильнее по смыслу и склонению. Но в идеале должно быть так: "Бегите за стену". Смысл, по идее, один и тот же
CL.RESTORE_LOS				= "Maintain LOS"
CL.BOSSTOGETHER				= "Боссы вместе"
CL.BOSSAPART				= "Боссы раздельно"
CL.MINDCONTROL				= "Контроль над разумом"
CL.TANKCOMBO				= "Танковое комбо"
CL.TANKDEBUFF				= "Дебафф на танке"
CL.AOEDAMAGE				= "AoE урон"
CL.AVOID					= "Избежание"
CL.GROUPSOAK				= "Поглощение"
CL.GROUPSOAKS				= "Поглощения"
CL.HEALABSORB				= "Поглощение исцеления"--По идее так будет правильно. Но если вдруг окажется, что не подходит по смыслу, то дайте знать
CL.HEALABSORBS				= "Поглощение исцеления"--По идее так будет правильно. Но если вдруг окажется, что не подходит по смыслу, то дайте знать
CL.DODGES					= "Уклонения"
CL.POOL						= "Лужа"
CL.POOLS					= "Лужи"
CL.DEBUFFS					= "Дебаффы"
CL.DISPELS					= "Рассеивания"
CL.PUSHBACK					= "Отталкивание"
CL.FRONTAL					= "Фронтальный удар"
CL.RUNAWAY					= "Убегать"
CL.SPREAD					= "Рассредоточение"--По идее так правильно, но если что вдруг, дайте знать
CL.SPREADS					= "Рассредоточение"--По идее так правильно, но если что вдруг, дайте знать
CL.SPREADDEBUFF				= "Рассредоточение с дебаффом"--Если вдруг окажется, что не подойдёт по смыслу, то дайте знать
CL.SPREADDEBUFFS			= "Рассредоточение с дебаффами"--Если вдруг окажется, что не подойдёт по смыслу, то дайте знать
CL.LASER					= "Лазер"
CL.LASERS					= "Лазеры"
CL.RIFT						= "Разлом"
CL.RIFTS					= "Разломы"
CL.TRAPS					= "Ловушки"
CL.ROOTS					= "Корни"
CL.MARK						= "Метка"
CL.MARKS					= "Метки"
CL.CURSE					= "Проклятие"
CL.CURSES					= "Проклятия"
CL.SWIRLS					= "Вихри"
CL.CHARGES					= "Атака босса"--По идее так правильно
CL.CIRCLES					= "Круги"
CL.KNOCKUP					= "Столкновение"
CL.NEGATIVE					= "Отрицательно"
CL.POSITIVE					= "Положительно"

-- Colors
CL.BLACK	= "Черный"
CL.BLUE		= "Синий"
CL.GREEN	= "Зеленый"
CL.RED		= "Красный"
CL.BRONZE	= "Бронзовый"

-- Conjunctions, used to join words, e.g., "Spell1 *and* Spell2 on you!"
CL.AND		= "и"
CL.OR		= "или"
