-- Copyright (c) 2015-2016, r. brian harrison.  All rights reserved.

local LIB_NAME = "InstanceLocations-1.0"
assert(LibStub, string.format("%s requires %s", LIB_NAME, "LibStub"))

-- inlined:
-- local MapMap = LibStub:GetLibrary("MapMap-1.0")
-- assert(MapMap, string.format("%s requires MapMap-1.0", LIB_NAME))

local InstanceLocations = LibStub:NewLibrary(LIB_NAME, 1)
if not InstanceLocations then return end


InstanceLocations.instances = {
    AhnQiraj                   = {"AhnQirajTheFallenKingdom", 0.468, 0.075},
    Ahnkahet                   = {"Dragonblight",             0.284, 0.517},
    AshranAllianceFactionHub   = {"Ashran",                   0.375, 0.917},
    AshranHordeFactionHub      = {"Ashran",                   0.407, 0.108},
    AuchenaiCrypts             = {"TerokkarForest",           0.344, 0.656},
    AzjolNerub                 = {"Dragonblight",             0.260, 0.509},
    BaradinHold                = {"TolBarad"},                -- XXX
    BlackTemple                = {"ShadowmoonValley",         0.710, 0.465},
    BlackfathomDeeps           = {"Ashenvale",                0.165, 0.110},
    BlackrockCaverns           = {"BurningSteppes",           0.273, 0.279},
    BlackrockDepths            = {"BurningSteppes",           0.145, 0.092},
    BlackrockSpire             = {"BurningSteppes",           0.276, 0.254},
    BlackrockTrainDepotDungeon = {"Gorgrond",                 0.550, 0.313},
    BlackwingDescent           = {"BurningSteppes",           0.231, 0.264},
    BlackwingLair              = {"BurningSteppes",           0.239, 0.322},
    CoTHillsbradFoothills      = {"Tanaris",                  0.554, 0.536},
    CoTMountHyjal              = {"Tanaris",                  0.570, 0.500},
    CoTStratholme              = {"Tanaris",                  0.609, 0.621},
    CoTTheBlackMorass          = {"Tanaris",                  0.571, 0.623},
    CoilfangReservoir          = {"Zangarmarsh",              0.519, 0.328},
    Dalaran                    = {"CrystalsongForest",        0.270, 0.360},
    Darnassus                  = {"Teldrassil",               0.291, 0.494},
    DireMaul                   = {"Feralas",                  0.625, 0.249},
    DraenorAuchindoun          = {"Talador",                  0.463, 0.740},
    DragonSoul                 = {"Tanaris",                  0.617, 0.519},
    DrakTharonKeep             = {"ZulDrak",                  0.286, 0.869},
    EastTemple                 = {"TheJadeForest",            0.562, 0.579},
    EndTime                    = {"Tanaris",                  0.610, 0.525},
    Firelands                  = {"Hyjal",                    0.473, 0.781},
    FoundryRaid                = {"Gorgrond",                 0.516, 0.272},
    Gnomeregan                 = {"DunMorogh",                0.253, 0.369},
    GrimBatol                  = {"TwilightHighlands",        0.192, 0.540},
    GruulsLair                 = {"BladesEdgeMountains",      0.693, 0.237},
    Gundrak                    = {"ZulDrak",                  0.763, 0.212},
    HallsofLightning           = {"TheStormPeaks",            0.453, 0.214},
    HallsofOrigination         = {"Uldum",                    0.691, 0.529},
    HallsofReflection          = {"IcecrownGlacier",          0.553, 0.908},
    HeartofFear                = {"DreadWastes",              0.389, 0.350},
    HellfireRaid               = {"TanaanJungle",             0.456, 0.536},
    HellfireRamparts           = {"Hellfire",                 0.477, 0.536},
    HighmaulRaid               = {"NagrandDraenor",           0.330, 0.384},
    HourofTwilight             = {"Tanaris",                  0.626, 0.524},
    IcecrownCitadel            = {"IcecrownGlacier",          0.538, 0.871},
    IronDocks                  = {"Gorgrond",                 0.454, 0.135},
    Ironforge                  = {"DunMorogh",                0.607, 0.330},
    Karazhan                   = {"DeadwindPass",             0.470, 0.750},
    LostCityofTolvir           = {"Uldum",                    0.605, 0.642},
    MagistersTerrace           = {"Sunwell",                  0.612, 0.309},
    MagtheridonsLair           = {"Hellfire",                 0.475, 0.521},
    ManaTombs                  = {"TerokkarForest",           0.396, 0.577},
    Maraudon                   = {"Desolace",                 0.287, 0.629},
    MogushanPalace             = {"ValeofEternalBlossoms",    0.807, 0.329},
    MogushanVaults             = {"KunLaiSummit",             0.596, 0.392},
    MoltenCore                 = {"BurningSteppes",           0.182, 0.249},
    Naxxramas                  = {"Dragonblight",             0.870, 0.510},
    Nexus80                    = {"BoreanTundra",             0.275, 0.266},
    OgreMines                  = {"FrostfireRidge",           0.498, 0.247},
    OnyxiasLair                = {"Dustwallow",               0.526, 0.767},
    Orgrimmar                  = {"Durotar",                  0.455, 0.119},
    OrgrimmarRaid              = {"ValeofEternalBlossoms",    0.740, 0.421},
    OvergrownOutpost           = {"Gorgrond",                 0.596, 0.455},
    PitofSaron                 = {"IcecrownGlacier",          0.548, 0.917},
    Ragefire                   = {"Orgrimmar",                0.525, 0.580},
    RazorfenDowns              = {"ThousandNeedles",          0.476, 0.236},
    RazorfenKraul              = {"SouthernBarrens",          0.408, 0.945},
    RuinsofAhnQiraj            = {"AhnQirajTheFallenKingdom", 0.589, 0.143},
    ScarletHalls               = {"Tirisfal",                 0.853, 0.322},
    ScarletMonastery           = {"Tirisfal",                 0.849, 0.306},
    Scholomance                = {"WesternPlaguelands",       0.691, 0.730},
    SethekkHalls               = {"TerokkarForest",           0.449, 0.656},
    ShadowLabyrinth            = {"TerokkarForest",           0.396, 0.735},
    ShadowfangKeep             = {"Silverpine",               0.448, 0.678},
    ShadowmoonDungeon          = {"ShadowmoonValleyDR",       0.319, 0.426},
    ShadowpanHideout           = {"KunLaiSummit",             0.367, 0.475},
    ShattrathCity              = {"TerokkarForest",           0.309, 0.229},
    --ShrineofSevenStars         = {"ValeofEternalBlossoms"},   -- XXX
    --ShrineofTwoMoons           = {"ValeofEternalBlossoms"},   -- XXX
    SiegeofNiuzaoTemple        = {"TownlongWastes",           0.347, 0.814},
    SilvermoonCity             = {"EversongWoods",            0.567, 0.494},
    Skywall                    = {"Uldum",                    0.767, 0.844},
    SpiresofArakDungeon        = {"SpiresOfArak",             0.356, 0.336},
    StormstoutBrewery          = {"ValleyoftheFourWinds",     0.361, 0.691},
    StormwindCity              = {"Elwynn",                   0.317, 0.486},
    Stratholme                 = {"EasternPlaguelands",       0.277, 0.116},
    SunwellPlateau             = {"Sunwell",                  0.443, 0.456},
    TempestKeep                = {"Netherstorm",              0.737, 0.637},
    TerraceOfEndlessSpring     = {"TheHiddenPass",            0.484, 0.614},
    TheArcatraz                = {"Netherstorm",              0.744, 0.577},
    TheArgentColiseum          = {"IcecrownGlacier",          0.751, 0.218},
    TheArgentColiseum          = {"IcecrownGlacier",          0.751, 0.218},
    TheBastionofTwilight       = {"TwilightHighlands",        0.339, 0.780},
    TheBloodFurnace            = {"Hellfire",                 0.460, 0.518},
    TheBotanica                = {"Netherstorm",              0.717, 0.551},
    TheDeadmines               = {"Westfall",                 0.383, 0.775},
    TheExodar                  = {"AzuremystIsle",            0.262, 0.457},
    TheEyeofEternity           = {"BoreanTundra",             0.275, 0.268},
    TheForgeofSouls            = {"IcecrownGlacier",          0.549, 0.898},
    TheGreatWall               = {"ValeofEternalBlossoms",    0.158, 0.744},
    TheMechanar                = {"Netherstorm",              0.706, 0.697},
    TheNexus                   = {"BoreanTundra",             0.275, 0.260},
    TheObsidianSanctum         = {"Dragonblight",             0.600, 0.569},
    TheRubySanctum             = {"Dragonblight",             0.613, 0.527},
    TheShatteredHalls          = {"Hellfire",                 0.476, 0.520},
    TheSlavePens               = {"Zangarmarsh",              0.490, 0.359},
    TheSteamvault              = {"Zangarmarsh",              0.504, 0.333},
    TheStockade                = {"StormwindCity",            0.506, 0.666},
    TheStonecore               = {"Deepholm",                 0.475, 0.520},
    TheTempleOfAtalHakkar      = {"SwampOfSorrows",           0.760, 0.452},
    TheUnderbog                = {"Zangarmarsh",              0.542, 0.345},
    ThroneofTides              = {"VashjirDepths",            0.695, 0.250},
    ThroneoftheFourWinds       = {"Uldum",                    0.384, 0.806},
    ThunderBluff               = {"Mulgore",                  0.382, 0.338},
    ThunderKingRaid            = {"IsleoftheThunderKing",     0.520, 0.450},
    Uldaman                    = {"Badlands",                 0.343, 0.103},
    Ulduar                     = {"TheStormPeaks",            0.416, 0.178},
    Ulduar77                   = {"TheStormPeaks",            0.397, 0.269},
    Undercity                  = {"Tirisfal",                 0.618, 0.695},
    UpperBlackrockSpire        = {"BurningSteppes",           0.273, 0.238},
    UtgardeKeep                = {"HowlingFjord",             0.573, 0.468},
    UtgardePinnacle            = {"HowlingFjord",             0.572, 0.466},
    VaultofArchavon            = {"LakeWintergrasp"},         -- XXX
    VioletHold                 = {"Dalaran",                  0.683, 0.700},
    WailingCaverns             = {"Barrens",                  0.551, 0.659},
    WellofEternity             = {"Tanaris",                  0.546, 0.588},
    ZulAman                    = {"Ghostlands",               0.823, 0.644},
    ZulFarrak                  = {"Tanaris",                  0.392, 0.213},
    ZulGurub                   = {"StranglethornJungle",      0.722, 0.329},
}

InstanceLocations.below = {}

for mapFile, projection in pairs(InstanceLocations.instances) do
    local parentMapFile = projection[1]
    local below = InstanceLocations.below[parentMapFile]
    if not below then
        below = {}
        InstanceLocations.below[parentMapFile] = below
    end
    table.insert(below, mapFile)
end


function InstanceLocations:GetLocation(mapFile)
    return self.instances[mapFile]
end


function InstanceLocations:BuildNumericTable()
    if not self.instancesByID then
        self.instancesByID = {}
        local MapMap = LibStub("MapMap-1.0")
        assert(MapMap, string.format("%s requires %s", LIB_NAME, "MapMap-1.0"))
        MapMap:Survey()
        for mapFile, data in pairs(self.instances) do
            local mapID = MapMap.mapFileToID[mapFile]
            assert(mapID, string.format("mapFile %s has no id", mapFile))
            local numericData = {MapMap.mapFileToID[data[1]], data[2], data[3]}
            self.instancesByID[mapID] = numericData
        end
    end
end


function InstanceLocations:GetLocationByID(mapID)
    self:BuildNumericTable()
    return self.instancesByID[mapID]
end


function InstanceLocations:GetBelow(mapFile)
    return self.below[mapFile]
end
