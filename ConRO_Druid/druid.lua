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
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Druid_Ability, ids.Druid_Passive, ids.Druid_Form, ids.Druid_Buff, ids.Druid_Debuff, ids.Druid_PetAbility, ids.Druid_PvPTalent, ids.Glyph;
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
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(Racial.Berserking, timeShift);

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
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Druid_Ability, ids.Druid_Passive, ids.Druid_Form, ids.Druid_Buff, ids.Druid_Debuff, ids.Druid_PetAbility, ids.Druid_PvPTalent, ids.Glyph;
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
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(Racial.Berserking, timeShift);

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
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Bal_Ability, ids.Bal_Passive, ids.Bal_Form, ids.Bal_Buff, ids.Bal_Debuff, ids.Bal_PetAbility, ids.Bal_PvPTalent, ids.Glyph;
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
	local _AstralPower, _AstralPower_Max = ConRO:PlayerPower('LunarPower');
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');

--Racials
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);

--Abilities
	local _CelestialAlignment, _CelestialAlignment_RDY, _CelestialAlignment_CD = ConRO:AbilityReady(Ability.CelestialAlignment, timeShift);
	local _CelestialAlignmentOS, _CelestialAlignmentOS_RDY, _CelestialAlignmentOS_CD = ConRO:AbilityReady(Ability.CelestialAlignmentOS, timeShift);
		local _CelestialAlignment_BUFF = ConRO:Aura(Buff.CelestialAlignment, timeShift);
	local _ConvoketheSpirits, _ConvoketheSpirits_RDY = ConRO:AbilityReady(Ability.ConvoketheSpirits, timeShift);
	local _ForceofNature, _ForceofNature_RDY = ConRO:AbilityReady(Ability.ForceofNature, timeShift);
	local _FuryofElune, _FuryofElune_RDY = ConRO:AbilityReady(Ability.FuryofElune, timeShift);
	local _IncarnationChosenofElune, _IncarnationChosenofElune_RDY, _IncarnationChosenofElune_CD = ConRO:AbilityReady(Ability.IncarnationChosenofElune, timeShift);
		local _IncarnationChosenofElune_BUFF = ConRO:Aura(Buff.IncarnationChosenofElune, timeShift);
	local _Moonfire, _Moonfire_RDY = ConRO:AbilityReady(Ability.Moonfire, timeShift);
		local _Moonfire_DEBUFF, _, _Moonfire_DUR = ConRO:TargetAura(Debuff.Moonfire, timeShift);
	local _MoonkinForm, _MoonkinForm_RDY = ConRO:AbilityReady(Ability.MoonkinForm, timeShift);
		local _MoonkinForm_FORM = ConRO:Form(Form.MoonkinForm);
		local _OwlkinFrenzy_BUFF = ConRO:Aura(Buff.OwlkinFrenzy, timeShift);
	local _NewMoon, _NewMoon_RDY = ConRO:AbilityReady(Ability.NewMoon, timeShift);
		local _HalfMoon, _, _HalfMoon_CD = ConRO:AbilityReady(Ability.HalfMoon, timeShift);
		local _FullMoon, _, _FullMoon_CD = ConRO:AbilityReady(Ability.FullMoon, timeShift);
		local _NewMoon_CHARGES, _NewMoon_MCHARGES, _NewMoon_CCD = ConRO:SpellCharges(_NewMoon);
	local _SolarBeam, _SolarBeam_RDY = ConRO:AbilityReady(Ability.SolarBeam, timeShift);
	local _Soothe, _Soothe_RDY = ConRO:AbilityReady(Ability.Soothe, timeShift);
	local _Starfire, _Starfire_RDY = ConRO:AbilityReady(Ability.Starfire, timeShift);
		local _Starfire_Count = GetSpellCount(_Starfire);
		local _EclipseSolar_BUFF, _, _EclipseSolar_DUR = ConRO:Aura(Buff.EclipseSolar, timeShift);
	local _Starsurge, _Starsurge_RDY = ConRO:AbilityReady(Ability.Starsurge, timeShift);
		local _Starlord_BUFF, _Starlord_COUNT = ConRO:Aura(Buff.Starlord, timeShift);
		local _UmbralEmbrace_BUFF = ConRO:Aura(Buff.UmbralEmbrace, timeShift);
	local _Starfall, _Starfall_RDY = ConRO:AbilityReady(Ability.Starfall, timeShift);
		local _Starfall_BUFF, _, _Starfall_DUR = ConRO:Aura(Buff.Starfall, timeShift);
	local _StellarFlare, _StellarFlare_RDY = ConRO:AbilityReady(Ability.StellarFlare, timeShift);
		local _StellarFlare_DEBUFF, _, _StellarFlare_DUR = ConRO:TargetAura(Debuff.StellarFlare, timeShift);
	local _Sunfire, _Sunfire_RDY = ConRO:AbilityReady(Ability.Sunfire, timeShift);
		local _Sunfire_DEBUFF, _, _Sunfire_DUR = ConRO:TargetAura(Debuff.Sunfire, timeShift);
	local _WarriorofElune, _WarriorofElune_RDY = ConRO:AbilityReady(Ability.WarriorofElune, timeShift);
		local _WarriorofElune_BUFF = ConRO:Form(Form.WarriorofElune);
	local _WildMushroom, _WildMushroom_RDY = ConRO:AbilityReady(Ability.WildMushroom, timeShift);
		local _WildMushroom_CHARGES = ConRO:SpellCharges(_WildMushroom);
	local _Wrath, _Wrath_RDY = ConRO:AbilityReady(Ability.Wrath, timeShift);
		local _Wrath_Count = GetSpellCount(_Wrath);
		local _EclipseLunar_BUFF, _, _EclipseLunar_DUR = ConRO:Aura(Buff.EclipseLunar, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
	local _enemies_in_range, _target_in_range = ConRO:Targets(Ability.Wrath);

		if _Wrath_Count == 1 and currentSpell == _Wrath then
			_EclipseLunar_BUFF = true;
		end

		if _Starfire_Count == 1 and currentSpell == _Starfire then
			_EclipseSolar_BUFF = true;
		end

		if currentSpell == Ability.FullMoon then
			_AstralPower = _AstralPower + 40;
			_NewMoon_CHARGES = _NewMoon_CHARGES - 1;
		elseif currentSpell == Ability.NewMoon then
			_AstralPower = _AstralPower + 10;
			_NewMoon_CHARGES = _NewMoon_CHARGES - 1;
		elseif currentSpell == Ability.HalfMoon then
			_AstralPower = _AstralPower + 20;
			_NewMoon_CHARGES = _NewMoon_CHARGES - 1;
		elseif currentSpell == Ability.Wrath then
			if tChosen[Ability.SouloftheForest] and _EclipseSolar_BUFF then
				_AstralPower = _AstralPower + 12;
			else
				_AstralPower = _AstralPower + 8;
			end
			_Wrath_Count = _Wrath_Count - 1;
		elseif currentSpell == Ability.Starfire then
			_AstralPower = _AstralPower + 8;
			_Starfire_Count = _Starfire_Count - 1;
			_UmbralEmbrace_BUFF = false;
		end

		if ConRO:FindSpell(_FullMoon) then
			_NewMoon_RDY = _NewMoon_RDY and _FullMoon_CD <= 0;
			_NewMoon = _FullMoon;
		elseif ConRO:FindSpell(_HalfMoon) then
			_NewMoon_RDY = _NewMoon_RDY and _HalfMoon_CD <= 0;
			_NewMoon = _HalfMoon;
		end

		if tChosen[Passive.OrbitalStrike.talentID] then
			_CelestialAlignment, _CelestialAlignment_RDY, _CelestialAlignment_CD = _CelestialAlignmentOS, _CelestialAlignmentOS_RDY, _CelestialAlignmentOS_CD;
		end


	local _No_Eclipse = not _EclipseSolar_BUFF and not _EclipseLunar_BUFF;

--Indicators
	ConRO:AbilityInterrupt(_SolarBeam, _SolarBeam_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Soothe, _Soothe_RDY and ConRO:Purgable());

	ConRO:AbilityBurst(_CelestialAlignment, _CelestialAlignment_RDY and _Moonfire_DEBUFF and _Sunfire_DEBUFF and (not tChosen[Ability.StellarFlare] or (tChosen[Ability.StellarFlare] and _StellarFlare_DEBUFF)) and (_EclipseSolar_BUFF or _EclipseLunar_BUFF) and not tChosen[Ability.IncarnationChosenofElune] and ConRO:BurstMode(_CelestialAlignment));
	ConRO:AbilityBurst(_IncarnationChosenofElune, _IncarnationChosenofElune_RDY and _Moonfire_DEBUFF and _Sunfire_DEBUFF and (not tChosen[Ability.StellarFlare] or (tChosen[Ability.StellarFlare] and _StellarFlare_DEBUFF)) and (_EclipseSolar_BUFF or _EclipseLunar_BUFF) and ConRO:BurstMode(_IncarnationChosenofElune));
	ConRO:AbilityBurst(_FuryofElune, _FuryofElune_RDY and _AstralPower <= 60 and (((_CelestialAlignment_BUFF or _CelestialAlignment_CD >= 50) and not tChosen[Ability.IncarnationChosenofElune]) or ((_IncarnationChosenofElune_BUFF or _IncarnationChosenofElune_CD >= 40) and tChosen[Ability.IncarnationChosenofElune])) and ConRO:BurstMode(_FuryofElune));
	ConRO:AbilityBurst(_ForceofNature, _ForceofNature_RDY and _AstralPower <= 80 and ConRO:BurstMode(_ForceofNature));
	ConRO:AbilityBurst(_WarriorofElune, _WarriorofElune_RDY and not _WarriorofElune_BUFF and ConRO:BurstMode(_WarriorofElune));
	ConRO:AbilityBurst(_ConvoketheSpirits, _ConvoketheSpirits_RDY and (_EclipseSolar_BUFF or _EclipseLunar_BUFF) and ConRO:BurstMode(_ConvoketheSpirits));

--Rotations	
	for i = 1, 2, 1 do
		if select(8, UnitChannelInfo("player")) == _ConvoketheSpirits then -- Do not break cast
			tinsert(ConRO.SuggestedSpells, _ConvoketheSpirits);
		end

		if _MoonkinForm_RDY and not _MoonkinForm_FORM then
			tinsert(ConRO.SuggestedSpells, _MoonkinForm);
		end

		if not _in_combat then
			if _No_Eclipse then
				if _Wrath_RDY and _Wrath_Count >= 1 then
					tinsert(ConRO.SuggestedSpells, _Wrath);
					_Wrath_Count = _Wrath_Count - 1;
					_EclipseLunar_BUFF = true;
				end
			end
		end

		if _Moonfire_RDY and (not _Moonfire_DEBUFF or _Moonfire_DUR <= 5) then
			tinsert(ConRO.SuggestedSpells, _Moonfire);
			_Moonfire_DEBUFF = true;
			_Moonfire_DUR = 16;
		elseif _StellarFlare_RDY and (not _StellarFlare_DEBUFF or _StellarFlare_DUR <= 5) and currentSpell ~= _StellarFlare and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 2) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _StellarFlare);
			_StellarFlare_DEBUFF = true;
			_StellarFlare_DUR = 18;
		elseif _Sunfire_RDY and (not _Sunfire_DEBUFF or _Sunfire_DUR <= 4) then
			tinsert(ConRO.SuggestedSpells, _Sunfire);
			_Sunfire_DEBUFF = true;
			_Sunfire_DUR = 13;
		end

		if _No_Eclipse then
			if _Wrath_RDY and _Wrath_Count >= 1 then
				tinsert(ConRO.SuggestedSpells, _Wrath);
				_Wrath_Count = _Wrath_Count - 1;
				_EclipseLunar_BUFF = true;
			end
		end

		if _AdaptiveSwarm_RDY then
			tinsert(ConRO.SuggestedSpells, _AdaptiveSwarm);
			_AdaptiveSwarm_RDY = false;
		end

		if tChosen[Ability.IncarnationChosenofElune.talentID] then
			if _IncarnationChosenofElune_RDY and not _IncarnationChosenofElune_BUFF and ConRO:FullMode(_IncarnationChosenofElune) then
				tinsert(ConRO.SuggestedSpells, _IncarnationChosenofElune);
				_IncarnationChosenofElune_RDY = false;
			end
		else
			if _CelestialAlignment_RDY and not _CelestialAlignment_BUFF and ConRO:FullMode(_CelestialAlignment) then
				tinsert(ConRO.SuggestedSpells, _CelestialAlignment);
				_CelestialAlignment_RDY = false;
			end
		end

		if _ConvoketheSpirits_RDY and _AstralPower < 50 and ConRO:FullMode(_ConvoketheSpirits) then
			tinsert(ConRO.SuggestedSpells, _ConvoketheSpirits);
			_ConvoketheSpirits_RDY = false;
		end

		if _Starsurge_RDY and _AstralPower >= 40 and (_EclipseLunar_BUFF or _EclipseSolar_BUFF) and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 2) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _Starsurge);
			_AstralPower = _AstralPower - 40;
		end

		if _Starfall_RDY and _AstralPower >= 50 and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _Starfall);
			_AstralPower = _AstralPower - 50;
		end

		if _AstralCommunion_RDY and _AstralPower < _AstralPower_Max - 60 and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 2) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _AstralCommunion);
			_AstralCommunion_RDY = false;
			_AstralPower = AstralCommunion + 60;
		end

		if _FuryofElune_RDY and _AstralPower <= 70 and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 2) or ConRO_SingleButton:IsVisible()) and ConRO:FullMode(_FuryofElune) then
			tinsert(ConRO.SuggestedSpells, _FuryofElune);
			_FuryofElune_RDY = false;
		end		

		if _WildMushroom_RDY and _WildMushroom_CHARGES >= 1 and (tChosen[Passive.FungalGrowth.talentID] or ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible())) then
			tinsert(ConRO.SuggestedSpells, _WildMushroom);
			_WildMushroom_CHARGES = _WildMushroom_CHARGES - 1;
		end

		if _FuryofElune_RDY and _AstralPower <= 70 and ConRO:FullMode(_FuryofElune) then
			tinsert(ConRO.SuggestedSpells, _FuryofElune);
			_FuryofElune_RDY = false;
		end

		if _AstralCommunion_RDY and _AstralPower < 40 then
			tinsert(ConRO.SuggestedSpells, _AstralCommunion);
			_AstralCommunion_RDY = false;
			_AstralPower = AstralCommunion + 60;
		end

		if _NewMoon_RDY and (_NewMoon_CHARGES == _NewMoon_MCHARGES or (_NewMoon_CHARGES >= _NewMoon_MCHARGES - 1 and _NewMoon_CCD <= 3) or _AstralPower <= 40) then
			tinsert(ConRO.SuggestedSpells, _NewMoon);
			_NewMoon_CHARGES = _NewMoon_CHARGES - 1;
		end

		if _ForceofNature_RDY and _AstralPower <= 80 and ConRO:FullMode(_ForceofNature) then
			tinsert(ConRO.SuggestedSpells, _ForceofNature);
			_ForceofNature_RDY = false;
		end

		if _WarriorofElune_RDY and not _WarriorofElune_BUFF and ConRO:FullMode(_WarriorofElune) then
			tinsert(ConRO.SuggestedSpells, _WarriorofElune);
			_WarriorofElune_RDY = false;
		end

		if _Starfire_RDY and ((_EclipseLunar_BUFF or _EclipseSolar_BUFF) and (_UmbralEmbrace_BUFF or (ConRO_AutoButton:IsVisible() and _enemies_in_range >= 2) or ConRO_AoEButton:IsVisible())) then
			tinsert(ConRO.SuggestedSpells, _Starfire);
		end

		if _Wrath_RDY then
			tinsert(ConRO.SuggestedSpells, _Wrath);
		end
	end
	return nil;
