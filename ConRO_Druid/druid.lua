ConRO.Druid = {};
ConRO.Druid.CheckTalents = function()
end
ConRO.Druid.CheckPvPTalents = function()
end
local ConRO_Druid, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Druid.CheckTalents;
	self.ModuleOnEnable = ConRO.Druid.CheckPvPTalents;	
	if mode == 0 then
		self.Description = "Druid [No Specialization Under 10]";
		self.NextSpell = ConRO.Druid.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = "Druid [Balance - Caster]";
		if ConRO.db.profile._Spec_1_Enabled then			
			self.NextSpell = ConRO.Druid.Balance;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Druid.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 2 then
		self.Description = "Druid [Feral - Melee]";
		if ConRO.db.profile._Spec_2_Enabled then			
			self.NextSpell = ConRO.Druid.Feral;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Druid.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 3 then
		self.Description = "Druid [Guardian - Tank]";
		if ConRO.db.profile._Spec_3_Enabled then			
			self.NextSpell = ConRO.Druid.Guardian;
			self.ToggleDamage();
			self.BlockAoE();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Druid.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 4 then
		self.Description = "Druid [Restoration - Healer]";
		if ConRO.db.profile._Spec_4_Enabled then			
			self.NextSpell = ConRO.Druid.Restoration;
			self.ToggleHealer();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Druid.Disabled;
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
		self.NextDef = ConRO.Druid.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Druid.BalanceDef;
		else
			self.NextDef = ConRO.Druid.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Druid.FeralDef;
		else
			self.NextDef = ConRO.Druid.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Druid.GuardianDef;
		else
			self.NextDef = ConRO.Druid.Disabled;
		end
	end;
	if mode == 4 then
		if ConRO.db.profile._Spec_4_Enabled then
			self.NextDef = ConRO.Druid.RestorationDef;
		else
			self.NextDef = ConRO.Druid.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Druid.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Druid.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Druid.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Druid.Balance(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _LunarPower, _LunarPower_Max																	= ConRO:PlayerPower('LunarPower');
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	
--Racials
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);

--Abilities
	local _CelestialAlignment, _CelestialAlignment_RDY, _CelestialAlignment_CD							= ConRO:AbilityReady(ids.Bal_Ability.CelestialAlignment, timeShift);
		local _CelestialAlignment_BUFF																		= ConRO:Aura(ids.Bal_Buff.CelestialAlignment, timeShift);
	local _Moonfire, _Moonfire_RDY 																		= ConRO:AbilityReady(ids.Bal_Ability.Moonfire, timeShift);
		local _Moonfire_DEBUFF, _, _Moonfire_DUR															= ConRO:TargetAura(ids.Bal_Debuff.Moonfire, timeShift);
	local _MoonkinForm, _MoonkinForm_RDY																= ConRO:AbilityReady(ids.Bal_Ability.MoonkinForm, timeShift);
		local _MoonkinForm_FORM																				= ConRO:Form(ids.Bal_Form.MoonkinForm);
		local _OwlkinFrenzy_BUFF																			= ConRO:Aura(ids.Bal_Buff.OwlkinFrenzy, timeShift);
	local _SolarBeam, _SolarBeam_RDY																	= ConRO:AbilityReady(ids.Bal_Ability.SolarBeam, timeShift);
	local _Soothe, _Soothe_RDY																			= ConRO:AbilityReady(ids.Bal_Ability.Soothe, timeShift); 
	local _Starfire, _Starfire_RDY																		= ConRO:AbilityReady(ids.Bal_Ability.Starfire, timeShift);
		local _Starfire_Count																				= GetSpellCount(ids.Bal_Ability.Starfire);
		local _EclipseSolar_BUFF, _, _EclipseSolar_DUR														= ConRO:Aura(ids.Bal_Buff.EclipseSolar, timeShift);
	local _Starsurge, _Starsurge_RDY																	= ConRO:AbilityReady(ids.Bal_Ability.Starsurge, timeShift);
		local _Starlord_BUFF, _Starlord_COUNT																= ConRO:Aura(ids.Bal_Buff.Starlord, timeShift);
	local _Starfall, _Starfall_RDY																		= ConRO:AbilityReady(ids.Bal_Ability.Starfall, timeShift);
		local _Starfall_BUFF, _, _Starfall_DUR																= ConRO:Aura(ids.Bal_Buff.Starfall, timeShift);
	local _Sunfire, _Sunfire_RDY																		= ConRO:AbilityReady(ids.Bal_Ability.Sunfire, timeShift);
		local _Sunfire_DEBUFF, _, _Sunfire_DUR																= ConRO:TargetAura(ids.Bal_Debuff.Sunfire, timeShift);	
	local _Wrath, _Wrath_RDY																			= ConRO:AbilityReady(ids.Bal_Ability.Wrath, timeShift);
		local _Wrath_Count																					= GetSpellCount(ids.Bal_Ability.Wrath);
		local _EclipseLunar_BUFF, _, _EclipseLunar_DUR														= ConRO:Aura(ids.Bal_Buff.EclipseLunar, timeShift);
		
	local _ForceofNature, _ForceofNature_RDY															= ConRO:AbilityReady(ids.Bal_Talent.ForceofNature, timeShift);
	local _FuryofElune, _FuryofElune_RDY																= ConRO:AbilityReady(ids.Bal_Talent.FuryofElune, timeShift);
	local _IncarnationChosenofElune, _IncarnationChosenofElune_RDY, _IncarnationChosenofElune_CD		= ConRO:AbilityReady(ids.Bal_Talent.IncarnationChosenofElune, timeShift);
		local _IncarnationChosenofElune_BUFF																= ConRO:Aura(ids.Bal_Buff.IncarnationChosenofElune, timeShift);
	local _NewMoon, _NewMoon_RDY  																		= ConRO:AbilityReady(ids.Bal_Talent.NewMoon, timeShift);
		local _HalfMoon, _, _HalfMoon_CD  																	= ConRO:AbilityReady(ids.Bal_Talent.HalfMoon, timeShift);
		local _FullMoon, _, _FullMoon_CD  																	= ConRO:AbilityReady(ids.Bal_Talent.FullMoon, timeShift);
		local _NewMoon_CHARGES																				= ConRO:SpellCharges(ids.Bal_Talent.NewMoon);
	local _StellarFlare, _StellarFlare_RDY																= ConRO:AbilityReady(ids.Bal_Talent.StellarFlare, timeShift);	
		local _StellarFlare_DEBUFF, _, _StellarFlare_DUR													= ConRO:TargetAura(ids.Bal_Debuff.StellarFlare, timeShift);	
	local _WarriorofElune, _WarriorofElune_RDY															= ConRO:AbilityReady(ids.Bal_Talent.WarriorofElune, timeShift);
		local _WarriorofElune_BUFF 																			= ConRO:Form(ids.Bal_Form.WarriorofElune);
		
	local _AdaptiveSwarm, _AdaptiveSwarm_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.AdaptiveSwarm, timeShift);
		local _AdaptiveSwarm_DEBUFF																			= ConRO:TargetAura(ids.Covenant_Debuff.AdaptiveSwarm, timeShift);
	local _ConvoketheSpirits, _ConvoketheSpirits_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.ConvoketheSpirits, timeShift);
	local _KindredSpirits, _KindredSpirits_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.KindredSpirits, timeShift);
		local _EmpowerBondDamage, _, _EmpowerBondDamage_CD													= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondDamage, timeShift);
		local _EmpowerBondTank, _, _EmpowerBondTank_CD														= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondTank, timeShift);
		local _EmpowerBondHealer, _, _EmpowerBondHealer_CD													= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondHealer, timeShift);
		local _KindredEmpowerment_BUFF																		= ConRO:Aura(ids.Covenant_Buff.KindredEmpowerment, timeShift);
		local _KindredSpirits_BUFF																			= ConRO:Aura(ids.Covenant_Buff.KindredSpirits, timeShift);
		local _LoneEmpowerment, _, _LoneEmpowerment_CD														= ConRO:AbilityReady(ids.Covenant_Ability.LoneEmpowerment, timeShift);
		local _LoneEmpowerment_BUFF																			= ConRO:Aura(ids.Covenant_Buff.LoneEmpowerment, timeShift);
		local _LoneSpirit_BUFF																				= ConRO:Aura(ids.Covenant_Buff.LoneSpirit, timeShift);
	local _RavenousFrenzy, _RavenousFrenzy_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.RavenousFrenzy, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _enemies_in_range, _target_in_range															= ConRO:Targets(ids.Bal_Ability.Wrath);	

	local _movability = false
		if (not _is_moving) or (tChosen[ids.Bal_Talent.StellarDrift] and _Starfall_BUFF) then
			_movability = true;
		end
	
		if _Wrath_Count == 1 and currentSpell == _Wrath then
			_EclipseLunar_BUFF = true;
			_EclipseLunar_DUR = 15;
		end

		if _Starfire_Count == 1 and currentSpell == _Starfire then
			_EclipseSolar_BUFF = true;
			_EclipseSolar_DUR = 15;
		end		

		if currentSpell == ids.Bal_Talent.FullMoon then
			_LunarPower = _LunarPower + 40;
			_NewMoon_CHARGES = _NewMoon_CHARGES - 1;
		elseif currentSpell == ids.Bal_Talent.NewMoon then
			_LunarPower = _LunarPower + 10;
			_NewMoon_CHARGES = _NewMoon_CHARGES - 1;
		elseif currentSpell == ids.Bal_Talent.HalfMoon then
			_LunarPower = _LunarPower + 20;
			_NewMoon_CHARGES = _NewMoon_CHARGES - 1;
		elseif currentSpell == ids.Bal_Ability.Wrath then
			if tChosen[ids.Bal_Talent.SouloftheForest] and _EclipseSolar_BUFF then
				_LunarPower = _LunarPower + 9;
			else
				_LunarPower = _LunarPower + 6;
			end
			_Wrath_Count = _Wrath_Count - 1;
		elseif currentSpell == ids.Bal_Ability.Starfire then
			_LunarPower = _LunarPower + 8;
			_Starfire_Count = _Starfire_Count - 1;
		end

		if ConRO:FindSpell(_FullMoon) then
			_NewMoon_RDY = _NewMoon_RDY and _FullMoon_CD <= 0;
			_NewMoon = _FullMoon;
		elseif ConRO:FindSpell(_HalfMoon) then
			_NewMoon_RDY = _NewMoon_RDY and _HalfMoon_CD <= 0;
			_NewMoon = _HalfMoon;
		end
		
		if _KindredSpirits_BUFF then
			if ConRO:FindCurrentSpell(_EmpowerBondDamage) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondDamage_CD <= 0;
				_KindredSpirits = _EmpowerBondDamage;
			elseif ConRO:FindCurrentSpell(_EmpowerBondTank) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondTank_CD <= 0;
				_KindredSpirits = _EmpowerBondTank;
			elseif ConRO:FindCurrentSpell(_EmpowerBondHealer) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondHealer_CD <= 0;
				_KindredSpirits = _EmpowerBondHealer;
			end
		end

		if _LoneSpirit_BUFF then
			_KindredSpirits_BUFF = _LoneSpirit_BUFF;
			_KindredSpirits_RDY = _KindredSpirits_RDY and _LoneEmpowerment_CD <= 0;
			_KindredSpirits = _LoneEmpowerment;
		end

	local _No_Eclipse = not _EclipseSolar_BUFF and not _EclipseLunar_BUFF;
	
