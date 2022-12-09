ConRO.Monk = {};
ConRO.Monk.CheckTalents = function()
end
ConRO.Monk.CheckPvPTalents = function()
end
local ConRO_Monk, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Monk.CheckTalents;
	self.ModuleOnEnable = ConRO.Monk.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Monk [No Specialization Under 10]";
		self.NextSpell = ConRO.Monk.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = "Monk [Brewmaster - Tank]";
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Monk.Brewmaster;
			self.ToggleDamage();
			self.BlockAoE();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Monk.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 2 then
		self.Description = "Monk [Mistweaver - Healer]";
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Monk.Mistweaver;
			self.ToggleHealer();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Monk.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 3 then
		self.Description = "Monk [Windwalker - Melee]";
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.Monk.Windwalker;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Monk.Disabled;
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
		self.NextDef = ConRO.Monk.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Monk.BrewmasterDef;
		else
			self.NextDef = ConRO.Monk.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Monk.MistweaverDef;
		else
			self.NextDef = ConRO.Monk.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Monk.WindwalkerDef;
		else
			self.NextDef = ConRO.Monk.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Monk.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Monk.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Monk.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

--Warnings

--Rotations

return nil;
end

function ConRO.Monk.Brewmaster(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Bm_Ability, ids.Bm_Passive, ids.Bm_Form, ids.Bm_Buff, ids.Bm_Debuff, ids.Bm_PetAbility, ids.Bm_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Health = UnitHealth('player');
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Energy, _Energy_Max = ConRO:PlayerPower('Energy');

--Racials
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _BlackoutKick, _BlackoutKick_RDY = ConRO:AbilityReady(Ability.BlackoutKick, timeShift);
		local _BlackoutCombo_BUFF = ConRO:Aura(Buff.BlackoutCombo, timeShift);
		local _CharredPassions_BUFF = ConRO:Aura(Buff.CharredPassions, timeShift);
	local _BonedustBrew, _BonedustBrew_RDY = ConRO:AbilityReady(Ability.BonedustBrew, timeShift);
		local _BonedustBrew_BUFF = ConRO:Aura(Buff.BonedustBrew, timeShift);
	local _BreathofFire, _BreathofFire_RDY = ConRO:AbilityReady(Ability.BreathofFire, timeShift);
	local _CelestialBrew, _CelestialBrew_RDY = ConRO:AbilityReady(Ability.CelestialBrew, timeShift);
	local _InvokeNiuzaotheBlackOx, _InvokeNiuzaotheBlackOx_RDY = ConRO:AbilityReady(Ability.InvokeNiuzaotheBlackOx, timeShift);
	local _KegSmash, _KegSmash_RDY = ConRO:AbilityReady(Ability.KegSmash, timeShift);
		local _KegSmash_DEBUFF = ConRO:TargetAura(Debuff.KegSmash, timeShift);
		local _KegSmash_CHARGES = ConRO:SpellCharges(_KegSmash);
	local _Provoke, _Provoke_RDY = ConRO:AbilityReady(Ability.Provoke, timeShift);
	local _PurifyingBrew, _PurifyingBrew_RDY = ConRO:AbilityReady(Ability.PurifyingBrew, timeShift);
		local _PurifyingBrew_CHARGES = ConRO:SpellCharges(_PurifyingBrew);
	local _Roll, _Roll_RDY = ConRO:AbilityReady(Ability.Roll, timeShift);
	local _SpearHandStrike, _SpearHandStrike_RDY = ConRO:AbilityReady(Ability.SpearHandStrike, timeShift);
	local _SpinningCraneKick, _SpinningCraneKick_RDY = ConRO:AbilityReady(Ability.SpinningCraneKick, timeShift);
	local _SummonWhiteTigerStatue, _SummonWhiteTigerStatue_RDY = ConRO:AbilityReady(Ability.SummonWhiteTigerStatue, timeShift);
	local _TigerPalm, _TigerPalm_RDY = ConRO:AbilityReady(Ability.TigerPalm, timeShift);
	local _TouchofDeath, _TouchofDeath_RDY = ConRO:AbilityReady(Ability.TouchofDeath, timeShift);
	local _WeaponsofOrder, _WeaponsofOrder_RDY = ConRO:AbilityReady(Ability.WeaponsofOrder, timeShift);
		local _WeaponsofOrder_BUFF = ConRO:Aura(Buff.WeaponsofOrder, timeShift);

	local _BlackOxBrew, _BlackOxBrew_RDY																					= ConRO:AbilityReady(Ability.BlackOxBrew, timeShift);
	local _ChiBurst, _ChiBurst_RDY																								= ConRO:AbilityReady(Ability.ChiBurst, timeShift);
	local _ChiTorpedo, _ChiTorpedo_RDY																						= ConRO:AbilityReady(Ability.ChiTorpedo, timeShift);
		local _ChiTorpedo_BUFF																												= ConRO:Aura(Buff.ChiTorpedo, timeShift);
	local _ChiWave, _ChiWave_RDY																									= ConRO:AbilityReady(Ability.ChiWave, timeShift);
	local _ExplodingKeg, _ExplodingKeg_RDY																				= ConRO:AbilityReady(Ability.ExplodingKeg, timeShift);
	local _RushingJadeWind, _RushingJadeWind_RDY																	= ConRO:AbilityReady(Ability.RushingJadeWind, timeShift);
		local _RushingJadeWind_BUFF																										= ConRO:Aura(Buff.RushingJadeWind, timeShift);
	local _TigersLust, _TigersLust_RDY																						= ConRO:AbilityReady(Ability.TigersLust, timeShift);



--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Indicators
	ConRO:AbilityInterrupt(_SpearHandStrike, _SpearHandStrike_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Roll, _Roll_RDY and not tChosen[Ability.ChiTorpedo.talentID]);
	ConRO:AbilityMovement(_ChiTorpedo, _ChiTorpedo_RDY and not _ChiTorpedo_BUFF);
	ConRO:AbilityMovement(_TigersLust, _TigersLust_RDY);

	ConRO:AbilityTaunt(_Provoke, _Provoke_RDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));

	ConRO:AbilityBurst(_BlackOxBrew, _BlackOxBrew_RDY and _Energy <= 30 and not _CelestialBrew_RDY and not _PurifyingBrew_RDY and ConRO:BurstMode(_BlackOxBrew));
	ConRO:AbilityBurst(_BonedustBrew, _BonedustBrew_RDY and _in_combat and ConRO:BurstMode(_BonedustBrew));
	ConRO:AbilityBurst(_ExplodingKeg, _ExplodingKeg_RDY and ConRO:BurstMode(_ExplodingKeg));
	ConRO:AbilityBurst(_InvokeNiuzaotheBlackOx, _InvokeNiuzaotheBlackOx_RDY and ConRO:BurstMode(_InvokeNiuzaotheBlackOx));
	ConRO:AbilityBurst(_SummonWhiteTigerStatue, _SummonWhiteTigerStatue_RDY and ConRO:BurstMode(_SummonWhiteTigerStatue));
	ConRO:AbilityBurst(_TouchofDeath, _TouchofDeath_RDY and ConRO:BurstMode(_TouchofDeath));
	ConRO:AbilityBurst(_WeaponsofOrder, _WeaponsofOrder_RDY and _in_combat and ConRO:BurstMode(_WeaponsofOrder));


