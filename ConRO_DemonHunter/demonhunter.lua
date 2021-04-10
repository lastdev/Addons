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

function ConRO.DemonHunter.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.DemonHunter.Havoc(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Fury, _Fury_Max, _Fury_Percent																= ConRO:PlayerPower('Fury');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities
	local _BladeDance, _BladeDance_RDY, _BladeDance_CD 													= ConRO:AbilityReady(ids.Havoc_Ability.BladeDance, timeShift);
		local _DeathSweep, _, _DeathSweep_CD 																	= ConRO:AbilityReady(ids.Havoc_Ability.DeathSweep, timeShift);
	local _ChaosStrike, _ChaosStrike_RDY 																= ConRO:AbilityReady(ids.Havoc_Ability.ChaosStrike, timeShift);
		local _Annihilation, _, _Annihilation_CD																= ConRO:AbilityReady(ids.Havoc_Ability.Annihilation, timeShift);	
	local _ConsumeMagic, _ConsumeMagic_RDY																= ConRO:AbilityReady(ids.Havoc_Ability.ConsumeMagic, timeShift);
	local _DemonsBite, _DemonsBite_RDY 																	= ConRO:AbilityReady(ids.Havoc_Ability.DemonsBite, timeShift);
	local _Disrupt, _Disrupt_RDY																		= ConRO:AbilityReady(ids.Havoc_Ability.Disrupt, timeShift);
		local _, _Disrupt_RANGE 																			= ConRO:Targets(ids.Havoc_Ability.Disrupt);
	local _EyeBeam, _EyeBeam_RDY 																		= ConRO:AbilityReady(ids.Havoc_Ability.EyeBeam, timeShift);
	local _FelRush, _FelRush_RDY, _FelRush_CD															= ConRO:AbilityReady(ids.Havoc_Ability.FelRush, timeShift);
		local _FelRush_CHARGES, _, _FelRush_CCD																= ConRO:SpellCharges(ids.Havoc_Ability.FelRush);								
		local _Momentum_BUFF 																				= ConRO:Aura(ids.Havoc_Buff.Momentum, timeShift);
		local _InnerDemon_BUFF																				= ConRO:Form(ids.Havoc_Buff.InnerDemon);
	local _ImmolationAura, _ImmolationAura_RDY															= ConRO:AbilityReady(ids.Havoc_Ability.ImmolationAura, timeShift);
	local _Metamorphosis, _Metamorphosis_RDY, _Metamorphosis_CD											= ConRO:AbilityReady(ids.Havoc_Ability.Metamorphosis, timeShift);
		local _Metamorphosis_BUFF, _, _Metamorphosis_DUR													= ConRO:Aura(ids.Havoc_Buff.Metamorphosis, timeShift);
	local _ThrowGlaive, _ThrowGlaive_RDY	  															= ConRO:AbilityReady(ids.Havoc_Ability.ThrowGlaive, timeShift);
		local _ThrowGlaive_CHARGES																			= ConRO:SpellCharges(ids.Havoc_Ability.ThrowGlaive);
		local _, _ThrowGlaive_RANGE 																		= ConRO:Targets(ids.Havoc_Ability.ThrowGlaive);
	local _VengefulRetreat, _VengefulRetreat_RDY 														= ConRO:AbilityReady(ids.Havoc_Ability.VengefulRetreat, timeShift);

	local _EssenceBreak, _EssenceBreak_RDY																= ConRO:AbilityReady(ids.Havoc_Talent.EssenceBreak, timeShift);	
	local _FelBarrage, _FelBarrage_RDY 																	= ConRO:AbilityReady(ids.Havoc_Talent.FelBarrage, timeShift);
	local _FelEruption, _FelEruption_RDY 																= ConRO:AbilityReady(ids.Havoc_Talent.FelEruption, timeShift);
	local _Felblade, _Felblade_RDY 																		= ConRO:AbilityReady(ids.Havoc_Talent.Felblade, timeShift);
		local _, _Felblade_RANGE 																			= ConRO:Targets(ids.Havoc_Talent.Felblade);
	local _GlaiveTempest, _GlaiveTempest_RDY															= ConRO:AbilityReady(ids.Havoc_Talent.GlaiveTempest, timeShift);
	
	local _ElysianDecree, _ElysianDecree_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.ElysianDecree, timeShift);
	local _FoddertotheFlame, _FoddertotheFlame_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.FoddertotheFlame, timeShift);
	local _SinfulBrand, _SinfulBrand_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.SinfulBrand, timeShift);
		local _SinfulBrand_DEBUFF																			= ConRO:TargetAura(ids.Covenant_Debuff.SinfulBrand, timeShift);	
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _TheHunt, _TheHunt_RDY																		= ConRO:AbilityReady(ids.Covenant_Ability.TheHunt, timeShift);

		local _FelBombardment_BUFF, _FelBombardment_COUNT													= ConRO:Aura(ids.Legendary_Buff.FelBombardment, timeShift);
	local _ChaosTheory_EQUIPPED																			= ConRO:ItemEquipped(ids.Legendary.ChaosTheory_Hands) or ConRO:ItemEquipped(ids.Legendary.ChaosTheory_Waist);
		local _ChaoticBlades_BUFF																			= ConRO:Aura(ids.Legendary_Buff.ChaoticBlades, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

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
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_Metamorphosis, _Metamorphosis_RDY and not _Metamorphosis_BUFF and not _EyeBeam_RDY and _Fury >= 100 and ConRO:BurstMode(_Metamorphosis));
	ConRO:AbilityBurst(_FelBarrage, _FelBarrage_RDY and _Disrupt_RANGE and ConRO:BurstMode(_FelBarrage));
	
	ConRO:AbilityBurst(_TheHunt, _TheHunt_RDY and ConRO:BurstMode(_TheHunt));
	ConRO:AbilityBurst(_FoddertotheFlame, _FoddertotheFlame_RDY and ConRO:BurstMode(_FoddertotheFlame));
	ConRO:AbilityBurst(_SinfulBrand, _SinfulBrand_RDY and not _SinfulBrand_DEBUFF and ConRO:BurstMode(_SinfulBrand));
	ConRO:AbilityBurst(_ElysianDecree, _ElysianDecree_RDY and ConRO:BurstMode(_ElysianDecree));
	
