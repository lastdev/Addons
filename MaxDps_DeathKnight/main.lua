--- @type MaxDps
if not MaxDps then
	return ;
end

local DeathKnight = MaxDps:NewModule('DeathKnight');

-- Blood

local _DancingRuneWeapon = 49028;
local _DarkCommand = 56222;
local _BloodDrinker = 206931;
local _Marrowrend = 195182;
local _BloodBoil = 50842;
local _BoneShield = 195181;
local _DeathStrike = 49998;
local _BloodShield = 77535;
local _BloodPlague = 55078;
local _BonesoftheDamned = 279503;
local _Ossuary = 219786;
local _RuneStrike = 210764;
local _DeathandDecay = 43265;
local _HeartStrike = 206930;
local _CrimsonScourge = 81136;
local _DeathGrip = 49576;
local _AntiMagicShell = 48707;
local _VampiricBlood = 55233;
local _IceboundFortitude = 48792;
local _AntiMagicBarrier = 205727;
local _Haemostasis = 235559;
local _Hemostasis = 273946;
local _RedThirst = 205723;
local _DeathsAdvance = 48265;
local _RuneTap = 194679;
local _MasteryBloodShield = 77513;
local _Bonestorm = 194844;

-- Frost

local _RemorselessWinter = 196770;
local _GatheringStorm = 194912;
local _HowlingBlast = 49184;
local _Rime = 59052;
local _FrostFever = 55095;
local _Obliterate = 49020;
local _KillingMachine = 51124;
local _EmpowerRuneWeapon = 47568;
local _HornofWinter = 57330;
local _ChainsofIce = 45524;
local _PillarofFrost = 51271;
local _FrostStrike = 49143;
local _BreathofSindragosa = 152279;
local _Frostscythe = 207230;
local _FrostwyrmsFury = 279302;
local _MasteryFrozenHeart = 77514;
local _Obliteration = 281238;
local _ColdHeart = 281209;
local _ColdHeartTalent = 281208;

-- Unholy

local _VirulentPlague = 191587;
local _Outbreak = 77575;
local _SoulReaper = 130736;
local _DarkTransformation = 63560;
local _Apocalypse = 275699;
local _FesteringWound = 194310;
local _DeathCoil = 47541;
local _SuddenDoom = 49530;
local _DeathandDecayUh = 43265;
local _Pestilence = 277234;
local _Defile = 152280;
local _ScourgeStrike = 55090;
local _ClawingShadows = 207311;
local _FesteringStrike = 85948;
local _UnholyFrenzy = 207289;
local _BurstingSores = 207264;
local _InfectedClaws = 207272;
local _ArmyoftheDead = 42650;
local _Epidemic = 207317;
local _SummonGargoyle = 49206;
local _RaiseDead = 46584;

function DeathKnight:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Death Knight [Frost, Unholy, Blood]');

	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = DeathKnight.Blood;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = DeathKnight.Frost;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = DeathKnight.Unholy;
	end ;

	return true;
end

