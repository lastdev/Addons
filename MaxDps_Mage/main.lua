--- @type MaxDps
if not MaxDps then
	return ;
end
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local EnumPowerType = Enum.PowerType;
local UnitExists = UnitExists;

local Mage = MaxDps:NewModule('Mage', 'AceEvent-3.0');

-- Fire

local _Meteor = 153561;
local _Pyroclasm = 269651;
local _PhoenixFlames = 257541;
local _Flamestrike = 2120;
local _FlamePatch = 205037;
local _LivingBomb = 44457;
local _DragonsBreath = 31661;
local _FireBlast = 108853;
local _Scorch = 2948;
local _SearingTouch = 269644;
local _Fireball = 133;
local _AlexstraszasFury = 235870;
local _Ignite = 12654;
local _Pyroblast = 11366;
local _BlastWave = 157981;
local _FrostNova = 122;
local _Kindling = 155148;
local _BlazingBarrier = 235313;
local _Firestarter = 205026;
local _Pyromaniac = 205020;

local FR = {
	ArcaneIntellect   = 1459,
	MirrorImage       = 55342,
	Pyroblast         = 11366,
	Combustion        = 190319,
	RuneOfPower       = 116011,
	RuneOfPowerAura   = 116014,
	Firestarter       = 205026,
	FireBlast         = 108853,
	PhoenixFlames     = 257541,
	LivingBomb        = 44457,
	Meteor            = 153561,
	Scorch            = 2948,
	HotStreak         = 48108,
	HeatingUp         = 48107,
	Pyroclasm         = 269650,
	DragonsBreath     = 31661,
	FlameOn           = 205029,
	Flamestrike       = 2120,
	FlamePatch        = 205037,
	SearingTouch      = 269644,
	AlexstraszasFury  = 235870,
	Fireball          = 133,
	Kindling          = 155148,
	BlasterMasterAura = 274598,
};

-- Frost

local _Frostbolt = 116;
local _FingersofFrost = 44544;
local _IceLance = 30455;
local _BrainFreeze = 190446;
local _GlacialSpike = 199786;
local _Flurry = 44614;
local _IcyVeins = 12472;
local _FrozenOrb = 84714;
local _RayofFrost = 205021;
local _Ebonbolt = 257537;
local _CometStorm = 153595;
local _IceNova = 157997;
local _Blizzard = 190356;
local _FreezingRain = 270233;
local _WintersReach = 273346;
local _Shatter = 12982;
local _Freeze = 231596;
local _ConeofCold = 120;
local _IceFloes = 108839;
local _LonelyWinter = 205024;
local _SummonWaterElemental = 31687;
local _Icicles = 205473;
local _SplittingIce = 56377;

local _SpellWhitelist = {
	[_Frostbolt]    = 1,
	[_Ebonbolt]     = 1,
	[_Flurry]       = 1,
	[_IceLance]     = 1,
	[_FrozenOrb]    = 1,
	[_RayofFrost]   = 1,
	[_GlacialSpike] = 1,
};

-- Arcane

local _Evocation = 12051;
local _ArcanePower = 12042;
local _Overpowered = 155147;
local _ArcaneOrb = 153626;
local _NetherTempest = 114923;
local _ArcaneBlast = 30451;
local _RuleofThrees = 264774;
local _PresenceofMind = 205025;
local _ArcaneBarrage = 44425;
local _ArcaneExplosion = 1449;
local _ArcaneMissiles = 5143;
local _Clearcasting = 263725;
local _Amplification = 236628;
local _ChargedUp = 205032;
local _Supernova = 157980;
local _DrainSoul = 198590;
local _Resonance = 205028;
local _Displacement = 195676;

-- Shared

local _MirrorImage = 55342;
local _RuneofPower = 116011;

local A = {
	BlasterMaster = 274596,
}

local spellMeta = {
	__index = function(t, k)
		print('Spell Key ' .. k .. ' not found!');
	end
}

setmetatable(A, spellMeta);
setmetatable(FR, spellMeta);

function Mage:Enable()
	if MaxDps.Spec == 1 then
		MaxDps:Print(MaxDps.Colors.Info .. 'Mage - Arcane');
		MaxDps.NextSpell = Mage.Arcane;
	elseif MaxDps.Spec == 2 then
		MaxDps:Print(MaxDps.Colors.Info .. 'Mage - Fire');
		MaxDps.NextSpell = Mage.Fire;
	elseif MaxDps.Spec == 3 then
		MaxDps:Print(MaxDps.Colors.Info .. 'Mage - Frost');
		MaxDps.NextSpell = Mage.Frost;
		self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED')
	end

	return true;