--Rotations

	if select(8, UnitChannelInfo("player")) == _FelBarrage then --Do not break cast
		return _FelBarrage;
	end
	
	if select(8, UnitChannelInfo("player")) == _EyeBeam then -- Do not break cast
		return _EyeBeam;
	end
	
	if not _in_combat then
		if _ImmolationAura_RDY then
			return _ImmolationAura;
		end	

		if _Metamorphosis_RDY and not _Metamorphosis_BUFF and ConRO:FullMode(_Metamorphosis) then
			return _Metamorphosis;
		end
	end

	if _Metamorphosis_RDY and not _Metamorphosis_BUFF and ConRO:FullMode(_Metamorphosis) then
		return _Metamorphosis;
	end

	if _ThrowGlaive_RDY and _FelBombardment_COUNT >= 5 then
		return _ThrowGlaive;
	end
	
	if _SinfulBrand_RDY and not _SinfulBrand_DEBUFF and ConRO:FullMode(_SinfulBrand) then
		return _SinfulBrand;
	end		
	
	if _TheHunt_RDY and ConRO:FullMode(_TheHunt) then
		return _TheHunt;
	end	

	if _FoddertotheFlame_RDY and ConRO:FullMode(_FoddertotheFlame) then
		return _FoddertotheFlame;
	end

	if _ElysianDecree_RDY and ConRO:FullMode(_ElysianDecree) then
		return _ElysianDecree;
	end

	if _EssenceBreak_RDY and _Fury >= 80 and _Disrupt_RANGE then
		return _EssenceBreak;
	end	
	
	if _VengefulRetreat_RDY and _target_in_melee and _FelRush_CHARGES >= 1 and ((tChosen[ids.Havoc_Talent.Momentum] and not _Momentum_BUFF) or _InnerDemon_BUFF) then
		return _VengefulRetreat;
	end
	
	if _FelRush_RDY and _InnerDemon_BUFF or (tChosen[ids.Havoc_Talent.Momentum] and not _Momentum_BUFF) then
		return _FelRush;
	end

	if _FelBarrage_RDY and _Disrupt_RANGE and ConRO:FullMode(_FelBarrage) then
		return _FelBarrage;
	end

	if _ThrowGlaive_RDY and _ThrowGlaive_RANGE and not _target_in_melee then
		return _ThrowGlaive;
	end	
	
	if _BladeDance_RDY and _Metamorphosis_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() or tChosen[ids.Havoc_Talent.FirstBlood] or _ChaosTheory_EQUIPPED) then
		return _BladeDance;
	end
	
	if _GlaiveTempest_RDY then
		return _GlaiveTempest;
	end	
	
	if _EyeBeam_RDY and (not tChosen[ids.Havoc_Talent.BlindFury] or (tChosen[ids.Havoc_Talent.BlindFury] and _Fury <= 50)) and (not tChosen[ids.Havoc_Talent.Demonic] or (tChosen[ids.Havoc_Talent.Demonic] and (_BladeDance_RDY or _BladeDance_CD <= 2.5))) and currentSpell ~= _EyeBeam then
		return _EyeBeam;
	end	

	if _ImmolationAura_RDY then
		return _ImmolationAura;
	end	
	
	if _BladeDance_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) or (ConRO_AutoButton:IsVisible() and tChosen[ids.Havoc_Talent.TrailofRuin] and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() or tChosen[ids.Havoc_Talent.FirstBlood] or _ChaosTheory_EQUIPPED) then
		return _BladeDance;
	end	

	if _Felblade_RDY and _Fury < 80 then
		return _Felblade;
	end

	if _ChaosStrike_RDY and (_Fury >= 50 or _ChaoticBlades_BUFF) then
		return _ChaosStrike;
	end
	
	if tChosen[ids.Havoc_Talent.DemonBlades] then
		if _ThrowGlaive_RDY then
			return _ThrowGlaive;
		end
	else
		if _DemonsBite_RDY then
			return _DemonsBite;
		end
	end
