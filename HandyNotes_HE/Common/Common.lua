local _, ns = ...

_, _, _, ns.version = GetBuildInfo()
ns.preAchievements = ( ns.version < 30000 ) and true or false -- Didn't have achievements prior to WotLK

ns.name = UnitName( "player" ) or "Character"
_, ns.class = UnitClass( "player" ) or "Unknown" -- Actually, I'm using the ClassFile name - it's all caps, no spaces. DEATHKNIGHT
ns.faction = UnitFactionGroup( "player" )

ns.locale = GetLocale()

ns.textures = {}
ns.textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
ns.textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
ns.textures[3] = "Interface\\Common\\Indicator-Red"
ns.textures[4] = "Interface\\Common\\Indicator-Yellow"
ns.textures[5] = "Interface\\Common\\Indicator-Green"
ns.textures[6] = "Interface\\Common\\Indicator-Gray"
ns.textures[7] = "Interface\\Common\\Friendship-ManaOrb"	
ns.textures[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
ns.textures[9] = "Interface\\Store\\Category-icon-pets"
ns.textures[10] = "Interface\\Store\\Category-icon-featured"
ns.textures[11] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	
ns.textures[12] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
ns.textures[13] = "Interface\\TargetingFrame\\PetBadge-Magical"
ns.textures[14] = "Interface\\Vehicles\\UI-Vehicles-Raid-Icon"

ns.texturesBaseTotal = #ns.textures

ns.scaling = {}

ns.scaling[1] = 0.245
ns.scaling[2] = 0.245
ns.scaling[3] = 0.238
ns.scaling[4] = 0.238
ns.scaling[5] = 0.238
ns.scaling[6] = 0.238
ns.scaling[7] = 0.278
ns.scaling[8] = 0.281
ns.scaling[9] = 0.348
ns.scaling[10] = 0.348
ns.scaling[11] = 0.265
ns.scaling[12] = 0.19
ns.scaling[13] = 0.21
ns.scaling[14] = 0.21

ns.pinSizeVersionFudge = ( ns.version >= 100000 ) and 1 or 0.7