ConRO.Mage = {};
ConRO.Mage.CheckTalents = function()
end
ConRO.Mage.CheckPvPTalents = function()
end
local ConRO_Mage, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Mage.CheckTalents;
	self.ModuleOnEnable = ConRO.Mage.CheckPvPTalents;	
	if mode == 0 then
		self.Description = "Mage [No Specialization Under 10]";
		self.NextSpell = ConRO.Mage.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = "Mage [Arcane - Caster]";
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Mage.Arcane;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Mage.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 2 then
		self.Description = "Mage [Fire - Caster]";
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Mage.Fire;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Mage.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 3 then
		self.Description = "Mage [Frost - Caster]";
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.Mage.Frost;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Mage.Disabled;
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
		self.NextDef = ConRO.Mage.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Mage.ArcaneDef;
		else
			self.NextDef = ConRO.Mage.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Mage.FireDef;
		else
			self.NextDef = ConRO.Mage.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Mage.FrostDef;
		else
			self.NextDef = ConRO.Mage.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Mage.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Mage.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max, _Mana_Percent																= ConRO:PlayerPower('Mana');
	
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

function ConRO.Mage.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max, _Mana_Percent																= ConRO:PlayerPower('Mana');
	
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

function ConRO.Mage.Arcane(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max, _Mana_Percent																= ConRO:PlayerPower('Mana');
	local _ArcaneCharges 																				= ConRO:PlayerPower('ArcaneCharges');

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilties	
	local _ArcaneBarrage, _ArcaneBarrage_RDY 															= ConRO:AbilityReady(ids.Arc_Ability.ArcaneBarrage, timeShift);
	local _ArcaneBlast, _ArcaneBlast_RDY	 															= ConRO:AbilityReady(ids.Arc_Ability.ArcaneBlast, timeShift);
		local _RuleofThrees_BUFF 																			= ConRO:Aura(ids.Arc_Buff.RuleofThrees, timeShift);
	local _ArcaneExplosion, _ArcaneExplosion_RDY														= ConRO:AbilityReady(ids.Arc_Ability.ArcaneExplosion, timeShift);
	local _ArcaneIntellect, _ArcaneIntellect_RDY														= ConRO:AbilityReady(ids.Arc_Ability.ArcaneIntellect, timeShift);
	local _ArcaneMissiles, _ArcaneMissiles_RDY 															= ConRO:AbilityReady(ids.Arc_Ability.ArcaneMissiles, timeShift);
		local _Clearcasting_BUFF 																			= ConRO:Aura(ids.Arc_Buff.Clearcasting, timeShift);	
		local _Clearcasting_PvP_BUFF 																		= ConRO:Aura(ids.Arc_Buff.ClearcastingPvP, timeShift);	
	local _ArcanePower, _ArcanePower_RDY, _ArcanePower_CD 												= ConRO:AbilityReady(ids.Arc_Ability.ArcanePower, timeShift);
		local _ArcanePower_BUFF, _, _ArcanePower_DUR														= ConRO:Aura(ids.Arc_Buff.ArcanePower, timeShift);
	local _Blink, _Blink_RDY																			= ConRO:AbilityReady(ids.Arc_Ability.Blink, timeShift);
	local _ConjureManaGem, _ConjureManaGem_RDY															= ConRO:AbilityReady(ids.Arc_Ability.ConjureManaGem, timeShift);
		local _ManaGem, _ManaGem_RDY, _, _, _ManaGem_COUNT													= ConRO:ItemReady(ids.Arc_Ability.ManaGem, timeShift);
	local _Counterspell, _Counterspell_RDY 																= ConRO:AbilityReady(ids.Arc_Ability.Counterspell, timeShift);
	local _Evocation, _Evocation_RDY, _Evocation_CD														= ConRO:AbilityReady(ids.Arc_Ability.Evocation, timeShift);
		local _Evocation_BUFF 																				= ConRO:Aura(ids.Arc_Buff.Evocation, timeShift);
	local _PresenceofMind, _PresenceofMind_RDY 															= ConRO:AbilityReady(ids.Arc_Ability.PresenceofMind, timeShift);
		local _PresenceofMind_BUFF 																			= ConRO:Form(ids.Arc_Form.PresenceofMind, timeShift);
	local _Spellsteal, _Spellsteal_RDY 																	= ConRO:AbilityReady(ids.Arc_Ability.Spellsteal, timeShift);
	local _TouchoftheMagi, _TouchoftheMagi_RDY, _TouchoftheMagi_CD										= ConRO:AbilityReady(ids.Arc_Ability.TouchoftheMagi, timeShift);
		local _TouchoftheMagi_DEBUFF 																		= ConRO:TargetAura(ids.Arc_Debuff.TouchoftheMagi, timeShift);

	local _ArcaneFamiliar, _ArcaneFamiliar_RDY															= ConRO:AbilityReady(ids.Arc_Talent.ArcaneFamiliar, timeShift);
		local _ArcaneFamiliar_BUFF 																			= ConRO:Aura(ids.Arc_Buff.ArcaneFamiliar, timeShift);
	local _ArcaneOrb, _ArcaneOrb_RDY 																	= ConRO:AbilityReady(ids.Arc_Talent.ArcaneOrb, timeShift);
	local _NetherTempest, _NetherTempest_RDY 															= ConRO:AbilityReady(ids.Arc_Talent.NetherTempest, timeShift);
		local _NetherTempest_DEBUFF 																		= ConRO:TargetAura(ids.Arc_Debuff.NetherTempest, timeShift + 3);
	local _RuneofPower, _RuneofPower_RDY				  												= ConRO:AbilityReady(ids.Arc_Talent.RuneofPower, timeShift);
		local _RuneofPower_CHARGES																			= ConRO:SpellCharges(ids.Arc_Talent.RuneofPower);
		local _RuneofPower_BUFF 																			= ConRO:Form(ids.Arc_Form.RuneofPower, timeShift);
	local _Shimmer, _Shimmer_RDY 																		= ConRO:AbilityReady(ids.Arc_Talent.Shimmer, timeShift);
	local _Supernova, _Supernova_RDY 																	= ConRO:AbilityReady(ids.Arc_Talent.Supernova, timeShift);

	local _Deathborne, _Deathborne_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Deathborne, timeShift);
	local _MirrorsofTorment, _MirrorsofTorment_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.MirrorsofTorment, timeShift);
		local _MirrorsofTorment_DEBUFF																		= ConRO:TargetAura(ids.Covenant_Debuff.MirrorsofTorment, timeShift);		
	local _RadiantSpark, _RadiantSpark_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.RadiantSpark, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _ShiftingPower, _ShiftingPower_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.ShiftingPower, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	if currentSpell == _ArcaneBlast then
		_ArcaneCharges = _ArcaneCharges + 1;
	end
	if currentSpell == _TouchoftheMagi then
		_ArcaneCharges = 4;
	end
	
	local _Mana_Threshold = 60;
		if tChosen[ids.Arc_Talent.Enlightened] then
			_Mana_Threshold = 80;
		end
	
	if _is_PvP then
		if pvpChosen[ids.Arc_PvPTalent.ArcaneEmpowerment] then
			_Clearcasting_BUFF = _Clearcasting_PvP_BUFF;
		end
	end

