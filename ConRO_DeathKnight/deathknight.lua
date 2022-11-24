ConRO.DeathKnight = {};
ConRO.DeathKnight.CheckTalents = function()
end
ConRO.DeathKnight.CheckPvPTalents = function()
end
local ConRO_DeathKnight, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.DeathKnight.CheckTalents;
	self.ModuleOnEnable = ConRO.DeathKnight.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Death Knight [No Specialization Under 10]";
		self.NextSpell = ConRO.DeathKnight.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = 'Death Knight [Blood - Tank]';
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.DeathKnight.Blood;
			self.ToggleDamage();
			self.BlockAoE();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.DeathKnight.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 2 then
		self.Description = 'Death Knight [Frost - Melee]';
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.DeathKnight.Frost;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.DeathKnight.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 3 then
		self.Description = 'Death Knight [Unholy - Melee]';
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.DeathKnight.Unholy;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.DeathKnight.Disabled;
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
		self.NextDef = ConRO.DeathKnight.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.DeathKnight.BloodDef;
		else
			self.NextDef = ConRO.DeathKnight.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.DeathKnight.FrostDef;
		else
			self.NextDef = ConRO.DeathKnight.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.DeathKnight.UnholyDef;
		else
			self.NextDef = ConRO.DeathKnight.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.DeathKnight.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.DeathKnight.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Warnings

--Rotations


	return nil;
end

function ConRO.DeathKnight.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Warnings

--Rotations

return nil;
end

function ConRO.DeathKnight.Blood(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Blood_Ability, ids.Blood_Passive, ids.Blood_Form, ids.Blood_Buff, ids.Blood_Debuff, ids.Blood_PetAbility, ids.Blood_PvPTalent, ids.Glyph;
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
	local _Runes = dkrunes();
	local _RunicPower, _RunicPower_Max = ConRO:PlayerPower('RunicPower');

--Racials
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _Asphyxiate, _Asphyxiate_RDY																						= ConRO:AbilityReady(Ability.Asphyxiate, timeShift);
	local _BloodBoil, _BloodBoil_RDY																							= ConRO:AbilityReady(Ability.BloodBoil, timeShift);
		local _BloodBoil_CHARGES																											= ConRO:SpellCharges(_BloodBoil);
		local _BloodPlague_DEBUFF			 																							= ConRO:TargetAura(Debuff.BloodPlague, timeShift);
		local _CrimsonScourge_BUFF			 																							= ConRO:Aura(Buff.CrimsonScourge, timeShift);
		local _Hemostasis_BUFF, _Hemostasis_COUNT			 																= ConRO:Aura(Buff.Hemostasis, timeShift);
	local _DancingRuneWeapon, _DancingRuneWeapon_RDY															= ConRO:AbilityReady(Ability.DancingRuneWeapon, timeShift);
		local _DancingRuneWeapon_BUFF																									= ConRO:Aura(Buff.DancingRuneWeapon, timeShift);
	local _DarkCommand, _DarkCommand_RDY																					= ConRO:AbilityReady(Ability.DarkCommand, timeShift);
	local _DeathandDecay, _DeathandDecay_RDY			 																= ConRO:AbilityReady(Ability.DeathandDecay, timeShift);
		local _DeathandDecay_BUFF, _, _DeathandDecay_DUR															= ConRO:Aura(Buff.DeathandDecay, timeShift);
	local _DeathStrike, _DeathStrike_RDY					 																= ConRO:AbilityReady(Ability.DeathStrike, timeShift);
		local _BloodShield_BUFF																												= ConRO:Aura(Buff.BloodShield, timeShift + 2);
	local _DeathsAdvance, _DeathsAdvance_RDY				 															= ConRO:AbilityReady(Ability.DeathsAdvance, timeShift);
	local _DeathsCaress, _DeathsCaress_RDY				 																= ConRO:AbilityReady(Ability.DeathsCaress, timeShift);
	local _HeartStrike, _HeartStrike_RDY 																					= ConRO:AbilityReady(Ability.HeartStrike, timeShift);
	local _MindFreeze, _MindFreeze_RDY					 																	= ConRO:AbilityReady(Ability.MindFreeze, timeShift);
	local _Marrowrend, _Marrowrend_RDY				 																		= ConRO:AbilityReady(Ability.Marrowrend, timeShift);
		local _BoneShield_BUFF, _BoneShield_COUNT			 																= ConRO:Aura(Buff.BoneShield, timeShift + 3);
	local _BloodTap, _BloodTap_RDY																								= ConRO:AbilityReady(Ability.BloodTap, timeShift);
		local _BloodTap_CHARGES, _BloodTap_MAX_CHARGES																= ConRO:SpellCharges(_BloodTap);
	local _Blooddrinker, _Blooddrinker_RDY																				= ConRO:AbilityReady(Ability.Blooddrinker, timeShift);
	local _Bonestorm, _Bonestorm_RDY					 																		= ConRO:AbilityReady(Ability.Bonestorm, timeShift);
	local _Consumption, _Consumption_RDY					 																= ConRO:AbilityReady(Ability.Consumption, timeShift);
	local _MarkofBlood, _MarkofBlood_RDY					 																= ConRO:AbilityReady(Ability.MarkofBlood, timeShift);
	local _Tombstone, _Tombstone_RDY					 																		= ConRO:AbilityReady(Ability.Tombstone, timeShift);
	local _WraithWalk, _WraithWalk_RDY					 																	= ConRO:AbilityReady(Ability.WraithWalk, timeShift);
	local _AbominationLimb, _AbominationLimb_RDY																	= ConRO:AbilityReady(Ability.AbominationLimb, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

	local _BoneShield_Threshold = 7;
		if _DancingRuneWeapon_BUFF then
			_BoneShield_Threshold = 4;
		end

--Indicators
	ConRO:AbilityInterrupt(_MindFreeze, _MindFreeze_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_Asphyxiate, _Asphyxiate_RDY and (ConRO:Interrupt() and not _MindFreeze_RDY and _is_PC and _is_Enemy));
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityTaunt(_DarkCommand, _DarkCommand_RDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));
	ConRO:AbilityMovement(_DeathsAdvance, _DeathsAdvance_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_WraithWalk, _WraithWalk_RDY and not _target_in_melee);

	ConRO:AbilityBurst(_Bonestorm, _Bonestorm_RDY and _RunicPower >= 10 and _enemies_in_melee >= 3 and ConRO:BurstMode(_Bonestorm));

	ConRO:AbilityBurst(_AbominationLimb, _AbominationLimb_RDY and _in_combat and ConRO:BurstMode(_AbominationLimb));

--Rotations
		if not _in_combat then
			if _Blooddrinker_RDY then
				tinsert(ConRO.SuggestedSpells, _Blooddrinker);
			end

			if _DeathsCaress_RDY and not _BloodPlague_DEBUFF and not _target_in_melee then
				tinsert(ConRO.SuggestedSpells, _DeathsCaress);
			end
		end

		if currentSpell == _Blooddrinker then
			tinsert(ConRO.SuggestedSpells, _Blooddrinker);
		end

		if _Marrowrend_RDY and not _BoneShield_BUFF then
			tinsert(ConRO.SuggestedSpells, _Marrowrend);
		end

		if _Bonestorm_RDY and _RunicPower >= 100 and _enemies_in_melee >= 3 and ConRO:FullMode(_Bonestorm) then
			tinsert(ConRO.SuggestedSpells, _Bonestorm);
		end

		if _DeathStrike_RDY and ((not _BloodShield_BUFF and _Player_Percent_Health <= 75) or _RunicPower == _RunicPower_Max or _Hemostasis_COUNT == 5) then
			tinsert(ConRO.SuggestedSpells, _DeathStrike);
		end

		if _BloodTap_RDY and (_Runes < 3 or _BloodTap_CHARGES == _BloodTap_MAX_CHARGES) then
			tinsert(ConRO.SuggestedSpells, _BloodTap);
		end

		if _BloodBoil_RDY and _BloodBoil_CHARGES == 2 then
			tinsert(ConRO.SuggestedSpells, _BloodBoil);
		end

		if _DeathandDecay_RDY and _CrimsonScourge_BUFF and tChosen[Passive.RelishinBlood.talentID] then
			tinsert(ConRO.SuggestedSpells, _DeathandDecay);
		end

		if _AbominationLimb_RDY and ConRO:FullMode(_AbominationLimb) then
			tinsert(ConRO.SuggestedSpells, _AbominationLimb);
		end

		if _Blooddrinker_RDY and not _DancingRuneWeapon_BUFF then
			tinsert(ConRO.SuggestedSpells, _Blooddrinker);
		end

		if _BloodBoil_RDY and not _BloodPlague_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _BloodBoil);
		end

		if _Marrowrend_RDY and _BoneShield_COUNT <= _BoneShield_Threshold then
			tinsert(ConRO.SuggestedSpells, _Marrowrend);
		end

		if _DeathandDecay_RDY and _Runes >= 3 and _enemies_in_melee >= 3 then
			tinsert(ConRO.SuggestedSpells, _DeathandDecay);
		end

		if _HeartStrike_RDY and _Runes >= 3 and _BoneShield_COUNT >= 5 then
			tinsert(ConRO.SuggestedSpells, _HeartStrike);
		end

		if _BloodBoil_RDY and _DancingRuneWeapon_BUFF then
			tinsert(ConRO.SuggestedSpells, _BloodBoil);
		end

		if _DeathandDecay_RDY and _CrimsonScourge_BUFF then
			tinsert(ConRO.SuggestedSpells, _DeathandDecay);
		end

		if _Consumption_RDY then
			tinsert(ConRO.SuggestedSpells, _Consumption);
		end

		if _BloodBoil_RDY then
			tinsert(ConRO.SuggestedSpells, _BloodBoil);
		end
		return nil;