return nil;
end

function ConRO.DemonHunter.HavocDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Fury, _Fury_Max, _Fury_Percent																= ConRO:PlayerPower('Fury');
	
--Abilities
	local _Blur, _Blur_RDY																				= ConRO:AbilityReady(ids.Havoc_Ability.Blur, timeShift);
	
	local _Netherwalk, _Netherwalk_RDY																	= ConRO:AbilityReady(ids.Havoc_Talent.Netherwalk, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY	 																= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY	 													= ConRO:AbilityReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end

	if _Netherwalk_RDY and _Player_Percent_Health <= 25 then
		return _Netherwalk;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Blur_RDY and _Player_Percent_Health <= 75 then
		return _Blur;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.DemonHunter.Vengeance(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Fury, _Fury_Max, _Fury_Percent																= ConRO:PlayerPower('Fury');
	local _, _SoulFragments																				= ConRO:Form(ids.Ven_Form.SoulFragments);
	
--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local _ConsumeMagic, _ConsumeMagic_RDY																= ConRO:AbilityReady(ids.Ven_Ability.ConsumeMagic, timeShift);
	local _Disrupt, _Disrupt_RDY																		= ConRO:AbilityReady(ids.Ven_Ability.Disrupt, timeShift);
	local _FelDevastation, _FelDevastation_RDY															= ConRO:AbilityReady(ids.Ven_Ability.FelDevastation, timeShift);
	local _ImmolationAura, _ImmolationAura_RDY															= ConRO:AbilityReady(ids.Ven_Ability.ImmolationAura, timeShift);
	local _InfernalStrike, _InfernalStrike_RDY															= ConRO:AbilityReady(ids.Ven_Ability.InfernalStrike, timeShift);
		local _InfernalStrike_CHARGES, _, _InfernalStrike_CHARGES_CD										= ConRO:SpellCharges(ids.Ven_Ability.InfernalStrike);
	local _Metamorphosis, _Metamorphosis_RDY															= ConRO:AbilityReady(ids.Ven_Ability.Metamorphosis, timeShift);
		local _Metamorphosis_BUFF																			= ConRO:Aura(ids.Ven_Buff.Metamorphosis, timeShift);
	local _Shear, _Shear_RDY																			= ConRO:AbilityReady(ids.Ven_Ability.Shear, timeShift);
	local _SigilofFlame, _SigilofFlame_RDY																= ConRO:AbilityReady(ids.Ven_Ability.SigilofFlame, timeShift);
	local _SigilofFlameCS, _SigilofFlameCS_RDY															= ConRO:AbilityReady(ids.Ven_Talent.SigilofFlame, timeShift);
		local _SigilofFlame_DEBUFF																			= ConRO:TargetAura(ids.Ven_Debuff.SigilofFlame, timeShift);
	local _SoulCleave, _SoulCleave_RDY																	= ConRO:AbilityReady(ids.Ven_Ability.SoulCleave, timeShift);	
	local _ThrowGlaive, _ThrowGlaive_RDY																= ConRO:AbilityReady(ids.Ven_Ability.ThrowGlaive, timeShift);
		local _, _ThrowGlaive_RANGE 																		= ConRO:Targets(ids.Ven_Ability.ThrowGlaive);
	local _Torment, _Torment_RDY																		= ConRO:AbilityReady(ids.Ven_Ability.Torment, timeShift);

	local _Felblade, _Felblade_RDY																		= ConRO:AbilityReady(ids.Ven_Talent.Felblade, timeShift);
		local _, _Felblade_RANGE 																			= ConRO:Targets(ids.Ven_Talent.Felblade);	
	local _Fracture, _Fracture_RDY																		= ConRO:AbilityReady(ids.Ven_Talent.Fracture, timeShift);
		local _Fracture_CHARGES, _, _Fracture_CCD															= ConRO:SpellCharges(ids.Ven_Talent.Fracture);
	local _SpiritBomb, _SpiritBomb_RDY																	= ConRO:AbilityReady(ids.Ven_Talent.SpiritBomb, timeShift);
		local _Frailty_DEBUFF																				= ConRO:TargetAura(ids.Ven_Debuff.Frailty, timeShift + 3);

	local _Kyrian_CHOSEN																				= ConRO:CovenantChosen(ids.Covenant.Kyrian);
	local _ElysianDecree, _ElysianDecree_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.ElysianDecree, timeShift);
	local _ElysianDecreeCS, _ElysianDecreeCS_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.ElysianDecreeCS, timeShift);
	local _FoddertotheFlame, _FoddertotheFlame_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.FoddertotheFlame, timeShift);
	local _SinfulBrand, _SinfulBrand_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.SinfulBrand, timeShift);
		local _SinfulBrand_DEBUFF																			= ConRO:TargetAura(ids.Covenant_Debuff.SinfulBrand, timeShift);	
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _TheHunt, _TheHunt_RDY																		= ConRO:AbilityReady(ids.Covenant_Ability.TheHunt, timeShift);
	
		local _FelBombardment_BUFF, _FelBombardment_COUNT													= ConRO:Aura(ids.Legendary_Buff.FelBombardment, timeShift);
	local _RazelikhsDefilement_EQUIPPED																	= ConRO:ItemEquipped(ids.Legendary.RazelikhsDefilement_Legs) or ConRO:ItemEquipped(ids.Legendary.RazelikhsDefilement_Wrist);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	if tChosen[ids.Ven_Talent.ConcentratedSigils] then
		_SigilofFlame_RDY = _SigilofFlameCS_RDY;
		_SigilofFlame = _SigilofFlameCS;
		_ElysianDecree_RDY = _ElysianDecreeCS_RDY;
		_ElysianDecree = _ElysianDecreeCS;
	end
	
