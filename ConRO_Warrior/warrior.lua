ConRO.Warrior = {};
ConRO.Warrior.CheckTalents = function()
end
ConRO.Warrior.CheckPvPTalents = function()
end
local ConRO_Warrior, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Warrior.CheckTalents;
	self.ModuleOnEnable = ConRO.Warrior.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Warrior [No Specialization Under 10]";
		self.NextSpell = ConRO.Warrior.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = 'Warrior [Arms - Melee]';
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Warrior.Arms;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Warrior.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 2 then
		self.Description = 'Warrior [Fury - Melee]';
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Warrior.Fury;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Warrior.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 3 then
		self.Description = 'Warrior [Protection - Tank]';
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.Warrior.Protection;
			self.ToggleDamage();
			self.BlockAoE();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Warrior.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 0;
	if mode == 0 then
		self.NextDef = ConRO.Warrior.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Warrior.ArmsDef;
		else
			self.NextDef = ConRO.Warrior.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Warrior.FuryDef;
		else
			self.NextDef = ConRO.Warrior.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Warrior.ProtectionDef;
		else
			self.NextDef = ConRO.Warrior.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Warrior.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Warrior.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Warrior_Ability, ids.Warrior_Passive, ids.Warrior_Form, ids.Warrior_Buff, ids.Warrior_Debuff, ids.Warrior_PetAbility, ids.Warrior_PvPTalent, ids.Glyph;
--Info
	local _Player_Level	 = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources

--Racials
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Warnings

--Rotations	


	return nil;
end

function ConRO.Warrior.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Warrior_Ability, ids.Warrior_Passive, ids.Warrior_Form, ids.Warrior_Buff, ids.Warrior_Debuff, ids.Warrior_PetAbility, ids.Warrior_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources

--Racials
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Warnings

--Rotations	

	return nil;
end

