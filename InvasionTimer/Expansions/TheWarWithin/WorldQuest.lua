---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local WQ = IT.WorldQuest

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 10,
    category = 'quest',
    achievementIDs = {
        40623, -- I Only Need One Trip
        40630, -- For the Collective
    },
    questIDs = {
        82580, -- Courier Mission: Ore Recovery
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 10,
    category = 'quest',
    achievementID = 40082, -- Never Enough
    questID = 82120, -- Pool Cleaner
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 10,
    category = 'quest',
    achievementID = 40150, -- Children's Entertainer
    questID = 82288, -- Work Hard, Play Hard
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 10,
    category = 'quest',
    achievementID = 40507, -- Hanging Tight
    questID = 83101, -- Reaching for Resources
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 10,
    category = 'exploration',
    achievementID = 40869, -- Worm Theory
    questIDs = {
        {82324}, -- Grub Run
        {79959}, -- Wormcraft Rumble
        {79958}, -- Worm Sign, Sealed, Delivered
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 10,
    category = 'exploration',
    achievementID = 40620, -- Back to the Wall
    questID = 82414, -- Special Assignment: A Pound of Cure
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 10,
    category = 'exploration',
    achievementID = 40843, -- Mine Poppin'
    questID = 82468, -- Let Them Win
})