end

function ConRO.DeathKnight.BloodDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Blood_Ability, ids.Blood_Passive, ids.Blood_Form, ids.Blood_Buff, ids.Blood_Debuff, ids.Blood_PetAbility, ids.Blood_PvPTalent, ids.Glyph;
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
	local _Runes							 																										= dkrunes();
	local _RunicPower, _RunicPower_Max																						= ConRO:PlayerPower('RunicPower');

--Abilities
	local _DancingRuneWeapon, _DancingRuneWeapon_RDY		 													= ConRO:AbilityReady(Ability.DancingRuneWeapon, timeShift);
	local _DeathCoil, _DeathCoil_RDY					 																		= ConRO:AbilityReady(Ability.DeathCoil, timeShift);
	local _DeathStrike, _DeathStrike_RDY					 																= ConRO:AbilityReady(Ability.DeathStrike, timeShift);
	local _IceboundFortitude, _IceboundFortitude_RDY		 													= ConRO:AbilityReady(Ability.IceboundFortitude, timeShift);
	local _Lichborne, _Lichborne_RDY																							= ConRO:AbilityReady(Ability.Lichborne, timeShift);
		local _Lichborne_BUFF							 																						= ConRO:Aura(Buff.Lichborne, timeShift);
	local _RaiseDead, _RaiseDead_RDY, _RaiseDead_CD																= ConRO:AbilityReady(Ability.RaiseDead, timeShift);
	local _RuneTap, _RuneTap_RDY																									= ConRO:AbilityReady(Ability.RuneTap, timeShift);
		local _RuneTap_BUFF							 																							= ConRO:Aura(Buff.RuneTap, timeShift);
	local _SacrificialPact, _SacrificialPact_RDY																	= ConRO:AbilityReady(Ability.SacrificialPact, timeShift);
	local _VampiricBlood, _VampiricBlood_RDY			 																= ConRO:AbilityReady(Ability.VampiricBlood, timeShift);

	local _Blooddrinker, _Blooddrinker_RDY 																				= ConRO:AbilityReady(Ability.Blooddrinker, timeShift);
	local _DeathPact, _DeathPact_RDY 																							= ConRO:AbilityReady(Ability.DeathPact, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Rotations
		if _SacrificialPact_RDY and _Player_Percent_Health <= 20 and _RaiseDead_CD > 60 then
			tinsert(ConRO.SuggestedDefSpells, _SacrificialPact);
		end

		if _DeathPact_RDY and _Player_Percent_Health <= 50 then
			tinsert(ConRO.SuggestedDefSpells, _DeathPact);
		end

		if _DeathCoil_RDY and _Lichborne_BUFF and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _DeathCoil);
		end

		if _Blooddrinker_RDY and _Player_Percent_Health <= 75 then
			tinsert(ConRO.SuggestedDefSpells, _Blooddrinker);
		end

		if _VampiricBlood_RDY and _Player_Percent_Health <= 50 then
			tinsert(ConRO.SuggestedDefSpells, _VampiricBlood);
		end

		if _Lichborne_RDY and _Player_Percent_Health <= 40 then
			tinsert(ConRO.SuggestedDefSpells, _Lichborne);
		end

		if _RaiseDead_RDY and _Player_Percent_Health <= 30 then
			tinsert(ConRO.SuggestedDefSpells, _RaiseDead);
		end

		if _DeathStrike_RDY and _Player_Percent_Health <= 30 then
			tinsert(ConRO.SuggestedDefSpells, _DeathStrike);
		end

		if _DancingRuneWeapon_RDY then
			tinsert(ConRO.SuggestedDefSpells, _DancingRuneWeapon);
		end

		if _RuneTap_RDY and not _RuneTap_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _RuneTap);
		end

		if _IceboundFortitude_RDY then
			tinsert(ConRO.SuggestedDefSpells, _IceboundFortitude);
		end
	return nil;
