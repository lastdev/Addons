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

function ConRO.Monk.Brewmaster(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Health 																				= UnitHealth('player');
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Energy, _Energy_Max																			= ConRO:PlayerPower('Energy');

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local _BlackoutKick, _BlackoutKick_RDY																= ConRO:AbilityReady(ids.Bm_Ability.BlackoutKick, timeShift);
		local _BlackoutCombo_BUFF																			= ConRO:Aura(ids.Bm_Buff.BlackoutCombo, timeShift);
	local _BreathofFire, _BreathofFire_RDY																= ConRO:AbilityReady(ids.Bm_Ability.BreathofFire, timeShift);
	local _CelestialBrew, _CelestialBrew_RDY															= ConRO:AbilityReady(ids.Bm_Ability.CelestialBrew, timeShift);
	local _InvokeNiuzaotheBlackOx, _InvokeNiuzaotheBlackOx_RDY											= ConRO:AbilityReady(ids.Bm_Ability.InvokeNiuzaotheBlackOx, timeShift);
	local _KegSmash, _KegSmash_RDY																		= ConRO:AbilityReady(ids.Bm_Ability.KegSmash, timeShift);
		local _KegSmash_DEBUFF																				= ConRO:TargetAura(ids.Bm_Debuff.KegSmash, timeShift);
	local _Provoke, _Provoke_RDY																		= ConRO:AbilityReady(ids.Bm_Ability.Provoke, timeShift);
	local _PurifyingBrew, _PurifyingBrew_RDY															= ConRO:AbilityReady(ids.Bm_Ability.PurifyingBrew, timeShift);	
		local _PurifyingBrew_CHARGES																		= ConRO:SpellCharges(ids.Bm_Ability.PurifyingBrew);
	local _Roll, _Roll_RDY																				= ConRO:AbilityReady(ids.Bm_Ability.Roll, timeShift);
	local _SpearHandStrike, _SpearHandStrike_RDY 														= ConRO:AbilityReady(ids.Bm_Ability.SpearHandStrike, timeShift);
	local _SpinningCraneKick, _SpinningCraneKick_RDY													= ConRO:AbilityReady(ids.Bm_Ability.SpinningCraneKick, timeShift);
	local _TigerPalm, _TigerPalm_RDY																	= ConRO:AbilityReady(ids.Bm_Ability.TigerPalm, timeShift);
	local _TouchofDeath, _TouchofDeath_RDY																= ConRO:AbilityReady(ids.Bm_Ability.TouchofDeath, timeShift);
	
	local _BlackOxBrew, _BlackOxBrew_RDY																= ConRO:AbilityReady(ids.Bm_Talent.BlackOxBrew, timeShift);
	local _ChiBurst, _ChiBurst_RDY																		= ConRO:AbilityReady(ids.Bm_Talent.ChiBurst, timeShift);
	local _ChiTorpedo, _ChiTorpedo_RDY																	= ConRO:AbilityReady(ids.Bm_Talent.ChiTorpedo, timeShift);
		local _ChiTorpedo_BUFF																				= ConRO:Aura(ids.Bm_Buff.ChiTorpedo, timeShift);	
	local _ChiWave, _ChiWave_RDY																		= ConRO:AbilityReady(ids.Bm_Talent.ChiWave, timeShift);
	local _ExplodingKeg, _ExplodingKeg_RDY																= ConRO:AbilityReady(ids.Bm_Talent.ExplodingKeg, timeShift);
	local _RushingJadeWind, _RushingJadeWind_RDY														= ConRO:AbilityReady(ids.Bm_Talent.RushingJadeWind, timeShift);
		local _RushingJadeWind_BUFF																			= ConRO:Aura(ids.Bm_Buff.RushingJadeWind, timeShift);	
	local _TigersLust, _TigersLust_RDY																	= ConRO:AbilityReady(ids.Bm_Talent.TigersLust, timeShift);

	local _BonedustBrew, _BonedustBrew_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.BonedustBrew, timeShift);
		local _BonedustBrew_BUFF																			= ConRO:Aura(ids.Covenant_Buff.BonedustBrew, timeShift);
	local _FaelineStomp, _FaelineStomp_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.FaelineStomp, timeShift);
		local _FaelineStomp_BUFF																			= ConRO:Aura(ids.Covenant_Buff.FaelineStomp, timeShift);
	local _FallenOrder, _FallenOrder_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.FallenOrder, timeShift);
		local _FallenOrder_BUFF																				= ConRO:Aura(ids.Covenant_Buff.FallenOrder, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _WeaponsofOrder, _WeaponsofOrder_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.WeaponsofOrder, timeShift);
		local _WeaponsofOrder_BUFF																			= ConRO:Aura(ids.Covenant_Buff.WeaponsofOrder, timeShift);

		local _CharredPassions_BUFF																			= ConRO:Aura(ids.Legendary_Buff.CharredPassions, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Indicators
	ConRO:AbilityInterrupt(_SpearHandStrike, _SpearHandStrike_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Roll, _Roll_RDY and not tChosen[ids.Bm_Talent.ChiTorpedo]);
	ConRO:AbilityMovement(_ChiTorpedo, _ChiTorpedo_RDY and not _ChiTorpedo_BUFF);
	ConRO:AbilityMovement(_TigersLust, _TigersLust_RDY);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityTaunt(_Provoke, _Provoke_RDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));

	ConRO:AbilityBurst(_BlackOxBrew, _BlackOxBrew_RDY and _Energy <= 30 and not _CelestialBrew_RDY and not _PurifyingBrew_RDY and ConRO:BurstMode(_BlackOxBrew));
	ConRO:AbilityBurst(_ExplodingKeg, _ExplodingKeg_RDY and ConRO:BurstMode(_ExplodingKeg));
	ConRO:AbilityBurst(_InvokeNiuzaotheBlackOx, _InvokeNiuzaotheBlackOx_RDY and ConRO:BurstMode(_InvokeNiuzaotheBlackOx));
	ConRO:AbilityBurst(_TouchofDeath, _TouchofDeath_RDY and ConRO:BurstMode(_TouchofDeath));

	ConRO:AbilityBurst(_WeaponsofOrder, _WeaponsofOrder_RDY and _in_combat and ConRO:BurstMode(_WeaponsofOrder));
	ConRO:AbilityBurst(_FallenOrder, _FallenOrder_RDY and _in_combat and ConRO:BurstMode(_FallenOrder));
	ConRO:AbilityBurst(_BonedustBrew, _BonedustBrew_RDY and _in_combat and ConRO:BurstMode(_BonedustBrew));
	
