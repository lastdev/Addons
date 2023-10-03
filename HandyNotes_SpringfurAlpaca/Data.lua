local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local texturesSpecial = ns.texturesSpecial
local scalingSpecial = ns.scalingSpecial

	
points[ 249 ] = {
	[22004500] = { testUldum=true },	
}
points[ 1527 ] = {
	[14806160] = { alpaca=true },
	
	[23960988] = { alpaca=true },
	[24290855] = { alpaca=true },
	[24640898] = { alpaca=true },
	[24700971] = { alpaca=true },
	[24930956] = { alpaca=true },
	
	[28204900] = { alpaca=true },
	
	[30602860] = { alpaca=true },
	
	[38480909] = { alpaca=true },
	[38620969] = { alpaca=true },
	[38860892] = { alpaca=true },
	[38940974] = { alpaca=true },
	[39140890] = { alpaca=true },
	[39400940] = { alpaca=true },
	[38621018] = { alpaca=true },
	
	[42407030] = { alpaca=true },
	
	[46204830] = { alpaca=true },

	[52661855] = { alpaca=true },
	[52841952] = { alpaca=true },
	[53111960] = { alpaca=true },
	[53381903] = { alpaca=true },
	[53581844] = { alpaca=true },

	[55206973] = { alpaca=true },
	[55257005] = { alpaca=true },
	[55356983] = { alpaca=true },
	[55427013] = { alpaca=true },
	[55527039] = { alpaca=true },
	[55687063] = { alpaca=true },
	
	[63031444] = { alpaca=true },
	[63171418] = { alpaca=true },
	[63231551] = { alpaca=true },
	[63501544] = { alpaca=true },
	[63761502] = { alpaca=true },

	[63255255] = { alpaca=true },
	[63505250] = { alpaca=true },
	[63765217] = { alpaca=true },
		
	[69955796] = { alpaca=true },
	
	[69883949] = { alpaca=true },
	[69974005] = { alpaca=true },
	[70003925] = { alpaca=true },
	[70363963] = { alpaca=true },
	[70413862] = { alpaca=true },
	[70473911] = { alpaca=true },
	
	[76406780] = { alpaca=true },
	
	[57408500] = { gersahlGreens=true },
	[59008530] = { gersahlGreens=true },
	[61608290] = { gersahlGreens=true },
	[59107440] = { gersahlGreens=true },
	[59105930] = { gersahlGreens=true },
	[72207630] = { gersahlGreens=true },
	[71107880] = { gersahlGreens=true },
	[70007680] = { gersahlGreens=true },
	[64707940] = { gersahlGreens=true },
	[68907310] = { gersahlGreens=true },
	[64707250] = { gersahlGreens=true },
	[65006880] = { gersahlGreens=true },
	[60706020] = { gersahlGreens=true },
	[58504050] = { gersahlGreens=true },
	[51204430] = { gersahlGreens=true },
	[59607880] = { gersahlGreens=true },
	[58706580] = { gersahlGreens=true },
	[59305130] = { gersahlGreens=true },
	[56005120] = { gersahlGreens=true },
	[59603420] = { gersahlGreens=true },
	[59102880] = { gersahlGreens=true },
	[57302500] = { gersahlGreens=true },
	[57502000] = { gersahlGreens=true },
	[58601640] = { gersahlGreens=true },
	[61701360] = { gersahlGreens=true },
	[57804600] = { gersahlGreens=true },
	[63006440] = { gersahlGreens=true },
	[57805480] = { gersahlGreens=true },
	[54404630] = { gersahlGreens=true },
	[49303700] = { gersahlGreens=true },
	[50503620] = { gersahlGreens=true },
	[48803300] = { gersahlGreens=true },
	[47203020] = { gersahlGreens=true },
	[57601310] = { gersahlGreens=true },
	[56501560] = { gersahlGreens=true },
	[55901890] = { gersahlGreens=true },
	[55502390] = { gersahlGreens=true },
	[56802840] = { gersahlGreens=true },
	[58003190] = { gersahlGreens=true },
	[57703370] = { gersahlGreens=true },
	[56603490] = { gersahlGreens=true },
	[53503530] = { gersahlGreens=true },
	[50703190] = { gersahlGreens=true },
	[59508230] = { gersahlGreens=true },
	[67707730] = { gersahlGreens=true },
	[44102860] = { gersahlGreens=true },
	[42802730] = { gersahlGreens=true },
	[43602570] = { gersahlGreens=true },
	[47102750] = { gersahlGreens=true },
	[61807760] = { gersahlGreens=true },
	[65907600] = { gersahlGreens=true },
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
texturesSpecial[1] = "Interface\\Common\\RingBorder"
texturesSpecial[2] = "Interface\\PlayerFrame\\DeathKnight-Energize-Blood"
texturesSpecial[3] = "Interface\\PlayerFrame\\DeathKnight-Energize-Frost"
texturesSpecial[4] = "Interface\\PlayerFrame\\DeathKnight-Energize-Unholy"
texturesSpecial[5] = "Interface\\PetBattles\\DeadPetIcon"
texturesSpecial[6] = "Interface\\RaidFrame\\UI-RaidFrame-Threat"
texturesSpecial[7] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
texturesSpecial[8] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.65
scaling[8] = 0.63
scaling[9] = 0.75
scaling[10] = 0.75
scalingSpecial[1] = 0.38
scalingSpecial[2] = 0.5
scalingSpecial[3] = 0.5
scalingSpecial[4] = 0.5
scalingSpecial[5] = 0.46
scalingSpecial[6] = 0.45
scalingSpecial[7] = 0.41
scalingSpecial[8] = 0.6
