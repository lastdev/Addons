--- @type MaxDps
if not MaxDps then
	return;
end

local Priest = MaxDps:NewModule('Priest');

-- Forms
local _Voidform = 194249;
local _Shadowform = 232698;
local _LegacyoftheVoid = 193225;
local _VoidEruption = 228260;
--local _Voidform = 228264;
--local _VoidBolt = 228266;
local _VoidBolt = 205448;
local _ShadowWordPain = 589;
local _VampiricTouch = 34914;
local _Shadowfiend = 34433;
local _MindBlast = 8092;
local _ShadowWordVoid = 205351;
local _ShadowWordDeath = 32379;
local _Mindbender = 200174;
local _DarkVoid = 263346;
local _ShadowCrash = 205385;
local _VoidTorrent = 263165;
local _MindFlay = 15407;
local _Misery = 238558;
local _MindSear = 48045;
local _Dispersion = 47585;
local _DarkAscension = 280711;


function Priest:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Priest [Shadow]');

	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Priest.Discipline;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Priest.Holy;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Priest.Shadow;
	end;

	return true;
end

function Priest:Discipline(timeShift, currentSpell, gcd, talents)
	return nil;
end

function Priest:Holy(timeShift, currentSpell, gcd, talents)
	return nil;
end

function Priest:Shadow(timeShift, currentSpell, gcd, talents)
	local insa = UnitPower('player', Enum.PowerType.Insanity);

	-- Fix a bug when void bolt tooltip does not refresh
	local voidBolt = _VoidBolt;
	if MaxDps:FindSpell(_VoidEruption) then
		voidBolt = _VoidEruption;
	end
	local mindBlast = talents[_ShadowWordVoid] and _ShadowWordVoid or _MindBlast;

	local swp, swpCd = MaxDps:TargetAura(_ShadowWordPain, timeShift + 4);
	local vt, vtCd = MaxDps:TargetAura(_VampiricTouch, timeShift + 5);

	local vf, vCharges = MaxDps:Aura(_Voidform);
	if not MaxDps:Aura(_Shadowform) and not vf then
		return _Shadowform;
	end

	-- Cooldowns

	if talents[_Mindbender] then
		MaxDps:GlowCooldown(_Mindbender, MaxDps:SpellAvailable(_Mindbender, timeShift));
	else
		MaxDps:GlowCooldown(_Shadowfiend, MaxDps:SpellAvailable(_Shadowfiend, timeShift));
	end

	-- Rotation

	if not InCombatLockdown() and MaxDps:SpellAvailable(mindBlast, timeShift) and currentSpell ~= mindBlast then
		return mindBlast;
	end

	if not vf and (insa > 90 or (insa > 60 and talents[_LegacyoftheVoid])) then
		return _VoidEruption;
	end

	if talents[_DarkAscension] and not vf and insa < 40 and MaxDps:SpellAvailable(_DarkAscension, timeShift) then
		return _DarkAscension;
	end

	if talents[_DarkVoid] and MaxDps:SpellAvailable(_DarkVoid, timeShift) and currentSpell ~= _DarkVoid then
		return _DarkVoid;
	end

	if talents[_ShadowCrash] and MaxDps:SpellAvailable(_ShadowCrash, timeShift) then
		return _ShadowCrash;
	end

	if vf and MaxDps:SpellAvailable(_VoidBolt, timeShift + 0.4) then
		return voidBolt;
	end

	if talents[_ShadowWordVoid] then
		local swv, swvCharges = MaxDps:SpellCharges(_ShadowWordVoid, timeShift);
		if swvCharges >= 1.3 and currentSpell ~= _ShadowWordVoid then
			return _ShadowWordVoid;
		end
	else
		if MaxDps:SpellAvailable(_MindBlast, timeShift) and currentSpell ~= _MindBlast then
			return _MindBlast;
		end
	end

	if not vt and currentSpell ~= _VampiricTouch then
		return _VampiricTouch;
	end

	if not talents[_Misery] and not swp and currentSpell ~= _DarkVoid then -- dark void applies SWP
		return _ShadowWordPain;
	end

	if talents[_ShadowWordDeath] then
		local targetPh = MaxDps:TargetPercentHealth();
		local swd, swdCharges, swdMax = MaxDps:SpellCharges(_ShadowWordDeath, timeShift);
		if swdCharges >= 1.5 and targetPh < 0.2 then
			return _ShadowWordDeath;
		end
	end

	if talents[_DarkVoid] and MaxDps:SpellAvailable(_DarkVoid, timeShift) and currentSpell ~= _DarkVoid then
		return _DarkVoid;
	end

	if talents[_ShadowCrash] and MaxDps:SpellAvailable(_ShadowCrash, timeShift) then
		return _ShadowCrash;
	end

	if talents[_VoidTorrent] and vf and MaxDps:SpellAvailable(_VoidTorrent, timeShift)
		and currentSpell ~= _VoidTorrent
	then
		return _VoidTorrent;
	end

	return _MindFlay;
end
