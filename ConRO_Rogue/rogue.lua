ConRO.Rogue = {};
ConRO.Rogue.CheckTalents = function()
end
ConRO.Rogue.CheckPvPTalents = function()
end
local ConRO_Rogue, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Rogue.CheckTalents;
	self.ModuleOnEnable = ConRO.Rogue.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Rogue [No Specialization Under 10]";
		self.NextSpell = ConRO.Rogue.Under10;
		self.ToggleHealer();
	end;
    if mode == 1 then
	    self.Description = 'Rogue [Assassination]';
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Rogue.Assassination;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Rogue.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
    end;
    if mode == 2 then
	    self.Description = 'Rogue [Outlaw]';
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Rogue.Outlaw;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Rogue.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
    end;
    if mode == 3 then
	    self.Description = 'Rogue [Sublety]';
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.Rogue.Subtlety;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Rogue.Disabled;
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
		self.NextDef = ConRO.Rogue.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Rogue.AssassinationDef;
		else
			self.NextDef = ConRO.Rogue.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Rogue.OutlawDef;
		else
			self.NextDef = ConRO.Rogue.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Rogue.SubletyDef;
		else
			self.NextDef = ConRO.Rogue.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Rogue.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Rogue.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");

--Warnings

--Rotations


return nil;
end

function ConRO.Rogue.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																														= UnitLevel("player");
	local _Player_Percent_Health 																									= ConRO:PercentHealth('player');
	local _is_PvP																																	= ConRO:IsPvP();
	local _in_combat 																															= UnitAffectingCombat('player');
	local _party_size																															= GetNumGroupMembers();

	local _is_PC																																	= UnitPlayerControlled("target");
	local _is_Enemy 																															= ConRO:TarHostile();
	local _Target_Health 																													= UnitHealth('target');
	local _Target_Percent_Health 																									= ConRO:PercentHealth('target');

--Resources

--Racials
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Warnings

--Rotations

	return nil;
end

function ConRO.Rogue.Assassination(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ass_Ability, ids.Ass_Passive, ids.Ass_Form, ids.Ass_Buff, ids.Ass_Debuff, ids.Ass_PetAbility, ids.Ass_PvPTalent, ids.Glyph;
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
	local _Energy, _Energy_Max, _Energy_Percent = ConRO:PlayerPower('Energy');
	local _Combo, _Combo_Max = ConRO:PlayerPower('Combo');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);
	local _Shadowmeld, _Shadowmeld_RDY = ConRO:AbilityReady(Racial.Shadowmeld, timeShift);

--Abilities
	local _Ambush, _Ambush_RDY = ConRO:AbilityReady(Ability.Ambush, timeShift);
		local _Blindside_BUFF = ConRO:Aura(Buff.Blindside, timeShift);
	local _CrimsonTempest, _CrimsonTempest_RDY = ConRO:AbilityReady(Ability.CrimsonTempest, timeShift);
		local _CrimsonTempest_DEBUFF = ConRO:TargetAura(Debuff.CrimsonTempest, timeShift + 2);
	local _Deathmark, _Deathmark_RDY = ConRO:AbilityReady(Ability.Deathmark, timeShift);
	local _EchoingReprimand, _EchoingReprimand_RDY = ConRO:AbilityReady(Ability.EchoingReprimand, timeShift);
		local _EchoingReprimand_2_BUFF = ConRO:Aura(Buff.EchoingReprimand_2, timeShift);
		local _EchoingReprimand_3_BUFF = ConRO:Aura(Buff.EchoingReprimand_3, timeShift);
		local _EchoingReprimand_4_BUFF = ConRO:Aura(Buff.EchoingReprimand_4, timeShift);
	local _Envenom, _Envenom_RDY = ConRO:AbilityReady(Ability.Envenom, timeShift);
		local _Envenom_BUFF = ConRO:Aura(Buff.Envenom, timeShift + 1);
	local _Exsanguinate, _Exsanguinate_RDY, _Exsanguinate_CD, _Exsanguinate_MaxCD = ConRO:AbilityReady(Ability.Exsanguinate, timeShift);
	local _FanofKnives, _FanofKnives_RDY = ConRO:AbilityReady(Ability.FanofKnives, timeShift);
	local _Garrote, _Garrote_RDY = ConRO:AbilityReady(Ability.Garrote, timeShift);
		local _Garrote_DEBUFF, _, _Garrote_DUR = ConRO:TargetAura(Debuff.Garrote, timeShift);
	local _IndiscriminateCarnage, _IndiscriminateCarnage_RDY = ConRO:AbilityReady(Ability.IndiscriminateCarnage, timeShift);
	local _Kick, _Kick_RDY = ConRO:AbilityReady(Ability.Kick, timeShift);
	local _KingsBane, _KingsBane_RDY = ConRO:AbilityReady(Ability.KingsBane, timeShift);
		local _KingsBane_DEBUFF, _, _KingsBane_DUR = ConRO:TargetAura(Debuff.KingsBane, timeShift);
	local _MarkedforDeath, _MarkedforDeath_RDY = ConRO:AbilityReady(Ability.MarkedforDeath, timeShift);
	local _Mutilate, _Mutilate_RDY = ConRO:AbilityReady(Ability.Mutilate, timeShift);
	--Poisons
		local _AmplifyingPoison_BUFF = ConRO:Aura(Buff.AmplifyingPoison, timeShift);
		local _CripplingPoison_BUFF = ConRO:Aura(Buff.CripplingPoison, timeShift);
		local _DeadlyPoison_BUFF = ConRO:Aura(Buff.DeadlyPoison, timeShift);
		local _DeadlyPoison_DEBUFF = ConRO:TargetAura(Debuff.DeadlyPoison, timeShift);
		local _InstantPoison_BUFF = ConRO:Aura(Buff.InstantPoison, timeShift);
		local _WoundPoison_BUFF = ConRO:Aura(Buff.WoundPoison, timeShift);
	local _PoisonedKnife, _PoisonedKnife_RDY = ConRO:AbilityReady(Ability.PoisonedKnife, timeShift);
	local _Rupture, _Rupture_RDY = ConRO:AbilityReady(Ability.Rupture, timeShift);
		local _Rupture_DEBUFF, _, _Rupture_DUR = ConRO:TargetAura(Debuff.Rupture, timeShift);
	local _Sepsis, _Sepsis_RDY = ConRO:AbilityReady(Ability.Sepsis, timeShift);
		local _Sepsis_DEBUFF, _Sepsis_DUR = ConRO:TargetAura(Debuff.Rupture, timeShift);
	local _SerratedBoneSpike, _SerratedBoneSpike_RDY = ConRO:AbilityReady(Ability.SerratedBoneSpike, timeShift);
		local _SerratedBoneSpike_DEBUFF, _SerratedBoneSpike_COUNT = ConRO:PersistentDebuff(Debuff.SerratedBoneSpike);
		local _SerratedBoneSpike_CHARGES, _, _SerratedBoneSpike_CCD = ConRO:SpellCharges(_SerratedBoneSpike);
	local _ShadowDance, _ShadowDance_RDY, _ShadowDance_CD = ConRO:AbilityReady(Ability.ShadowDance, timeShift);
		local _ShadowDance_CHARGES, _ShadowDance_MaxCHARGES, _ShadowDance_CCD = ConRO:SpellCharges(_ShadowDance);
		local _ShadowDance_BUFF = ConRO:Aura(Buff.ShadowDance, timeShift);
	local _Shadowstep, _Shadowstep_RDY = ConRO:AbilityReady(Ability.Shadowstep, timeShift);
		local _, _Shadowstep_RANGE = ConRO:Targets(Ability.Shadowstep);
	local _Shiv, _Shiv_RDY = ConRO:AbilityReady(Ability.Shiv, timeShift);
		local _Shiv_DEBUFF = ConRO:TargetAura(Debuff.Shiv, timeShift);
		local _Shiv_CHARGES, _, _Shiv_CCD = ConRO:SpellCharges(_Shiv);
	local _SliceandDice, _SliceandDice_RDY = ConRO:AbilityReady(Ability.SliceandDice, timeShift);
		local _SliceandDice_BUFF = ConRO:Aura(Buff.SliceandDice, timeShift);
	local _Sprint, _Sprint_RDY = ConRO:AbilityReady(Ability.Sprint, timeShift);
	local _Stealth, _Stealth_RDY = ConRO:AbilityReady(Ability.Stealth, timeShift);
	local _Subterfuge_Stealth, _Subterfuge_Stealth_RDY, _Subterfuge_Stealth_CD = ConRO:AbilityReady(Passive.Subterfuge_Stealth, timeShift);
		local _Subterfuge_BUFF = ConRO:Aura(Buff.Subterfuge, timeShift);
		local _MasterAssassin_BUFF = ConRO:Aura(Buff.MasterAssassin, timeShift);
	local _ThistleTea, _ThistleTea_RDY = ConRO:AbilityReady(Ability.ThistleTea, timeShift);
		local _ThistleTea_CHARGES = ConRO:SpellCharges(_ThistleTea);
	local _Vanish, _Vanish_RDY = ConRO:AbilityReady(Ability.Vanish, timeShift);
		local _Vanish_BUFF = ConRO:Aura(Buff.Vanish, timeShift);



		local _ElaboratePlanning_BUFF = ConRO:Aura(Buff.ElaboratePlanning, timeShift);


