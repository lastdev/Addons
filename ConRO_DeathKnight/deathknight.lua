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

function ConRO.DeathKnight.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.DeathKnight.Blood(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Runes							 															= dkrunes();
	local _RunicPower, _RunicPower_Max																	= ConRO:PlayerPower('RunicPower');

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local _Asphyxiate, _Asphyxiate_RDY																	= ConRO:AbilityReady(ids.Blood_Ability.Asphyxiate, timeShift);
	local _BloodBoil, _BloodBoil_RDY																	= ConRO:AbilityReady(ids.Blood_Ability.BloodBoil, timeShift);
		local _BloodBoil_CHARGES																			= ConRO:SpellCharges(ids.Blood_Ability.BloodBoil);
		local _BloodPlague_DEBUFF			 																= ConRO:TargetAura(ids.Blood_Debuff.BloodPlague, timeShift);
		local _CrimsonScourge_BUFF			 																= ConRO:Aura(ids.Blood_Buff.CrimsonScourge, timeShift);
		local _Hemostasis_BUFF, _Hemostasis_COUNT			 												= ConRO:Aura(ids.Blood_Buff.Hemostasis, timeShift);
	local _DancingRuneWeapon, _DancingRuneWeapon_RDY													= ConRO:AbilityReady(ids.Blood_Ability.DancingRuneWeapon, timeShift);
		local _DancingRuneWeapon_BUFF																		= ConRO:Aura(ids.Blood_Buff.DancingRuneWeapon, timeShift);
	local _DarkCommand, _DarkCommand_RDY																= ConRO:AbilityReady(ids.Blood_Ability.DarkCommand, timeShift);
	local _DeathandDecay, _DeathandDecay_RDY			 												= ConRO:AbilityReady(ids.Blood_Ability.DeathandDecay, timeShift);
		local _DeathandDecay_BUFF, _, _DeathandDecay_DUR													= ConRO:Aura(ids.Blood_Buff.DeathandDecay, timeShift);	
	local _DeathStrike, _DeathStrike_RDY					 											= ConRO:AbilityReady(ids.Blood_Ability.DeathStrike, timeShift);
		local _BloodShield_BUFF																				= ConRO:Aura(ids.Blood_Buff.BloodShield, timeShift + 2);
	local _DeathsAdvance, _DeathsAdvance_RDY				 											= ConRO:AbilityReady(ids.Blood_Ability.DeathsAdvance, timeShift);
	local _DeathsCaress, _DeathsCaress_RDY				 												= ConRO:AbilityReady(ids.Blood_Ability.DeathsCaress, timeShift);
	local _HeartStrike, _HeartStrike_RDY 																= ConRO:AbilityReady(ids.Blood_Ability.HeartStrike, timeShift);
	local _MindFreeze, _MindFreeze_RDY					 												= ConRO:AbilityReady(ids.Blood_Ability.MindFreeze, timeShift);
	local _Marrowrend, _Marrowrend_RDY				 													= ConRO:AbilityReady(ids.Blood_Ability.Marrowrend, timeShift);
		local _BoneShield_BUFF, _BoneShield_COUNT			 												= ConRO:Aura(ids.Blood_Buff.BoneShield, timeShift + 3);


	local _BloodTap, _BloodTap_RDY																		= ConRO:AbilityReady(ids.Blood_Talent.BloodTap, timeShift);
		local _BloodTap_CHARGES, _BloodTap_MAX_CHARGES														= ConRO:SpellCharges(ids.Blood_Talent.BloodTap);
	local _Blooddrinker, _Blooddrinker_RDY																= ConRO:AbilityReady(ids.Blood_Talent.Blooddrinker, timeShift);
	local _Bonestorm, _Bonestorm_RDY					 												= ConRO:AbilityReady(ids.Blood_Talent.Bonestorm, timeShift);
	local _Consumption, _Consumption_RDY					 											= ConRO:AbilityReady(ids.Blood_Talent.Consumption, timeShift);
	local _MarkofBlood, _MarkofBlood_RDY					 											= ConRO:AbilityReady(ids.Blood_Talent.MarkofBlood, timeShift);
	local _Tombstone, _Tombstone_RDY					 												= ConRO:AbilityReady(ids.Blood_Talent.Tombstone, timeShift);
	local _WraithWalk, _WraithWalk_RDY					 												= ConRO:AbilityReady(ids.Blood_Talent.WraithWalk, timeShift);
	
	local _BloodforBlood, _BloodforBlood_RDY				 											= ConRO:AbilityReady(ids.Blood_PvPTalent.BloodforBlood, timeShift);
		local _BloodforBlood_BUFF											 								= ConRO:Aura(ids.Blood_Buff.BloodforBlood, timeShift);

	local _AbominationLimb, _AbominationLimb_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.AbominationLimb, timeShift);
	local _DeathsDue, _, _DeathsDue_CD																	= ConRO:AbilityReady(ids.Covenant_Ability.DeathsDue, timeShift);
	local _ShackletheUnworthy, _ShackletheUnworthy_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.ShackletheUnworthy, timeShift);
		local _ShackletheUnworthy_DEBUFF			 														= ConRO:TargetAura(ids.Blood_Debuff.ShackletheUnworthy, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _SwarmingMist, _SwarmingMist_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.SwarmingMist, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _BoneShield_Threshold = 7;
		if _DancingRuneWeapon_BUFF then
			_BoneShield_Threshold = 4;
		end

		if C_Covenants.GetActiveCovenantID() == 3 then
			_DeathandDecay_RDY = _DeathandDecay_RDY and _DeathsDue_CD <= 0;
			_DeathandDecay = _DeathsDue;
		end
		
--Indicators
	ConRO:AbilityInterrupt(_MindFreeze, _MindFreeze_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_Asphyxiate, _Asphyxiate_RDY and (ConRO:Interrupt() and not _MindFreeze_RDY and _is_PC and _is_Enemy));
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityTaunt(_DarkCommand, _DarkCommand_RDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));
	ConRO:AbilityMovement(_DeathsAdvance, _DeathsAdvance_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_WraithWalk, _WraithWalk_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_Bonestorm, _Bonestorm_RDY and _RunicPower >= 10 and _enemies_in_melee >= 3 and ConRO:BurstMode(_Bonestorm));

	ConRO:AbilityBurst(_AbominationLimb, _AbominationLimb_RDY and _in_combat and ConRO:BurstMode(_AbominationLimb));
	ConRO:AbilityBurst(_ShackletheUnworthy, _ShackletheUnworthy_RDY and _in_combat and ConRO:BurstMode(_ShackletheUnworthy));
	ConRO:AbilityBurst(_SwarmingMist, _SwarmingMist_RDY and _in_combat and ConRO:BurstMode(_SwarmingMist));
	