--Indicators	
	ConRO:AbilityInterrupt(_Counterspell, _Counterspell_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Spellsteal, _Spellsteal_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_10yrds and ConRO:Purgable());
	ConRO:AbilityMovement(_Blink, _Blink_RDY and not tChosen[ids.Arc_Talent.Shimmer] and _target_in_melee);
	ConRO:AbilityMovement(_Shimmer, _Shimmer_RDY and _target_in_melee);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityRaidBuffs(_ArcaneIntellect, _ArcaneIntellect_RDY and not ConRO:RaidBuff(ids.Arc_Buff.ArcaneIntellect));
	
	ConRO:AbilityBurst(_ArcanePower, _ArcanePower_RDY and (_Evocation_RDY or _Evocation_CD < 15) and ConRO:BurstMode(_ArcanePower));
	ConRO:AbilityBurst(_PresenceofMind, _PresenceofMind_RDY and not _PresenceofMind_BUFF and _ArcanePower_BUFF and _ArcanePower_DUR <= 3 and ConRO:BurstMode(_PresenceofMind));
	ConRO:AbilityBurst(_RuneofPower, _RuneofPower_RDY and not _RuneofPower_BUFF and not _ArcanePower_BUFF and currentSpell ~= _RuneofPower and ConRO:BurstMode(_RuneofPower));
	ConRO:AbilityBurst(_TouchoftheMagi, _TouchoftheMagi_RDY and _ArcaneCharges <= 0 and currentSpell ~= _TouchoftheMagi and ConRO:BurstMode(_TouchoftheMagi));

	ConRO:AbilityBurst(_Deathborne, _Deathborne_RDY and _in_combat and currentSpell ~= _Deathborne and ConRO:BurstMode(_Deathborne));
	ConRO:AbilityBurst(_MirrorsofTorment, _MirrorsofTorment_RDY and _in_combat and currentSpell ~= _MirrorsofTorment and ConRO:BurstMode(_MirrorsofTorment));
	ConRO:AbilityBurst(_ShiftingPower, _ShiftingPower_RDY and _target_in_10yrds and not _ArcanePower_RDY and not _Evocation_RDY and not _TouchoftheMagi_RDY and ConRO:BurstMode(_ShiftingPower));
		
--Warnings	
	