end

function ConRO.DeathKnight.Frost(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Frost_Ability, ids.Frost_Passive, ids.Frost_Form, ids.Frost_Buff, ids.Frost_Debuff, ids.Frost_PetAbility, ids.Frost_PvPTalent, ids.Glyph;
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
	local _Runes							 																										= dkrunes();
	local _RunicPower, _RunicPower_Max																						= ConRO:PlayerPower('RunicPower');

--Racials
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _ChainsofIce, _ChainsofIce_RDY																					= ConRO:AbilityReady(Ability.ChainsofIce, timeShift);
		local _ColdHeart_BUFF, _ColdHeart_COUNT																				= ConRO:Form(Buff.ColdHeart);
	local _DeathandDecay, _DeathandDecay_RDY					 														= ConRO:AbilityReady(Ability.DeathandDecay, timeShift);
		local _DeathandDecay_BUFF					 																						= ConRO:Aura(Buff.DeathandDecay, timeShift);
	local _DeathStrike, _DeathStrike_RDY					 																= ConRO:AbilityReady(Ability.DeathStrike, timeShift);
		local _DarkSuccor_BUFF					 																							= ConRO:Aura(Buff.DarkSuccor, timeShift);
	local _DeathsAdvance, _DeathsAdvance_RDY				 															= ConRO:AbilityReady(Ability.DeathsAdvance, timeShift);
	local _EmpowerRuneWeapon, _EmpowerRuneWeapon_RDY		 													= ConRO:AbilityReady(Ability.EmpowerRuneWeapon, timeShift);
		local _EmpowerRuneWeapon_BUFF																									= ConRO:Aura(Buff.EmpowerRuneWeapon, timeShift);
		local _UnholyStrength_BUFF, _, _UnholyStrength_DUR														= ConRO:Aura(Buff.UnholyStrength, timeShift);
		local _RazorIce_DEBUFF, _RazorIce_COUNT				 																= ConRO:TargetAura(Debuff.RazorIce, timeShift);
	local _FrostStrike, _FrostStrike_RDY				 																	= ConRO:AbilityReady(Ability.FrostStrike, timeShift);
		local _IcyTalons_BUFF, _, _IcyTalons_DUR																			= ConRO:Aura(Buff.IcyTalons, timeShift + 1.5);
	local _FrostwyrmsFury, _FrostwyrmsFury_RDY																		= ConRO:AbilityReady(Ability.FrostwyrmsFury, timeShift);
	local _HowlingBlast, _HowlingBlast_RDY					 															= ConRO:AbilityReady(Ability.HowlingBlast, timeShift);
		local _FrostFever_DEBUFF																											= ConRO:TargetAura(Debuff.FrostFever, timeShift);
		local _Rime_BUFF																															= ConRO:Aura(Buff.Rime, timeShift);
	local _MindFreeze, _MindFreeze_RDY					 																	= ConRO:AbilityReady(Ability.MindFreeze, timeShift);
	local _Obliterate, _Obliterate_RDY					 																	= ConRO:AbilityReady(Ability.Obliterate, timeShift);
		local _KillingMachine_BUFF																										= ConRO:Aura(Buff.KillingMachine, timeShift);
	local _PillarofFrost, _PillarofFrost_RDY, _PillarofFrost_CD										= ConRO:AbilityReady(Ability.PillarofFrost, timeShift);
		local _PillarofFrost_BUFF, _, _PillarofFrost_DUR															= ConRO:Aura(Buff.PillarofFrost, timeShift);
	local _RaiseDead, _RaiseDead_RDY																							= ConRO:AbilityReady(Ability.RaiseDead, timeShift);
	local _RemorselessWinter, _RemorselessWinter_RDY, _RemorselessWinter_CD				= ConRO:AbilityReady(Ability.RemorselessWinter, timeShift);

	local _Asphyxiate, _Asphyxiate_RDY																						= ConRO:AbilityReady(Ability.Asphyxiate, timeShift);
	local _BreathofSindragosa, _BreathofSindragosa_RDY, _BreathofSindragosa_CD		= ConRO:AbilityReady(Ability.BreathofSindragosa, timeShift);
		local _BreathofSindragosa_FORM																								= ConRO:Form(Form.BreathofSindragosa);
	local _Frostscythe, _Frostscythe_RDY 																					= ConRO:AbilityReady(Ability.Frostscythe, timeShift);
	local _GlacialAdvance, _GlacialAdvance_RDY			 															= ConRO:AbilityReady(Ability.GlacialAdvance, timeShift);
	local _HornofWinter, _HornofWinter_RDY																				= ConRO:AbilityReady(Ability.HornofWinter, timeShift);
	local _WraithWalk, _WraithWalk_RDY					 																	= ConRO:AbilityReady(Ability.WraithWalk, timeShift);

	local _ChillStreak, _ChillStreak_RDY					 																= ConRO:AbilityReady(Ability.ChillStreak, timeShift);

	local _AbominationLimb, _AbominationLimb_RDY																	= ConRO:AbilityReady(Ability.AbominationLimb, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

	local _Pet_summoned 																													= ConRO:CallPet();

--Indicators
	ConRO:AbilityInterrupt(_MindFreeze, _MindFreeze_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_Asphyxiate, _Asphyxiate_RDY and (ConRO:Interrupt() and not _MindFreeze_RDY and _is_PC and _is_Enemy));
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_DeathsAdvance, _DeathsAdvance_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_WraithWalk, _WraithWalk_RDY and not _target_in_melee);

	ConRO:AbilityBurst(_FrostwyrmsFury, _FrostwyrmsFury_RDY and _in_combat and _PillarofFrost_BUFF and _PillarofFrost_DUR <= 5);
	ConRO:AbilityBurst(_BreathofSindragosa, _BreathofSindragosa_RDY and _Runes >= 3 and _RunicPower >= 60 and _PillarofFrost_RDY and ConRO:BurstMode(_BreathofSindragosa));
	ConRO:AbilityBurst(_EmpowerRuneWeapon, _EmpowerRuneWeapon_RDY and _PillarofFrost_RDY and _Runes < 6 and not tChosen[Ability.BreathofSindragosa.talentID] and ConRO:BurstMode(_EmpowerRuneWeapon, 120));
	ConRO:AbilityBurst(_HornofWinter, _HornofWinter_RDY and _Runes <= 4 and _RunicPower <= _RunicPower_Max - 25 and (not tChosen[Ability.Obliteration.talentID] and (not tChosen[Ability.BreathofSindragosa.talentID] or (tChosen[Ability.BreathofSindragosa.talentID] and _BreathofSindragosa_CD >= 40))) and ConRO:BurstMode(_HornofWinter));
	ConRO:AbilityBurst(_PillarofFrost, _PillarofFrost_RDY and ((not tChosen[Ability.BreathofSindragosa.talentID] and _Runes <= 2) or (tChosen[Ability.BreathofSindragosa.talentID] and _BreathofSindragosa_CD >= 40)) and ConRO:BurstMode(_PillarofFrost));
	ConRO:AbilityBurst(_RaiseDead, _RaiseDead_RDY and not _Pet_summoned and _PillarofFrost_RDY and ConRO:BurstMode(_RaiseDead, timeShift));

	ConRO:AbilityBurst(_AbominationLimb, _AbominationLimb_RDY and _FrostFever_DEBUFF and (_BreathofSindragosa_FORM or not tChosen[Ability.BreathofSindragosa.talentID]) and ConRO:BurstMode(_AbominationLimb));

--Rotations
if tChosen[Passive.ColdHeart.talentID] then
			if tChosen[Ability.Obliteration.talentID] then
				if _ChainsofIce_RDY and not _PillarofFrost_BUFF and (_ColdHeart_COUNT >= 20 or (_UnholyStrength_BUFF and _UnholyStrength_DUR <= 2 and _ColdHeart_COUNT >= 17)) then
					tinsert(ConRO.SuggestedSpells, _ChainsofIce);
				end
			elseif tChosen[Ability.BreathofSindragosa.talentID] then
				if _ChainsofIce_RDY and ((_ColdHeart_COUNT >= 20 and _PillarofFrost_BUFF and _PillarofFrost_DUR <= 3) or (_ColdHeart_COUNT >= 10 and not _PillarofFrost_BUFF and _PillarofFrost_CD >= 28)) then
					tinsert(ConRO.SuggestedSpells, _ChainsofIce);
				end
			else
				if _ChainsofIce_RDY and _ColdHeart_COUNT >= 20 and _PillarofFrost_BUFF and _PillarofFrost_DUR <= 3 then
					tinsert(ConRO.SuggestedSpells, _ChainsofIce);
				end
			end
		end

		if _ChillStreak_RDY and ((_PillarofFrost_BUFF and _PillarofFrost_DUR <= 4) or (not _PillarofFrost_BUFF and _PillarofFrost_CD >= 40)) then
			tinsert(ConRO.SuggestedSpells, _ChillStreak);
		end

		if tChosen[Ability.BreathofSindragosa.talentID] and _BreathofSindragosa_FORM then
			if _PillarofFrost_RDY then
				tinsert(ConRO.SuggestedSpells, _PillarofFrost);
			end

			if _Obliterate_RDY and _RunicPower <= 30 then
				tinsert(ConRO.SuggestedSpells, _Obliterate);
			end

			if _RemorselessWinter_RDY and tChosen[Passive.GatheringStorm.talentID] then
				tinsert(ConRO.SuggestedSpells, _RemorselessWinter);
			end

			if _Obliterate_RDY and (_Runes <= 5 or _RunicPower <= 45) then
				tinsert(ConRO.SuggestedSpells, _Obliterate);
			end

			if _HowlingBlast_RDY and (not _FrostFever_DEBUFF or _Rime_BUFF) then
				tinsert(ConRO.SuggestedSpells, _HowlingBlast);
			end

			if _RemorselessWinter_RDY then
				tinsert(ConRO.SuggestedSpells, _RemorselessWinter);
			end

			if tChosen[Ability.Frostscythe.talentID] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				if _Frostscythe_RDY and _RunicPower <= 73 then
					tinsert(ConRO.SuggestedSpells, _Frostscythe);
				end
			else
				if _Obliterate_RDY and _RunicPower <= 73 then
					tinsert(ConRO.SuggestedSpells, _Obliterate);
				end
			end

			if _HornofWinter_RDY and _Runes <= 4 and _RunicPower <= _RunicPower_Max - 25 then
				tinsert(ConRO.SuggestedSpells, _HornofWinter);
			end

			if _AbominationLimb_RDY and ConRO:FullMode(_AbominationLimb) then
				tinsert(ConRO.SuggestedSpells, _AbominationLimb);
			end
		elseif tChosen[Ability.BreathofSindragosa.talentID] and (_BreathofSindragosa_RDY or _BreathofSindragosa_CD <= 10) and ConRO:FullMode(_BreathofSindragosa) then
			if _RaiseDead_RDY and not _Pet_summoned and _Runes >= 3 and _RunicPower >= 60 and _PillarofFrost_RDY then
				tinsert(ConRO.SuggestedSpells, _RaiseDead);
			end

			if _EmpowerRuneWeapon_RDY and _Runes >= 3 and _RunicPower >= 60 and _PillarofFrost_RDY then
				tinsert(ConRO.SuggestedSpells, _EmpowerRuneWeapon);
			end

			if _BreathofSindragosa_RDY and _Runes >= 3 and _RunicPower >= 60 and _PillarofFrost_RDY then
				tinsert(ConRO.SuggestedSpells, _BreathofSindragosa);
			end

			if _HowlingBlast_RDY and _Rime_BUFF then
				tinsert(ConRO.SuggestedSpells, _HowlingBlast);
			end

			if _DeathandDecay_RDY and not _DeathandDecay_BUFF and (((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) or _DeathandDecay == _DeathsDue) then
				tinsert(ConRO.SuggestedSpells, _DeathandDecay);
			end

			if tChosen[Ability.Frostscythe.talentID] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				if _Frostscythe_RDY and (_Runes >= 5 or _RunicPower <= 59) then
					tinsert(ConRO.SuggestedSpells, _Frostscythe);
				end
			else
				if _Obliterate_RDY and (_Runes >= 6 or _RunicPower <= 59) then
					tinsert(ConRO.SuggestedSpells, _Obliterate);
				end
			end

		elseif tChosen[Passive.Obliteration.talentID] and _PillarofFrost_BUFF then
			if _DeathandDecay_RDY and not _DeathandDecay_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _DeathandDecay);
			end

			if tChosen[Ability.Frostscythe.talentID] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				if _Frostscythe_RDY and _KillingMachine_BUFF then
					tinsert(ConRO.SuggestedSpells, _Frostscythe);
				end
			else
				if _Obliterate_RDY and _KillingMachine_BUFF then
					tinsert(ConRO.SuggestedSpells, _Obliterate);
				end
			end

			if _HornofWinter_RDY and _Runes <= 3 then
				tinsert(ConRO.SuggestedSpells, _HornofWinter);
			end

			if _GlacialAdvance_RDY and (not _KillingMachine_BUFF or _RunicPower >= 73) and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _GlacialAdvance);
			end

			if _FrostStrike_RDY and (not _KillingMachine_BUFF or _RunicPower >= 73) then
				tinsert(ConRO.SuggestedSpells, _FrostStrike);
			end

			if _HowlingBlast_RDY and _Rime_BUFF then
				tinsert(ConRO.SuggestedSpells, _HowlingBlast);
			end

			if tChosen[Ability.Frostscythe.talentID] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				if _Frostscythe_RDY then
					tinsert(ConRO.SuggestedSpells, _Frostscythe);
				end
			else
				if _Obliterate_RDY then
					tinsert(ConRO.SuggestedSpells, _Obliterate);
				end
			end

			if _AbominationLimb_RDY and ConRO:FullMode(_AbominationLimb) then
				tinsert(ConRO.SuggestedSpells, _AbominationLimb);
			end
		else
			if tChosen[Passive.IcyTalons.talentID] and not _IcyTalons_BUFF then
				if _RunicPower < 30 and tChosen[Ability.GlacialAdvance.talentID] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
					if _GlacialAdvance_RDY then
						tinsert(ConRO.SuggestedSpells, _GlacialAdvance);
					end
				else
					if _FrostStrike_RDY then
						tinsert(ConRO.SuggestedSpells, _FrostStrike);
					end
				end
			end

			if _RaiseDead_RDY and not _Pet_summoned and _PillarofFrost_RDY and _Runes < 6 and not tChosen[Ability.BreathofSindragosa.talentID] and ConRO:FullMode(_RaiseDead) then
				tinsert(ConRO.SuggestedSpells, _RaiseDead);
			end

			if _EmpowerRuneWeapon_RDY and _PillarofFrost_RDY and _Runes < 6 and not tChosen[Ability.BreathofSindragosa.talentID] and ConRO:FullMode(_EmpowerRuneWeapon, 120) then
				tinsert(ConRO.SuggestedSpells, _EmpowerRuneWeapon);
			end

			if _RemorselessWinter_RDY and tChosen[Passive.GatheringStorm.talentID] and (_PillarofFrost_RDY or _PillarofFrost_CD >= 20) then
				tinsert(ConRO.SuggestedSpells, _RemorselessWinter);
			end

			if _PillarofFrost_RDY and ((not tChosen[Ability.BreathofSindragosa.talentID] and _Runes < 6) or (tChosen[Ability.BreathofSindragosa.talentID] and _BreathofSindragosa_CD >= 40)) and ConRO:FullMode(_PillarofFrost) then
				tinsert(ConRO.SuggestedSpells, _PillarofFrost);
			end

			if _HowlingBlast_RDY and (not _FrostFever_DEBUFF or _Rime_BUFF) then
				tinsert(ConRO.SuggestedSpells, _HowlingBlast);
			end

			if _AbominationLimb_RDY and not (tChosen[Ability.BreathofSindragosa.talentID] or (tChosen[Passive.Obliteration.talentID] and _PillarofFrost_CD >= 40)) and ConRO:FullMode(_AbominationLimb) then
				tinsert(ConRO.SuggestedSpells, _AbominationLimb);
			end

			if _FrostStrike_RDY and _RunicPower >= 73 and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _FrostStrike);
			end

			if _KillingMachine_BUFF then
				if _Frostscythe_RDY then
					tinsert(ConRO.SuggestedSpells, _Frostscythe);
				end
			else
				if _Obliterate_RDY and _Runes >= 4 and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
					tinsert(ConRO.SuggestedSpells, _Obliterate);
				end
			end

			if _RemorselessWinter_RDY and not tChosen[Passive.GatheringStorm.talentID] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _RemorselessWinter);
			end

			if _DeathandDecay_RDY and not _DeathandDecay_BUFF and (((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) or _DeathandDecay == _DeathsDue) then
				tinsert(ConRO.SuggestedSpells, _DeathandDecay);
			end

			if _Frostscythe_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _Frostscythe);
			end

			if _Obliterate_RDY then
				tinsert(ConRO.SuggestedSpells, _Obliterate);
			end

			if _GlacialAdvance_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _GlacialAdvance);
			end

			if _HornofWinter_RDY and _Runes <= 4 and _RunicPower <= _RunicPower_Max - 25 and not tChosen[Passive.Obliteration.talentID] and (not tChosen[Ability.BreathofSindragosa.talentID] or (tChosen[Ability.BreathofSindragosa.talentID] and _BreathofSindragosa_CD >= 40)) and ConRO:FullMode(_HornofWinter) then
				tinsert(ConRO.SuggestedSpells, _HornofWinter);
			end

			if _DeathStrike_RDY and _DarkSuccor_BUFF and _Player_Percent_Health <= 85 then
				tinsert(ConRO.SuggestedSpells, _DeathStrike);
			end

			if _FrostStrike_RDY and not tChosen[Passive.IcyTalons.talentID] then
				tinsert(ConRO.SuggestedSpells, _FrostStrike);
			end
		end
	return nil;
