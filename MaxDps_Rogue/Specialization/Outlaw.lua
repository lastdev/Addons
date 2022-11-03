local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then
	return
end

local MaxDps = MaxDps;
local Rogue = addonTable.Rogue;

local OL = {
	AdrenalineRush			= 13750,
	Ambush					= 8676,
	BetweenTheEyes			= 315341,
	BladeFlurry				= 13877,
	BladeRush				= 271877,
	Broadside				= 193356,
	BuriedTreasure			= 199600,
	Deadshot				= 272940,
	DeeperStratagem			= 193531,
	DirtyTricks				=108216,
	Dispatch				= 2098,
	Dreadblades				= 343142,
	EchoingReprimandTalent	= 385616,
	EchoingReprimandCovenant= 323547,
	Flagellation 			= 323654,
	GhostlyStrike			= 196937,
	Gouge					= 1776,
	GrandMelee				= 193358,
	InstantPoison			= 315584,
	KeepYourWitsAboutYou	= 288988,
	KillingSpree			= 51690,
	LoadedDice				= 256170,
	MarkedForDeath			= 137619,
	Opportunity				= 195627,
	PistolShot				= 185763,
	QuickDraw				= 196938,
	RollTheBones			= 315508,
	RuthlessPrecision		= 193357,
	Sepsis					= 328305,
	SepsisAura				= 347037,
	SerratedBoneSpear		= 328547,
	SerratedBoneSpearAura	= 324073,
	SinisterStrike			= 193315,
	SkullAndCrossbones		= 199603,
	SliceAndDice			= 315496,
	SnakeEyes				= 275863,
	Stealth					= 1784,
	StealthAura				= 1784,
	TrueBearing				= 193359,
	Vanish					= 1856,
	VanishAura				= 11327
};

local RTB = {
	Broadside			=	193356,
	BuriedTreasure		=	199600,
	GrandMelee			=	193358,
	RuthlessPrecision	=	193357,
	SkullAndCrossbones	=	199603,
	TrueBearing			=	193359
};

local CN = {
	None      = 0,
	Kyrian    = 1,
	Venthyr   = 2,
	NightFae  = 3,
	Necrolord = 4
};

setmetatable(OL, Rogue.spellMeta);

function Rogue:Outlaw()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local timeToDie = fd.timeToDie;
	local targets = MaxDps:SmartAoe();
	local comboPoints = UnitPower('player', 4);
	local comboPointsMax = UnitPowerMax('player', 4);
	local comboPointsDeficit = comboPointsMax - comboPoints;
	local energy = UnitPower('player', 3);
	local energyMax = UnitPowerMax('player', 3);
	local inCombat = UnitAffectingCombat("player");
	local stealthed = IsStealthed();
	
	--RTB Tracker
	local rollTheBonesBuffCount = 0;
	if buff[OL.SkullAndCrossbones].up then rollTheBonesBuffCount = rollTheBonesBuffCount + 1; end
	if buff[OL.TrueBearing].up        then rollTheBonesBuffCount = rollTheBonesBuffCount + 2; end
	if buff[OL.RuthlessPrecision].up  then rollTheBonesBuffCount = rollTheBonesBuffCount + 1; end
	if buff[OL.GrandMelee].up         then rollTheBonesBuffCount = rollTheBonesBuffCount + 1; end
	if buff[OL.BuriedTreasure].up     then rollTheBonesBuffCount = rollTheBonesBuffCount + 1; end
	if buff[OL.Broadside].up          then rollTheBonesBuffCount = rollTheBonesBuffCount + 2; end
	
	local RTB_Reroll = rollTheBonesBuffCount < 2;
	
	local RTB_VanishTracker = false;
	if buff[OL.SkullAndCrossbones].remains > 10 then RTB_VanishTracker = true; end
	if buff[OL.TrueBearing].remains > 10 		then RTB_VanishTracker = true; end
	if buff[OL.RuthlessPrecision].remains > 10 	then RTB_VanishTracker = true; end
	if buff[OL.GrandMelee].remains > 10 		then RTB_VanishTracker = true; end
	if buff[OL.BuriedTreasure].remains > 10 	then RTB_VanishTracker = true; end
	if buff[OL.Broadside].remains > 10 			then RTB_VanishTracker = true; end
	
	fd.RTB_Reroll, fd.RTB_VanishTracker = RTB_Reroll, RTB_VanishTracker;
	
	MaxDps:GlowCooldown(OL.Dreadblades, talents[OL.Dreadblades] and cooldown[OL.Dreadblades].ready and not buff[OL.Dreadblades].up);
	MaxDps:GlowCooldown(OL.AdrenalineRush, cooldown[OL.AdrenalineRush].ready and not buff[OL.AdrenalineRush].up);
	MaxDps:GlowCooldown(OL.Vanish, cooldown[OL.Vanish].ready and energy >= 50 and ((comboPoints <= comboPointsMax - 2 and not buff[OL.Broadside].up) or (buff[OL.Broadside].up and comboPoints <= comboPointsMax - 3)) and RTB_VanishTracker);

	
	if not inCombat and buff[OL.InstantPoison].remains < 600 and not stealthed and not buff[OL.VanishAura].up then
		return OL.InstantPoison;
	end
	
	if not inCombat and not stealthed and cooldown[OL.Stealth].ready and not buff[OL.VanishAura].up then
		return OL.Stealth;
	end
	
	if cooldown[OL.RollTheBones].ready and rollTheBonesBuffCount == 0 then
		return OL.RollTheBones;
	end
	
	if not inCombat and cooldown[OL.MarkedForDeath].ready and talents[OL.MarkedForDeath] and comboPoints <= 1 and buff[OL.SliceAndDice].remains < 2 then
		return OL.MarkedForDeath;
	end
	
	--actions+=/run_action_list,name=stealth,if=stealthed.all
	if stealthed or buff[OL.VanishAura].up then
		return Rogue:OutlawStealth();
	end
	
	--actions+=/call_action_list,name=cds
	local result = Rogue:OutlawCooldown();
	if result then
		return result;
	end
	--actions+=/run_action_list,name=finish,if=variable.finish_condition
	if comboPoints == comboPointsMax or (buff[OL.Broadside].up and comboPoints == comboPointsMax - 1) then
		return Rogue:OutlawFinisher();
	end
	--actions+=/call_action_list,name=build
	return Rogue:OutlawBuilder();
