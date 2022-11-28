ConRO.DemonHunter = {};
ConRO.DemonHunter.CheckTalents = function()
end
ConRO.DemonHunter.CheckPvPTalents = function()
end
local ConRO_DemonHunter, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.DemonHunter.CheckTalents;
	self.ModuleOnEnable = ConRO.DemonHunter.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Demon Hunter [No Specialization Under 10]";
		self.NextSpell = ConRO.DemonHunter.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = "Demon Hunter [Havoc - Melee]";
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.DemonHunter.Havoc;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.DemonHunter.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 2 then
		self.Description = "Demon Hunter [Vengeance - Tank]";
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.DemonHunter.Vengeance;
			self.ToggleDamage();
			self.BlockAoE();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.DemonHunter.Disabled;
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
		self.NextDef = ConRO.DemonHunter.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.DemonHunter.HavocDef;
		else
			self.NextDef = ConRO.DemonHunter.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.DemonHunter.VengeanceDef;
		else
			self.NextDef = ConRO.DemonHunter.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.DemonHunter.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.DemonHunter.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.DemonHunter.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.DemonHunter.Havoc(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Havoc_Ability, ids.Havoc_Passive, ids.Havoc_Form, ids.Havoc_Buff, ids.Havoc_Debuff, ids.Havoc_PetAbility, ids.Havoc_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP	= ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size	= GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Fury, _Fury_Max, _Fury_Percent = ConRO:PlayerPower('Fury');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _BladeDance, _BladeDance_RDY, _BladeDance_CD = ConRO:AbilityReady(Ability.BladeDance, timeShift);
		local _DeathSweep, _, _DeathSweep_CD = ConRO:AbilityReady(Ability.DeathSweep, timeShift);
	local _ChaosStrike, _ChaosStrike_RDY = ConRO:AbilityReady(Ability.ChaosStrike, timeShift);
		local _Annihilation, _, _Annihilation_CD = ConRO:AbilityReady(Ability.Annihilation, timeShift);
	local _ConsumeMagic, _ConsumeMagic_RDY = ConRO:AbilityReady(Ability.ConsumeMagic, timeShift);
	local _DemonsBite, _DemonsBite_RDY = ConRO:AbilityReady(Ability.DemonsBite, timeShift);
	local _Disrupt, _Disrupt_RDY = ConRO:AbilityReady(Ability.Disrupt, timeShift);
		local _, _Disrupt_RANGE = ConRO:Targets(Ability.Disrupt);
	local _EyeBeam, _EyeBeam_RDY = ConRO:AbilityReady(Ability.EyeBeam, timeShift);
	local _FelRush, _FelRush_RDY, _FelRush_CD = ConRO:AbilityReady(Ability.FelRush, timeShift);
		local _FelRush_CHARGES, _, _FelRush_CCD = ConRO:SpellCharges(_FelRush);
		local _Momentum_BUFF = ConRO:Aura(Buff.Momentum, timeShift);
		local _InnerDemon_BUFF = ConRO:Form(Buff.InnerDemon);
	local _ImmolationAura, _ImmolationAura_RDY = ConRO:AbilityReady(Ability.ImmolationAura, timeShift);
	local _Metamorphosis, _Metamorphosis_RDY, _Metamorphosis_CD = ConRO:AbilityReady(Ability.Metamorphosis, timeShift);
		local _Metamorphosis_BUFF, _, _Metamorphosis_DUR = ConRO:Aura(Buff.Metamorphosis, timeShift);
	local _ThrowGlaive, _ThrowGlaive_RDY = ConRO:AbilityReady(Ability.ThrowGlaive, timeShift);
		local _ThrowGlaive_CHARGES = ConRO:SpellCharges(_ThrowGlaive);
		local _, _ThrowGlaive_RANGE = ConRO:Targets(Ability.ThrowGlaive);
	local _VengefulRetreat, _VengefulRetreat_RDY = ConRO:AbilityReady(Ability.VengefulRetreat, timeShift);
		local _Initiative_BUFF = ConRO:Aura(Buff.Initiative, timeShift);
	local _EssenceBreak, _EssenceBreak_RDY = ConRO:AbilityReady(Ability.EssenceBreak, timeShift);
	local _FelBarrage, _FelBarrage_RDY = ConRO:AbilityReady(Ability.FelBarrage, timeShift);
	local _FelEruption, _FelEruption_RDY = ConRO:AbilityReady(Ability.FelEruption, timeShift);
	local _Felblade, _Felblade_RDY = ConRO:AbilityReady(Ability.Felblade, timeShift);
		local _, _Felblade_RANGE = ConRO:Targets(Ability.Felblade);
	local _GlaiveTempest, _GlaiveTempest_RDY = ConRO:AbilityReady(Ability.GlaiveTempest, timeShift);

	local _ElysianDecree, _ElysianDecree_RDY = ConRO:AbilityReady(Ability.ElysianDecree, timeShift);
	local _TheHunt, _TheHunt_RDY = ConRO:AbilityReady(Ability.TheHunt, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

		if _Metamorphosis_BUFF then
			_ChaosStrike_RDY = _ChaosStrike_RDY and _Annihilation_CD <= 0;
			_ChaosStrike = _Annihilation;
			_BladeDance_RDY = _BladeDance_RDY and _DeathSweep_CD <= 0;
			_BladeDance = _DeathSweep;
		end

--Indicators
	ConRO:AbilityInterrupt(_Disrupt, _Disrupt_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ConsumeMagic, _ConsumeMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_FelRush, _FelRush_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_Felblade, _Felblade_RDY and _Felblade_RANGE and not _target_in_melee);

	ConRO:AbilityBurst(_VengefulRetreat, _VengefulRetreat_RDY and tChosen[Passive.Initiative.talentID] and not _Initiative_BUFF and ConRO:BurstMode(_VengefulRetreat, 120));
	ConRO:AbilityBurst(_Metamorphosis, _Metamorphosis_RDY and not _Metamorphosis_BUFF and not _EyeBeam_RDY and _Fury >= 100 and ConRO:BurstMode(_Metamorphosis));
	ConRO:AbilityBurst(_FelBarrage, _FelBarrage_RDY and _Disrupt_RANGE and ConRO:BurstMode(_FelBarrage));

	ConRO:AbilityBurst(_TheHunt, _TheHunt_RDY and ConRO:BurstMode(_TheHunt));
	ConRO:AbilityBurst(_ElysianDecree, _ElysianDecree_RDY and ConRO:BurstMode(_ElysianDecree));

--Rotations
		if select(8, UnitChannelInfo("player")) == _FelBarrage then --Do not break cast
			tinsert(ConRO.SuggestedSpells, _FelBarrage);
		end

		if select(8, UnitChannelInfo("player")) == _EyeBeam then -- Do not break cast
			tinsert(ConRO.SuggestedSpells, _EyeBeam);
		end

		if not _in_combat then
			if _ImmolationAura_RDY then
				tinsert(ConRO.SuggestedSpells, _ImmolationAura);
				_ImmolationAura_RDY = false;
			end

			if _Felblade_RDY and _Fury < 80 then
				tinsert(ConRO.SuggestedSpells, _Felblade);
				_Felblade_RDY = false;
			end

			if _FelRush_RDY and _FelRush_CHARGES >= 1 and not _target_in_melee then
				tinsert(ConRO.SuggestedSpells, _FelRush);
				_FelRush_RDY = false;
			end

			if _EyeBeam_RDY and currentSpell ~= _EyeBeam and _Felblade_RANGE then
				tinsert(ConRO.SuggestedSpells, _EyeBeam);
				_EyeBeam_RDY = false;
			end
		end

		if _Metamorphosis_RDY and not _Metamorphosis_BUFF and (not _EyeBeam_RDY) and ConRO:FullMode(_Metamorphosis) then
			tinsert(ConRO.SuggestedSpells, _Metamorphosis);
			_Metamorphosis_RDY = false;
		end

		if _FelRush_RDY and _FelRush_CHARGES >= 1 and _UnboundChaos_BUFF then
			tinsert(ConRO.SuggestedSpells, _FelRush);
			_UnboundChaos_BUFF = false;
		end

		if _EyeBeam_RDY and currentSpell ~= _EyeBeam and _Felblade_RANGE then
			tinsert(ConRO.SuggestedSpells, _EyeBeam);
			_EyeBeam_RDY = false;
		end

		if _VengefulRetreat_RDY and tChosen[Passive.Initiative.talentID] and not _Initiative_BUFF and ConRO:FullMode(_VengefulRetreat, 120) then
			tinsert(ConRO.SuggestedSpells, _VengefulRetreat);
			_VengefulRetreat_RDY = false;
		end

		if _EssenceBreak_RDY and _Disrupt_RANGE then
			tinsert(ConRO.SuggestedSpells, _EssenceBreak);
			_EssenceBreak_RDY = false;
		end

		if _BladeDance_RDY and _Disrupt_RANGE then
			tinsert(ConRO.SuggestedSpells, _BladeDance);
			_BladeDance_RDY = false;
		end

		if _FelRush_RDY and tChosen[Passive.Momentum.talentID] and (_FelRush_CHARGES == 2 or not _Momentum_BUFF) then
			tinsert(ConRO.SuggestedSpells, _FelRush);
			_FelRush_RDY = false;
		end

		if _ThrowGlaive_RDY and _ThrowGlaive_RANGE and not _target_in_melee and _ThrowGlaive_CHARGES == 2 and tChosen[Passive.Soulrend.talentID] and tChosen[Passive.FuriousThrows.talentID] then
			tinsert(ConRO.SuggestedSpells, _ThrowGlaive);
			_ThrowGlaive_CHARGES = _ThrowGlaive_CHARGES - 1;
		end

		if _TheHunt_RDY and ConRO:FullMode(_TheHunt) then
			tinsert(ConRO.SuggestedSpells, _TheHunt);
			_TheHunt_RDY = false;
		end

		if _ElysianDecree_RDY and ConRO:FullMode(_ElysianDecree) then
			tinsert(ConRO.SuggestedSpells, _ElysianDecree);
			_ElysianDecree_RDY = false;
		end

		if _GlaiveTempest_RDY and _target_in_melee then
			tinsert(ConRO.SuggestedSpells, _GlaiveTempest);
			_GlaiveTempest_RDY = false;
		end

		if _ImmolationAura_RDY then
			tinsert(ConRO.SuggestedSpells, _ImmolationAura);
			_ImmolationAura_RDY = false;
		end

		if _Felblade_RDY and _Fury < 80 then
			tinsert(ConRO.SuggestedSpells, _Felblade);
		end

		if _ChaosStrike_RDY and _Fury >= 50 and _target_in_melee then
			tinsert(ConRO.SuggestedSpells, _ChaosStrike);
			_Fury = _Fury - 40;
		end

		if _SigilofFlame_RDY and _Fury < 40 then
			tinsert(ConRO.SuggestedSpells, _SigilofFlame);
			_SigilofFlame_RDY = false;
		end

		if tChosen[Passive.DemonBlades.talentID] then
			if _FelRush_RDY and _FelRush_CHARGES >= 1 then
				tinsert(ConRO.SuggestedSpells, _FelRush);
				_FelRush_CHARGES = _FelRush_CHARGES - 1;
			end

			if _ThrowGlaive_RDY and _ThrowGlaive_CHARGES >= 1 then
				tinsert(ConRO.SuggestedSpells, _ThrowGlaive);
				_ThrowGlaive_CHARGES = _ThrowGlaive_CHARGES - 1;
			end
		else
			if _DemonsBite_RDY then
				tinsert(ConRO.SuggestedSpells, _DemonsBite);
			end
		end
	return nil;
end

function ConRO.DemonHunter.HavocDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Havoc_Ability, ids.Havoc_Passive, ids.Havoc_Form, ids.Havoc_Buff, ids.Havoc_Debuff, ids.Havoc_PetAbility, ids.Havoc_PvPTalent, ids.Glyph;
--Info
	local _Player_Level	= UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC	= UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Fury, _Fury_Max, _Fury_Percent	= ConRO:PlayerPower('Fury');

--Abilities
	local _Blur, _Blur_RDY	= ConRO:AbilityReady(Ability.Blur, timeShift);
	local _Netherwalk, _Netherwalk_RDY	= ConRO:AbilityReady(Ability.Netherwalk, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations
		if _Netherwalk_RDY and _Player_Percent_Health <= 25 then
			tinsert(ConRO.SuggestedDefSpells, _Netherwalk);
		end

		if _Blur_RDY then
			tinsert(ConRO.SuggestedDefSpells, _Blur);
		end
	return nil;
end

function ConRO.DemonHunter.Vengeance(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ven_Ability, ids.Ven_Passive, ids.Ven_Form, ids.Ven_Buff, ids.Ven_Debuff, ids.Ven_PetAbility, ids.Ven_PvPTalent, ids.Glyph;
--Info
	local _Player_Level	= UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Fury, _Fury_Max, _Fury_Percent = ConRO:PlayerPower('Fury');
	local _, _SoulFragments = ConRO:Form(ids.Ven_Form.SoulFragments);

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _ConsumeMagic, _ConsumeMagic_RDY = ConRO:AbilityReady(Ability.ConsumeMagic, timeShift);
	local _Disrupt, _Disrupt_RDY = ConRO:AbilityReady(Ability.Disrupt, timeShift);
	local _ElysianDecree, _ElysianDecree_RDY = ConRO:AbilityReady(Ability.ElysianDecree, timeShift);
--		local _ElysianDecreeCS, _ElysianDecreeCS_RDY = ConRO:AbilityReady(Ability.ElysianDecreeCS, timeShift);
	local _FelDevastation, _FelDevastation_RDY = ConRO:AbilityReady(Ability.FelDevastation, timeShift);
	local _Felblade, _Felblade_RDY = ConRO:AbilityReady(Ability.Felblade, timeShift);
		local _, _Felblade_RANGE = ConRO:Targets(Ability.Felblade);
	local _Fracture, _Fracture_RDY = ConRO:AbilityReady(Ability.Fracture, timeShift);
		local _Fracture_CHARGES, _, _Fracture_CCD = ConRO:SpellCharges(_Fracture);
	local _ImmolationAura, _ImmolationAura_RDY = ConRO:AbilityReady(Ability.ImmolationAura, timeShift);
	local _InfernalStrike, _InfernalStrike_RDY = ConRO:AbilityReady(Ability.InfernalStrike, timeShift);
		local _InfernalStrike_CHARGES, _, _InfernalStrike_CHARGES_CD = ConRO:SpellCharges(_InfernalStrike);
	local _Metamorphosis, _Metamorphosis_RDY = ConRO:AbilityReady(Ability.Metamorphosis, timeShift);
		local _Metamorphosis_BUFF = ConRO:Aura(Buff.Metamorphosis, timeShift);
	local _Shear, _Shear_RDY = ConRO:AbilityReady(Ability.Shear, timeShift);
	local _SigilofFlame, _SigilofFlame_RDY = ConRO:AbilityReady(Ability.SigilofFlame, timeShift);
	local _SigilofFlameCS, _SigilofFlameCS_RDY = ConRO:AbilityReady(Ability.SigilofFlameCS, timeShift);
		local _SigilofFlame_DEBUFF = ConRO:TargetAura(Debuff.SigilofFlame, timeShift);
	local _SpiritBomb, _SpiritBomb_RDY = ConRO:AbilityReady(Ability.SpiritBomb, timeShift);
		local _Frailty_DEBUFF, _Frailty_COUNT = ConRO:TargetAura(Debuff.Frailty, timeShift + 3);
	local _SoulCarver, _SoulCarver_RDY = ConRO:AbilityReady(Ability.SoulCarver, timeShift);
	local _SoulCleave, _SoulCleave_RDY = ConRO:AbilityReady(Ability.SoulCleave, timeShift);
	local _TheHunt, _TheHunt_RDY = ConRO:AbilityReady(Ability.TheHunt, timeShift);
	local _ThrowGlaive, _ThrowGlaive_RDY = ConRO:AbilityReady(Ability.ThrowGlaive, timeShift);
		local _, _ThrowGlaive_RANGE = ConRO:Targets(Ability.ThrowGlaive);
	local _Torment, _Torment_RDY = ConRO:AbilityReady(Ability.Torment, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

	if tChosen[Passive.ConcentratedSigils.talentID] then
		_SigilofFlame_RDY = _SigilofFlameCS_RDY;
		_SigilofFlame = _SigilofFlameCS;
	--	_ElysianDecree_RDY = _ElysianDecreeCS_RDY;
		--_ElysianDecree = _ElysianDecreeCS;
	end

--Indicators
	ConRO:AbilityInterrupt(_Disrupt, _Disrupt_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ConsumeMagic, _ConsumeMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_InfernalStrike, _InfernalStrike_RDY and not _target_in_melee);

	ConRO:AbilityTaunt(_Torment, _Torment_RDY);

	ConRO:AbilityBurst(_FelDevastation, _FelDevastation_RDY and _Fury >= 50 and ConRO:BurstMode(_FelDevastation));
	ConRO:AbilityBurst(_ElysianDecree, _ElysianDecree_RDY and ConRO:BurstMode(_ElysianDecree));
	ConRO:AbilityBurst(_SoulCarver, _SoulCarver_RDY and ConRO:BurstMode(_SoulCarver));
	ConRO:AbilityBurst(_TheHunt, _TheHunt_RDY and ConRO:BurstMode(_TheHunt));

--Rotations
		if not _target_in_melee then
			if _ThrowGlaive_RDY and _ThrowGlaive_RANGE then
				tinsert(ConRO.SuggestedSpells, _ThrowGlaive);
			elseif _Felblade_RDY and _Felblade_RANGE then
				tinsert(ConRO.SuggestedSpells, _Felblade);
				_Felblade_RDY = false;
			end
		end

		if _InfernalStrike_RDY and (_InfernalStrike_CHARGES == 2 or (_InfernalStrike_CHARGES >= 1 and _InfernalStrike_CHARGES_CD < 3)) then
			tinsert(ConRO.SuggestedSpells, _InfernalStrike);
			_InfernalStrike_CHARGES = _InfernalStrike_CHARGES - 1;
		end

		if _FelDevastation_RDY and _Fury >= 50 and ConRO:FullMode(_FelDevastation) then
			tinsert(ConRO.SuggestedSpells, _FelDevastation);
			_FelDevastation_RDY = false;
		end

		if _ImmolationAura_RDY and _Fury <= (_Fury_Max - 25) and _SoulFragments <= 4 then
			tinsert(ConRO.SuggestedSpells, _ImmolationAura);
			_ImmolationAura_RDY = false;
		end

		if _Fracture_RDY and ((_SoulFragments <= 3 and _Fury <= _Fury_Max - 25) or _Fracture_CHARGES == 2 or (_Fracture_CHARGES == 1 and _Fracture_CCD <= 1)) then
			tinsert(ConRO.SuggestedSpells, _Fracture);
			_Fracture_CHARGES = _Fracture_CHARGES - 1;
		end

		if _Shear_RDY and not tChosen[Ability.Fracture.talentID] and (_Fury <= _Fury_Max - 10) and _SoulFragments <= 4 then
			tinsert(ConRO.SuggestedSpells, _Shear);
		end

		if _SigilofFlame_RDY  then
			tinsert(ConRO.SuggestedSpells, _SigilofFlame);
			_SigilofFlame_RDY = false;
		end

		if _SpiritBomb_RDY and _SoulFragments >= 4 then
			tinsert(ConRO.SuggestedSpells, _SpiritBomb);
			_SoulFragments = _SoulFragments - 5;
		end

		if _SoulCleave_RDY and (_SoulFragments <= 0 or not tChosen[Ability.SpiritBomb.talentID]) and (_Player_Percent_Health  <= 80 or (_Fury >= _Fury_Max - 10)) then
			tinsert(ConRO.SuggestedSpells, _SoulCleave);
			_Fury = _Fury - 30;
			_SoulFragments = _SoulFragments - 2;
		end

		if _ElysianDecree_RDY and _Frailty_COUNT >= 3 and ConRO:FullMode(_ElysianDecree) then
			tinsert(ConRO.SuggestedSpells, _ElysianDecree);
			_ElysianDecree_RDY = false;
		end

		if _TheHunt_RDY and _Frailty_COUNT >= 3 and ConRO:FullMode(_TheHunt) then
			tinsert(ConRO.SuggestedSpells, _TheHunt);
			_TheHunt_RDY = false;
		end

		if _SoulCarver_RDY and _Frailty_COUNT >= 6 and ConRO:FullMode(_SoulCarver) then
			tinsert(ConRO.SuggestedSpells, _SoulCarver);
			_SoulCarver_RDY = false;
		end

		if _Felblade_RDY then
			tinsert(ConRO.SuggestedSpells, _Felblade);
			_Felblade_RDY = false;
		end

		if _ThrowGlaive_RDY then
			tinsert(ConRO.SuggestedSpells, _ThrowGlaive);
		end
	return nil;
end

function ConRO.DemonHunter.VengeanceDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ven_Ability, ids.Ven_Passive, ids.Ven_Form, ids.Ven_Buff, ids.Ven_Debuff, ids.Ven_PetAbility, ids.Ven_PvPTalent, ids.Glyph;
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
	local _Fury, _Fury_Max, _Fury_Percent = ConRO:PlayerPower('Fury');
	local _, _SoulFragments = ConRO:Form(Form.SoulFragments);

--Abilities
	local _DemonSpikes, _DemonSpikes_RDY = ConRO:AbilityReady(Ability.DemonSpikes, timeShift);
		local _DemonSpikes_CHARGES, _DemonSpikes_MAX_CHARGES = ConRO:SpellCharges(_DemonSpikes);
		local _DemonSpikes_BUFF = ConRO:Aura(Buff.DemonSpikes, timeShift);
	local _FieryBrand, _FieryBrand_RDY = ConRO:AbilityReady(Ability.FieryBrand, timeShift);
		local _FieryBrand_DEBUFF = ConRO:TargetAura(Debuff.FieryBrand, timeShift);
	local _Metamorphosis, _Metamorphosis_RDY = ConRO:AbilityReady(Ability.Metamorphosis, timeShift);
		local _Metamorphosis_BUFF = ConRO:Aura(Buff.Metamorphosis, timeShift);

	local _SoulBarrier, _SoulBarrier_RDY = ConRO:AbilityReady(Ability.SoulBarrier, timeShift);
		local _SoulBarrier_BUFF = ConRO:Aura(Buff.SoulBarrier, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations
		if _DemonSpikes_RDY and _DemonSpikes_CHARGES == _DemonSpikes_MAX_CHARGES then
			tinsert(ConRO.SuggestedDefSpells, _DemonSpikes);
		end

		if _SoulBarrier_RDY and _SoulFragments >= 5 and not _FieryBrand_DEBUFF then
			tinsert(ConRO.SuggestedDefSpells, _SoulBarrier);
		end

		if _FieryBrand_RDY and not _SoulBarrier_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _FieryBrand);
		end

		if _DemonSpikes_RDY and not (_Metamorphosis_BUFF or _FieryBrand_DEBUFF) then
			tinsert(ConRO.SuggestedDefSpells, _DemonSpikes);
		end

		if _Metamorphosis_RDY and not _Metamorphosis_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _Metamorphosis);
		end
	return nil;
end
