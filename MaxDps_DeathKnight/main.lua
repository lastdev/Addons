--- @type MaxDps
if not MaxDps then
	return ;
end

local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local EnumPowerType = Enum.PowerType;

local DeathKnight = MaxDps:NewModule('DeathKnight');

-- Blood
local BL = {
	DancingRuneWeapon  = 49028,
	DarkCommand        = 56222,
	BloodDrinker       = 206931,
	Marrowrend         = 195182,
	BloodBoil          = 50842,
	BoneShield         = 195181,
	DeathStrike        = 49998,
	BloodShield        = 77535,
	BloodPlague        = 55078,
	BonesoftheDamned   = 279503,
	Ossuary            = 219786,
	RuneStrike         = 210764,
	DeathAndDecay      = 43265,
	HeartStrike        = 206930,
	CrimsonScourge     = 81136,
	DeathGrip          = 49576,
	AntiMagicShell     = 48707,
	VampiricBlood      = 55233,
	IceboundFortitude  = 48792,
	AntiMagicBarrier   = 205727,
	Hemostasis         = 273946,
	RedThirst          = 205723,
	DeathsAdvance      = 48265,
	RuneTap            = 194679,
	MasteryBloodShield = 77513,
	Bonestorm          = 194844,
};


-- Frost
local FR = {
	RemorselessWinter  = 196770,
	GatheringStorm     = 194912,
	HowlingBlast       = 49184,
	Rime               = 59052,
	FrostFever         = 55095,
	Obliterate         = 49020,
	KillingMachine     = 51124,
	EmpowerRuneWeapon  = 47568,
	HornOfWinter       = 57330,
	ChainsOfIce        = 45524,
	PillarOfFrost      = 51271,
	FrostStrike        = 49143,
	BreathOfSindragosa = 152279,
	Frostscythe        = 207230,
	FrostwyrmsFury     = 279302,
	MasteryFrozenHeart = 77514,
	Obliteration       = 281238,
	ColdHeart          = 281209,
	ColdHeartTalent    = 281208,
};


-- Unholy
local UH = {
	VirulentPlague     = 191587,
	Outbreak           = 77575,
	SoulReaper         = 130736,
	DarkTransformation = 63560,
	Apocalypse         = 275699,
	FesteringWound     = 194310,
	DeathCoil          = 47541,
	SuddenDoom         = 49530,
	DeathAndDecay      = 43265,
	Pestilence         = 277234,
	Defile             = 152280,
	ScourgeStrike      = 55090,
	ClawingShadows     = 207311,
	FesteringStrike    = 85948,
	UnholyFrenzy       = 207289,
	BurstingSores      = 207264,
	InfectedClaws      = 207272,
	ArmyOfTheDead      = 42650,
	Epidemic           = 207317,
	SummonGargoyle     = 49206,
	RaiseDead          = 46584,
}


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