--Indicators
	ConRO:AbilityInterrupt(_Disrupt, _Disrupt_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ConsumeMagic, _ConsumeMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_InfernalStrike, _InfernalStrike_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);

	ConRO:AbilityTaunt(_Torment, _Torment_RDY);

	ConRO:AbilityBurst(_FelDevastation, _FelDevastation_RDY and _Fury >= 50 and ConRO:BurstMode(_FelDevastation));

	ConRO:AbilityBurst(_ElysianDecree, _ElysianDecree_RDY and ConRO:BurstMode(_ElysianDecree));
	ConRO:AbilityBurst(_SinfulBrand, _SinfulBrand_RDY and not _SinfulBrand_DEBUFF and ConRO:BurstMode(_SinfulBrand));
	ConRO:AbilityBurst(_FoddertotheFlame, _FoddertotheFlame_RDY and ConRO:BurstMode(_FoddertotheFlame));
	ConRO:AbilityBurst(_TheHunt, _TheHunt_RDY and ConRO:BurstMode(_TheHunt));
	
--Rotations
	if not _target_in_melee then
		if _ThrowGlaive_RDY and _ThrowGlaive_RANGE then
			return _ThrowGlaive;
		elseif _Felblade_RDY and _Felblade_RANGE then
			return _Felblade;
		end
	end

	if _InfernalStrike_RDY and tChosen[ids.Ven_Talent.AbyssalStrike] and not _SigilofFlame_DEBUFF and (_InfernalStrike_CHARGES == 2 or (_InfernalStrike_CHARGES == 1 and _InfernalStrike_CHARGES_CD <= 1)) and ConRO.lastSpellId ~= _InfernalStrike and ConRO.lastSpellId ~= _SigilofFlame then
		return _InfernalStrike;
	end

	if _ThrowGlaive_RDY and _FelBombardment_COUNT >= 5 then
		return _ThrowGlaive;
	end
	
	if _ElysianDecree_RDY and ConRO:FullMode(_ElysianDecree) then
		return _ElysianDecree;
	end
	
	if _SinfulBrand_RDY and not _SinfulBrand_DEBUFF and ConRO:FullMode(_SinfulBrand) then
		return _SinfulBrand;
	end		

	if _FoddertotheFlame_RDY and ConRO:FullMode(_FoddertotheFlame) then
		return _FoddertotheFlame;
	end
	
	if _TheHunt_RDY and ConRO:FullMode(_FoddertotheFlame) then
		return _TheHunt;
	end
	
	if _SpiritBomb_RDY and _SoulFragments >= 4 and (not _Frailty_DEBUFF or _Player_Percent_Health <= 60) then
		return _SpiritBomb;
	end

	if _FelDevastation_RDY and _Fury >= 50 and ConRO:FullMode(_FelDevastation) then
		return _FelDevastation;
	end
	
	if _Fracture_RDY and ((_SoulFragments <= 3 and _Fury <= _Fury_Max - 25) or _Fracture_CHARGES == 2 or (_Fracture_CHARGES == 1 and _Fracture_CCD <= 1)) then
		return _Fracture;
	end

	if _ImmolationAura_RDY and _SoulFragments <= 4 then
		return _ImmolationAura;
	end

	if _SoulCleave_RDY and (_Frailty_DEBUFF or not tChosen[ids.Ven_Talent.SpiritBomb]) and (_Player_Percent_Health  <= 80 or (_Fury >= _Fury_Max - 10)) then
		return _SoulCleave;
	end

	if _SigilofFlame_RDY and not (_Kyrian_CHOSEN and _RazelikhsDefilement_EQUIPPED) then
		return _SigilofFlame;
	end
	
	if _Felblade_RDY then
		return _Felblade;
	end
	
	if _Shear_RDY and not tChosen[ids.Ven_Talent.Fracture] and (_Fury <= _Fury_Max - 10) and _SoulFragments <= 4 then
		return _Shear;
	end
	
	if _ThrowGlaive_RDY then
		return _ThrowGlaive;
	end