function DeathKnight:Blood(timeShift, currentSpell, gcd, talents)
	local runic = UnitPower('player', Enum.PowerType.RunicPower);
	local runicMax = UnitPowerMax('player', Enum.PowerType.RunicPower);
	local runes, runeCd = DeathKnight:Runes(timeShift);

	local bb, bbCharges = MaxDps:SpellCharges(_BloodBoil, timeShift);
	local dad, dadCharges = MaxDps:SpellAvailable(_DeathandDecay, timeShift);

	local bs, bsCharges = MaxDps:Aura(_BoneShield, timeShift + 6);
	local shield = MaxDps:Aura(_BloodShield, timeShift + 3);
	local bp = MaxDps:TargetAura(_BloodPlague, timeShift);

	MaxDps:GlowCooldown(_DancingRuneWeapon, MaxDps:SpellAvailable(_DancingRuneWeapon, timeShift));

	if talents[_Bonestorm] then
		MaxDps:GlowCooldown(_Bonestorm, MaxDps:SpellAvailable(_Bonestorm, timeShift) and runic >= 60);
	end

	if bsCharges <= 6 and runes >= 2 then
		return _Marrowrend;
	end

	local playerHp = MaxDps:TargetPercentHealth('player');
	if runic >= 45 and (not shield or playerHp < 0.5) then
		return _DeathStrike;
	end

	if talents[_BloodDrinker] and MaxDps:SpellAvailable(_BloodDrinker, timeShift) then
		return _BloodDrinker;
	end

	if not bp or bbCharges >= 2 then
		return _BloodBoil;
	end

	if bsCharges <= 6 and runes >= 2 then
		return _Marrowrend;
	end

	local rs, rsCharges = MaxDps:SpellCharges(_RuneStrike, timeShift);
	if talents[_RuneStrike] and rsCharges >= 1.7 and runes <= 3 then
		return _RuneStrike;
	end

	local targets = MaxDps:TargetsInRange(49998);
	if runes >= 3 then
		if dad and targets >= 3 then
			return _DeathandDecay;
		end

		return _HeartStrike;
	end

	if MaxDps:Aura(_CrimsonScourge, timeShift) or (dad and targets > 5 and runes >= 1) then
		return _DeathandDecay;
	end

	if runicMax - runic <= 20 then
		return _DeathStrike;
	end

	if runes > 2 then
		return _HeartStrike;
	end

	-- comment this out if survival is a problem
	if runic >= 60 then
		return _DeathStrike;
	end
	-- comment out the above if survival is a problem

	if bbCharges >= 1 then
		return _BloodBoil;
	end

	return nil;
end

function DeathKnight:Frost(timeShift, currentSpell, gcd, talents)
	local runic = UnitPower('player', Enum.PowerType.RunicPower);
	local runicMax = UnitPowerMax('player', Enum.PowerType.RunicPower);
	local runes, runeCd = DeathKnight:Runes(timeShift);

	local km = MaxDps:Aura(_KillingMachine, timeShift);
	local fever = MaxDps:TargetAura(_FrostFever, timeShift + 6);
	local FSCost = 25;

	MaxDps:GlowCooldown(_BreathofSindragosa, talents[_BreathofSindragosa] and MaxDps:SpellAvailable(_BreathofSindragosa, timeShift));

	MaxDps:GlowCooldown(_FrostwyrmsFury, MaxDps:SpellAvailable(_FrostwyrmsFury, timeShift));
	MaxDps:GlowCooldown(_PillarofFrost, MaxDps:SpellAvailable(_PillarofFrost, timeShift));
	MaxDps:GlowCooldown(_EmpowerRuneWeapon, MaxDps:SpellAvailable(_EmpowerRuneWeapon, timeShift) and runes <= 1 and runic <= (runicMax - FSCost));

	if talents[_BreathofSindragosa] then
		if MaxDps:Aura(_BreathofSindragosa, timeShift) then
			if talents[_GatheringStorm] and MaxDps:SpellAvailable(_RemorselessWinter, timeShift) and runes >= 1 then
				return _RemorselessWinter;
			end

			if runes >= 1 and (MaxDps:Aura(_Rime, timeShift) or not fever) then
				return _HowlingBlast;
			end

			if runes >= 2 then
				return _Obliterate;
			end

			if MaxDps:SpellAvailable(_EmpowerRuneWeapon, timeShift) and runic < 50 then
				return _EmpowerRuneWeapon;
			end

			if talents[_HornofWinter] and MaxDps:SpellAvailable(_HornofWinter, timeShift)
				and runes <= 3 and runic < 60
			then
				return _HornofWinter;
			end
		else
			local ch, chCharges = MaxDps:Aura(_ColdHeart, timeShift);
			if talents[_ColdHeartTalent] and chCharges >= 20 and runes >= 1 then
				return _ChainsofIce;
			end

			if talents[_GatheringStorm] and MaxDps:SpellAvailable(_RemorselessWinter, timeShift) and runes >= 1 then
				return _RemorselessWinter;
			end

			if runes >= 1 and (MaxDps:Aura(_Rime, timeShift) or not fever) then
				return _HowlingBlast;
			end

			if runes >= 4 then
				return _Obliterate;
			end

			if runic >= 90 then
				return _FrostStrike;
			end

			if km and runes >= 2 then
				return _Obliterate;
			end

			if runic >= 80 then
				return _FrostStrike;
			end

			if runes >= 2 then
				return _Obliterate;
			end

			if runic >= 25 then
				return _FrostStrike;
			end
		end

		return nil;
	else
		if MaxDps:Aura(_PillarofFrost, timeShift) then
			if MaxDps:SpellAvailable(_RemorselessWinter, timeShift) and runes >= 1 then
				return _RemorselessWinter;
			end

			if km and runes >= 2 then
				return _Obliterate;
			end

			if (not MaxDps:Aura(_Rime, timeShift) and runic >= 25) or runic > 90 then
				return _FrostStrike;
			end

			if runes >= 1 and (MaxDps:Aura(_Rime, timeShift) or not fever) then
				return _HowlingBlast;
			end

			if not km and runic >= 25 then
				return _FrostStrike;
			end

			if not km and runes >= 2 then
				return _Obliterate;
			end
		else
			local ch, chCharges = MaxDps:Aura(_ColdHeart, timeShift);
			if talents[_ColdHeartTalent] and chCharges >= 20 and runes >= 1 then
				return _ChainsofIce;
			end

			if MaxDps:SpellAvailable(_RemorselessWinter, timeShift) and runes >= 1 then
				return _RemorselessWinter;
			end

			if runes >= 1 and MaxDps:Aura(_Rime, timeShift) then
				return _HowlingBlast;
			end

			if runes >= 4 then
				return _Obliterate;
			end

			if runic >= 90 then
				return _FrostStrike;
			end

			if km and runes >= 2 then
				return _Obliterate;
			end

			if runic >= 75 then
				return _FrostStrike;
			end

			if runes >= 2 then
				return _Obliterate;
			end

			if runic >= 25 then
				return _FrostStrike;
			end
		end

		return nil;
	end