--Indicators
	ConRO:AbilityInterrupt(_SolarBeam, _SolarBeam_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Soothe, _Soothe_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityBurst(_CelestialAlignment, _CelestialAlignment_RDY and _Moonfire_DEBUFF and _Sunfire_DEBUFF and (not tChosen[ids.Bal_Talent.StellarFlare] or (tChosen[ids.Bal_Talent.StellarFlare] and _StellarFlare_DEBUFF)) and (_EclipseSolar_BUFF or _EclipseLunar_BUFF) and not tChosen[ids.Bal_Talent.IncarnationChosenofElune] and ConRO:BurstMode(_CelestialAlignment));
	ConRO:AbilityBurst(_Starfall, _Starfall_RDY and not _Starfall_BUFF and (_enemies_in_range >= 3 or (_enemies_in_range >= 2 and (not tChosen[ids.Bal_Talent.Starlord] or (tChosen[ids.Bal_Talent.Starlord] and tChosen[ids.Bal_Talent.StellarDrift])))));
	ConRO:AbilityBurst(_IncarnationChosenofElune, _IncarnationChosenofElune_RDY and _Moonfire_DEBUFF and _Sunfire_DEBUFF and (not tChosen[ids.Bal_Talent.StellarFlare] or (tChosen[ids.Bal_Talent.StellarFlare] and _StellarFlare_DEBUFF)) and (_EclipseSolar_BUFF or _EclipseLunar_BUFF) and ConRO:BurstMode(_IncarnationChosenofElune));
	ConRO:AbilityBurst(_FuryofElune, _FuryofElune_RDY and _LunarPower <= 60 and (((_CelestialAlignment_BUFF or _CelestialAlignment_CD >= 50) and not tChosen[ids.Bal_Talent.IncarnationChosenofElune]) or ((_IncarnationChosenofElune_BUFF or _IncarnationChosenofElune_CD >= 40) and tChosen[ids.Bal_Talent.IncarnationChosenofElune])) and ConRO:BurstMode(_FuryofElune));
	ConRO:AbilityBurst(_ForceofNature, _ForceofNature_RDY and _LunarPower <= 80 and ConRO:BurstMode(_ForceofNature));
	ConRO:AbilityBurst(_WarriorofElune, _WarriorofElune_RDY and not _WarriorofElune_BUFF and ConRO:BurstMode(_WarriorofElune));

	ConRO:AbilityBurst(_KindredSpirits, _KindredSpirits_RDY and _KindredSpirits_BUFF and ConRO:BurstMode(_KindredSpirits));
	ConRO:AbilityBurst(_ConvoketheSpirits, _ConvoketheSpirits_RDY and (_EclipseSolar_BUFF or _EclipseLunar_BUFF) and ConRO:BurstMode(_ConvoketheSpirits));
	ConRO:AbilityBurst(_RavenousFrenzy, _RavenousFrenzy_RDY and (_EclipseSolar_BUFF or _EclipseLunar_BUFF) and ConRO:BurstMode(_RavenousFrenzy));
	
--Rotations	
	if select(8, UnitChannelInfo("player")) == _ConvoketheSpirits then -- Do not break cast
		return _ConvoketheSpirits;
	end
	
	if _MoonkinForm_RDY and not _MoonkinForm_FORM then
		return _MoonkinForm;
	end

	if _KindredSpirits_RDY and not _LoneSpirit_BUFF and not _KindredSpirits_BUFF then
		return _KindredSpirits;
	end

	if not _in_combat then
		if _No_Eclipse then
			if _Wrath_Count >= 1 and _Starfire_Count >= 1 then
				if _Wrath_RDY then
					return _Wrath;
				end
			elseif _Wrath_Count >= 1 and _Starfire_Count <= 0 then
				if _Wrath_RDY then
					return _Wrath;
				end
			elseif _Starfire_Count >= 1 and _Wrath_Count <= 0 then
				if _Starfire_RDY then
					return _Starfire;
				end
			end
		end
		
		if _Wrath_RDY and _EclipseSolar_BUFF then
			return _Wrath;
		end
		
		if _Starfire_RDY and _EclipseLunar_BUFF then
			return _Starfire;
		end
	else
		if _Starsurge_RDY and _LunarPower >= 30 and (((_EclipseLunar_BUFF or _EclipseSolar_BUFF) and tChosen[ids.Bal_Talent.Starlord] and _Starlord_BUFF and _Starlord_COUNT < 3) or (_ConvoketheSpirits_RDY and (_EclipseLunar_BUFF and _EclipseLunar_DUR >= 13) or (_EclipseSolar_BUFF and _EclipseSolar_DUR >= 13))) then
			return _Starsurge;
		end

		if (tChosen[ids.Bal_Talent.IncarnationChosenofElune] and (not _IncarnationChosenofElune_RDY or ConRO:BurstMode(_IncarnationChosenofElune))) or (not tChosen[ids.Bal_Talent.IncarnationChosenofElune] and (not _CelestialAlignment_RDY or ConRO:BurstMode(_CelestialAlignment))) then
			if _Starfall_RDY and not _Starfall_BUFF and _LunarPower >= 50 and ConRO_AoEButton:IsVisible() then
				return _Starfall;
			end
		end

		if _Moonfire_RDY and ((not _Moonfire_DEBUFF) or (_Moonfire_DUR <= 13 and ((_EclipseLunar_BUFF and _EclipseLunar_DUR <= 4) or (_EclipseSolar_BUFF and _EclipseSolar_DUR <= 4) or not _movability))) then
			return _Moonfire;
		elseif _StellarFlare_RDY and _movability and ((not _StellarFlare_DEBUFF) or (_StellarFlare_DUR <= 13 and ((_EclipseLunar_BUFF and _EclipseLunar_DUR <= 4) or (_EclipseSolar_BUFF and _EclipseSolar_DUR <= 4)))) and currentSpell ~= _StellarFlare then
			return _StellarFlare;
		elseif _Sunfire_RDY and ((not _Sunfire_DEBUFF) or (_Sunfire_DUR <= 13 and ((_EclipseLunar_BUFF and _EclipseLunar_DUR <= 4) or (_EclipseSolar_BUFF and _EclipseSolar_DUR <= 4) or not _movability))) then
			return _Sunfire;
		end
		
		if _AdaptiveSwarm_RDY and not _AdaptiveSwarm_DEBUFF then
			return _AdaptiveSwarm;
		end		

		if _No_Eclipse then
			if _Wrath_Count >= 1 and _Starfire_Count >= 1 then
				if ConRO_AoEButton:IsVisible() then
					if _Wrath_RDY and _movability then
						return _Wrath;
					end
				else
					if _Starfire_RDY and (_movability or _WarriorofElune_BUFF) then
						return _Starfire;
					end
				end
			elseif _Wrath_Count >= 1 then
				if _Wrath_RDY and _movability then
					return _Wrath;
				end
			elseif _Starfire_Count >= 1 then
				if _Starfire_RDY and (_movability or _WarriorofElune_BUFF) then
					return _Starfire;
				end
			end
		end
		
		if tChosen[ids.Bal_Talent.IncarnationChosenofElune] then
			if _IncarnationChosenofElune_RDY and not _IncarnationChosenofElune_BUFF and (_LunarPower >= 90 or _ConvoketheSpirits_RDY) and ConRO:FullMode(_IncarnationChosenofElune) then
				return _IncarnationChosenofElune;
			end
		else
			if _CelestialAlignment_RDY and not _CelestialAlignment_BUFF and (_LunarPower >= 90 or _ConvoketheSpirits_RDY) and ConRO:FullMode(_CelestialAlignment) then
				return _CelestialAlignment;
			end
		end

		if not _No_Eclipse and (tChosen[ids.Bal_Talent.IncarnationChosenofElune] and (not _IncarnationChosenofElune_RDY or ConRO:BurstMode(_IncarnationChosenofElune))) or (not tChosen[ids.Bal_Talent.IncarnationChosenofElune] and (not _CelestialAlignment_RDY or ConRO:BurstMode(_CelestialAlignment))) then
			if _Starsurge_RDY and (_EclipseLunar_DUR >= 8 or _EclipseSolar_DUR >= 8) and (not tChosen[ids.Bal_Talent.Starlord] or (tChosen[ids.Bal_Talent.Starlord] and not _Starlord_BUFF)) then
				if ConRO_SingleButton:IsVisible() then
					return _Starsurge;
				elseif ConRO_AoEButton:IsVisible() and (_Starfall_DUR >= 3 or _LunarPower >= 90) then
					return _Starsurge;
				end
			end		
		end

		if _ConvoketheSpirits_RDY and _movability and (((_CelestialAlignment_BUFF or _CelestialAlignment_CD >= 10) and not tChosen[ids.Bal_Talent.IncarnationChosenofElune]) or ((_IncarnationChosenofElune_BUFF or _IncarnationChosenofElune_CD >= 10) and tChosen[ids.Bal_Talent.IncarnationChosenofElune])) and ConRO:FullMode(_ConvoketheSpirits) then
			return _ConvoketheSpirits;
		end			

		if _KindredSpirits_RDY and _KindredSpirits_BUFF and ConRO:FullMode(_KindredSpirits) then
			return _KindredSpirits;
		end
		
		if _RavenousFrenzy_RDY and ConRO:FullMode(_RavenousFrenzy) then
			return _RavenousFrenzy;
		end		

		if _FuryofElune_RDY and _LunarPower <= 60 and (((_CelestialAlignment_BUFF or _CelestialAlignment_CD >= 50) and not tChosen[ids.Bal_Talent.IncarnationChosenofElune]) or ((_IncarnationChosenofElune_BUFF or _IncarnationChosenofElune_CD >= 40) and tChosen[ids.Bal_Talent.IncarnationChosenofElune])) and ConRO:FullMode(_FuryofElune) then
			return _FuryofElune;
		end		
		
		if _ForceofNature_RDY and _LunarPower <= 80 and ConRO:FullMode(_ForceofNature) then
			return _ForceofNature;
		end
		
		if _WarriorofElune_RDY and not _WarriorofElune_BUFF and ConRO:FullMode(_WarriorofElune) then
			return _WarriorofElune;
		end

		if _NewMoon_RDY and _movability and _NewMoon_CHARGES >= 1 and (_EclipseLunar_BUFF or _EclipseSolar_BUFF) then
			return _NewMoon;
		end

		if _EclipseSolar_BUFF and _EclipseLunar_BUFF then
			if ConRO_AoEButton:IsVisible() then
				if _Starfire_RDY and (_movability or _WarriorofElune_BUFF) then
					return _Starfire;
				end
			else
				if _Wrath_RDY and _movability then
					return _Wrath;
				end
			end
		end
		
		if _Wrath_RDY and _movability and _EclipseSolar_BUFF then
			return _Wrath;
		end
		
		if _Starfire_RDY and (_movability or _WarriorofElune_BUFF) and _EclipseLunar_BUFF then
			return _Starfire;
		end
	end
end

function ConRO.Druid.BalanceDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _LunarPower, _LunarPower_Max																	= ConRO:PlayerPower('LunarPower');
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	
--Racials
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	
--Abilities	
	local _Barkskin, _Barkskin_RDY 																		= ConRO:AbilityReady(ids.Bal_Ability.Barkskin, timeShift);
	
	local _Renewal, _Renewal_RDY 																		= ConRO:AbilityReady(ids.Bal_Talent.Renewal, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end
	
	if _Renewal_RDY and _Player_Percent_Health <= 60 then
		return _Renewal;
	end

	if _Barkskin_RDY then
		return _Barkskin;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end	
return nil;
end

function ConRO.Druid.Feral(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Combo, _Combo_Max																			= ConRO:PlayerPower('Combo');
	local _Energy, _Energy_Max																			= ConRO:PlayerPower('Energy');
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	
--Racials
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	
--Abilities	
	local _Berserk, _Berserk_RDY																		= ConRO:AbilityReady(ids.Feral_Ability.Berserk, timeShift);
		local _Berserk_BUFF																					= ConRO:Aura(ids.Feral_Buff.Berserk, timeShift);
	local _CatForm, _CatForm_RDY 																		= ConRO:AbilityReady(ids.Feral_Ability.CatForm, timeShift);
		local _BearForm_FORM																				= ConRO:Form(ids.Feral_Form.BearForm);
		local _CatForm_FORM																					= ConRO:Form(ids.Feral_Form.CatForm);
	local _FerociousBite, _FerociousBite_RDY															= ConRO:AbilityReady(ids.Feral_Ability.FerociousBite, timeShift);
	local _Maim, _Maim_RDY																				= ConRO:AbilityReady(ids.Feral_Ability.Maim, timeShift);
	local _Mangle, _Mangle_RDY																			= ConRO:AbilityReady(ids.Feral_Ability.Mangle, timeShift);
	local _Moonfire, _Moonfire_RDY																		= ConRO:AbilityReady(ids.Feral_Ability.Moonfire, timeShift);
	local _Moonfire_Cat, _, _Moonfire_Cat_CD															= ConRO:AbilityReady(ids.Feral_Talent.Moonfire_Cat, timeShift);
		local _Moonfire_DEBUFF																				= ConRO:TargetAura(ids.Feral_Debuff.Moonfire, timeShift + 4);
	local _Prowl, _Prowl_RDY 																			= ConRO:AbilityReady(ids.Feral_Ability.Prowl, timeShift);
		local _Prowl_FORM 																					= ConRO:Form(ids.Feral_Form.Prowl);
	local _Rake, _Rake_RDY																				= ConRO:AbilityReady(ids.Feral_Ability.Rake, timeShift);
		local _Rake_DEBUFF 																					= ConRO:TargetAura(ids.Feral_Debuff.Rake, timeShift + 4);
		local _RakeStun_DEBUFF 																				= ConRO:TargetAura(ids.Feral_Debuff.RakeStun, timeShift);
	local _Regrowth, _Regrowth_RDY 																		= ConRO:AbilityReady(ids.Feral_Ability.Regrowth, timeShift);
		local _PredatorySwiftness_BUFF																		= ConRO:Aura(ids.Feral_Buff.PredatorySwiftness, timeShift);
	local _Rip, _Rip_RDY																				= ConRO:AbilityReady(ids.Feral_Ability.Rip, timeShift);
		local _Rip_DEBUFF, _, _Rip_DUR 																		= ConRO:TargetAura(ids.Feral_Debuff.Rip, timeShift);
	local _Shred, _Shred_RDY																			= ConRO:AbilityReady(ids.Feral_Ability.Shred, timeShift);
		local _Clearcasting_BUFF 																			= ConRO:Aura(ids.Feral_Buff.Clearcasting, timeShift);
		local _Bloodtalons_BUFF 																			= ConRO:Aura(ids.Feral_Buff.Bloodtalons, timeShift);		
	local _SkullBash, _SkullBash_RDY 																	= ConRO:AbilityReady(ids.Feral_Ability.SkullBash, timeShift);
	local _Soothe, _Soothe_RDY																			= ConRO:AbilityReady(ids.Feral_Ability.Soothe, timeShift); 
	local _Swipe, _Swipe_RDY																			= ConRO:AbilityReady(ids.Feral_Ability.Swipe, timeShift);
		local _Swipe_Bear, _, _Swipe_Bear_CD																= ConRO:AbilityReady(ids.Feral_Ability.Swipe_Bear, timeShift);
		local _Swipe_Cat, _, _Swipe_Cat_CD																	= ConRO:AbilityReady(ids.Feral_Ability.Swipe_Cat, timeShift);		
	local _Thrash, _Thrash_RDY																			= ConRO:AbilityReady(ids.Feral_Ability.Thrash, timeShift);
		local _Thrash_Cat, _, _Thrash_Cat_CD 																= ConRO:AbilityReady(ids.Feral_Ability.Thrash_Cat, timeShift);	
		local _Thrash_Cat_DEBUFF, _, _Thrash_Cat_DUR 														= ConRO:TargetAura(ids.Feral_Debuff.Thrash_Cat, timeShift + 2);
		local _Thrash_Bear, _, _Thrash_Bear_CD 																= ConRO:AbilityReady(ids.Feral_Ability.Thrash_Bear, timeShift);
		local _Thrash_Bear_DEBUFF, _Thrash_Bear_COUNT 														= ConRO:TargetAura(ids.Feral_Debuff.Thrash_Bear, timeShift);
	local _TigersFury, _TigersFury_RDY 																	= ConRO:AbilityReady(ids.Feral_Ability.TigersFury, timeShift + 0.5);
		local _TigersFury_BUFF																				= ConRO:Aura(ids.Feral_Buff.TigersFury, timeShift);
		
	local _BrutalSlash, _BrutalSlash_RDY																= ConRO:AbilityReady(ids.Feral_Talent.BrutalSlash, timeShift);
		local _BrutalSlash_CHARGES, _BrutalSlash_MaxCHARGES, _BrutalSlash_CCD								= ConRO:SpellCharges(ids.Feral_Talent.BrutalSlash);
	local _FeralFrenzy, _FeralFrenzy_RDY			 													= ConRO:AbilityReady(ids.Feral_Talent.FeralFrenzy, timeShift);
	local _IncarnationKingoftheJungle, _IncarnationKingoftheJungle_RDY									= ConRO:AbilityReady(ids.Feral_Talent.IncarnationKingoftheJungle, timeShift);
		local _IncarnationKingoftheJungle_BUFF 																= ConRO:Aura(ids.Feral_Buff.IncarnationKingoftheJungle, timeShift);
	local _PrimalWrath, _PrimalWrath_RDY 																= ConRO:AbilityReady(ids.Feral_Talent.PrimalWrath, timeShift);
	local _SavageRoar, _SavageRoar_RDY				 													= ConRO:AbilityReady(ids.Feral_Talent.SavageRoar, timeShift);
		local _SavageRoar_BUFF, _, _SavageRoar_DUR															= ConRO:Aura(ids.Feral_Buff.SavageRoar, timeShift);
	local _WildCharge, _WildCharge_RDY 																	= ConRO:AbilityReady(ids.Feral_Talent.WildCharge, timeShift);
		local _, _WildCharge_RANGE																			= ConRO:Targets(ids.Feral_Talent.WildCharge)	
		local _WildCharge_Bear																			= ConRO:AbilityReady(ids.Feral_Talent.WildCharge_Bear, timeShift);
		local _WildCharge_Cat 																			= ConRO:AbilityReady(ids.Feral_Talent.WildCharge_Cat, timeShift);
	
	
	local _AdaptiveSwarm, _AdaptiveSwarm_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.AdaptiveSwarm, timeShift);
		local _AdaptiveSwarm_DEBUFF																			= ConRO:TargetAura(ids.Covenant_Debuff.AdaptiveSwarm, timeShift);
	local _ConvoketheSpirits, _ConvoketheSpirits_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.ConvoketheSpirits, timeShift);
	local _KindredSpirits, _KindredSpirits_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.KindredSpirits, timeShift);
		local _EmpowerBondDamage, _, _EmpowerBondDamage_CD													= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondDamage, timeShift);
		local _EmpowerBondTank, _, _EmpowerBondTank_CD														= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondTank, timeShift);
		local _EmpowerBondHealer, _, _EmpowerBondHealer_CD													= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondHealer, timeShift);
		local _KindredEmpowerment_BUFF																		= ConRO:Aura(ids.Covenant_Buff.KindredEmpowerment, timeShift);
		local _KindredSpirits_BUFF																			= ConRO:Aura(ids.Covenant_Buff.KindredSpirits, timeShift);
		local _LoneEmpowerment, _, _LoneEmpowerment_CD														= ConRO:AbilityReady(ids.Covenant_Ability.LoneEmpowerment, timeShift);
		local _LoneEmpowerment_BUFF																			= ConRO:Aura(ids.Covenant_Buff.LoneEmpowerment, timeShift);
		local _LoneSpirit_BUFF																				= ConRO:Aura(ids.Covenant_Buff.LoneSpirit, timeShift);
	local _RavenousFrenzy, _RavenousFrenzy_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.RavenousFrenzy, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

		if _KindredSpirits_BUFF then
			if ConRO:FindCurrentSpell(_EmpowerBondDamage) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondDamage_CD <= 0;
				_KindredSpirits = _EmpowerBondDamage;
			elseif ConRO:FindCurrentSpell(_EmpowerBondTank) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondTank_CD <= 0;
				_KindredSpirits = _EmpowerBondTank;
			elseif ConRO:FindCurrentSpell(_EmpowerBondHealer) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondHealer_CD <= 0;
				_KindredSpirits = _EmpowerBondHealer;
			end
		end

		if _LoneSpirit_BUFF then
			_KindredSpirits_BUFF = _LoneSpirit_BUFF;
			_KindredSpirits_RDY = _KindredSpirits_RDY and _LoneEmpowerment_CD <= 0;
			_KindredSpirits = _LoneEmpowerment;
		end
		
		if _BearForm_FORM then
			_WildCharge = _WildCharge_Bear;
			_Thrash_RDY = _Thrash_RDY and _Thrash_Bear_CD <= 0;
			_Thrash = _Thrash_Bear;
			_Swipe_RDY = _Swipe_RDY and _Swipe_Bear_CD <= 0;
			_Swipe = _Swipe_Bear;
		end
		
		if _CatForm_FORM then
			_WildCharge = _WildCharge_Cat;
			_Thrash_RDY = _Thrash_RDY and _Thrash_Cat_CD <= 0;
			_Thrash = _Thrash_Cat;
			_Swipe_RDY = _Swipe_RDY and _Swipe_Cat_CD <= 0;
			_Swipe = _Swipe_Cat;
		end

		if tChosen[ids.Feral_Talent.LunarInspiration] then
			_Moonfire_RDY = _Moonfire_RDY and _Moonfire_Cat_CD <= 0;
			_Moonfire = _Moonfire_Cat;
		end	
		