end

function ConRO.DeathKnight.FrostDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Frost_Ability, ids.Frost_Passive, ids.Frost_Form, ids.Frost_Buff, ids.Frost_Debuff, ids.Frost_PetAbility, ids.Frost_PvPTalent, ids.Glyph;
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
	local _Runes							 																										= dkrunes();
	local _RunicPower, _RunicPower_Max																						= ConRO:PlayerPower('RunicPower');

--Abilities
	local _DeathCoil, _DeathCoil_RDY					 																		= ConRO:AbilityReady(Ability.DeathCoil, timeShift);
	local _DeathStrike, _DeathStrike_RDY																					= ConRO:AbilityReady(Ability.DeathStrike, timeShift);
		local _DarkSuccor_BUFF																												= ConRO:Aura(Buff.DarkSuccor, timeShift);
	local _IceboundFortitude, _IceboundFortitude_RDY															= ConRO:AbilityReady(Ability.IceboundFortitude, timeShift);
	local _Lichborne, _Lichborne_RDY																							= ConRO:AbilityReady(Ability.Lichborne, timeShift);
		local _Lichborne_BUFF							 																						= ConRO:Aura(Buff.Lichborne, timeShift);
	local _RaiseDead, _RaiseDead_RDY, _RaiseDead_CD																= ConRO:AbilityReady(Ability.RaiseDead, timeShift);
	local _SacrificialPact, _SacrificialPact_RDY																	= ConRO:AbilityReady(Ability.SacrificialPact, timeShift);

	local _DeathPact, _DeathPact_RDY																							= ConRO:AbilityReady(Ability.DeathPact, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Rotations
		if _SacrificialPact_RDY and _Player_Percent_Health <= 20 and _RaiseDead_CD > 60 then
			tinsert(ConRO.SuggestedDefSpells, _SacrificialPact);
		end

		if _DeathPact_RDY and _Player_Percent_Health <= 50 then
			tinsert(ConRO.SuggestedDefSpells, _DeathPact);
		end

		if _DeathCoil_RDY and _Lichborne_BUFF and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _DeathCoil);
		end

		if _Lichborne_RDY and _Player_Percent_Health <= 40 then
			tinsert(ConRO.SuggestedDefSpells, _Lichborne);
		end

		if _DeathStrike_RDY and ((_DarkSuccor_BUFF and _Player_Percent_Health <= 80) or _Player_Percent_Health <= 30) then
			tinsert(ConRO.SuggestedDefSpells, _DeathStrike);
		end

		if _IceboundFortitude_RDY then
			tinsert(ConRO.SuggestedDefSpells, _IceboundFortitude);
		end
	return nil;