--Rotations
	if _TouchofDeath_RDY and ConRO:FullMode(_TouchofDeath) then
		return _TouchofDeath;
	end

	if _InvokeNiuzaotheBlackOx_RDY and ConRO:FullMode(_InvokeNiuzaotheBlackOx) then
		return _InvokeNiuzaotheBlackOx;
	end

	if _WeaponsofOrder_RDY and ConRO:FullMode(_WeaponsofOrder) then
		return _WeaponsofOrder;
	end

	if _FallenOrder_RDY and ConRO:FullMode(_FallenOrder) then
		return _FallenOrder;
	end	

	if _BonedustBrew_RDY and ConRO:FullMode(_BonedustBrew) then
		return _BonedustBrew;
	end	

	if _ExplodingKeg_RDY and ConRO:FullMode(_ExplodingKeg) then
		return _ExplodingKeg;
	end	
	
	if _BlackoutKick_RDY and tChosen[ids.Bm_Talent.BlackoutCombo] and _KegSmash_RDY then
		return _BlackoutKick;
	end
	
	if _BlackOxBrew_RDY and _Energy <= 30 and not _CelestialBrew_RDY and not _PurifyingBrew_RDY and ConRO:FullMode(_BlackOxBrew) then
		return _BlackOxBrew;
	end
	
	if _KegSmash_RDY and (not tChosen[ids.Bm_Talent.BlackoutCombo] or (tChosen[ids.Bm_Talent.BlackoutCombo] and _BlackoutCombo_BUFF)) then
		return _KegSmash;
	end

	if _FaelineStomp_RDY and _enemies_in_melee >= 3 then
		return _FaelineStomp;
	end

	if _BreathofFire_RDY and _enemies_in_melee >= 3 then
		return _BreathofFire;
	end
	
	if _BlackoutKick_RDY then
		return _BlackoutKick;
	end
	
	if _FaelineStomp_RDY then
		return _FaelineStomp;
	end

	if _BreathofFire_RDY then
		return _BreathofFire;
	end

	if _RushingJadeWind_RDY and not _RushingJadeWind_BUFF then
		return _RushingJadeWind;
	end
	
	if _ChiBurst_RDY then
		return _ChiBurst;
	end		

	if _ChiWave_RDY then
		return _ChiWave;
	end

	if _SpinningCraneKick_RDY and _Energy >= 65 and (_enemies_in_melee >= 3 or _CharredPassions_BUFF) then
		return _SpinningCraneKick;
	end 

	if _TigerPalm_RDY and _Energy >= 65 and _enemies_in_melee <= 2 then
		return _TigerPalm;
	end