end

function ConRO.Druid.BalanceDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Bal_Ability, ids.Bal_Passive, ids.Bal_Form, ids.Bal_Buff, ids.Bal_Debuff, ids.Bal_PetAbility, ids.Bal_PvPTalent, ids.Glyph;
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
	local _AstralPower, _AstralPower_Max																	= ConRO:PlayerPower('LunarPower');
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');

--Racials
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(Racial.Berserking, timeShift);

--Abilities	
	local _Barkskin, _Barkskin_RDY 																		= ConRO:AbilityReady(Ability.Barkskin, timeShift);

	local _Renewal, _Renewal_RDY 																		= ConRO:AbilityReady(Ability.Renewal, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

--Rotations	
		if _Renewal_RDY and _Player_Percent_Health <= 60 then
			tinsert(ConRO.SuggestedDefSpells, _Renewal);
		end

		if _Barkskin_RDY then
			tinsert(ConRO.SuggestedDefSpells, _Barkskin);
		end
	return nil;
end

function ConRO.Druid.Feral(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Feral_Ability, ids.Feral_Passive, ids.Feral_Form, ids.Feral_Buff, ids.Feral_Debuff, ids.Feral_PetAbility, ids.Feral_PvPTalent, ids.Glyph;
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
	local _Combo, _Combo_Max = ConRO:PlayerPower('Combo');
	local _Energy, _Energy_Max = ConRO:PlayerPower('Energy');
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');

--Racials
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);

--Abilities	
	local _Berserk, _Berserk_RDY = ConRO:AbilityReady(Ability.Berserk, timeShift);
		local _Berserk_BUFF = ConRO:Aura(Buff.Berserk, timeShift);
	local _CatForm, _CatForm_RDY = ConRO:AbilityReady(Ability.CatForm, timeShift);
		local _BearForm_FORM = ConRO:Form(Form.BearForm);
		local _CatForm_FORM	= ConRO:Form(Form.CatForm);
	local _FerociousBite, _FerociousBite_RDY = ConRO:AbilityReady(Ability.FerociousBite, timeShift);
		local _ApexPredatorsCraving_BUFF = ConRO:Aura(Buff.ApexPredatorsCraving, timeShift);
	local _Maim, _Maim_RDY = ConRO:AbilityReady(Ability.Maim, timeShift);
	local _Mangle, _Mangle_RDY = ConRO:AbilityReady(Ability.Mangle, timeShift);
	local _Moonfire, _Moonfire_RDY = ConRO:AbilityReady(Ability.Moonfire, timeShift);
	local _MoonfireCF, _, _MoonfireCF_CD = ConRO:AbilityReady(Ability.MoonfireCF, timeShift);
		local _Moonfire_DEBUFF = ConRO:TargetAura(Debuff.Moonfire, timeShift + 4);
	local _Prowl, _Prowl_RDY = ConRO:AbilityReady(Ability.Prowl, timeShift);
		local _Prowl_FORM = ConRO:Form(Form.Prowl);
	local _Rake, _Rake_RDY = ConRO:AbilityReady(Ability.Rake, timeShift);
		local _Rake_DEBUFF = ConRO:TargetAura(Debuff.Rake, timeShift + 4);
		local _RakeStun_DEBUFF = ConRO:TargetAura(Debuff.RakeStun, timeShift);
	local _Regrowth, _Regrowth_RDY = ConRO:AbilityReady(Ability.Regrowth, timeShift);
		local _PredatorySwiftness_BUFF = ConRO:Aura(Buff.PredatorySwiftness, timeShift);
	local _Rip, _Rip_RDY = ConRO:AbilityReady(Ability.Rip, timeShift);
		local _Rip_DEBUFF, _, _Rip_DUR = ConRO:TargetAura(Debuff.Rip, timeShift);
	local _Shred, _Shred_RDY = ConRO:AbilityReady(Ability.Shred, timeShift);
		local _Clearcasting_BUFF = ConRO:Aura(Buff.Clearcasting, timeShift);
		local _Bloodtalons_BUFF = ConRO:Aura(Buff.Bloodtalons, timeShift);
	local _SkullBash, _SkullBash_RDY = ConRO:AbilityReady(Ability.SkullBash, timeShift);
	local _Soothe, _Soothe_RDY = ConRO:AbilityReady(Ability.Soothe, timeShift);
	local _Swipe, _Swipe_RDY = ConRO:AbilityReady(Ability.Swipe, timeShift);
		local _SwipeBF, _, _SwipeBF_CD = ConRO:AbilityReady(Ability.SwipeBF, timeShift);
		local _SwipeCF, _, _SwipeCF_CD = ConRO:AbilityReady(Ability.SwipeCF, timeShift);
	local _Thrash, _Thrash_RDY = ConRO:AbilityReady(Ability.Thrash, timeShift);
		local _ThrashCF, _, _ThrashCF_CD = ConRO:AbilityReady(Ability.ThrashCF, timeShift);
		local _ThrashCF_DEBUFF, _, _ThrashCF_DUR = ConRO:TargetAura(Debuff.ThrashCF, timeShift);
		local _ThrashBF, _, _ThrashBF_CD = ConRO:AbilityReady(Ability.ThrashBF, timeShift);
		local _ThrashBF_DEBUFF, _ThrashBF_COUNT = ConRO:TargetAura(Debuff.ThrashBF, timeShift);
	local _TigersFury, _TigersFury_RDY = ConRO:AbilityReady(Ability.TigersFury, timeShift + 0.5);
		local _TigersFury_BUFF = ConRO:Aura(Buff.TigersFury, timeShift);

	local _BrutalSlash, _BrutalSlash_RDY = ConRO:AbilityReady(Ability.BrutalSlash, timeShift);
		local _BrutalSlash_CHARGES, _BrutalSlash_MaxCHARGES, _BrutalSlash_CCD = ConRO:SpellCharges(_BrutalSlash);
	local _FeralFrenzy, _FeralFrenzy_RDY = ConRO:AbilityReady(Ability.FeralFrenzy, timeShift);
	local _IncarnationAvatarofAshmane, _IncarnationAvatarofAshmane_RDY = ConRO:AbilityReady(Ability.IncarnationAvatarofAshmane, timeShift);
		local _IncarnationAvatarofAshmane_BUFF = ConRO:Aura(Buff.IncarnationAvatarofAshmane, timeShift);
	local _PrimalWrath, _PrimalWrath_RDY = ConRO:AbilityReady(Ability.PrimalWrath, timeShift);
	local _WildCharge, _WildCharge_RDY = ConRO:AbilityReady(Ability.WildCharge, timeShift);
		local _, _WildCharge_RANGE = ConRO:Targets(Ability.WildCharge)
		local _WildChargeBF = ConRO:AbilityReady(Ability.WildChargeBF, timeShift);
		local _WildChargeCF = ConRO:AbilityReady(Ability.WildChargeCF, timeShift);


	local _AdaptiveSwarm, _AdaptiveSwarm_RDY = ConRO:AbilityReady(Ability.AdaptiveSwarm, timeShift);
		local _AdaptiveSwarm_DEBUFF = ConRO:TargetAura(Debuff.AdaptiveSwarm, timeShift);
	local _ConvoketheSpirits, _ConvoketheSpirits_RDY = ConRO:AbilityReady(Ability.ConvoketheSpirits, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");

		if _BearForm_FORM then
			_WildCharge = _WildChargeBF;
			_Thrash_RDY = _Thrash_RDY and _ThrashBF_CD <= 0;
			_Thrash = _ThrashBF;
			_Swipe_RDY = _Swipe_RDY and _SwipeBF_CD <= 0;
			_Swipe = _SwipeBF;
		end

		if _CatForm_FORM then
			_WildCharge = _WildChargeCF;
			_Thrash_RDY = _Thrash_RDY and _ThrashCF_CD <= 0;
			_Thrash = _ThrashCF;
			_Swipe_RDY = _Swipe_RDY and _SwipeCF_CD <= 0;
			_Swipe = _SwipeCF;
		end

		if tChosen[Passive.LunarInspiration.talentID] then
			_Moonfire_RDY = _Moonfire_RDY and _MoonfireCF_CD <= 0;
			_Moonfire = _MoonfireCF;
		end

--Indicators		
	ConRO:AbilityInterrupt(_SkullBash, _SkullBash_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Soothe, _Soothe_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_WildCharge, _WildCharge_RDY and _WildCharge_RANGE);

	ConRO:AbilityBurst(_Berserk, _Berserk_RDY and not tChosen[Ability.IncarnationAvatarofAshmane.talentID] and ConRO:BurstMode(_Berserk));
	ConRO:AbilityBurst(_IncarnationAvatarofAshmane, _IncarnationAvatarofAshmane_RDY and ConRO:BurstMode(_IncarnationAvatarofAshmane));
	ConRO:AbilityBurst(_FeralFrenzy, _FeralFrenzy_RDY and _Combo <= 0 and ConRO:BurstMode(_FeralFrenzy));
	ConRO:AbilityBurst(_ConvoketheSpirits, _ConvoketheSpirits_RDY and _Combo <= 2 and _Energy <= 30 and ConRO:BurstMode(_ConvoketheSpirits));

--Rotations	
	for i = 1, 2, 1 do
		if _BearForm_FORM then
			if _Thrash_RDY and _ThrashBF_COUNT < 3 then
				tinsert(ConRO.SuggestedSpells, _Thrash);
			end

			if _Mangle_RDY then
				tinsert(ConRO.SuggestedSpells, _Mangle);
			end

			if _Swipe_RDY then
				tinsert(ConRO.SuggestedSpells, _Swipe_Bear);
			end
		return nil;
		end

		if _CatForm_RDY and not _CatForm_FORM then
			tinsert(ConRO.SuggestedSpells, _CatForm);
			_CatForm_FORM = true;
		end

		if not _in_combat then
			if _Prowl_RDY and not _Prowl_FORM then
				tinsert(ConRO.SuggestedSpells, _Prowl);
				_Prowl_RDY = false;
			end

			if _Rake_RDY and not _Rake_DEBUFF then
				tinsert(ConRO.SuggestedSpells, _Rake);
				_Rake_DEBUFF = true;
			end
		end

		if _Moonfire_RDY and not _Moonfire_DEBUFF and tChosen[Passive.LunarInspiration.talentID] then
			tinsert(ConRO.SuggestedSpells, _Moonfire);
			_Moonfire_RDY = false;
		end

		if _TigersFury_RDY and not _TigersFury_BUFF and _Energy <= _Energy_Max - 55 then
			tinsert(ConRO.SuggestedSpells, _TigersFury);
			_TigersFury_RDY = false;
		end

		if _FerociousBite_RDY and _ApexPredatorsCraving_BUFF then
			tinsert(ConRO.SuggestedSpells, _FerociousBite);
			_ApexPredatorsCraving_BUFF = false;
		end

		if _FeralFrenzy_RDY and _Combo <= 0 and ConRO:FullMode(_FeralFrenzy) then
			tinsert(ConRO.SuggestedSpells, _FeralFrenzy);
			_FeralFrenzy_RDY = false;
		end

		if _AdaptiveSwarm_RDY and not _AdaptiveSwarm_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _AdaptiveSwarm);
			_AdaptiveSwarm_RDY = false;
		end

		if _Berserk_RDY and not tChosen[Ability.IncarnationAvatarofAshmane.talentID] and ConRO:FullMode(_Berserk) then
			tinsert(ConRO.SuggestedSpells, _Berserk);
			_Berserk_RDY = false;
		end

		if _IncarnationAvatarofAshmane_RDY and ConRO:FullMode(_IncarnationAvatarofAshmane) then
			tinsert(ConRO.SuggestedSpells, _IncarnationAvatarofAshmane);
			_IncarnationAvatarofAshmane_RDY = false;
		end

		if _PrimalWrath_RDY and _Combo == 5 and _enemies_in_melee >= 2 then
			tinsert(ConRO.SuggestedSpells, _PrimalWrath);
			_Combo = _Combo - 5;
		end

		if _Rip_RDY and (not _Rip_DEBUFF or _Rip_DUR <= 7) and _Combo >= 5 then
			tinsert(ConRO.SuggestedSpells, _Rip);
			_Rip_DUR = 24;
			_Combo = _Combo - 5;
		end

		if _Rake_RDY and not _Rake_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _Rake);
		end

		if _FerociousBite_RDY and _Rake_DEBUFF and _Combo >= 5 and _Energy >= 50 then
			tinsert(ConRO.SuggestedSpells, _FerociousBite);
			_Combo = _Combo - 5;
		end

		if _ConvoketheSpirits_RDY and ConRO:FullMode(_ConvoketheSpirits) then
			tinsert(ConRO.SuggestedSpells, _ConvoketheSpirits);
			_ConvoketheSpirits_RDY = false;
		end

		if _BrutalSlash_RDY and _Combo <= 4 and (_BrutalSlash_CHARGES == _BrutalSlash_MaxCHARGES or (_BrutalSlash_CHARGES == _BrutalSlash_MaxCHARGES - 1 and _BrutalSlash_CCD <= 1.5)) then
			tinsert(ConRO.SuggestedSpells, _BrutalSlash);
			_BrutalSlash_CHARGES = _BrutalSlash_CHARGES - 1;
			_Combo = _Combo + 1;
		end

		if _Thrash_RDY and _Combo <= 4 and (not _ThrashCF_DEBUFF or _ThrashCF_DUR <= 4) and ((tChosen[Passive.Bloodtalons.talentID] and not _Bloodtalons_BUFF) or tChosen[Passive.TasteforBlood.talentID]) and ConRO.lastSpellId ~= _Thrash then
			tinsert(ConRO.SuggestedSpells, _Thrash);
			_Thrash_Cat_DUR = 15;
			_Combo = _Combo + 1;
		end

		if _Swipe_RDY and not tChosen[Ability.BrutalSlash.talentID] and _Combo <= 4 and _enemies_in_melee >= 2 then
			tinsert(ConRO.SuggestedSpells, _Swipe);
			_Combo = _Combo + 1;
		end

		if _Shred_RDY and _Combo <= 4 then
			tinsert(ConRO.SuggestedSpells, _Shred);
			_Combo = _Combo + 1;
		end
	end
	return nil;