--Rotations
	for i = 1, 2, 1 do
		if not _in_combat then
			if _RushingJadeWind_RDY and not _RushingJadeWind_BUFF then
				tinsert(ConRO.SuggestedSpells, _RushingJadeWind);
				_RushingJadeWind_RDY = false;
			end

			if _ChiWave_RDY then
				tinsert(ConRO.SuggestedSpells, _ChiWave);
				_ChiWave_RDY = false;
			end
		end

		if _BlackOxBrew_RDY and _Energy <= 30 and _PurifyingBrew_CHARGES <= 0 and not _CelestialBrew_RDY and ConRO:FullMode(_BlackOxBrew) then
			tinsert(ConRO.SuggestedSpells, _BlackOxBrew);
			_BlackOxBrew_RDY = false;
		end

		if _TouchofDeath_RDY and ConRO:FullMode(_TouchofDeath) then
			tinsert(ConRO.SuggestedSpells, _TouchofDeath);
			_TouchofDeath_RDY = false;
		end

		if _InvokeNiuzaotheBlackOx_RDY and ConRO:FullMode(_InvokeNiuzaotheBlackOx) then
			tinsert(ConRO.SuggestedSpells, _InvokeNiuzaotheBlackOx);
			_InvokeNiuzaotheBlackOx_RDY = false;
		end

		if _SummonWhiteTigerStatue_RDY and ConRO:FullMode(_SummonWhiteTigerStatue) then
			tinsert(ConRO.SuggestedSpells, _SummonWhiteTigerStatue);
			_SummonWhiteTigerStatue_RDY = false;
		end

		if _BonedustBrew_RDY and not _BonedustBrew_BUFF and ConRO:FullMode(_BonedustBrew) then
			tinsert(ConRO.SuggestedSpells, _BonedustBrew);
			_BonedustBrew_RDY = false;
		end

		if _BlackoutKick_RDY and (_CharredPassions_BUFF or (tChosen[Passive.BlackoutCombo.talentID] and _BreathofFire_RDY)) then
			tinsert(ConRO.SuggestedSpells, _BlackoutKick);
			_BlackoutKick_RDY = false;
		end

		if _KegSmash_RDY and not _BlackoutCombo_BUFF and (not tChosen[Passive.StormstoutsLastKeg.talentID] or _KegSmash_CHARGES > 1) then
			tinsert(ConRO.SuggestedSpells, _KegSmash);
			_KegSmash_RDY = false;
		end

		if _BreathofFire_RDY then
			tinsert(ConRO.SuggestedSpells, _BreathofFire);
		end

		if _WeaponsofOrder_RDY and ConRO:FullMode(_WeaponsofOrder) then
			tinsert(ConRO.SuggestedSpells, _WeaponsofOrder);
		end

		if _BlackoutKick_RDY then
			tinsert(ConRO.SuggestedSpells, _BlackoutKick);
			_BlackoutKick_RDY = false;
		end

		if _RisingSunKick_RDY then
			tinsert(ConRO.SuggestedSpells, _RisingSunKick);
			_RisingSunKick_RDY = false;
		end

		if _ExplodingKeg_RDY and _RushingJadeWind_BUFF and ConRO:FullMode(_ExplodingKeg) then
			tinsert(ConRO.SuggestedSpells, _ExplodingKeg);
			_ExplodingKeg_RDY = false;
		end

		if _SpinningCraneKick_RDY and (_CharredPassions_BUFF or _ExplodingKeg_DEBUFF) then
			tinsert(ConRO.SuggestedSpells, _SpinningCraneKick);
		end

		if _KegSmash_RDY and tChosen[Passive.StormstoutsLastKeg.talentID] and _KegSmash_CHARGES >= 1 then
			tinsert(ConRO.SuggestedSpells, _KegSmash);
			_KegSmash_RDY = false;
		end

		if _ChiWave_RDY then
			tinsert(ConRO.SuggestedSpells, _ChiWave);
			_ChiWave_RDY = false;
		end

		if _ChiBurst_RDY then
			tinsert(ConRO.SuggestedSpells, _ChiBurst);
			_ChiBurst_RDY = false;
		end

		if _RushingJadeWind_RDY and not _RushingJadeWind_BUFF then
			tinsert(ConRO.SuggestedSpells, _RushingJadeWind);
		end

		if _enemies_in_melee >= 3 or tChosen[Passive.WalkwiththeOx.talentID] then
			if _SpinningCraneKick_RDY and _Energy >= 65 then
				tinsert(ConRO.SuggestedSpells, _SpinningCraneKick);
			end
		else
			if _TigerPalm_RDY and _Energy >= 65 then
				tinsert(ConRO.SuggestedSpells, _TigerPalm);
			end
		end
	end
	return nil;