--Rotations	
	if not _in_combat then
		if _Blooddrinker_RDY then
			return _Blooddrinker;
		end
		
		if _DeathsCaress_RDY and not _BloodPlague_DEBUFF and not _target_in_melee then
			return _DeathsCaress;
		end
	end

	if currentSpell == _Blooddrinker then
		return _Blooddrinker;
	end
		
	if _Marrowrend_RDY and not _BoneShield_BUFF then
		return _Marrowrend;
	end
	
	if _Bonestorm_RDY and _RunicPower >= 100 and _enemies_in_melee >= 3 and ConRO:FullMode(_Bonestorm) then
		return _Bonestorm;
	end

	if _HeartStrike_RDY and IsPlayerSpell(_DeathsDue) and _DeathandDecay_DUR <= 1.5 then
		return _HeartStrike;
	end
	
	if _DeathStrike_RDY and ((not _BloodShield_BUFF and _Player_Percent_Health <= 75) or _RunicPower == _RunicPower_Max or _Hemostasis_COUNT == 5) then
		return _DeathStrike;
	end

	if _BloodTap_RDY and (_Runes < 3 or _BloodTap_CHARGES == _BloodTap_MAX_CHARGES) then
		return _BloodTap;
	end

	if _BloodBoil_RDY and _BloodBoil_CHARGES == 2 then
		return _BloodBoil;
	end

	if _SwarmingMist_RDY and ConRO:FullMode(_SwarmingMist) then
		return _SwarmingMist;
	end

	if _DeathandDecay_RDY and _CrimsonScourge_BUFF and tChosen[ids.Blood_Talent.RelishinBlood] then
		return _DeathandDecay;
	end

	if _ShackletheUnworthy_RDY and ConRO:FullMode(_ShackletheUnworthy) then
		return _ShackletheUnworthy;
	end

	if _AbominationLimb_RDY and ConRO:FullMode(_AbominationLimb) then
		return _AbominationLimb;
	end

	if _Blooddrinker_RDY and not _DancingRuneWeapon_BUFF then
		return _Blooddrinker;
	end
	
	if _BloodBoil_RDY and not _BloodPlague_DEBUFF then
		return _BloodBoil;
	end	
	
	if _Marrowrend_RDY and _BoneShield_COUNT <= _BoneShield_Threshold then
		return _Marrowrend;
	end	

	if _DeathandDecay_RDY and _Runes >= 3 and _enemies_in_melee >= 3 then
		return _DeathandDecay;
	end	

	if _BloodforBlood_RDY and _Runes >= 3 and _BoneShield_COUNT >= 5 and not _BloodforBlood_BUFF and _Player_Percent_Health >= 65 then
		return _BloodforBlood;
	end	

	if _HeartStrike_RDY and _Runes >= 3 and _BoneShield_COUNT >= 5 then
		return _HeartStrike;
	end	

	if _BloodBoil_RDY and _DancingRuneWeapon_BUFF then
		return _BloodBoil;
	end	

	if _DeathandDecay_RDY and _CrimsonScourge_BUFF then
		return _DeathandDecay;
	end	

	if _Consumption_RDY then
		return _Consumption;
	end
	
	if _BloodBoil_RDY then
		return _BloodBoil;
	end
	
return nil;
end

function ConRO.DeathKnight.BloodDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Runes							 															= dkrunes();
	local _RunicPower, _RunicPower_Max																	= ConRO:PlayerPower('RunicPower');