return nil;
end

function ConRO.DemonHunter.VengeanceDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Fury, _Fury_Max, _Fury_Percent																= ConRO:PlayerPower('Fury');
	local _, _SoulFragments																				= ConRO:Form(ids.Ven_Form.SoulFragments);

--Abilities
	local _DemonSpikes, _DemonSpikes_RDY	 															= ConRO:AbilityReady(ids.Ven_Ability.DemonSpikes, timeShift);
		local _DemonSpikes_CHARGES, _DemonSpikes_MAX_CHARGES												= ConRO:SpellCharges(ids.Ven_Ability.DemonSpikes);
		local _DemonSpikes_BUFF																				= ConRO:Aura(ids.Ven_Buff.DemonSpikes, timeShift);
	local _FieryBrand, _FieryBrand_RDY																	= ConRO:AbilityReady(ids.Ven_Ability.FieryBrand, timeShift);
		local _FieryBrand_DEBUFF																			= ConRO:TargetAura(ids.Ven_Debuff.FieryBrand, timeShift);
	local _Metamorphosis, _Metamorphosis_RDY															= ConRO:AbilityReady(ids.Ven_Ability.Metamorphosis, timeShift);
		local _Metamorphosis_BUFF																			= ConRO:Aura(ids.Ven_Buff.Metamorphosis, timeShift);
	
	local _SoulBarrier, _SoulBarrier_RDY																= ConRO:AbilityReady(ids.Ven_Talent.SoulBarrier, timeShift);
		local _SoulBarrier_BUFF																				= ConRO:Aura(ids.Ven_Buff.SoulBarrier, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY	 																= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY	 													= ConRO:AbilityReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end	
	
	if _DemonSpikes_RDY and _DemonSpikes_CHARGES == _DemonSpikes_MAX_CHARGES then
		return _DemonSpikes;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _SoulBarrier_RDY and _SoulFragments >= 5 and not _FieryBrand_DEBUFF then
		return _SoulBarrier;
	end
	
	if _FieryBrand_RDY and not _SoulBarrier_BUFF then
		return _FieryBrand;
	end
	
	if _DemonSpikes_RDY and not (_Metamorphosis_BUFF or _FieryBrand_DEBUFF) then
		return _DemonSpikes;
	end

	if _Metamorphosis_RDY and not _Metamorphosis_BUFF then
		return _Metamorphosis;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end		
	return nil;
end
