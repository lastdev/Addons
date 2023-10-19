local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local language = ns.language

points[ 125 ] = {	-- Achievement ID, criteria ID, short title, tip
	[26505221] = { aIndexR=4, aIndexC=1, 7239, shortTitle="Divination", tip="divTip" },
	[30764591] = { aIndexR=3, aIndexC=2, 7238, shortTitle="Conjuration", tip="conjTip" },
	[43554671] = { aIndexR=5, aIndexC=7, 7240, shortTitle="Enchantment", tip="enchTip" },
	[46733904] = { aIndexR=7, aIndexC=5, 7242, shortTitle="Necromancy", tip="necroTip" },
	[46744012] = { aIndexR=8, aIndexC=8, 7243, shortTitle="Transmutation", tip="transTip" },
	[52325479] = { aIndexR=2, aIndexC=3, 7237, shortTitle="Abjuration", tip="abjTip" },
	[56684560] = { aIndexR=1, aIndexC=4, 7236, shortTitle="Introduction", tip="intTip" },
	[64435237] = { aIndexR=6, aIndexC=6, 7241, shortTitle="Illusion", tip="illTip" },
}

-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've copied my scaling factors from my old AddOn
-- in order to homogenise the sizes. I should also allow for non-uniform origin placement as well as adjust the x,y offsets
textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
textures[3] = "Interface\\Common\\Indicator-Red"
textures[4] = "Interface\\Common\\Indicator-Yellow"
textures[5] = "Interface\\Common\\Indicator-Green"
textures[6] = "Interface\\Common\\Indicator-Gray"
textures[7] = "Interface\\Common\\Friendship-ManaOrb"	
textures[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
textures[9] = "Interface\\Store\\Category-icon-pets"
textures[10] = "Interface\\Store\\Category-icon-featured"

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.65
scaling[8] = 0.62
scaling[9] = 0.75
scaling[10] = 0.75