end

function Mage:Disable()
	self:UnregisterAllEvents();
end

function Mage:UNIT_SPELLCAST_SUCCEEDED(event, unitID, spell, spellId)
	if unitID == 'player' and _SpellWhitelist[spellId] == 1 then
		Mage.lastSpell = spellId;
	end
end

function Mage:Arcane(timeShift, currentSpell, gcd, talents)
	-- Ressource
	local arcaneCharge = UnitPower('player', Enum.PowerType.ArcaneCharges);
	local mana = UnitPower('player', Enum.PowerType.Mana);
	local maxMana = UnitPowerMax('player', Enum.PowerType.Mana);
	local manaPct = mana / maxMana;

	if currentSpell == _ArcaneBlast then
		arcaneCharge = arcaneCharge + 1;
	end

	local ap, apCd = MaxDps:Aura(_ArcanePower, timeShift);
	local rop = MaxDps:Aura(_RuneofPower);
	local _, ropCharges, ropCd = MaxDps:SpellCharges(_RuneofPower, timeShift);

	-- image
	MaxDps:GlowCooldown(_MirrorImage, talents[_MirrorImage] and MaxDps:SpellAvailable(_MirrorImage, timeShift));

	local burnCond = MaxDps:SpellAvailable(_ArcanePower, timeShift) and arcaneCharge >= 4 and
		(ropCharges >= 1 or not talents[_RuneofPower]) and
		((talents[_Overpowered] and manaPct > 0.3) or manaPct > 0.5);

	MaxDps:GlowCooldown(_ArcanePower, burnCond);

	-- burn
	if MaxDps:SpellAvailable(_Evocation, timeShift) then

		if manaPct < 0.05 then
			return _Evocation;
		end

		if talents[_ChargedUp] and MaxDps:SpellAvailable(_ChargedUp, timeShift) and arcaneCharge <= 1 then
			return _ChargedUp;
		end

		if talents[_ArcaneOrb] and MaxDps:SpellAvailable(_ArcaneOrb, timeShift) and arcaneCharge < 4 then
			return _ArcaneOrb;
		end

		if talents[_NetherTempest] and not ap and not rop and not MaxDps:TargetAura(_NetherTempest, timeShift + 3)
			and arcaneCharge >= 4 then
			return _NetherTempest;
		end

		if talents[_RuleofThrees] and talents[_Overpowered] and MaxDps:Aura(_RuleofThrees, timeShift) and
			currentSpell ~= _ArcaneBlast then
			return _ArcaneBlast;
		end

		if talents[_RuneofPower] and ropCharges > 1.6 then
			return _RuneofPower;
		end

		local pom, pomCd = MaxDps:SpellAvailable(_PresenceofMind, timeShift);
		if pom and apCd < 2 and not MaxDps:Aura(_PresenceofMind, timeShift) then
			return _PresenceofMind;
		end

		local cc = MaxDps:Aura(_Clearcasting, timeShift);
		local am = MaxDps:SpellAvailable(_ArcaneMissiles, timeShift);

		if talents[_Amplification] and cc and am and currentSpell ~= _ArcaneMissiles then
			return _ArcaneMissiles;
		end

		if am and cc and not ap and manaPct < 0.95 and currentSpell ~= _ArcaneMissiles then
			return _ArcaneMissiles;
		end

		return _ArcaneBlast;
	end

	if talents[_ChargedUp] and MaxDps:SpellAvailable(_ChargedUp, timeShift) and arcaneCharge == 0 then
		return _ChargedUp;
	end

	if talents[_NetherTempest] and not MaxDps:TargetAura(_NetherTempest, timeShift + 3) and arcaneCharge >= 4 then
		return _NetherTempest;
	end

	if talents[_ArcaneOrb] and MaxDps:SpellAvailable(_ArcaneOrb, timeShift) and arcaneCharge < 4 then
		return _ArcaneOrb;
	end

	if talents[_RuneofPower] and ropCharges > 1.8 and currentSpell ~= _RuneofPower then
		return _RuneofPower;
	end

	if talents[_RuleofThrees] and MaxDps:Aura(_RuleofThrees, timeShift) then
		return _ArcaneBlast;
	end

	if MaxDps:Aura(_Clearcasting, timeShift) and MaxDps:SpellAvailable(_ArcaneMissiles, timeShift) and
		currentSpell ~= _ArcaneMissiles
	then
		return _ArcaneMissiles;
	end

	if manaPct < 0.6 and arcaneCharge >= 4 then
		return _ArcaneBarrage;
	end

	if talents[_Supernova] and MaxDps:SpellAvailable(_Supernova, timeShift) then
		return _Supernova;
	end

	return _ArcaneBlast;