function DeathKnight:Blood()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, timeShift, talents, azerite, currentSpell =
		fd.cooldown, fd.buff, fd.debuff, fd.timeShift, fd.talents, fd.azerite, fd.currentSpell;

	local runic = UnitPower('player', EnumPowerType.RunicPower);
	local runicMax = UnitPowerMax('player', EnumPowerType.RunicPower);
	local runes, runeCd = DeathKnight:Runes(timeShift);

	MaxDps:GlowCooldown(BL.DancingRuneWeapon, cooldown[BL.DancingRuneWeapon].ready);

	if talents[BL.Bonestorm] then
		MaxDps:GlowCooldown(BL.Bonestorm, cooldown[BL.Bonestorm].ready and runic >= 60);
	end

	local shouldUseMarrowrend = buff[BL.BoneShield].count <= 6 or buff[BL.BoneShield].remains < 6;
	if shouldUseMarrowrend and runes >= 2 then
		return BL.Marrowrend;
	end

	local playerHp = MaxDps:TargetPercentHealth('player');
	if runic >= 45 and (buff[BL.BoneShield].remains < 3 or playerHp < 0.5) then
		return BL.DeathStrike;
	end

	if talents[BL.BloodDrinker] and cooldown[BL.BloodDrinker].ready then
		return BL.BloodDrinker;
	end

	if not debuff[BL.BloodPlague].up or cooldown[BL.BloodBoil].charges >= 2 then
		return BL.BloodBoil;
	end

	if shouldUseMarrowrend and runes >= 2 then
		return BL.Marrowrend;
	end

	if talents[BL.RuneStrike] and cooldown[BL.RuneStrike].charges >= 1.7 and runes <= 3 then
		return BL.RuneStrike;
	end

	local targets = MaxDps:TargetsInRange(49998);
	if runes >= 3 then
		if cooldown[BL.DeathAndDecay].ready and targets >= 3 then
			return BL.DeathAndDecay;
		end

		return BL.HeartStrike;
	end

	if buff[BL.CrimsonScourge].up or (cooldown[BL.DeathAndDecay].ready and targets > 5 and runes >= 1) then
		return BL.DeathAndDecay;
	end

	if runicMax - runic <= 20 then
		return BL.DeathStrike;
	end

	if runes > 2 then
		return BL.HeartStrike;
	end

	if runic >= 60 then
		return BL.DeathStrike;
	end

	if cooldown[BL.BloodBoil].charges >= 1 then
		return BL.BloodBoil;
	end

	return nil;
end

function DeathKnight:Frost()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, timeShift, talents, azerite, currentSpell =
		fd.cooldown, fd.buff, fd.debuff, fd.timeShift, fd.talents, fd.azerite, fd.currentSpell;

	local runic = UnitPower('player', EnumPowerType.RunicPower);
	local runicMax = UnitPowerMax('player', EnumPowerType.RunicPower);
	local runes, runeCd = DeathKnight:Runes(timeShift);

	local fever = debuff[FR.FrostFever].remains > 6;
	local FSCost = 25;

	MaxDps:GlowCooldown(FR.BreathOfSindragosa, talents[FR.BreathOfSindragosa] and cooldown[FR.BreathOfSindragosa].ready);

	MaxDps:GlowCooldown(FR.FrostwyrmsFury, cooldown[FR.FrostwyrmsFury].ready);
	MaxDps:GlowCooldown(FR.PillarOfFrost, cooldown[FR.PillarOfFrost].ready);
	MaxDps:GlowCooldown(FR.EmpowerRuneWeapon, cooldown[FR.EmpowerRuneWeapon].ready and runes <= 1 and runic <= (runicMax - FSCost));

	if talents[FR.BreathOfSindragosa] then
		if buff[FR.BreathOfSindragosa].up then
			if talents[FR.GatheringStorm] and cooldown[FR.RemorselessWinter].ready and runes >= 1 then
				return FR.RemorselessWinter;
			end

			if runes >= 1 and (buff[FR.Rime].up or not fever) then
				return FR.HowlingBlast;
			end

			if runes >= 2 then
				return FR.Obliterate;
			end

			if cooldown[FR.EmpowerRuneWeapon].ready and runic < 50 then
				return FR.EmpowerRuneWeapon;
			end

			if talents[FR.HornOfWinter] and cooldown[FR.HornOfWinter].ready
				and runes <= 3 and runic < 60
			then
				return FR.HornOfWinter;
			end
		else
			if talents[FR.ColdHeartTalent] and buff[FR.ColdHeart].count >= 20 and runes >= 1 then
				return FR.ChainsOfIce;
			end

			if talents[FR.GatheringStorm] and cooldown[FR.RemorselessWinter].ready and runes >= 1 then
				return FR.RemorselessWinter;
			end

			if runes >= 1 and (buff[FR.Rime].up or not fever) then
				return FR.HowlingBlast;
			end

			if runes >= 4 then
				return FR.Obliterate;
			end

			if runic >= 90 then
				return FR.FrostStrike;
			end

			if buff[FR.KillingMachine].up and runes >= 2 then
				return FR.Obliterate;
			end

			if runic >= 80 then
				return FR.FrostStrike;
			end

			if runes >= 2 then
				return FR.Obliterate;
			end

			if runic >= 25 then
				return FR.FrostStrike;
			end
		end

		return nil;
	else
		if buff[FR.PillarOfFrost].up then
			if cooldown[FR.RemorselessWinter].ready and runes >= 1 then
				return FR.RemorselessWinter;
			end

			if buff[FR.KillingMachine].up and runes >= 2 then
				return FR.Obliterate;
			end

			if (not buff[FR.Rime].up and runic >= 25) or runic > 90 then
				return FR.FrostStrike;
			end

			if runes >= 1 and (buff[FR.Rime].up or not fever) then
				return FR.HowlingBlast;
			end

			if not buff[FR.KillingMachine].up and runic >= 25 then
				return FR.FrostStrike;
			end

			if not buff[FR.KillingMachine].up and runes >= 2 then
				return FR.Obliterate;
			end
		else
			if talents[FR.ColdHeartTalent] and buff[FR.ColdHeart].count >= 20 and runes >= 1 then
				return FR.ChainsOfIce;
			end

			if cooldown[FR.RemorselessWinter].ready and runes >= 1 then
				return FR.RemorselessWinter;
			end

			if runes >= 1 and buff[FR.Rime].up then
				return FR.HowlingBlast;
			end

			if runes >= 4 then
				return FR.Obliterate;
			end

			if runic >= 90 then
				return FR.FrostStrike;
			end

			if buff[FR.KillingMachine].up and runes >= 2 then
				return FR.Obliterate;
			end

			if runic >= 75 then
				return FR.FrostStrike;
			end

			if runes >= 2 then
				return FR.Obliterate;
			end

			if runic >= 25 then
				return FR.FrostStrike;
			end
		end

		return nil;
	end
