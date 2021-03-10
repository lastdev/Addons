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
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');

--Resources

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Warnings

--Rotations	

	
return nil;
end

function ConRO.Warrior.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');

--Resources

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Warnings

--Rotations	

return nil;
end

function ConRO.Warrior.Arms(_, timeShift, currentSpell, gcd, tChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Rage, _Rage_Max																				= ConRO:PlayerPower('Rage');
	
--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _BattleShout, _BattleShout_RDY																= ConRO:AbilityReady(ids.Arms_Ability.BattleShout, timeShift);
	local _Bladestorm, _Bladestorm_RDY, _Bladestorm_CD													= ConRO:AbilityReady(ids.Arms_Ability.Bladestorm, timeShift);
	local _Charge, _Charge_RDY 																			= ConRO:AbilityReady(ids.Arms_Ability.Charge, timeShift);
		local _Charge_RANGE 																				= ConRO:Targets(ids.Arms_Ability.Charge);
	local _ColossusSmash, _ColossusSmash_RDY, _ColossusSmash_CD											= ConRO:AbilityReady(ids.Arms_Ability.ColossusSmash, timeShift);
		local _ColossusSmash_DEBUFF																			= ConRO:TargetAura(ids.Arms_Debuff.ColossusSmash, timeShift);
	local _Execute, _Execute_RDY																		= ConRO:AbilityReady(ids.Arms_Ability.Execute, timeShift);
		local _SuddenDeath_BUFF																				= ConRO:Aura(ids.Arms_Buff.SuddenDeath, timeShift);
	local _HeroicThrow, _HeroicThrow_RDY																= ConRO:AbilityReady(ids.Arms_Ability.HeroicThrow, timeShift);	
	local _MortalStrike, _MortalStrike_RDY																= ConRO:AbilityReady(ids.Arms_Ability.MortalStrike, timeShift);
		local _DeepWounds_DEBUFF																			= ConRO:TargetAura(ids.Arms_Debuff.DeepWounds, timeShift + 4);
	local _Overpower, _Overpower_RDY																	= ConRO:AbilityReady(ids.Arms_Ability.Overpower, timeShift);
		local _Overpower_CHARGES																			= ConRO:SpellCharges(ids.Arms_Ability.Overpower);
		local _Overpower_BUFF, _Overpower_COUNT																= ConRO:Aura(ids.Arms_Buff.Overpower, timeShift);
	local _Pummel, _Pummel_RDY																			= ConRO:AbilityReady(ids.Arms_Ability.Pummel, timeShift);
	local _Slam, _Slam_RDY 																				= ConRO:AbilityReady(ids.Arms_Ability.Slam, timeShift);
	local _ShatteringThrow, _ShatteringThrow_RDY 														= ConRO:AbilityReady(ids.Arms_Ability.ShatteringThrow, timeShift);	
		local _IceBlock_BUFF 																				= ConRO:UnitAura(45438, timeShift, 'target', 'HELPFUL');
		local _DivineShield_BUFF																			= ConRO:UnitAura(642, timeShift, 'target', 'HELPFUL');
	local _SweepingStrikes, _SweepingStrikes_RDY														= ConRO:AbilityReady(ids.Arms_Ability.SweepingStrikes, timeShift);
		local _SweepingStrikes_BUFF																			= ConRO:Aura(ids.Arms_Buff.SweepingStrikes, timeShift);
	local _Whirlwind, _Whirlwind_RDY 																	= ConRO:AbilityReady(ids.Arms_Ability.Whirlwind, timeShift);
	
	local _Avatar, _Avatar_RDY 																			= ConRO:AbilityReady(ids.Arms_Talent.Avatar, timeShift);
	local _Cleave, _Cleave_RDY 																			= ConRO:AbilityReady(ids.Arms_Talent.Cleave, timeShift);
	local _DeadlyCalm, _DeadlyCalm_RDY 																	= ConRO:AbilityReady(ids.Arms_Talent.DeadlyCalm, timeShift);
	local _MassacreExecute, _MassacreExecute_RDY, _MassacreExecute_CD 									= ConRO:AbilityReady(ids.Arms_Talent.MassacreExecute, timeShift);
	local _Ravager, _Ravager_RDY																		= ConRO:AbilityReady(ids.Arms_Talent.Ravager, timeShift);
	local _Rend, _Rend_RDY 																				= ConRO:AbilityReady(ids.Arms_Talent.Rend, timeShift);
		local _Rend_DEBUFF																					= ConRO:TargetAura(ids.Arms_Debuff.Rend, timeShift + 4);
	local _Skullsplitter, _Skullsplitter_RDY															= ConRO:AbilityReady(ids.Arms_Talent.Skullsplitter, timeShift);
	local _StormBolt, _StormBolt_RDY																	= ConRO:AbilityReady(ids.Arms_Talent.StormBolt, timeShift);
	local _Warbreaker, _Warbreaker_RDY, _Warbreaker_CD													= ConRO:AbilityReady(ids.Arms_Talent.Warbreaker, timeShift);

	local _AncientAftershock, _AncientAftershock_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.AncientAftershock, timeShift);
	local _Condemn, _Condemn_RDY, _Condemn_CD															= ConRO:AbilityReady(ids.Covenant_Ability.Condemn, timeShift);
	local _CondemnMassacre, _CondemnMassacre_RDY, _CondemnMassacre_CD									= ConRO:AbilityReady(ids.Covenant_Ability.CondemnMassacre, timeShift);	
	local _ConquerorsBanner, _ConquerorsBanner_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.ConquerorsBanner, timeShift);
	local _SpearofBastion, _SpearofBastion_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.SpearofBastion, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_execute																					= _Target_Percent_Health <= 20;
	
		if C_Covenants.GetActiveCovenantID() == 2 then
			if tChosen[ids.Arms_Talent.Massacre] then
				_can_execute = _Target_Percent_Health <= 35 or _Target_Percent_Health >= 80;
				_Execute_RDY = _Execute_RDY and _CondemnMassacre_CD <= 0;
				_Execute = _CondemnMassacre;
			else
				_can_execute = _Target_Percent_Health <= 20 or _Target_Percent_Health >= 80;
				_Execute_RDY = _Execute_RDY and _Condemn_CD <= 0;
				_Execute = _Condemn;
			end
		else
			if tChosen[ids.Arms_Talent.Massacre] then
				_can_execute = _Target_Percent_Health <= 35;
				_Execute_RDY = _Execute_RDY and _MassacreExecute_CD <= 0;
				_Execute = _MassacreExecute;
			end		
		end
		