--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");

	local _is_stealthed = IsStealthed();
	local _combat_stealth = _is_stealthed or _ShadowDance_BUFF or _Vanish_BUFF or _Shadowmeld_BUFF or _Sepsis_BUFF or _Subterfuge_BUFF;

		if tChosen[Passive.Subterfuge.talentID] then
			_Stealth_RDY =  _Subterfuge_Stealth_RDY;
			_Stealth = _Subterfuge_Stealth;
		end

	local _Poison_applied = false;
		if _InstantPoison_BUFF then
			_Poison_applied = true;
		elseif _DeadlyPoison_BUFF then
			_Poison_applied = true;
		elseif _AmplifyingPoison_BUFF then
			_Poison_applied = true;
		elseif _WoundPoison_BUFF then
			_Poison_applied = true;
		end

	local EchoingReprimand_COUNT = 0;
		if _EchoingReprimand_2_BUFF then
			EchoingReprimand_COUNT = 2;
		end
		if _EchoingReprimand_3_BUFF then
			EchoingReprimand_COUNT = 3;
		end
		if _EchoingReprimand_4_BUFF then
			EchoingReprimand_COUNT = 4;
		end

--Indicators
	ConRO:AbilityInterrupt(_Kick, _Kick_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Shadowstep, _Shadowstep_RDY and _Shadowstep_RANGE and not _target_in_melee);
	ConRO:AbilityMovement(_Sprint, _Sprint_RDY and not _target_in_melee);

	ConRO:AbilityBurst(_EchoingReprimand, _EchoingReprimand_RDY and _Combo <= _Combo_Max - 2 and ConRO:BurstMode(_EchoingReprimand));
	ConRO:AbilityBurst(_MarkedforDeath, _MarkedforDeath_RDY and _Combo <= 1 and ConRO:BurstMode(_MarkedforDeath));
	ConRO:AbilityBurst(_Sepsis, _Sepsis_RDY and _Combo <= _Combo_Max - 1 and ConRO:BurstMode(_Sepsis));
	ConRO:AbilityBurst(_ShadowDance, _ShadowDance_RDY and not _combat_stealth and ConRO:BurstMode(_ShadowDance));
	ConRO:AbilityBurst(_Vanish, _Vanish_RDY and _in_combat and not ConRO:TarYou() and ((_Combo >= _Combo_Max and not _Rupture_DEBUFF and tChosen[Passive.Subterfuge.talentID]) or (tChosen[Passive.Subterfuge.talentID] and not _Garrote_DEBUFF)) and ConRO:BurstMode(_Vanish));

--Warnings
	ConRO:Warnings("Put lethal poison on your weapon!", not _Poison_applied and (_in_combat or _is_stealthed));