--Rotations
	if _Evocation_BUFF and _Mana < _Mana_Max then
		return _Evocation;
	end

	if not _in_combat then
		if _ConjureManaGem_RDY and _ManaGem_COUNT <= 0 then
			return _ConjureManaGem;
		end

		if _ArcaneBlast_RDY and currentSpell ~= _ArcaneBlast and currentSpell ~= _TouchoftheMagi then
			return _ArcaneBlast;
		end

		if _ArcaneBarrage_RDY and _TouchoftheMagi_RDY and _ArcaneCharges >= 4 and currentSpell ~= _TouchoftheMagi then
			return _ArcaneBarrage;
		end
		
		if _TouchoftheMagi_RDY and currentSpell ~= _TouchoftheMagi and ConRO:FullMode(_TouchoftheMagi) then
			return _TouchoftheMagi;
		end
	end
	
	if _ArcanePower_BUFF or (not _ArcanePower_RDY and _ArcanePower_CD >= 30 and (_Evocation_RDY or _Evocation_CD < 30)) then
		if _RadiantSpark_RDY and currentSpell ~= _RadiantSpark then
			return _RadiantSpark;
		end

		if _Deathborne_RDY and currentSpell ~= _Deathborne and ConRO:FullMode(_Deathborne) then
			return _Deathborne;
		end		

		if _MirrorsofTorment_RDY and currentSpell ~= _MirrorsofTorment and ConRO:FullMode(_MirrorsofTorment) then
			return _MirrorsofTorment;
		end

		if _ArcaneOrb_RDY and not _TouchoftheMagi_RDY and _ArcaneCharges <= 3 and currentSpell ~= _TouchoftheMagi then
			return _ArcaneOrb;
		end

		if _NetherTempest_RDY and _ArcaneCharges >= 4 and not _NetherTempest_DEBUFF and not _ArcanePower_BUFF and not _RuneofPower_BUFF then
			return _NetherTempest;
		end

		if _ManaGem_RDY and _ManaGem_COUNT > 0 and _Mana_Percent <= 85 and not _ArcanePower_BUFF then
			return _ManaGem;
		end

		if _RuneofPower_RDY and not _RuneofPower_BUFF and not _ArcanePower_BUFF and currentSpell ~= _RuneofPower and ConRO:FullMode(_RuneofPower) then
			return _RuneofPower;
		end
		
		if _TouchoftheMagi_RDY and currentSpell ~= _TouchoftheMagi then
			return _TouchoftheMagi;
		end
		
		if _PresenceofMind_RDY and not _PresenceofMind_BUFF and _ArcanePower_BUFF and _ArcanePower_DUR <= 3 and ConRO:FullMode(_PresenceofMind) then
			return _PresenceofMind;
		end
			
		if ConRO_AoEButton:IsVisible() then
			if _ArcaneBarrage_RDY and _ArcaneCharges >= 4 then
				return _ArcaneBarrage;
			end
			
			if _ArcaneExplosion_RDY then
				return _ArcaneExplosion;
			end			
		else
			if _ArcaneMissiles_RDY and ((_Clearcasting_BUFF and _Mana_Percent < 95 and _TouchoftheMagi_CD > 10) or (_TouchoftheMagi_DEBUFF and (tChosen[ids.Arc_Talent.ArcaneEcho] or _Clearcasting_BUFF))) then
				return _ArcaneMissiles;
			end	
		
			if _ArcaneBlast_RDY then
				return _ArcaneBlast;
			end
		end
		
		if _Evocation_RDY then
			return _Evocation;
		end	
	end
	
	if _ArcanePower_RDY and (_Evocation_RDY or _Evocation_CD < 30) and ConRO:FullMode(_ArcanePower) then 
		if _ArcaneBarrage_RDY and _TouchoftheMagi_RDY and _ArcaneCharges >= 4 and currentSpell ~= _TouchoftheMagi then
			return _ArcaneBarrage;
		end

		if _ArcanePower_RDY and _TouchoftheMagi_DEBUFF or currentSpell == _TouchoftheMagi then
			return _ArcanePower;
		end	
		
		if _RadiantSpark_RDY and currentSpell ~= _RadiantSpark then
			return _RadiantSpark;
		end
		
		if _Deathborne_RDY and currentSpell ~= _Deathborne and ConRO:FullMode(_Deathborne) then
			return _Deathborne;
		end		

		if _MirrorsofTorment_RDY and currentSpell ~= _MirrorsofTorment and ConRO:FullMode(_MirrorsofTorment) then
			return _MirrorsofTorment;
		end
		
		if _TouchoftheMagi_RDY and currentSpell ~= _TouchoftheMagi and ConRO:FullMode(_TouchoftheMagi) then
			return _TouchoftheMagi;
		end

		if _ArcaneOrb_RDY and not _TouchoftheMagi_RDY and _ArcaneCharges <= 3 and currentSpell ~= _TouchoftheMagi then
			return _ArcaneOrb;
		end

		if _NetherTempest_RDY and _ArcaneCharges >= 4 and not _NetherTempest_DEBUFF then
			return _NetherTempest;
		end
		
		if _ArcaneBlast_RDY and _ArcaneCharges < 4 and currentSpell ~= _TouchoftheMagi then
			return _ArcaneBlast;
		end
		
	elseif _TouchoftheMagi_DEBUFF or currentSpell == _TouchoftheMagi then
		if _ArcaneMissiles_RDY and (tChosen[ids.Arc_Talent.ArcaneEcho] or _Clearcasting_BUFF) then
			return _ArcaneMissiles;
		end
		
		if _ArcaneBlast_RDY then
			return _ArcaneBlast;
		end	
	else
		if _ShiftingPower_RDY and _target_in_10yrds and not _ArcanePower_RDY and not _Evocation_RDY and not _TouchoftheMagi_RDY and ConRO:FullMode(_ShiftingPower) then
			return _ShiftingPower;
		end

		if _RuneofPower_RDY and not _RuneofPower_BUFF and _TouchoftheMagi_RDY and _ArcanePower_CD >= 42 and currentSpell ~= _RuneofPower and ConRO:FullMode(_RuneofPower) then
			return _RuneofPower;
		end

		if _ArcaneBarrage_RDY and _ArcaneCharges >= 1 and _TouchoftheMagi_RDY and _ArcanePower_CD >= 40 and currentSpell ~= ids.Arc_Ability.TouchoftheMagi then
			return _ArcaneBarrage;
		end
			
		if _TouchoftheMagi_RDY and _ArcanePower_CD >= 40 and currentSpell ~= _TouchoftheMagi and ConRO:FullMode(_TouchoftheMagi) then
			return _TouchoftheMagi;
		end
		
		if _RadiantSpark_RDY and currentSpell ~= _RadiantSpark then
			return _RadiantSpark;
		end

		if _NetherTempest_RDY and _ArcaneCharges >= 4 and not _NetherTempest_DEBUFF then
			return _NetherTempest;
		end	

		if _ArcaneOrb_RDY and not _TouchoftheMagi_RDY and _ArcaneCharges <= 3 and currentSpell ~= _TouchoftheMagi then
			return _ArcaneOrb;
		end

		if _ArcaneBlast_RDY and _RuleofThrees_BUFF then
			return _ArcaneBlast;
		end

		if _Supernova_RDY then
			return _Supernova;
		end
		
		if ConRO_AoEButton:IsVisible() then
			if _ArcaneExplosion_RDY and _Clearcasting_BUFF then
				return _ArcaneExplosion;
			end
			
			if _ArcaneBarrage_RDY and _ArcaneCharges >= 4 and (_Mana_Percent < _Mana_Threshold) then
				return _ArcaneBarrage;
			end

			if _ArcaneExplosion_RDY then
				return _ArcaneExplosion;
			end
		else
			if _ArcaneMissiles_RDY and _Clearcasting_BUFF and _Mana_Percent < 95 and _TouchoftheMagi_CD > 10 then
				return _ArcaneMissiles;
			end

			if _ArcaneBarrage_RDY and _ArcaneCharges >= 2 and _Mana_Percent < _Mana_Threshold then
				return _ArcaneBarrage;
			end
		end

		if _ArcaneBlast_RDY then
			return _ArcaneBlast;
		end
	end
return nil;		
end

function ConRO.Mage.ArcaneDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max, _Mana_Percent																= ConRO:PlayerPower('Mana');
	