return nil;
end

function ConRO.Monk.BrewmasterDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Energy, _Energy_Max																			= ConRO:PlayerPower('Energy');

--Racials
	local _Cannibalize, _Cannibalize_RDY																= ConRO:AbilityReady(ids.Racial.Cannibalize, timeShift);
	local _GiftoftheNaaru, _GiftoftheNaaru_RDY															= ConRO:AbilityReady(ids.Racial.GiftoftheNaaru, timeShift);
	
--Abilities
	local _CelestialBrew, _CelestialBrew_RDY															= ConRO:AbilityReady(ids.Bm_Ability.CelestialBrew, timeShift);
	local _ExpelHarm, _ExpelHarm_RDY																	= ConRO:AbilityReady(ids.Bm_Ability.ExpelHarm, timeShift);		
	local _FortifyingBrew, _FortifyingBrew_RDY															= ConRO:AbilityReady(ids.Bm_Ability.FortifyingBrew, timeShift);
	local _PurifyingBrew, _PurifyingBrew_RDY															= ConRO:AbilityReady(ids.Bm_Ability.PurifyingBrew, timeShift);
		local _PurifiedChi_BUFF 																			= ConRO:Aura(ids.Bm_Buff.PurifiedChi, timeShift);
		local _PurifyingBrew_CHARGES																		= ConRO:SpellCharges(ids.Bm_Ability.PurifyingBrew);
		local _HighStagger_DEBUFF																			= ConRO:Aura(ids.Bm_Debuff.HighStagger, timeShift, 'HARMFUL');
		local _MediumStagger_DEBUFF																			= ConRO:Aura(ids.Bm_Debuff.MediumStagger, timeShift, 'HARMFUL');	
	local _ZenMeditation, _ZenMeditation_RDY															= ConRO:AbilityReady(ids.Bm_Ability.ZenMeditation, timeShift);	

	local _DampenHarm, _DampenHarm_RDY																	= ConRO:AbilityReady(ids.Bm_Talent.DampenHarm, timeShift);
	local _HealingElixir, _HealingElixir_RDY															= ConRO:AbilityReady(ids.Bm_Talent.HealingElixir, timeShift);	
	
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
	
	if _CelestialBrew_RDY and _PurifiedChi_BUFF then
		return _CelestialBrew;
	end

	if _PurifyingBrew_RDY and ((_PurifyingBrew_CHARGES >= 1 and _HighStagger_DEBUFF) or (_MediumStagger_DEBUFF and (_PurifyingBrew_CHARGES >= 2 or _Player_Percent_Health <= 50))) then
		return _PurifyingBrew;
	end
	
	if _HealingElixir_RDY and _Player_Percent_Health <= 80 then
		return _HealingElixir;
	end	
	
	if _ExpelHarm_RDY and _Player_Percent_Health <= 50 then
		return _ExpelHarm;
	end
	
	if _DampenHarm_RDY then
		return _DampenHarm;
	end
	
	if _FortifyingBrew_RDY then
		return _FortifyingBrew;
	end	

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end	
return nil;
end