end

function ConRO.DeathKnight.Unholy(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Unholy_Ability, ids.Unholy_Passive, ids.Unholy_Form, ids.Unholy_Buff, ids.Unholy_Debuff, ids.Unholy_PetAbility, ids.Unholy_PvPTalent, ids.Glyph;
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
	local _Runes											 																						= dkrunes();
	local _RunicPower, _RunicPower_Max																						= ConRO:PlayerPower('RunicPower');

--Racials
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _Apocalypse, _Apocalypse_RDY, _Apocalypse_CD, _Apocalypse_MaxCD					= ConRO:AbilityReady(Ability.Apocalypse, timeShift);
	local _ArmyoftheDead, _ArmyoftheDead_RDY			 																= ConRO:AbilityReady(Ability.ArmyoftheDead, timeShift);
	local _DarkTransformation, _DarkTransformation_RDY, _DarkTransformation_CD		= ConRO:AbilityReady(Ability.DarkTransformation, timeShift);
		local _DarkTransformation_BUFF																								= ConRO:UnitAura(Buff.DarkTransformation, timeShift, "pet");
	local _DeathandDecay, _DeathandDecay_RDY			 																= ConRO:AbilityReady(Ability.DeathandDecay, timeShift);
		local _DeathandDecay_BUFF																											= ConRO:Aura(Buff.DeathandDecay, timeShift);
	local _DeathCoil, _DeathCoil_RDY																							= ConRO:AbilityReady(Ability.DeathCoil, timeShift);
		local _SuddenDoom_BUFF					 																							= ConRO:Aura(Buff.SuddenDoom, timeShift);
	local _DeathStrike, _DeathStrike_RDY					 																= ConRO:AbilityReady(Ability.DeathStrike, timeShift);
		local _DarkSuccor_BUFF					 																							= ConRO:Aura(Buff.DarkSuccor, timeShift);
	local _DeathsAdvance, _DeathsAdvance_RDY				 															= ConRO:AbilityReady(Ability.DeathsAdvance, timeShift);
	local _Epidemic, _Epidemic_RDY						 																		= ConRO:AbilityReady(Ability.Epidemic, timeShift);
	local _FesteringStrike, _FesteringStrike_RDY				 													= ConRO:AbilityReady(Ability.FesteringStrike, timeShift);
		local _FesteringWound_DEBUFF, _FesteringWound_COUNT 													= ConRO:TargetAura(Debuff.FesteringWound, timeShift);
	local _MindFreeze, _MindFreeze_RDY																						= ConRO:AbilityReady(Ability.MindFreeze, timeShift);
	local _Outbreak, _Outbreak_RDY																								= ConRO:AbilityReady(Ability.Outbreak, timeShift);
		local _VirulentPlague_DEBUFF			 																						= ConRO:TargetAura(Debuff.VirulentPlague, timeShift);
	local _RaiseDead, _RaiseDead_RDY					 																		= ConRO:AbilityReady(Ability.RaiseDead, timeShift);
	local _ScourgeStrike, _ScourgeStrike_RDY				 															= ConRO:AbilityReady(Ability.ScourgeStrike, timeShift);

	local _Asphyxiate, _Asphyxiate_RDY																						= ConRO:AbilityReady(Ability.Asphyxiate, timeShift);
	local _ClawingShadows, _ClawingShadows_RDY																		= ConRO:AbilityReady(Ability.ClawingShadows, timeShift);
	local _Defile, _Defile_RDY																										= ConRO:AbilityReady(Ability.Defile, timeShift);
	local _SoulReaper, _SoulReaper_RDY					 																	= ConRO:AbilityReady(Ability.SoulReaper, timeShift);
	local _SummonGargoyle, _SummonGargoyle_RDY, _SummonGargoyle_CD								= ConRO:AbilityReady(Ability.SummonGargoyle, timeShift);
	local _UnholyAssault, _UnholyAssault_RDY					 														= ConRO:AbilityReady(Ability.UnholyAssault, timeShift);
	local _UnholyBlight, _UnholyBlight_RDY, _UnholyBlight_CD, _UnholyBlight_MaxCD	= ConRO:AbilityReady(Ability.UnholyBlight, timeShift);
		local _UnholyBlight_DEBUFF																										= ConRO:TargetAura(Debuff.UnholyBlight, timeShift);
	local _WraithWalk, _WraithWalk_RDY					 																	= ConRO:AbilityReady(Ability.WraithWalk, timeShift);

	local _AbominationLimb, _AbominationLimb_RDY																	= ConRO:AbilityReady(Ability.AbominationLimb, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);
	local _can_execute																														= _Target_Percent_Health <= 36;

	local _Pet_summoned 																													= ConRO:CallPet();
	local _Pet_assist 																														= ConRO:PetAssist();
	local _Pet_Percent_Health																											= ConRO:PercentHealth('pet');
	local _Ghoul_out																															= IsSpellKnown(PetAbility.Claw, true);

--Indicators
	ConRO:AbilityInterrupt(_MindFreeze, _MindFreeze_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_Asphyxiate, _Asphyxiate_RDY and (ConRO:Interrupt() and not _MindFreeze_RDY and _is_PC and _is_Enemy));
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_DeathsAdvance, _DeathsAdvance_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_WraithWalk, _WraithWalk_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_ArmyoftheDead, _ArmyoftheDead_RDY);
	ConRO:AbilityBurst(_DarkTransformation, _in_combat and _DarkTransformation_RDY and _Ghoul_out and ConRO:BurstMode(_DarkTransformation));
	ConRO:AbilityBurst(_Apocalypse, _in_combat and _Apocalypse_RDY and _FesteringWound_COUNT >= 4 and ConRO:BurstMode(_Apocalypse));
	ConRO:AbilityBurst(_UnholyAssault, _in_combat and _UnholyAssault_RDY and _FesteringWound_COUNT < 3 and ConRO:BurstMode(_UnholyAssault));
	ConRO:AbilityBurst(_SummonGargoyle, _SummonGargoyle_RDY and _RunicPower >= 90 and _SuddenDoom_BUFF and ConRO:BurstMode(_SummonGargoyle));
	ConRO:AbilityBurst(_UnholyBlight, _UnholyBlight_RDY and not (_VirulentPlague_DEBUFF and _UnholyBlight_DEBUFF) and ConRO:BurstMode(_UnholyBlight));

	ConRO:AbilityBurst(_AbominationLimb, _AbominationLimb_RDY and ConRO:BurstMode(_AbominationLimb));