end

function Rogue:OutlawStealth()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local comboPoints = UnitPower('player', 4);
	local comboPointsMax = UnitPowerMax('player', 4);
	
	--Use SliceAndDice if you've used MarkedForDeath and SliceAndDice isn't up (This should only happen when out of combat)
	if cooldown[OL.SliceAndDice].ready and buff[OL.SliceAndDice].remains < 2 and comboPoints == comboPointsMax then
		return OL.SliceAndDice;
	end

	if comboPoints == comboPointsMax or (buff[OL.Broadside].up and comboPoints == comboPointsMax - 1) then
		return OL.Dispatch;
	end
	
	return OL.Ambush;
end

function Rogue:OutlawCooldown()
	local fd = MaxDps.FrameData;
	local timeToDie = fd.timeToDie;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local RTB_Reroll = fd.RTB_Reroll;
	local RTB_VanishTracker = fd.RTB_VanishTracker;
	local comboPoints = UnitPower('player', 4);
	local comboPointsMax = UnitPowerMax('player', 4);
	local targets = MaxDps:SmartAoe();
	local energy = UnitPower('player', 3);
	local energyMax = UnitPowerMax('player', 3);
	local energyRegen = GetPowerRegen();
	local energyTimeToMax = (energyMax - energy) / energyRegen;
	local threatStatus = UnitThreatSituation("player", "target");
	
	if cooldown[OL.BladeFlurry].ready and targets >= 2 and not buff[OL.BladeFlurry].up then
		return OL.BladeFlurry;
	end
	
	if cooldown[OL.RollTheBones].ready and RTB_Reroll then
		return OL.RollTheBones;
	end
	
	if cooldown[OL.MarkedForDeath].ready and talents[OL.MarkedForDeath] and (comboPoints <= 1 or timeToDie <= 2) then
		return OL.MarkedForDeath;
	end
	
	if talents[OL.KillingSpree] and cooldown[OL.KillingSpree].ready and comboPoints <= 1 then
		return OL.KillingSpree;
	end
	
	if talents[OL.BladeRush] and cooldown[OL.BladeRush].ready and (targets > 2 or energyTimeToMax > 2 or energy <= 30) then
		return OL.BladeRush;
	end
end

function Rogue:OutlawFinisher()
	local fd = MaxDps.FrameData;
	local timeToDie = fd.timeToDie;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local targets = MaxDps:SmartAoe();
	local covenantId = fd.covenant.covenantId;
	
	if cooldown[OL.SliceAndDice].ready and buff[OL.SliceAndDice].remains < 6 and (buff[OL.SliceAndDice].remains < timeToDie or targets > 1) then
		return OL.SliceAndDice;
	end
	
	if covenantId == CN.Venthyr and cooldown[OL.Flagellation].ready then
		return OL.Flagellation;
	end
	
	if cooldown[OL.BetweenTheEyes].ready and timeToDie > 3 then
		return OL.BetweenTheEyes;
	end
	
	return OL.Dispatch;
end

function Rogue:OutlawBuilder()
	local fd = MaxDps.FrameData;
	local timeToDie = fd.timeToDie;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local energy = UnitPower('player', 3);
	local energyMax = UnitPowerMax('player', 3);
	local energyRegen = GetPowerRegen();
	local energyTimeToMax = (energyMax - energy) / energyRegen;
	local targets = MaxDps:SmartAoe();
	local covenantId = fd.covenant.covenantId;
	
	if covenantId == CN.NightFae and cooldown[OL.Sepsis].ready then
		return OL.Sepsis;
	end
	
	if talents[OL.GhostlyStrike] and cooldown[OL.GhostlyStrike].ready and energy >= 30 then
		return OL.GhostlyStrike;
	end
	
	if talents[OL.EchoingReprimandTalent] and cooldown[OL.EchoingReprimandTalent].ready then
		return OL.EchoingReprimandTalent;
	end
	
	if not talents[OL.EchoingReprimandTalent] and covenantId == CN.Kyrian and cooldown[OL.EchoingReprimandCovenant].ready then
		return OL.EchoingReprimandCovenant;
	end
	
	if covenantId == CN.Necrolord and energy >= 15 and cooldown[OL.SerratedBoneSpear].charges >= 1 and 
		((buff[OL.SliceAndDice].up and not debuff[OL.SerratedBoneSpearAura].up) or cooldown[OL.SerratedBoneSpear].charges > 2.75 or (targets == 1 and timeToDie <= 5))
	then
		return OL.SerratedBoneSpear;
	end
	
	if buff[OL.Opportunity].up and energy <= (energyMax - (10 + energyRegen)) then
		return OL.PistolShot;
	end
	
	if energy >= 45 then
		return OL.SinisterStrike;
	end
	
	if cooldown[OL.Gouge].ready and talents[OL.DirtyTricks] then
		return OL.Gouge;
	end
end