function ConRO.Monk.Mistweaver(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local _BlackoutKick, _BlackoutKick_RDY 																= ConRO:AbilityReady(ids.Mw_Ability.BlackoutKick, timeShift);
	local _ChiTorpedo, _ChiTorpedo_RDY																	= ConRO:AbilityReady(ids.Mw_Talent.ChiTorpedo, timeShift);
		local _ChiTorpedo_BUFF																				= ConRO:Aura(ids.Mw_Buff.ChiTorpedo, timeShift);	
	local _RenewingMist, _RenewingMist_RDY																= ConRO:AbilityReady(ids.Mw_Ability.RenewingMist, timeShift);
	local _RisingSunKick, _RisingSunKick_RDY, _RisingSunKick_CD, _RisingSunKick_MaxCD					= ConRO:AbilityReady(ids.Mw_Ability.RisingSunKick, timeShift);
	local _Roll, _Roll_RDY																				= ConRO:AbilityReady(ids.Mw_Ability.Roll, timeShift);
	local _SummonJadeSerpentStatue, _SummonJadeSerpentStatue_RDY										= ConRO:AbilityReady(ids.Mw_Talent.SummonJadeSerpentStatue, timeShift);
	local _TigerPalm, _TigerPalm_RDY 																	= ConRO:AbilityReady(ids.Mw_Ability.TigerPalm, timeShift);
		local _TeachingsoftheMonastery_BUFF, _TeachingsoftheMonastery_COUNT									= ConRO:Aura(ids.Mw_Buff.TeachingsoftheMonastery, timeShift);
	local _TigersLust, _TigersLust_RDY																	= ConRO:AbilityReady(ids.Mw_Talent.TigersLust, timeShift);
	local _TouchofDeath, _TouchofDeath_RDY																= ConRO:AbilityReady(ids.Mw_Ability.TouchofDeath, timeShift);

	local _BonedustBrew, _BonedustBrew_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.BonedustBrew, timeShift);
		local _BonedustBrew_BUFF																			= ConRO:Aura(ids.Covenant_Buff.BonedustBrew, timeShift);
	local _FaelineStomp, _FaelineStomp_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.FaelineStomp, timeShift);
		local _FaelineStomp_BUFF																			= ConRO:Aura(ids.Covenant_Buff.FaelineStomp, timeShift);
	local _FallenOrder, _FallenOrder_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.FallenOrder, timeShift);
		local _FallenOrder_BUFF																				= ConRO:Aura(ids.Covenant_Buff.FallenOrder, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _WeaponsofOrder, _WeaponsofOrder_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.WeaponsofOrder, timeShift);
		local _WeaponsofOrder_BUFF																			= ConRO:Aura(ids.Covenant_Buff.WeaponsofOrder, timeShift);
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Statue_texture = 620831;
	local _JadeSerpentStatue_ACTIVE = false;
	if tChosen[ids.Mw_Talent.SummonJadeSerpentStatue] then
		for slot = 1, 2 do
			local found, _, _, _, texture = GetTotemInfo(slot)
			if found and texture == _Statue_texture then
				_JadeSerpentStatue_ACTIVE = true;
			end
		end
	end
	
--Indicators
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Roll, _Roll_RDY and not tChosen[ids.Mw_Talent.ChiTorpedo]);
	ConRO:AbilityMovement(_ChiTorpedo, _ChiTorpedo_RDY and not _ChiTorpedo_BUFF);
	ConRO:AbilityMovement(_TigersLust, _TigersLust_RDY);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityRaidBuffs(_SummonJadeSerpentStatue, _SummonJadeSerpentStatue_RDY and not _JadeSerpentStatue_ACTIVE);
	ConRO:AbilityRaidBuffs(_RenewingMist, _RenewingMist_RDY and not ConRO:OneBuff(ids.Mw_Buff.RenewingMist));
	
--Rotations
	if _is_Enemy then
		if _TouchofDeath_RDY then
			return _TouchofDeath;
		end
	
		if _RisingSunKick_RDY then
			return _RisingSunKick;
		end
		
		if _TigerPalm_RDY and (not _TeachingsoftheMonastery_BUFF or _TeachingsoftheMonastery_COUNT < 3) then
			return _TigerPalm;
		end
		
		if _BlackoutKick_RDY and not _RisingSunKick_RDY and _RisingSunKick_CD > _RisingSunKick_MaxCD - 6 then
			return _BlackoutKick;
		end
	end
return nil;
end

function ConRO.Monk.MistweaverDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Cannibalize, _Cannibalize_RDY																= ConRO:AbilityReady(ids.Racial.Cannibalize, timeShift);
	local _GiftoftheNaaru, _GiftoftheNaaru_RDY															= ConRO:AbilityReady(ids.Racial.GiftoftheNaaru, timeShift);

--Abilities	
	local _FortifyingBrew, _FortifyingBrew_RDY															= ConRO:AbilityReady(ids.Mw_Ability.FortifyingBrew, timeShift);

	local _DampenHarm, _DampenHarm_RDY																	= ConRO:AbilityReady(ids.Mw_Talent.DampenHarm, timeShift);	
	local _HealingElixir, _HealingElixir_RDY															= ConRO:AbilityReady(ids.Mw_Talent.HealingElixir, timeShift);	

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

	if _HealingElixir_RDY and _Player_Percent_Health <= 80 then
		return _HealingElixir;
	end	

	if _DampenHarm_RDY then
		return _DampenHarm;
	end	
	
	if _FortifyingBrew_RDY then
		return _FortifyingBrew;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end	