end

function ConRO.Monk.BrewmasterDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Bm_Ability, ids.Bm_Passive, ids.Bm_Form, ids.Bm_Buff, ids.Bm_Debuff, ids.Bm_PetAbility, ids.Bm_PvPTalent, ids.Glyph;
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
	local _Energy, _Energy_Max																										= ConRO:PlayerPower('Energy');

--Racials
	local _Cannibalize, _Cannibalize_RDY																					= ConRO:AbilityReady(Racial.Cannibalize, timeShift);
	local _GiftoftheNaaru, _GiftoftheNaaru_RDY																		= ConRO:AbilityReady(Racial.GiftoftheNaaru, timeShift);

--Abilities
	local _CelestialBrew, _CelestialBrew_RDY																			= ConRO:AbilityReady(Ability.CelestialBrew, timeShift);
	local _ExpelHarm, _ExpelHarm_RDY																							= ConRO:AbilityReady(Ability.ExpelHarm, timeShift);
	local _FortifyingBrew, _FortifyingBrew_RDY																		= ConRO:AbilityReady(Ability.FortifyingBrew, timeShift);
	local _PurifyingBrew, _PurifyingBrew_RDY																			= ConRO:AbilityReady(Ability.PurifyingBrew, timeShift);
		local _PurifiedChi_BUFF 																											= ConRO:Aura(Buff.PurifiedChi, timeShift);
		local _PurifyingBrew_CHARGES																									= ConRO:SpellCharges(Ability.PurifyingBrew.spellID);
		local _HighStagger_DEBUFF																											= ConRO:Aura(Debuff.HighStagger, timeShift, 'HARMFUL');
		local _MediumStagger_DEBUFF																										= ConRO:Aura(Debuff.MediumStagger, timeShift, 'HARMFUL');
	local _ZenMeditation, _ZenMeditation_RDY																			= ConRO:AbilityReady(Ability.ZenMeditation, timeShift);

	local _DampenHarm, _DampenHarm_RDY																						= ConRO:AbilityReady(Ability.DampenHarm, timeShift);
	local _HealingElixir, _HealingElixir_RDY																			= ConRO:AbilityReady(Ability.HealingElixir, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Rotations
		if _CelestialBrew_RDY and _PurifiedChi_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _CelestialBrew);
		end

		if _PurifyingBrew_RDY and ((_PurifyingBrew_CHARGES >= 1 and _HighStagger_DEBUFF) or (_MediumStagger_DEBUFF and (_PurifyingBrew_CHARGES >= 2 or _Player_Percent_Health <= 50))) then
			tinsert(ConRO.SuggestedDefSpells, _PurifyingBrew);
		end

		if _HealingElixir_RDY and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _HealingElixir);
		end

		if _ExpelHarm_RDY and _Player_Percent_Health <= 50 then
			tinsert(ConRO.SuggestedDefSpells, _ExpelHarm);
		end

		if _DampenHarm_RDY then
			tinsert(ConRO.SuggestedDefSpells, _DampenHarm);
		end

		if _FortifyingBrew_RDY then
			tinsert(ConRO.SuggestedDefSpells, _FortifyingBrew);
		end
	return nil;
