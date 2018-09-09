-- Fire
local _Combustion = 190319;
local _PhoenixsFlames = 194466;
local _FlameOn = 205029;
local _Flamestrike = 2120;
local _HotStreak = 195283;
local _HotStreakAura = 48108;
local _Pyroblast = 11366;
local _Meteor = 153561;
local _LivingBomb = 44457;
local _FireBlast = 108853;
local _DragonsBreath = 31661;
local _HeatingUp = 48107;
local _Fireball = 133;
local _Scorch = 2948;
local _IceFloes = 108839;
local _Ignite = 12654;
local _BlastWave = 157981;
local _Cinderstorm = 198929;
local _FrostNova = 122;
local _Blink = 1953;
local _IceBlock = 45438;
local _Kindling = 155148;
local _IceBarrier = 11426;
local _Shimmer = 212653;
local _Pyromaniac = 205020;
local _AlexstraszasFury = 235870;

-- Frost
local _IcyVeins = 12472;
local _RayofFrost = 205021;
local _IceLance = 30455;
local _FingersofFrost = 112965;
local _FrostBomb = 112948;
local _FrozenOrb = 84714;
local _Freeze = 33395;
local _Ebonbolt = 214634;
local _BrainFreeze = 190447;
local _Flurry = 44614;
local _Frostbolt = 116;
local _WaterJet = 135029;
local _IceNova = 157997;
local _CometStorm = 153595;
local _Blizzard = 190356;
local _ArcticGale = 205038;
local _GlacialSpike = 199786;
local _IncantersFlow = 1463;
local _ThermalVoid = 155149;
local _SplittingIce = 56377;
local _IceFloes = 108839;
local _Blink = 1953;
local _IceBarrier = 11426;
local _Shimmer = 212653;
local _SummonWaterElemental = 31687;
local _Icicles = 205473;
local _LonelyWinter = 205024;
local _ChainReaction = 195419;
local _WintersChill = 228358;

-- Arcane

-- Offensive Abilities
local _MarkOfAluneth  = 224968;
local _Arcane_Explosion = 1449;
local _Arcane_Missiles  = 5143;
local _Arcane_Barrage   = 44425;
local _Arcane_Blast     = 30451;

-- Offensive Cooldowns
local _Time_Warp = 80353 ;
local _Arcance_Power = 12042;
local _Presence_of_Mind = 205025;

-- Defensive Cooldowns
local _Ice_Block = 45438;
local _Prismatic_Barrier = 234550;

-- talent
local _MirrorImage = 55342;
local _RuneofPower = 116011;

-- Utils
local _Evocation = 12051;

-- Aura
local _RhoninsAssaulting = 208081;
local _ArcaneMissilesAura = 79683;

-- CDs

local _MirrorImage = 55342;
local _RuneofPower = 116011;


-- Legendary items
local _isKoralon = false;
local _isDarckli = false;

_BaseArcaneBlastCost = 3200;
local talents = {};

MaxDps.Mage = {};
function MaxDps.Mage.CheckTalents()
	_isKoralon = IsEquippedItem(132454);
	_isDarckli = IsEquippedItem(132863);
end

function MaxDps:EnableRotationModule(mode)
	mode = mode or 1;
	MaxDps.Description = 'Mage [Fire]';
	MaxDps.ModuleOnEnable = MaxDps.Mage.CheckTalents;
	if mode == 1 then
		MaxDps.NextSpell = MaxDps.Mage.Arcane;
	end;
	if mode == 2 then
		MaxDps.NextSpell = MaxDps.Mage.Fire;
	end;
	if mode == 3 then
		MaxDps.NextSpell = MaxDps.Mage.Frost;
	end;
end

