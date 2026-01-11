---@type InvasionTimer, table<string, string>
local IT, L = unpack((select(2, ...)))
local WQ = IT.WorldQuest

WQ:RegisterEntry({
    type = 'single',
    expansion = 9,
    category = 'quest',
    achievementID = 19293, -- Friends In Feathers
    questID = 78370, -- Claws for Concern
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 9,
    category = 'quest',
    achievementIDs = {
        19786, -- When a Rock is Just a Rock
    },
    questIDs = {
        78645, -- Excavation: Buried in the Riverbed
        78661, -- Excavation: Treasures in the Cliffside
        78663, -- Excavation: Scattered Around the Tower
    },
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 9,
    category = 'quest',
    achievementIDs = {
        19787, -- Clued In
        19792, -- Just One More Thing
    },
    questIDs = {
        77424, -- Research: Dracthyr of Forbidden Reach
        76587, -- Research: Centaur of Ohn'ahran Plains
        76734, -- Research: Djaradin of Zaralek Cavern
        76739, -- Research: Niffen of Zaralek Cavern
        76911, -- Research: Drakonid of Waking Shores
        77362, -- Research: Drakonid of Forbidden Reach
    },
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 9,
    category = 'quest',
    achievementID = 19791, -- Goggle Wobble
    questIDs = {
        {78820}, -- Technoscrying: The Mysteries of Igira's Watch
        {78931}, -- Technoscrying: The Mysteries of Dragonskull Island
        {78616}, -- Technoscrying: The Mysteries of the Concord Observatory
    },
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 9,
    category = 'reputation',
    achievementIDs = {
        16587, -- Lead Climber
        16625, -- Belay On!
        16588, -- How Did These Get Here?
        16591, -- The Gentleman Elemental
        16623, -- Toe Tension
    },
    questIDs = {
        70651, -- Stolen Luggage
        66070, -- Brightblade's Bones
        64768, -- Lightsprocket's Artifact Hunt
        70652, -- Take One Down, Pass It Around
        70660, -- High-Grade Minerals
        70655, -- Leaves from the Vine
        70653, -- Cold Hard Science
        70658, -- Artifact or Fiction
        70662, -- A Bone to Pickaxe
        70654, -- Are You Kitten Me?
        70661, -- Supplies on High
        70656, -- Not Mushroom For Error
    },
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 9,
    category = 'reputation',
    achievementID = 16600, -- Isles Ascender
    questIDs = {
        {
            70651, -- Stolen Luggage
            66070, -- Brightblade's Bones
            64768, -- Lightsprocket's Artifact Hunt
        },
        {
            70652, -- Take One Down, Pass It Around
            70660, -- High-Grade Minerals
            70655, -- Leaves from the Vine
        },
        {
            70653, -- Cold Hard Science
            70658, -- Artifact or Fiction
            70662, -- A Bone to Pickaxe
        },
        {
            70654, -- Are You Kitten Me?
            70661, -- Supplies on High
            70656, -- Not Mushroom For Error
        },
    },
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 9,
    category = 'reputation',
    achievementIDs = {
        16547, -- Pulled!
    },
    questIDs = {
        69938, -- Fishing Frenzy!
        70152, -- Fishing Frenzy!
        72022, -- Fishing Frenzy!
        72028, -- Fishing Frenzy!
        72029, -- Fishing Frenzy!
        72030, -- Fishing Frenzy!
    },
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 9,
    category = 'reputation',
    achievementID = 16560, -- Wildlife Photographer
    questIDs = {
        {70075, 70632}, -- Cataloging the Waking Shores
        {70659, 70079}, -- Cataloging the Ohn'ahran Plains
        {70100}, -- Cataloging the Azure Span
        {70110, 70699}, -- Cataloging Thaldraszus
    },
})

WQ:RegisterEntry({
    type = 'multiple',
    expansion = 9,
    category = 'reputation',
    achievementIDs = {
        16568, -- Great Shots Galore!
    },
    questIDs = {
        70075, -- Cataloging the Waking Shores
        70632, -- Cataloging the Waking Shores
        70100, -- Cataloging the Azure Span
        70659, -- Cataloging the Ohn'ahran Plains
        70110, -- Cataloging Thaldraszus
        70079, -- Cataloging the Ohn'ahran Plains
        70699, -- Cataloging Thaldraszus
    },
})

WQ:RegisterEntry({
    type = 'criteria',
    expansion = 9,
    category = 'reputation',
    achievementID = 16570, -- A Legendary Album
    questIDs = {
        {70075}, -- Cataloging the Waking Shores
        {70632}, -- Cataloging the Waking Shores
        {70100}, -- Cataloging the Azure Span
        {70659}, -- Cataloging the Ohn'ahran Plains
        {70110}, -- Cataloging Thaldraszus
        {70079}, -- Cataloging the Ohn'ahran Plains
        {70699}, -- Cataloging Thaldraszus
    },
})