--Abilties
	local _PrismaticBarrier, _PrismaticBarrier_RDY 														= ConRO:AbilityReady(ids.Arc_Ability.PrismaticBarrier, timeShift);
		local _PrismaticBarrier_BUFF 																		= ConRO:Aura(ids.Arc_Buff.PrismaticBarrier, timeShift);
	local _IceBlock, _IceBlock_RDY 																		= ConRO:AbilityReady(ids.Arc_Ability.IceBlock, timeShift);
	local _MirrorImage, _MirrorImage_RDY 																= ConRO:AbilityReady(ids.Arc_Ability.MirrorImage, timeShift);

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
	
	if _IceBlock_RDY and _Player_Percent_Health <= 25 and _in_combat then
		return _IceBlock;
	end

	if _PrismaticBarrier_RDY and not _PrismaticBarrier_BUFF then
		return _PrismaticBarrier;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _MirrorImage_RDY and _in_combat then
		return _MirrorImage;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Mage.Fire(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max, _Mana_Percent																= ConRO:PlayerPower('Mana');
	
--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local _ArcaneIntellect, _ArcaneIntellect_RDY														= ConRO:AbilityReady(ids.Fire_Ability.ArcaneIntellect, timeShift);
	local _Blink, _Blink_RDY																			= ConRO:AbilityReady(ids.Fire_Ability.Blink, timeShift);
	local _Combustion, _Combustion_RDY, _Combustion_CD													= ConRO:AbilityReady(ids.Fire_Ability.Combustion, timeShift);
		local _Combustion_BUFF, _, _Combustion_DUR														= ConRO:Aura(ids.Fire_Buff.Combustion, timeShift);
	local _Counterspell,  _Counterspell_RDY 															= ConRO:AbilityReady(ids.Fire_Ability.Counterspell, timeShift);
	local _DragonsBreath, _DragonsBreath_RDY 															= ConRO:AbilityReady(ids.Fire_Ability.DragonsBreath, timeShift);
	local _FireBlast, _FireBlast_RDY																	= ConRO:AbilityReady(ids.Fire_Ability.FireBlast, timeShift);
		local _FireBlast_CHARGES 																			= ConRO:SpellCharges(ids.Fire_Ability.FireBlast);
	local _Fireball, _Fireball_RDY 																		= ConRO:AbilityReady(ids.Fire_Ability.Fireball, timeShift);
		local _HeatingUp_BUFF																				= ConRO:Aura(ids.Fire_Buff.HeatingUp, timeShift);
		local _HotStreak_BUFF 																				= ConRO:Aura(ids.Fire_Buff.HotStreak, timeShift);
	local _Flamestrike, _Flamestrike_RDY 																= ConRO:AbilityReady(ids.Fire_Ability.Flamestrike, timeShift);
	local _Pyroblast, _Pyroblast_RDY, _, _Pyroblast_MaxCD, _Pyroblast_CAST								= ConRO:AbilityReady(ids.Fire_Ability.Pyroblast, timeShift);		
		local _Pyroclasm_BUFF, _Pyroclasm_COUNT																= ConRO:Aura(ids.Fire_Buff.Pyroclasm, timeShift);
	local _PhoenixFlames, _PhoenixFlames_RDY															= ConRO:AbilityReady(ids.Fire_Ability.PhoenixFlames, timeShift);
		local _PhoenixFlames_CHARGES, _, _PhoenixFlames_CCD													= ConRO:SpellCharges(ids.Fire_Ability.PhoenixFlames);
	local _Scorch, _Scorch_RDY 																			= ConRO:AbilityReady(ids.Fire_Ability.Scorch, timeShift);
	local _Spellsteal, _Spellsteal_RDY 																	= ConRO:AbilityReady(ids.Fire_Ability.Spellsteal, timeShift);

	local _LivingBomb, _LivingBomb_RDY 																	= ConRO:AbilityReady(ids.Fire_Talent.LivingBomb, timeShift);	
	local _Meteor, _Meteor_RDY 																			= ConRO:AbilityReady(ids.Fire_Talent.Meteor, timeShift);
	local _RuneofPower, _RuneofPower_RDY																= ConRO:AbilityReady(ids.Fire_Talent.RuneofPower, timeShift);
		local _RuneofPower_CHARGES, _, _RuneofPower_CCD														= ConRO:SpellCharges(ids.Fire_Talent.RuneofPower);
		local _RuneofPower_BUFF 																			= ConRO:Form(ids.Fire_Form.RuneofPower);
	local _Shimmer, _Shimmer_RDY 																		= ConRO:AbilityReady(ids.Fire_Talent.Shimmer, timeShift);

	local _Deathborne, _Deathborne_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Deathborne, timeShift);
	local _MirrorsofTorment, _MirrorsofTorment_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.MirrorsofTorment, timeShift);
		local _MirrorsofTorment_DEBUFF																		= ConRO:TargetAura(ids.Covenant_Debuff.MirrorsofTorment, timeShift);		
	local _RadiantSpark, _RadiantSpark_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.RadiantSpark, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _ShiftingPower, _ShiftingPower_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.ShiftingPower, timeShift);

		local _InfernalCascade_BUFF, _InfernalCascade_COUNT, _InfernalCascade_DUR							= ConRO:Aura(ids.Conduit_Buff.InfernalCascade, timeShift);
	
		local _Firestorm_BUFF																				= ConRO:Aura(ids.Legendary_Buff.Firestorm, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
		if currentSpell == _Pyroblast then
			_Pyroclasm_COUNT = _Pyroclasm_COUNT - 1;
		end

--Indicators	
	ConRO:AbilityInterrupt(_Counterspell, _Counterspell_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Spellsteal, _Spellsteal_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_10yrds and ConRO:Purgable());
	ConRO:AbilityMovement(_Blink, _Blink_RDY and not tChosen[ids.Fire_Talent.Shimmer] and _target_in_melee);
	ConRO:AbilityMovement(_Shimmer, _Shimmer_RDY and _target_in_melee);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityRaidBuffs(_ArcaneIntellect, _ArcaneIntellect_RDY and not ConRO:RaidBuff(ids.Fire_Buff.ArcaneIntellect));

	ConRO:AbilityBurst(_Combustion, _Combustion_RDY and _HotStreak_BUFF and (currentSpell == _Fireball or currentSpell == _Scorch) and ConRO:BurstMode(_Combustion));
	ConRO:AbilityBurst(_Meteor, _Meteor_RDY and (((not tChosen[ids.Fire_Talent.RuneofPower] or (tChosen[ids.Fire_Talent.RuneofPower] and (_RuneofPower_BUFF or currentSpell == _RuneofPower)) or _Combustion_CD > 40) and not _Combustion_RDY) or _Combustion_BUFF) and ConRO:BurstMode(_Meteor));
		
	ConRO:AbilityBurst(_Deathborne, _Deathborne_RDY and _in_combat and currentSpell ~= _Deathborne and ConRO:BurstMode(_Deathborne));
	ConRO:AbilityBurst(_MirrorsofTorment, _MirrorsofTorment_RDY and _in_combat and currentSpell ~= _MirrorsofTorment and ConRO:BurstMode(_MirrorsofTorment));
	ConRO:AbilityBurst(_ShiftingPower, _ShiftingPower_RDY and _target_in_10yrds and not _Combustion_RDY and ConRO:BurstMode(_ShiftingPower));
	
--Warnings	

--Rotations	
	if not _in_combat then
		if ConRO_AoEButton:IsVisible() then
			if _Flamestrike_RDY and currentSpell ~= _Flamestrike  then
				return _Flamestrike;
			end
			
			if _FireBlast_RDY and not _HotStreak_BUFF and currentSpell == _Flamestrike then
				return _FireBlast;
			end
		else
			if _Pyroblast_RDY and currentSpell ~= _Pyroblast then
				return _Pyroblast;
			end
			
			if _Fireball_RDY and currentSpell ~= _Fireball then
				return _Fireball;
			end
		end
	elseif tChosen[ids.Fire_Talent.Firestarter] and _Target_Percent_Health >= 90 then
		if _Pyroblast_RDY and _Pyroclasm_BUFF and _Pyroclasm_COUNT >= 1 then
			return _Pyroblast;
		end

		if _FireBlast_RDY and not _HeatingUp_BUFF and not _HotStreak_BUFF then
			return _FireBlast;
		end	
		
		if _Pyroblast_RDY and ((_HeatingUp_BUFF and currentSpell ~= _Pyroblast) or (_HotStreak_BUFF and currentSpell == _Fireball)) then
			return _Pyroblast;
		end

		if _Fireball_RDY and _HotStreak_BUFF and currentSpell ~= _Fireball then
			return _Fireball;
		end
		
		if _Fireball_RDY and currentSpell ~= _Fireball then
			return _Fireball;
		end
	elseif _Firestorm_BUFF then
		if ConRO_AoEButton:IsVisible() then
			if _Flamestrike_RDY then
				return _Flamestrike;
			end
		else
			if _Pyroblast_RDY then
				return _Pyroblast;
			end
		end		
	elseif _Combustion_BUFF then
		if _FireBlast_RDY and ConRO:ConduitChosen(ids.Conduit.InfernalCascade) and (_InfernalCascade_BUFF and _InfernalCascade_DUR < 1.5) then
			return _FireBlast;
		end

		if ConRO_AoEButton:IsVisible() then
			if _Flamestrike_RDY and _HotStreak_BUFF or (_HeatingUp_BUFF  and (currentSpell == _Scorch or currentSpell == _Flamestrike)) then
				return _Flamestrike;
			end
		else
			if _Pyroblast_RDY and _HotStreak_BUFF or (_HeatingUp_BUFF and (currentSpell == _Scorch or currentSpell == _Pyroblast)) then
				return _Pyroblast;
			end
		end

		if _Meteor_RDY and ConRO:FullMode(_Meteor) then
			return _Meteor;
		end

		if _DragonsBreath_RDY and _target_in_10yrds and not _PhoenixFlames_RDY and not _FireBlast_RDY and ((_HeatingUp_BUFF and tChosen[ids.Fire_Talent.AlexstraszasFury]) or ConRO.lastSpellId == _Pyroblast) then
			return _DragonsBreath;
		end
		
		if _PhoenixFlames_RDY and (not _FireBlast_RDY or _PhoenixFlames_CHARGES >= 3) and (_HeatingUp_BUFF or ConRO.lastSpellId == _Pyroblast or ConRO.lastSpellId == _Flamestrike) then
			return _PhoenixFlames;
		end
		
		if _FireBlast_RDY and (_HeatingUp_BUFF or ConRO.lastSpellId == _Pyroblast or ConRO.lastSpellId == _Flamestrike) then
			return _FireBlast;
		end

		if not ConRO_AoEButton:IsVisible() then
			if _Pyroblast_RDY and _Pyroclasm_BUFF and _Pyroclasm_COUNT >= 1 and _Combustion_DUR < _Pyroblast_CAST + 0.5 then
				return _Pyroblast;
			end
		end
		
		if _Scorch_RDY then
			return _Scorch;
		end	
	else
		if ConRO_AoEButton:IsVisible() then
			if _FireBlast_RDY and not _HotStreak_BUFF and (_Combustion_RDY or ((_FireBlast_CHARGES >= 1 and _Combustion_CD >= 20) or (_FireBlast_CHARGES >= 2 and _Combustion_CD >= 10) or _FireBlast_CHARGES >= 3)) and (currentSpell == _Scorch or currentSpell == _Flamestrike) then
				return _FireBlast;
			end
		else
			if _FireBlast_RDY and ((_Combustion_RDY and not _HotStreak_BUFF) or (_HeatingUp_BUFF and ((_FireBlast_CHARGES >= 1 and _Combustion_CD >= 20) or (_FireBlast_CHARGES >= 2 and _Combustion_CD >= 10) or _FireBlast_CHARGES >= 3))) and (currentSpell == _Fireball or currentSpell == _Scorch or currentSpell == _Pyroblast or currentSpell == _Flamestrike) then
				return _FireBlast;
			end
		end

		if _Combustion_RDY and _HotStreak_BUFF and (currentSpell == ids.Fire_Ability.Fireball or currentSpell == ids.Fire_Ability.Scorch or currentSpell == ids.Fire_Ability.Pyroblast or currentSpell == ids.Fire_Ability.Flamestrike) and ConRO_FullButton:IsVisible() then
			return _Combustion;
		end

		if ConRO_AoEButton:IsVisible() then
			if _Flamestrike_RDY and _HotStreak_BUFF and (currentSpell == _Fireball or currentSpell == _Scorch or currentSpell == _Flamestrike) then
				return _Flamestrike;
			end
		else
			if _Pyroblast_RDY and _HotStreak_BUFF and (currentSpell == _Fireball or currentSpell == _Scorch or currentSpell == _Pyroblast) then
				return _Pyroblast;
			end
		end
		
		if _Deathborne_RDY and ConRO:FullMode(_Deathborne) then
			return _Deathborne;
		end

		if _ShiftingPower_RDY and _target_in_10yrds and not _Combustion_RDY and ConRO:FullMode(_ShiftingPower) then
			return _ShiftingPower;
		end
		
		if _RadiantSpark_RDY and currentSpell ~= _RadiantSpark then
			return _RadiantSpark;
		end

		if _MirrorsofTorment_RDY and currentSpell ~= _MirrorsofTorment and ConRO:FullMode(_MirrorsofTorment) then
			return _MirrorsofTorment;
		end
	
		if _RuneofPower_RDY and not _Combustion_RDY and not _RuneofPower_BUFF and (_RuneofPower_CHARGES >= 2 or (_RuneofPower_CHARGES ==1 and _RuneofPower_CCD <= 2) or _Pyroclasm_BUFF or _Meteor_RDY or (not tChosen[ids.Fire_Talent.Meteor] and not tChosen[ids.Fire_Talent.Pyroclasm])) and (_Combustion_CD > 40 or not _in_combat) and currentSpell ~= _RuneofPower and ConRO:FullMode(_RuneofPower) then
			return _RuneofPower;
		end

		if _Meteor_RDY and (not tChosen[ids.Fire_Talent.RuneofPower] or (tChosen[ids.Fire_Talent.RuneofPower] and (_RuneofPower_BUFF or currentSpell == _RuneofPower)) or _Combustion_CD > 40) and not _Combustion_RDY and ConRO:FullMode(_Meteor) then
			return _Meteor;
		end
	
		if _HotStreak_BUFF and currentSpell ~= _Fireball and currentSpell ~= _Scorch and not ConRO_AoEButton:IsVisible() then
			if _Scorch_RDY and (_is_moving or (tChosen[ids.Fire_Talent.SearingTouch] and _Target_Percent_Health <= 30)) then
				return _Scorch;
			elseif _Fireball_RDY then
				return _Fireball;
			end		
		end
		
		if _Pyroblast_RDY and _Pyroclasm_BUFF and _Pyroclasm_COUNT >= 1 and not _Combustion_RDY and not ConRO_AoEButton:IsVisible() then
			return _Pyroblast;
		end

		if _PhoenixFlames_RDY and not _HeatingUp_BUFF and ((_PhoenixFlames_CHARGES >= 1 and _Combustion_CD >= 50) or (_PhoenixFlames_CHARGES >= 2 and _Combustion_CD >= 25) or _PhoenixFlames_CHARGES >= 3) then
			return _PhoenixFlames;
		end

		if _DragonsBreath_RDY and _target_in_10yrds and ((_HeatingUp_BUFF and tChosen[ids.Fire_Talent.AlexstraszasFury]) or ConRO_AoEButton:IsVisible()) then
			return _DragonsBreath;
		end
		
		if _LivingBomb_RDY and ConRO_AoEButton:IsVisible() then
			return _LivingBomb;
		end
		
		if (_is_moving or (tChosen[ids.Fire_Talent.SearingTouch] and _Target_Percent_Health <= 30)) then
			if _Scorch_RDY then
				return _Scorch;
			end
		elseif ConRO_AoEButton:IsVisible() then
			if _Flamestrike_RDY then
				return _Flamestrike;
			end
		else
			if _Fireball_RDY then
				return _Fireball;
			end
		end
	end
end

function ConRO.Mage.FireDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max, _Mana_Percent																= ConRO:PlayerPower('Mana');
	
--Abilities	
	local _BlazingBarrier, _BlazingBarrier_RDY 															= ConRO:AbilityReady(ids.Fire_Ability.BlazingBarrier, timeShift);
		local _BlazingBarrier_BUFF 																			= ConRO:Aura(ids.Fire_Buff.BlazingBarrier, timeShift);
	local _IceBlock, _IceBlock_RDY 																		= ConRO:AbilityReady(ids.Fire_Ability.IceBlock, timeShift);
	local _MirrorImage, _MirrorImage_RDY 																= ConRO:AbilityReady(ids.Fire_Ability.MirrorImage, timeShift);

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
	
	if _IceBlock_RDY and _Player_Percent_Health <= 25 and _in_combat then
		return _IceBlock;
	end

	if _BlazingBarrier_RDY and not _BlazingBarrier_BUFF then
		return _BlazingBarrier;
	end
	
	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _MirrorImage_RDY and _in_combat then
		return _MirrorImage;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Mage.Frost(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max, _Mana_Percent																= ConRO:PlayerPower('Mana');

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local _ArcaneExplosion, _ArcaneExplosion_RDY														= ConRO:AbilityReady(ids.Frost_Ability.ArcaneExplosion, timeShift);
	local _ArcaneIntellect, _ArcaneIntellect_RDY														= ConRO:AbilityReady(ids.Frost_Ability.ArcaneIntellect, timeShift);
	local _Blink, _Blink_RDY																			= ConRO:AbilityReady(ids.Frost_Ability.Blink, timeShift);
	local _Blizzard, _Blizzard_RDY																		= ConRO:AbilityReady(ids.Frost_Ability.Blizzard, timeShift);
		local _FreezingRain_BUFF																			= ConRO:Aura(ids.Frost_Buff.FreezingRain, timeShift);
	local _ConeofCold_RDY																				= ConRO:AbilityReady(ids.Frost_Ability.ConeofCold, timeShift);
	local _Counterspell, _Counterspell_RDY 																= ConRO:AbilityReady(ids.Frost_Ability.Counterspell, timeShift);
	local _Flurry, _Flurry_RDY 																			= ConRO:AbilityReady(ids.Frost_Ability.Flurry, timeShift);
		local _BrainFreeze_BUFF 																			= ConRO:Aura(ids.Frost_Buff.BrainFreeze, timeShift);
		local _WintersChill_DEBUFF, _WintersChill_COUNT														= ConRO:TargetAura(ids.Frost_Debuff.WintersChill, timeShift);		
	local _Frostbolt, _Frostbolt_RDY 																	= ConRO:AbilityReady(ids.Frost_Ability.Frostbolt, timeShift);
	local _FrozenOrb, _FrozenOrb_RDY 																	= ConRO:AbilityReady(ids.Frost_Ability.FrozenOrb, timeShift);
	local _IcyVeins, _IcyVeins_RDY, _IcyVeins_CD														= ConRO:AbilityReady(ids.Frost_Ability.IcyVeins, timeShift);
		local _IcyVeins_BUFF 																				= ConRO:Aura(ids.Frost_Buff.IcyVeins, timeShift);
	local _Spellsteal, _Spellsteal_RDY 																	= ConRO:AbilityReady(ids.Frost_Ability.Spellsteal, timeShift);
	local _SummonWaterElemental, _SummonWaterElemental_RDY 												= ConRO:AbilityReady(ids.Frost_Ability.SummonWaterElemental, timeShift);
	local _IceLance, _IceLance_RDY																		= ConRO:AbilityReady(ids.Frost_Ability.IceLance, timeShift);
		local _, _Icicles_COUNT																				= ConRO:Aura(ids.Frost_Buff.Icicles, timeShift);
		local _FingersofFrost_BUFF, _FingersofFrost_COUNT 													= ConRO:Aura(ids.Frost_Buff.FingersofFrost, timeShift);

	local _CometStorm, _CometStorm_RDY 																	= ConRO:AbilityReady(ids.Frost_Talent.CometStorm, timeShift);
	local _Ebonbolt, _Ebonbolt_RDY 																		= ConRO:AbilityReady(ids.Frost_Talent.Ebonbolt, timeShift);
	local _GlacialSpike, _GlacialSpike_RDY 																= ConRO:AbilityReady(ids.Frost_Talent.GlacialSpike, timeShift);
		local _GlacialSpike_BUFF																			= ConRO:Aura(ids.Frost_Buff.GlacialSpike, timeShift);
	local _IceFloes, _IceFloes_RDY																		= ConRO:AbilityReady(ids.Frost_Talent.IceFloes, timeShift);
	local _IceNova, _IceNova_RDY 																		= ConRO:AbilityReady(ids.Frost_Talent.IceNova, timeShift);
	local _RayofFrost, _RayofFrost_RDY						 											= ConRO:AbilityReady(ids.Frost_Talent.RayofFrost, timeShift);
	local _RuneofPower, _RuneofPower_RDY									 							= ConRO:AbilityReady(ids.Frost_Talent.RuneofPower, timeShift);
		local _RuneofPower_CHARGES, _, _RuneofPower_CCD														= ConRO:SpellCharges(ids.Frost_Talent.RuneofPower);
		local _RuneofPower_BUFF 																			= ConRO:Form(ids.Frost_Form.RuneofPower, timeShift);
	local _Shimmer, _Shimmer_RDY 																		= ConRO:AbilityReady(ids.Frost_Talent.Shimmer, timeShift);

	local _ConcentratedCoolness_FrozenOrb, _, _ConcentratedCoolness_FrozenOrb_CD						= ConRO:AbilityReady(ids.Frost_PvPTalent.ConcentratedCoolness_FrozenOrb, timeShift);
	local _IceForm, _, _IceForm_CD																		= ConRO:AbilityReady(ids.Frost_PvPTalent.IceForm, timeShift);

	local _Deathborne, _Deathborne_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Deathborne, timeShift);
	local _MirrorsofTorment, _MirrorsofTorment_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.MirrorsofTorment, timeShift);
		local _MirrorsofTorment_DEBUFF																		= ConRO:TargetAura(ids.Covenant_Debuff.MirrorsofTorment, timeShift);		
	local _RadiantSpark, _RadiantSpark_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.RadiantSpark, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _ShiftingPower, _ShiftingPower_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.ShiftingPower, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();	
	
	if currentSpell == _Frostbolt then
		_Icicles_COUNT = _Icicles_COUNT + 1;
	elseif currentSpell == _GlacialSpike then
		_Icicles_COUNT = 0;
	end
	
	if _is_PvP then
		if pvpChosen[ids.Frost_PvPTalent.IceForm] then
			_IcyVeins_RDY = _IcyVeins_RDY and _IceForm_CD <= 0
			_IcyVeins = _IceForm;
		end
		if pvpChosen[ids.Frost_PvPTalent.ConcentratedCoolness] then
			_FrozenOrb_RDY = _FrozenOrb_RDY and _ConcentratedCoolness_FrozenOrb_CD <= 0;
			_FrozenOrb = _ConcentratedCoolness_FrozenOrb;
		end		
	end
	