return nil;
end

function ConRO.Monk.Windwalker(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Health 																				= UnitHealth('player');
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');
	local _party_size																					= GetNumGroupMembers();
	
	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Chi, _Chi_Max																				= ConRO:PlayerPower('Chi');
	local _Energy, _Energy_Max																			= ConRO:PlayerPower('Energy');
	
--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities
	local _BlackoutKick, _BlackoutKick_RDY 																= ConRO:AbilityReady(ids.Ww_Ability.BlackoutKick, timeShift);
		local _BlackoutKick_BUFF 																			= ConRO:Aura(ids.Ww_Buff.BlackoutKick, timeShift);
	local _CracklingJadeLightning, _CracklingJadeLightning_RDY											= ConRO:AbilityReady(ids.Ww_Ability.CracklingJadeLightning, timeShift);
		local _, _CracklingJadeLightning_RANGE 																= ConRO:Targets(ids.Ww_Ability.CracklingJadeLightning);		
	local _ExpelHarm, _ExpelHarm_RDY	 																= ConRO:AbilityReady(ids.Ww_Ability.ExpelHarm, timeShift);
	local _FistsofFury, _FistsofFury_RDY, _FistsofFury_CD												= ConRO:AbilityReady(ids.Ww_Ability.FistsofFury, timeShift);
		local _, _FistsofFury_RANGE 																		= ConRO:Targets(ids.Ww_Ability.FistsofFury);	
	local _FlyingSerpentKick, _FlyingSerpentKick_RDY													= ConRO:AbilityReady(ids.Ww_Ability.FlyingSerpentKick, timeShift);
	local _InvokeXuentheWhiteTiger, _InvokeXuentheWhiteTiger_RDY 										= ConRO:AbilityReady(ids.Ww_Ability.InvokeXuentheWhiteTiger, timeShift);
	local _RisingSunKick, _RisingSunKick_RDY, _RisingSunKick_CD											= ConRO:AbilityReady(ids.Ww_Ability.RisingSunKick, timeShift);
	local _Roll, _Roll_RDY																				= ConRO:AbilityReady(ids.Ww_Ability.Roll, timeShift);
	local _SpearHandStrike, _SpearHandStrike_RDY 														= ConRO:AbilityReady(ids.Ww_Ability.SpearHandStrike, timeShift);
	local _SpinningCraneKick, _SpinningCraneKick_RDY 													= ConRO:AbilityReady(ids.Ww_Ability.SpinningCraneKick, timeShift);
		local _DanceofChiJi_BUFF 																			= ConRO:Aura(ids.Ww_Buff.DanceofChiJi, timeShift);		
		local _MarkoftheCrane_DEBUFF																		= ConRO:TargetAura(ids.Ww_Debuff.MarkoftheCrane, timeShift);
	local _StormEarthandFire, _StormEarthandFire_RDY													= ConRO:AbilityReady(ids.Ww_Ability.StormEarthandFire, timeShift);
		local _StormEarthandFire_BUFF																		= ConRO:Aura(ids.Ww_Buff.StormEarthandFire, timeShift);
		local _StormEarthandFire_CHARGES, _StormEarthandFire_MaxCHARGES										= ConRO:SpellCharges(ids.Ww_Ability.StormEarthandFire);	
	local _TigerPalm, _TigerPalm_RDY					 												= ConRO:AbilityReady(ids.Ww_Ability.TigerPalm, timeShift);
	local _TouchofDeath, _TouchofDeath_RDY 																= ConRO:AbilityReady(ids.Ww_Ability.TouchofDeath, timeShift);
		local _TouchofDeath_DEBUFF																			= ConRO:TargetAura(ids.Ww_Debuff.TouchofDeath, timeShift);
	
	local _ChiTorpedo, _ChiTorpedo_RDY																	= ConRO:AbilityReady(ids.Ww_Talent.ChiTorpedo, timeShift);
		local _ChiTorpedo_BUFF																				= ConRO:Aura(ids.Ww_Buff.ChiTorpedo, timeShift);	
	local _TigersLust, _TigersLust_RDY																	= ConRO:AbilityReady(ids.Ww_Talent.TigersLust, timeShift);	
	local _EnergizingElixir, _EnergizingElixir_RDY 														= ConRO:AbilityReady(ids.Ww_Talent.EnergizingElixir, timeShift);	
	local _WhirlingDragonPunch, _WhirlingDragonPunch_RDY, _WhirlingDragonPunch_CD 						= ConRO:AbilityReady(ids.Ww_Talent.WhirlingDragonPunch, timeShift);
	local _ChiWave, _ChiWave_RDY 																		= ConRO:AbilityReady(ids.Ww_Talent.ChiWave, timeShift);
	local _Serenity, _Serenity_RDY 																		= ConRO:AbilityReady(ids.Ww_Talent.Serenity, timeShift);
		local _Serenity_BUFF, _, _Serenity_DUR																= ConRO:Aura(ids.Ww_Buff.Serenity, timeShift);
	local _RushingJadeWind, _RushingJadeWind_RDY 														= ConRO:AbilityReady(ids.Ww_Talent.RushingJadeWind, timeShift);
	local _ChiBurst, _ChiBurst_RDY 																		= ConRO:AbilityReady(ids.Ww_Talent.ChiBurst, timeShift);
	local _FistoftheWhiteTiger, _FistoftheWhiteTiger_RDY 												= ConRO:AbilityReady(ids.Ww_Talent.FistoftheWhiteTiger, timeShift);
	
	local _BonedustBrew, _BonedustBrew_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.BonedustBrew, timeShift);
		local _BonedustBrew_BUFF																			= ConRO:Aura(ids.Covenant_Buff.BonedustBrew, timeShift);
	local _FaelineStomp, _FaelineStomp_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.FaelineStomp, timeShift);
		local _FaelineStomp_BUFF																			= ConRO:Aura(ids.Covenant_Buff.FaelineStomp, timeShift);
	local _FallenOrder, _FallenOrder_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.FallenOrder, timeShift);
		local _FallenOrder_BUFF																				= ConRO:Aura(ids.Covenant_Buff.FallenOrder, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _WeaponsofOrder, _WeaponsofOrder_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.WeaponsofOrder, timeShift);
		local _WeaponsofOrder_BUFF																			= ConRO:Aura(ids.Covenant_Buff.WeaponsofOrder, timeShift);

		local _ChiEnergy_BUFF, _ChiEnergy_COUNT, _ChiEnergy_DUR												= ConRO:Aura(ids.Legendary_Buff.ChiEnergy, timeShift);
		local _TheEmperorsCapacitor_BUFF, _TheEmperorsCapacitor_COUNT, _TheEmperorsCapacitor_DUR			= ConRO:Aura(ids.Legendary_Buff.TheEmperorsCapacitor, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Indicators
	ConRO:AbilityInterrupt(_SpearHandStrike, _SpearHandStrike_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Roll, _Roll_RDY and not tChosen[ids.Ww_Talent.ChiTorpedo]);
	ConRO:AbilityMovement(_ChiTorpedo, _ChiTorpedo_RDY and not _ChiTorpedo_BUFF);
	ConRO:AbilityMovement(_TigersLust, _TigersLust_RDY);
	ConRO:AbilityMovement(_FlyingSerpentKick, _FlyingSerpentKick_RDY);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_EnergizingElixir, _EnergizingElixir_RDY and _Chi < 4 and _Energy <= 50 and ConRO:BurstMode(_EnergizingElixir));
	ConRO:AbilityBurst(_InvokeXuentheWhiteTiger, _InvokeXuentheWhiteTiger_RDY and ConRO:BurstMode(_InvokeXuentheWhiteTiger));
	ConRO:AbilityBurst(_StormEarthandFire, _StormEarthandFire_RDY and not _StormEarthandFire_BUFF and not tChosen[ids.Ww_Talent.Serenity] and ConRO:BurstMode(_StormEarthandFire, 90));
	ConRO:AbilityBurst(_Serenity, _Serenity_RDY and _FistsofFury_CD == 0 and ConRO:BurstMode(_Serenity));
	ConRO:AbilityBurst(_TouchofDeath, _TouchofDeath_RDY and ConRO:BurstMode(_TouchofDeath));
	
	ConRO:AbilityBurst(_WeaponsofOrder, _WeaponsofOrder_RDY and _in_combat and ConRO:BurstMode(_WeaponsofOrder));
	ConRO:AbilityBurst(_FallenOrder, _FallenOrder_RDY and _in_combat and ConRO:BurstMode(_FallenOrder));
	ConRO:AbilityBurst(_BonedustBrew, _BonedustBrew_RDY and _in_combat and ConRO:BurstMode(_BonedustBrew));
	
