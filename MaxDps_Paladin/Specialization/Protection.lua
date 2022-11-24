local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then
	return
end

local Paladin = addonTable.Paladin;
local MaxDps = MaxDps;

local HolyPower = Enum.PowerType.HolyPower;
local PR = {
	AshenHallow = 316958,
	AvengersShield = 31935,
	AvengingWrath = 31884,
	AvengingWrathTalent = 384376,
	AvengingWrathMightTalent = 384442,
	BastionOfLight = 378974,
	BlessedHammer = 204019,
	Consecration = 26573,
	ConsecrationBuff = 188370,
	DivinePurpose = 223819,
	DivineToll = 375576,
	HammerOfTheRighteous = 53595,
	HammerOfWrath = 24275,
	Judgment = 275779,
	KyrianDivineToll = 304971,
	Seraphim = 152262,
	ShieldOfTheRighteous = 53600,
	ShieldOfTheRighteousBuff = 132403,
	ShiningLight = 327510,
	WordOfGlory = 85673,

	--NightFae
	BlessingofSpring = 328282,
	BlessingofSummer = 328620,
	BlessingofAutumn = 328622,
	BlessingofWinter = 328281
};
local CN = {
	None      = 0,
	Kyrian    = 1,
	Venthyr   = 2,
	NightFae  = 3,
	Necrolord = 4
};

setmetatable(PR, Paladin.spellMeta);

function Paladin:Protection()
	MaxDps:GlowEssences();
	Paladin:ProtectionCooldowns();

	local fd = MaxDps.FrameData;
	fd.targets = MaxDps:SmartAoe();
	local targets = fd.targets;

	if targets < 3 then
		return Paladin:ProtectionSingleTarget()
	else
		return Paladin:ProtectionMultiTarget()
	end
end

function Paladin:ProtectionSingleTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local holyPower = UnitPower('player', HolyPower);

	if talents[PR.DivineToll] and cooldown[PR.DivineToll].ready then
		return PR.DivineToll;
	end

	if cooldown[PR.Consecration].ready and not buff[PR.ConsecrationBuff].up then
		return PR.Consecration;
	end

	if cooldown[PR.Judgment].ready then
		return PR.Judgment;
	end

	if targetHp <= 20 and cooldown[PR.HammerOfWrath].ready and holyPower <= 4 then
		return PR.HammerOfWrath;
	end

	if cooldown[PR.HammerOfWrath].ready and holyPower <= 4 then
		if targetHp <= 20 or buff[PR.AvengingWrath].up then return PR.HammerOfWrath end;
	end

	if cooldown[PR.AvengersShield].ready then
		return PR.AvengersShield;
	end

	if talents[PR.BlessedHammer] and cooldown[PR.BlessedHammer].ready then
		return PR.BlessedHammer;
	end

	if talents[PR.HammerOfTheRighteous] and cooldown[PR.HammerOfTheRighteous].ready then
		return PR.HammerOfTheRighteous;
	end

	if cooldown[PR.Consecration].ready then
		return PR.Consecration;
	end
end

function Paladin:ProtectionMultiTarget()
	local fd = MaxDps.FrameData;
	local covenantId = fd.covenant.covenantId;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local holyPower = UnitPower('player', HolyPower);

	if talents[PR.DivineToll] and cooldown[PR.DivineToll].ready then
		return PR.DivineToll;
	end

	if cooldown[PR.Consecration].ready and not buff[PR.ConsecrationBuff].up then
		return PR.Consecration;
	end

	if cooldown[PR.AvengersShield].ready then
		return PR.AvengersShield;
	end

	if cooldown[PR.Judgment].ready then
		return PR.Judgment;
	end

	if targetHp <= 20 and cooldown[PR.HammerOfWrath].ready and holyPower <= 4 then
		return PR.HammerOfWrath;
	end

	if cooldown[PR.HammerOfWrath].ready and holyPower <= 4 then
		if targetHp <= 20 or buff[PR.AvengingWrath].up then return PR.HammerOfWrath end;
	end

	if talents[PR.BlessedHammer] and cooldown[PR.BlessedHammer].ready then
		return PR.BlessedHammer;
	end

	if talents[PR.HammerOfTheRighteous] and cooldown[PR.HammerOfTheRighteous].ready then
		return PR.HammerOfTheRighteous;
	end

	if cooldown[PR.Consecration].ready then
		return PR.Consecration;
	end
end

function Paladin:ProtectionCooldowns()
	local fd = MaxDps.FrameData;
	local covenantId = fd.covenant.covenantId;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local playerHealthPct = MaxDps:TargetPercentHealth('player') * 100;

	if covenantId == CN.Kyrian then
		MaxDps:GlowCooldown(PR.KyrianDivineToll, cooldown[PR.KyrianDivineToll].ready);
	end

	MaxDps:GlowCooldown(PR.ShieldOfTheRighteous, (not buff[PR.ShieldOfTheRighteousBuff].up or buff[PR.ShieldOfTheRighteousBuff].remains <= 9.5) or (buff[PR.DivinePurpose].up or buff[PR.BastionOfLight].up));

	MaxDps:GlowCooldown(PR.WordOfGlory, playerHealthPct <= 60 and buff[PR.ShiningLight].up);

	if talents[PR.AvengingWrathMightTalent] or talents[PR.AvengingWrathTalent] then
		MaxDps:GlowCooldown(PR.AvengingWrath, cooldown[PR.AvengingWrath].ready);
	end

	if talents[PR.Seraphim] then
		MaxDps:GlowCooldown(PR.Seraphim, cooldown[PR.Seraphim].ready);
	end

	if talents[PR.BastionOfLight] then
		MaxDps:GlowCooldown(PR.BastionOfLight, cooldown[PR.BastionOfLight].ready);
	end

	--Venthyr
	if covenantId == CN.Venthyr and cooldown[PR.AshenHallow].ready then
		MaxDps:GlowCooldown(PR.AshenHallow, cooldown[PR.AshenHallow].ready);
	end

	--NightFae
	if covenantId == CN.NightFae and cooldown[PR.BlessingofSpring].ready then
		MaxDps:GlowCooldown(PR.BlessingofSpring, cooldown[PR.BlessingofSpring].ready);
	end

	if covenantId == CN.NightFae and cooldown[PR.BlessingofSummer].ready then
		MaxDps:GlowCooldown(PR.BlessingofSummer, cooldown[PR.BlessingofSummer].ready);
	end

	if covenantId == CN.NightFae and cooldown[PR.BlessingofAutumn].ready then
		MaxDps:GlowCooldown(PR.BlessingofAutumn, cooldown[PR.BlessingofAutumn].ready);
	end

	if covenantId == CN.NightFae and cooldown[PR.BlessingofWinter].ready then
		MaxDps:GlowCooldown(PR.BlessingofWinter, cooldown[PR.BlessingofWinter].ready);
	end

end