local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Paladin = addonTable.Paladin;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local HolyPower = Enum.PowerType.HolyPower;
local RT = {
	AvengingWrath = 31884,
	AvengingWrathTalent = 384376,
	AvengingWrathMightTalent = 384442,
	BladeOfJustice = 184575,
	Consecration = 26573,
	ConsecrationBuff = 188370,
	Crusade = 231895,
	CrusadeTalent = 384392,
	CrusaderStrike = 35395,
	DivinePurpose = 223819,
	DivineStorm = 53385,
	DivineToll = 375576,
	EmpyreanPower = 326733,
	ExecutionSentence = 343527,
	Exorcism = 383185,
	FlashOfLight = 19750,
	FinalReckoning = 343721,
	FinalVerdict = 383328,
	GreaterJudgment = 231663,
	HammerOfWrath = 24275,
	HolyAvenger = 105809,
	ImprovedCrusaderStrike = 383254,
	Judgment = 20271,
	JudgmentDebuff = 197277,
	RadiantDecree = 383469,
	RadiantDecreeTalent = 384052,
	SelflessHealer = 114250,
	SelflessHealerTalent = 85804,
	Seraphim = 152262,
	TemplarsVerdict = 85256,
	WakeOfAshes = 255937
};
setmetatable(RT, Paladin.spellMeta);

function Paladin:Retribution()
	-- Essences
	MaxDps:GlowEssences();
	Paladin:RetributionCooldowns(MaxDps:TargetPercentHealth('player') * 100)

	local fd = MaxDps.FrameData;
	fd.targets = MaxDps:SmartAoe();
	local targets = fd.targets;

	if targets < 2 then
		return Paladin:RetributionSingleTarget()
	else
		return Paladin:RetributionMultiTarget()
	end
end

function Paladin:RetributionSingleTarget()
	local fd = MaxDps.FrameData;
	local holyPower = UnitPower('player', HolyPower);
	fd.holyPower = holyPower;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targetHp = MaxDps:TargetPercentHealth() * 100;

	if talents[RT.Seraphim] and cooldown[RT.Seraphim].ready and holyPower >=3 then
		return RT.Seraphim;
	end

	if talents[RT.ExecutionSentence] and holyPower >= 3 and cooldown[RT.ExecutionSentence].ready then
		return RT.ExecutionSentence;
	end

	if talents[RT.RadiantDecreeTalent] and holyPower >= 3 and cooldown[RT.RadiantDecree].ready then
		return RT.RadiantDecree;
	end

	if holyPower >= 3 or buff[RT.DivinePurpose].up then
		if talents[RT.FinalVerdict] then
			if cooldown[RT.FinalVerdict].ready then return RT.FinalVerdict end;
		elseif cooldown[RT.TemplarsVerdict].ready then
			return RT.TemplarsVerdict;
		end
	end

	if talents[RT.DivineToll] and cooldown[RT.DivineToll].ready and not debuff[RT.JudgmentDebuff].up then
		return RT.DivineToll;
	end

	if not talents[RT.RadiantDecreeTalent] and talents[RT.WakeOfAshes] and cooldown[RT.WakeOfAshes].ready and holyPower <= 2 then
		return RT.WakeOfAshes;
	end

	if talents[RT.Exorcism] and cooldown[RT.Exorcism].ready then
		return RT.Exorcism;
	end

	if cooldown[RT.Judgment].ready and holyPower <= 4 and not debuff[RT.GreaterJudgment].up then
		return RT.Judgment;
	end

	if targetHp <= 20 and cooldown[RT.HammerOfWrath].ready and holyPower <= 4 then
		return RT.HammerOfWrath;
	end

	if cooldown[RT.HammerOfWrath].ready and holyPower <= 4 then
		if targetHp <= 20 or buff[RT.AvengingWrath].up or buff[RT.Crusade].up then return RT.HammerOfWrath end;
	end

	if talents[RT.BladeOfJustice] and cooldown[RT.BladeOfJustice].ready and holyPower <= 3 then
		return RT.BladeOfJustice;
	end

	if buff[RT.EmpyreanPower].up and not debuff[RT.JudgmentDebuff].up then
		return RT.DivineStorm;
	end

	if talents[RT.ImprovedCrusaderStrike] and cooldown[RT.CrusaderStrike].charges > 1 then
		return RT.CrusaderStrike;
	end

	if cooldown[RT.Consecration].ready then
		return RT.Consecration;
	end

	if cooldown[RT.CrusaderStrike].ready then
		return RT.CrusaderStrike;
	end
