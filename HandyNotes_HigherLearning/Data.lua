local _, ns = ...
local points = ns.points
local pointsWrath = ns.pointsWrath
local textures = ns.textures
local scaling = ns.scaling
local language = ns.language

points[ns.dalaran] = {	-- Achievement ID, criteria ID, short title, tip
	[26505221] = { 4, 7239, "Divination", "divTip" },
	[30764591] = { 3, 7238, "Conjuration", "conjTip" },
	[43554671] = { 5, 7240, "Enchantment", "enchTip" },
	[46733904] = { 7, 7242, "Necromancy", "necroTip" },
	[46744012] = { 8, 7243, "Transmutation", "transTip" },
	[52325479] = { 2, 7237, "Abjuration", "abjTip" },
	[56684560] = { 1, 7236, "Introduction", "intTip" },
	[64435237] = { 6, 7241, "Illusion", "illTip" },
}

pointsWrath[ns.dalaran] = {	-- Achievement ID, criteria ID, short title, tip
	[26505221] = { 1, 7239, "Divination", "divTip" },
	[30764591] = { 2, 7238, "Conjuration", "conjTip" },
	[43554671] = { 7, 7240, "Enchantment", "enchTip" },
	[46733904] = { 5, 7242, "Necromancy", "necroTip" },
	[46744012] = { 8, 7243, "Transmutation", "transTip" },
	[52325479] = { 3, 7237, "Abjuration", "abjTip" },
	[56684560] = { 4, 7236, "Introduction", "intTip" },
	[64435237] = { 6, 7241, "Illusion", "illTip" },
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

scaling[1] = 0.85
scaling[2] = 0.85
scaling[3] = 0.83
scaling[4] = 0.83
scaling[5] = 0.83
scaling[6] = 0.83
scaling[7] = 0.95
scaling[8] = 0.95
scaling[9] = 1.2
scaling[10] = 1.2