end

function ConRO.Druid.FeralDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Feral_Ability, ids.Feral_Passive, ids.Feral_Form, ids.Feral_Buff, ids.Feral_Debuff, ids.Feral_PetAbility, ids.Feral_PvPTalent, ids.Glyph;
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
	local _Combo, _Combo_Max = ConRO:PlayerPower('Combo');
	local _Energy, _Energy_Max = ConRO:PlayerPower('Energy');
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');

--Racials
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);

--Abilities
	local _SurvivalInstincts, _SurvivalInstincts_RDY = ConRO:AbilityReady(Ability.SurvivalInstincts, timeShift);
	local _Barkskin, _Barkskin_RDY = ConRO:AbilityReady(Ability.Barkskin, timeShift);
	local _Renewal, _Renewal_RDY = ConRO:AbilityReady(Ability.Renewal, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations	
		if _Renewal_RDY and _Player_Percent_Health <= 60 then
			tinsert(ConRO.SuggestedDefSpells, _Renewal);
		end

		if _Barkskin_RDY then
			tinsert(ConRO.SuggestedDefSpells, _Barkskin);
		end

		if _SurvivalInstincts_RDY then
			tinsert(ConRO.SuggestedDefSpells, _SurvivalInstincts);
		end
	return nil;
end

function ConRO.Druid.Guardian(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Guard_Ability, ids.Guard_Passive, ids.Guard_Form, ids.Guard_Buff, ids.Guard_Debuff, ids.Guard_PetAbility, ids.Guard_PvPTalent, ids.Glyph;
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
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');
	local _Rage, _Rage_Max = ConRO:PlayerPower('Rage');

--Racials
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);

--Abilities	
	local _BearForm, _BearForm_RDY = ConRO:AbilityReady(Ability.BearForm, timeShift);
		local _BearForm_FORM = ConRO:Form(Form.BearForm);
	local _BerserkRavage, _BerserkRavage_RDY = ConRO:AbilityReady(Ability.BerserkRavage, timeShift);
	local _BerserkUncheckedAggression, _BerserkUncheckedAggression_RDY = ConRO:AbilityReady(Ability.BerserkUncheckedAggression, timeShift);
	local _Growl, _Growl_RDY = ConRO:AbilityReady(Ability.Growl, timeShift);
	local _Mangle, _Mangle_RDY = ConRO:AbilityReady(Ability.Mangle, timeShift);
	local _Maul, _Maul_RDY = ConRO:AbilityReady(Ability.Maul, timeShift);
	local _Moonfire, _Moonfire_RDY = ConRO:AbilityReady(Ability.Moonfire, timeShift);
		local _GalacticGuardian_BUFF = ConRO:Aura(Buff.GalacticGuardian, timeShift);
		local _Moonfire_DEBUFF = ConRO:TargetAura(Debuff.Moonfire, timeShift);
	local _SkullBash, _SkullBash_RDY = ConRO:AbilityReady(Ability.SkullBash, timeShift);
	local _Soothe, _Soothe_RDY = ConRO:AbilityReady(Ability.Soothe, timeShift);
	local _Swipe, _Swipe_RDY = ConRO:AbilityReady(Ability.Swipe, timeShift);
		local _SwipeBF, _, _SwipeBF_CD = ConRO:AbilityReady(Ability.SwipeBF, timeShift);
		local _SwipeCF, _, _SwipeCF_CD = ConRO:AbilityReady(Ability.SwipeCF, timeShift);
	local _Thrash, _Thrash_RDY = ConRO:AbilityReady(Ability.Thrash, timeShift);
		local _ThrashCF, _, _ThrashCF_CD = ConRO:AbilityReady(Ability.ThrashCF, timeShift);
		local _ThrashCF_DEBUFF, _, _ThrashCF_DUR = ConRO:TargetAura(Debuff.ThrashCF, timeShift + 2);
		local _ThrashBF, _, _ThrashBF_CD = ConRO:AbilityReady(Ability.ThrashBF, timeShift);
		local _Thrash_DEBUFF, _Thrash_COUNT = ConRO:TargetAura(Debuff.Thrash, timeShift);

	local _Pulverize, _Pulverize_RDY = ConRO:AbilityReady(Ability.Pulverize, timeShift);
		local _Pulverize_BUFF = ConRO:Aura(Buff.Pulverize, timeShift + 3);
	local _WildCharge, _WildCharge_RDY = ConRO:AbilityReady(Ability.WildCharge, timeShift);
		local _, _WildCharge_RANGE = ConRO:Targets(Ability.WildCharge)
		local _WildChargeBF = ConRO:AbilityReady(Ability.WildChargeBF, timeShift);
		local _WildChargeCF	= ConRO:AbilityReady(Ability.WildChargeCF, timeShift);
	local _ConvoketheSpirits, _ConvoketheSpirits_RDY = ConRO:AbilityReady(Ability.ConvoketheSpirits, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

		if _BearForm_FORM then
			_WildCharge = _WildChargeBF;
			_Thrash_RDY = _Thrash_RDY and _ThrashBF_CD <= 0;
			_Thrash = _ThrashBF;
			_Swipe_RDY = _Swipe_RDY and _SwipeBF_CD <= 0;
			_Swipe = _SwipeBF;
		end

		if _CatForm_FORM then
			_WildCharge = _WildChargeCF;
			_Thrash_RDY = _Thrash_RDY and _ThrashCF_CD <= 0;
			_Thrash = _ThrashCF;
			_Swipe_RDY = _Swipe_RDY and _SwipeCF_CD <= 0;
			_Swipe = _SwipeCF;
		end

		if tChosen[Ability.BerserkRavage.talentID] then
			_Berserk = _BerserkRavage;
			_Berserk_RDY = _BerserkRavage_RDY;
		elseif tChosen[Ability.BerserkUncheckedAggression.talentID] then
			_Berserk = _BerserkUncheckedAggression;
			_Berserk_RDY = _BerserkUncheckedAggression_RDY;
		end

--Indicators	
	ConRO:AbilityInterrupt(_SkullBash, _SkullBash_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Soothe, _Soothe_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_WildCharge, _WildCharge_RDY and _WildCharge_RANGE);

	ConRO:AbilityTaunt(_Growl, _Growl_RDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));

	ConRO:AbilityBurst(_ConvoketheSpirits, _ConvoketheSpirits_RDY and ConRO:BurstMode(_ConvoketheSpirits));

--Rotations	
	for i = 1, 2, 1 do
		if _BearForm_RDY and not _BearForm_FORM then
			tinsert(ConRO.SuggestedSpells, _BearForm);
			_BearForm_FORM = true;
		end

		if _Moonfire_RDY and not _Moonfire_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _Moonfire);
			_Moonfire_DEBUFF = true;
		end

		if _Moonfire_RDY and _GalacticGuardian_BUFF and _enemies_in_melee == 1  then
			tinsert(ConRO.SuggestedSpells, _Moonfire);
			_GalacticGuardian_BUFF = false;
		end

		if _Thrash_RDY and (_Thrash_COUNT < 3 or _enemies_in_melee >= 2) then
			tinsert(ConRO.SuggestedSpells, _Thrash);
			_Thrash_RDY = false;
		end

		if _Pulverize_RDY and not _Pulverize_BUFF and _Thrash_COUNT >= 3 then
			tinsert(ConRO.SuggestedSpells, _Pulverize);
			_Pulverize_RDY = false;
		end

		if _Mangle_RDY and _enemies_in_melee <= 3 then
			tinsert(ConRO.SuggestedSpells, _Mangle);
			_Mangle_RDY = false;
		end

		if _Thrash_RDY and _enemies_in_melee == 1 then
			tinsert(ConRO.SuggestedSpells, _Thrash);
			_Thrash_RDY = false;
		end

		if _Moonfire_RDY and _GalacticGuardian_BUFF and _enemies_in_melee <= 5  then
			tinsert(ConRO.SuggestedSpells, _Moonfire);
			_GalacticGuardian_BUFF = false;
		end

		if _Maul_RDY and not ConRO:TarYou() and _Rage >= 90 and _enemies_in_melee <= 3 then
			tinsert(ConRO.SuggestedSpells, _Maul);
			_Rage = _Rage - 40;
		end

		if _Swipe_RDY then
			tinsert(ConRO.SuggestedSpells, _Swipe);
		end
	end
	return nil;
