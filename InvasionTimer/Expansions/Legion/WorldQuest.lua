---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local WQ = IT.WorldQuest

---@type table<number, number[]>
local battlePetFamilyFamiliar = {
    {42159}, -- Training with the Nightwatchers
    {40299}, -- Fight Night: Bodhi Sunwayver
    {40277}, -- Fight Night: Tiffany Nelson
    {42442}, -- Fight Night: Amalia
    {40298}, -- Fight Night: Sir Galveston
    {40280}, -- Training with Bredda
    {40282}, -- Tiny Poacher, Tiny Animals
    {41687}, -- Snail Fight!
    {40278}, -- My Beasts's Bidding
    {41944}, -- Jarrun's Ladder
    {41895}, -- The Master of Pets
    {40337}, -- Flummoxed
    {41990}, -- Chopped
    {40279}, -- Training with Durian
    {41860}, -- Dealing with Satyrs
}

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'quest',
    achievementID = 11427, -- No Shellfish Endeavor
    questIDs = {
        {44943}, -- Now That's Just Clawful!
        {40230}, -- Oh, the Clawdacity!
        {45307}, -- Claws for Alarm!
    },
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 6,
    category = 'quest',
    achievementID = 11607, -- They See Me Rolling
    questID = 46175, -- Rolling Thunder
})

WQ:RegisterEntry({
    type = 'single',
    expansion = 6,
    category = 'quest',
    achievementID = 11681, -- Crate Expectations
    questID = 45559, -- Behind Enemy Portals
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pvp',
    achievementID = 11474, -- Free For All, More For Me
    questIDs = {
        {41896}, -- Operation Murloc Freedom
        {42025}, -- Bareback Brawl
        {42023}, -- Black Rook Rumble
        {41013}, -- Darkbrul Arena
    },
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9686, -- Aquatic Acquiescence
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9687, -- Best of the Beasts
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9688, -- Mousing Around
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9689, -- Dragons!
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9690, -- Ragnaros, Watch and Learn
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9691, -- Flock Together
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9692, -- Murlocs, Harpies, and Wolvar, Oh My!
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9693, -- Master of Magic
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9694, -- Roboteer
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 9695, -- The Lil' Necromancer
    questIDs = battlePetFamilyFamiliar,
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 6,
    category = 'pet',
    achievementID = 10876, -- Battle on the Broken Isles
    questIDs = {
        {42063}, -- Size Doesn't Matter
        {42165}, -- Azsuna Specimens
        {42146}, -- Dazed and Confused and Adorable
        {42159}, -- Training with the Nightwatchers
        {42148}, -- The Wine's Gone Bad
        {42154}, -- Help a Whelp
        {42442}, -- Fight Night: Amalia
        {40299}, -- Fight Night: Bodhi Sunwayver
        {41881}, -- Fight Night: Heliosus
        {40298}, -- Fight Night: Sir Galveston
        {41886}, -- Fight Night: Rats!
        {42062}, -- Fight Night: Stitches Jr. Jr.
        {40277}, -- Fight Night: Tiffany Nelson
        {40280}, -- Training with Bredda
        {40282}, -- Tiny Poacher, Tiny Animals
        {41766}, -- Wildlife Protection Force
        {42064}, -- It's Illid... Wait.
        {41687}, -- Snail Fight!
        {41624}, -- Rocko Needs a Shave
        {42067}, -- All Howl, No Bite
        {41944}, -- Jarrun's Ladder
        {41958}, -- Oh, Ominitron
        {40278}, -- My Beasts's Bidding
        {41948}, -- All Pets Go to Heaven
        {41935}, -- Beasts of Burden
        {41895}, -- The Master of Pets
        {41914}, -- Clear the Catacombs
        {41990}, -- Chopped
        {40337}, -- Flummoxed
        {42015}, -- Threads of Fate
        {41931}, -- Mana Tap
        {40279}, -- Training with Durian
        {41862}, -- Only Pets Can Prevent Forest Fires
        {41861}, -- Meet The Maw
        {41855}, -- Stand Up to Bullies
        {42190}, -- Wildlife Conservationist
        {41860}, -- Dealing with Satyrs
    },
})