--Rotations
	if not _in_combat or _combat_stealth then
		if _Stealth_RDY and not _combat_stealth then
			tinsert(ConRO.SuggestedSpells, _Stealth);
			_Stealth_RDY = false;
		end

		if _SliceandDice_RDY and not _SliceandDice_BUFF and _Combo >= 1 then
			tinsert(ConRO.SuggestedSpells, _SliceandDice);
			_SliceandDice_BUFF = true;
		end

		if _IndiscriminateCarnage_RDY and not _combat_stealth and (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) then
			tinsert(ConRO.SuggestedSpells, _IndiscriminateCarnage);
			_IndiscriminateCarnage_RDY = false;
		end

		if _Rupture_RDY and not _Rupture_DEBUFF and _Combo >= 5 then
			tinsert(ConRO.SuggestedSpells, _Rupture);
			_Rupture_DEBUFF = true;
			_Combo = 0;
		end

		if _Mutilate_RDY and _Combo <= (_Combo_Max - 1) and tChosen[Passive.MasterAssassin.talentID] then
			tinsert(ConRO.SuggestedSpells, _Mutilate);
			_Mutilate_RDY = false;
			_Combo = _Combo + 2;
		end

		if _Garrote_RDY then
			tinsert(ConRO.SuggestedSpells, _Garrote);
			_Garrote_RDY = false;
		end

		if _Ambush_RDY and _is_stealthed then
			tinsert(ConRO.SuggestedSpells, _Ambush);
			_Ambush_RDY = false;
		end
	end

	if _SliceandDice_RDY and not _SliceandDice_BUFF and _Combo >= 1 then
		tinsert(ConRO.SuggestedSpells, _SliceandDice);
		_SliceandDice_BUFF = true;
	end

	if _SerratedBoneSpike_RDY and not _SerratedBoneSpike_DEBUFF then
		tinsert(ConRO.SuggestedSpells, _SerratedBoneSpike);
		_SerratedBoneSpike_BUFF = true;
	end

	if _CrimsonTempest_RDY and not _CrimsonTempest_DEBUFF and (_Combo >= (_Combo_Max - 1) or _Combo == EchoingReprimand_COUNT) and (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) then
		tinsert(ConRO.SuggestedSpells, _CrimsonTempest);
		_CrimsonTempest_RDY = false;
		_Combo = 0;
	end

	if _IndiscriminateCarnage_RDY and not _combat_stealth and (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) then
		tinsert(ConRO.SuggestedSpells, _IndiscriminateCarnage);
		_IndiscriminateCarnage_RDY = false;
	end

	if _ShadowDance_RDY and not _combat_stealth and ConRO:FullMode(_ShadowDance) then
		tinsert(ConRO.SuggestedSpells, _ShadowDance);
	end

	if _MarkedforDeath_RDY and _Combo <= 1 and ConRO:FullMode(_MarkedforDeath) then
		tinsert(ConRO.SuggestedSpells, _MarkedforDeath);
	end

	if _Garrote_RDY and (not _Garrote_DEBUFF or (_Garrote_DEBUFF and _Garrote_DUR <= 3)) and not _MasterAssassin_BUFF then
		tinsert(ConRO.SuggestedSpells, _Garrote);
		_Garrote_RDY = false;
	end

	if _Rupture_RDY and not _Rupture_DEBUFF and (_Combo >= (_Combo_Max - 1) or _Combo == EchoingReprimand_COUNT) then
		tinsert(ConRO.SuggestedSpells, _Rupture);
		_Rupture_DEBUFF = true;
		_Combo = 0;
	end

	if _Shiv_RDY and not _Shiv_DEBUFF and ((_KingsBane_DEBUFF and _KingsBane_DUR <= 8) or (_Sepsis_DEBUFF and _Sepsis_DUR <= 8)) then
		tinsert(ConRO.SuggestedSpells, _Shiv);
		_Shiv_RDY = false;
		_Shiv_DEBUFF = true;
		_Combo = _Combo + 1;
	end

	if _KingsBane_RDY then
		tinsert(ConRO.SuggestedSpells, _KingsBane);
		_KingsBane_RDY = false;
	end

	if _Sepsis_RDY and _Combo <= (_Combo_Max - 1) and ConRO:FullMode(_Sepsis) then
		tinsert(ConRO.SuggestedSpells, _Sepsis);
		_Sepsis_RDY = false;
		_Combo = _Combo + 1;
	end

	if _EchoingReprimand_RDY and _Combo <= _Combo_Max - 2 and ConRO:FullMode(_EchoingReprimand) then
		tinsert(ConRO.SuggestedSpells, _EchoingReprimand);
		_EchoingReprimand_RDY = false;
		_Combo = _Combo + 2;
	end

	if _Exsanguinate_RDY and not _is_stealthed and not _Subterfuge_BUFF and not _MasterAssassin_BUFF then
		tinsert(ConRO.SuggestedSpells, _Exsanguinate);
		_Exsanguinate_RDY = false;
	end

	if _Vanish_RDY and not _is_stealthed and not _Subterfuge_BUFF and not _MasterAssassin_BUFF and not ConRO:TarYou() and ConRO:FullMode(_Vanish) then
		if tChosen[Passive.Subterfuge.talentID] then
			if tChosen[Ability.Exsanguinate.talentID] then
				if (_Exsanguinate_RDY and _Combo <= _Combo_Max - 1) or not _Garrote_DEBUFF then
					tinsert(ConRO.SuggestedSpells, _Vanish);
				end
			else
				if not _Garrote_DEBUFF or (_Garrote_DEBUFF and _Garrote_DUR <= 6) then
					tinsert(ConRO.SuggestedSpells, _Vanish);
				end
			end
		elseif tChosen[Passive.Nightstalker.talentID] then
			if tChosen[Ability.Exsanguinate.talentID] then
				if not _Rupture_DEBUFF and _Exsanguinate_RDY and _Combo >= _Combo_Max - 1 then
					tinsert(ConRO.SuggestedSpells, _Vanish);
				end
			else
				if (not _Rupture_DEBUFF or (_Rupture_DEBUFF and _Rupture_DUR <= 7)) and _Combo >= _Combo_Max - 1 then
					tinsert(ConRO.SuggestedSpells, _Vanish);
				end
			end
		else
			if _Rupture_DEBUFF and _Garrote_DEBUFF then
				tinsert(ConRO.SuggestedSpells, _Vanish);
			end
		end
	end

	if _Deathmark_RDY then
		tinsert(ConRO.SuggestedSpells, _Deathmark);
		_Deathmark_RDY = false;
	end

	if _Shiv_RDY and (_Shiv_CHARGES == 2 or (_Shiv_CHARGES >= 1 and _Shiv_CCD >= 20 )) then
		tinsert(ConRO.SuggestedSpells, _Shiv);
		_Shiv_RDY = false;
		_Shiv_CHARGES = _Shiv_CHARGES - 1
		_Combo = _Combo + 1;
	end

	if _SerratedBoneSpike_RDY and (_SerratedBoneSpike_CHARGES == 3 or (_SerratedBoneSpike_CHARGES >= 2 and _SerratedBoneSpike_CCD < 3 )) then
		tinsert(ConRO.SuggestedSpells, _SerratedBoneSpike);
		_SerratedBoneSpike_BUFF = true;
		_Combo = _Combo + 1 + _SerratedBoneSpike_COUNT;
	end

	if _Envenom_RDY and not _Envenom_BUFF and (_Combo >= (_Combo_Max - 1) or _Combo == EchoingReprimand_COUNT) then
		tinsert(ConRO.SuggestedSpells, _Envenom);
		_Envenom_RDY = false;
		_Combo = 0;
	end

	if _ThistleTea_RDY and _ThistleTea_CHARGES >= 1 and _Energy <= 25 then
		tinsert(ConRO.SuggestedSpells, _ThistleTea);
		_ThistleTea_CHARGES = _ThistleTea_CHARGES - 1;
	end

	if _FanofKnives_RDY and _Combo <= (_Combo_Max - 1) and (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) then
		tinsert(ConRO.SuggestedSpells, _FanofKnives);
		_Combo = _Combo + 1;
	end

	if _CrimsonTempest_RDY and (_Combo >= (_Combo_Max - 1) or _Combo == EchoingReprimand_COUNT) and (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 6) then
		tinsert(ConRO.SuggestedSpells, _CrimsonTempest);
		_CrimsonTempest_RDY = false;
		_Combo = 0;
	end

	if _Envenom_RDY and (_Combo >= (_Combo_Max - 1) or _Combo == EchoingReprimand_COUNT) and (ConRO_AutoButton:IsVisible() and _enemies_in_melee < 6) then
		tinsert(ConRO.SuggestedSpells, _Envenom);
		_Envenom_RDY = false;
		_Combo = 0;
	end

	if _Ambush_RDY and _Combo <= (_Combo_Max - 1) and _Blindside_BUFF then
		tinsert(ConRO.SuggestedSpells, _Ambush);
		_Combo = _Combo + 2;
	end

	if _Mutilate_RDY and _Combo <= (_Combo_Max - 1) then
		tinsert(ConRO.SuggestedSpells, _Mutilate);
		_Combo = _Combo + 2;
	end
	return nil;
end

function ConRO.Rogue.AssassinationDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ass_Ability, ids.Ass_Passive, ids.Ass_Form, ids.Ass_Buff, ids.Ass_Debuff, ids.Ass_PetAbility, ids.Ass_PvPTalent, ids.Glyph;
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
	local _Energy, _Energy_Max, _Energy_Percent = ConRO:PlayerPower('Energy');
	local _Combo, _Combo_Max = ConRO:PlayerPower('Combo');