--Abilities
	local _DancingRuneWeapon, _DancingRuneWeapon_RDY		 											= ConRO:AbilityReady(ids.Blood_Ability.DancingRuneWeapon, timeShift);
	local _DeathCoil, _DeathCoil_RDY					 												= ConRO:AbilityReady(ids.Blood_Ability.DeathCoil, timeShift);
	local _DeathStrike, _DeathStrike_RDY					 											= ConRO:AbilityReady(ids.Blood_Ability.DeathStrike, timeShift);
	local _IceboundFortitude, _IceboundFortitude_RDY		 											= ConRO:AbilityReady(ids.Blood_Ability.IceboundFortitude, timeShift);
	local _Lichborne, _Lichborne_RDY																	= ConRO:AbilityReady(ids.Blood_Ability.Lichborne, timeShift);
		local _Lichborne_BUFF							 													= ConRO:Aura(ids.Blood_Buff.Lichborne, timeShift);
	local _RaiseDead, _RaiseDead_RDY, _RaiseDead_CD														= ConRO:AbilityReady(ids.Blood_Ability.RaiseDead, timeShift);
	local _RuneTap, _RuneTap_RDY																		= ConRO:AbilityReady(ids.Blood_Ability.RuneTap, timeShift);
		local _RuneTap_BUFF							 														= ConRO:Aura(ids.Blood_Buff.RuneTap, timeShift);	
	local _SacrificialPact, _SacrificialPact_RDY														= ConRO:AbilityReady(ids.Blood_Ability.SacrificialPact, timeShift);
	local _VampiricBlood, _VampiricBlood_RDY			 												= ConRO:AbilityReady(ids.Blood_Ability.VampiricBlood, timeShift);
	
	local _Blooddrinker, _Blooddrinker_RDY 																= ConRO:AbilityReady(ids.Blood_Talent.Blooddrinker, timeShift);
	local _DeathPact, _DeathPact_RDY 																	= ConRO:AbilityReady(ids.Blood_Talent.DeathPact, timeShift);

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

	if _SacrificialPact_RDY and _Player_Percent_Health <= 20 and _RaiseDead_CD > 60 then
		return _SacrificialPact;
	end

	if _DeathPact_RDY and _Player_Percent_Health <= 50 then
		return _DeathPact;
	end

	if _DeathCoil_RDY and _Lichborne_BUFF and _Player_Percent_Health <= 80 then
		return _DeathCoil;
	end
	
	if _Blooddrinker_RDY and _Player_Percent_Health <= 75 then
		return _Blooddrinker;
	end

	if _VampiricBlood_RDY and _Player_Percent_Health <= 50 then
		return _VampiricBlood;
	end

	if _Lichborne_RDY and _Player_Percent_Health <= 40 then
		return _Lichborne;
	end

	if _RaiseDead_RDY and _Player_Percent_Health <= 30 then
		return _RaiseDead;
	end
	
	if _DeathStrike_RDY and _Player_Percent_Health <= 30 then
		return _DeathStrike;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _DancingRuneWeapon_RDY then
		return _DancingRuneWeapon;
	end
	
	if _RuneTap_RDY and not _RuneTap_BUFF then
		return _RuneTap;
	end	
	
	if _IceboundFortitude_RDY then
		return _IceboundFortitude;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.DeathKnight.Frost(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Runes							 															= dkrunes();
	local _RunicPower, _RunicPower_Max																	= ConRO:PlayerPower('RunicPower');

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _ChainsofIce, _ChainsofIce_RDY																= ConRO:AbilityReady(ids.Frost_Ability.ChainsofIce, timeShift);
		local _ColdHeart_BUFF, _ColdHeart_COUNT																= ConRO:Form(ids.Frost_Buff.ColdHeart);	
	local _DeathandDecay, _DeathandDecay_RDY					 										= ConRO:AbilityReady(ids.Frost_Ability.DeathandDecay, timeShift);
		local _DeathandDecay_BUFF					 														= ConRO:Aura(ids.Frost_Buff.DeathandDecay, timeShift);		
	local _DeathStrike, _DeathStrike_RDY					 											= ConRO:AbilityReady(ids.Frost_Ability.DeathStrike, timeShift);
		local _DarkSuccor_BUFF					 															= ConRO:Aura(ids.Frost_Buff.DarkSuccor, timeShift);
	local _DeathsAdvance, _DeathsAdvance_RDY				 											= ConRO:AbilityReady(ids.Frost_Ability.DeathsAdvance, timeShift);
	local _EmpowerRuneWeapon, _EmpowerRuneWeapon_RDY		 											= ConRO:AbilityReady(ids.Frost_Ability.EmpowerRuneWeapon, timeShift);
		local _EmpowerRuneWeapon_BUFF																		= ConRO:Aura(ids.Frost_Buff.EmpowerRuneWeapon, timeShift);
		local _UnholyStrength_BUFF, _, _UnholyStrength_DUR													= ConRO:Aura(ids.Frost_Buff.UnholyStrength, timeShift);
		local _RazorIce_DEBUFF, _RazorIce_COUNT				 												= ConRO:TargetAura(ids.Frost_Debuff.RazorIce, timeShift);		
	local _FrostStrike, _FrostStrike_RDY				 												= ConRO:AbilityReady(ids.Frost_Ability.FrostStrike, timeShift);
		local _IcyTalons_BUFF, _, _IcyTalons_DUR															= ConRO:Aura(ids.Frost_Buff.IcyTalons, timeShift + 1.5);
	local _FrostwyrmsFury, _FrostwyrmsFury_RDY															= ConRO:AbilityReady(ids.Frost_Ability.FrostwyrmsFury, timeShift);
	local _HowlingBlast, _HowlingBlast_RDY					 											= ConRO:AbilityReady(ids.Frost_Ability.HowlingBlast, timeShift);
		local _FrostFever_DEBUFF																			= ConRO:TargetAura(ids.Frost_Debuff.FrostFever, timeShift);	
		local _Rime_BUFF																					= ConRO:Aura(ids.Frost_Buff.Rime, timeShift);
	local _MindFreeze, _MindFreeze_RDY					 												= ConRO:AbilityReady(ids.Frost_Ability.MindFreeze, timeShift);
	local _Obliterate, _Obliterate_RDY					 												= ConRO:AbilityReady(ids.Frost_Ability.Obliterate, timeShift);
		local _KillingMachine_BUFF																			= ConRO:Aura(ids.Frost_Buff.KillingMachine, timeShift);
	local _PillarofFrost, _PillarofFrost_RDY, _PillarofFrost_CD											= ConRO:AbilityReady(ids.Frost_Ability.PillarofFrost, timeShift);
		local _PillarofFrost_BUFF, _, _PillarofFrost_DUR													= ConRO:Aura(ids.Frost_Buff.PillarofFrost, timeShift);
	local _RaiseDead, _RaiseDead_RDY																	= ConRO:AbilityReady(ids.Frost_Ability.RaiseDead, timeShift);	
	local _RemorselessWinter, _RemorselessWinter_RDY, _RemorselessWinter_CD								= ConRO:AbilityReady(ids.Frost_Ability.RemorselessWinter, timeShift);

	local _Asphyxiate, _Asphyxiate_RDY																	= ConRO:AbilityReady(ids.Frost_Talent.Asphyxiate, timeShift);
	local _BreathofSindragosa, _BreathofSindragosa_RDY, _BreathofSindragosa_CD							= ConRO:AbilityReady(ids.Frost_Talent.BreathofSindragosa, timeShift);
		local _BreathofSindragosa_FORM																		= ConRO:Form(ids.Frost_Form.BreathofSindragosa);
	local _Frostscythe, _Frostscythe_RDY 																= ConRO:AbilityReady(ids.Frost_Talent.Frostscythe, timeShift);
	local _GlacialAdvance, _GlacialAdvance_RDY			 												= ConRO:AbilityReady(ids.Frost_Talent.GlacialAdvance, timeShift);
	local _HornofWinter, _HornofWinter_RDY																= ConRO:AbilityReady(ids.Frost_Talent.HornofWinter, timeShift);
	local _HypothermicPresence, _HypothermicPresence_RDY												= ConRO:AbilityReady(ids.Frost_Talent.HypothermicPresence, timeShift);
	local _WraithWalk, _WraithWalk_RDY					 												= ConRO:AbilityReady(ids.Frost_Talent.WraithWalk, timeShift);
	
	local _ChillStreak, _ChillStreak_RDY					 											= ConRO:AbilityReady(ids.Frost_PvPTalent.ChillStreak, timeShift);

	local _AbominationLimb, _AbominationLimb_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.AbominationLimb, timeShift);
	local _DeathsDue, _, _DeathsDue_CD																	= ConRO:AbilityReady(ids.Covenant_Ability.DeathsDue, timeShift);
	local _ShackletheUnworthy, _ShackletheUnworthy_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.ShackletheUnworthy, timeShift);
		local _ShackletheUnworthy_DEBUFF			 														= ConRO:TargetAura(ids.Blood_Debuff.ShackletheUnworthy, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _SwarmingMist, _SwarmingMist_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.SwarmingMist, timeShift);

		if C_Covenants.GetActiveCovenantID() == 3 then
			_DeathandDecay_RDY = _DeathandDecay_RDY and _DeathsDue_CD <= 0;
			_DeathandDecay = _DeathsDue;
		end
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

	local _Pet_summoned 																				= ConRO:CallPet();
	