--Indicators		
	ConRO:AbilityInterrupt(_SkullBash, _SkullBash_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Soothe, _Soothe_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_WildCharge, _WildCharge_RDY and _WildCharge_RANGE);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_Berserk, _Berserk_RDY and not tChosen[ids.Feral_Talent.IncarnationKingoftheJungle] and ConRO:BurstMode(_Berserk));
	ConRO:AbilityBurst(_IncarnationKingoftheJungle, _IncarnationKingoftheJungle_RDY and ConRO:BurstMode(_IncarnationKingoftheJungle));
	ConRO:AbilityBurst(_FeralFrenzy, _FeralFrenzy_RDY and _Combo <= 0 and ConRO:BurstMode(_FeralFrenzy));
		
	ConRO:AbilityBurst(_KindredSpirits, _KindredSpirits_RDY and _KindredSpirits_BUFF and ConRO:BurstMode(_KindredSpirits));
	ConRO:AbilityBurst(_ConvoketheSpirits, _ConvoketheSpirits_RDY and _Combo <= 2 and _Energy <= 30 and ConRO:BurstMode(_ConvoketheSpirits));
	ConRO:AbilityBurst(_RavenousFrenzy, _RavenousFrenzy_RDY and (_Berserk_BUFF or _IncarnationKingoftheJungle_BUFF) and ConRO:BurstMode(_RavenousFrenzy));
	