--Indicators	
	ConRO:AbilityInterrupt(_Counterspell, _Counterspell_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Spellsteal, _Spellsteal_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_10yrds and ConRO:Purgable());
	ConRO:AbilityMovement(_Blink, _Blink_RDY and not tChosen[ids.Frost_Talent.Shimmer] and _target_in_melee);
	ConRO:AbilityMovement(_Shimmer, _Shimmer_RDY and _target_in_melee);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityRaidBuffs(_ArcaneIntellect, _ArcaneIntellect_RDY and not ConRO:RaidBuff(ids.Frost_Buff.ArcaneIntellect));

	ConRO:AbilityBurst(_Ebonbolt, _Ebonbolt_RDY and currentSpell ~= _Ebonbolt and ConRO:BurstMode(_Ebonbolt));
	ConRO:AbilityBurst(_FrozenOrb, _FrozenOrb_RDY and ConRO:BurstMode(_FrozenOrb));
	ConRO:AbilityBurst(_IcyVeins, _in_combat and _IcyVeins_RDY and ConRO:BurstMode(_IcyVeins));
	
	ConRO:AbilityBurst(_Deathborne, _Deathborne_RDY and _in_combat and currentSpell ~= _Deathborne and ConRO:BurstMode(_Deathborne));
	ConRO:AbilityBurst(_MirrorsofTorment, _MirrorsofTorment_RDY and _in_combat and currentSpell ~= _MirrorsofTorment and ConRO:BurstMode(_MirrorsofTorment));
	ConRO:AbilityBurst(_ShiftingPower, _ShiftingPower_RDY and _target_in_10yrds and (not tChosen[ids.Frost_Talent.RuneofPower] or (tChosen[ids.Frost_Talent.RuneofPower] and _RuneofPower_CCD >= 16) or ConRO_AoEButton:IsVisible()) and ConRO:BurstMode(_ShiftingPower));
	
