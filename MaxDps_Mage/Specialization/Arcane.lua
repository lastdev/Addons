local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then return end
-- Build string = B4DAAAAAAAAAAAAAAAAAAAAAAIJQolIhkUAJtEiIikIhEaBSLJAAAAAAAAAAAAJJJJhkkkcAA

local Mage = addonTable.Mage;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local fd;
local spellHistory;
local cooldown;
local buff;
local debuff;
local spellHistory;
local talents;
local targets;
local gcd;
local aoeTargetCount;
local mana;
local maxMana;
local manaPct;
local targetHp;
local chargeCount;
local spellHaste;
local conserveMana;
local phase;

local AR = {
	ArcaneIntellect = 1459,
	ArcaneFamiliar = 205022,
	ConjureManaGem = 759,
	MirrorImage = 55342,
	ArcaneBlast = 30451,
	SiphonStorm = 384187,
	Evocation = 12051,
	TimeWarp = 80353,
	TemporalWarp = 386539,
	ArcaneSurge = 365350,
	ArcaneOrb = 153626,
	ArcaneCharge = 36032,
	RuneOfPower = 116011,
	RadiantSpark = 376103,
	RadiantSparkStacks = 376104,
	TouchOfTheMagi = 321507,
	CascadingPower = 384276,
	ClearcastingOld = 79684,
	Clearcasting = 263725,
	ShiftingPower = 382440,
	IceNova = 157997,
	NetherTempest = 114923,
	ArcaneMissiles = 5143,
	ArcaneHarmony = 384452,
	ArcaneHarmonyBuff = 384455,
	ArcaneBarrage = 44425,
	ArcaneEcho = 342231,
	PresenceOfMind = 205025,
	Meteor = 153561,
	ArcaneBombardment = 384581,
	Concentration = 384374,
	NetherPrecision = 383782,
	ArcaneExplosion = 1449
};
local A = {
};

function Mage:SpellReady(spellId)
	spellKnown = IsSpellKnownOrOverridesKnown(spellId);
	cooldownReady = cooldown[spellId].ready;

	if spellKnown and cooldownReady then
		return true
	end

	return false
end

function Mage:Arcane()
	fd = MaxDps.FrameData;
	spellHistory = fd.spellHistory;
	cooldown = fd.cooldown;
	buff = fd.buff;
	debuff = fd.debuff;
	spellHistory = fd.spellHistory;
	talents = fd.talents;
	targets = MaxDps:SmartAoe();
	gcd = fd.gcd;
	aoeTargetCount = 2;
	chargeCount = UnitPower('player', Enum.PowerType.ArcaneCharges)
	mana = UnitPower('player', Enum.PowerType.Mana)
	maxMana = UnitPowerMax('player', Enum.PowerType.Mana);
	manaPct = mana / maxMana;
	targetHp = MaxDps:TargetPercentHealth();
	spellHaste = MaxDps:AttackHaste()
	conserveMana = 0;

	if phase == nil then
		phase = 0;
	end

	if Mage:SpellReady(AR.TimeWarp) then
		MaxDps:GlowCooldown(AR.TimeWarp, true);
	end

	if Mage:SpellReady(AR.TemporalWarp) then
		MaxDps:GlowCooldown(AR.TemporalWarp, true);
	end

	if not Mage:SpellReady(AR.TouchOfTheMagi) and not debuff[AR.TouchOfTheMagi].up then
		phase = 0;
	end

	if phase > 0 or (Mage:SpellReady(AR.TouchOfTheMagi) and Mage:SpellReady(AR.RuneOfPower) and Mage:SpellReady(AR.RadiantSpark)  and (chargeCount == 4 or (chargeCount >= 2 and Mage:SpellReady(AR.ArcaneOrb)))) then
		if phase == 1 or ( Mage:SpellReady(AR.Evocation) and Mage:SpellReady(AR.ArcaneSurge) )then
			phase = 1;
			if targets >= 3 then
				-- print("burn phase multi")
				return Mage:BurnPhaseMulti();
			else
				-- print("burn phase")
				return Mage:BurnPhase();
			end

		else
			phase = 2;
			if targets >= 3 then
				-- print("mini burn phase multi")
				return Mage:MiniBurnPhaseMulti()
			else
				-- print("mini burn phase")
				return Mage:MiniBurnPhase()
			end

		end
	end

	if targets >= 3 then
		-- print("conserve phase multi")
		return Mage:ConservePhaseMulti()
	else
		-- print("conserve phase")
		return Mage:ConservePhase()
	end