function MaxDps.Mage.Arcane(_, timeShift, currentSpell, gcd, talents)
	-- Ressource
	local arcaneCharge = UnitPower('player', SPELL_POWER_ARCANE_CHARGES);
	local mana = UnitMana("player");
	local maxMana = UnitManaMax("player");

	local freeBlast = MaxDps:Aura(_RhoninsAssaulting);
	local _, _, maCharge = MaxDps:Aura(_ArcaneMissilesAura);

	-- Cooldowns are included in rotation because of burn phase
	-- _Arcance_Power
	-- MaxDps:GlowCooldown(_Arcance_Power, MaxDps:SpellAvailable(_Arcance_Power, timeShift));
	-- _Presence_of_Mind
	-- MaxDps:GlowCooldown(_Presence_of_Mind, MaxDps:SpellAvailable(_Presence_of_Mind, timeShift));
	-- rune
	MaxDps:GlowCooldown(_RuneofPower, talents[_RuneofPower] and MaxDps:SpellAvailable(_RuneofPower, timeShift));
	-- image
	MaxDps:GlowCooldown(_MirrorImage, talents[_MirrorImage] and MaxDps:SpellAvailable(_MirrorImage, timeShift));

	-- _Ice_Block
	-- MaxDps:GlowCooldown(_Ice_Block, MaxDps:SpellAvailable(_Ice_Block, timeShift));
	-- _Prismatic_Barrier
	-- MaxDps:GlowCooldown(_Prismatic_Barrier, MaxDps:SpellAvailable(_Prismatic_Barrier, timeShift));

	-- legendary buff
	if freeBlast then
		return _Arcane_Blast;
	end

	-- burn
	if MaxDps:SpellAvailable(_Evocation, timeShift) then
		-- Arcane Missiles (at three stacks)
		if maCharge >= 3 then
			return _Arcane_Missiles;
		end

		-- Mark of Aluneth
		if MaxDps:SpellAvailable(_MarkOfAluneth, timeShift) and not MaxDps:SameSpell(currentSpell, _MarkOfAluneth) then
			return _MarkOfAluneth;
		end

		if mana < 200000 then
			return _Evocation;
		end

		-- Build to four Arcane Charges ( Arcane Blast x 4, Charged Up, etc)
		if MaxDps:SpellAvailable(_Presence_of_Mind, timeShift) then
			if arcaneCharge <= 0 or not MaxDps:SpellAvailable(_Arcane_Barrage, timeShift) then
				return _Presence_of_Mind;
			else
				return _Arcane_Barrage;
			end
		end

		-- on est ici à arcaneCharge = 4
		if arcaneCharge > 3 then
			-- Rune of Power (talent)
			-- Mirror Image (talent)
			-- Arcane Power
			MaxDps:GlowCooldown(_Arcance_Power, MaxDps:SpellAvailable(_Arcance_Power, timeShift));

			-- Arcane Missiles (at four Arcane Charges)
			if maCharge > 0 then
				return _Arcane_Missiles;
			end
		end
		-- Nether Tempest (talent) (at four Arcane Charges)
		-- Arcane Blast
		return _Arcane_Blast;
		-- Supernova (talent)
	end

	-- conserve
	-- Stay at a high enough mana level that you will be near to 100% when Evocation comes off of cooldown.
	-- In practice this will mean hovering between 100% and around 50%. At early gear levels you will probably
	-- need to Arcane Barrage before reaching four Arcane Charge stacks.
	-- Arcane Missiles (at four Arcane Charges or three Arcane Missiles stacks)
	if (arcaneCharge > 3 and maCharge > 0) or (maCharge >= 3) then
		return _Arcane_Missiles;
	end

	if maCharge > 0 and MaxDps:SpellAvailable(_Presence_of_Mind, timeShift) then
		if  MaxDps:SpellAvailable(_Presence_of_Mind, timeShift) and
			(arcaneCharge <= 0 or not MaxDps:SpellAvailable(_Arcane_Barrage, timeShift))
		then
			return _Presence_of_Mind;
		else
			return _Arcane_Barrage;
		end
	end


	-- Arcane Barrage (if no Arcane Missiles stacks)
	if MaxDps:SpellAvailable(_Arcane_Barrage, timeShift) and maCharge < 2 and arcaneCharge >= 3 then
		return _Arcane_Barrage;
	end

	-- Supernova (talent)
	-- _MarkOfAluneth
	if MaxDps:SpellAvailable(_MarkOfAluneth, timeShift) and not MaxDps:SameSpell(currentSpell, _MarkOfAluneth) and (maxMana * 0.65) < mana then
		return _MarkOfAluneth;
	end

	-- Nether Tempest (talent) (at four Arcane Charges)
	return _Arcane_Blast;
end

