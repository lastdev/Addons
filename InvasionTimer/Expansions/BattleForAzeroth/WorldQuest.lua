---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local WQ = IT.WorldQuest

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 7,
    category = 'quest',
    achievementID = 13512, -- Master Calligrapher
    questIDs = {
        {55340, 55342}, -- Calligraphy
        {55264, 55343}, -- Calligraphy
        {55341, 55344}, -- Calligraphy
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13426, -- Come On and Slam
    questID = 54512, -- Cleansing Tide
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13440, -- Pushing the Payload
    questID = 54498, -- Stack On The Tank
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13441, -- Pushing the Payload
    questID = 54505, -- Get On The Payload
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13435, -- Doomsoul Surprise
    questID = 54689, -- Lights Out
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13437, -- Scavenge like a Vulpera
    questID = 54415, -- Vulpera for a Day
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 7,
    category = 'quest',
    achievementID = 13060, -- Kul Runnings
    questIDs = {
        {49994}, -- Sliding with Style
        {53188}, -- Frozen Freestyle
        {53189}, -- Slippery Slopes
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13059, -- Drag Race
    questID = 53346, -- Trogg Tromping
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 7,
    category = 'quest',
    achievementIDs = {
        13050, -- Bless the Rains Down in Freehold
    },
    questIDs = {
        52159, -- Swab This!
        53196, -- Swab This!
    },
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 7,
    category = 'quest',
    achievementID = 13054, -- Sabertron Assemble
    questIDs = {
        nil,
        {51977}, -- Sabertron
        {51978}, -- Sabertron
        {51976}, -- Sabertron
        {51974}, -- Sabertron
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13285, -- Upright Citizens
    questID = 53704, -- Not Too Sober Citizens Brigade
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 7,
    category = 'quest',
    achievementIDs = {
        13042, -- About To Break
    },
    questIDs = {
        53106, -- Censership
        53107, -- Plunder and Provisions
        53108, -- Iconoclasm
        53343, -- Censership
        53344, -- Iconoclasm
        53345, -- Plunder and Provisions
    },
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 7,
    category = 'quest',
    achievementIDs = {
        13035, -- By de Power of de Loa!
    },
    questIDs = {
        51178, -- Hundred Troll Holdout
        51232, -- Hundred Troll Holdout
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13026, -- 7th Legion Spycatcher
    questID = 50899, -- Don't Stalk Me, Troll
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13025, -- Zandalari Spycatcher
    questID = 50717, -- Don't Stalk Me, Troll
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 7,
    category = 'quest',
    achievementIDs = {
        13023, -- It's Really Getting Out of Hand
    },
    questIDs = {
        50559, -- Getting Out of Hand
        51127, -- Getting Out of Hand
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13022, -- Revenge is Best Served Speedily
    questID = 50786, -- Revenge of Krag'wa
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13021, -- A Most Efficient Apocalypse
    questID = 50665, -- Cancel the Blood Troll Apocalypse
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13009, -- Adept Sandfisher
    questID = 51173, -- Sandfishing
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 7,
    category = 'quest',
    achievementID = 13014, -- Vorrik's Champion
    questIDs = {
        {51957}, -- The Wrath of Vorrik
        {51983}, -- Vorrik's Vengeance
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 7,
    category = 'quest',
    achievementID = 13041, -- Hungry, Hungry Ranishu
    questID = 52798, -- A Few More Charges
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 7,
    category = 'exploration',
    achievementID = 13690, -- Nazjatarget Eliminated
    questIDs = {
        {55897}, -- Szun, Breaker of Slaves
        {55895}, -- Frozen Winds of Zhiela
        {55894}, -- Zoko, Her Iron Defender
        {55898}, -- Tempest-Speaker Shalan'ali
        {55899}, -- Starseeker of the Shirakess
        {55893}, -- Azanz, the Slitherblade
        {55896}, -- Undana, Chilling Assassin
        {55900}, -- Kassar, Wielder of Dark Blades
        {55886}, -- The Zanj'ir Brutalizer
        {55891}, -- Champion Aldrantiss, Defender of Her Kingdom
        {55887}, -- Champion Alzana, Arrow of Thunder
        {55892}, -- Champion Eldanar, Shield of Her Glory
        {55889}, -- Champion Kyx'zhul the Deepspeaker
        {55888}, -- Champion Qalina, Spear of Ice
        {55890}, -- Champion Vyz'olgo the Mind-Taker
    },
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 7,
    category = 'exploration',
    achievementID = 13764, -- Puzzle Performer
    questIDs = {
        {56025}, -- Leylocked Chest
        {56024}, -- Leylocked Chest
        {56023}, -- Leylocked Chest
        {56022}, -- Runelocked Chest
        {56021}, -- Runelocked Chest
        {56020}, -- Runelocked Chest
        {56019}, -- Runelocked Chest
        {56018}, -- Runelocked Chest
        {56017}, -- Runelocked Chest
        {56016}, -- Runelocked Chest
        {56015}, -- Runelocked Chest
        {56014}, -- Runelocked Chest
        {56013}, -- Runelocked Chest
        {56012}, -- Runelocked Chest
        {56011}, -- Runelocked Chest
        {56010}, -- Runelocked Chest
        {56009}, -- Runelocked Chest
        {56008}, -- Runelocked Chest
        {56007}, -- Runelocked Chest
        {56006}, -- Runelocked Chest
        {56003}, -- Runelocked Chest
    },
})