end

function Mage:Fire()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local timeToDie = fd.timeToDie;
	local spellHistory = fd.spellHistory;
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local targets = MaxDps:SmartAoe();
	local combustionRopCutoff = 60;
	local firestarterActive = talents[FR.Firestarter] and targetHp > 90;

	fd.targets = targets;
	fd.targetHp = targetHp;
	fd.combustionRopCutoff = combustionRopCutoff;

	-- mirror_image,if=buff.combustion.down;
	if talents[FR.MirrorImage] then
		MaxDps:GlowCooldown(FR.MirrorImage, cooldown[FR.MirrorImage].ready and not buff[FR.Combustion].up);
	end

	-- rune_of_power,if=talent.firestarter.enabled&firestarter.remains>full_recharge_time|cooldown.combustion.remains>variable.combustion_rop_cutoff&buff.combustion.down|target.time_to_die<cooldown.combustion.remains&buff.combustion.down;
	if talents[FR.RuneOfPower] then
		MaxDps:GlowCooldown(FR.RuneOfPower,
			cooldown[FR.RuneOfPower].ready and
			currentSpell ~= FR.RuneOfPower and
			(
				talents[FR.Firestarter] and firestarterActive or
				cooldown[FR.Combustion].remains > combustionRopCutoff and not buff[FR.Combustion].up or
				cooldown[FR.Combustion].ready or
				timeToDie < cooldown[FR.Combustion].remains and not buff[FR.Combustion].up
			)
		);
	end

	-- combustion,use_off_gcd=1,use_while_casting=1,if=azerite.blaster_master.enabled&((action.meteor.in_flight&action.meteor.in_flight_remains<0.2)|!talent.meteor.enabled|prev_gcd.1.meteor)&(buff.rune_of_power.up|!talent.rune_of_power.enabled);
	MaxDps:GlowCooldown(FR.Combustion,
		cooldown[FR.Combustion].ready and (
			buff[FR.RuneOfPowerAura].up or currentSpell == FR.RuneOfPower or not talents[FR.RuneOfPower]
		)
	);


	-- call_action_list,name=combustion_phase,if=(talent.rune_of_power.enabled&cooldown.combustion.remains<=action.rune_of_power.cast_time|cooldown.combustion.ready)&!firestarter.active|buff.combustion.up;
	if buff[FR.Combustion].up then
		local result = Mage:FireCombustionPhase();
		if result then return result; end
	end

	-- call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down;
	if buff[FR.RuneOfPowerAura].up and not buff[FR.Combustion].up then
		local result = Mage:FireRopPhase();
		if result then return result; end
	end

	-- call_action_list,name=standard_rotation;
	return Mage:FireStandardRotation();
end

function Mage:FireActiveTalents()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local timeToDie = fd.timeToDie;
	local targetHp = fd.targetHp;
	local firestarterActive = fd.firestarterActive;

	-- living_bomb,if=active_enemies>1&buff.combustion.down&(cooldown.combustion.remains>cooldown.living_bomb.duration|cooldown.combustion.ready);
	if cooldown[FR.LivingBomb].ready and
		targets > 1 and
		not buff[FR.Combustion].up and
		(cooldown[FR.Combustion].remains > cooldown[FR.LivingBomb].duration or cooldown[FR.Combustion].ready)
	then
		return FR.LivingBomb;
	end

	-- meteor,if=buff.rune_of_power.up&(firestarter.remains>cooldown.meteor.duration|!firestarter.active)|cooldown.rune_of_power.remains>target.time_to_die&action.rune_of_power.charges<1|(cooldown.meteor.duration<cooldown.combustion.remains|cooldown.combustion.ready)&!talent.rune_of_power.enabled&(cooldown.meteor.duration<firestarter.remains|!talent.firestarter.enabled|!firestarter.active);
	if talents[FR.Meteor] and cooldown[FR.Meteor].ready and (
		buff[FR.RuneOfPowerAura].up and not firestarterActive or
		cooldown[FR.RuneOfPower].remains > timeToDie and cooldown[FR.RuneOfPower].charges < 1 or
		(cooldown[FR.Meteor].duration < cooldown[FR.Combustion].remains or cooldown[FR.Combustion].ready) and
		not talents[FR.RuneOfPower] and
		(not talents[FR.Firestarter] or not firestarterActive)
	) then
		return FR.Meteor;
	end