--Indicators	
	ConRO:AbilityInterrupt(_MindFreeze, _MindFreeze_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_Asphyxiate, _Asphyxiate_RDY and (ConRO:Interrupt() and not _MindFreeze_RDY and _is_PC and _is_Enemy));
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_DeathsAdvance, _DeathsAdvance_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_WraithWalk, _WraithWalk_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_FrostwyrmsFury, _FrostwyrmsFury_RDY and _in_combat and _PillarofFrost_BUFF and _PillarofFrost_DUR <= 5);
	ConRO:AbilityBurst(_BreathofSindragosa, _BreathofSindragosa_RDY and _Runes >= 3 and _RunicPower >= 60 and _PillarofFrost_RDY and ConRO:BurstMode(_BreathofSindragosa));
	ConRO:AbilityBurst(_EmpowerRuneWeapon, _EmpowerRuneWeapon_RDY and _PillarofFrost_RDY and _Runes < 6 and not tChosen[ids.Frost_Talent.BreathofSindragosa] and ConRO:BurstMode(_EmpowerRuneWeapon, 120));
	ConRO:AbilityBurst(_HypothermicPresence, _HypothermicPresence_RDY and not _EmpowerRuneWeapon_BUFF and (not tChosen[ids.Frost_Talent.BreathofSindragosa] or (tChosen[ids.Frost_Talent.BreathofSindragosa] and (_BreathofSindragosa_CD >= 40 or _BreathofSindragosa_FORM))) and ConRO:BurstMode(_HypothermicPresence));
	ConRO:AbilityBurst(_HornofWinter, _HornofWinter_RDY and _Runes <= 4 and _RunicPower <= _RunicPower_Max - 25 and (not tChosen[ids.Frost_Talent.Obliteration] and (not tChosen[ids.Frost_Talent.BreathofSindragosa] or (tChosen[ids.Frost_Talent.BreathofSindragosa] and _BreathofSindragosa_CD >= 40))) and ConRO:BurstMode(_HornofWinter));
	ConRO:AbilityBurst(_PillarofFrost, _PillarofFrost_RDY and ((not tChosen[ids.Frost_Talent.BreathofSindragosa] and _Runes <= 2) or (tChosen[ids.Frost_Talent.BreathofSindragosa] and _BreathofSindragosa_CD >= 40)) and ConRO:BurstMode(_PillarofFrost));
	ConRO:AbilityBurst(_RaiseDead, _RaiseDead_RDY and not _Pet_summoned and _PillarofFrost_RDY and ConRO:BurstMode(_RaiseDead, timeShift));
		
	ConRO:AbilityBurst(_AbominationLimb, _AbominationLimb_RDY and _FrostFever_DEBUFF and (_BreathofSindragosa_FORM or not tChosen[ids.Frost_Talent.BreathofSindragosa]) and ConRO:BurstMode(_AbominationLimb));
	ConRO:AbilityBurst(_ShackletheUnworthy, _ShackletheUnworthy_RDY and _FrostFever_DEBUFF and (_BreathofSindragosa_FORM or not tChosen[ids.Frost_Talent.BreathofSindragosa]) and ConRO:BurstMode(_ShackletheUnworthy));
	ConRO:AbilityBurst(_SwarmingMist, _SwarmingMist_RDY and (((_BreathofSindragosa_FORM or (tChosen[ids.Frost_Talent.Obliteration] and _PillarofFrost_BUFF)) and _RunicPower <= 30) or (not tChosen[ids.Frost_Talent.BreathofSindragosa] or (tChosen[ids.Frost_Talent.BreathofSindragosa] and _BreathofSindragosa_CD >= 55))) and ConRO:BurstMode(_SwarmingMist));