end

function Mage:BurnPhase()
	if Mage:SpellReady(AR.Evocation) then
		return AR.Evocation;
	end
	if talents[AR.ArcaneHarmony] and buff[AR.ArcaneHarmonyBuff].count < 20 then
		return AR.ArcaneMissiles;
	end
	if Mage:SpellReady(AR.ArcaneOrb) then
		return AR.ArcaneOrb;
	end
	if Mage:SpellReady(AR.RuneOfPower) then
		return AR.RuneOfPower;
	end
	if Mage:SpellReady(AR.RadiantSpark) then
		return AR.RadiantSpark;
	end
	if debuff[AR.RadiantSpark].up and debuff[AR.RadiantSparkStacks].count < 3 then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.ArcaneSurge) then
		return AR.ArcaneSurge;
	end
	if Mage:SpellReady(AR.NetherTempest) and debuff[AR.NetherTempest].refreshable then
		return AR.NetherTempest;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.TimeWarp].up then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and buff[AR.RadiantSpark].up then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.TouchOfTheMagi) then
		return AR.TouchOfTheMagi;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.NetherPrecision].up then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.ArcaneMissiles) and buff[AR.Clearcasting].up then
		return AR.ArcaneMissiles;
	end
	if talents[AR.CascadingPower] and manaPct < 85 and cooldown[AR.UseManaGem].ready then
		return AR.UseManaGem;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and targetHp < 35 then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.ArcaneBlast) then
		return AR.ArcaneBlast;
	end
	--if Mage:SpellReady(AR.ArcaneBarrage) then -- as last global
	--	return AR.ArcaneBarrage;
	--end
end

function Mage:MiniBurnPhase()

	if talents[AR.ArcaneHarmony] and buff[AR.ArcaneHarmonyBuff].count < 20 then
		return AR.ArcaneMissiles;
	end
	if Mage:SpellReady(AR.ArcaneOrb) then
		return AR.ArcaneOrb;
	end
	if Mage:SpellReady(AR.RuneOfPower) then
		return AR.RuneOfPower;
	end
	if Mage:SpellReady(AR.RadiantSpark) then
		return AR.RadiantSpark;
	end
	if debuff[AR.RadiantSpark].up and debuff[AR.RadiantSparkStacks].count < 3 then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.NetherTempest) and debuff[AR.NetherTempest].refreshable then
		return AR.NetherTempest;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.TimeWarp].up then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and buff[AR.RadiantSpark].up then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.TouchOfTheMagi) then
		return AR.TouchOfTheMagi;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.NetherPrecision].up then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.ArcaneMissiles) and buff[AR.Clearcasting].up then
		return AR.ArcaneMissiles;
	end
	if talents[AR.CascadingPower] and manaPct < 85 and cooldown[AR.UseManaGem].ready then
		return AR.UseManaGem;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and targetHp < 35 then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.ArcaneBlast) then
		return AR.ArcaneBlast;
	end
end

function Mage:ConservePhase()
	if Mage:SpellReady(AR.ArcaneOrb) and chargeCount < 4 then
		return AR.ArcaneOrb;
	end
	if Mage:SpellReady(AR.ShiftingPower) then
		return AR.ShiftingPower;
	end
	if Mage:SpellReady(AR.ArcaneMissiles) and buff[AR.Clearcasting].count > 2 then
		return AR.ArcaneMissiles;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.NetherPrecision].up then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.ArcaneMissiles) and buff[AR.Clearcasting].count > 0 then
		return AR.ArcaneMissiles;
	end
	if Mage:SpellReady(AR.NetherTempest) and debuff[AR.NetherTempest].refreshable and chargeCount == 4 then
		return AR.NetherTempest;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and chargeCount == 4 and manaPct < 60 then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.ArcaneBlast) then
		return AR.ArcaneBlast;
	end
end