end

function Mage:FireBmCombustionPhase()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local targets = fd.targets;
	local spellHistory = fd.spellHistory;
	local gcd = fd.gcd;
	local gcdRemains = fd.gcdRemains;

	-- living_bomb,if=buff.combustion.down&active_enemies>1;
	if cooldown[FR.LivingBomb].ready and not buff[FR.Combustion].up and targets > 1 then
		return FR.LivingBomb;
	end

	-- fire_blast,use_while_casting=1,if=buff.blaster_master.down&(talent.rune_of_power.enabled&action.rune_of_power.executing&action.rune_of_power.execute_remains<0.6|(cooldown.combustion.ready|buff.combustion.up)&!talent.rune_of_power.enabled&!action.pyroblast.in_flight&!action.fireball.in_flight);
	if cooldown[FR.FireBlast].ready and
		not buff[FR.BlasterMasterAura].up and
		(
			talents[FR.RuneOfPower] and currentSpell == FR.RuneOfPower or
			(cooldown[FR.Combustion].ready or buff[FR.Combustion].up) and not talents[FR.RuneOfPower]
		)
	then
		return FR.FireBlast;
	end

	-- call_action_list,name=active_talents;
	local result = Mage:FireActiveTalents();
	if result then return result; end

	-- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up;
	if currentSpell ~= FR.Pyroblast and currentSpell == FR.Scorch and buff[FR.HeatingUp].up then
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.hot_streak.up;
	if currentSpell ~= FR.Pyroblast and buff[FR.HotStreak].up then
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.pyroclasm.react&cast_time<buff.combustion.remains;
	if currentSpell ~= FR.Pyroblast and buff[FR.Pyroclasm].up and timeShift < buff[FR.Combustion].remains then
		return FR.Pyroblast;
	end

	-- phoenix_flames;
	if talents[FR.PhoenixFlames] and cooldown[FR.PhoenixFlames].ready then
		return FR.PhoenixFlames;
	end

	-- fire_blast,use_off_gcd=1,if=buff.blaster_master.stack=1&buff.hot_streak.down&!buff.pyroclasm.react&prev_gcd.1.pyroblast&(buff.blaster_master.remains<0.15|gcd.remains<0.15);
	if cooldown[FR.FireBlast].ready and
		buff[FR.BlasterMasterAura].count == 1 and
		not buff[FR.HotStreak].up and
		not buff[FR.Pyroclasm].up and
		(spellHistory[1] == FR.Pyroblast or currentSpell == FR.Pyroblast) and
		(buff[FR.BlasterMasterAura].remains < 0.3)
	then
		return FR.FireBlast;
	end

	-- fire_blast,use_while_casting=1,if=buff.blaster_master.stack=1&(action.scorch.executing&action.scorch.execute_remains<0.15|buff.blaster_master.remains<0.15);
	if cooldown[FR.FireBlast].ready and
		buff[FR.BlasterMasterAura].count == 1 and
		(currentSpell == FR.Scorch or buff[FR.BlasterMasterAura].remains < 0.3)
	then
		return FR.FireBlast;
	end

	-- scorch,if=buff.hot_streak.down&(cooldown.fire_blast.remains<cast_time|action.fire_blast.charges>0);
	if currentSpell ~= FR.Scorch and
		not buff[FR.HotStreak].up and
		(cooldown[FR.FireBlast].remains < 1.5 or cooldown[FR.FireBlast].charges >= 1)
	then
		return FR.Scorch;
	end

	-- fire_blast,use_while_casting=1,use_off_gcd=1,if=buff.blaster_master.stack>1&(prev_gcd.1.scorch&!buff.hot_streak.up&!action.scorch.executing|buff.blaster_master.remains<0.15);
	if cooldown[FR.FireBlast].ready and (
		buff[FR.BlasterMasterAura].count > 1 and
		(
			currentSpell == FR.Scorch and
			not buff[FR.HotStreak].up or
			buff[FR.BlasterMasterAura].remains < 0.3
		)
	) then
		return FR.FireBlast;
	end

	-- living_bomb,if=buff.combustion.remains<gcd.max&active_enemies>1;
	if cooldown[FR.LivingBomb].ready and buff[FR.Combustion].remains < gcd and targets > 1 then
		return FR.LivingBomb;
	end

	-- dragons_breath,if=buff.combustion.remains<gcd.max;
	if cooldown[FR.DragonsBreath].ready and buff[FR.Combustion].remains < gcd then
		return FR.DragonsBreath;
	end

	-- scorch;
	return FR.Scorch;