end


function Paladin:RetributionMultiTarget()
	local fd = MaxDps.FrameData;
	local holyPower = UnitPower('player', HolyPower);
	fd.holyPower = holyPower;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targetHp = MaxDps:TargetPercentHealth() * 100;

	if talents[RT.Seraphim] and cooldown[RT.Seraphim].ready and holyPower >=3 then
		return RT.Seraphim;
	end

	if talents[RT.RadiantDecreeTalent] and holyPower >= 3 and cooldown[RT.RadiantDecree].ready then
		return RT.RadiantDecree;
	end

	if holyPower == 5 then
		return RT.DivineStorm;
	end

	if talents[RT.DivineToll] and cooldown[RT.DivineToll].ready then
		return RT.DivineToll;
	end

	if not talents[RT.RadiantDecreeTalent] and talents[RT.WakeOfAshes] and cooldown[RT.WakeOfAshes].ready and holyPower <= 2 then
		return RT.WakeOfAshes;
	end

	if talents[RT.Exorcism] and cooldown[RT.Exorcism].ready and buff[RT.ConsecrationBuff].up then
		return RT.Exorcism;
	end

	if cooldown[RT.Judgment].ready and holyPower <= 4 then
		return RT.Judgment;
	end

	if targetHp <= 20 and cooldown[RT.HammerOfWrath].ready and holyPower <= 4 then
		return RT.HammerOfWrath;
	end

	if cooldown[RT.HammerOfWrath].ready and holyPower <= 4 then
		if targetHp <= 20 or buff[RT.AvengingWrath].up or buff[RT.Crusade].up then return RT.HammerOfWrath end;
	end

	if talents[RT.BladeOfJustice] and cooldown[RT.BladeOfJustice].ready and holyPower <= 3 then
		return RT.BladeOfJustice;
	end

	if cooldown[RT.Consecration].ready then
		return RT.Consecration;
	end

	if buff[RT.EmpyreanPower].up then
		return RT.DivineStorm;
	end

	if talents[RT.ImprovedCrusaderStrike] and cooldown[RT.CrusaderStrike].charges > 1 then
		return RT.CrusaderStrike;
	end

	if (holyPower == 3 or holyPower == 4) then
		return RT.DivineStorm;
	end

	if cooldown[RT.CrusaderStrike].ready then
		return RT.CrusaderStrike;
	end
end

---@param playerHealthPct number
function Paladin:RetributionCooldowns(playerHealthPct)
	local holyPower = UnitPower('player', HolyPower);
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;

	-- Cooldowns
	MaxDps:GlowCooldown(RT.FlashOfLight, talents[RT.SelflessHealerTalent] and buff[RT.SelflessHealer].count > 3 and playerHealthPct < 80);

	if talents[RT.CrusadeTalent] then
		MaxDps:GlowCooldown(RT.Crusade, cooldown[RT.Crusade].ready and holyPower >= 3);
	end

	if talents[RT.AvengingWrathMightTalent] or talents[RT.AvengingWrathTalent] then
		MaxDps:GlowCooldown(RT.AvengingWrath, cooldown[RT.AvengingWrath].ready and holyPower >= 3)
	end

	if talents[RT.FinalReckoning] and holyPower >=3 then
		MaxDps:GlowCooldown(RT.FinalReckoning, cooldown[RT.FinalReckoning].ready and holyPower >= 3);
	end

	if talents[RT.HolyAvenger] then
		MaxDps:GlowCooldown(RT.HolyAvenger, cooldown[RT.HolyAvenger].ready);
	end
end