function ConRO.Warrior.Arms(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Arms_Ability, ids.Arms_Passive, ids.Arms_Form, ids.Arms_Buff, ids.Arms_Debuff, ids.Arms_PetAbility, ids.Arms_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Rage, _Rage_Max = ConRO:PlayerPower('Rage');

--Racials
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities	
	local _Avatar, _Avatar_RDY = ConRO:AbilityReady(Ability.Avatar, timeShift);
	local _BattleShout, _BattleShout_RDY = ConRO:AbilityReady(Ability.BattleShout, timeShift);
	local _Bladestorm, _Bladestorm_RDY = ConRO:AbilityReady(Ability.Bladestorm, timeShift);
	local _BladestormH, _BladestormH_RDY = ConRO:AbilityReady(Ability.BladestormH, timeShift);
		local _MercilessBonegrinder_BUFF = ConRO:Aura(Buff.MercilessBonegrinder, timeShift);
		local _Hurricane_BUFF = ConRO:Aura(Buff.Hurricane, timeShift);
	local _Charge, _Charge_RDY = ConRO:AbilityReady(Ability.Charge, timeShift);
		local _Charge_RANGE = ConRO:Targets(Ability.Charge);
	local _Cleave, _Cleave_RDY = ConRO:AbilityReady(Ability.Cleave, timeShift);
	local _ColossusSmash, _ColossusSmash_RDY, _ColossusSmash_CD = ConRO:AbilityReady(Ability.ColossusSmash, timeShift);
		local _ColossusSmash_DEBUFF = ConRO:TargetAura(Debuff.ColossusSmash, timeShift);
		local _InForTheKill_BUFF = ConRO:Aura(Buff.InForTheKill, timeShift);
		local _TestofMight_BUFF = ConRO:Aura(Buff.TestofMight, timeShift);
	local _Execute, _Execute_RDY = ConRO:AbilityReady(Ability.Execute, timeShift);
		local _SuddenDeath_BUFF	= ConRO:Aura(Buff.SuddenDeath, timeShift);
		local _, _ExecutionersPrecision_COUNT = ConRO:Aura(Buff.ExecutionersPrecision, timeShift);
		local _MassacreExecute, _MassacreExecute_RDY, _MassacreExecute_CD = ConRO:AbilityReady(Passive.MassacreExecute, timeShift);
	local _HeroicThrow, _HeroicThrow_RDY = ConRO:AbilityReady(Ability.HeroicThrow, timeShift);
	local _MortalStrike, _MortalStrike_RDY = ConRO:AbilityReady(Ability.MortalStrike, timeShift);
		local _DeepWounds_DEBUFF = ConRO:TargetAura(Debuff.DeepWounds, timeShift + 4);
	local _Overpower, _Overpower_RDY = ConRO:AbilityReady(Ability.Overpower, timeShift);
		local _Overpower_CHARGES = ConRO:SpellCharges(_Overpower);
		local _Overpower_BUFF, _Overpower_COUNT = ConRO:Aura(Buff.Overpower, timeShift);
	local _Pummel, _Pummel_RDY = ConRO:AbilityReady(Ability.Pummel, timeShift);
	local _Rend, _Rend_RDY = ConRO:AbilityReady(Ability.Rend, timeShift);
		local _Rend_DEBUFF = ConRO:TargetAura(Debuff.Rend, timeShift + 3);
	local _ShatteringThrow, _ShatteringThrow_RDY = ConRO:AbilityReady(Ability.ShatteringThrow, timeShift);
		local _IceBlock_BUFF = ConRO:UnitAura(45438, timeShift, 'target', 'HELPFUL');
		local _DivineShield_BUFF = ConRO:UnitAura(642, timeShift, 'target', 'HELPFUL');
	local _Skullsplitter, _Skullsplitter_RDY = ConRO:AbilityReady(Ability.Skullsplitter, timeShift);
	local _Slam, _Slam_RDY = ConRO:AbilityReady(Ability.Slam, timeShift);
	local _SpearofBastion, _SpearofBastion_RDY = ConRO:AbilityReady(Ability.SpearofBastion, timeShift);
	local _StormBolt, _StormBolt_RDY = ConRO:AbilityReady(Ability.StormBolt, timeShift);
	local _SweepingStrikes, _SweepingStrikes_RDY = ConRO:AbilityReady(Ability.SweepingStrikes, timeShift);
		local _SweepingStrikes_BUFF = ConRO:Aura(Buff.SweepingStrikes, timeShift);
	local _ThunderClap, _ThunderClap_RDY = ConRO:AbilityReady(Ability.ThunderClap, timeShift);
	local _ThunderousRoar, _ThunderousRoar_RDY = ConRO:AbilityReady(Ability.ThunderousRoar, timeShift);
	local _Warbreaker, _Warbreaker_RDY, _Warbreaker_CD = ConRO:AbilityReady(Ability.Warbreaker, timeShift);
	local _Whirlwind, _Whirlwind_RDY = ConRO:AbilityReady(Ability.Whirlwind, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
	local _can_execute = _Target_Percent_Health <= 20;

	if tChosen[Passive.Massacre.talentID] then
		_can_execute = _Target_Percent_Health <= 35;
		_Execute_RDY = _MassacreExecute_RDY;
		_Execute = _MassacreExecute;
	end

	if tChosen[Passive.Hurricane.talentID] then
		_Bladestorm, _Bladestorm_RDY = _BladestormH, _BladestormH_RDY;
	end

--Indicators		
	ConRO:AbilityInterrupt(_Pummel, _Pummel_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_ShatteringThrow, _ShatteringThrow_RDY and (_IceBlock_BUFF or _DivineShield_BUFF));
	ConRO:AbilityRaidBuffs(_BattleShout, _BattleShout_RDY and not ConRO:RaidBuff(Buff.BattleShout));
	ConRO:AbilityMovement(_Charge, _Charge_RDY and _Charge_RANGE);

	ConRO:AbilityBurst(_Avatar, _Avatar_RDY and ConRO:BurstMode(_Avatar));
	ConRO:AbilityBurst(_Bladestorm, _Bladestorm_RDY and _ColossusSmash_DEBUFF and not _SweepingStrikes_BUFF and ConRO:BurstMode(_Bladestorm));
	ConRO:AbilityBurst(_ColossusSmash, _ColossusSmash_RDY and not tChosen[Ability.Warbreaker.talentID] and ConRO:BurstMode(_ColossusSmash));
	ConRO:AbilityBurst(_SweepingStrikes, _SweepingStrikes_RDY and (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) and ConRO:BurstMode(_SweepingStrikes));
	ConRO:AbilityBurst(_Warbreaker, _Warbreaker_RDY and ConRO:BurstMode(_Warbreaker));
	ConRO:AbilityBurst(_SpearofBastion, _SpearofBastion_RDY and _in_combat and ConRO:BurstMode(_SpearofBastion));
	ConRO:AbilityBurst(_ThunderousRoar, _ThunderousRoar_RDY and _target_in_10yrds and (_TestofMight_BUFF or _InForTheKill_BUFF) and ConRO:BurstMode(_ThunderousRoar));
--Warnings	

--Rotations	
	for i = 1, 2, 1 do
		if _ThunderClap_RDY and not _Rend_DEBUFF and _enemies_in_melee >= 2 and tChosen[Passive.BloodandThunder.talentID] and tChosen[Ability.Rend.talentID] then
			tinsert(ConRO.SuggestedSpells, _ThunderClap);
			_ThunderClap_RDY = false;
		end

		if _Rend_RDY and not _Rend_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _Rend);
			_Rend_DEBUFF = true;
		end

		if _Avatar_RDY and tChosen[Passive.WarlordsTorment.talentID] and ConRO:FullMode(_Avatar) then
			tinsert(ConRO.SuggestedSpells, _Avatar);
			_Avatar_RDY = false;
		end

		if _SweepingStrikes_RDY and _enemies_in_melee >= 2 and _enemies_in_melee <= 4 then
			tinsert(ConRO.SuggestedSpells, _SweepingStrikes);
			_SweepingStrikes_RDY = false;
		end

		if _Warbreaker_RDY and not _ColossusSmash_DEBUFF and ConRO:FullMode(_Warbreaker) then
			tinsert(ConRO.SuggestedSpells, _Warbreaker);
			_Warbreaker_RDY = false;
		end

		if _ColossusSmash_RDY and not _ColossusSmash_DEBUFF	and not tChosen[Ability.Warbreaker.talentID] and ConRO:FullMode(_ColossusSmash) then
			tinsert(ConRO.SuggestedSpells, _ColossusSmash);
			_ColossusSmash_RDY = false;
		end

		if (ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 2) or ConRO_SingleButton:IsVisible() then
			if _MortalStrike_RDY and not _can_execute then
				tinsert(ConRO.SuggestedSpells, _MortalStrike);
				_MortalStrike_RDY = false;
			end

			if _SpearofBastion_RDY and (_ColossusSmash_DEBUFF or _TestofMight_BUFF) and ConRO:FullMode(_SpearofBastion) then
				tinsert(ConRO.SuggestedSpells, _SpearofBastion);
				_SpearofBastion_RDY = false;
			end

			if _ThunderousRoar_RDY and (_TestofMight_BUFF or _InForTheKill_BUFF) and _target_in_10yrds and ConRO:FullMode(_ThunderousRoar) then
				tinsert(ConRO.SuggestedSpells, _ThunderousRoar);
				_ThunderousRoar_RDY = false;
			end

			if _can_execute then
				if _Overpower_RDY and _Overpower_CHARGES >= 1 and _Rage < 40 then
					tinsert(ConRO.SuggestedSpells, _Overpower);
					_Overpower_CHARGES = _Overpower_CHARGES - 1;
				end

				if _MortalStrike_RDY and (not _DeepWounds_DEBUFF or _ExecutionersPrecision_COUNT >= 2) then
					tinsert(ConRO.SuggestedSpells, _MortalStrike);
					_MortalStrike_RDY = false;
				end

				if _Execute_RDY then
					tinsert(ConRO.SuggestedSpells, _Execute);
				end

				if _Overpower_RDY and _Overpower_CHARGES >= 1 then
					tinsert(ConRO.SuggestedSpells, _Overpower);
					_Overpower_CHARGES = _Overpower_CHARGES - 1;
				end
			else
				if _Bladestorm_RDY and _TestofMight_BUFF and ConRO:FullMode(_Bladestorm) then
					tinsert(ConRO.SuggestedSpells, _Bladestorm);
					_Bladestorm_RDY = false;
				end

				if _Skullsplitter_RDY and _ColossusSmash_DEBUFF then
					tinsert(ConRO.SuggestedSpells, _Skullsplitter);
					_Skullsplitter_RDY = false;
				end

				if _Execute_RDY and _SuddenDeath_BUFF then
					tinsert(ConRO.SuggestedSpells, _Execute);
					_SuddenDeath_BUFF = false;
				end

				if _Overpower_RDY and _Overpower_CHARGES >= 2 then
					tinsert(ConRO.SuggestedSpells, _Overpower);
					_Overpower_CHARGES = _Overpower_CHARGES - 1;
				end

				if _Whirlwind_RDY and tChosen[Passive.StormofSwords.talentID] then
					tinsert(ConRO.SuggestedSpells, _Whirlwind);
					_Whirlwind_RDY = false;
				end

				if _ThunderClap_RDY and tChosen[Passive.BloodandThunder.talentID] then
					tinsert(ConRO.SuggestedSpells, _ThunderClap);
					_ThunderClap_RDY = false;
				end

				if _Slam_RDY and tChosen[Passive.CrushingForce.talentID] and _Rage >= _Rage_Max - 10 then
					tinsert(ConRO.SuggestedSpells, _Slam);
				end

				if _Overpower_RDY and _Overpower_CHARGES >= 1 then
					tinsert(ConRO.SuggestedSpells, _Overpower);
					_Overpower_CHARGES = _Overpower_CHARGES - 1;
				end

				if _Slam_RDY and _Rage >= _Rage_Max - 10 then
					tinsert(ConRO.SuggestedSpells, _Slam);
				end
			end
		else
			if _SpearofBastion_RDY and (_ColossusSmash_DEBUFF or _TestofMight_BUFF) and ConRO:FullMode(_SpearofBastion) then
				tinsert(ConRO.SuggestedSpells, _SpearofBastion);
				_SpearofBastion_RDY = false;
			end

			if _Avatar_RDY and tChosen[Passive.BlademastersTorment.talentID] and ConRO:FullMode(_Avatar) then
				tinsert(ConRO.SuggestedSpells, _Avatar);
				_Avatar_RDY = false;
			end

			if _Cleave_RDY then
				tinsert(ConRO.SuggestedSpells, _Cleave);
				_Cleave_RDY = false;
			end

			if _Whirlwind_RDY and tChosen[Passive.StormofSwords.talentID] and _MercilessBonegrinder_BUFF then
				tinsert(ConRO.SuggestedSpells, _Whirlwind);
				_Whirlwind_RDY = false;
			end

			if _ThunderousRoar_RDY and (_ColossusSmash_DEBUFF or _Hurricane_BUFF) and _target_in_10yrds and ConRO:FullMode(_ThunderousRoar) then
				tinsert(ConRO.SuggestedSpells, _ThunderousRoar);
				_ThunderousRoar_RDY = false;
			end

			if _Bladestorm_RDY and _ColossusSmash_DEBUFF and ConRO:FullMode(_Bladestorm) then
				tinsert(ConRO.SuggestedSpells, _Bladestorm);
				_Bladestorm_RDY = false;
			end

			if _Execute_RDY and _can_execute and _SweepingStrikes_BUFF then
				tinsert(ConRO.SuggestedSpells, _Execute);
			end

			if _MortalStrike_RDY and _SweepingStrikes_BUFF then
				tinsert(ConRO.SuggestedSpells, _MortalStrike);
				_MortalStrike_RDY = false;
			end

			if _Overpower_RDY and _Overpower_CHARGES >= 1 then
				tinsert(ConRO.SuggestedSpells, _Overpower);
				_Overpower_CHARGES = _Overpower_CHARGES - 1;
			end

			if _Whirlwind_RDY then
				tinsert(ConRO.SuggestedSpells, _Whirlwind);
			end
		end
	end
	return nil;
end

function ConRO.Warrior.ArmsDef(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Arms_Ability, ids.Arms_Passive, ids.Arms_Form, ids.Arms_Buff, ids.Arms_Debuff, ids.Arms_PetAbility, ids.Arms_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Rage, _Rage_Max = ConRO:PlayerPower('Rage');

--Abilities	
	local _RallyingCry, _RallyingCry_RDY = ConRO:AbilityReady(Ability.RallyingCry, timeShift);
	local _DiebytheSword, _DiebytheSword_RDY = ConRO:AbilityReady(Ability.DiebytheSword, timeShift);
	local _IgnorePain, _IgnorePain_RDY = ConRO:AbilityReady(Ability.IgnorePain, timeShift);
		local _IgnorePain_BUFF = ConRO:Aura(Buff.IgnorePain, timeShift);
	local _VictoryRush, _VictoryRush_RDY = ConRO:AbilityReady(Ability.VictoryRush, timeShift);
		local _Victorious_BUFF = ConRO:Aura(Buff.Victorious, timeShift);

	local _DefensiveStance, _DefensiveStance_RDY = ConRO:AbilityReady(Ability.DefensiveStance, timeShift);
		local _DefensiveStance_FORM = ConRO:Form(Form.DefensiveStance);
	local _ImpendingVictory, _ImpendingVictory_RDY = ConRO:AbilityReady(Ability.ImpendingVictory, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations	
	if _IgnorePain_RDY and _Rage >= _Rage_Max - 25 then
		tinsert(ConRO.SuggestedDefSpells, _IgnorePain);
	end

	if tChosen[Ability.ImpendingVictory.talentID] then
		if _ImpendingVictory_RDY and _Player_Percent_Health <= 70 then
			tinsert(ConRO.SuggestedDefSpells, _ImpendingVictory);
		end
	else
		if _VictoryRush_RDY and _Victorious_BUFF and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _VictoryRush);
		end
	end

	if _DiebytheSword_RDY then
		tinsert(ConRO.SuggestedDefSpells, _DiebytheSword);
	end

	if _RallyingCry_RDY then
		tinsert(ConRO.SuggestedDefSpells, _RallyingCry);
	end

	if _DefensiveStance_RDY and not _DefensiveStance_FORM then
		tinsert(ConRO.SuggestedDefSpells, _DefensiveStance);
	end
	return nil;
end

function ConRO.Warrior.Fury(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Fury_Ability, ids.Fury_Passive, ids.Fury_Form, ids.Fury_Buff, ids.Fury_Debuff, ids.Fury_PetAbility, ids.Fury_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Rage, _Rage_Max = ConRO:PlayerPower('Rage');

--Racials
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities	
	local _Avatar, _Avatar_RDY = ConRO:AbilityReady(Ability.Avatar, timeShift);
	local _BattleShout, _BattleShout_RDY = ConRO:AbilityReady(Ability.BattleShout, timeShift);
	local _Bloodbath, _, _BloodbathCD = ConRO:AbilityReady(Passive.Bloodbath, timeShift);
	local _Bloodthirst, _Bloodthirst_RDY = ConRO:AbilityReady(Ability.Bloodthirst, timeShift + 0.5);
		local _Enrage_BUFF = ConRO:Aura(Buff.Enrage, timeShift);
	local _Charge, _Charge_RDY = ConRO:AbilityReady(Ability.Charge, timeShift);
		local _Charge_RANGE = ConRO:IsSpellInRange(Ability.Charge, 'target');
	local _CrushingBlow, _, _CrushingBlowCD = ConRO:AbilityReady(Passive.CrushingBlow, timeShift);
	local _Execute, _Execute_RDY = ConRO:AbilityReady(Ability.Execute, timeShift);
		local _SuddenDeath_BUFF = ConRO:Aura(Buff.SuddenDeath, timeShift);
	local _MassacreExecute, _MassacreExecute_RDY = ConRO:AbilityReady(Ability.MassacreExecute, timeShift);
	local _OdynsFury, _OdynsFury_RDY = ConRO:AbilityReady(Ability.OdynsFury, timeShift);
	local _Onslaught, _Onslaught_RDY = ConRO:AbilityReady(Ability.Onslaught, timeShift);
	local _Pummel, _Pummel_RDY = ConRO:AbilityReady(Ability.Pummel, timeShift);
	local _Rampage, _Rampage_RDY = ConRO:AbilityReady(Ability.Rampage, timeShift);
		local _RecklessAbandon_BUFF = ConRO:Aura(Buff.RecklessAbandon, timeShift);
	local _RagingBlow, _RagingBlow_RDY = ConRO:AbilityReady(Ability.RagingBlow, timeShift);
		local _RagingBlow_CHARGES = ConRO:SpellCharges(_RagingBlow);
	local _Ravager, _Ravager_RDY = ConRO:AbilityReady(Ability.Ravager, timeShift);
	local _Recklessness, _Recklessness_RDY, _Recklessness_CD = ConRO:AbilityReady(Ability.Recklessness, timeShift);
		local _Recklessness_BUFF = ConRO:Aura(Buff.Recklessness, timeShift);
	local _Slam, _Slam_RDY = ConRO:AbilityReady(Ability.Slam, timeShift);
	local _ShatteringThrow, _ShatteringThrow_RDY = ConRO:AbilityReady(Ability.ShatteringThrow, timeShift);
		local _IceBlock_BUFF = ConRO:UnitAura(45438, timeShift, 'target', 'HELPFUL');
		local _DivineShield_BUFF = ConRO:UnitAura(642, timeShift, 'target', 'HELPFUL');
	local _SpearofBastion, _SpearofBastion_RDY = ConRO:AbilityReady(Ability.SpearofBastion, timeShift);
	local _ThunderousRoar, _ThunderousRoar_RDY = ConRO:AbilityReady(Ability.ThunderousRoar, timeShift);
	local _Whirlwind, _Whirlwind_RDY = ConRO:AbilityReady(Ability.Whirlwind, timeShift);
		local _Whirlwind_BUFF, _Whirlwind_COUNT = ConRO:Aura(Buff.Whirlwind, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
	local _can_execute = _Target_Percent_Health <= 20;

	if tChosen[Passive.Massacre.talentID] then
		_can_execute = _Target_Percent_Health <= 35;
		_Execute_RDY = _MassacreExecute_RDY;
		_Execute = _MassacreExecute;
	end

	if tChosen[Passive.RecklessAbandon.talentID] and _RecklessAbandon_BUFF then
		_Bloodthirst_RDY = _Bloodthirst_RDY and _BloodbathCD <= 0;
		_Bloodthirst = _Bloodbath;

		_RagingBlow_RDY = _RagingBlow_RDY and _CrushingBlowCD <= 0;
		_RagingBlow = _CrushingBlow;
	end

--Indicators	
	ConRO:AbilityInterrupt(_Pummel, _Pummel_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_ShatteringThrow, _ShatteringThrow_RDY and (_IceBlock_BUFF or _DivineShield_BUFF));
	ConRO:AbilityRaidBuffs(_BattleShout, _BattleShout_RDY and not ConRO:RaidBuff(Buff.BattleShout));
	ConRO:AbilityMovement(_Charge, _Charge_RDY and _Charge_RANGE);

	ConRO:AbilityBurst(_Avatar, _Avatar_RDY and _Recklessness_BUFF and ((_Enrage_BUFF and tChosen[Passive.TitansTorment.talentID]) or not tChosen[Passive.TitansTorment.talentID]) and ConRO:BurstMode(_Avatar));
	ConRO:AbilityBurst(_Recklessness, _Recklessness_RDY and ConRO:BurstMode(_Recklessness));
	ConRO:AbilityBurst(_SpearofBastion, _SpearofBastion_RDY and _in_combat and ConRO:BurstMode(_SpearofBastion));
	ConRO:AbilityBurst(_Ravager, _Ravager_RDY and ConRO:BurstMode(_Ravager));

--Warnings


--Rotations
	for i = 1, 2, 1 do
		if _Ravager_RDY and _Enrage_BUFF and ConRO:FullMode(_Ravager) then
			tinsert(ConRO.SuggestedSpells, _Ravager);
			_Ravager_RDY = false;
		end

		if _Whirlwind_RDY and tChosen[Passive.ImprovedWhirlwind.talentID] and not _Whirlwind_BUFF and (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) then
			tinsert(ConRO.SuggestedSpells, _Whirlwind);
			_Whirlwind_BUFF = true;
		end

		if _Avatar_RDY and tChosen[Passive.BerserkersTorment.talentID] and ConRO:FullMode(_Avatar) then
			tinsert(ConRO.SuggestedSpells, _Avatar);
			_Avatar_RDY = false;
		end

		if _Recklessness_RDY and ConRO:FullMode(_Recklessness) then
			tinsert(ConRO.SuggestedSpells, _Recklessness);
			_Recklessness_RDY = false;
		end

		if _Avatar_RDY and _Recklessness_BUFF and (_Enrage_BUFF or tChosen[Passive.TitansTorment.talentID]) and ConRO:FullMode(_Avatar) then
			tinsert(ConRO.SuggestedSpells, _Avatar);
			_Avatar_RDY = false;
		end

		if _SpearofBastion_RDY and _Enrage_BUFF and ConRO:FullMode(_SpearofBastion) then
			tinsert(ConRO.SuggestedSpells, _SpearofBastion);
			_SpearofBastion_RDY = false;
		end

		if _ThunderousRoar_RDY and _Enrage_BUFF then
			tinsert(ConRO.SuggestedSpells, _ThunderousRoar);
			_ThunderousRoar_RDY = false;
		end

		if _RagingBlow_RDY and tChosen[Passive.RecklessAbandon.talentID] and _RecklessAbandon_BUFF and not tChosen[Passive.Annihilator.talentID] then
			tinsert(ConRO.SuggestedSpells, _RagingBlow);
			_RagingBlow_CHARGES = _RagingBlow_CHARGES - 1;
		end

		if _Rampage_RDY and (not _Enrage_BUFF or _Rage >= _Rage_Max - 10) then
			tinsert(ConRO.SuggestedSpells, _Rampage);
			_Rampage_RDY = false;
		end

		if _Execute_RDY and (_can_execute or _SuddenDeath_BUFF) then
			tinsert(ConRO.SuggestedSpells, _Execute);
			_Execute_RDY = false;
		end

		if _Onslaught_RDY and (_Enrage_BUFF or tChosen[Passive.Tenderize.talentID]) then
			tinsert(ConRO.SuggestedSpells, _Onslaught);
			_Onslaught_RDY = false;
		end

		if _OdynsFury_RDY and (_Enrage_BUFF or tChosen[Passive.TitanicRage.talentID]) then
			tinsert(ConRO.SuggestedSpells, _OdynsFury);
			_OdynsFury_RDY = false;
		end

		if _Rampage_RDY and tChosen[Passive.RecklessAbandon.talentID] and not _RecklessAbandon_BUFF then
			tinsert(ConRO.SuggestedSpells, _Rampage);
			_Rampage_RDY = false;
		end

		if _Bloodthirst_RDY and tChosen[Passive.RecklessAbandon.talentID] and _RecklessAbandon_BUFF then
			tinsert(ConRO.SuggestedSpells, _Bloodthirst);
			_Bloodthirst_RDY = false;
		end

		if _RagingBlow_RDY and _RagingBlow_CHARGES >= 1 and not tChosen[Passive.Annihilator.talentID] then
			tinsert(ConRO.SuggestedSpells, _RagingBlow);
			_RagingBlow_CHARGES = _RagingBlow_CHARGES - 1;
		end

		if _Bloodthirst_RDY then
			tinsert(ConRO.SuggestedSpells, _Bloodthirst);
			_Bloodthirst_RDY = false;
		end

		if _Slam_RDY and tChosen[Passive.StormofSwords.talentID] then
			tinsert(ConRO.SuggestedSpells, _Slam);
			_Slam_RDY = false;
		end

		if _Whirlwind_RDY then
			tinsert(ConRO.SuggestedSpells, _Whirlwind);
		end
	end
	return nil;
end

function ConRO.Warrior.FuryDef(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Fury_Ability, ids.Fury_Passive, ids.Fury_Form, ids.Fury_Buff, ids.Fury_Debuff, ids.Fury_PetAbility, ids.Fury_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Rage, _Rage_Max = ConRO:PlayerPower('Rage');

--Abilities	
	local _RallyingCry, _RallyingCry_RDY = ConRO:AbilityReady(Ability.RallyingCry, timeShift);
	local _EnragedRegeneration, _EnragedRegeneration_RDY = ConRO:AbilityReady(Ability.EnragedRegeneration, timeShift);
	local _VictoryRush, _VictoryRush_RDY = ConRO:AbilityReady(Ability.VictoryRush, timeShift);
		local _Victorious_BUFF = ConRO:Aura(Buff.Victorious, timeShift);
	local _ImpendingVictory, _ImpendingVictory_RDY = ConRO:AbilityReady(Ability.ImpendingVictory, timeShift);

	--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");

--Rotations	
	if tChosen[Ability.ImpendingVictory.talentID] then
		if _ImpendingVictory_RDY and _Player_Percent_Health <= 70 then
			tinsert(ConRO.SuggestedDefSpells, _ImpendingVictory);
		end
	else
		if _VictoryRush_RDY and _Victorious_BUFF and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _VictoryRush);
		end
	end

	if _EnragedRegeneration_RDY then
		tinsert(ConRO.SuggestedDefSpells, _EnragedRegeneration);
	end

	if _RallyingCry_RDY then
		tinsert(ConRO.SuggestedDefSpells, _RallyingCry);
	end
	return nil;
end

function ConRO.Warrior.Protection(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Prot_Ability, ids.Prot_Passive, ids.Prot_Form, ids.Prot_Buff, ids.Prot_Debuff, ids.Prot_PetAbility, ids.Prot_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Rage, _Rage_Max = ConRO:PlayerPower('Rage');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities	
	local _Avatar, _Avatar_RDY = ConRO:AbilityReady(Ability.Avatar, timeShift);
		local _Avatar_BUFF = ConRO:Aura(Buff.Avatar, timeShift);
	local _BattleShout, _BattleShout_RDY = ConRO:AbilityReady(Ability.BattleShout, timeShift);
	local _Charge, _Charge_RDY = ConRO:AbilityReady(Ability.Charge, timeShift);
		local _Charge_RANGE = ConRO:IsSpellInRange(Ability.Charge, 'target');
	local _DemoralizingShout, _DemoralizingShout_RDY = ConRO:AbilityReady(Ability.DemoralizingShout, timeShift);
	local _Devastate, _Devastate_RDY = ConRO:AbilityReady(Ability.Devastate, timeShift);
	local _Execute, _Execute_RDY = ConRO:AbilityReady(Ability.Execute, timeShift);
	local _Pummel, _Pummel_RDY = ConRO:AbilityReady(Ability.Pummel, timeShift);
	local _Ravager, _Ravager_RDY = ConRO:AbilityReady(Ability.Ravager, timeShift);
	local _Revenge, _Revenge_RDY = ConRO:AbilityReady(Ability.Revenge, timeShift);
		local _Revenge_BUFF = ConRO:Aura(Buff.Revenge, timeShift);
	local _ShatteringThrow, _ShatteringThrow_RDY = ConRO:AbilityReady(Ability.ShatteringThrow, timeShift);
		local _IceBlock_BUFF = ConRO:UnitAura(45438, timeShift, 'target', 'HELPFUL');
		local _DivineShield_BUFF = ConRO:UnitAura(642, timeShift, 'target', 'HELPFUL');
	local _ShieldBlock, _ShieldBlock_RDY = ConRO:AbilityReady(Ability.ShieldBlock, timeShift);
		local _ShieldBlock_CHARGES = ConRO:SpellCharges(_ShieldBlock);
		local _ShieldBlock_BUFF = ConRO:Aura(Buff.ShieldBlock, timeShift);
	local _ShieldCharge, _ShieldCharge_RDY = ConRO:AbilityReady(Ability.ShieldCharge, timeShift);
	local _ShieldSlam, _ShieldSlam_RDY, _ShieldSlam_CD = ConRO:AbilityReady(Ability.ShieldSlam, timeShift);
		local _ViolentOutburst_BUFF = ConRO:Aura(Buff.ViolentOutburst, timeShift);
	local _Shockwave, _Shockwave_RDY = ConRO:AbilityReady(Ability.Shockwave, timeShift);
	local _SpearofBastion, _SpearofBastion_RDY = ConRO:AbilityReady(Ability.SpearofBastion, timeShift);
	local _StormBolt, _StormBolt_RDY = ConRO:AbilityReady(Ability.StormBolt, timeShift);
	local _Taunt, _Taunt_RDY = ConRO:AbilityReady(Ability.Taunt, timeShift);
	local _ThunderClap, _ThunderClap_RDY = ConRO:AbilityReady(Ability.ThunderClap, timeShift);
	local _ThunderousRoar, _ThunderousRoar_RDY = ConRO:AbilityReady(Ability.ThunderousRoar, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
	local _can_execute = _Target_Percent_Health <= 20;

--Indicators		
	ConRO:AbilityInterrupt(_Pummel, _Pummel_RDY and ConRO:Interrupt());

	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_ShatteringThrow, _ShatteringThrow_RDY and (_IceBlock_BUFF or _DivineShield_BUFF));
	ConRO:AbilityRaidBuffs(_BattleShout, _BattleShout_RDY and not ConRO:RaidBuff(Buff.BattleShout));
	ConRO:AbilityTaunt(_Taunt, _Taunt_RDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));
	ConRO:AbilityMovement(_Charge, _Charge_RDY and _Charge_RANGE);

	ConRO:AbilityBurst(_Avatar, _Avatar_RDY and _is_Enemy and ConRO:BurstMode(_Avatar));
	ConRO:AbilityBurst(_DemoralizingShout, _DemoralizingShout_RDY and tChosen[Passive.BoomingVoice.talentID] and _is_Enemy and ConRO:BurstMode(_DemoralizingShout));
	ConRO:AbilityBurst(_Ravager, _Ravager_RDY and _is_Enemy and ConRO:BurstMode(_Ravager));
	ConRO:AbilityBurst(_ShieldCharge, _ShieldCharge_RDY and ConRO:BurstMode(_ShieldCharge));
	ConRO:AbilityBurst(_SpearofBastion, _SpearofBastion_RDY and _in_combat and ConRO:BurstMode(_SpearofBastion));

--Warnings

--Rotations
	for i = 1, 2, 1 do
		if _Avatar_RDY and ConRO:FullMode(_Avatar) then
			tinsert(ConRO.SuggestedSpells, _Avatar);
			_Avatar_RDY = false;
		end

		if _DemoralizingShout_RDY and tChosen[Passive.BoomingVoice.talentID] and _target_in_10yrds and ConRO:FullMode(_DemoralizingShout) then
			tinsert(ConRO.SuggestedSpells, _DemoralizingShout);
			_DemoralizingShout_RDY = false;
		end

		if _Ravager_RDY and ConRO:FullMode(_Ravager) then
			tinsert(ConRO.SuggestedSpells, _Ravager);
			_Ravager_RDY = false;
		end

		if _ShieldCharge_RDY and ConRO:FullMode(_ShieldCharge) then
			tinsert(ConRO.SuggestedSpells, _ShieldCharge);
			_ShieldCharge_RDY = false;
		end

		if _ThunderousRoar_RDY and ConRO:FullMode(_ThunderousRoar) then
			tinsert(ConRO.SuggestedSpells, _ThunderousRoar);
			_ThunderousRoar_RDY = false;
		end

		if _SpearofBastion_RDY and ConRO:FullMode(_SpearofBastion) then
			tinsert(ConRO.SuggestedSpells, _SpearofBastion);
			_SpearofBastion_RDY = false;
		end

		if _ViolentOutburst_BUFF then
			if _ThunderClap_RDY and _enemies_in_10yrds >= 5 then
				tinsert(ConRO.SuggestedSpells, _ThunderClap);
				_ThunderClap_RDY = false;
			elseif _ShieldSlam_RDY then
				tinsert(ConRO.SuggestedSpells, _ShieldSlam);
				_ShieldSlam_RDY = false;
			end
		end

		if _ThunderClap_RDY and _Avatar_BUFF and tChosen[Passive.UnstoppableForce.talentID] and _enemies_in_melee >= 2 then
			tinsert(ConRO.SuggestedSpells, _ThunderClap);
			_ThunderClap_RDY = false;
		end

		if _ShieldSlam_RDY then
			tinsert(ConRO.SuggestedSpells, _ShieldSlam);
			_ShieldSlam_RDY = false;
		end

		if _ThunderClap_RDY then
			tinsert(ConRO.SuggestedSpells, _ThunderClap);
			_ThunderClap_RDY = false;
		end

		if _Execute_RDY and _Rage >= 70 and _can_execute then
			tinsert(ConRO.SuggestedSpells, _Execute);
			_Rage = _Rage - 40;
		end

		if _Revenge_RDY and (_Rage >= 50 or _Revenge_BUFF) and (_enemies_in_melee >= 2 or (_enemies_in_melee < 2 and not _can_execute)) then
			tinsert(ConRO.SuggestedSpells, _Revenge);
			_Revenge_BUFF = false;
		end

		if _Devastate_RDY and not tChosen[Passive.Devastator.talentID] then
			tinsert(ConRO.SuggestedSpells, _Devastate);
		end
	end
	return nil;
end

function ConRO.Warrior.ProtectionDef(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Prot_Ability, ids.Prot_Passive, ids.Prot_Form, ids.Prot_Buff, ids.Prot_Debuff, ids.Prot_PetAbility, ids.Prot_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Rage, _Rage_Max = ConRO:PlayerPower('Rage');

--Abilities	
	local _ShieldWall, _ShieldWall_RDY = ConRO:AbilityReady(Ability.ShieldWall, timeShift);
	local _ShieldBlock, _ShieldBlock_RDY = ConRO:AbilityReady(Ability.ShieldBlock, timeShift);
		local _ShieldBlock_CHARGES = ConRO:SpellCharges(_ShieldBlock);
		local _ShieldBlock_BUFF = ConRO:Aura(Buff.ShieldBlock, timeShift);
	local _LastStand, _LastStand_RDY = ConRO:AbilityReady(Ability.LastStand, timeShift);
	local _DemoralizingShout, _DemoralizingShout_RDY = ConRO:AbilityReady(Ability.DemoralizingShout, timeShift);
	local _VictoryRush, _VictoryRush_RDY = ConRO:AbilityReady(Ability.VictoryRush, timeShift);
		local _Victorious_BUFF = ConRO:Aura(Buff.Victorious, timeShift);
	local _ImpendingVictory, _ImpendingVictory_RDY = ConRO:AbilityReady(Ability.ImpendingVictory, timeShift);
	local _IgnorePain, _IgnorePain_RDY = ConRO:AbilityReady(Ability.IgnorePain, timeShift);
		local _IgnorePain_BUFF = ConRO:Aura(Buff.IgnorePain, timeShift);
	local _SpellReflection, _SpellReflection_RDY = ConRO:AbilityReady(Ability.SpellReflection, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations	
	if _SpellReflection_RDY and (ConRO:BossCast() or ConRO:Interrupt()) and ConRO:TarYou() then
		tinsert(ConRO.SuggestedDefSpells, _SpellReflection);
	end

	if _ShieldBlock_RDY and not _ShieldBlock_BUFF and _ShieldBlock_CHARGES >= 1 and ConRO:TarYou() then
		tinsert(ConRO.SuggestedDefSpells, _ShieldBlock);
	end

	if tChosen[Ability.ImpendingVictory.talentID] then
		if _ImpendingVictory_RDY and _Player_Percent_Health <= 70 then
			tinsert(ConRO.SuggestedDefSpells, _ImpendingVictory);
		end
	else
		if _VictoryRush_RDY and _Victorious_BUFF and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _VictoryRush);
		end
	end

	if _LastStand_RDY and _Player_Percent_Health <= 40 then
		tinsert(ConRO.SuggestedDefSpells, _LastStand);
	end

	if _IgnorePain_RDY and not _IgnorePain_BUFF and _Rage >= 70 then
		tinsert(ConRO.SuggestedDefSpells, _IgnorePain);
	end

	if _DemoralizingShout_RDY then
		tinsert(ConRO.SuggestedDefSpells, _DemoralizingShout);
	end

	if _ShieldWall_RDY then
		tinsert(ConRO.SuggestedDefSpells, _ShieldWall);
	end
	return nil;
end