end

function ConRO.Druid.GuardianDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Guard_Ability, ids.Guard_Passive, ids.Guard_Form, ids.Guard_Buff, ids.Guard_Debuff, ids.Guard_PetAbility, ids.Guard_PvPTalent, ids.Glyph;
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
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(Racial.Berserking, timeShift);

--Abilities	
	local _SurvivalInstincts, _SurvivalInstincts_RDY 													= ConRO:AbilityReady(Ability.SurvivalInstincts, timeShift);
		local _SurvivalInstincts_BUFF																		= ConRO:Aura(Buff.SurvivalInstincts, timeShift);
	local _Barkskin, _Barkskin_RDY 																		= ConRO:AbilityReady(Ability.Barkskin, timeShift);
		local _Barkskin_BUFF																				= ConRO:Aura(Buff.Barkskin, timeShift);
	local _Ironfur, _Ironfur_RDY 																		= ConRO:AbilityReady(Ability.Ironfur, timeShift);
		local _Ironfur_BUFF, _Ironfur_COUNT																	= ConRO:Aura(Buff.Ironfur, timeShift);
	local _FrenziedRegeneration, _FrenziedRegeneration_RDY 												= ConRO:AbilityReady(Ability.FrenziedRegeneration, timeShift);
	local _Berserk, _Berserk_RDY																		= ConRO:AbilityReady(Ability.BerserkPersistence, timeShift);

	local _BristlingFur, _BristlingFur_RDY																= ConRO:AbilityReady(Ability.BristlingFur, timeShift);
	local _IncarnationGuardianofUrsoc, _IncarnationGuardianofUrsoc_RDY									= ConRO:AbilityReady(Ability.IncarnationGuardianofUrsoc, timeShift);
		local _IncarnationGuardianofUrsoc_BUFF																= ConRO:Aura(Buff.IncarnationGuardianofUrsoc, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

--Rotations	
		if _FrenziedRegeneration_RDY and _Player_Percent_Health <= 60 then
			tinsert(ConRO.SuggestedDefSpells, _FrenziedRegeneration);
		end

		if _BristlingFur_RDY and ConRO:TarYou() then
			tinsert(ConRO.SuggestedDefSpells, _BristlingFur);
		end

		if _Ironfur_RDY and ConRO:TarYou() and _Ironfur_COUNT < 4 then
			tinsert(ConRO.SuggestedDefSpells, _Ironfur);
		end

		if tChosen[Ability.IncarnationGuardianofUrsoc.talentID] then
			if _IncarnationGuardianofUrsoc_RDY and not _Barkskin_BUFF and not _SurvivalInstincts_BUFF then
				tinsert(ConRO.SuggestedDefSpells, _IncarnationGuardianofUrsoc);
			end
		else
			if _Berserk_RDY then
				tinsert(ConRO.SuggestedDefSpells, _Berserk);
			end
		end

		if _Barkskin_RDY and not _IncarnationGuardianofUrsoc_BUFF and not _SurvivalInstincts_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _Barkskin);
		end

		if _SurvivalInstincts_RDY and not _Barkskin_BUFF and not _IncarnationGuardianofUrsoc_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _SurvivalInstincts);
		end
	return nil;
