local _, ns = ...

ns.db = {}

-- ns.iconStandard is found at the foot of Localisations_Common - to avoid cyclical references

_, _, _, ns.version = GetBuildInfo()
ns.preAchievements = ( ns.version < 30000 ) and true or false -- Didn't have achievements prior to WotLK

ns.name = UnitName( "player" ) or "Character"
_, ns.class = UnitClass( "player" ) or "Unknown" -- Actually, I'm using the ClassFile name - it's all caps, no spaces. DEATHKNIGHT
ns.faction = UnitFactionGroup( "player" )

ns.questTypes = { "One Time", "Seasonal", "Weekly", "Daily", }
ns.questTypesDB = { "removeOneTime", "removeSeasonal", "removeWeekly", "removeDailies", }
ns.questColours = { ns.colour.oneTime, ns.colour.seasonal, ns.colour.weekly, ns.colour.daily, }

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
ns.scaling = {}
ns.scaling[1] = 0.4125
ns.scaling[2] = 0.4125
ns.scaling[3] = 0.4125
ns.scaling[4] = 0.4125
ns.scaling[5] = 0.4125
ns.scaling[6] = 0.4125
ns.scaling[7] = 0.4875
ns.scaling[8] = 0.4625
ns.scaling[9] = 0.5625
ns.scaling[10] = 0.5625
ns.pinSizeVersionFudge = ( ns.version > 100000 ) and 1.3 or 1

function ns.round( num, places ) -- round to nearest integer, fives round away from zero
	if num < 0 then
		return ceil( (num * 10^places) - .5 ) / 10^places
	end
	return floor( num * 10^places + .5 ) / 10^places
end