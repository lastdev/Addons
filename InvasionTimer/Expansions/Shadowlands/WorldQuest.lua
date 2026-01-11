---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local WQ = IT.WorldQuest

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 8,
    category = 'quest',
    achievementID = 14233, -- Tea Tales
    questIDs = {
        {59848}, -- Tea Tales: Theotar
        {59850}, -- Tea Tales: Vulca
        {59852}, -- Tea Tales: Gubbins and Tubbins
        {59853}, -- Tea Tales: Lost Sybille
    },
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 8,
    category = 'quest',
    achievementID = 14735, -- Flight School Graduate
    questIDs = {
        {60844}, -- Flight School: Falling With Style
        {60858}, -- Flight School: Up and Away!
        {60911}, -- Flight School: Flapping Frenzy
    },
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 8,
    category = 'quest',
    achievementIDs = {
        14737, -- What Bastion Remembered
    },
    questIDs = {
        59705, -- Things Remembered
        59717, -- Things Remembered
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 8,
    category = 'quest',
    achievementID = 14671, -- Something's Not Quite Right....
    questID = 60739, -- Tough Crowd
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 8,
    category = 'quest',
    achievementID = 14672, -- A Bit of This, A Bit of That
    questID = 60475, -- We'll Workshop It
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 8,
    category = 'quest',
    achievementID = 14741, -- Aerial Ace
    questID = 60911, -- Flight School: Flapping Frenzy
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 8,
    category = 'quest',
    achievementID = 14762, -- Breaking the Stratus Fear
    questID = 60858, -- Flight School: Up and Away!
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 8,
    category = 'quest',
    achievementID = 14765, -- Ramparts Racer
    questID = 59643, -- It's Race Day in the Ramparts!
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 8,
    category = 'quest',
    achievementID = 14766, -- Parasoling
    questID = 59718, -- Parasol Peril
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 8,
    category = 'quest',
    achievementID = 14772, -- Caught in a Bat Romance
    questID = 60602, -- Secret Service
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 8,
    category = 'exploration',
    achievementID = 14626, -- Harvester of Sorrow
    questID = 57205, -- A Few Bumps Along the Way
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 8,
    category = 'exploration',
    achievementID = 14721, -- It's In The Mix
    questID = 59234, -- Mixing A Mess
})
