--- @type MaxDps
if not MaxDps then
	return;
end

local Monk = MaxDps:NewModule('Monk');

-- Auras
local _HitComboAura = 196741;
local _BlackoutKickAura = 116768;
local _RushingJadeWindAura = 148187;

-- Spells
local _TigerPalm = 100780;
local _FistsofFury = 113656;
local _RisingSunKick = 107428;
local _BlackoutKick = 100784;
local _MarkoftheCrane = 228287;
local _SpinningCraneKick = 101546;
local _StormEarthandFire = 137639;
local _TouchofDeath = 115080;
local _TouchofKarma = 122470;
local _MasteryComboStrikes = 115636;
local _Afterlife = 116092;
local _Transcendence = 101643;
local _TranscendenceTransfer = 119996;


-- Talents
local _ChiWave = 173527;
local _ChiBurst = 123986;
local _Ascension = 115396;
local _FistOfTheWhiteTiger = 261947;
local _HitCombo = 196740;
local _Xuen = 123904;
local _WhirlingDragonPunch = 152175;
local _Serenity = 152173;
local _RushingJadeWind = 261715;


function Monk:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Monk [Brewmaster, Mistweaver, Windwalker]');

	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Monk.Brewmaster;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Monk.Mistweaver;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Monk.Windwalker;
	end;

	return true;
end



function Monk:Brewmaster(timeShift, currentSpell, gcd, talents)
	return nil;
end

function Monk:Mistweaver(timeShift, currentSpell, gcd, talents)
	return nil;
end

function Monk:Windwalker(timeShift, currentSpell, gcd, talents)
	-- Cooldowns

	if talents[_Serenity] then
		MaxDps:GlowCooldown(_Serenity, MaxDps:SpellAvailable(_Serenity, timeShift));
	else
		MaxDps:GlowCooldown(_StormEarthandFire, MaxDps:SpellAvailable(_StormEarthandFire, timeShift));
	end

	if talents[_Xuen] then
		MaxDps:GlowCooldown(_Xuen, MaxDps:SpellAvailable(_Xuen, timeShift));
	end

	MaxDps:GlowCooldown(_TouchofDeath, MaxDps:SpellAvailable(_TouchofDeath, timeShift));
	MaxDps:GlowCooldown(_TouchofKarma, MaxDps:SpellAvailable(_TouchofKarma, timeShift));

	-- Auras

	local hit, hitCharges = MaxDps:Aura(_HitComboAura, timeShift);

	-- CD Checkers

	local rsk = MaxDps:SpellAvailable(_RisingSunKick, timeShift);
	local fotf, fotfCd = MaxDps:SpellAvailable(_FistsofFury, timeShift + 0.5);
	local wdp, wdpCd = MaxDps:SpellAvailable(_WhirlingDragonPunch, timeShift);

	local chi = UnitPower('player', Enum.PowerType.Chi);
	local energy = UnitPower('player', Enum.PowerType.Energy);
	local energyMax = UnitPowerMax('player', Enum.PowerType.Energy);

	-- Rotation start
	if fotf and chi >= 3 then
		return _FistsofFury;
	end

	if talents[_FistOfTheWhiteTiger]
		and MaxDps:SpellAvailable(_FistOfTheWhiteTiger, timeShift)
		and energy >= 40
		and chi < 3
	then
		return _FistOfTheWhiteTiger;
	end

	if talents[_WhirlingDragonPunch]
		and wdpCd <= 2
		and MaxDps:SpellAvailable(_RisingSunKick, timeShift)
		and chi >= 2
	then
		return _RisingSunKick;
	end

	if talents[_WhirlingDragonPunch]
		and wdp
		and not rsk
		and not fotf
	then
		return _WhirlingDragonPunch;
	end

	if (chi < 4 and (energyMax - energy < 20)) then
		return _TigerPalm;
	end

	if talents[_ChiBurst]
		and MaxDps:SpellAvailable(_ChiBurst, timeShift)
		and chi < 5
		and currentSpell ~= _ChiBurst
	then
		return _ChiBurst;
	end

	if (chi >= 1 and fotfCd > 2) or MaxDps:Aura(_BlackoutKickAura, timeShift) then
		return _BlackoutKick;
	end

	if MaxDps:SpellAvailable(_RisingSunKick, timeShift) and fotfCd > 2 and chi >= 2 then
		return _RisingSunKick;
	end

	return _TigerPalm
end