--Rotations
	if tChosen[ids.Frost_Talent.ColdHeart] then
		if tChosen[ids.Frost_Talent.Obliteration] then
			if _ChainsofIce_RDY and not _PillarofFrost_BUFF and (_ColdHeart_COUNT >= 20 or (_UnholyStrength_BUFF and _UnholyStrength_DUR <= 2 and _ColdHeart_COUNT >= 17)) then
				return _ChainsofIce;
			end		
		elseif tChosen[ids.Frost_Talent.BreathofSindragosa] then
			if _ChainsofIce_RDY and ((_ColdHeart_COUNT >= 20 and _PillarofFrost_BUFF and _PillarofFrost_DUR <= 3) or (_ColdHeart_COUNT >= 10 and not _PillarofFrost_BUFF and _PillarofFrost_CD >= 28)) then
				return _ChainsofIce;
			end		
		else
			if _ChainsofIce_RDY and _ColdHeart_COUNT >= 20 and _PillarofFrost_BUFF and _PillarofFrost_DUR <= 3 then
				return _ChainsofIce;
			end
		end
	end
	
	if _ChillStreak_RDY and ((_PillarofFrost_BUFF and _PillarofFrost_DUR <= 4) or (not _PillarofFrost_BUFF and _PillarofFrost_CD >= 40)) then
		return _ChillStreak;
	end
	
	if tChosen[ids.Frost_Talent.BreathofSindragosa] and _BreathofSindragosa_FORM then
		if _PillarofFrost_RDY then
			return _PillarofFrost;
		end

		if _HypothermicPresence_RDY and not _EmpowerRuneWeapon_BUFF then
			return _HypothermicPresence;
		end
		
		if _Obliterate_RDY and _RunicPower <= 30 then
			return _Obliterate;
		end

		if _SwarmingMist_RDY and _RunicPower <= 30 and ConRO:FullMode(_SwarmingMist) then
			return _SwarmingMist;
		end
	
		if _RemorselessWinter_RDY and tChosen[ids.Frost_Talent.GatheringStorm] then
			return _RemorselessWinter;
		end

		if _Obliterate_RDY and (_Runes <= 5 or _RunicPower <= 45) then
			return _Obliterate;
		end
		
		if _HowlingBlast_RDY and (not _FrostFever_DEBUFF or _Rime_BUFF) then
			return _HowlingBlast;
		end

		if _RemorselessWinter_RDY then
			return _RemorselessWinter;
		end
		
		if tChosen[ids.Frost_Talent.Frostscythe] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			if _Frostscythe_RDY and _RunicPower <= 73 then
				return _Frostscythe;
			end		
		else
			if _Obliterate_RDY and _RunicPower <= 73 then
				return _Obliterate;
			end
		end
		
		if _HornofWinter_RDY and _Runes <= 4 and _RunicPower <= _RunicPower_Max - 25 then
			return _HornofWinter;
		end
		
		if _ShackletheUnworthy_RDY and ConRO:FullMode(_ShackletheUnworthy) then
			return _ShackletheUnworthy;
		end
		
		if _AbominationLimb_RDY and ConRO:FullMode(_AbominationLimb) then
			return _AbominationLimb;
		end
		
		return nil;	
		
	elseif tChosen[ids.Frost_Talent.BreathofSindragosa] and (_BreathofSindragosa_RDY or _BreathofSindragosa_CD <= 10) and ConRO:FullMode(_BreathofSindragosa) then
		if _RaiseDead_RDY and not _Pet_summoned and _Runes >= 3 and _RunicPower >= 60 and _PillarofFrost_RDY then
			return _RaiseDead;
		end
		
		if _EmpowerRuneWeapon_RDY and _Runes >= 3 and _RunicPower >= 60 and _PillarofFrost_RDY then
			return _EmpowerRuneWeapon;
		end
		
		if _BreathofSindragosa_RDY and _Runes >= 3 and _RunicPower >= 60 and _PillarofFrost_RDY then
			return _BreathofSindragosa;
		end
		
		if _HowlingBlast_RDY and _Rime_BUFF then
			return _HowlingBlast;
		end	
		
		if _DeathandDecay_RDY and not _DeathandDecay_BUFF and (((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) or _DeathandDecay == _DeathsDue) then
			return _DeathandDecay;
		end
		
		if _ShackletheUnworthy_RDY and ConRO:FullMode(_ShackletheUnworthy) then
			return _ShackletheUnworthy;
		end
		
		if tChosen[ids.Frost_Talent.Frostscythe] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			if _Frostscythe_RDY and (_Runes >= 5 or _RunicPower <= 59) then
				return _Frostscythe;
			end
		else
			if _Obliterate_RDY and (_Runes >= 6 or _RunicPower <= 59) then
				return _Obliterate;
			end
		end
		
	elseif tChosen[ids.Frost_Talent.Obliteration] and _PillarofFrost_BUFF then
		if _DeathandDecay_RDY and not _DeathandDecay_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			return _DeathandDecay;
		end
		
		if tChosen[ids.Frost_Talent.Frostscythe] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			if _Frostscythe_RDY and _KillingMachine_BUFF then
				return _Frostscythe;
			end
		else
			if _Obliterate_RDY and _KillingMachine_BUFF then
				return _Obliterate;
			end	
		end
		
		if _SwarmingMist_RDY and _RunicPower <= 30 and ConRO:FullMode(_SwarmingMist) then
			return _SwarmingMist;
		end
		
		if _HornofWinter_RDY and _Runes <= 3 then
			return _HornofWinter;
		end
		
		if _GlacialAdvance_RDY and (not _KillingMachine_BUFF or _RunicPower >= 73) and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			return _GlacialAdvance;
		end	
		
		if _FrostStrike_RDY and (not _KillingMachine_BUFF or _RunicPower >= 73) then
			return _FrostStrike;
		end

		if _HowlingBlast_RDY and _Rime_BUFF then
			return _HowlingBlast;
		end
		
		if tChosen[ids.Frost_Talent.Frostscythe] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			if _Frostscythe_RDY then
				return _Frostscythe;
			end
		else
			if _Obliterate_RDY then
				return _Obliterate;
			end
		end

		if _ShackletheUnworthy_RDY and ConRO:FullMode(_ShackletheUnworthy) then
			return _ShackletheUnworthy;
		end

		if _AbominationLimb_RDY and ConRO:FullMode(_AbominationLimb) then
			return _AbominationLimb;
		end

		return nil;
	else
		if tChosen[ids.Frost_Talent.IcyTalons] and not _IcyTalons_BUFF then
			if _RunicPower < 30 and tChosen[ids.Frost_Talent.GlacialAdvance] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				if _GlacialAdvance_RDY then
					return _GlacialAdvance;
				end
			else
				if _FrostStrike_RDY then
					return _FrostStrike;
				end
			end
		end
		
		if _RaiseDead_RDY and not _Pet_summoned and _PillarofFrost_RDY and _Runes < 6 and not tChosen[ids.Frost_Talent.BreathofSindragosa] and ConRO:FullMode(_RaiseDead) then
			return _RaiseDead;
		end
		
		if _EmpowerRuneWeapon_RDY and _PillarofFrost_RDY and _Runes < 6 and not tChosen[ids.Frost_Talent.BreathofSindragosa] and ConRO:FullMode(_EmpowerRuneWeapon, 120) then
			return _EmpowerRuneWeapon;
		end
		
		if _HypothermicPresence_RDY and not _EmpowerRuneWeapon_BUFF and (not tChosen[ids.Frost_Talent.BreathofSindragosa] or (tChosen[ids.Frost_Talent.BreathofSindragosa] and _BreathofSindragosa_CD >= 40)) and ConRO:FullMode(_HypothermicPresence) then
			return _HypothermicPresence;
		end

		if _SwarmingMist_RDY and (not tChosen[ids.Frost_Talent.BreathofSindragosa] or (tChosen[ids.Frost_Talent.BreathofSindragosa] and _BreathofSindragosa_CD >= 55)) and ConRO:FullMode(_SwarmingMist) then
			return _SwarmingMist;
		end
		
		if _RemorselessWinter_RDY and tChosen[ids.Frost_Talent.GatheringStorm] and (_PillarofFrost_RDY or _PillarofFrost_CD >= 20) then
			return _RemorselessWinter;
		end
		
		if _PillarofFrost_RDY and ((not tChosen[ids.Frost_Talent.BreathofSindragosa] and _Runes < 6) or (tChosen[ids.Frost_Talent.BreathofSindragosa] and _BreathofSindragosa_CD >= 40)) and ConRO:FullMode(_PillarofFrost) then
			return _PillarofFrost;
		end
		
		if _HowlingBlast_RDY and (not _FrostFever_DEBUFF or _Rime_BUFF) then
			return _HowlingBlast;
		end

		if _Obliterate_RDY and _Runes >= 3 and tChosen[ids.Frost_Talent.FrozenPulse] then
			return _Obliterate;
		end
		
		if _ShackletheUnworthy_RDY and not (tChosen[ids.Frost_Talent.BreathofSindragosa] or (tChosen[ids.Frost_Talent.Obliteration] and _PillarofFrost_CD >= 40)) and ConRO:FullMode(_ShackletheUnworthy) then
			return _ShackletheUnworthy;
		end

		if _AbominationLimb_RDY and not (tChosen[ids.Frost_Talent.BreathofSindragosa] or (tChosen[ids.Frost_Talent.Obliteration] and _PillarofFrost_CD >= 40)) and ConRO:FullMode(_AbominationLimb) then
			return _AbominationLimb;
		end
		
		if _FrostStrike_RDY and _RunicPower >= 73 and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
			return _FrostStrike;
		end	

		if _KillingMachine_BUFF then
			if _Frostscythe_RDY then
				return _Frostscythe;
			end
		else
			if _Obliterate_RDY and _Runes >= 4 and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 1) or ConRO_SingleButton:IsVisible()) then
				return _Obliterate;
			end
		end

		if _RemorselessWinter_RDY and not tChosen[ids.Frost_Talent.GatheringStorm] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			return _RemorselessWinter;
		end	

		if _DeathandDecay_RDY and not _DeathandDecay_BUFF and (((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) or _DeathandDecay == _DeathsDue) then
			return _DeathandDecay;
		end

		if _Frostscythe_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			return _Frostscythe;
		end
		
		if _Obliterate_RDY then
			return _Obliterate;
		end
		
		if _GlacialAdvance_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			return _GlacialAdvance;
		end	

		if _HornofWinter_RDY and _Runes <= 4 and _RunicPower <= _RunicPower_Max - 25 and not tChosen[ids.Frost_Talent.Obliteration] and (not tChosen[ids.Frost_Talent.BreathofSindragosa] or (tChosen[ids.Frost_Talent.BreathofSindragosa] and _BreathofSindragosa_CD >= 40)) and ConRO:FullMode(_HornofWinter) then
			return _HornofWinter;
		end
		
		if _DeathStrike_RDY and _DarkSuccor_BUFF and _Player_Percent_Health <= 85 then
			return _DeathStrike;
		end		

		if _FrostStrike_RDY and not tChosen[ids.Frost_Talent.IcyTalons] then
			return _FrostStrike;
		end
		
		return nil;
	end
end

function ConRO.DeathKnight.FrostDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Runes							 															= dkrunes();
	local _RunicPower, _RunicPower_Max																	= ConRO:PlayerPower('RunicPower');

--Abilities	
	local _DeathCoil, _DeathCoil_RDY					 												= ConRO:AbilityReady(ids.Frost_Ability.DeathCoil, timeShift);
	local _DeathStrike, _DeathStrike_RDY																= ConRO:AbilityReady(ids.Frost_Ability.DeathStrike, timeShift);
		local _DarkSuccor_BUFF																				= ConRO:Aura(ids.Frost_Buff.DarkSuccor, timeShift);
	local _IceboundFortitude, _IceboundFortitude_RDY													= ConRO:AbilityReady(ids.Frost_Ability.IceboundFortitude, timeShift);
	local _Lichborne, _Lichborne_RDY																	= ConRO:AbilityReady(ids.Frost_Ability.Lichborne, timeShift);
		local _Lichborne_BUFF							 													= ConRO:Aura(ids.Frost_Buff.Lichborne, timeShift);
	local _RaiseDead, _RaiseDead_RDY, _RaiseDead_CD														= ConRO:AbilityReady(ids.Frost_Ability.RaiseDead, timeShift);	
	local _SacrificialPact, _SacrificialPact_RDY														= ConRO:AbilityReady(ids.Frost_Ability.SacrificialPact, timeShift);
	
	local _DeathPact, _DeathPact_RDY																	= ConRO:AbilityReady(ids.Frost_Talent.DeathPact, timeShift);	
	
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

	if _SacrificialPact_RDY and _Player_Percent_Health <= 20 and _RaiseDead_CD > 60 then
		return _SacrificialPact;
	end

	if _DeathPact_RDY and _Player_Percent_Health <= 50 then
		return _DeathPact;
	end

	if _DeathCoil_RDY and _Lichborne_BUFF and _Player_Percent_Health <= 80 then
		return _DeathCoil;
	end
	
	if _Lichborne_RDY and _Player_Percent_Health <= 40 then
		return _Lichborne;
	end

	if _DeathStrike_RDY and ((_DarkSuccor_BUFF and _Player_Percent_Health <= 80) or _Player_Percent_Health <= 30) then
		return _DeathStrike;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end

	if _IceboundFortitude_RDY then
		return _IceboundFortitude;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
	
	return nil;
end

function ConRO.DeathKnight.Unholy(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Runes											 											= dkrunes();
	local _RunicPower, _RunicPower_Max																	= ConRO:PlayerPower('RunicPower');

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _Apocalypse, _Apocalypse_RDY, _Apocalypse_CD, _Apocalypse_MaxCD								= ConRO:AbilityReady(ids.Unholy_Ability.Apocalypse, timeShift);
	local _ArmyoftheDead, _ArmyoftheDead_RDY			 												= ConRO:AbilityReady(ids.Unholy_Ability.ArmyoftheDead, timeShift);
	local _DarkTransformation, _DarkTransformation_RDY, _DarkTransformation_CD							= ConRO:AbilityReady(ids.Unholy_Ability.DarkTransformation, timeShift);
		local _DarkTransformation_BUFF																		= ConRO:UnitAura(ids.Unholy_Buff.DarkTransformation, timeShift, "pet");	
	local _DeathandDecay, _DeathandDecay_RDY			 												= ConRO:AbilityReady(ids.Unholy_Ability.DeathandDecay, timeShift);
		local _DeathandDecay_BUFF																			= ConRO:Aura(ids.Unholy_Buff.DeathandDecay, timeShift);	
	local _DeathCoil, _DeathCoil_RDY																	= ConRO:AbilityReady(ids.Unholy_Ability.DeathCoil, timeShift);
		local _SuddenDoom_BUFF					 															= ConRO:Aura(ids.Unholy_Buff.SuddenDoom, timeShift);
	local _DeathStrike, _DeathStrike_RDY					 											= ConRO:AbilityReady(ids.Unholy_Ability.DeathStrike, timeShift);
		local _DarkSuccor_BUFF					 															= ConRO:Aura(ids.Unholy_Buff.DarkSuccor, timeShift);
	local _DeathsAdvance, _DeathsAdvance_RDY				 											= ConRO:AbilityReady(ids.Unholy_Ability.DeathsAdvance, timeShift);
	local _Epidemic, _Epidemic_RDY						 												= ConRO:AbilityReady(ids.Unholy_Ability.Epidemic, timeShift);
	local _FesteringStrike, _FesteringStrike_RDY				 										= ConRO:AbilityReady(ids.Unholy_Ability.FesteringStrike, timeShift);
		local _FesteringWound_DEBUFF, _FesteringWound_COUNT 												= ConRO:TargetAura(ids.Unholy_Debuff.FesteringWound, timeShift);
	local _MindFreeze, _MindFreeze_RDY																	= ConRO:AbilityReady(ids.Unholy_Ability.MindFreeze, timeShift);
	local _Outbreak, _Outbreak_RDY																		= ConRO:AbilityReady(ids.Unholy_Ability.Outbreak, timeShift);
		local _VirulentPlague_DEBUFF			 															= ConRO:TargetAura(ids.Unholy_Debuff.VirulentPlague, timeShift);
	local _RaiseDead, _RaiseDead_RDY					 												= ConRO:AbilityReady(ids.Unholy_Ability.RaiseDead, timeShift);
	local _ScourgeStrike, _ScourgeStrike_RDY				 											= ConRO:AbilityReady(ids.Unholy_Ability.ScourgeStrike, timeShift);

	local _Asphyxiate, _Asphyxiate_RDY																	= ConRO:AbilityReady(ids.Unholy_Talent.Asphyxiate, timeShift);
	local _ClawingShadows, _ClawingShadows_RDY															= ConRO:AbilityReady(ids.Unholy_Talent.ClawingShadows, timeShift);	
	local _Defile, _Defile_RDY																			= ConRO:AbilityReady(ids.Unholy_Talent.Defile, timeShift);
	local _SoulReaper, _SoulReaper_RDY					 												= ConRO:AbilityReady(ids.Unholy_Talent.SoulReaper, timeShift);
	local _SummonGargoyle, _SummonGargoyle_RDY, _SummonGargoyle_CD										= ConRO:AbilityReady(ids.Unholy_Talent.SummonGargoyle, timeShift);
	local _UnholyAssault, _UnholyAssault_RDY					 										= ConRO:AbilityReady(ids.Unholy_Talent.UnholyAssault, timeShift);
	local _UnholyBlight, _UnholyBlight_RDY, _UnholyBlight_CD, _UnholyBlight_MaxCD										= ConRO:AbilityReady(ids.Unholy_Talent.UnholyBlight, timeShift);
		local _UnholyBlight_DEBUFF																			= ConRO:TargetAura(ids.Unholy_Debuff.UnholyBlight, timeShift);
	local _WraithWalk, _WraithWalk_RDY					 												= ConRO:AbilityReady(ids.Unholy_Talent.WraithWalk, timeShift);
	
	local _NecroticStrike, _NecroticStrike_RDY															= ConRO:AbilityReady(ids.Unholy_PvPTalent.NecroticStrike, timeShift);
		local _NecroticStrike_DEBUFF, _, _NecroticStrike_DUR												= ConRO:TargetAura(ids.Unholy_Debuff.NecroticStrike, timeShift);
	local _RaiseAbomination, _RaiseAbomination_RDY														= ConRO:AbilityReady(ids.Unholy_PvPTalent.RaiseAbomination, timeShift);
	local _Transfusion, _Transfusion_RDY					 											= ConRO:AbilityReady(ids.Unholy_PvPTalent.Transfusion, timeShift);
		local _Transfusion_BUFF						 														= ConRO:Aura(ids.Unholy_Buff.Transfusion, timeShift);

	local _AbominationLimb, _AbominationLimb_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.AbominationLimb, timeShift);
	local _DeathsDue, _, _DeathsDue_CD																	= ConRO:AbilityReady(ids.Covenant_Ability.DeathsDue, timeShift);
	local _ShackletheUnworthy, _ShackletheUnworthy_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.ShackletheUnworthy, timeShift);
		local _ShackletheUnworthy_DEBUFF			 														= ConRO:TargetAura(ids.Blood_Debuff.ShackletheUnworthy, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _SwarmingMist, _SwarmingMist_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.SwarmingMist, timeShift);

	local _DeadliestCoil_EQUIPPED																		= ConRO:ItemEquipped(ids.Legendary.DeadliestCoil_Back) or ConRO:ItemEquipped(ids.Legendary.DeadliestCoil_Chest);