--Rotations
	if select(8, UnitChannelInfo("player")) == _FistsofFury then -- Do not break cast
		return _FistsofFury;
	end

	if _SpinningCraneKick_RDY and _FistsofFury_RANGE and (_ChiEnergy_COUNT >= 30 or (_ChiEnergy_BUFF and _ChiEnergy_DUR <= 2)) then
		return _SpinningCraneKick;
	end
	
	if _CracklingJadeLightning_RDY and _CracklingJadeLightning_RANGE and (_TheEmperorsCapacitor_COUNT >= 20 or (_TheEmperorsCapacitor_BUFF and _TheEmperorsCapacitor_DUR <= 2)) then
		return _CracklingJadeLightning;
	end
		
	if not _in_combat then
		if _ExpelHarm_RDY and _Chi <= 4 then
			return _ExpelHarm;
		end
		
		if _ChiWave_RDY and _CracklingJadeLightning_RANGE then
			return _ChiWave;
		end

		if _ChiBurst_RDY and _CracklingJadeLightning_RANGE and _Chi <= 4 and currentSpell ~= _ChiBurst then
			return _ChiBurst;
		end
		
		if _FaelineStomp_RDY then
			return _FaelineStomp;
		end
		
		if _FallenOrder_RDY and ConRO:FullMode(_FallenOrder) then
			return _FallenOrder;
		end
		
		if _FistoftheWhiteTiger_RDY then
			return _FistoftheWhiteTiger;
		end

		if _EnergizingElixir_RDY and _Chi < 4 and _Energy <= 50 and ConRO:FullMode(_EnergizingElixir) then
			return _EnergizingElixir;
		end
		
		if _TigerPalm_RDY then
			return _TigerPalm;
		end
	elseif _Serenity_BUFF then
		if _RisingSunKick_RDY and ConRO.lastSpellId ~= _RisingSunKick then
			return _RisingSunKick;
		end
		
		if _FistsofFury_RDY and _Serenity_DUR >= 9 then
			return _FistsofFury;
		end
		
		if _BlackoutKick_RDY and ConRO.lastSpellId ~= _BlackoutKick then
			return _BlackoutKick;
		end	

		if _FistsofFury_RDY then
			return _FistsofFury;
		end
		
		if tChosen[ids.Ww_Talent.FistoftheWhiteTiger] then
			if _FistoftheWhiteTiger_RDY then
				return _FistoftheWhiteTiger;
			end
		else
			if _SpinningCraneKick_RDY then
				return _SpinningCraneKick;
			end		
		end
	else
		if _InvokeXuentheWhiteTiger_RDY and ConRO:FullMode(_InvokeXuentheWhiteTiger) then
			return _InvokeXuentheWhiteTiger;
		end	
	
		if _WeaponsofOrder_RDY and ConRO:FullMode(_WeaponsofOrder) then
			return _WeaponsofOrder;
		end

		if _FallenOrder_RDY and ConRO:FullMode(_FallenOrder) then
			return _FallenOrder;
		end
		
		if _TouchofDeath_RDY and ConRO:FullMode(_TouchofDeath) then
			return _TouchofDeath;
		end	
	
		if _BonedustBrew_RDY and _Energy >= _Energy_Max - 15 and _Chi >= 4 and ConRO:FullMode(_BonedustBrew) then
			return _BonedustBrew;
		end	

		if _StormEarthandFire_RDY and not _StormEarthandFire_BUFF and not tChosen[ids.Ww_Talent.Serenity] and ConRO:FullMode(_StormEarthandFire, 90) then
			return _StormEarthandFire;
		end
		
		if _Serenity_RDY and _FistsofFury_CD == 0 and ConRO:FullMode(_Serenity) then
			return _Serenity;
		end
		
		if _ExpelHarm_RDY and _Chi <= 4 and _Energy >= _Energy_Max - 15 then
			return _ExpelHarm;
		end

		if _FistoftheWhiteTiger_RDY and _Chi < 3 and _Energy >= _Energy_Max - 15 and not _DanceofChiJi_BUFF then
			return _FistoftheWhiteTiger;
		end

		if _TigerPalm_RDY and _Chi < 4 and _Energy >= _Energy_Max - 15 and ConRO.lastSpellId ~= _TigerPalm and not _DanceofChiJi_BUFF then
			return _TigerPalm;
		end	

		if _WhirlingDragonPunch_RDY and _FistsofFury_CD > 0 and _RisingSunKick_CD > 0 then
			return _WhirlingDragonPunch;
		end

		if _FaelineStomp_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
			return _FaelineStomp;
		end
		
		if _SpinningCraneKick_RDY and _FistsofFury_RANGE and _DanceofChiJi_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) or ConRO_AoEButton:IsVisible()) then
			return _SpinningCraneKick;
		end

		if _RisingSunKick_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
			return _RisingSunKick;
		end
		
		if _FistsofFury_RDY and _FistsofFury_RANGE and currentSpell ~= _FistsofFury then
			return _FistsofFury;
		end
		
		if _FaelineStomp_RDY then
			return _FaelineStomp;
		end

		if _RushingJadeWind_RDY and _FistsofFury_RANGE and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			return _RushingJadeWind;
		end

		if _RisingSunKick_RDY and (tChosen[ids.Ww_Talent.WhirlingDragonPunch] and not _WhirlingDragonPunch_RDY and _WhirlingDragonPunch_CD < 3) then
			return _RisingSunKick;
		end

		if _ExpelHarm_RDY and _Chi <= 4 and not _DanceofChiJi_BUFF then
			return _ExpelHarm;
		end

		if _ChiBurst_RDY and _CracklingJadeLightning_RANGE and _Chi <= 4 and currentSpell ~= _ChiBurst then
			return _ChiBurst;
		end
		
		if _SpinningCraneKick_RDY and _FistsofFury_RANGE and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) or ConRO_AoEButton:IsVisible()) then
			return _SpinningCraneKick;
		end

		if _FistoftheWhiteTiger_RDY and not _DanceofChiJi_BUFF then
			return _FistoftheWhiteTiger;
		end

		if _SpinningCraneKick_RDY and _FistsofFury_RANGE and _DanceofChiJi_BUFF then
			return _SpinningCraneKick;
		end

		if _BlackoutKick_RDY and ConRO.lastSpellId ~= _BlackoutKick and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible() or not _MarkoftheCrane_DEBUFF) then
			return _BlackoutKick;
		end	
		
		if _ChiWave_RDY and _CracklingJadeLightning_RANGE then
			return _ChiWave;
		end
		
		if _ExpelHarm_RDY and _target_in_melee then
			return _ExpelHarm;
		end	
		
		if _EnergizingElixir_RDY and _Chi < 4 and _Energy <= 50 and ConRO:FullMode(_EnergizingElixir) then
			return _EnergizingElixir;
		end
		
		if _TigerPalm_RDY and ConRO.lastSpellId ~= _TigerPalm then
			return _TigerPalm;
		end
	end