end

function Mage:FireCombustionPhase()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local targets = fd.targets;
	local spellHistory = fd.spellHistory;
	local targetHp = fd.targetHp;
	local gcd = fd.gcd;

	-- call_action_list,name=bm_combustion_phase,if=azerite.blaster_master.enabled&talent.flame_on.enabled;
	if azerite[A.BlasterMaster] > 0 and talents[FR.FlameOn] then
		local result = Mage:FireBmCombustionPhase();
		if result then return result; end
	end

	-- call_action_list,name=active_talents;
	local result = Mage:FireActiveTalents();
	if result then return result; end

	-- flamestrike,if=((talent.flame_patch.enabled&active_enemies>2)|active_enemies>6)&buff.hot_streak.react;
	if currentSpell ~= FR.Flamestrike and
		((talents[FR.FlamePatch] and targets > 2) or targets > 6) and
		buff[FR.HotStreak].up
	then
		return FR.Flamestrike;
	end

	-- pyroblast,if=buff.pyroclasm.react&buff.combustion.remains>cast_time;
	if currentSpell ~= FR.Pyroblast and buff[FR.Pyroclasm].up and buff[FR.Combustion].remains > 4.5 then -- 100 OK
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.hot_streak.react;
	if currentSpell ~= FR.Pyroblast and buff[FR.HotStreak].up then -- 100 OK
		return FR.Pyroblast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(!azerite.blaster_master.enabled|!talent.flame_on.enabled)&((buff.combustion.up&(buff.heating_up.react&!action.pyroblast.in_flight&!action.scorch.executing)|(action.scorch.execute_remains&buff.heating_up.down&buff.hot_streak.down&!action.pyroblast.in_flight)));
	if cooldown[FR.FireBlast].ready and (
		(azerite[A.BlasterMaster] == 0 or not talents[FR.FlameOn]) and
		(
			buff[FR.Combustion].up and (buff[FR.HeatingUp].up and currentSpell ~= FR.Scorch) or
			(currentSpell == FR.Scorch and not buff[FR.HeatingUp].up and not buff[FR.HotStreak].up)
		)
	) then
		return FR.FireBlast;
	end

	-- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up;
	if currentSpell ~= FR.Pyroblast and currentSpell == FR.Scorch and buff[FR.HeatingUp].up then -- 100 OK
		return FR.Pyroblast;
	end

	-- phoenix_flames;
	if talents[FR.PhoenixFlames] and cooldown[FR.PhoenixFlames].ready then -- 100 OK
		return FR.PhoenixFlames;
	end

	-- scorch,if=buff.combustion.remains>cast_time&buff.combustion.up|buff.combustion.down;
	if currentSpell ~= FR.Scorch and (
		buff[FR.Combustion].remains > 1.5 and buff[FR.Combustion].up or
		not buff[FR.Combustion].up
	) then -- 100 OK
		return FR.Scorch;
	end

	-- living_bomb,if=buff.combustion.remains<gcd.max&active_enemies>1;
	if cooldown[FR.LivingBomb].ready and buff[FR.Combustion].remains < gcd and targets > 1 then -- 100 OK
		return FR.LivingBomb;
	end

	-- dragons_breath,if=buff.combustion.remains<gcd.max&buff.combustion.up;
	if cooldown[FR.DragonsBreath].ready and buff[FR.Combustion].remains < gcd and buff[FR.Combustion].up then -- 100 OK
		return FR.DragonsBreath;
	end

	-- scorch,if=target.health.pct<=30&talent.searing_touch.enabled;
	if targetHp <= 30 and talents[FR.SearingTouch] then -- 100 OK
		return FR.Scorch;
	end