--Conditions	
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_execute																					= _Target_Percent_Health <= 36;
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	local _Ghoul_out																					= IsSpellKnown(ids.Unholy_PetAbility.Claw, true);
	
		if _is_PvP then
			if pvpChosen[ids.Unholy_PvPTalent.RaiseAbomination] then
				_ArmyoftheDead_RDY = _RaiseAbomination_RDY;
				_ArmyoftheDead = _RaiseAbomination;
			end	
		end

		if C_Covenants.GetActiveCovenantID() == 3 then
			_DeathandDecay_RDY = _DeathandDecay_RDY and _DeathsDue_CD <= 0;
			_DeathandDecay = _DeathsDue;
		end
		
--Indicators	
	ConRO:AbilityInterrupt(_MindFreeze, _MindFreeze_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_Asphyxiate, _Asphyxiate_RDY and (ConRO:Interrupt() and not _MindFreeze_RDY and _is_PC and _is_Enemy));
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_DeathsAdvance, _DeathsAdvance_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_WraithWalk, _WraithWalk_RDY and not _target_in_melee);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_ArmyoftheDead, _ArmyoftheDead_RDY);
	ConRO:AbilityBurst(_DarkTransformation, _in_combat and _DarkTransformation_RDY and _Ghoul_out and ConRO:BurstMode(_DarkTransformation));
	ConRO:AbilityBurst(_Apocalypse, _in_combat and _Apocalypse_RDY and _FesteringWound_COUNT >= 4 and ConRO:BurstMode(_Apocalypse));
	ConRO:AbilityBurst(_UnholyAssault, _in_combat and _UnholyAssault_RDY and _FesteringWound_COUNT < 3 and ConRO:BurstMode(_UnholyAssault));
	ConRO:AbilityBurst(_SummonGargoyle, _SummonGargoyle_RDY and _RunicPower >= 90 and _SuddenDoom_BUFF and ConRO:BurstMode(_SummonGargoyle));
	ConRO:AbilityBurst(_UnholyBlight, _UnholyBlight_RDY and not (_VirulentPlague_DEBUFF and _UnholyBlight_DEBUFF) and ConRO:BurstMode(_UnholyBlight));
		
	ConRO:AbilityBurst(_AbominationLimb, _AbominationLimb_RDY and ConRO:BurstMode(_AbominationLimb));
	ConRO:AbilityBurst(_ShackletheUnworthy, _ShackletheUnworthy_RDY and ConRO:BurstMode(_ShackletheUnworthy));
	ConRO:AbilityBurst(_SwarmingMist, _SwarmingMist_RDY and ConRO:BurstMode(_SwarmingMist));