return nil;
end

function ConRO.Monk.WindwalkerDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Chi, _Chi_Max																				= ConRO:PlayerPower('Chi');
	local _Energy, _Energy_Max																			= ConRO:PlayerPower('Energy');

--Racials
	local _Cannibalize, _Cannibalize_RDY																= ConRO:AbilityReady(ids.Racial.Cannibalize, timeShift);
	local _GiftoftheNaaru, _GiftoftheNaaru_RDY															= ConRO:AbilityReady(ids.Racial.GiftoftheNaaru, timeShift);
	
--Abilities
	local _ExpelHarm, _ExpelHarm_RDY																	= ConRO:AbilityReady(ids.Ww_Ability.ExpelHarm, timeShift);	
	local _FortifyingBrew, _FortifyingBrew_RDY															= ConRO:AbilityReady(ids.Ww_Ability.FortifyingBrew, timeShift);
	local _TouchofKarma, _TouchofKarma_RDY 																= ConRO:AbilityReady(ids.Ww_Ability.TouchofKarma, timeShift);
	
	local _DampenHarm, _DampenHarm_RDY																	= ConRO:AbilityReady(ids.Ww_Talent.DampenHarm, timeShift);	

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
	
	if _ExpelHarm_RDY and _Player_Percent_Health <= 50 then
		return _ExpelHarm;
	end

	if _TouchofKarma_RDY then
		return _TouchofKarma;
	end
	
	if _DampenHarm_RDY then
		return _DampenHarm;
	end
	
	if _FortifyingBrew_RDY then
		return _FortifyingBrew;
	end	

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end