--Warnings
	ConRO:Warnings("Call your ghoul!", _RaiseDead_RDY and not _Pet_summoned);

--Rotations
		if not _in_combat then
			if _Outbreak_RDY and not _VirulentPlague_DEBUFF and (not tChosen[Ability.UnholyBlight.talentID] or (tChosen[Ability.UnholyBlight.talentID] and (_UnholyBlight_CD >= 10 or ConRO:BurstMode(_UnholyBlight)))) then
				tinsert(ConRO.SuggestedSpells, _Outbreak);
			end

			if _FesteringStrike_RDY and _Runes >= 2 and (_FesteringWound_COUNT <= 0 or (_FesteringWound_COUNT <= 4 and (_Apocalypse_RDY or _Apocalypse_CD <= 10))) then
				tinsert(ConRO.SuggestedSpells, _FesteringStrike);
			end

			if _UnholyBlight_RDY and (_DarkTransformation_RDY or _DarkTransformation_BUFF) and not (_VirulentPlague_DEBUFF and _UnholyBlight_DEBUFF) and ConRO:FullMode(_UnholyBlight) then
				tinsert(ConRO.SuggestedSpells, _UnholyBlight);
			end
		end

		if _SummonGargoyle_RDY and _RunicPower >= 90 and _SuddenDoom_BUFF and ConRO:FullMode(_SummonGargoyle) then
			tinsert(ConRO.SuggestedSpells, _SummonGargoyle);
		end

		if _DeathCoil_RDY and ((_SummonGargoyle_CD >= 150 and tChosen[Ability.SummonGargoyle.talentID]) or (_DeadliestCoil_EQUIPPED and _DarkTransformation_BUFF)) then
			tinsert(ConRO.SuggestedSpells, _DeathCoil);
		end

		if _DeathStrike_RDY and _DarkSuccor_BUFF and _SummonGargoyle_CD >= 150 and tChosen[Ability.SummonGargoyle.talentID] then
			tinsert(ConRO.SuggestedSpells, _DeathStrike);
		end

		if _UnholyBlight_RDY and (_DarkTransformation_RDY or _DarkTransformation_BUFF) and not (_VirulentPlague_DEBUFF and _UnholyBlight_DEBUFF) and ConRO:FullMode(_UnholyBlight) then
			tinsert(ConRO.SuggestedSpells, _UnholyBlight);
		end

		if _Outbreak_RDY and not _VirulentPlague_DEBUFF and (not tChosen[Ability.UnholyBlight.talentID] or (tChosen[Ability.UnholyBlight.talentID] and (_UnholyBlight_CD >= 10 or ConRO:BurstMode(_UnholyBlight))) or ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible())) then
			tinsert(ConRO.SuggestedSpells, _Outbreak);
		end

		if _SoulReaper_RDY and _Runes >= 1 and _can_execute then
			tinsert(ConRO.SuggestedSpells, _SoulReaper);
		end

		if _DarkTransformation_RDY and _Ghoul_out and ConRO:FullMode(_DarkTransformation) then
			tinsert(ConRO.SuggestedSpells, _DarkTransformation);
		end

		if _Apocalypse_RDY and _FesteringWound_COUNT >= 4 and ConRO:FullMode(_Apocalypse) then
			tinsert(ConRO.SuggestedSpells, _Apocalypse);
		end

		if _UnholyAssault_RDY and _FesteringWound_COUNT < 3 and _Apocalypse_CD <= _Apocalypse_MaxCD - 3 and _Apocalypse_CD >= _Apocalypse_MaxCD - 15 and ConRO:FullMode(_UnholyAssault) then
			tinsert(ConRO.SuggestedSpells, _UnholyAssault);
		end

		if (_RunicPower >= 80 or _SuddenDoom_BUFF) and not (tChosen[Ability.SummonGargoyle.talentID] and (_SummonGargoyle_RDY or _SummonGargoyle_CD <= 10)) and not (_DeadliestCoil_EQUIPPED and (_DarkTransformation_RDY or _DarkTransformation_CD <= 10)) then
			if (not _DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible())) or (_DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 4) or ConRO_AoEButton:IsVisible())) then
				if _Epidemic_RDY  then
					tinsert(ConRO.SuggestedSpells, _Epidemic);
				end
			else
				if _DeathCoil_RDY then
					tinsert(ConRO.SuggestedSpells, _DeathCoil);
				end
			end
		end

		if _AbominationLimb_RDY and ConRO:FullMode(_AbominationLimb) then
			tinsert(ConRO.SuggestedSpells, _AbominationLimb);
		end

		if tChosen[Ability.Defile.talentID] then
			if _Defile_RDY then
				tinsert(ConRO.SuggestedSpells, _Defile);
			end
		else
			if _DeathandDecay_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() or tChosen[Passive.Pestilence.talentID]) then
				tinsert(ConRO.SuggestedSpells, _DeathandDecay);
			end
		end

		if ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and _DeathandDecay_BUFF then
			if _ClawingShadows_RDY and tChosen[Ability.ClawingShadows.talentID] and ((_FesteringWound_COUNT >= 1 and (not _Apocalypse_RDY or _Apocalypse_CD > 5)) or (_FesteringWound_COUNT >= 5 and _Apocalypse_RDY)) then
				tinsert(ConRO.SuggestedSpells, _ClawingShadows);
			elseif _ScourgeStrike_RDY and not tChosen[Ability.ClawingShadows.talentID] and ((_FesteringWound_COUNT >= 1 and (not _Apocalypse_RDY or _Apocalypse_CD > 5)) or (_FesteringWound_COUNT >= 5 and _Apocalypse_RDY)) then
				tinsert(ConRO.SuggestedSpells, _ScourgeStrike);
			end
		end

		if _Epidemic_RDY and not (tChosen[Ability.SummonGargoyle.talentID] and (_SummonGargoyle_RDY or _SummonGargoyle_CD <= 10)) and ((not _DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible())) or (_DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 4) or ConRO_AoEButton:IsVisible()))) then
			tinsert(ConRO.SuggestedSpells, _Epidemic);
		end

		if _ClawingShadows_RDY and tChosen[Ability.ClawingShadows.talentID] and ((_FesteringWound_COUNT >= 1 and (not _Apocalypse_RDY or _Apocalypse_CD > 5)) or (_FesteringWound_COUNT >= 5 and _Apocalypse_RDY)) then
			tinsert(ConRO.SuggestedSpells, _ClawingShadows);
		elseif _ScourgeStrike_RDY and not tChosen[Ability.ClawingShadows.talentID] and ((_FesteringWound_COUNT >= 1 and (not _Apocalypse_RDY or _Apocalypse_CD > 5)) or (_FesteringWound_COUNT >= 5 and _Apocalypse_RDY)) then
			tinsert(ConRO.SuggestedSpells, _ScourgeStrike);
		end

		if _FesteringStrike_RDY and _Runes >= 2 and (_FesteringWound_COUNT <= 0 or (_FesteringWound_COUNT <= 4 and (_Apocalypse_RDY or _Apocalypse_CD <= 10))) then
			tinsert(ConRO.SuggestedSpells, _FesteringStrike);
		end

		if _Transfusion_RDY and _RunicPower <= 50 then
			tinsert(ConRO.SuggestedSpells, _Transfusion);
		end

		if _DeathStrike_RDY and (_DarkSuccor_BUFF or _Transfusion_BUFF) then
			tinsert(ConRO.SuggestedSpells, _DeathStrike);
		end

		if _DeathCoil_RDY and not (tChosen[Ability.SummonGargoyle.talentID] and (_SummonGargoyle_RDY or _SummonGargoyle_CD <= 10)) and ((not _DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee == 1) or ConRO_SingleButton:IsVisible())) or (_DeadliestCoil_EQUIPPED and (_DarkTransformation_RDY or _DarkTransformation_CD > 11) and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 3) or ConRO_SingleButton:IsVisible()))) then
			tinsert(ConRO.SuggestedSpells, _DeathCoil);
		end
	return nil;