--Warnings
	ConRO:Warnings("Call your ghoul!", _RaiseDead_RDY and not _Pet_summoned);

--Rotations
	if not _in_combat then
		if _Outbreak_RDY and not _VirulentPlague_DEBUFF and (not tChosen[ids.Unholy_Talent.UnholyBlight] or (tChosen[ids.Unholy_Talent.UnholyBlight] and (_UnholyBlight_CD >= 10 or ConRO:BurstMode(_UnholyBlight)))) then
			return _Outbreak;
		end
		
		if _FesteringStrike_RDY and _Runes >= 2 and (_FesteringWound_COUNT <= 0 or (_FesteringWound_COUNT <= 4 and (_Apocalypse_RDY or _Apocalypse_CD <= 10))) then
			return _FesteringStrike;
		end
		
		if _UnholyBlight_RDY and (_DarkTransformation_RDY or _DarkTransformation_BUFF) and not (_VirulentPlague_DEBUFF and _UnholyBlight_DEBUFF) and ConRO:FullMode(_UnholyBlight) then
			return _UnholyBlight;
		end
	end

	if _SummonGargoyle_RDY and _RunicPower >= 90 and _SuddenDoom_BUFF and ConRO:FullMode(_SummonGargoyle) then
		return _SummonGargoyle;
	end

	if _DeathCoil_RDY and ((_SummonGargoyle_CD >= 150 and tChosen[ids.Unholy_Talent.SummonGargoyle]) or (_DeadliestCoil_EQUIPPED and _DarkTransformation_BUFF)) then
		return _DeathCoil;
	end

	if _DeathStrike_RDY and _DarkSuccor_BUFF and _SummonGargoyle_CD >= 150 and tChosen[ids.Unholy_Talent.SummonGargoyle] then
		return _DeathStrike;
	end
	
	if _UnholyBlight_RDY and (_DarkTransformation_RDY or _DarkTransformation_BUFF) and not (_VirulentPlague_DEBUFF and _UnholyBlight_DEBUFF) and ConRO:FullMode(_UnholyBlight) then
		return _UnholyBlight;
	end		

	if _Outbreak_RDY and not _VirulentPlague_DEBUFF and (not tChosen[ids.Unholy_Talent.UnholyBlight] or (tChosen[ids.Unholy_Talent.UnholyBlight] and (_UnholyBlight_CD >= 10 or ConRO:BurstMode(_UnholyBlight))) or ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible())) then
		return _Outbreak;
	end
		
	if _SoulReaper_RDY and _Runes >= 1 and _can_execute then
		return _SoulReaper;
	end

	if _DarkTransformation_RDY and _Ghoul_out and ConRO:FullMode(_DarkTransformation) then
		return _DarkTransformation;
	end	

	if _Apocalypse_RDY and _FesteringWound_COUNT >= 4 and ConRO:FullMode(_Apocalypse) then
		return _Apocalypse;
	end

	if _UnholyAssault_RDY and _FesteringWound_COUNT < 3 and _Apocalypse_CD <= _Apocalypse_MaxCD - 3 and _Apocalypse_CD >= _Apocalypse_MaxCD - 15 and ConRO:FullMode(_UnholyAssault) then
		return _UnholyAssault;
	end	
		
	if (_RunicPower >= 80 or _SuddenDoom_BUFF) and not (tChosen[ids.Unholy_Talent.SummonGargoyle] and (_SummonGargoyle_RDY or _SummonGargoyle_CD <= 10)) and not (_DeadliestCoil_EQUIPPED and (_DarkTransformation_RDY or _DarkTransformation_CD <= 10)) then
		if (not _DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible())) or (_DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 4) or ConRO_AoEButton:IsVisible())) then
			if _Epidemic_RDY  then
				return _Epidemic;
			end
		else
			if _DeathCoil_RDY then
				return _DeathCoil;
			end
		end
	end

	if _SwarmingMist_RDY and ConRO:FullMode(_SwarmingMist) then
		return _SwarmingMist;
	end
		
	if _AbominationLimb_RDY and ConRO:FullMode(_AbominationLimb) then
		return _AbominationLimb;
	end
		
	if _ShackletheUnworthy_RDY and ConRO:FullMode(_ShackletheUnworthy) then
		return _ShackletheUnworthy;
	end
		
	if tChosen[ids.Unholy_Talent.Defile] then
		if _Defile_RDY then
			return _Defile;
		end
	else
		if _DeathandDecay_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() or tChosen[ids.Unholy_Talent.Pestilence]) then
			return _DeathandDecay;
		end
	end

	if ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and _DeathandDecay_BUFF then 
		if _ClawingShadows_RDY and tChosen[ids.Unholy_Talent.ClawingShadows] and ((_FesteringWound_COUNT >= 1 and (not _Apocalypse_RDY or _Apocalypse_CD > 5)) or (_FesteringWound_COUNT >= 5 and _Apocalypse_RDY)) then
			return _ClawingShadows;
		elseif _ScourgeStrike_RDY and not tChosen[ids.Unholy_Talent.ClawingShadows] and ((_FesteringWound_COUNT >= 1 and (not _Apocalypse_RDY or _Apocalypse_CD > 5)) or (_FesteringWound_COUNT >= 5 and _Apocalypse_RDY)) then
			return _ScourgeStrike;
		end
	end
		
	if _Epidemic_RDY and not (tChosen[ids.Unholy_Talent.SummonGargoyle] and (_SummonGargoyle_RDY or _SummonGargoyle_CD <= 10)) and ((not _DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible())) or (_DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 4) or ConRO_AoEButton:IsVisible()))) then
		return _Epidemic;
	end
		
	if _NecroticStrike_RDY and pvpChosen[ids.Unholy_PvPTalent.NecroticStrike] and _FesteringWound_COUNT >= 1 and (not _NecroticStrike_DEBUFF or (_NecroticStrike_DEBUFF and _NecroticStrike_DUR <= 4)) then
		return _NecroticStrike;
	end
		
	if _ClawingShadows_RDY and tChosen[ids.Unholy_Talent.ClawingShadows] and ((_FesteringWound_COUNT >= 1 and (not _Apocalypse_RDY or _Apocalypse_CD > 5)) or (_FesteringWound_COUNT >= 5 and _Apocalypse_RDY)) then
		return _ClawingShadows;
	elseif _ScourgeStrike_RDY and not tChosen[ids.Unholy_Talent.ClawingShadows] and ((_FesteringWound_COUNT >= 1 and (not _Apocalypse_RDY or _Apocalypse_CD > 5)) or (_FesteringWound_COUNT >= 5 and _Apocalypse_RDY)) then
		return _ScourgeStrike;
	end

	if _FesteringStrike_RDY and _Runes >= 2 and (_FesteringWound_COUNT <= 0 or (_FesteringWound_COUNT <= 4 and (_Apocalypse_RDY or _Apocalypse_CD <= 10))) then
		return _FesteringStrike;
	end
	
	if _Transfusion_RDY and _RunicPower <= 50 then
		return _Transfusion;
	end

	if _DeathStrike_RDY and (_DarkSuccor_BUFF or _Transfusion_BUFF) then
		return _DeathStrike;
	end

	if _DeathCoil_RDY and not (tChosen[ids.Unholy_Talent.SummonGargoyle] and (_SummonGargoyle_RDY or _SummonGargoyle_CD <= 10)) and ((not _DeadliestCoil_EQUIPPED and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee == 1) or ConRO_SingleButton:IsVisible())) or (_DeadliestCoil_EQUIPPED and (_DarkTransformation_RDY or _DarkTransformation_CD > 11) and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 3) or ConRO_SingleButton:IsVisible()))) then
		return _DeathCoil;
	end
		
	return nil;