end

function ConRO.Druid.Restoration(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Resto_Ability, ids.Resto_Passive, ids.Resto_Form, ids.Resto_Buff, ids.Resto_Debuff, ids.Resto_PetAbility, ids.Resto_PvPTalent, ids.Glyph;
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
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(Racial.Berserking, timeShift);

--Abilities
	local _Soothe, _Soothe_RDY																			= ConRO:AbilityReady(Ability.Soothe, timeShift);
	local _Tranquility, _Tranquility_RDY 																= ConRO:AbilityReady(Ability.Tranquility, timeShift);
	local _Lifebloom, _Lifebloom_RDY 																	= ConRO:AbilityReady(Ability.Lifebloom, timeShift);
	local _Moonfire, _Moonfire_RDY 																		= ConRO:AbilityReady(Ability.Moonfire, timeShift);
		local _Moonfire_DEBUFF																				= ConRO:TargetAura(Debuff.Moonfire, timeShift + 2);
	local _Regrowth, _Regrowth_RDY 																		= ConRO:AbilityReady(Ability.Regrowth, timeShift);
	local _Sunfire, _Sunfire_RDY 																		= ConRO:AbilityReady(Ability.Sunfire, timeShift);
		local _Sunfire_DEBUFF																				= ConRO:TargetAura(Debuff.Sunfire, timeShift + 2);
	local _Wrath, _Wrath_RDY 																			= ConRO:AbilityReady(Ability.Wrath, timeShift);
		local _EclipseLunar_BUFF, _, _EclipseLunar_DUR														= ConRO:Aura(Buff.EclipseLunar, timeShift);

	local _MoonkinForm, _MoonkinForm_RDY 																= ConRO:AbilityReady(Ability.MoonkinForm, timeShift);
		local _MoonkinForm_FORM																				= ConRO:Form(Form.MoonkinForm);
	local _Starsurge, _Starsurge_RDY 																	= ConRO:AbilityReady(Ability.Starsurge, timeShift);
	local _Starfire, _Starfire_RDY 																		= ConRO:AbilityReady(Ability.Starfire, timeShift);
		local _EclipseSolar_BUFF, _, _EclipseSolar_DUR														= ConRO:Aura(Buff.EclipseSolar, timeShift);
	local _Typhoon, _Typhoon_RDY 																		= ConRO:AbilityReady(Ability.Typhoon, timeShift);

	local _AdaptiveSwarm, _AdaptiveSwarm_RDY															= ConRO:AbilityReady(Ability.AdaptiveSwarm, timeShift);
		local _AdaptiveSwarm_DEBUFF																			= ConRO:TargetAura(Debuff.AdaptiveSwarm, timeShift);
	local _ConvoketheSpirits, _ConvoketheSpirits_RDY													= ConRO:AbilityReady(Ability.ConvoketheSpirits, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

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

	ConRO:AbilityBurst(_Tranquility, _Tranquility_RDY);

	ConRO:AbilityRaidBuffs(_Lifebloom, _Lifebloom_RDY and not ConRO:OneBuff(Buff.Lifebloom));

	ConRO:AbilityBurst(_ConvoketheSpirits, _ConvoketheSpirits_RDY and _in_combat);

--Rotations
		if _is_Enemy then
				if _MoonkinForm_RDY and not _MoonkinForm_FORM then
					tinsert(ConRO.SuggestedSpells, _MoonkinForm);
				end

				if _Moonfire_RDY and not _Moonfire_DEBUFF then
					tinsert(ConRO.SuggestedSpells, _Moonfire);
				elseif _Sunfire_RDY and not _Sunfire_DEBUFF then
					tinsert(ConRO.SuggestedSpells, _Sunfire);
				end

				if not _EclipseSolar_BUFF and not _EclipseLunar_BUFF then
					if last_eclipse_phase == "both" then
						if _Wrath_RDY then
							tinsert(ConRO.SuggestedSpells, _Wrath);
						end
					elseif last_eclipse_phase == "solar" then
						if _Wrath_RDY then
							tinsert(ConRO.SuggestedSpells, _Wrath);
						end
					elseif last_eclipse_phase == "lunar" then
						if _Starfire_RDY then
							tinsert(ConRO.SuggestedSpells, _Starfire);
						end
					end
				end

				if _Starsurge_RDY and ((_EclipseSolar_BUFF and _EclipseSolar_DUR >= 5) or (_EclipseLunar_BUFF and _EclipseLunar_DUR >= 5)) and currentSpell ~= _Starsurge then
					tinsert(ConRO.SuggestedSpells, _Starsurge);
				end

				if _Wrath_RDY and _EclipseSolar_BUFF then
					tinsert(ConRO.SuggestedSpells, _Wrath);
				end

				if _Starfire_RDY and _EclipseLunar_BUFF then
					tinsert(ConRO.SuggestedSpells, _Starfire);
				end


			if _Moonfire_RDY and not _Moonfire_DEBUFF then
				tinsert(ConRO.SuggestedSpells, _Moonfire);
			elseif _Sunfire_RDY and not _Sunfire_DEBUFF then
				tinsert(ConRO.SuggestedSpells, _Sunfire);
			end

			if _Wrath_RDY then
				tinsert(ConRO.SuggestedSpells, _Wrath);
			end
		end
	return nil;
end

function ConRO.Druid.RestorationDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Resto_Ability, ids.Resto_Passive, ids.Resto_Form, ids.Resto_Buff, ids.Resto_Debuff, ids.Resto_PetAbility, ids.Resto_PvPTalent, ids.Glyph;
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
	local _Barkskin, _Barkskin_RDY 																		= ConRO:AbilityReady(Ability.Barkskin, timeShift);

	local _Renewal, _Renewal_RDY 																		= ConRO:AbilityReady(Ability.Renewal, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

--Rotations	
		if _Renewal_RDY and _Player_Percent_Health <= 60 then
			tinsert(ConRO.SuggestedDefSpells, _Renewal);
		end

		if _Barkskin_RDY then
			tinsert(ConRO.SuggestedDefSpells, _Barkskin);
		end
	return nil;
end