--Indicators		
	ConRO:AbilityInterrupt(_Pummel, _Pummel_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_ShatteringThrow, _ShatteringThrow_RDY and (_IceBlock_BUFF or _DivineShield_BUFF));
	ConRO:AbilityRaidBuffs(_BattleShout, _BattleShout_RDY and not ConRO:RaidBuff(ids.Arms_Buff.BattleShout));
	ConRO:AbilityMovement(_Charge, _Charge_RDY and _Charge_RANGE);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_Avatar, _Avatar_RDY and ((not tChosen[ids.Arms_Talent.Warbreaker] and _ColossusSmash_CD < 5) or (tChosen[ids.Arms_Talent.Warbreaker] and _Warbreaker_CD < 5)) and ConRO:BurstMode(_Avatar));
	ConRO:AbilityBurst(_Bladestorm, _Bladestorm_RDY and _ColossusSmash_DEBUFF and not _SweepingStrikes_BUFF and ConRO:BurstMode(_Bladestorm));
	ConRO:AbilityBurst(_ColossusSmash, _ColossusSmash_RDY and not tChosen[ids.Arms_Talent.Warbreaker] and (((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) or (((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and (_SweepingStrikes_BUFF or tChosen[ids.Arms_Talent.Cleave]))) and ConRO:BurstMode(_ColossusSmash));
	ConRO:AbilityBurst(_DeadlyCalm,	_DeadlyCalm_RDY and ConRO:BurstMode(_DeadlyCalm));
	ConRO:AbilityBurst(_Ravager, _Ravager_RDY and ((not tChosen[ids.Arms_Talent.Warbreaker] and _ColossusSmash_RDY) or (tChosen[ids.Arms_Talent.Warbreaker] and _Warbreaker_RDY)) and ConRO:BurstMode(_Ravager));
	ConRO:AbilityBurst(_SweepingStrikes, _SweepingStrikes_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and ConRO:BurstMode(_SweepingStrikes));
	ConRO:AbilityBurst(_Warbreaker, _Warbreaker_RDY and ConRO:BurstMode(_Warbreaker));
	
	ConRO:AbilityBurst(_AncientAftershock, _AncientAftershock_RDY and _in_combat and ConRO:BurstMode(_AncientAftershock));
	ConRO:AbilityBurst(_ConquerorsBanner, _ConquerorsBanner_RDY and _in_combat and ConRO:BurstMode(_ConquerorsBanner));
	ConRO:AbilityBurst(_SpearofBastion, _SpearofBastion_RDY and _in_combat and ConRO:BurstMode(_SpearofBastion));
	
--Warnings	

--Rotations	
	if _ConquerorsBanner_RDY and ConRO:FullMode(_ConquerorsBanner) then
		return _ConquerorsBanner;
	end
	
	if _SweepingStrikes_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and ConRO:FullMode(_SweepingStrikes) then
		return _SweepingStrikes;
	end	

	if _Avatar_RDY and ((not tChosen[ids.Arms_Talent.Warbreaker] and _ColossusSmash_CD < 5) or (tChosen[ids.Arms_Talent.Warbreaker] and _Warbreaker_CD < 5)) and ConRO:FullMode(_Avatar) then
		return _Avatar;
	end
	
	if _Ravager_RDY and ((not tChosen[ids.Arms_Talent.Warbreaker] and _ColossusSmash_RDY) or (tChosen[ids.Arms_Talent.Warbreaker] and _Warbreaker_RDY)) and ConRO:FullMode(_Ravager) then
		return _Ravager;
	end	

	if _Warbreaker_RDY and not _ColossusSmash_DEBUFF and ConRO:FullMode(_Warbreaker) then
		return _Warbreaker;
	end
		
	if _Cleave_RDY and not _DeepWounds_DEBUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
		return _Cleave;
	end

	if _Bladestorm_RDY and not tChosen[ids.Arms_Talent.Ravager] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 4) or ConRO_AoEButton:IsVisible()) and ConRO:FullMode(_Bladestorm) then
		return _Bladestorm;
	end

	if _ColossusSmash_RDY and not _ColossusSmash_DEBUFF	and not tChosen[ids.Arms_Talent.Warbreaker] and (((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) or (((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and (_SweepingStrikes_BUFF or tChosen[ids.Arms_Talent.Cleave]))) and ConRO:FullMode(_ColossusSmash) then
		return _ColossusSmash;
	end
	
	if _Execute_RDY and _Target_Percent_Health >= 80 then
		return _Execute;
	end

	if _Rend_RDY and not _Rend_DEBUFF and not _ColossusSmash_DEBUFF and (((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) or (((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and _SweepingStrikes_BUFF)) then
		return _Rend;
	end

	if _Skullsplitter_RDY and _Rage < 60 then
		return _Skullsplitter;
	end
	
	if _MortalStrike_RDY and not _DeepWounds_DEBUFF and (_enemies_in_melee <= 4 or ConRO_SingleButton:IsVisible()) then
		return _MortalStrike;
	end	
	
	if _DeadlyCalm_RDY and ConRO:FullMode(_DeadlyCalm) then
		return _DeadlyCalm;
	end	

	if _Overpower_RDY and ((not _can_execute and _Overpower_COUNT ~= 2) or _can_execute or ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 4) or ConRO_AoEButton:IsVisible())) then
		return _Overpower;
	end

	if _Execute_RDY then
		return _Execute;
	end

	if _SpearofBastion_RDY and ConRO:FullMode(_SpearofBastion) then
		return _SpearofBastion;
	end	

	if _AncientAftershock_RDY and ConRO:FullMode(_AncientAftershock) then
		return _AncientAftershock;
	end	

	if _MortalStrike_RDY and (_enemies_in_melee <= 4 or ConRO_SingleButton:IsVisible()) then
		return _MortalStrike;
	end

	if _Bladestorm_RDY and not tChosen[ids.Arms_Talent.Ravager] and _ColossusSmash_DEBUFF and ConRO:FullMode(_Bladestorm) then
		return _Bladestorm;
	end
	
	if _Whirlwind_RDY and not _can_execute and _Rage >= 60 and (tChosen[ids.Arms_Talent.FervorofBattle] or (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
		return _Whirlwind;
	end	
	
	if _Slam_RDY and not _can_execute and _Rage >= 50 and not tChosen[ids.Arms_Talent.FervorofBattle] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
		return _Slam;
	end
return nil;
end

function ConRO.Warrior.ArmsDef(_, timeShift, currentSpell, gcd, tChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Rage, _Rage_Max																				= ConRO:PlayerPower('Rage');
	
--Abilities	
	local _RallyingCry, _RallyingCry_RDY																= ConRO:AbilityReady(ids.Arms_Ability.RallyingCry, timeShift);
	local _DiebytheSword, _DiebytheSword_RDY 															= ConRO:AbilityReady(ids.Arms_Ability.DiebytheSword, timeShift);
	local _IgnorePain, _IgnorePain_RDY 																	= ConRO:AbilityReady(ids.Arms_Ability.IgnorePain, timeShift);
		local _IgnorePain_BUFF 																				= ConRO:Aura(ids.Arms_Buff.IgnorePain, timeShift);
	local _VictoryRush, _VictoryRush_RDY 																= ConRO:AbilityReady(ids.Arms_Ability.VictoryRush, timeShift);
		local _Victorious_BUFF																				= ConRO:Aura(ids.Arms_Buff.Victorious, timeShift);
		
	local _DefensiveStance, _DefensiveStance_RDY														= ConRO:AbilityReady(ids.Arms_Talent.DefensiveStance, timeShift);
		local _DefensiveStance_FORM																			= ConRO:Form(ids.Arms_Form.DefensiveStance);
	local _ImpendingVictory, _ImpendingVictory_RDY	 													= ConRO:AbilityReady(ids.Arms_Talent.ImpendingVictory, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");	
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations	
	if _Fleshcraft_RDY and _in_combat then
		return _Fleshcraft;
	end
	
	if tChosen[ids.Arms_Talent.ImpendingVictory] then
		if _ImpendingVictory_RDY and _Player_Percent_Health <= 80 then	
			return _ImpendingVictory;
		end
	else
		if _VictoryRush_RDY and _Victorious_BUFF and _Player_Percent_Health < 100 then	
			return _VictoryRush;
		end
	end

	if _IgnorePain_RDY and not _IgnorePain_BUFF and _Player_Percent_Health <= 90 and _Rage >= 80 then
		return _IgnorePain;
	end
	
	if _DiebytheSword_RDY then
		return _DiebytheSword;
	end
	
	if _RallyingCry_RDY then
		return _RallyingCry;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _DefensiveStance_RDY and not _DefensiveStance_FORM then
		return _DefensiveStance;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Warrior.Fury(_, timeShift, currentSpell, gcd, tChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Rage, _Rage_Max																				= ConRO:PlayerPower('Rage');

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities	
	local _BattleShout, _BattleShout_RDY																= ConRO:AbilityReady(ids.Fury_Ability.BattleShout, timeShift);	
	local _Bloodthirst, _Bloodthirst_RDY 																= ConRO:AbilityReady(ids.Fury_Ability.Bloodthirst, timeShift + 0.5);
		local _Enrage_BUFF 																					= ConRO:Aura(ids.Fury_Buff.Enrage, timeShift);
	local _Charge, _Charge_RDY 																			= ConRO:AbilityReady(ids.Fury_Ability.Charge, timeShift);
		local _Charge_RANGE 																				= ConRO:IsSpellInRange(ids.Fury_Ability.Charge, 'target');
	local _Execute, _Execute_RDY 																		= ConRO:AbilityReady(ids.Fury_Ability.Execute, timeShift);
		local _SuddenDeath_BUFF 																			= ConRO:Aura(ids.Fury_Buff.SuddenDeath, timeShift);	
	local _Pummel, _Pummel_RDY 																			= ConRO:AbilityReady(ids.Fury_Ability.Pummel, timeShift);
	local _Rampage, _Rampage_RDY 																		= ConRO:AbilityReady(ids.Fury_Ability.Rampage, timeShift);
	local _RagingBlow, _RagingBlow_RDY 																	= ConRO:AbilityReady(ids.Fury_Ability.RagingBlow, timeShift + 0.5);
		local _RagingBlow_CHARGES																			= ConRO:SpellCharges(ids.Fury_Ability.RagingBlow);		
	local _Recklessness, _Recklessness_RDY, _Recklessness_CD											= ConRO:AbilityReady(ids.Fury_Ability.Recklessness, timeShift);
		local _Recklessness_BUFF 																			= ConRO:Aura(ids.Fury_Buff.Recklessness, timeShift - .5);
	local _ShatteringThrow, _ShatteringThrow_RDY 														= ConRO:AbilityReady(ids.Fury_Ability.ShatteringThrow, timeShift);	
		local _IceBlock_BUFF 																				= ConRO:UnitAura(45438, timeShift, 'target', 'HELPFUL');
		local _DivineShield_BUFF																			= ConRO:UnitAura(642, timeShift, 'target', 'HELPFUL');
	local _Whirlwind, _Whirlwind_RDY 																	= ConRO:AbilityReady(ids.Fury_Ability.Whirlwind, timeShift);
		local _Whirlwind_BUFF, _Whirlwind_COUNT																= ConRO:Aura(ids.Fury_Buff.Whirlwind, timeShift + 2);
		
	local _DragonRoar, _DragonRoar_RDY 																	= ConRO:AbilityReady(ids.Fury_Talent.DragonRoar, timeShift);
	local _Bladestorm, _Bladestorm_RDY 																	= ConRO:AbilityReady(ids.Fury_Talent.Bladestorm, timeShift);
	local _Siegebreaker, _Siegebreaker_RDY																= ConRO:AbilityReady(ids.Fury_Talent.Siegebreaker, timeShift);
		local _Siegebreaker_DEBUFF																			= ConRO:TargetAura(ids.Fury_Debuff.Siegebreaker, timeShift);
	local _Onslaught, _Onslaught_RDY																	= ConRO:AbilityReady(ids.Fury_Talent.Onslaught, timeShift);
	local _Bloodbath, _, _BloodbathCD																	= ConRO:AbilityReady(ids.Fury_Talent.Bloodbath, timeShift);
	local _CrushingBlow, _, _CrushingBlowCD																= ConRO:AbilityReady(ids.Fury_Talent.CrushingBlow, timeShift);
	local _MassacreExecute, _, _MassacreExecute_CD 														= ConRO:AbilityReady(ids.Fury_Talent.MassacreExecute, timeShift);

	local _AncientAftershock, _AncientAftershock_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.AncientAftershock, timeShift);
	local _Condemn, _Condemn_RDY, _Condemn_CD															= ConRO:AbilityReady(ids.Covenant_Ability.CondemnFury, timeShift);
	local _CondemnMassacre, _CondemnMassacre_RDY, _CondemnMassacre_CD									= ConRO:AbilityReady(ids.Covenant_Ability.CondemnMassacreFury, timeShift);	
	local _ConquerorsBanner, _ConquerorsBanner_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.ConquerorsBanner, timeShift);
	local _SpearofBastion, _SpearofBastion_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.SpearofBastion, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_execute																					= _Target_Percent_Health <= 20;

		if C_Covenants.GetActiveCovenantID() == 2 then
			if tChosen[ids.Fury_Talent.Massacre] then
				_can_execute = _Target_Percent_Health <= 35 or _Target_Percent_Health >= 80;
				_Execute_RDY = _Execute_RDY and _CondemnMassacre_CD <= 0;
				_Execute = _CondemnMassacre;
			else
				_can_execute = _Target_Percent_Health <= 20 or _Target_Percent_Health >= 80;
				_Execute_RDY = _Execute_RDY and _Condemn_CD <= 0;
				_Execute = _Condemn;
			end
		else
			if tChosen[ids.Fury_Talent.Massacre] then
				_can_execute = _Target_Percent_Health <= 35;
				_Execute_RDY = _Execute_RDY and _MassacreExecute_CD <= 0;
				_Execute = _MassacreExecute;
			end		
		end
	
		if tChosen[ids.Fury_Talent.RecklessAbandon] and _Recklessness_BUFF then
			_Bloodthirst_RDY = _Bloodthirst_RDY and _BloodbathCD <= 0;
			_Bloodthirst = _Bloodbath;
			
			_RagingBlow_RDY = _RagingBlow_RDY and _CrushingBlowCD <= 0;
			_RagingBlow = _CrushingBlow;
		end

--Indicators	
	ConRO:AbilityInterrupt(_Pummel, _Pummel_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_ShatteringThrow, _ShatteringThrow_RDY and (_IceBlock_BUFF or _DivineShield_BUFF));
	ConRO:AbilityRaidBuffs(_BattleShout, _BattleShout_RDY and not ConRO:RaidBuff(ids.Fury_Buff.BattleShout));
	ConRO:AbilityMovement(_Charge, _Charge_RDY and _Charge_RANGE);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_Recklessness, _Recklessness_RDY and ConRO:BurstMode(_Recklessness));
	ConRO:AbilityBurst(_Bladestorm, _Bladestorm_RDY and ConRO:BurstMode(_Bladestorm));
	
	ConRO:AbilityBurst(_AncientAftershock, _AncientAftershock_RDY and _in_combat and ConRO:BurstMode(_AncientAftershock));
	ConRO:AbilityBurst(_ConquerorsBanner, _ConquerorsBanner_RDY and _in_combat and ConRO:BurstMode(_ConquerorsBanner));
	ConRO:AbilityBurst(_SpearofBastion, _SpearofBastion_RDY and _in_combat and ConRO:BurstMode(_SpearofBastion));
	
--Warnings	


--Rotations		
	if not _in_combat or ConRO.lastSpellId == _Charge then
		if _Recklessness_RDY and not _Recklessness_BUFF and ConRO:FullMode(_Recklessness) then
			return _Recklessness;
		end
		
		if _Rampage_RDY and (not _Enrage_BUFF or _Recklessness_BUFF or _Rage >= 90) then
			return _Rampage;
		end

		if _Bloodthirst_RDY and not _Enrage_BUFF then
			return _Bloodthirst;
		end
	else
		if _ConquerorsBanner_RDY and ConRO:FullMode(_ConquerorsBanner) then
			return _ConquerorsBanner;
		end

		if _Whirlwind_RDY and not _Whirlwind_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			return _Whirlwind;
		end

		if _Siegebreaker_RDY and _Rage < 90 and (_Recklessness_BUFF or _Recklessness_CD >= 20 or (_Recklessness_RDY and ConRO:BurstMode(_Recklessness))) then
			return _Siegebreaker;
		end	
		
		if _Rampage_RDY and (not _Enrage_BUFF or _Recklessness_BUFF or _Rage >= 90) then
			return _Rampage;
		end
		
		if _Recklessness_RDY and not _Recklessness_BUFF and ConRO:FullMode(_Recklessness) then
			return _Recklessness;
		end

		if _Execute_RDY and ((_Rage <= 60 and _Recklessness_BUFF) or (_Rage <= 80 and not _Recklessness_BUFF)) then
			return _Execute;
		end	
		
		if _SpearofBastion_RDY and (_Recklessness_BUFF or _Recklessness_CD >= 55 or (_Recklessness_RDY and ConRO:BurstMode(_Recklessness))) and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and ConRO:FullMode(_SpearofBastion) then
			return _SpearofBastion;
		end	
		
		if _AncientAftershock_RDY and _Recklessness_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and ConRO:FullMode(_AncientAftershock) then
			return _AncientAftershock;
		end

		if _DragonRoar_RDY and (_Recklessness_BUFF or _Recklessness_CD >= 25 or (_Recklessness_RDY and ConRO:BurstMode(_Recklessness))) and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			return _DragonRoar;
		end

		if _Bladestorm_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and ConRO:FullMode(_Bladestorm) then
			return _Bladestorm;
		end

		if _Onslaught_RDY and _Enrage_BUFF then
			return _Onslaught;
		end

		if _RagingBlow_RDY and (_RagingBlow_CHARGES >= 2 or _Recklessness_BUFF) and _Enrage_BUFF then
			return _RagingBlow;
		end	
		
		if _SpearofBastion_RDY and _Enrage_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) and ConRO:FullMode(_SpearofBastion) then
			return _SpearofBastion;
		end	
		
		if _AncientAftershock_RDY and _Enrage_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) and ConRO:FullMode(_AncientAftershock) then
			return _AncientAftershock;
		end

		if _Bloodthirst_RDY then
			return _Bloodthirst;
		end

		if _DragonRoar_RDY and _Enrage_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
			return _DragonRoar;
		end
		
		if _Bladestorm_RDY and _Enrage_BUFF and ConRO:FullMode(_Bladestorm) then
			return _Bladestorm;
		end

		if _RagingBlow_RDY then	
			return _RagingBlow;
		end
				
		if _Whirlwind_RDY then
			return _Whirlwind;
		end
	end
return nil;
end

function ConRO.Warrior.FuryDef(_, timeShift, currentSpell, gcd, tChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Rage, _Rage_Max																				= ConRO:PlayerPower('Rage');
	
--Abilities	
	local _RallyingCry, _RallyingCry_RDY 																= ConRO:AbilityReady(ids.Fury_Ability.RallyingCry, timeShift);
	local _EnragedRegeneration, _EnragedRegeneration_RDY												= ConRO:AbilityReady(ids.Fury_Ability.EnragedRegeneration, timeShift);
	local _VictoryRush, _VictoryRush_RDY 																= ConRO:AbilityReady(ids.Fury_Ability.VictoryRush, timeShift);
		local _Victorious_BUFF																				= ConRO:Aura(ids.Fury_Buff.Victorious, timeShift);
	local _IgnorePain, _IgnorePain_RDY 																	= ConRO:AbilityReady(ids.Fury_Ability.IgnorePain, timeShift);
		local _IgnorePain_BUFF 																				= ConRO:Aura(ids.Fury_Buff.IgnorePain, timeShift);

	local _ImpendingVictory, _ImpendingVictory_RDY	 													= ConRO:AbilityReady(ids.Fury_Talent.ImpendingVictory, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end
	
	if tChosen[ids.Fury_Talent.ImpendingVictory] then
		if _ImpendingVictory_RDY and _Player_Percent_Health <= 80 then	
			return _ImpendingVictory;
		end
	else
		if _VictoryRush_RDY and _Victorious_BUFF and _Player_Percent_Health < 100 then	
			return _VictoryRush;
		end
	end

	if _IgnorePain_RDY and not _IgnorePain_BUFF and _Player_Percent_Health <= 90 and _Rage >= 70 then
		return _IgnorePain;
	end
	
	if _EnragedRegeneration_RDY then
		return _EnragedRegeneration;
	end
		
	if _RallyingCry_RDY then
		return _RallyingCry;
	end
	
	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Warrior.Protection(_, timeShift, currentSpell, gcd, tChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Rage, _Rage_Max																				= ConRO:PlayerPower('Rage');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _Avatar, _Avatar_RDY 																			= ConRO:AbilityReady(ids.Prot_Ability.Avatar, timeShift);
		local _Avatar_BUFF 																					= ConRO:Aura(ids.Prot_Buff.Avatar, timeShift);
	local _BattleShout, _BattleShout_RDY 																= ConRO:AbilityReady(ids.Prot_Ability.BattleShout, timeShift);	
	local _Charge, _Charge_RDY 																			= ConRO:AbilityReady(ids.Fury_Ability.Charge, timeShift);
		local _Charge_RANGE 																				= ConRO:IsSpellInRange(ids.Fury_Ability.Charge, 'target');
	local _DemoralizingShout, _DemoralizingShout_RDY													= ConRO:AbilityReady(ids.Prot_Ability.DemoralizingShout, timeShift);
	local _Devastate, _Devastate_RDY 																	= ConRO:AbilityReady(ids.Prot_Ability.Devastate, timeShift);
	local _Execute, _Execute_RDY 																		= ConRO:AbilityReady(ids.Prot_Ability.Execute, timeShift);
	local _Pummel, _Pummel_RDY 																			= ConRO:AbilityReady(ids.Prot_Ability.Pummel, timeShift);	
	local _Revenge, _Revenge_RDY 																		= ConRO:AbilityReady(ids.Prot_Ability.Revenge, timeShift);
		local _Revenge_BUFF 																				= ConRO:Aura(ids.Prot_Buff.Revenge, timeShift);
	local _ShatteringThrow, _ShatteringThrow_RDY 														= ConRO:AbilityReady(ids.Prot_Ability.ShatteringThrow, timeShift);	
		local _IceBlock_BUFF 																				= ConRO:UnitAura(45438, timeShift, 'target', 'HELPFUL');
		local _DivineShield_BUFF																			= ConRO:UnitAura(642, timeShift, 'target', 'HELPFUL');
	local _ShieldBlock, _ShieldBlock_RDY 																= ConRO:AbilityReady(ids.Prot_Ability.ShieldBlock, timeShift);
		local _ShieldBlock_CHARGES																			= ConRO:SpellCharges(ids.Prot_Ability.ShieldBlock);
		local _ShieldBlock_BUFF 																			= ConRO:Aura(ids.Prot_Buff.ShieldBlock, timeShift);
	local _ShieldSlam, _ShieldSlam_RDY, _ShieldSlam_CD													= ConRO:AbilityReady(ids.Prot_Ability.ShieldSlam, timeShift);
	local _Shockwave, _Shockwave_RDY 																	= ConRO:AbilityReady(ids.Prot_Ability.Shockwave, timeShift);
	local _Taunt, _Taunt_RDY 																			= ConRO:AbilityReady(ids.Prot_Ability.Taunt, timeShift);
	local _ThunderClap, _ThunderClap_RDY																= ConRO:AbilityReady(ids.Prot_Ability.ThunderClap, timeShift);
	
	local _DragonRoar, _DragonRoar_RDY																	= ConRO:AbilityReady(ids.Prot_Talent.DragonRoar, timeShift);	
	local _Ravager, _Ravager_RDY																		= ConRO:AbilityReady(ids.Prot_Talent.Ravager, timeShift);
	local _StormBolt, _StormBolt_RDY 																	= ConRO:AbilityReady(ids.Prot_Talent.StormBolt, timeShift);
	
	local _AncientAftershock, _AncientAftershock_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.AncientAftershock, timeShift);
	local _Condemn, _Condemn_RDY, _Condemn_CD															= ConRO:AbilityReady(ids.Covenant_Ability.Condemn, timeShift);
	local _ConquerorsBanner, _ConquerorsBanner_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.ConquerorsBanner, timeShift);
	local _SpearofBastion, _SpearofBastion_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.SpearofBastion, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds																				= CheckInteractDistance("target", 3);
	local _can_execute																					= _Target_Percent_Health <= 20;
		
		if C_Covenants.GetActiveCovenantID() == 2 then
			_can_execute = _Target_Percent_Health <= 20 or _Target_Percent_Health >= 80;
			_Execute_RDY = _Execute_RDY and _Condemn_CD <= 0;
			_Execute = ids.Covenant_Ability.Condemn;
		end
		
--Indicators		
	ConRO:AbilityInterrupt(_Pummel, _Pummel_RDY and ConRO:Interrupt());
	
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_ShatteringThrow, _ShatteringThrow_RDY and (_IceBlock_BUFF or _DivineShield_BUFF));
	ConRO:AbilityRaidBuffs(_BattleShout, _BattleShout_RDY and not ConRO:RaidBuff(ids.Prot_Buff.BattleShout));
	ConRO:AbilityTaunt(_Taunt, _Taunt_RDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));
	ConRO:AbilityMovement(_Charge, _Charge_RDY and _Charge_RANGE);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);

	ConRO:AbilityBurst(_Avatar, _Avatar_RDY and _is_Enemy and ConRO:BurstMode(_Avatar));
	ConRO:AbilityBurst(_DemoralizingShout, _DemoralizingShout_RDY and tChosen[ids.Prot_Talent.BoomingVoice] and _is_Enemy and ConRO:BurstMode(_DemoralizingShout));
	ConRO:AbilityBurst(_Ravager, _Ravager_RDY and _is_Enemy and ConRO:BurstMode(_Ravager));
	
	ConRO:AbilityBurst(_AncientAftershock, _AncientAftershock_RDY and _in_combat and ConRO:BurstMode(_AncientAftershock));
	ConRO:AbilityBurst(_ConquerorsBanner, _ConquerorsBanner_RDY and _in_combat and ConRO:BurstMode(_ConquerorsBanner));
	ConRO:AbilityBurst(_SpearofBastion, _SpearofBastion_RDY and _in_combat and ConRO:BurstMode(_SpearofBastion));

--Warnings	

--Rotations	
	if _Avatar_RDY and ConRO:FullMode(_Avatar) then
		return _Avatar;
	end

	if _DemoralizingShout_RDY and tChosen[ids.Prot_Talent.BoomingVoice] and ConRO:FullMode(_DemoralizingShout) then
		return _DemoralizingShout;
	end

	if _SpearofBastion_RDY and ConRO:FullMode(_SpearofBastion) then
		return _SpearofBastion;
	end
	
	if _ConquerorsBanner_RDY and ConRO:FullMode(_ConquerorsBanner) then
		return _ConquerorsBanner;
	end

	if _AncientAftershock_RDY and ConRO:FullMode(_AncientAftershock) then
		return _AncientAftershock;
	end
	
	if _Ravager_RDY and ConRO:FullMode(_Ravager) then
		return _Ravager;
	end	

	if _DragonRoar_RDY then
		return _DragonRoar;
	end	

	if _Revenge_RDY and (_Revenge_BUFF or _Rage >= 60) and _enemies_in_melee >= 3 then
		return _Revenge;
	end

	if _ThunderClap_RDY and _enemies_in_melee >= 3 then
		return _ThunderClap;
	end
	
	if _ShieldBlock_RDY and (_ShieldSlam_RDY or _ShieldSlam_CD < 2) and not _ShieldBlock_BUFF and _ShieldBlock_CHARGES >= 2 then
		return _ShieldBlock;
	end
	
	if _ShieldSlam_RDY then
		return _ShieldSlam;
	end	
	
	if _ThunderClap_RDY and _enemies_in_melee <= 2 then
		return _ThunderClap;
	end		

	if _Revenge_RDY and _Revenge_BUFF and _enemies_in_melee <= 2 then
		return _Revenge;
	end	
	
	if _Execute_RDY and _Rage >= 80 and _can_execute and _enemies_in_melee <= 2 then
		return _Execute;
	end
	
	if _Revenge_RDY and _Rage >= 80 and _enemies_in_melee <= 2 then
		return _Revenge;
	end		
	
	if _Devastate_RDY and not tChosen[ids.Prot_Talent.Devastator] then
		return _Devastate;
	end
return nil;
end

function ConRO.Warrior.ProtectionDef(_, timeShift, currentSpell, gcd, tChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Rage, _Rage_Max																				= ConRO:PlayerPower('Rage');
	
--Abilities	
	local _ShieldWall, _ShieldWall_RDY 																	= ConRO:AbilityReady(ids.Prot_Ability.ShieldWall, timeShift);
	local _ShieldBlock, _ShieldBlock_RDY																= ConRO:AbilityReady(ids.Prot_Ability.ShieldBlock, timeShift);
		local _ShieldBlock_CHARGES																			= ConRO:SpellCharges(ids.Prot_Ability.ShieldBlock);
		local _ShieldBlock_BUFF 																			= ConRO:Aura(ids.Prot_Buff.ShieldBlock, timeShift);
	local _LastStand, _LastStand_RDY 																	= ConRO:AbilityReady(ids.Prot_Ability.LastStand, timeShift);
	local _DemoralizingShout, _DemoralizingShout_RDY													= ConRO:AbilityReady(ids.Prot_Ability.DemoralizingShout, timeShift);
	local _VictoryRush, _VictoryRush_RDY 																= ConRO:AbilityReady(ids.Prot_Ability.VictoryRush, timeShift);
		local _Victorious_BUFF 																				= ConRO:Aura(ids.Prot_Buff.Victorious, timeShift);
	local _IgnorePain, _IgnorePain_RDY 																	= ConRO:AbilityReady(ids.Prot_Ability.IgnorePain, timeShift);
		local _IgnorePain_BUFF 																				= ConRO:Aura(ids.Prot_Buff.IgnorePain, timeShift);
	local _SpellReflection, _SpellReflection_RDY														= ConRO:AbilityReady(ids.Prot_Ability.SpellReflection, timeShift);
		
	local _ImpendingVictory, _ImpendingVictory_RDY 														= ConRO:AbilityReady(ids.Prot_Talent.ImpendingVictory, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end

	if _SpellReflection_RDY and (ConRO:BossCast() or ConRO:Interrupt()) and ConRO:TarYou() then
		return _SpellReflection;
	end
	
	if tChosen[ids.Prot_Talent.ImpendingVictory] then
		if _ImpendingVictory_RDY and _Player_Percent_Health <= 80 then	
			return _ImpendingVictory;
		end
	else
		if _VictoryRush_RDY and _Victorious_BUFF and _Player_Percent_Health < 100 then	
			return _VictoryRush;
		end
	end
		
	if _LastStand_RDY and _Player_Percent_Health <= 40 then
		return _LastStand;
	end
	
	if _IgnorePain_RDY and not _IgnorePain_BUFF and _Player_Percent_Health <= 90 and _Rage >= 70 then
		return _IgnorePain;
	end
	
	if _ShieldBlock_RDY and _ShieldBlock_CHARGES >= 1 and ConRO:TarYou() then
		return _ShieldBlock;
	end
	
	if _DemoralizingShout_RDY then
		return _DemoralizingShout;
	end
		
	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end

	if _ShieldWall_RDY then
		return _ShieldWall;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
	return nil;
end