end

function Mage:FireRopPhase()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local spellHistory = fd.spellHistory;
	local targets = fd.targets;
	local targetHp = fd.targetHp;
	local firestarterActive = fd.firestarterActive;

	-- rune_of_power;
	--if talents[FR.RuneOfPower] and cooldown[FR.RuneOfPower].ready and currentSpell ~= FR.RuneOfPower then
	--	return FR.RuneOfPower;
	--end

	-- flamestrike,if=((talent.flame_patch.enabled&active_enemies>1)|active_enemies>4)&buff.hot_streak.react;
	if currentSpell ~= FR.Flamestrike and
		((talents[FR.FlamePatch] and targets > 1) or targets > 4) and
		buff[FR.HotStreak].up
	then
		return FR.Flamestrike;
	end

	-- pyroblast,if=buff.hot_streak.react;
	if currentSpell ~= FR.Pyroblast and buff[FR.HotStreak].up then
		return FR.Pyroblast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0|firestarter.active&buff.rune_of_power.up)&(!buff.heating_up.react&!buff.hot_streak.react&!prev_off_gcd.fire_blast&(action.fire_blast.charges>=2|(action.phoenix_flames.charges>=1&talent.phoenix_flames.enabled)|(talent.alexstraszas_fury.enabled&cooldown.dragons_breath.ready)|(talent.searing_touch.enabled&target.health.pct<=30)|(talent.firestarter.enabled&firestarter.active)));
	if cooldown[FR.FireBlast].ready and (
		(cooldown[FR.Combustion].remains > 0 or firestarterActive and buff[FR.RuneOfPowerAura].up) and
		(
			not buff[FR.HeatingUp].up and
			not buff[FR.HotStreak].up and
			not spellHistory[1] == FR.FireBlast and
			(
				cooldown[FR.FireBlast].charges >= 2 or
				(cooldown[FR.PhoenixFlames].charges >= 1 and talents[FR.PhoenixFlames]) or
				(talents[FR.AlexstraszasFury] and cooldown[FR.DragonsBreath].ready) or
				(talents[FR.SearingTouch] and targetHp <= 30) or
				(talents[FR.Firestarter] and firestarterActive)
			)
		)
	) then
		return FR.FireBlast;
	end

	-- call_action_list,name=active_talents;
	local result = Mage:FireActiveTalents();
	if result then return result; end

	-- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains&buff.rune_of_power.remains>cast_time;
	if currentSpell ~= FR.Pyroblast and
		buff[FR.Pyroclasm].up and
		timeShift < buff[FR.Pyroclasm].remains and
		buff[FR.RuneOfPowerAura].remains > timeShift
	then
		return FR.Pyroblast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0|firestarter.active&buff.rune_of_power.up)&(buff.heating_up.react&(target.health.pct>=30|!talent.searing_touch.enabled));
	if cooldown[FR.FireBlast].ready and
		(cooldown[FR.Combustion].remains > 0 or firestarterActive and buff[FR.RuneOfPowerAura].up) and
		(buff[FR.HeatingUp].up and (targetHp >= 30 or not talents[FR.SearingTouch]))
	then
		return FR.FireBlast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0|firestarter.active&buff.rune_of_power.up)&talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.heating_up.react&!buff.hot_streak.react);
	if cooldown[FR.FireBlast].ready and
		(cooldown[FR.Combustion].remains > 0 or firestarterActive and buff[FR.RuneOfPowerAura].up) and
		talents[FR.SearingTouch] and
		targetHp <= 30 and
		(buff[FR.HeatingUp].up and not currentSpell == FR.Scorch or not buff[FR.HeatingUp].up and not buff[FR.HotStreak].up)
	then
		return FR.FireBlast;
	end

	-- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&(!talent.flame_patch.enabled|active_enemies=1);
	if currentSpell ~= FR.Pyroblast and
		spellHistory[1] == FR.Scorch and
		buff[FR.HeatingUp].up and
		talents[FR.SearingTouch] and
		targetHp <= 30 and
		(not talents[FR.FlamePatch] or targets <= 1)
	then
		return FR.Pyroblast;
	end

	-- phoenix_flames,if=!prev_gcd.1.phoenix_flames&buff.heating_up.react;
	if talents[FR.PhoenixFlames] and
		not spellHistory[1] == FR.PhoenixFlames and
		buff[FR.HeatingUp].up
	then
		return FR.PhoenixFlames;
	end

	-- scorch,if=target.health.pct<=30&talent.searing_touch.enabled;
	if targetHp <= 30 and talents[FR.SearingTouch] then
		return FR.Scorch;
	end

	-- dragons_breath,if=active_enemies>2;
	if cooldown[FR.DragonsBreath].ready and targets > 2 then
		return FR.DragonsBreath;
	end

	-- flamestrike,if=(talent.flame_patch.enabled&active_enemies>2)|active_enemies>5;
	if currentSpell ~= FR.Flamestrike and (
		(talents[FR.FlamePatch] and targets > 2) or targets > 5
	) then
		return FR.Flamestrike;
	end

	-- fireball;
	return FR.Fireball;