--Abilities
	local _Evasion, _Evasion_RDY = ConRO:AbilityReady(Ability.Evasion, timeShift);
	local _CrimsonVial, _CrimsonVial_RDY = ConRO:AbilityReady(Ability.CrimsonVial, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");

	local _is_stealthed = IsStealthed();

--Rotations
		if _CrimsonVial_RDY and _Player_Percent_Health <= 70 then
			tinsert(ConRO.SuggestedDefSpells, _CrimsonVial);
		end

		if _Evasion_RDY and _in_combat then
			tinsert(ConRO.SuggestedDefSpells, _Evasion);
		end
	return nil;
end

function ConRO.Rogue.Outlaw(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Out_Ability, ids.Out_Passive, ids.Out_Form, ids.Out_Buff, ids.Out_Debuff, ids.Out_PetAbility, ids.Out_PvPTalent, ids.Glyph;
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
	local _Energy, _Energy_Max, _Energy_Percent = ConRO:PlayerPower('Energy');
	local _Combo, _Combo_Max = ConRO:PlayerPower('Combo');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);
	local _Shadowmeld, _Shadowmeld_RDY = ConRO:AbilityReady(Racial.Shadowmeld, timeShift);

--Abilities
	local _AdrenalineRush, _AdrenalineRush_RDY = ConRO:AbilityReady(Ability.AdrenalineRush, timeShift);
		local _AdrenalineRush_BUFF 	= ConRO:Aura(Buff.AdrenalineRush, timeShift);
		local _LoadedDice_BUFF = ConRO:Aura(Buff.LoadedDice, timeShift);
	local _Ambush, _Ambush_RDY = ConRO:AbilityReady(Ability.Ambush, timeShift);
		local _Audacity_BUFF = ConRO:Aura(Buff.Audacity, timeShift);
	local _BetweentheEyes, _BetweentheEyes_RDY = ConRO:AbilityReady(Ability.BetweentheEyes, timeShift);
	local _BladeFlurry, _BladeFlurry_RDY = ConRO:AbilityReady(Ability.BladeFlurry, timeShift);
		local _BladeFlurry_BUFF = ConRO:Aura(Buff.BladeFlurry, timeShift + 1);
		local _BladeFlurry_CHARGES = ConRO:SpellCharges(_BladeFlurry);
	local _BladeRush, _BladeRush_RDY, _BladeRush_CD = ConRO:AbilityReady(Ability.BladeRush, timeShift);
	local _Dispatch, _Dispatch_RDY = ConRO:AbilityReady(Ability.Dispatch, timeShift);
	local _Dreadblades, _Dreadblades_RDY = ConRO:AbilityReady(Ability.Dreadblades, timeShift);
		local _Dreadblades_BUFF = ConRO:Aura(Buff.Dreadblades, timeShift);
	local _Eviscerate, _Eviscerate_RDY = ConRO:AbilityReady(Ability.Eviscerate, timeShift);
	local _GrapplingHook, _GrapplingHook_RDY = ConRO:AbilityReady(Ability.GrapplingHook, timeShift);
	local _KeepItRolling, _KeepItRolling_RDY =  ConRO:AbilityReady(Ability.KeepItRolling, timeShift);
	local _Kick, _Kick_RDY = ConRO:AbilityReady(Ability.Kick, timeShift);
	local _MarkedforDeath, _MarkedforDeath_RDY = ConRO:AbilityReady(Ability.MarkedforDeath, timeShift);
	--Poisons
		local _CripplingPoison_BUFF = ConRO:Aura(Buff.CripplingPoison, timeShift);
		local _InstantPoison_BUFF = ConRO:Aura(Buff.InstantPoison, timeShift);
		local _WoundPoison_BUFF = ConRO:Aura(Buff.WoundPoison, timeShift);
	local _PistolShot, _PistolShot_RDY = ConRO:AbilityReady(Ability.PistolShot, timeShift);
		local _Opportunity_BUFF = ConRO:Aura(Buff.Opportunity, timeShift);
	local _RolltheBones, _RolltheBones_RDY = ConRO:AbilityReady(Ability.RolltheBones, timeShift);
		local _RolltheBones_BUFF = {
			TrueBearing = ConRO:Aura(Buff.TrueBearing, timeShift + 3),
			RuthlessPrecision = ConRO:Aura(Buff.RuthlessPrecision, timeShift + 3),
			SkullandCrossbones = ConRO:Aura(Buff.SkullandCrossbones, timeShift + 3),
			GrandMelee = ConRO:Aura(Buff.GrandMelee, timeShift + 3),
			Broadside = ConRO:Aura(Buff.Broadside, timeShift + 3),
			BuriedTreasure = ConRO:Aura(Buff.BuriedTreasure, timeShift + 3),
		}
		local _RolltheBones_BUFF_DUR = {
			TrueBearing = select(3, ConRO:Aura(Buff.TrueBearing, timeShift)),
			RuthlessPrecision = select(3, ConRO:Aura(Buff.RuthlessPrecision, timeShift)),
			SkullandCrossbones = select(3, ConRO:Aura(Buff.SkullandCrossbones, timeShift)),
			GrandMelee = select(3, ConRO:Aura(Buff.GrandMelee, timeShift)),
			Broadside = select(3, ConRO:Aura(Buff.Broadside, timeShift)),
			BuriedTreasure = select(3, ConRO:Aura(Buff.BuriedTreasure, timeShift)),
		}
	local _ShadowDance, _ShadowDance_RDY, _ShadowDance_CD = ConRO:AbilityReady(Ability.ShadowDance, timeShift);
		local _ShadowDance_CHARGES, _ShadowDance_MaxCHARGES, _ShadowDance_CCD = ConRO:SpellCharges(_ShadowDance);
		local _ShadowDance_BUFF = ConRO:Aura(Buff.ShadowDance, timeShift);
	local _SinisterStrike, _SinisterStrike_RDY = ConRO:AbilityReady(Ability.SinisterStrike, timeShift);
	local _SliceandDice, _SliceandDice_RDY = ConRO:AbilityReady(Ability.SliceandDice, timeShift);
		local _SliceandDice_BUFF = ConRO:Aura(Buff.SliceandDice, timeShift + 12);
	local _Sprint, _Sprint_RDY = ConRO:AbilityReady(Ability.Sprint, timeShift);
	local _Stealth, _Stealth_RDY = ConRO:AbilityReady(Ability.Stealth, timeShift);
	local _ThistleTea, _ThistleTea_RDY = ConRO:AbilityReady(Ability.ThistleTea, timeShift);
		local _ThistleTea_CHARGES = ConRO:SpellCharges(_ThistleTea);
	local _Vanish, _Vanish_RDY = ConRO:AbilityReady(Ability.Vanish, timeShift);

	local _GhostlyStrike, _GhostlyStrike_RDY = ConRO:AbilityReady(Ability.GhostlyStrike, timeShift);
		local _GhostlyStrike_DEBUFF = ConRO:TargetAura(Debuff.GhostlyStrike, timeShift);
	local _KillingSpree, _KillingSpree_RDY, _KillingSpree_CD = ConRO:AbilityReady(Ability.KillingSpree, timeShift);
	local _Subterfuge_Stealth, _Subterfuge_Stealth_RDY = ConRO:AbilityReady(Passive.Subterfuge_Stealth, timeShift);
	local _EchoingReprimand, _EchoingReprimand_RDY = ConRO:AbilityReady(Ability.EchoingReprimand, timeShift);
		local _EchoingReprimand_2_BUFF = ConRO:Aura(Buff.EchoingReprimand_2, timeShift);
		local _EchoingReprimand_3_BUFF = ConRO:Aura(Buff.EchoingReprimand_3, timeShift);
		local _EchoingReprimand_4_BUFF = ConRO:Aura(Buff.EchoingReprimand_4, timeShift);
	local _Sepsis, _Sepsis_RDY = ConRO:AbilityReady(Ability.Sepsis, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");

	local _is_stealthed = IsStealthed();
	local _combat_stealth = _is_stealthed or _Vanish_BUFF or _Shadowmeld_BUFF;
		if _Player_Level <= 21 then
			_Dispatch, _Dispatch_RDY = _Eviscerate, _Eviscerate_RDY;
		end

		if tChosen[Passive.Subterfuge.talentID] then
			_Stealth_RDY =  _Subterfuge_Stealth_RDY;
			_Stealth = _Subterfuge_Stealth;
		end

	local _RolltheBones_COUNT = 0;
		for k, v in pairs(_RolltheBones_BUFF) do
			if v then
				_RolltheBones_COUNT = _RolltheBones_COUNT + 1;
			end
		end

	local _RolltheBones_DUR = 30;
	for k, v in pairs(_RolltheBones_BUFF_DUR) do
		if v > 0 then
			if v < _RolltheBones_DUR then
				_RolltheBones_DUR = v;
			end
		end
	end

    local _should_Roll = false;
		if _RolltheBones_COUNT <= 1 and _LoadedDice_BUFF then
			_should_Roll = true;
		end
		if (_RolltheBones_COUNT == 1 and not(_RolltheBones_BUFF.TrueBearing or _RolltheBones_BUFF.SkullandCrossbones)) or (_RolltheBones_COUNT == 2 and (_RolltheBones_BUFF.BuriedTreasure and _RolltheBones_BUFF.GrandMelee)) then
			_should_Roll = true;
		end
		if _RolltheBones_COUNT <= 0 then
			_should_Roll = true;
		end

	local _Broadside_Reward = 0
	local _Opportunity_Reward = 0
		if _RolltheBones_BUFF.Broadside then
			_Broadside_Reward = _Broadside_Reward + 1;
		end
		if tChosen[Passive.QuickDraw] and _Opportunity_BUFF then
			_Opportunity_Reward = _Opportunity_Reward + 1;
		end

	local _Poison_applied = false;
		if _InstantPoison_BUFF then
			_Poison_applied = true;
		elseif _WoundPoison_BUFF then
			_Poison_applied = true;
		end

	local EchoingReprimand_COUNT = 0;
		if _EchoingReprimand_2_BUFF then
			EchoingReprimand_COUNT = 2;
		end
		if _EchoingReprimand_3_BUFF then
			EchoingReprimand_COUNT = 3;
		end
		if _EchoingReprimand_4_BUFF then
			EchoingReprimand_COUNT = 4;
		end

		if _RolltheBones_BUFF.Broadside or _Opportunity_BUFF then
			_Combo_Max = _Combo_Max - 1;
		end

--Indicators
	ConRO:AbilityInterrupt(_Kick, _Kick_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_GrapplingHook, _GrapplingHook_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_Sprint, _Sprint_RDY and not _target_in_melee);

  	ConRO:AbilityBurst(_AdrenalineRush, _AdrenalineRush_RDY and ConRO:BurstMode(_AdrenalineRush));
	ConRO:AbilityBurst(_BladeRush, _BladeRush_RDY and (((ConRO_AutoButton:IsVisible() and _enemies_in_melee == 1) or ConRO_SingleButton:IsVisible()) or (_BladeFlurry_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()))) and ConRO:BurstMode(_BladeRush));
	ConRO:AbilityBurst(_Dreadblades, _Dreadblades_RDY and _Combo <= 1 and ConRO:BurstMode(_Dreadblades));
	ConRO:AbilityBurst(_KillingSpree, _KillingSpree_RDY and not _AdrenalineRush_BUFF and _Energy <= _Energy_Max - 35 and (((ConRO_AutoButton:IsVisible() and _enemies_in_melee == 1) or ConRO_SingleButton:IsVisible()) or (_BladeFlurry_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()))) and ConRO:BurstMode(_KillingSpree));
	ConRO:AbilityBurst(_MarkedforDeath, _MarkedforDeath_RDY and _Combo <= 1 and ConRO:BurstMode(_MarkedforDeath));
	ConRO:AbilityBurst(_RolltheBones, _RolltheBones_RDY and _should_Roll and ConRO:BurstMode(_RolltheBones));
	ConRO:AbilityBurst(_Vanish, _Vanish_RDY and not _combat_stealth and not ConRO:TarYou() and _Combo <= 1 and _Energy >= 50);
	ConRO:AbilityBurst(_Shadowmeld, _Shadowmeld_RDY and not _combat_stealth and not ConRO:TarYou() and _Combo <= 1 and _Energy >= 50);

	ConRO:AbilityBurst(_Sepsis, _Sepsis_RDY and _Combo <= _Combo_Max - 1 and ConRO:BurstMode(_Sepsis, timeShift));
	ConRO:AbilityBurst(_EchoingReprimand, _EchoingReprimand_RDY and _Combo <= _Combo_Max - 2 and ConRO:BurstMode(_EchoingReprimand));