function Mage:BurnPhaseMulti()
	if Mage:SpellReady(AR.Evocation) then
		return AR.Evocation;
	end
	if talents[AR.ArcaneHarmony] and buff[AR.ArcaneHarmonyBuff].count < 20 then
		return AR.ArcaneMissiles;
	end
	if Mage:SpellReady(AR.ArcaneOrb) then
		return AR.ArcaneOrb;
	end
	if Mage:SpellReady(AR.RuneOfPower) then
		return AR.RuneOfPower;
	end
	if Mage:SpellReady(AR.RadiantSpark) then
		return AR.RadiantSpark;
	end
	if debuff[AR.RadiantSpark].up and debuff[AR.RadiantSparkStacks].count < 3 then
		return AR.ArcaneExplosion;
	end
	if Mage:SpellReady(AR.ArcaneSurge) then
		return AR.ArcaneSurge;
	end
	if Mage:SpellReady(AR.NetherTempest) and debuff[AR.NetherTempest].refreshable then
		return AR.NetherTempest;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.TimeWarp].up then
		return AR.ArcaneExplosion;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and buff[AR.RadiantSpark].up then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.TouchOfTheMagi) then
		return AR.TouchOfTheMagi;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.NetherPrecision].up then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.ArcaneMissiles) and buff[AR.Clearcasting].up then
		return AR.ArcaneExplosion;
	end
	if talents[AR.CascadingPower] and manaPct < 85 and cooldown[AR.UseManaGem].ready then
		return AR.UseManaGem;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and targetHp < 35 then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.ArcaneBlast) then
		return AR.ArcaneExplosion;
	end
	--if Mage:SpellReady(AR.ArcaneBarrage) then -- as last global
	--	return AR.ArcaneBarrage;
	--end
end

function Mage:MiniBurnPhaseMulti()

	if talents[AR.ArcaneHarmony] and buff[AR.ArcaneHarmonyBuff].count < 20 then
		return AR.ArcaneMissiles;
	end
	if Mage:SpellReady(AR.ArcaneOrb) then
		return AR.ArcaneOrb;
	end
	if Mage:SpellReady(AR.RuneOfPower) then
		return AR.RuneOfPower;
	end
	if Mage:SpellReady(AR.RadiantSpark) then
		return AR.RadiantSpark;
	end
	if debuff[AR.RadiantSpark].up and debuff[AR.RadiantSparkStacks].count < 3 then
		return AR.ArcaneExplosion;
	end
	if Mage:SpellReady(AR.NetherTempest) and debuff[AR.NetherTempest].refreshable then
		return AR.NetherTempest;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.TimeWarp].up then
		return AR.ArcaneExplosion;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and buff[AR.RadiantSpark].up then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.TouchOfTheMagi) then
		return AR.TouchOfTheMagi;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.NetherPrecision].up then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.ArcaneMissiles) and buff[AR.Clearcasting].up then
		return AR.ArcaneExplosion;
	end
	if talents[AR.CascadingPower] and manaPct < 85 and cooldown[AR.UseManaGem].ready then
		return AR.UseManaGem;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and targetHp < 35 then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.ArcaneBlast) then
		return AR.ArcaneExplosion;
	end
end

function Mage:ConservePhaseMulti()
	if Mage:SpellReady(AR.ArcaneOrb) and chargeCount < 4 then
		return AR.ArcaneOrb;
	end
	if Mage:SpellReady(AR.ShiftingPower) then
		return AR.ShiftingPower;
	end
	if Mage:SpellReady(AR.ArcaneMissiles) and buff[AR.Clearcasting].count > 2 then
		return AR.ArcaneExplosion;
	end
	if Mage:SpellReady(AR.ArcaneBlast) and buff[AR.NetherPrecision].up then
		return AR.ArcaneBlast;
	end
	if Mage:SpellReady(AR.ArcaneMissiles) and buff[AR.Clearcasting].count > 0 then
		return AR.ArcaneExplosion;
	end
	if Mage:SpellReady(AR.NetherTempest) and debuff[AR.NetherTempest].refreshable and chargeCount == 4 then
		return AR.NetherTempest;
	end
	if Mage:SpellReady(AR.ArcaneBarrage) and chargeCount == 4 and manaPct < 60 then
		return AR.ArcaneBarrage;
	end
	if Mage:SpellReady(AR.ArcaneBlast) then
		return AR.ArcaneExplosion;
	end
end