--Rotations	
	if _KindredSpirits_RDY and not _LoneSpirit_BUFF and not _KindredSpirits_BUFF then
		return _KindredSpirits;
	end

	if _BearForm_FORM then
		if _Thrash_RDY and _Thrash_Bear_COUNT < 3 then
			return _Thrash;
		end

		if _Mangle_RDY then
			return _Mangle;
		end
		
		if _Swipe_RDY then
			return _Swipe_Bear;
		end
	return nil;
	end

	if _CatForm_RDY and not _CatForm_FORM then
		return _CatForm;
	end
		
	if not _in_combat then 
		if _Prowl_RDY and not _Prowl_FORM then
			return _Prowl;
		end
		
		if _Rake_RDY and not _Rake_DEBUFF then
			return _Rake;
		end		
	
	elseif (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 4) or ConRO_AoEButton:IsVisible() then
		if _RavenousFrenzy_RDY and (_Berserk_BUFF or _IncarnationKingoftheJungle_BUFF) and ConRO:FullMode(_RavenousFrenzy) then
			return _RavenousFrenzy;
		end	
		
		if _TigersFury_RDY and not _TigersFury_BUFF and _Energy <= _Energy_Max - 50 then
			return _TigersFury;
		end

		if _KindredSpirits_RDY and _KindredSpirits_BUFF and _TigersFury_BUFF and ConRO:FullMode(_KindredSpirits) then
			return _KindredSpirits;
		end
		
		if _FeralFrenzy_RDY and _Combo <= 0 and ConRO:FullMode(_FeralFrenzy) then
			return _FeralFrenzy;
		end
		
		if _Berserk_RDY and not tChosen[ids.Feral_Talent.IncarnationKingoftheJungle] and ConRO:FullMode(_Berserk) then
			return _Berserk;
		end

		if _IncarnationKingoftheJungle_RDY and ConRO:FullMode(_IncarnationKingoftheJungle) then
			return _IncarnationKingoftheJungle;
		end

		if _ConvoketheSpirits_RDY and _Combo <= 2 and _Energy <= 30 and ConRO:FullMode(_ConvoketheSpirits) then
			return _ConvoketheSpirits;
		end	
		
		if _BrutalSlash_RDY and (_BrutalSlash_CHARGES == _BrutalSlash_MaxCHARGES or (_BrutalSlash_CHARGES == _BrutalSlash_MaxCHARGES - 1 and _BrutalSlash_CCD <= 1.5)) then
			return _BrutalSlash;
		end
		
		if _PrimalWrath_RDY and _Combo == 5 and (not _Rip_DEBUFF or _Rip_DUR <= 4) then
			return _PrimalWrath;
		end

		if _Thrash_RDY and not _Thrash_Cat_DEBUFF then
			return _Thrash;
		end
		
		if _Rake_RDY and not _Rake_DEBUFF then
			return _Rake;
		end
		
		if _SavageRoar_RDY and (not _SavageRoar_BUFF or _SavageRoar_DUR <= 10) and _Combo == 5 then
			return _SavageRoar;
		end
		
		if _Rip_RDY and not _Rip_DEBUFF and _Combo == 5 then
			return _Rip;
		end

		if _AdaptiveSwarm_RDY and not _AdaptiveSwarm_DEBUFF and _Rake_DEBUFF and _Thrash_Cat_DEBUFF then
			return _AdaptiveSwarm;
		end	
		
		if _FerociousBite_RDY and _Combo >= 5 and _Rip_DEBUFF then
			return _FerociousBite;
		end
			
		if _BrutalSlash_RDY and _Thrash_Cat_DEBUFF and _BrutalSlash_CHARGES >= 1 and _Combo <= 4 then
			return _BrutalSlash;
		end

		if _Swipe_RDY and _Rake_DEBUFF and not tChosen[ids.Feral_Talent.BrutalSlash] and _Combo <= 4 then
			return _Swipe;
		end
	else
		if _RavenousFrenzy_RDY and (_Berserk_BUFF or _IncarnationKingoftheJungle_BUFF) and ConRO:FullMode(_RavenousFrenzy) then
			return _RavenousFrenzy;
		end	
		
		if _FeralFrenzy_RDY and _Combo <= 0 and ConRO:FullMode(_FeralFrenzy) then
			return _FeralFrenzy;
		end
		
		if _TigersFury_RDY and not _TigersFury_BUFF and _Energy <= _Energy_Max - 50 then
			return _TigersFury;
		end

		if _KindredSpirits_RDY and _KindredSpirits_BUFF and _TigersFury_BUFF and ConRO:FullMode(_KindredSpirits) then
			return _KindredSpirits;
		end
		
		if _Berserk_RDY and not tChosen[ids.Feral_Talent.IncarnationKingoftheJungle] and ConRO:FullMode(_Berserk) then
			return _Berserk;
		end

		if _IncarnationKingoftheJungle_RDY and ConRO:FullMode(_IncarnationKingoftheJungle) then
			return _IncarnationKingoftheJungle;
		end

		if _ConvoketheSpirits_RDY and _Combo <= 2 and _Energy <= 30 and ConRO:FullMode(_ConvoketheSpirits) then
			return _ConvoketheSpirits;
		end
		
		if _PrimalWrath_RDY and _Combo == 5 and _enemies_in_melee >= 3 then
			return _PrimalWrath;
		end		

		if _BrutalSlash_RDY and (_BrutalSlash_CHARGES == _BrutalSlash_MaxCHARGES or (_BrutalSlash_CHARGES == _BrutalSlash_MaxCHARGES - 1 and _BrutalSlash_CCD <= 1.5)) and _enemies_in_melee >= 2 then
			return _BrutalSlash;
		end	

		if _Rip_RDY and not _Rip_DEBUFF and _Combo >= 5 then
			return _Rip;
		end

		if tChosen[ids.Feral_Talent.Sabertooth] then
			if _FerociousBite_RDY and _Rip_DUR <= 9 and _Combo >= 5 then
				return _FerociousBite;
			end
		else
			if _Rip_RDY and _Rip_DUR <= 7 and _Combo >= 5 then
				return _Rip;
			end
		end
		
		if _Rake_RDY and not _Rake_DEBUFF then
			return _Rake;
		end		

		if _Thrash_RDY and _Thrash_Cat_DUR <= 10 and not _Bloodtalons_BUFF and tChosen[ids.Feral_Talent.Bloodtalons] and not tChosen[ids.Feral_Talent.BrutalSlash] and not tChosen[ids.Feral_Talent.LunarInspiration] and ConRO.lastSpellId ~= _Thrash then
			return _Thrash;
		end
		
		if _SavageRoar_RDY and (not _SavageRoar_BUFF or _SavageRoar_DUR <= 9) and _Combo >= 5 then
			return _SavageRoar;
		end		

		if _AdaptiveSwarm_RDY and not _AdaptiveSwarm_DEBUFF and _Rake_DEBUFF and _Rip_DEBUFF then
			return _AdaptiveSwarm;
		end	
		
		if _FerociousBite_RDY and _Combo >= 5 and (not IsPlayerSpell(ids.Feral_Ability.Rip) or (IsPlayerSpell(ids.Feral_Ability.Rip) and _Rip_DUR >= 10)) and (not tChosen[ids.Feral_Talent.SavageRoar] or (tChosen[ids.Feral_Talent.SavageRoar] and _SavageRoar_DUR >= 10)) then
			return _FerociousBite;
		end		

		if _Moonfire_RDY and not _Moonfire_DEBUFF and tChosen[ids.Feral_Talent.LunarInspiration] then
			return _Moonfire;
		end
		
		if _Thrash_RDY and not _Thrash_Cat_DEBUFF and _enemies_in_melee >= 2 then
			return _Thrash;
		end
		
		if _Swipe_RDY and _Rake_DEBUFF and not tChosen[ids.Feral_Talent.BrutalSlash] and _Combo <= 4 and _enemies_in_melee >= 3 then
			return _Swipe_Cat;
		end
		
		if _BrutalSlash_RDY and _Combo <= 4 and ((ConRO_AutoButton:IsVisible() and not _Clearcasting_BUFF) or ConRO_AoEButton:IsVisible()) then
			return _BrutalSlash;
		end

		if _Shred_RDY and _Combo <= 4 then
			return _Shred;
		end
	end
