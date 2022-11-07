local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then return end
local DeathKnight = addonTable.DeathKnight;
local MaxDps = MaxDps;

local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local RunicPower = Enum.PowerType.RunicPower;
local Runes = Enum.PowerType.Runes;

local BL = {
	BloodBoil             	= 50842,
	Blooddrinker          	= 206931,
	BloodTap              	= 221699,
	BoneShield            	= 195181,
	Bonestorm             	= 194844,
	Consumption           	= 274156,
	CrimsonScourge        	= 81141,
	DancingRuneWeapon     	= 49028,
	DancingRuneWeaponBuff 	= 81256,
	DeathsCaress			= 195292,
	Heartbreaker          	= 221536,
	HeartStrike           	= 206930,
	Hemostasis            	= 273947,
	Marrowrend            	= 195182,
	RapidDecomposition    	= 194662,
	RelishInBlood         	= 317610,
	ShackleTheUnworthy    	= 312202,
	SwarmingMist          	= 311648,
	Tombstone             	= 219809,
};

setmetatable(BL, DeathKnight.spellMeta);

function DeathKnight:Blood()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local runes = DeathKnight:Runes(fd.timeShift);
	local runicPower = UnitPower('player', RunicPower);
	local targets = MaxDps:SmartAoe();
	local targetHpPercent = MaxDps:TargetPercentHealth() * 100;
	fd.targetHpPercent = targetHpPercent;
	
	fd.targets = targets;
	fd.runes = runes;
	fd.runicPower = runicPower;

	DeathKnight:BloodGlowCooldowns();
	
	if talents[COMMON.SoulReaper] and targetHpPercent <= 35 and cooldown[COMMON.SoulReaper].ready then
		return COMMON.SoulReaper;
	end

	if buff[BL.DancingRuneWeaponBuff].up then
		return DeathKnight:DancingRuneWeaponUp();
	end
	if not buff[BL.DancingRuneWeaponBuff].up then
		return DeathKnight:DancingRuneWeaponNotUp();
	end

end

function DeathKnight:DancingRuneWeaponUp()
	local fd = MaxDps.FrameData;
	local buff = fd.buff;
	local runicPower = fd.runicPower;
	local debuff = fd.debuff;
	local cooldown = fd.cooldown;
	local runes = fd.runes;
	
	if buff[BL.DancingRuneWeaponBuff].remains < 4 and buff[BL.BoneShield].remains < 20 then
		return BL.Marrowrend;
	end
	
	if not debuff[COMMON.DeathAndDecay].up and cooldown[COMMON.DeathAndDecay].ready then
		return COMMON.DeathAndDecay;
	end
	
	if buff[BL.BoneShield].count <= 2 then
		return BL.DeathsCaress;
	end
	
	if runicPower >= 75 or buff[COMMON.IcyTalons].remains < 3 then
		return COMMON.DeathStrike;
	end
	
	if cooldown[BL.BloodBoil].charges >= 2 then
		return BL.BloodBoil;
	end
	
	if runes >= 3 then
		return BL.HeartStrike;
	end
end

function DeathKnight:DancingRuneWeaponNotUp()
	local fd = MaxDps.FrameData;
	local buff = fd.buff;
	local runicPower = fd.runicPower;
	local debuff = fd.debuff;
	local cooldown = fd.cooldown;
	local runes = fd.runes;

	if buff[BL.BoneShield].remains < 4 then
		return BL.DeathsCaress;
	end
	if not buff[COMMON.DeathAndDecayBuff].up and cooldown[COMMON.DeathAndDecay].ready then
		return COMMON.DeathAndDecay;
	end
	
	if runes >= 2 and buff[BL.BoneShield].count <= 4 then
		return BL.Marrowrend;
	end
	
	if runes < 2 and buff[BL.BoneShield].count <= 4 then
		return BL.DeathsCaress;
	end
	
	if runicPower >= 75 or (buff[COMMON.IcyTalons].remains < 3 and runicPower >= 35) then
		return COMMON.DeathStrike;
	end
	
	if cooldown[BL.BloodBoil].charges >= 2 then
		return BL.BloodBoil;
	end
	
	if runes >= 3 then
		return BL.HeartStrike;
	end
end

function DeathKnight:BloodGlowCooldowns()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;

	local abominationLimbTalentReady = talents[COMMON.AbominationLimbTalent] and cooldown[COMMON.AbominationLimbTalent].ready;
	local dancingRuneWeaponReady = talents[BL.DancingRuneWeapon] and cooldown[BL.DancingRuneWeapon].ready;
	local boneStormReady = talents[BL.Bonestorm] and cooldown[BL.Bonestorm].ready;
	local empowerRuneweaponReady = talents[COMMON.EmpowerRuneWeapon] and cooldown[COMMON.EmpowerRuneWeapon].ready;

	if DeathKnight.db.alwaysGlowCooldowns then
		MaxDps:GlowCooldown(COMMON.AbominationLimbTalent, abominationLimbTalentReady);
		MaxDps:GlowCooldown(BL.Bonestorm, boneStormReady);
		MaxDps:GlowCooldown(COMMON.EmpowerRuneWeapon, empowerRuneweaponReady);
		MaxDps:GlowCooldown(BL.DancingRuneWeapon, dancingRuneWeaponReady);
	else
	--currently just glows as specific scenarios would need to be identified
		MaxDps:GlowCooldown(BL.Bonestorm, boneStormReady);
		MaxDps:GlowCooldown(COMMON.EmpowerRuneWeapon, empowerRuneweaponReady);
		MaxDps:GlowCooldown(COMMON.AbominationLimbTalent, abominationLimbTalentReady);
		MaxDps:GlowCooldown(BL.DancingRuneWeapon, dancingRuneWeaponReady);
	end
end