function MaxDps.Mage.Fire(_, timeShift, currentSpell, gcd, talents)
	MaxDps:GlowCooldown(_Combustion, MaxDps:SpellAvailable(_Combustion, timeShift));

	if talents[_RuneofPower] then
		MaxDps:GlowCooldown(_RuneofPower, MaxDps:SpellAvailable(_RuneofPower, timeShift));
	end

	if talents[_MirrorImage] then
		MaxDps:GlowCooldown(_MirrorImage, MaxDps:SpellAvailable(_MirrorImage, timeShift));
	end

	local combu, combuCD = MaxDps:Aura(_Combustion, timeShift);
	local rop = MaxDps:PersistentAura(_RuneofPower);

	local pf, pfCharges = MaxDps:SpellCharges(_PhoenixsFlames, timeShift);
	local fb, fbCharges = MaxDps:SpellCharges(_FireBlast, timeShift);

	local ph = MaxDps:TargetPercentHealth();

	if pfCharges >= 2 then
		return _PhoenixsFlames;
	end

	if MaxDps:Aura(_HotStreakAura, timeShift) then
		return _Pyroblast;
	end

	--actions.active_talents+=/blast_wave,if=(buff.combustion.down)|(buff.combustion.up&action.fire_blast
	--.charges<1&action.phoenixs_flames.charges<1)
	if talents[_BlastWave] and MaxDps:SpellAvailable(_BlastWave, timeShift) and
		((not combu) or
		(combu and fbCharges < 1 and pfCharges < 1))
	then
		return _BlastWave;
	end

	--actions.active_talents+=/meteor,if=cooldown.combustion.remains>30|(cooldown.combustion.remains>target
	--.time_to_die)|buff.rune_of_power.up
	if talents[_Meteor] and MaxDps:SpellAvailable(_Meteor, timeShift) and ((combuCD > 30) or rop) then
		return _Meteor
	end

	--actions.active_talents+=/cinderstorm,if=cooldown.combustion.remains<cast_time&(buff.rune_of_power.up|!talent
	--.rune_on_power.enabled)|cooldown.combustion.remains>10*spell_haste&!buff.combustion.up
	if talents[_Cinderstorm] and MaxDps:SpellAvailable(_Cinderstorm, timeShift) and
		not MaxDps:SameSpell(currentSpell, _Cinderstorm) and
		not combu and not rop then
		return _Cinderstorm;
	end

	--actions.active_talents+=/dragons_breath,if=equipped.132863
	if (_isDarckli or talents[_AlexstraszasFury]) and MaxDps:SpellAvailable(_DragonsBreath, timeShift) then
		return _DragonsBreath;
	end

	--actions.active_talents+=/living_bomb,if=active_enemies>1&buff.combustion.down
	--NIY

	if fbCharges >= 1 and MaxDps:Aura(_HeatingUp, timeShift) then
		return _FireBlast;
	end

	local moving = GetUnitSpeed('player');
	if (_isKoralon and ph < 0.25) or moving > 0 then
		return _Scorch;
	end

	return _Fireball;
end

function MaxDps.Mage.Frost(_, timeShift, currentSpell, gcd, talents)
	local _, currentPetSpell = MaxDps:EndCast('pet');

	local rop = MaxDps:PersistentAura(_RuneofPower);
	local fof, fofCharges = MaxDps:Aura(_FingersofFrost, timeShift);
	local ici, iciCharges = MaxDps:Aura(_Icicles, timeShift);
	local cr, crCharges, crCd = MaxDps:Aura(_ChainReaction, timeShift);

	local elemental = UnitExists('pet');

	MaxDps:GlowCooldown(_RuneofPower, talents[_RuneofPower] and MaxDps:SpellAvailable(_RuneofPower, timeShift));
	MaxDps:GlowCooldown(_MirrorImage, talents[_MirrorImage] and MaxDps:SpellAvailable(_MirrorImage, timeShift));

	if not talents[_LonelyWinter] and not elemental and MaxDps:SpellAvailable(_SummonWaterElemental, timeShift) and
			not MaxDps:SameSpell(currentSpell, _SummonWaterElemental) then
		return _SummonWaterElemental;
	end

	if talents[_RayofFrost] and MaxDps:SpellAvailable(_RayofFrost, timeShift) then
		if talents[_RuneofPower] then
			if rop then
				return _RayofFrost;
			end
		else
			return _RayofFrost;
		end
	end

	if fofCharges >= 3 then
		return _IceLance;
	end

	if talents[_FrostBomb] and fofCharges >= 1 and not MaxDps:SameSpell(currentSpell, _FrostBomb) and not
		MaxDps:TargetAura(_FrostBomb, timeShift) then
		return _FrostBomb;
	end

	if MaxDps:Aura(_BrainFreeze, timeShift) then
		return _Flurry;
	end

	if MaxDps:SameSpell(currentSpell, _Flurry) or MaxDps:TargetAura(_WintersChill, timeShift) then
		return _IceLance;
	end

	if not talents[_LonelyWinter] and MaxDps:SpellAvailable(_WaterJet, timeShift) and not fof and
			not MaxDps:SameSpell(currentPetSpell, _WaterJet) then
		return _WaterJet;
	end

	--Chain reaction
	if fofCharges >= 1 and (crCd < 1 or crCharges >= 3) then
		return _IceLance;
	end

	if talents[_GlacialSpike] and iciCharges >= 5 and not MaxDps:SameSpell(currentSpell, _GlacialSpike) then
		return _GlacialSpike;
	end

	return _Frostbolt;
end

function MaxDps.Mage.ArcaneCharge()
	local _, _, _, charges = UnitAura('player', 'Arcane Charge', nil, 'PLAYER|HARMFUL');
	if charges == nil then
		charges = 0;
	end
	return charges;
end

function MaxDps.Mage.Ignite()
	return select(15, UnitAura('target', 'Ignite', nil, 'HARMFUL'));
end