--Warnings	
	ConRO:Warnings("Call your Water Elemental!!!", not tChosen[ids.Frost_Talent.LonelyWinter] and not _Pet_summoned and _SummonWaterElemental_RDY);

--Rotations	
	if not _in_combat then
		if _Ebonbolt_RDY and currentSpell ~= _Ebonbolt and ConRO:FullMode(_Ebonbolt) then
			return _Ebonbolt;
		end

		if _Frostbolt_RDY and currentSpell ~= _Frostbolt and currentSpell ~= _Ebonbolt then
			return _Frostbolt;
		end
		
		if _IcyVeins_RDY and ConRO:FullMode(_IcyVeins) then
			return _IcyVeins;
		end
		
		if _FrozenOrb_RDY and ConRO:FullMode(_FrozenOrb) then
			return _FrozenOrb;
		end
	end
	
	if ConRO_AoEButton:IsVisible() then
		if _Deathborne_RDY and ConRO:FullMode(_Deathborne) then
			return _Deathborne;
		end

		if _IcyVeins_RDY and ConRO:FullMode(_IcyVeins) then
			return _IcyVeins;
		end

		if _RuneofPower_RDY and not _RuneofPower_BUFF and _IcyVeins_CD >= 15 and currentSpell ~= _RuneofPower and ConRO:FullMode(_RuneofPower) then
			return _RuneofPower;
		end

		if _FrozenOrb_RDY and ConRO:FullMode(_FrozenOrb) then
			return _FrozenOrb;
		end

		if _Blizzard_RDY and currentSpell ~= _Blizzard then
			return _Blizzard;
		end

		if _Flurry_RDY and _BrainFreeze_BUFF and _WintersChill_COUNT <= 0 and (currentSpell == _Frostbolt or currentSpell == _Ebonbolt or _MirrorsofTorment_DEBUFF) then
			return _Flurry;
		end

		if _IceNova_RDY then
			return _IceNova;
		end
		
		if _CometStorm_RDY then
			return _CometStorm;
		end

		if _IceLance_RDY and (ConRO.lastSpellId == ids.Frost_Ability.Flurry or _WintersChill_COUNT >= 1) then
			return _IceLance;
		end

		if _RadiantSpark_RDY and _BrainFreeze_BUFF and currentSpell ~= ids.Covenant_Ability.RadiantSpark then
			return _RadiantSpark;
		end

		if _ShiftingPower_RDY and _target_in_10yrds and (not tChosen[ids.Frost_Talent.RuneofPower] or (tChosen[ids.Frost_Talent.RuneofPower] and _RuneofPower_CCD >= 16) or ConRO_AoEButton:IsVisible()) and ConRO:FullMode(_ShiftingPower) then
			return _ShiftingPower;
		end
		
		if _MirrorsofTorment_RDY and currentSpell ~= _MirrorsofTorment and ConRO:FullMode(_MirrorsofTorment) then
			return _MirrorsofTorment;
		end	

		if _ArcaneExplosion_RDY and _Mana_Percent >= 30 and _target_in_10yrds and ConRO_AoEButton:IsVisible() then
			return _ArcaneExplosion;
		end
		
		if _Ebonbolt_RDY and currentSpell ~= _Ebonbolt and ConRO:FullMode(_Ebonbolt) then
			return _Ebonbolt;
		end
		
		if _Frostbolt_RDY then
			return _Frostbolt;
		end
	else
		if _Deathborne_RDY and ConRO:FullMode(_Deathborne) then
			return _Deathborne;
		end

		if _RuneofPower_RDY and not _RuneofPower_BUFF and _IcyVeins_CD >= 15 and currentSpell ~= _RuneofPower and ConRO:FullMode(_RuneofPower) then
			return _RuneofPower;
		end	
		
		if _IcyVeins_RDY and ConRO:FullMode(_IcyVeins) then
			return _IcyVeins;
		end	

		if _Flurry_RDY and _BrainFreeze_BUFF and _WintersChill_COUNT <= 0 and (currentSpell == _Frostbolt or currentSpell == _Ebonbolt or _MirrorsofTorment_DEBUFF) then
			return _Flurry;
		end

		if _FrozenOrb_RDY and ConRO:FullMode(_FrozenOrb) then
			return _FrozenOrb;
		end

		if _Blizzard_RDY and _FreezingRain_BUFF then
			return _Blizzard;
		end	
		
		if _RayofFrost_RDY and _WintersChill_COUNT == 1 and ConRO_SingleButton:IsVisible() and ConRO:FullMode(_RayofFrost) then
			return _RayofFrost;
		end	

		if (_GlacialSpike_RDY or _Icicles_COUNT >= 5) and tChosen[ids.Frost_Talent.GlacialSpike] and currentSpell ~= _GlacialSpike and (ConRO.lastSpellId == _Flurry or _WintersChill_COUNT >= 1 or ConRO_AoEButton:IsVisible()) then
			return _GlacialSpike;
		end
		
		if _IceLance_RDY and (ConRO.lastSpellId == _Flurry or _WintersChill_COUNT >= 1) then
			return _IceLance;
		end

		if _CometStorm_RDY then
			return _CometStorm;
		end

		if _IceNova_RDY then
			return _IceNova;
		end

		if _IceLance_RDY and _FingersofFrost_BUFF then
			return _IceLance;
		end

		if _Ebonbolt_RDY and currentSpell ~= ids.Frost_Talent.Ebonbolt and ConRO:FullMode(_Ebonbolt) then
			return _Ebonbolt;
		end

		if _RadiantSpark_RDY and _BrainFreeze_BUFF and currentSpell ~= _RadiantSpark then
			return _RadiantSpark;
		end

		if _ShiftingPower_RDY and _target_in_10yrds and (not tChosen[ids.Frost_Talent.RuneofPower] or (tChosen[ids.Frost_Talent.RuneofPower] and _RuneofPower_CCD >= 16) or ConRO_AoEButton:IsVisible()) and ConRO:FullMode(_ShiftingPower) then
			return _ShiftingPower;
		end

		if _MirrorsofTorment_RDY and currentSpell ~= _MirrorsofTorment and ConRO:FullMode(_MirrorsofTorment) then
			return _MirrorsofTorment;
		end

		if _Frostbolt_RDY then
			return _Frostbolt;
		end
	end