end

function ConRO.Monk.Mistweaver(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Mw_Ability, ids.Mw_Passive, ids.Mw_Form, ids.Mw_Buff, ids.Mw_Debuff, ids.Mw_PetAbility, ids.Mw_PvPTalent, ids.Glyph;
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
	local _Mana, _Mana_Max																												= ConRO:PlayerPower('Mana');

--Racials
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _BlackoutKick, _BlackoutKick_RDY 																				= ConRO:AbilityReady(Ability.BlackoutKick, timeShift);
	local _ChiTorpedo, _ChiTorpedo_RDY																						= ConRO:AbilityReady(Ability.ChiTorpedo, timeShift);
		local _ChiTorpedo_BUFF																												= ConRO:Aura(Buff.ChiTorpedo, timeShift);
	local _RenewingMist, _RenewingMist_RDY																				= ConRO:AbilityReady(Ability.RenewingMist, timeShift);
	local _RisingSunKick, _RisingSunKick_RDY, _RisingSunKick_CD, _RisingSunKick_MaxCD	= ConRO:AbilityReady(Ability.RisingSunKick, timeShift);
	local _Roll, _Roll_RDY																												= ConRO:AbilityReady(Ability.Roll, timeShift);
	local _SummonJadeSerpentStatue, _SummonJadeSerpentStatue_RDY									= ConRO:AbilityReady(Ability.SummonJadeSerpentStatue, timeShift);
	local _TigerPalm, _TigerPalm_RDY 																							= ConRO:AbilityReady(Ability.TigerPalm, timeShift);
		local _TeachingsoftheMonastery_BUFF, _TeachingsoftheMonastery_COUNT						= ConRO:Aura(Buff.TeachingsoftheMonastery, timeShift);
	local _TigersLust, _TigersLust_RDY																						= ConRO:AbilityReady(Ability.TigersLust, timeShift);
	local _TouchofDeath, _TouchofDeath_RDY																				= ConRO:AbilityReady(Ability.TouchofDeath, timeShift);

	local _BonedustBrew, _BonedustBrew_RDY																				= ConRO:AbilityReady(Ability.BonedustBrew, timeShift);
		local _BonedustBrew_BUFF																											= ConRO:Aura(Buff.BonedustBrew, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

	local _Statue_texture = 620831;
	local _JadeSerpentStatue_ACTIVE = false;
	if tChosen[Ability.SummonJadeSerpentStatue.talentID] then
		for slot = 1, 2 do
			local found, _, _, _, texture = GetTotemInfo(slot)
			if found and texture == _Statue_texture then
				_JadeSerpentStatue_ACTIVE = true;
			end
		end
	end

--Indicators
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Roll, _Roll_RDY and not tChosen[Ability.ChiTorpedo.talentID]);
	ConRO:AbilityMovement(_ChiTorpedo, _ChiTorpedo_RDY and not _ChiTorpedo_BUFF);
	ConRO:AbilityMovement(_TigersLust, _TigersLust_RDY);

	ConRO:AbilityRaidBuffs(_SummonJadeSerpentStatue, _SummonJadeSerpentStatue_RDY and not _JadeSerpentStatue_ACTIVE);
	ConRO:AbilityRaidBuffs(_RenewingMist, _RenewingMist_RDY and not ConRO:OneBuff(Buff.RenewingMist));

--Rotations
	if _is_Enemy then
		if _TouchofDeath_RDY then
			tinsert(ConRO.SuggestedSpells, _TouchofDeath);
		end

		if _RisingSunKick_RDY then
			tinsert(ConRO.SuggestedSpells, _RisingSunKick);
		end

		if _TigerPalm_RDY and (not _TeachingsoftheMonastery_BUFF or _TeachingsoftheMonastery_COUNT < 3) then
			tinsert(ConRO.SuggestedSpells, _TigerPalm);
		end

		if _BlackoutKick_RDY and not _RisingSunKick_RDY and _RisingSunKick_CD > _RisingSunKick_MaxCD - 6 then
			tinsert(ConRO.SuggestedSpells, _BlackoutKick);
		end
	end
return nil;
end

function ConRO.Monk.MistweaverDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Mw_Ability, ids.Mw_Passive, ids.Mw_Form, ids.Mw_Buff, ids.Mw_Debuff, ids.Mw_PetAbility, ids.Mw_PvPTalent, ids.Glyph;
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
	local _Mana, _Mana_Max																												= ConRO:PlayerPower('Mana');

--Racials
	local _Cannibalize, _Cannibalize_RDY																					= ConRO:AbilityReady(Racial.Cannibalize, timeShift);
	local _GiftoftheNaaru, _GiftoftheNaaru_RDY																		= ConRO:AbilityReady(Racial.GiftoftheNaaru, timeShift);

--Abilities
	local _FortifyingBrew, _FortifyingBrew_RDY																		= ConRO:AbilityReady(Ability.FortifyingBrew, timeShift);

	local _DampenHarm, _DampenHarm_RDY																						= ConRO:AbilityReady(Ability.DampenHarm, timeShift);
	local _HealingElixir, _HealingElixir_RDY																			= ConRO:AbilityReady(Ability.HealingElixir, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Rotations
		if _HealingElixir_RDY and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _HealingElixir);
		end

		if _DampenHarm_RDY then
			tinsert(ConRO.SuggestedDefSpells, _DampenHarm);
		end

		if _FortifyingBrew_RDY then
			tinsert(ConRO.SuggestedDefSpells, _FortifyingBrew);
		end
	return nil;
end

function ConRO.Monk.Windwalker(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ww_Ability, ids.Ww_Passive, ids.Ww_Form, ids.Ww_Buff, ids.Ww_Debuff, ids.Ww_PetAbility, ids.Ww_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Health = UnitHealth('player');
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Chi, _Chi_Max = ConRO:PlayerPower('Chi');
	local _Energy, _Energy_Max = ConRO:PlayerPower('Energy');

--Racials
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _BlackoutKick, _BlackoutKick_RDY = ConRO:AbilityReady(Ability.BlackoutKick, timeShift);
		local _BlackoutKick_BUFF = ConRO:Aura(Buff.BlackoutKick, timeShift);
		local _, _TeachingsoftheMonastery_COUNT = ConRO:Aura(Buff.TeachingsoftheMonastery, timeShift);
	local _BonedustBrew, _BonedustBrew_RDY = ConRO:AbilityReady(Ability.BonedustBrew, timeShift);
		local _BonedustBrew_BUFF = ConRO:Aura(Buff.BonedustBrew, timeShift);
	local _CracklingJadeLightning, _CracklingJadeLightning_RDY = ConRO:AbilityReady(Ability.CracklingJadeLightning, timeShift);
		local _, _CracklingJadeLightning_RANGE = ConRO:Targets(Ability.CracklingJadeLightning);
	local _ExpelHarm, _ExpelHarm_RDY = ConRO:AbilityReady(Ability.ExpelHarm, timeShift);
	local _FaelineStomp, _FaelineStomp_RDY = ConRO:AbilityReady(Ability.FaelineStomp, timeShift);
		local _FaeExposure_DEBUFF = ConRO:TargetAura(Debuff.FaeExposure, timeShift);
	local _FistsofFury, _FistsofFury_RDY, _FistsofFury_CD													= ConRO:AbilityReady(Ability.FistsofFury, timeShift);
		local _, _FistsofFury_RANGE 																									= ConRO:Targets(Ability.FistsofFury);
	local _FlyingSerpentKick, _FlyingSerpentKick_RDY															= ConRO:AbilityReady(Ability.FlyingSerpentKick, timeShift);
	local _InvokeXuentheWhiteTiger, _InvokeXuentheWhiteTiger_RDY 									= ConRO:AbilityReady(Ability.InvokeXuentheWhiteTiger, timeShift);
	local _RisingSunKick, _RisingSunKick_RDY, _RisingSunKick_CD										= ConRO:AbilityReady(Ability.RisingSunKick, timeShift);
	local _Roll, _Roll_RDY																												= ConRO:AbilityReady(Ability.Roll, timeShift);
	local _SpearHandStrike, _SpearHandStrike_RDY 																	= ConRO:AbilityReady(Ability.SpearHandStrike, timeShift);
	local _SpinningCraneKick, _SpinningCraneKick_RDY 															= ConRO:AbilityReady(Ability.SpinningCraneKick, timeShift);
		local _DanceofChiJi_BUFF 																											= ConRO:Aura(Buff.DanceofChiJi, timeShift);
		local _MarkoftheCrane_DEBUFF																									= ConRO:TargetAura(Debuff.MarkoftheCrane, timeShift);
	local _StormEarthandFire, _StormEarthandFire_RDY															= ConRO:AbilityReady(Ability.StormEarthandFire, timeShift);
		local _StormEarthandFire_BUFF																									= ConRO:Aura(Buff.StormEarthandFire, timeShift);
		local _StormEarthandFire_CHARGES, _StormEarthandFire_MaxCHARGES = ConRO:SpellCharges(_StormEarthandFire);
	local _StrikeoftheWindlord, _StrikeoftheWindlord_RDY = ConRO:AbilityReady(Ability.StrikeoftheWindlord, timeShift);
	local _TigerPalm, _TigerPalm_RDY					 																		= ConRO:AbilityReady(Ability.TigerPalm, timeShift);
	local _TouchofDeath, _TouchofDeath_RDY 																				= ConRO:AbilityReady(Ability.TouchofDeath, timeShift);
		local _TouchofDeath_DEBUFF																										= ConRO:TargetAura(Debuff.TouchofDeath, timeShift);

	local _ChiTorpedo, _ChiTorpedo_RDY																						= ConRO:AbilityReady(Ability.ChiTorpedo, timeShift);
		local _ChiTorpedo_BUFF																												= ConRO:Aura(Buff.ChiTorpedo, timeShift);
	local _TigersLust, _TigersLust_RDY																						= ConRO:AbilityReady(Ability.TigersLust, timeShift);
	local _WhirlingDragonPunch, _WhirlingDragonPunch_RDY, _WhirlingDragonPunch_CD = ConRO:AbilityReady(Ability.WhirlingDragonPunch, timeShift);
	local _ChiWave, _ChiWave_RDY 																									= ConRO:AbilityReady(Ability.ChiWave, timeShift);
	local _Serenity, _Serenity_RDY 																								= ConRO:AbilityReady(Ability.Serenity, timeShift);
		local _Serenity_BUFF, _, _Serenity_DUR																				= ConRO:Aura(ids.Ww_Buff.Serenity, timeShift);
	local _RushingJadeWind, _RushingJadeWind_RDY 																	= ConRO:AbilityReady(Ability.RushingJadeWind, timeShift);
	local _ChiBurst, _ChiBurst_RDY 																								= ConRO:AbilityReady(Ability.ChiBurst, timeShift);


		local _ChiEnergy_BUFF, _ChiEnergy_COUNT, _ChiEnergy_DUR												= ConRO:Aura(Buff.ChiEnergy, timeShift);
	

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

	if _Serenity_BUFF then
		_Chi = 99;
	end
--Indicators
	ConRO:AbilityInterrupt(_SpearHandStrike, _SpearHandStrike_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Roll, _Roll_RDY and not tChosen[Ability.ChiTorpedo.talentID]);
	ConRO:AbilityMovement(_ChiTorpedo, _ChiTorpedo_RDY and not _ChiTorpedo_BUFF);
	ConRO:AbilityMovement(_TigersLust, _TigersLust_RDY);
	ConRO:AbilityMovement(_FlyingSerpentKick, _FlyingSerpentKick_RDY);

	ConRO:AbilityBurst(_InvokeXuentheWhiteTiger, _InvokeXuentheWhiteTiger_RDY and ConRO:BurstMode(_InvokeXuentheWhiteTiger));
	ConRO:AbilityBurst(_StormEarthandFire, _StormEarthandFire_RDY and not _StormEarthandFire_BUFF and not tChosen[Ability.Serenity.talentID] and ConRO:BurstMode(_StormEarthandFire, 90));
	ConRO:AbilityBurst(_Serenity, _Serenity_RDY and _FistsofFury_CD == 0 and ConRO:BurstMode(_Serenity));
	ConRO:AbilityBurst(_TouchofDeath, _TouchofDeath_RDY and ConRO:BurstMode(_TouchofDeath));

	ConRO:AbilityBurst(_BonedustBrew, _BonedustBrew_RDY and _in_combat and ConRO:BurstMode(_BonedustBrew));

--Rotations
	for i = 1, 2, 1 do
		if select(8, UnitChannelInfo("player")) == _FistsofFury then -- Do not break cast
			tinsert(ConRO.SuggestedSpells, _FistsofFury);
		end

		if _InvokeXuentheWhiteTiger_RDY and ConRO:FullMode(_InvokeXuentheWhiteTiger) then
			tinsert(ConRO.SuggestedSpells, _InvokeXuentheWhiteTiger);
			_InvokeXuentheWhiteTiger_RDY = false;
		end

		if _TouchofDeath_RDY and ConRO:FullMode(_TouchofDeath) then
			tinsert(ConRO.SuggestedSpells, _TouchofDeath);
			_TouchofDeath_RDY = false;
		end

		if _ExpelHarm_RDY and _Chi <= (_Chi_Max - 1) and _Energy >= _Energy_Max - 15 then
			tinsert(ConRO.SuggestedSpells, _ExpelHarm);
			_ExpelHarm_RDY = false;
			_Chi = _Chi + 1;
		end

		if _TigerPalm_RDY and _Chi <= (_Chi_Max - 2) and _Energy >= _Energy_Max - 15 and ConRO.lastSpellId ~= _TigerPalm then
			tinsert(ConRO.SuggestedSpells, _TigerPalm);
			_TigerPalm_RDY = false;
			_Chi = _Chi + 2;
		end

		if _StrikeoftheWindlord_RDY and _Chi >= 2 and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee > 1) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _StrikeoftheWindlord);
			_StrikeoftheWindlord_RDY = false;
			_Chi = _Chi - 2;
		end

		if _SpinningCraneKick_RDY and _Chi >= 2 and _FistsofFury_RANGE and _DanceofChiJi_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee > 1) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _SpinningCraneKick);
			_SpinningCraneKick_RDY = false;
			_Chi = _Chi - 2;
		end

		if _BlackoutKick_RDY and _Chi >= 1 and _TeachingsoftheMonastery_COUNT >= 3 and ConRO.lastSpellId ~= _BlackoutKick then
			tinsert(ConRO.SuggestedSpells, _BlackoutKick);
			_BlackoutKick_RDY = false;
			_Chi = _Chi - 1;
		end

		if _StrikeoftheWindlord_RDY and _Chi >= 2 then
			tinsert(ConRO.SuggestedSpells, _StrikeoftheWindlord);
			_StrikeoftheWindlord_RDY = false;
			_Chi = _Chi - 2;
		end

		if _FaelineStomp_RDY and not _FaeExposure_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _FaelineStomp);
			_FaelineStomp_RDY = false;
		end

		if _BonedustBrew_RDY and _Energy >= _Energy_Max - 15 and _Chi >= 4 and ConRO:FullMode(_BonedustBrew) then
			tinsert(ConRO.SuggestedSpells, _BonedustBrew);
			_BonedustBrew_RDY = false;
		end

		if _Serenity_RDY and _FistsofFury_CD == 0 and ConRO:FullMode(_Serenity) then
			tinsert(ConRO.SuggestedSpells, _Serenity);
			_Serenity_RDY = false;
		end

		if _StormEarthandFire_RDY and not _StormEarthandFire_BUFF and _FistsofFury_RDY and _Chi >= 3 and not tChosen[Ability.Serenity.talentID] and ConRO:FullMode(_StormEarthandFire, 90) then
			tinsert(ConRO.SuggestedSpells, _StormEarthandFire);
			_StormEarthandFire_RDY = false;
		end

		if _FistsofFury_RDY and _Chi >= 3 and (not _Serenity_BUFF or _Serenity_DUR >= 9) then
			tinsert(ConRO.SuggestedSpells, _FistsofFury);
			_FistsofFury_RDY = false;
			_Chi = _Chi - 3;
		end

		if _RisingSunKick_RDY and _Chi >= 2 and ConRO.lastSpellId ~= _RisingSunKick then
			tinsert(ConRO.SuggestedSpells, _RisingSunKick);
			_RisingSunKick_RDY = false;
			_Chi = _Chi - 2;
		end

		if _WhirlingDragonPunch_RDY and _FistsofFury_CD > 0 and _RisingSunKick_CD > 0 then
			tinsert(ConRO.SuggestedSpells, _WhirlingDragonPunch);
			_WhirlingDragonPunch_RDY = false;
		end

		if _SpinningCraneKick_RDY and _Chi >= 2 and _FistsofFury_RANGE and _DanceofChiJi_BUFF then
			tinsert(ConRO.SuggestedSpells, _SpinningCraneKick);
			_SpinningCraneKick_RDY = false;
			_Chi = _Chi - 2;
		end

		if _BlackoutKick_RDY and _Chi >= 1 and ConRO.lastSpellId ~= _BlackoutKick and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _BlackoutKick);
			_BlackoutKick_RDY = false;
			_Chi = _Chi - 1;
		end

		if _RushingJadeWind_RDY and _Chi >= 1 and _FistsofFury_RANGE then
			tinsert(ConRO.SuggestedSpells, _RushingJadeWind);
			_RushingJadeWind_RDY = false;
			_Chi = _Chi - 1;
		end

		if _SpinningCraneKick_RDY and _Chi >= 2 and _FistsofFury_RANGE then
			tinsert(ConRO.SuggestedSpells, _SpinningCraneKick);
			_SpinningCraneKick_RDY = false;
			_Chi = _Chi - 2;
		end

		if _BlackoutKick_RDY and _Chi >= 1 and ConRO.lastSpellId ~= _BlackoutKick and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee > 1) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _BlackoutKick);
			_BlackoutKick_RDY = false;
			_Chi = _Chi - 1;
		end
		
		if _ChiWave_RDY and _CracklingJadeLightning_RANGE then
			tinsert(ConRO.SuggestedSpells, _ChiWave);
			_ChiWave_RDY = false;
		end

		if _FaelineStomp_RDY then
			tinsert(ConRO.SuggestedSpells, _FaelineStomp);
			_FaelineStomp_RDY = false;
		end

		if _ChiBurst_RDY and _CracklingJadeLightning_RANGE and _Chi <= 4 and currentSpell ~= _ChiBurst then
			tinsert(ConRO.SuggestedSpells, _ChiBurst);
			_ChiBurst_RDY = false;
			_Chi = _Chi + 1;
		end

		if _ExpelHarm_RDY and _Chi <= (_Chi_Max - 1) and _target_in_melee then
			tinsert(ConRO.SuggestedSpells, _ExpelHarm);
			_ExpelHarm_RDY = false;
			_Chi = _Chi + 1;
		end

		if _TigerPalm_RDY and _Chi <= (_Chi_Max - 2) and ConRO.lastSpellId ~= _TigerPalm then
			tinsert(ConRO.SuggestedSpells, _TigerPalm);
			_TigerPalm_RDY = false;
			_Chi = _Chi + 2;
		end
	end
	return nil;