end

function DeathKnight:Unholy()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, timeShift, talents, azerite, currentSpell =
		fd.cooldown, fd.buff, fd.debuff, fd.timeShift, fd.talents, fd.azerite, fd.currentSpell;

	local runic = UnitPower('player', EnumPowerType.RunicPower);
	--local runicMax = UnitPowerMax('player', EnumPowerType.RunicPower);
	local runes, runeCd = DeathKnight:Runes(timeShift);


	local scourgeStrike = talents[UH.ClawingShadows] and UH.ClawingShadows or UH.ScourgeStrike;
	local deathAndDecay = talents[UH.Defile] and UH.Defile or UH.DeathAndDecay;

	MaxDps:GlowCooldown(UH.ArmyOfTheDead, cooldown[UH.ArmyOfTheDead].ready and runes >= 3);

	if talents[UH.UnholyFrenzy] then
		MaxDps:GlowCooldown(UH.UnholyFrenzy, cooldown[UH.UnholyFrenzy].ready);
	end

	if not UnitExists('pet') and cooldown[UH.RaiseDead].ready then
		return UH.RaiseDead;
	end

	if debuff[UH.VirulentPlague].refreshable and runes >= 1 then
		return UH.Outbreak;
	end

	if runes < 2 and cooldown[UH.SoulReaper].ready then
		return UH.SoulReaper;
	end

	if cooldown[UH.DarkTransformation].ready then
		return UH.DarkTransformation;
	end

	if cooldown[UH.Apocalypse].ready and debuff[UH.FesteringWound].count >= 6 then
		return UH.Apocalypse;
	end

	if runic > 80 or buff[UH.SuddenDoom].up then
		return UH.DeathCoil;
	end

	if cooldown[deathAndDecay].ready and runes >= 1 then
		return deathAndDecay;
	end

	if debuff[UH.FesteringWound].count >= 1 and runes >= 1 then
		return scourgeStrike;
	end

	if debuff[UH.FesteringWound].count < 6 and runes >= 2 then
		return UH.FesteringStrike;
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