end

function ConRO.Mage.FrostDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max, _Mana_Percent																= ConRO:PlayerPower('Mana');
	
--Abilities	
	local _IceBarrier, _IceBarrier_RDY 																	= ConRO:AbilityReady(ids.Frost_Ability.IceBarrier, timeShift);
		local _IceBarrier_BUFF 																				= ConRO:Aura(ids.Frost_Buff.IceBarrier, timeShift);
	local _IceBlock, _IceBlock_RDY 																		= ConRO:AbilityReady(ids.Frost_Ability.IceBlock, timeShift);
	local _ColdSnap, _ColdSnap_RDY 																		= ConRO:AbilityReady(ids.Frost_Ability.ColdSnap, timeShift);
	local _MirrorImage, _MirrorImage_RDY 																= ConRO:AbilityReady(ids.Frost_Ability.MirrorImage, timeShift);

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
	
	if _ColdSnap_RDY and not _IceBlock_RDY then
		return _ColdSnap;
	end
	
	if _IceBlock_RDY and _Player_Percent_Health <= 25 and _in_combat then
		return _IceBlock;
	end
	
	if _IceBarrier_RDY and not _IceBarrier_BUFF then
		return _IceBarrier;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _MirrorImage_RDY and _in_combat then
		return _MirrorImage;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end