end

function ConRO.DeathKnight.UnholyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Unholy_Ability, ids.Unholy_Passive, ids.Unholy_Form, ids.Unholy_Buff, ids.Unholy_Debuff, ids.Unholy_PetAbility, ids.Unholy_PvPTalent, ids.Glyph;
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
	local _Runes											 																						= dkrunes();
	local _RunicPower, _RunicPower_Max																						= ConRO:PlayerPower('RunicPower');

--Abilities
	local _DeathCoil, _DeathCoil_RDY																							= ConRO:AbilityReady(Ability.DeathCoil, timeShift);
	local _DeathStrike, _DeathStrike_RDY					 																= ConRO:AbilityReady(Ability.DeathStrike, timeShift);
		local _DarkSuccor_BUFF					 																							= ConRO:Aura(Buff.DarkSuccor, timeShift);
	local _IceboundFortitude, _IceboundFortitude_RDY		 													= ConRO:AbilityReady(Ability.IceboundFortitude, timeShift);
	local _Lichborne, _Lichborne_RDY																							= ConRO:AbilityReady(Ability.Lichborne, timeShift);
		local _Lichborne_BUFF							 																						= ConRO:Aura(Buff.Lichborne, timeShift);
	local _SacrificialPact, _SacrificialPact_RDY																	= ConRO:AbilityReady(Ability.SacrificialPact, timeShift);

	local _DeathPact, _DeathPact_RDY					 																		= ConRO:AbilityReady(Ability.DeathPact, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

	local _Pet_summoned 																													= ConRO:CallPet();
	local _Pet_assist 																														= ConRO:PetAssist();
	local _Pet_Percent_Health																											= ConRO:PercentHealth('pet');

--Rotations
		if _SacrificialPact_RDY and _Player_Percent_Health <= 20 and _Pet_summoned then
			tinsert(ConRO.SuggestedDefSpells, _SacrificialPact);
		end

		if _DeathPact_RDY and _Player_Percent_Health <= 50 then
			tinsert(ConRO.SuggestedDefSpells, _DeathPact);
		end

		if _DeathCoil_RDY and _Lichborne_BUFF and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _DeathCoil);
		end

		if _Lichborne_RDY and _Player_Percent_Health <= 40 then
			tinsert(ConRO.SuggestedDefSpells, _Lichborne);
		end

		if _DeathStrike_RDY and ((_DarkSuccor_BUFF and _Player_Percent_Health <= 80) or _Player_Percent_Health <= 30) then
			tinsert(ConRO.SuggestedDefSpells, _DeathStrike);
		end

		if _IceboundFortitude_RDY then
			tinsert(ConRO.SuggestedDefSpells, _IceboundFortitude);
		end
	return nil;
end

function dkrunes()
	local _Runes = {
		rune1 = select(3, GetRuneCooldown(1));
		rune2 = select(3, GetRuneCooldown(2));
		rune3 = select(3, GetRuneCooldown(3));
		rune4 = select(3, GetRuneCooldown(4));
		rune5 = select(3, GetRuneCooldown(5));
		rune6 = select(3, GetRuneCooldown(6));
	}

	local totalrunes = 0;
		for k, v in pairs(_Runes) do
			if v then
				totalrunes = totalrunes + 1;
			end
		end
	return totalrunes;
end