end

function DeathKnight:Unholy(timeShift, currentSpell, gcd, talents)
	local runic = UnitPower('player', Enum.PowerType.RunicPower);
	local runicMax = UnitPowerMax('player', Enum.PowerType.RunicPower);
	local runes, runeCd = DeathKnight:Runes(timeShift);

	--Get wounds on target.
	local festering, festeringCharges, festeringCd = MaxDps:TargetAura(_FesteringWound, timeShift);

	local scourgeStrike = (talents[_ClawingShadows] and _ClawingShadows) or _ScourgeStrike;
	local deathanddecay = (talents[_Defile] and _Defile) or _DeathandDecay;

	MaxDps:GlowCooldown(_ArmyoftheDead, MaxDps:SpellAvailable(_ArmyoftheDead, timeShift) and runes >= 3);
	if talents[_UnholyFrenzy] then
		MaxDps:GlowCooldown(_UnholyFrenzy, MaxDps:SpellAvailable(_UnholyFrenzy, timeShift));
	end

	if not UnitExists('pet') and MaxDps:SpellAvailable(_RaiseDead, timeShift) then
		return _RaiseDead;
	end

	if not MaxDps:TargetAura(_VirulentPlague, timeShift + 1.5) and runes >= 1 then
		return _Outbreak;
	end

	if runes < 2 and MaxDps:SpellAvailable(_SoulReaper, timeShift) then
		return _SoulReaper;
	end

	if MaxDps:SpellAvailable(_DarkTransformation, timeShift) then
		return _DarkTransformation;
	end

	if MaxDps:SpellAvailable(_Apocalypse, timeShift) and festeringCharges >= 6 then
		return _Apocalypse;
	end

	if runic > 80 or MaxDps:Aura(_SuddenDoom, timeShift) then
		return _DeathCoil;
	end

	if MaxDps:SpellAvailable(deathanddecay, timeShift) and runes >= 1 then
		return deathanddecay;
	end

	if festeringCharges >= 1 and runes >= 1 then
		return scourgeStrike;
	end

	if festeringCharges < 6 and runes >= 2 then
		return _FesteringStrike;
	end

	return nil;
end

function DeathKnight:Runes(timeShift)
	local count = 0;
	local time = GetTime();
	for i = 1, 10 do
		local start, duration, runeReady = GetRuneCooldown(i);
		if start and start > 0 then
			local rcd = duration + start - time;
			if rcd < timeShift then
				count = count + 1;
			end
		elseif runeReady then
			count = count + 1;
		end
	end

	return count;
end