return nil;
end

function ConRO.Druid.FeralDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Combo, _Combo_Max																			= ConRO:PlayerPower('Combo');
	local _Energy, _Energy_Max																			= ConRO:PlayerPower('Energy');
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	
--Racials
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	
--Abilities
	local _SurvivalInstincts, _SurvivalInstincts_RDY 													= ConRO:AbilityReady(ids.Feral_Ability.SurvivalInstincts, timeShift);
	local _Barkskin, _Barkskin_RDY																		= ConRO:AbilityReady(ids.Feral_Ability.Barkskin, timeShift);
	
	local _Renewal, _Renewal_RDY 																		= ConRO:AbilityReady(ids.Feral_Talent.Renewal, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end
	
	if _Renewal_RDY and _Player_Percent_Health <= 60 then
		return _Renewal;
	end

	if _Barkskin_RDY then
		return _Barkskin;
	end
	
	if _SurvivalInstincts_RDY then
		return _SurvivalInstincts;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Druid.Guardian(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	local _Rage, _Rage_Max																				= ConRO:PlayerPower('Rage');
	
--Racials
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	
--Abilities	
	local _BearForm, _BearForm_RDY 																		= ConRO:AbilityReady(ids.Guard_Ability.BearForm, timeShift);
		local _BearForm_FORM 																				= ConRO:Form(ids.Guard_Form.BearForm);
	local _Growl, _Growl_RDY 																			= ConRO:AbilityReady(ids.Guard_Ability.Growl, timeShift);		
	local _Mangle, _Mangle_RDY 																			= ConRO:AbilityReady(ids.Guard_Ability.Mangle, timeShift);
	local _Maul, _Maul_RDY																				= ConRO:AbilityReady(ids.Guard_Ability.Maul, timeShift);
	local _Moonfire, _Moonfire_RDY 																		= ConRO:AbilityReady(ids.Guard_Ability.Moonfire, timeShift);
		local _GalacticGuardian_BUFF 																		= ConRO:Aura(ids.Guard_Buff.GalacticGuardian, timeShift);
		local _Moonfire_DEBUFF 																				= ConRO:TargetAura(ids.Guard_Debuff.Moonfire, timeShift);
	local _SkullBash, _SkullBash_RDY						 											= ConRO:AbilityReady(ids.Guard_Ability.SkullBash, timeShift);
	local _Soothe, _Soothe_RDY																			= ConRO:AbilityReady(ids.Guard_Ability.Soothe, timeShift); 
	local _Swipe, _Swipe_RDY 																			= ConRO:AbilityReady(ids.Guard_Ability.Swipe, timeShift);
		local _Swipe_Bear, _, _Swipe_Bear_CD																= ConRO:AbilityReady(ids.Guard_Ability.Swipe_Bear, timeShift);
		local _Swipe_Cat, _, _Swipe_Cat_CD																	= ConRO:AbilityReady(ids.Guard_Ability.Swipe_Cat, timeShift);	
	local _Thrash, _Thrash_RDY 																			= ConRO:AbilityReady(ids.Guard_Ability.Thrash, timeShift);
		local _Thrash_Cat, _, _Thrash_Cat_CD 																= ConRO:AbilityReady(ids.Guard_Ability.Thrash_Cat, timeShift);	
		local _Thrash_Cat_DEBUFF, _, _Thrash_Cat_DUR 														= ConRO:TargetAura(ids.Guard_Debuff.Thrash_Cat, timeShift + 2);
		local _Thrash_Bear, _, _Thrash_Bear_CD 																= ConRO:AbilityReady(ids.Guard_Ability.Thrash_Bear, timeShift);
		local _Thrash_DEBUFF, _Thrash_COUNT 																= ConRO:TargetAura(ids.Guard_Debuff.Thrash, timeShift);

	local _Pulverize, _Pulverize_RDY 																	= ConRO:AbilityReady(ids.Guard_Talent.Pulverize, timeShift);
		local _Pulverize_BUFF 																				= ConRO:Aura(ids.Guard_Buff.Pulverize, timeShift + 3);		
	local _WildCharge, _WildCharge_RDY 																	= ConRO:AbilityReady(ids.Guard_Talent.WildCharge, timeShift);
		local _, _WildCharge_RANGE																			= ConRO:Targets(ids.Guard_Talent.WildCharge)
		local _WildCharge_Bear																			= ConRO:AbilityReady(ids.Guard_Talent.WildCharge_Bear, timeShift);
		local _WildCharge_Cat 																			= ConRO:AbilityReady(ids.Guard_Talent.WildCharge_Cat, timeShift);

	local _AdaptiveSwarm, _AdaptiveSwarm_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.AdaptiveSwarm, timeShift);
		local _AdaptiveSwarm_DEBUFF																			= ConRO:TargetAura(ids.Covenant_Debuff.AdaptiveSwarm, timeShift);
	local _ConvoketheSpirits, _ConvoketheSpirits_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.ConvoketheSpirits, timeShift);
	local _RavenousFrenzy, _RavenousFrenzy_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.RavenousFrenzy, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

		if _BearForm_FORM then
			_WildCharge = _WildCharge_Bear;
			_Thrash_RDY = _Thrash_RDY and _Thrash_Bear_CD <= 0;
			_Thrash = _Thrash_Bear;
			_Swipe_RDY = _Swipe_RDY and _Swipe_Bear_CD <= 0;
			_Swipe = _Swipe_Bear;
		end

		if _CatForm_FORM then
			_WildCharge = _WildCharge_Cat;
			_Thrash_RDY = _Thrash_RDY and _Thrash_Cat_CD <= 0;
			_Thrash = _Thrash_Cat;
			_Swipe_RDY = _Swipe_RDY and _Swipe_Cat_CD <= 0;
			_Swipe = _Swipe_Cat;
		end
		