end

function ConRO.Monk.WindwalkerDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ww_Ability, ids.Ww_Passive, ids.Ww_Form, ids.Ww_Buff, ids.Ww_Debuff, ids.Ww_PetAbility, ids.Ww_PvPTalent, ids.Glyph;
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
	local _Chi, _Chi_Max																													= ConRO:PlayerPower('Chi');
	local _Energy, _Energy_Max																										= ConRO:PlayerPower('Energy');

--Racials
	local _Cannibalize, _Cannibalize_RDY																					= ConRO:AbilityReady(Racial.Cannibalize, timeShift);
	local _GiftoftheNaaru, _GiftoftheNaaru_RDY																		= ConRO:AbilityReady(Racial.GiftoftheNaaru, timeShift);

--Abilities
	local _ExpelHarm, _ExpelHarm_RDY																							= ConRO:AbilityReady(Ability.ExpelHarm, timeShift);
	local _FortifyingBrew, _FortifyingBrew_RDY																		= ConRO:AbilityReady(Ability.FortifyingBrew, timeShift);
	local _TouchofKarma, _TouchofKarma_RDY 																				= ConRO:AbilityReady(Ability.TouchofKarma, timeShift);

	local _DampenHarm, _DampenHarm_RDY																						= ConRO:AbilityReady(Ability.DampenHarm, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Rotations
		if _ExpelHarm_RDY and _Player_Percent_Health <= 50 then
			tinsert(ConRO.SuggestedDefSpells, _ExpelHarm);
		end

		if _TouchofKarma_RDY then
			tinsert(ConRO.SuggestedDefSpells, _TouchofKarma);
		end

		if _DampenHarm_RDY then
			tinsert(ConRO.SuggestedDefSpells, _DampenHarm);
		end

		if _FortifyingBrew_RDY then
			tinsert(ConRO.SuggestedDefSpells, _FortifyingBrew);
		end
	return nil;
end
