if not MaxDps then
	return;
end

local Paladin = MaxDps:NewModule('Paladin');

-- Spells
local _TemplarsVerdict = 85256;
local _Judgment = 20271;
local _CrusaderStrike = 35395;
local _BladeofJustice = 184575;
local _Crusade = 231895;
local _ShieldofVengeance = 184662;
local _Zeal = 217020;
local _Consecration = 205228;
local _HammerofWrath = 24275;
local _Inquisition = 84963;
local _ExecutionSentence = 267798;
local _WakeofAshes = 255937;
local _JudgementHoly = 275773;
local _HolyShock = 20473;
local _HolyConsecration = 26573;
local _HolyConsecrationAura = 204242;
local _AvengingWrath = 31884;

-- General

function Paladin:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Paladin [Holy, Protection, Retribution]');

	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Paladin.Holy;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Paladin.Protection;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Paladin.Retribution;
	end;
end

function Paladin:Holy(timeShift, currentSpell, gcd, talents)

	if MaxDps:SpellAvailable(_JudgementHoly, timeShift) then
		return _JudgementHoly;
	end

	if MaxDps:SpellAvailable(_CrusaderStrike, timeShift) then
		return _CrusaderStrike;
	end

	if MaxDps:SpellAvailable(_HolyShock, timeShift) then
		return _HolyShock;
	end

	if MaxDps:SpellAvailable(_HolyConsecration, timeShift) and
		not MaxDps:TargetAura(_HolyConsecrationAura, timeShift + 3) then
		return _HolyConsecration;
	end
end

function Paladin:Protection(timeShift, currentSpell, gcd, talents)

end

function Paladin:Retribution(timeShift, currentSpell, gcd, talents)

	local tgtPctHp = MaxDps:TargetPercentHealth();
	local execPct = 0.2;
	local holyPower = UnitPower('player', Enum.PowerType.HolyPower);

	-- Cooldowns

	MaxDps:GlowCooldown(_ShieldofVengeance, MaxDps:SpellAvailable(_ShieldofVengeance, timeShift));

	if talents[_Crusade] then
		MaxDps:GlowCooldown(_Crusade, MaxDps:SpellAvailable(_Crusade, timeShift));
	else
		MaxDps:GlowCooldown(_AvengingWrath, MaxDps:SpellAvailable(_AvengingWrath, timeShift));
	end
	-- Rotation

	-- Spenders
	if talents[_Inquisition] and holyPower >= 2 and not MaxDps:Aura(_Inquisition, timeShift + 7) then
		return _Inquisition;
	end

	if talents[_ExecutionSentence] and MaxDps:SpellAvailable(_ExecutionSentence, timeShift) and holyPower >= 3 then
		return _ExecutionSentence;
	end

	if holyPower >= 5 then
		return _TemplarsVerdict;
	end

	-- Generators
	if talents[_WakeofAshes] and holyPower<=1 and MaxDps:SpellAvailable(_WakeofAshes, timeShift) then
		return _WakeofAshes;
	end

	if MaxDps:SpellAvailable(_BladeofJustice, timeShift) and holyPower <= 3 then
		return _BladeofJustice;
	end

	if MaxDps:SpellAvailable(_Judgment, timeShift) and holyPower <= 4 then
		return _Judgment;
	end

	if talents[_HammerofWrath] and MaxDps:SpellAvailable(_HammerofWrath, timeShift) and holyPower <=4 and tgtPctHp < execPct then
		return _HammerofWrath;
	end

	if talents[_Consecration] and MaxDps:SpellAvailable(_Consecration, timeShift) and holyPower <=4 then
		return _Consecration;
	end

	if MaxDps:SpellAvailable(_CrusaderStrike, timeShift) and holyPower <= 4 then
		return _CrusaderStrike;
	end
end