--Indicators	
	ConRO:AbilityInterrupt(_SkullBash, _SkullBash_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Soothe, _Soothe_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_WildCharge, _WildCharge_RDY and _WildCharge_RANGE);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityTaunt(_Growl, _Growl_RDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));

	ConRO:AbilityBurst(_ConvoketheSpirits, _ConvoketheSpirits_RDY and ConRO:BurstMode(_ConvoketheSpirits));
	ConRO:AbilityBurst(_RavenousFrenzy, _RavenousFrenzy_RDY and ConRO:BurstMode(_RavenousFrenzy));
	
--Rotations	
	if _BearForm_RDY and not _BearForm_FORM then
		return _BearForm;
	end
	
	if _Moonfire_RDY and not _Moonfire_DEBUFF and _enemies_in_melee <= 2 then
		return _Moonfire;
	end

	if _Thrash_RDY and (_Thrash_COUNT < 3 or _enemies_in_melee >= 2) then
		return _Thrash;
	end

	if _Pulverize_RDY and not _Pulverize_BUFF and _Thrash_COUNT >= 3 then
		return _Pulverize;
	end

	if _Mangle_RDY and _enemies_in_melee <= 4 then
		return _Mangle;
	end
	
	if _Thrash_RDY then
		return _Thrash;
	end
	
	if _Moonfire_RDY and _GalacticGuardian_BUFF and _enemies_in_melee <= 3  then
		return _Moonfire;
	end

	if _AdaptiveSwarm_RDY and not _AdaptiveSwarm_DEBUFF then
		return _AdaptiveSwarm;
	end	

	if _ConvoketheSpirits_RDY and ConRO:FullMode(_ConvoketheSpirits) then
		return _ConvoketheSpirits;
	end

	if _RavenousFrenzy_RDY and ConRO:FullMode(_RavenousFrenzy) then
		return _RavenousFrenzy;
	end

	if _Maul_RDY and not ConRO:TarYou() and _Rage >= 90 and _enemies_in_melee <= 3 then
		return _Maul;
	end	
	
	if _Swipe_RDY then
		return _Swipe;
	end