--Warnings
	ConRO:Warnings("Put lethal poison on your weapon!", not _Poison_applied and (_in_combat or _is_stealthed));

--Rotations
	if not _in_combat then
		if _MarkedforDeath_RDY and _Combo <= 1 and ConRO:FullMode(_MarkedforDeath) then
			tinsert(ConRO.SuggestedSpells, _MarkedforDeath);
			_MarkedforDeath_RDY = false;
		end

		if _Stealth_RDY and not _combat_stealth then
			tinsert(ConRO.SuggestedSpells, _Stealth);
		end

		if _AdrenalineRush_RDY and ConRO:FullMode(_AdrenalineRush) then
			tinsert(ConRO.SuggestedSpells, _AdrenalineRush);
			_AdrenalineRush_RDY = false;
		end

		if _RolltheBones_RDY and _should_Roll and ConRO:FullMode(_RolltheBones) then
			tinsert(ConRO.SuggestedSpells, _RolltheBones);
		end

		if _BetweentheEyes_RDY and (_Combo >= _Combo_Max or _Combo == EchoingReprimand_COUNT) then
			tinsert(ConRO.SuggestedSpells, _BetweentheEyes);
			_BetweentheEyes_RDY = false;
			_Combo = 0;
		end

		if _Dispatch_RDY and (_Combo >= (_Combo_Max - 1) or _Combo == EchoingReprimand_COUNT) then
			tinsert(ConRO.SuggestedSpells, _Dispatch);
		end

		if _Ambush_RDY and _Combo <= _Combo_Max - 2 then
			tinsert(ConRO.SuggestedSpells, _Ambush);
		end
	elseif _combat_stealth then
		if _BetweentheEyes_RDY and (_Combo >= _Combo_Max or _Combo == EchoingReprimand_COUNT) then
			tinsert(ConRO.SuggestedSpells, _BetweentheEyes);
		end

		if _Dispatch_RDY and (_Combo >= (_Combo_Max - 1) or _Combo == EchoingReprimand_COUNT) then
			tinsert(ConRO.SuggestedSpells, _Dispatch);
		end

		if _Ambush_RDY and _Combo <= _Combo_Max - 2 then
			tinsert(ConRO.SuggestedSpells, _Ambush);
		end
	else
		if _AdrenalineRush_RDY and (not tChosen[Passive.ImprovedAdrenalineRush.talentID] or (tChosen[Passive.ImprovedAdrenalineRush.talentID] and _Combo <= 2)) and ConRO:FullMode(_AdrenalineRush) then
			tinsert(ConRO.SuggestedSpells, _AdrenalineRush);
			_AdrenalineRush_RDY = false;
		end

		if _RolltheBones_RDY and _should_Roll and ConRO:FullMode(_RolltheBones) then
			tinsert(ConRO.SuggestedSpells, _RolltheBones);
			_RolltheBones_RDY = false;
		end

		if _KeepItRolling_RDY and _RolltheBones_COUNT >= 3 and _RolltheBones_DUR <= 2 then
			tinsert(ConRO.SuggestedSpells, _KeepItRolling);
			_KeepItRolling_RDY = false;
		end

		if _ThistleTea_RDY and _ThistleTea_CHARGES >= 1 and _Energy <= 50 then
			tinsert(ConRO.SuggestedSpells, _ThistleTea);
			_ThistleTea_CHARGES = _ThistleTea_CHARGES - 1;
		end

		if _BladeFlurry_RDY and not _BladeFlurry_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _BladeFlurry);
			_BladeFlurry_RDY = false;
		end

		if _ColdBlood_RDY and _BetweentheEyes_RDY and (_Combo >= _Combo_Max or _Combo == EchoingReprimand_COUNT) and ConRO:FullMode(_ColdBlood) then
			tinsert(ConRO.SuggestedSpells, _ColdBlood);
			_ColdBlood_RDY = false;
		end

		if _BetweentheEyes_RDY and (_Combo >= _Combo_Max or _Combo == EchoingReprimand_COUNT) then
			tinsert(ConRO.SuggestedSpells, _BetweentheEyes);
			_BetweentheEyes_RDY = false;
			_Combo = 0;
		end

		if _SliceandDice_RDY and _Combo >= _Combo_Max and not _SliceandDice_BUFF then
			tinsert(ConRO.SuggestedSpells, _SliceandDice);
			_SliceandDice_RDY = false;
			_Combo = 0;
		end
		
		if _Dispatch_RDY and (_Combo >= _Combo_Max or _Combo == EchoingReprimand_COUNT) then
			tinsert(ConRO.SuggestedSpells, _Dispatch);
			_Dispatch_RDY = false;
		end

		if _ShadowDance_RDY and not _combat_stealth and _Combo <= 3 and not _Opportunity_BUFF and not _Audacity_BUFF and _Energy >= 80 then
			tinsert(ConRO.SuggestedSpells, _ShadowDance);
			_ShadowDance_RDY = false;
		end

		if _Dreadblades_RDY and _Combo <= 2 and ConRO:FullMode(_Dreadblades) then
			tinsert(ConRO.SuggestedSpells, _Dreadblades);
			_Dreadblades_RDY = false;
		end

		if _MarkedforDeath_RDY and _Combo <= 2 and ConRO:FullMode(_MarkedforDeath) then
			tinsert(ConRO.SuggestedSpells, _MarkedforDeath);
			_MarkedforDeath_RDY = false;
		end

		if _BladeRush_RDY and _Energy <= _Energy_Max - 50 and not _combat_stealth and not _Dreadblades_BUFF and ConRO:FullMode(_BladeRush) then
			tinsert(ConRO.SuggestedSpells, _BladeRush);
			_BladeRush_RDY = false;
		end

		if _KillingSpree_RDY and not _AdrenalineRush_BUFF and ConRO:FullMode(_KillingSpree) then
			tinsert(ConRO.SuggestedSpells, _KillingSpree);
			_KillingSpree_RDY = false;
		end

		if _GhostlyStrike_RDY and not _GhostlyStrike_DEBUFF and _Combo <= _Combo_Max then
			tinsert(ConRO.SuggestedSpells, _GhostlyStrike);
			_GhostlyStrike_RDY = false;
		end

		if _Sepsis_RDY and _Combo <= _Combo_Max - 1 and not _combat_stealth and not _Dreadblades_BUFF and ConRO:FullMode(_Sepsis) then
			tinsert(ConRO.SuggestedSpells, _Sepsis);
			_Sepsis_RDY = false;
		end

		if _EchoingReprimand_RDY and _Combo <= _Combo_Max - 2 and ConRO:FullMode(_EchoingReprimand) then
			tinsert(ConRO.SuggestedSpells, _EchoingReprimand);
			_EchoingReprimand_RDY = false;
		end

		if _Ambush_RDY and _Combo <= _Combo_Max - 2 then
			tinsert(ConRO.SuggestedSpells, _Ambush);
			_Ambush_RDY = false;
			_Combo = _Combo + 2;
		end

		if _PistolShot_RDY and _Opportunity_BUFF and _Combo <= (_Combo_Max - 1) then
			tinsert(ConRO.SuggestedSpells, _PistolShot);
			_PistolShot_RDY = false;
			_Combo = _Combo + 1;
		end

		if _SinisterStrike_RDY and _Combo <= (_Combo_Max - 1) then
			tinsert(ConRO.SuggestedSpells, _SinisterStrike);
			_SinisterStrike_RDY = false;
			_Combo = _Combo + 1;
		end
	end