end

function ConRO.DeathKnight.UnholyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Runes											 											= dkrunes();
	local _RunicPower, _RunicPower_Max																	= ConRO:PlayerPower('RunicPower');

--Abilities	
	local _DeathCoil, _DeathCoil_RDY																	= ConRO:AbilityReady(ids.Unholy_Ability.DeathCoil, timeShift);
	local _DeathStrike, _DeathStrike_RDY					 											= ConRO:AbilityReady(ids.Unholy_Ability.DeathStrike, timeShift);
		local _DarkSuccor_BUFF					 															= ConRO:Aura(ids.Unholy_Buff.DarkSuccor, timeShift);
	local _IceboundFortitude, _IceboundFortitude_RDY		 											= ConRO:AbilityReady(ids.Unholy_Ability.IceboundFortitude, timeShift);
	local _Lichborne, _Lichborne_RDY																	= ConRO:AbilityReady(ids.Unholy_Ability.Lichborne, timeShift);
		local _Lichborne_BUFF							 													= ConRO:Aura(ids.Unholy_Buff.Lichborne, timeShift);
	local _SacrificialPact, _SacrificialPact_RDY														= ConRO:AbilityReady(ids.Unholy_Ability.SacrificialPact, timeShift);
	
	local _DeathPact, _DeathPact_RDY					 												= ConRO:AbilityReady(ids.Unholy_Talent.DeathPact, timeShift);	

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');

--Rotations	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end

	if _SacrificialPact_RDY and _Player_Percent_Health <= 20 and _Pet_summoned then
		return _SacrificialPact;
	end

	if _DeathPact_RDY and _Player_Percent_Health <= 50 then
		return _DeathPact;
	end

	if _DeathCoil_RDY and _Lichborne_BUFF and _Player_Percent_Health <= 80 then
		return _DeathCoil;
	end

	if _Lichborne_RDY and _Player_Percent_Health <= 40 then
		return _Lichborne;
	end
	
	if _DeathStrike_RDY and ((_DarkSuccor_BUFF and _Player_Percent_Health <= 80) or _Player_Percent_Health <= 30) then
		return _DeathStrike;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _IceboundFortitude_RDY then
		return _IceboundFortitude;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
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