return nil;
end

function ConRO.Druid.GuardianDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	local _Rage, _Rage_Max																				= ConRO:PlayerPower('Rage');
	
--Racials
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);

--Abilities	
	local _SurvivalInstincts, _SurvivalInstincts_RDY 													= ConRO:AbilityReady(ids.Guard_Ability.SurvivalInstincts, timeShift);
		local _SurvivalInstincts_BUFF																		= ConRO:Aura(ids.Guard_Buff.SurvivalInstincts, timeShift);
	local _Barkskin, _Barkskin_RDY 																		= ConRO:AbilityReady(ids.Guard_Ability.Barkskin, timeShift);
		local _Barkskin_BUFF																				= ConRO:Aura(ids.Guard_Buff.Barkskin, timeShift);
	local _Ironfur, _Ironfur_RDY 																		= ConRO:AbilityReady(ids.Guard_Ability.Ironfur, timeShift);
		local _Ironfur_BUFF, _Ironfur_COUNT																	= ConRO:Aura(ids.Guard_Buff.Ironfur, timeShift);
	local _FrenziedRegeneration, _FrenziedRegeneration_RDY 												= ConRO:AbilityReady(ids.Guard_Ability.FrenziedRegeneration, timeShift);
	local _Berserk, _Berserk_RDY																		= ConRO:AbilityReady(ids.Guard_Ability.Berserk, timeShift);

	local _BristlingFur, _BristlingFur_RDY																= ConRO:AbilityReady(ids.Guard_Talent.BristlingFur, timeShift);
	local _IncarnationGuardianofUrsoc, _IncarnationGuardianofUrsoc_RDY									= ConRO:AbilityReady(ids.Guard_Talent.IncarnationGuardianofUrsoc, timeShift);
		local _IncarnationGuardianofUrsoc_BUFF																= ConRO:Aura(ids.Guard_Buff.IncarnationGuardianofUrsoc, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _KindredSpirits, _KindredSpirits_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.KindredSpirits, timeShift);
		local _EmpowerBondDamage, _, _EmpowerBondDamage_CD													= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondDamage, timeShift);
		local _EmpowerBondTank, _, _EmpowerBondTank_CD														= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondTank, timeShift);
		local _EmpowerBondHealer, _, _EmpowerBondHealer_CD													= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondHealer, timeShift);
		local _KindredEmpowerment_BUFF																		= ConRO:Aura(ids.Covenant_Buff.KindredEmpowerment, timeShift);
		local _KindredSpirits_BUFF																			= ConRO:Aura(ids.Covenant_Buff.KindredSpirits, timeShift);
		local _LoneProtection, _, _LoneProtection_CD														= ConRO:AbilityReady(ids.Covenant_Ability.LoneProtection, timeShift);
		local _LoneProtection_BUFF																			= ConRO:Aura(ids.Covenant_Buff.LoneEmpowerment, timeShift);
		local _LoneSpirit_BUFF																				= ConRO:Aura(ids.Covenant_Buff.LoneSpirit, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

		if _KindredSpirits_BUFF then
			if ConRO:FindCurrentSpell(_EmpowerBondDamage) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondDamage_CD <= 0;
				_KindredSpirits = _EmpowerBondDamage;
			elseif ConRO:FindCurrentSpell(_EmpowerBondTank) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondTank_CD <= 0;
				_KindredSpirits = _EmpowerBondTank;
			elseif ConRO:FindCurrentSpell(_EmpowerBondHealer) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondHealer_CD <= 0;
				_KindredSpirits = _EmpowerBondHealer;
			end
		end

		if _LoneSpirit_BUFF then
			_KindredSpirits_BUFF = _LoneSpirit_BUFF;
			_KindredSpirits_RDY = _KindredSpirits_RDY and _LoneProtection_CD <= 0;
			_KindredSpirits = _LoneProtection;
		end

--Rotations	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end

	if _KindredSpirits_RDY and not _LoneSpirit_BUFF and not _KindredSpirits_BUFF then
		return _KindredSpirits;
	end
	
	if _FrenziedRegeneration_RDY and _Player_Percent_Health <= 60 then
		return _FrenziedRegeneration;
	end

	if _BristlingFur_RDY and ConRO:TarYou() then
		return _BristlingFur;
	end
	
	if _Ironfur_RDY and ConRO:TarYou() and _Ironfur_COUNT < 4 then
		return _Ironfur;
	end

	if _KindredSpirits_RDY and _KindredSpirits_BUFF then
		return _KindredSpirits;
	end
	
	if tChosen[ids.Guard_Talent.IncarnationGuardianofUrsoc] then
		if _IncarnationGuardianofUrsoc_RDY and not _Barkskin_BUFF and not _SurvivalInstincts_BUFF then
			return _IncarnationGuardianofUrsoc;
		end
	else
		if _Berserk_RDY then
			return _Berserk;
		end
	end

	if _Barkskin_RDY and not _IncarnationGuardianofUrsoc_BUFF and not _SurvivalInstincts_BUFF then
		return _Barkskin;
	end
	
	if _SurvivalInstincts_RDY and not _Barkskin_BUFF and not _IncarnationGuardianofUrsoc_BUFF then
		return _SurvivalInstincts;
	end	

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Druid.Restoration(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	
--Racials
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	
--Abilities
	local _Soothe, _Soothe_RDY																			= ConRO:AbilityReady(ids.Resto_Ability.Soothe, timeShift); 
	local _Tranquility, _Tranquility_RDY 																= ConRO:AbilityReady(ids.Resto_Ability.Tranquility, timeShift);
	local _Lifebloom, _Lifebloom_RDY 																	= ConRO:AbilityReady(ids.Resto_Ability.Lifebloom, timeShift);
	local _Moonfire, _Moonfire_RDY 																		= ConRO:AbilityReady(ids.Resto_Ability.Moonfire, timeShift);
		local _Moonfire_DEBUFF																				= ConRO:TargetAura(ids.Resto_Debuff.Moonfire, timeShift + 2);
	local _Regrowth, _Regrowth_RDY 																		= ConRO:AbilityReady(ids.Resto_Ability.Regrowth, timeShift);
	local _Sunfire, _Sunfire_RDY 																		= ConRO:AbilityReady(ids.Resto_Ability.Sunfire, timeShift);
		local _Sunfire_DEBUFF																				= ConRO:TargetAura(ids.Resto_Debuff.Sunfire, timeShift + 2);
	local _Wrath, _Wrath_RDY 																			= ConRO:AbilityReady(ids.Resto_Ability.Wrath, timeShift);
		local _EclipseLunar_BUFF, _, _EclipseLunar_DUR														= ConRO:Aura(ids.Resto_Buff.EclipseLunar, timeShift);
		
	local _MoonkinForm, _MoonkinForm_RDY 																= ConRO:AbilityReady(ids.Resto_Talent.MoonkinForm, timeShift);
		local _MoonkinForm_FORM																				= ConRO:Form(ids.Resto_Form.MoonkinForm);	
	local _Starsurge, _Starsurge_RDY 																	= ConRO:AbilityReady(ids.Resto_Talent.Starsurge, timeShift);
	local _Starfire, _Starfire_RDY 																		= ConRO:AbilityReady(ids.Resto_Talent.Starfire, timeShift);
		local _EclipseSolar_BUFF, _, _EclipseSolar_DUR														= ConRO:Aura(ids.Resto_Buff.EclipseSolar, timeShift);
	local _Typhoon, _Typhoon_RDY 																		= ConRO:AbilityReady(ids.Resto_Talent.Typhoon, timeShift);
	
	local _AdaptiveSwarm, _AdaptiveSwarm_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.AdaptiveSwarm, timeShift);
		local _AdaptiveSwarm_DEBUFF																			= ConRO:TargetAura(ids.Covenant_Debuff.AdaptiveSwarm, timeShift);
	local _ConvoketheSpirits, _ConvoketheSpirits_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.ConvoketheSpirits, timeShift);
	local _KindredSpirits, _KindredSpirits_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.KindredSpirits, timeShift);
	local _KindredSpirits, _KindredSpirits_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.KindredSpirits, timeShift);
		local _EmpowerBondDamage, _, _EmpowerBondDamage_CD													= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondDamage, timeShift);
		local _EmpowerBondTank, _, _EmpowerBondTank_CD														= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondTank, timeShift);
		local _EmpowerBondHealer, _, _EmpowerBondHealer_CD													= ConRO:AbilityReady(ids.Covenant_Ability.EmpowerBondHealer, timeShift);
		local _KindredEmpowerment_BUFF																		= ConRO:Aura(ids.Covenant_Buff.KindredEmpowerment, timeShift);
		local _KindredSpirits_BUFF																			= ConRO:Aura(ids.Covenant_Buff.KindredSpirits, timeShift);
		local _LoneMeditation, _, _LoneMeditation_CD														= ConRO:AbilityReady(ids.Covenant_Ability.LoneMeditation, timeShift);
		local _LoneMeditation_BUFF																			= ConRO:Aura(ids.Covenant_Buff.LoneMeditation, timeShift);
		local _LoneSpirit_BUFF																				= ConRO:Aura(ids.Covenant_Buff.LoneSpirit, timeShift);
	local _RavenousFrenzy, _RavenousFrenzy_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.RavenousFrenzy, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

		if _KindredSpirits_BUFF then
			if ConRO:FindCurrentSpell(_EmpowerBondDamage) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondDamage_CD <= 0;
				_KindredSpirits = _EmpowerBondDamage;
			elseif ConRO:FindCurrentSpell(_EmpowerBondTank) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondTank_CD <= 0;
				_KindredSpirits = _EmpowerBondTank;
			elseif ConRO:FindCurrentSpell(_EmpowerBondHealer) then
				_KindredSpirits_RDY = _KindredSpirits_RDY and _EmpowerBondHealer_CD <= 0;
				_KindredSpirits = _EmpowerBondHealer;
			end
		end

		if _LoneSpirit_BUFF then
			_KindredSpirits_BUFF = _LoneSpirit_BUFF;
			_KindredSpirits_RDY = _KindredSpirits_RDY and _LoneMeditation_CD <= 0;
			_KindredSpirits = _LoneMeditation;
		end

		if _EclipseLunar_BUFF and _EclipseSolar_BUFF then
			last_eclipse_phase = "both";
		else
			if _EclipseLunar_BUFF and not _EclipseSolar_BUFF then
				last_eclipse_phase = "lunar";
			end
			if _EclipseSolar_BUFF and not _EclipseLunar_BUFF then
				last_eclipse_phase = "solar";
			end
		end
		