return nil;
end

function ConRO.Rogue.OutlawDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Out_Ability, ids.Out_Passive, ids.Out_Form, ids.Out_Buff, ids.Out_Debuff, ids.Out_PetAbility, ids.Out_PvPTalent, ids.Glyph;
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
	local _Energy, _Energy_Max, _Energy_Percent = ConRO:PlayerPower('Energy');
	local _Combo, _Combo_Max = ConRO:PlayerPower('Combo');

--Abilities
	local _Evasion, _Evasion_RDY = ConRO:AbilityReady(Ability.Evasion, timeShift);
	local _CrimsonVial, _CrimsonVial_RDY = ConRO:AbilityReady(Ability.CrimsonVial, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

	local _is_stealthed = IsStealthed();

--Rotations
		if _CrimsonVial_RDY and _Player_Percent_Health <= 70 then
			tinsert(ConRO.SuggestedDefSpells, _CrimsonVial);
		end

		if _Evasion_RDY and _in_combat then
			tinsert(ConRO.SuggestedDefSpells, _Evasion);
		end
	return nil;
end

function ConRO.Rogue.Subtlety(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Sub_Ability, ids.Sub_Passive, ids.Sub_Form, ids.Sub_Buff, ids.Sub_Debuff, ids.Sub_PetAbility, ids.Sub_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _is_PvP_Target = _is_PvP and _is_PC and _is_Enemy;
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Energy, _Energy_Max, _Energy_Percent = ConRO:PlayerPower('Energy');
	local _Combo, _Combo_Max = ConRO:PlayerPower('Combo');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);
	local _Shadowmeld, _Shadowmeld_RDY = ConRO:AbilityReady(Racial.Shadowmeld, timeShift);
		local _Shadowmeld_BUFF = ConRO:Aura(Racial.Shadowmeld, timeShift);

--Abilities
	local _Backstab, _Backstab_RDY = ConRO:AbilityReady(Ability.Backstab, timeShift);
	local _BlackPowder, _BlackPowder_RDY = ConRO:AbilityReady(Ability.BlackPowder, timeShift);
	local _CheapShot, _CheapShot_RDY = ConRO:AbilityReady(Ability.CheapShot, timeShift);
	local _ColdBlood, _ColdBlood_RDY = ConRO:AbilityReady(Ability.ColdBlood, timeShift);
		local _ColdBlood_BUFF = ConRO:Aura(Buff.ColdBlood, timeShift);
	local _Eviscerate, _Eviscerate_RDY = ConRO:AbilityReady(Ability.Eviscerate, timeShift);
	local _Kick, _Kick_RDY = ConRO:AbilityReady(Ability.Kick, timeShift);
	local _KidneyShot, _KidneyShot_RDY = ConRO:AbilityReady(Ability.KidneyShot, timeShift);
	--Poisons
		local _CripplingPoison_BUFF = ConRO:Aura(Buff.CripplingPoison, timeShift);
		local _InstantPoison_BUFF = ConRO:Aura(Buff.InstantPoison, timeShift);
		local _WoundPoison_BUFF = ConRO:Aura(Buff.WoundPoison, timeShift);
	local _Rupture, _Rupture_RDY = ConRO:AbilityReady(Ability.Rupture, timeShift);
		local _Rupture_DEBUFF = ConRO:TargetAura(Debuff.Rupture, timeShift + 4);
	local _ShadowBlades, _ShadowBlades_RDY = ConRO:AbilityReady(Ability.ShadowBlades, timeShift);
		local _ShadowBlades_BUFF = ConRO:Aura(Buff.ShadowBlades, timeShift);
	local _ShadowDance, _ShadowDance_RDY = ConRO:AbilityReady(Ability.ShadowDance, timeShift);
		local _ShadowDance_CHARGES, _ShadowDance_MaxCHARGES, _ShadowDance_CCD = ConRO:SpellCharges(Ability.ShadowDance.spellID);
		local _ShadowDance_BUFF = ConRO:Aura(Buff.ShadowDance, timeShift);
	local _Shadowstep, _Shadowstep_RDY = ConRO:AbilityReady(Ability.Shadowstep, timeShift);
		local _Shadowstep_RANGE = ConRO:Targets(Ability.Shadowstep);
	local _Shiv, _Shiv_RDY = ConRO:AbilityReady(Ability.Shiv, timeShift);
	local _ShurikenStorm, _ShurikenStorm_RDY = ConRO:AbilityReady(Ability.ShurikenStorm, timeShift);
	local _ShurikenToss, _ShurikenToss_RDY = ConRO:AbilityReady(Ability.ShurikenToss, timeShift);
	local _Shadowstrike, _Shadowstrike_RDY = ConRO:AbilityReady(Ability.Shadowstrike, timeShift);
		local _FindWeakness_DEBUFF = ConRO:TargetAura(Debuff.FindWeakness, timeShift);
	local _SliceandDice, _SliceandDice_RDY = ConRO:AbilityReady(Ability.SliceandDice, timeShift);
		local _SliceandDice_BUFF = ConRO:Aura(Buff.SliceandDice, timeShift + 4);
	local _Sprint, _Sprint_RDY = ConRO:AbilityReady(Ability.Sprint, timeShift);
	local _Stealth, _Stealth_RDY, _Stealth_CD = ConRO:AbilityReady(Ability.Stealth, timeShift);
	local _SymbolsofDeath, _SymbolsofDeath_RDY, _SymbolsofDeath_CD = ConRO:AbilityReady(Ability.SymbolsofDeath, timeShift);
		local _SymbolsofDeath_BUFF = ConRO:Aura(Buff.SymbolsofDeath, timeShift);
	local _ThistleTea, _ThistleTea_RDY = ConRO:AbilityReady(Ability.ThistleTea, timeShift);
	local _Vanish, _Vanish_RDY = ConRO:AbilityReady(Ability.Vanish, timeShift);
		local _Vanish_BUFF = ConRO:Aura(Buff.Vanish, timeShift);

	local _Gloomblade, _Gloomblade_RDY = ConRO:AbilityReady(Ability.Gloomblade, timeShift);
	local _MarkedforDeath, _MarkedforDeath_RDY = ConRO:AbilityReady(Ability.MarkedforDeath, timeShift);
		local _MarkedforDeath_DEBUFF = ConRO:TargetAura(Debuff.MarkedforDeath, timeShift);
	local _SecretTechnique, _SecretTechnique_RDY = ConRO:AbilityReady(Ability.SecretTechnique, timeShift);
	local _ShurikenTornado, _ShurikenTornado_RDY = ConRO:AbilityReady(Ability.ShurikenTornado, timeShift);
	local _Subterfuge_Stealth, _Subterfuge_Stealth_RDY = ConRO:AbilityReady(Passive.Subterfuge_Stealth, timeShift);
		local _Premeditation_FORM = ConRO:Form(Form.Premeditation);

	local _EchoingReprimand, _EchoingReprimand_RDY = ConRO:AbilityReady(Ability.EchoingReprimand, timeShift);
		local _EchoingReprimand_2_BUFF = ConRO:Aura(Buff.EchoingReprimand_2, timeShift);
		local _EchoingReprimand_3_BUFF = ConRO:Aura(Buff.EchoingReprimand_3, timeShift);
		local _EchoingReprimand_4_BUFF = ConRO:Aura(Buff.EchoingReprimand_4, timeShift);
	local _Flagellation, _Flagellation_RDY = ConRO:AbilityReady(Ability.Flagellation, timeShift);
		local _Flagellation_BUFF, _, _Flagellation_DUR = ConRO:Aura(Buff.Flagellation, timeShift);
	local _Sepsis, _Sepsis_RDY = ConRO:AbilityReady(Ability.Sepsis, timeShift);
		local _Sepsis_BUFF = ConRO:Aura(Buff.Sepsis, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");

	local _is_stealthed = IsStealthed();
	local _combat_stealth = _is_stealthed or _ShadowDance_BUFF or _Vanish_BUFF or _Shadowmeld_BUFF or _Sepsis_BUFF;

	if tChosen[Passive.Subterfuge.talentID] then
		_Stealth_RDY =  _Subterfuge_Stealth_RDY;
		_Stealth = _Subterfuge_Stealth;
	end

	if tChosen[Ability.Gloomblade.talentID] then
		_Backstab, _Backstab_RDY = _Gloomblade, _Gloomblade_RDY;
	end

	local _Poison_applied = false;
	if _InstantPoison_BUFF then
		_Poison_applied = true;
	elseif _WoundPoison_BUFF then
		_Poison_applied = true;
	end

	local EchoingReprimand_COUNT = 0;
	if _EchoingReprimand_2_BUFF then
		EchoingReprimand_COUNT = 2;
	end
	if _EchoingReprimand_3_BUFF then
		EchoingReprimand_COUNT = 3;
	end
	if _EchoingReprimand_4_BUFF then
		EchoingReprimand_COUNT = 4;
	end

--Indicators
	ConRO:AbilityInterrupt(_Kick, _Kick_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_CheapShot, _CheapShot_RDY and (_Combo <= _Combo_Max - 1) and _is_PvP_Target and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_KidneyShot, _KidneyShot_RDY and (_Combo >= _Combo_Max - 1) and _is_PvP_Target and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Shadowstep, _Shadowstep_RDY and _Shadowstep_RANGE and not _target_in_melee);
	ConRO:AbilityMovement(_Sprint, _Sprint_RDY and not _target_in_melee);

	ConRO:AbilityBurst(_MarkedforDeath, _MarkedforDeath_RDY and _Combo <= 1 and ConRO:BurstMode(_MarkedforDeath));
	ConRO:AbilityBurst(_SecretTechnique, _SecretTechnique_RDY and (_SymbolsofDeath_BUFF or (not _SymbolsofDeath_BUFF and _SymbolsofDeath_CD > 5)) and (_Combo >= (_Combo_Max - 1) or _Combo == EchoingReprimand_COUNT) and ConRO:BurstMode(_SecretTechnique));
	ConRO:AbilityBurst(_ShadowBlades, _ShadowBlades_RDY and _SymbolsofDeath_BUFF and ConRO:BurstMode(_ShadowBlades));
	ConRO:AbilityBurst(_ShadowDance, _ShadowDance_RDY and not _combat_stealth and _SymbolsofDeath_BUFF and ConRO:BurstMode(_ShadowDance));
	ConRO:AbilityBurst(_Shadowmeld, _Shadowmeld_RDY and not ConRO:TarYou() and not _combat_stealth and not _FindWeakness_DEBUFF and _Combo <= 0);
	ConRO:AbilityBurst(_ShurikenTornado, _ShurikenTornado_RDY and _SymbolsofDeath_BUFF and ConRO:BurstMode(_ShurikenTornado));
	ConRO:AbilityBurst(_Vanish, _Vanish_RDY and not ConRO:TarYou() and not _combat_stealth and _Energy >= 45 and _Combo <= 1)
	ConRO:AbilityBurst(_ColdBlood, _ColdBlood_RDY and _Combo >=_Combo_Max - 1 and ConRO:BurstMode(_ColdBlood));

	ConRO:AbilityBurst(_Flagellation, _Flagellation_RDY and ConRO:BurstMode(_Flagellation));
	ConRO:AbilityBurst(_Sepsis, _Sepsis_RDY and _Combo <= _Combo_Max - 1 and _SymbolsofDeath_BUFF and ConRO:BurstMode(_Sepsis));
	ConRO:AbilityBurst(_EchoingReprimand, _EchoingReprimand_RDY and _Combo <= _Combo_Max - 2 and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 4) or ConRO_SingleButton:IsVisible()) and ConRO:BurstMode(_EchoingReprimand));