end

function Mage:FireStandardRotation()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local azerite = fd.azerite;
	local timeShift = fd.timeShift;
	local targets = fd.targets;
	local spellHistory = fd.spellHistory;
	local targetHp = fd.targetHp;
	local timeToDie = fd.timeToDie;
	local firestarterActive = fd.firestarterActive;
	local combustionRopCutoff = fd.combustionRopCutoff;

	local playerMoving = GetUnitSpeed('player') > 0;

	-- flamestrike,if=((talent.flame_patch.enabled&active_enemies>1&!firestarter.active)|active_enemies>4)&buff.hot_streak.react;
	if currentSpell ~= FR.Flamestrike and
		((talents[FR.FlamePatch] and targets > 1 and not firestarterActive) or targets > 4) and
		buff[FR.HotStreak].up
	then
		return FR.Flamestrike;
	end

	-- pyroblast,if=buff.hot_streak.react&buff.hot_streak.remains<action.fireball.execute_time;
	if buff[FR.HotStreak].up and buff[FR.HotStreak].remains < 2 then
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.hot_streak.react&(prev_gcd.1.fireball|firestarter.active|action.pyroblast.in_flight);
	if currentSpell ~= FR.Pyroblast and
		buff[FR.HotStreak].up and
		(currentSpell == FR.Fireball or firestarterActive)
	then
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.hot_streak.react&target.health.pct<=30&talent.searing_touch.enabled;
	if buff[FR.HotStreak].up and targetHp <= 30 and talents[FR.SearingTouch] then
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains;
	if currentSpell ~= FR.Pyroblast and buff[FR.Pyroclasm].up and buff[FR.Pyroclasm].remains >= 5 then
		return FR.Pyroblast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0&buff.rune_of_power.down|firestarter.active)&!talent.kindling.enabled&!variable.fire_blast_pooling&(((action.fireball.executing|action.pyroblast.executing)&(buff.heating_up.react|firestarter.active&!buff.hot_streak.react&!buff.heating_up.react))|(talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.hot_streak.react&!buff.heating_up.react&action.scorch.executing&!action.pyroblast.in_flight&!action.fireball.in_flight))|(firestarter.active&(action.pyroblast.in_flight|action.fireball.in_flight)&!buff.heating_up.react&!buff.hot_streak.react));
	if cooldown[FR.FireBlast].charges >= cooldown[FR.FireBlast].maxCharges - 0.5 and
		not buff[FR.HotStreak].up and
		buff[FR.HeatingUp].up
	then
		return FR.FireBlast;
	end

	-- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&((talent.flame_patch.enabled&active_enemies=1&!firestarter.active)|(active_enemies<4&!talent.flame_patch.enabled));
	if currentSpell == FR.Scorch and
		buff[FR.HeatingUp].up and
		talents[FR.SearingTouch] and
		targetHp <= 30 and
		((talents[FR.FlamePatch] and targets == 1 and not firestarterActive) or (targets < 4 and not talents[FR.FlamePatch]))
	then
		return FR.Pyroblast;
	end

	-- phoenix_flames,if=(buff.heating_up.react|(!buff.hot_streak.react&(action.fire_blast.charges>0|talent.searing_touch.enabled&target.health.pct<=30)))&!variable.phoenix_pooling;
	if talents[FR.PhoenixFlames] and (
		buff[FR.HeatingUp].up or
		(
			not buff[FR.HotStreak].up and (
				cooldown[FR.FireBlast].charges > 0 or talents[FR.SearingTouch] and targetHp <= 30
			)
		)
	) then
		return FR.PhoenixFlames;
	end

	-- call_action_list,name=active_talents;
	local result = Mage:FireActiveTalents();
	if result then return result; end

	-- dragons_breath,if=active_enemies>1;
	if cooldown[FR.DragonsBreath].ready and targets > 1 then
		return FR.DragonsBreath;
	end

	-- scorch,if=target.health.pct<=30&talent.searing_touch.enabled;
	if targetHp <= 30 and talents[FR.SearingTouch] then
		return FR.Scorch;
	end

	-- fireball;
	if not playerMoving then
		return FR.Fireball;
	end

	-- scorch;
	return FR.Scorch;