--Indicators	
	ConRO:AbilityPurge(_Soothe, _Soothe_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityBurst(_Tranquility, _Tranquility_RDY);

	ConRO:AbilityRaidBuffs(_Lifebloom, _Lifebloom_RDY and not ConRO:OneBuff(ids.Resto_Buff.Lifebloom));

	ConRO:AbilityBurst(_KindredSpirits, _KindredSpirits_RDY and _KindredSpirits_BUFF and _in_combat);
	ConRO:AbilityBurst(_ConvoketheSpirits, _ConvoketheSpirits_RDY and _in_combat);
	ConRO:AbilityBurst(_RavenousFrenzy, _RavenousFrenzy_RDY and _in_combat);
	
--Rotations
	if _KindredSpirits_RDY and not _LoneSpirit_BUFF and not _KindredSpirits_BUFF then
		return _KindredSpirits;
	end

	if _is_Enemy then
		if tChosen[ids.Resto_Talent.BalanceAffinity] then
			if _MoonkinForm_RDY and not _MoonkinForm_FORM then
				return _MoonkinForm
			end
			
			if _Moonfire_RDY and not _Moonfire_DEBUFF then
				return _Moonfire;
			elseif _Sunfire_RDY and not _Sunfire_DEBUFF then
				return _Sunfire;
			end
	
			if not _EclipseSolar_BUFF and not _EclipseLunar_BUFF then
				if last_eclipse_phase == "both" then
					if _Wrath_RDY then
						return _Wrath;
					end
				elseif last_eclipse_phase == "solar" then
					if _Wrath_RDY then
						return _Wrath;
					end
				elseif last_eclipse_phase == "lunar" then
					if _Starfire_RDY then
						return _Starfire;
					end
				end
			end
			
			if _Starsurge_RDY and ((_EclipseSolar_BUFF and _EclipseSolar_DUR >= 5) or (_EclipseLunar_BUFF and _EclipseLunar_DUR >= 5)) and currentSpell ~= _Starsurge then
				return _Starsurge;
			end
			
			if _Wrath_RDY and _EclipseSolar_BUFF then
				return _Wrath;
			end
			
			if _Starfire_RDY and _EclipseLunar_BUFF then
				return _Starfire;
			end
		end

		if tChosen[ids.Resto_Talent.FeralAffinity] then

		end

		if tChosen[ids.Resto_Talent.GuardianAffinity] then

		end
		
		if _Moonfire_RDY and not _Moonfire_DEBUFF then
			return _Moonfire;
		elseif _Sunfire_RDY and not _Sunfire_DEBUFF then
			return _Sunfire;
		end
		
		if _Wrath_RDY then
			return _Wrath;
		end
	end
return nil;
end

function ConRO.Druid.RestorationDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	
--Racials
	
--Abilities
	local _Barkskin, _Barkskin_RDY 																		= ConRO:AbilityReady(ids.Resto_Ability.Barkskin, timeShift);
	
	local _Renewal, _Renewal_RDY 																		= ConRO:AbilityReady(ids.Resto_Talent.Renewal, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

--Rotations	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end
	
	if _Renewal_RDY and _Player_Percent_Health <= 60 then
		return _Renewal;
	end

	if _Barkskin_RDY then
		return _Barkskin;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end		
return nil;
end