--Warnings
	ConRO:Warnings("Put lethal poison on your weapon!", not _Poison_applied and (_in_combat or _is_stealthed));

--Rotations
	if not _in_combat then
		if _Stealth_RDY and not _is_stealthed then
			tinsert(ConRO.SuggestedSpells, _Stealth);
		end

		if _MarkedforDeath_RDY and _Combo <= 1 and ConRO:FullMode(_MarkedforDeath) then
			tinsert(ConRO.SuggestedSpells, _MarkedforDeath);
		end

		if _SliceandDice_RDY and not _SliceandDice_BUFF and _Combo <= _Combo_Max - 1 then
			tinsert(ConRO.SuggestedSpells, _SliceandDice);
		end

		if _Rupture_RDY and not _Rupture_DEBUFF and _Combo <= _Combo_Max - 1 then
			tinsert(ConRO.SuggestedSpells, _Rupture);
		end

		if _Shadowstrike_RDY and _combat_stealth and _Combo <= _Combo_Max - 1 then
			tinsert(ConRO.SuggestedSpells, _Shadowstrike);
		end
	else
		if _Stealth_CD > 0 and _Combo >= 1 then
			if _SliceandDice_RDY and not _SliceandDice_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 5) or ConRO_SingleButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _SliceandDice);
			end

			if _Rupture_RDY and not _Rupture_DEBUFF then
				tinsert(ConRO.SuggestedSpells, _Rupture);
			end
		end

		if _SymbolsofDeath_RDY then
			tinsert(ConRO.SuggestedSpells, _SymbolsofDeath);
			_SymbolsofDeath_RDY = false;
		end

		if _ShadowBlades_RDY and ConRO:FullMode(_ShadowBlades) then
			tinsert(ConRO.SuggestedSpells, _ShadowBlades);
			_ShadowBlades_RDY = false;
		end

		if _ShurikenTornado_RDY and _SymbolsofDeath_BUFF and ConRO:FullMode(_ShurikenTornado) then
			tinsert(ConRO.SuggestedSpells, _ShurikenTornado);
			_ShurikenTornado_RDY = false;
		end

		if _ShadowDance_RDY and not _combat_stealth and _SymbolsofDeath_BUFF and ConRO:FullMode(_ShadowDance) then
			tinsert(ConRO.SuggestedSpells, _ShadowDance);
		end

		if _ColdBlood_RDY and (_Combo >= _Combo_Max - 1 or _Combo == EchoingReprimand_COUNT) and ConRO:FullMode(_ColdBlood) then
			tinsert(ConRO.SuggestedSpells, _ColdBlood);
			_ColdBlood_RDY = false;
		end

		if _ColdBlood_BUFF and (_Combo >= (_Combo_Max - 1) or _Combo == EchoingReprimand_COUNT) then
			if _SecretTechnique_RDY and ConRO:FullMode(_SecretTechnique) then
				tinsert(ConRO.SuggestedSpells, _SecretTechnique);
			end

			if _BlackPowder_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) or (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2 and tChosen[Passive.DarkBrew.talentID]) or ConRO_AoEButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _BlackPowder);
			end

			if _Eviscerate_RDY then
				tinsert(ConRO.SuggestedSpells, _Eviscerate);
			end
		end

		if _Sepsis_RDY and _Combo <= _Combo_Max - 1 and _SymbolsofDeath_BUFF and ConRO:FullMode(_Sepsis) then
			tinsert(ConRO.SuggestedSpells, _Sepsis);
			_Sepsis_RDY = false;
		end

		if _Flagellation_RDY and (_Combo >= _Combo_Max - 1 or _Combo == EchoingReprimand_COUNT) and ConRO:FullMode(_Flagellation) then
			tinsert(ConRO.SuggestedSpells, _Flagellation);
			_Flagellation_RDY = false;
		end

		if _ShadowDance_RDY and not _combat_stealth and (_ShadowDance_CHARGES >= _ShadowDance_MaxCHARGES - 1 and _ShadowDance_CCD <= 3) and ConRO:FullMode(_ShadowDance) then
			tinsert(ConRO.SuggestedSpells, _ShadowDance);
		end

		if _ThistleTea_RDY and _Energy_Percent <= 25 then
			tinsert(ConRO.SuggestedSpells, _ThistleTea);
			_ThistleTea_RDY = false;
		end

		if _MarkedforDeath_RDY and _Combo <= 1 and ConRO:FullMode(_MarkedforDeath) then
			tinsert(ConRO.SuggestedSpells, _MarkedforDeath);
		end

		if _EchoingReprimand_RDY and _Combo <= _Combo_Max - 2 and ConRO:FullMode(_EchoingReprimand) then
			tinsert(ConRO.SuggestedSpells, _EchoingReprimand);
		end

		if (_Combo >= _Combo_Max - 1 or (_Combo >= _Combo_Max - 2 and _ShadowDance_BUFF) or _Combo == EchoingReprimand_COUNT) then
			if _SecretTechnique_RDY and ConRO:FullMode(_SecretTechnique) then
				tinsert(ConRO.SuggestedSpells, _SecretTechnique);
			end

			if _SliceandDice_RDY and not _SliceandDice_BUFF and not _combat_stealth and not _SymbolsofDeath_BUFF then
				tinsert(ConRO.SuggestedSpells, _SliceandDice);
			end

			if _Rupture_RDY and not _Rupture_DEBUFF then
				tinsert(ConRO.SuggestedSpells, _Rupture);
			end

			if _BlackPowder_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) or (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2 and tChosen[Passive.DarkBrew.talentID]) or ConRO_AoEButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _BlackPowder);
			end

			if _Eviscerate_RDY then
				tinsert(ConRO.SuggestedSpells, _Eviscerate);
			end
		end

		if _Shadowstrike_RDY and _combat_stealth and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 3) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _Shadowstrike);
		end

		if _Backstab_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _Backstab);
		end

		if _ShurikenStorm_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _ShurikenStorm);
		end
	end
	return nil;
end

function ConRO.Rogue.SubletyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Sub_Ability, ids.Sub_Passive, ids.Sub_Form, ids.Sub_Buff, ids.Sub_Debuff, ids.Sub_PetAbility, ids.Sub_PvPTalent, ids.Glyph;
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
	local _Energy, _Energy_Max, _Energy_Percent = ConRO:PlayerPower('Energy');
	local _Combo, _Combo_Max = ConRO:PlayerPower('Combo');

--Abilities
	local _Evasion, _Evasion_RDY = ConRO:AbilityReady(Ability.Evasion, timeShift);
	local _CrimsonVial, _CrimsonVial_RDY = ConRO:AbilityReady(Ability.CrimsonVial, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");

	local _is_stealthed = IsStealthed();

--Rotations
		if _CrimsonVial_RDY and _Player_Percent_Health <= 70 then
			tinsert(ConRO.SuggestedDefSpells, _CrimsonVial);
		end

		if _Evasion_RDY and _in_combat then
			tinsert(ConRO.SuggestedDefSpells, _Evasion);
		end
	return nil;
end