end

function Mage:Frost(timeShift, currentSpell, gcd, talents)
	local rop = MaxDps:Aura(_RuneofPower);
	local ici, iciCharges = MaxDps:Aura(_Icicles, timeShift);

	if currentSpell == _Frostbolt then
		iciCharges = iciCharges + 1;
	end

	local frozenOrb = MaxDps:FindSpell(198149) and 198149 or _FrozenOrb;

	MaxDps:GlowCooldown(_MirrorImage, talents[_MirrorImage] and MaxDps:SpellAvailable(_MirrorImage, timeShift));
	MaxDps:GlowCooldown(_IcyVeins, MaxDps:SpellAvailable(_IcyVeins, timeShift));

	if not talents[_LonelyWinter] and not UnitExists('pet')
		and MaxDps:SpellAvailable(_SummonWaterElemental, timeShift)
		and currentSpell ~= _SummonWaterElemental
	then
		return _SummonWaterElemental;
	end

	--Ice Lance after every Flurry cast. @TODO
	if Mage.lastSpell == _Flurry or currentSpell == _Flurry then
		return _IceLance;
	end

	if MaxDps:Aura(_BrainFreeze, timeShift) and
		(
			talents[_GlacialSpike] and (
				(iciCharges >= 5 and currentSpell == _GlacialSpike) or
				(iciCharges <= 3 and currentSpell == _Frostbolt)
			)
				or
			not talents[_GlacialSpike] and (
				currentSpell == _Ebonbolt or
				currentSpell == _Frostbolt
			)
		)
	then
		return _Flurry;
	end

	if MaxDps:SpellAvailable(frozenOrb, timeShift) then
		return frozenOrb;
	end

	if MaxDps:Aura(_FingersofFrost, timeShift) then
		return _IceLance;
	end

	if talents[_RayofFrost] and MaxDps:SpellAvailable(_RayofFrost, timeShift) and currentSpell ~= _RayofFrost then
		return _RayofFrost;
	end

	if talents[_CometStorm] and MaxDps:SpellAvailable(_CometStorm, timeShift) then
		return _CometStorm;
	end

	if talents[_Ebonbolt] then
		if not talents[_GlacialSpike] and MaxDps:SpellAvailable(_Ebonbolt, timeShift) and currentSpell ~= _Ebonbolt then
			return _Ebonbolt;
		end

		if talents[_GlacialSpike] and MaxDps:SpellAvailable(_Ebonbolt, timeShift) and iciCharges >= 5
			and not MaxDps:Aura(_BrainFreeze, timeShift) and currentSpell ~= _Ebonbolt
		then
			return _Ebonbolt;
		end
	end

	local targets = MaxDps:TargetsInRange(_IceLance);
	if talents[_GlacialSpike] and MaxDps:SpellAvailable(_GlacialSpike, timeShift) and iciCharges >= 5 and
		currentSpell ~= _GlacialSpike and (
		(talents[_SplittingIce] and targets >= 2) or MaxDps:Aura(_BrainFreeze, timeShift) or currentSpell == _Ebonbolt
	) then
		return _GlacialSpike;
	end

	return _Frostbolt;
end

function Mage:ArcaneCharge()
	local _, _, _, charges = UnitAura('player', 'Arcane Charge', nil, 'PLAYER|HARMFUL');
	if charges == nil then
		charges = 0;
	end
	return charges;
end

function Mage:Ignite()
	return select(15, UnitAura('target', 'Ignite', nil, 'HARMFUL'));
end