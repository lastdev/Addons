ConRO.Shaman = {};
ConRO.Shaman.CheckTalents = function()
end
ConRO.Shaman.CheckPvPTalents = function()
end
local ConRO_Shaman, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Shaman.CheckTalents;
	self.ModuleOnEnable = ConRO.Shaman.CheckPvPTalents;	
	if mode == 0 then
		self.Description = "Shaman [No Specialization Under 10]";
		self.NextSpell = ConRO.Shaman.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = 'Shaman Module [Elemental - Caster]';
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Shaman.Elemental;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Shaman.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 2 then
		self.Description = 'Shaman Module [Enhancement - Melee]';
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Shaman.Enhancement;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Shaman.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 3 then
		self.Description = 'Shaman Module [Restoration - Healer]';
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.Shaman.Restoration;
			self.ToggleHealer();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Shaman.Disabled;
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
		self.NextDef = ConRO.Shaman.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Shaman.ElementalDef;
		else
			self.NextDef = ConRO.Shaman.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Shaman.EnhancementDef;
		else
			self.NextDef = ConRO.Shaman.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Shaman.RestorationDef;
		else
			self.NextDef = ConRO.Shaman.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Shaman.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Shaman.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Shaman.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Shaman.Elemental(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Maelstrom, _Maelstrom_Max																	= ConRO:PlayerPower('Maelstrom');
	
--Abilities	
	local _ChainLightning, _ChainLightning_RDY															= ConRO:AbilityReady(ids.Ele_Ability.ChainLightning, timeShift);
	local _EarthElemental, _EarthElemental_RDY, _EarthElemental_CD, _EarthElemental_MaxCD				= ConRO:AbilityReady(ids.Ele_Ability.EarthElemental, timeShift);
	local _Earthquake, _Earthquake_RDY																	= ConRO:AbilityReady(ids.Ele_Ability.Earthquake, timeShift);
	local _EarthShock, _EarthShock_RDY 																	= ConRO:AbilityReady(ids.Ele_Ability.EarthShock, timeShift);
		local _SurgeofPower_BUFF																			= ConRO:Aura(ids.Ele_Buff.SurgeofPower, timeShift);
	local _FireElemental, _FireElemental_RDY, _FireElemental_CD, _FireElemental_MaxCD					= ConRO:AbilityReady(ids.Ele_Ability.FireElemental, timeShift);
	local _FlameShock, _FlameShock_RDY																	= ConRO:AbilityReady(ids.Ele_Ability.FlameShock, timeShift);
		local _FlameShock_DEBUFF, _, _FlameShock_DUR														= ConRO:TargetAura(ids.Ele_Debuff.FlameShock, timeShift);
	local _FrostShock, _FrostShock_RDY																	= ConRO:AbilityReady(ids.Ele_Ability.FrostShock, timeShift);
	local _LavaBurst, _LavaBurst_RDY																	= ConRO:AbilityReady(ids.Ele_Ability.LavaBurst, timeShift);
		local _LavaBurst_CHARGES																			= ConRO:SpellCharges(ids.Ele_Ability.LavaBurst);
		local _LavaSurge_BUFF 																				= ConRO:Aura(ids.Ele_Buff.LavaSurge, timeShift);
		local _MasteroftheElements_BUFF 																	= ConRO:Aura(ids.Ele_Buff.MasteroftheElements, timeShift);
	local _LightningBolt, _LightningBolt_RDY															= ConRO:AbilityReady(ids.Ele_Ability.LightningBolt, timeShift);
	local _LightningShield, _LightningShield_RDY														= ConRO:AbilityReady(ids.Ele_Ability.LightningShield, timeShift);
		local _LightningShield_BUFF																			= ConRO:Aura(ids.Ele_Buff.LightningShield, timeShift);	
	local _Purge, _Purge_RDY 																			= ConRO:AbilityReady(ids.Ele_Ability.Purge, timeShift);
	local _Thunderstorm, _Thunderstorm_RDY																= ConRO:AbilityReady(ids.Ele_Ability.Thunderstorm, timeShift);
	local _WindShear, _WindShear_RDY 																	= ConRO:AbilityReady(ids.Ele_Ability.WindShear, timeShift);
	
	local _Ascendance, _Ascendance_RDY, _Ascendance_CD 													= ConRO:AbilityReady(ids.Ele_Talent.Ascendance, timeShift);
		local _Ascendance_BUFF 																				= ConRO:Aura(ids.Ele_Buff.Ascendance, timeShift);
		local _LavaBeam, _LavaBeam_RDY 																	= ConRO:AbilityReady(ids.Ele_Talent.LavaBeam, timeShift);
	local _EarthShield, _EarthShield_RDY																= ConRO:AbilityReady(ids.Ele_Talent.EarthShield, timeShift);
	local _EchoingShock, _EchoingShock_RDY																= ConRO:AbilityReady(ids.Ele_Talent.EchoingShock, timeShift);
		local _EchoingShock_BUFF																			= ConRO:Aura(ids.Ele_Buff.EchoingShock, timeShift);
	local _ElementalBlast, _ElementalBlast_RDY 															= ConRO:AbilityReady(ids.Ele_Talent.ElementalBlast, timeShift);
	local _Icefury, _Icefury_RDY 																		= ConRO:AbilityReady(ids.Ele_Talent.Icefury, timeShift);
		local _Icefury_BUFF 																				= ConRO:Aura(ids.Ele_Buff.Icefury, timeShift);	
	local _LiquidMagmaTotem, _LiquidMagmaTotem_RDY 														= ConRO:AbilityReady(ids.Ele_Talent.LiquidMagmaTotem, timeShift);
	local _StaticDischarge, _StaticDischarge_RDY														= ConRO:AbilityReady(ids.Ele_Talent.StaticDischarge, timeShift);
	local _StormElemental, _StormElemental_RDY, _StormElemental_CD, _StormElemental_MaxCD				= ConRO:AbilityReady(ids.Ele_Talent.StormElemental, timeShift);
		local _WindGust_BUFF, _WindGust_COUNT																= ConRO:Form(ids.Ele_Form.WindGust);
		local _CallLightning, _CallLightning_RDY															= ConRO:AbilityReady(ids.Ele_PetAbility.CallLightning, timeShift, 'pet');
		local _EyeoftheStorm, _EyeoftheStorm_RDY															= ConRO:AbilityReady(ids.Ele_PetAbility.EyeoftheStorm, timeShift, 'pet');
	local _Stormkeeper, _Stormkeeper_RDY 																= ConRO:AbilityReady(ids.Ele_Talent.Stormkeeper, timeShift);
		local _Stormkeeper_BUFF 																			= ConRO:Aura(ids.Ele_Buff.Stormkeeper, timeShift);

	local _ChainHarvest, _ChainHarvest_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.ChainHarvest, timeShift);
	local _FaeTransfusion, _FaeTransfusion_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.FaeTransfusion, timeShift);	
	local _PrimordialWave, _PrimordialWave_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.PrimordialWave, timeShift);
		local _PrimordialWave_BUFF																			= ConRO:Aura(ids.Covenant_Buff.PrimordialWave, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _VesperTotem, _VesperTotem_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.VesperTotem, timeShift);

		local _EchoesofGreatSundering_BUFF																	= ConRO:Aura(ids.Legendary_Buff.EchoesofGreatSundering, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Primal_elemental_summoned 																	= ConRO:CallPet();
	local _Primal_elemental_name 																		= UnitName("pet");
	local _Storm_elemental_summoned																		= false;
	local _current_pet_spell																			= select(9, UnitCastingInfo('pet'));
	
		if (_Primal_elemental_summoned and _Primal_elemental_name == "Primal Storm Elemental") or (_StormElemental_CD >= _StormElemental_MaxCD - 30) then
			_Storm_elemental_summoned = true;
		end

		if not tChosen[ids.Ele_Talent.EchooftheElements] and _LavaBurst_RDY then
			_LavaBurst_CHARGES = 1;
		end
	
		if currentSpell == _LavaBurst then
			_Maelstrom = _Maelstrom + 10;
			_LavaBurst_CHARGES = _LavaBurst_CHARGES - 1;
		end
		if currentSpell == _LightningBolt then
			_Maelstrom = _Maelstrom + 8;
		end
		if currentSpell == _Icefury then
			_Maelstrom = _Maelstrom + 15;
		end

--Indicators	
	ConRO:AbilityInterrupt(_WindShear, _WindShear_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Purge, _Purge_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);

	ConRO:AbilityBurst(_Thunderstorm, _Thunderstorm_RDY and ((ConRO:Interrupt() and not _WindShear_RDY and _target_in_melee) or (_target_in_melee and ConRO:TarYou())));	
	ConRO:AbilityBurst(_FireElemental, _FireElemental_RDY and ConRO_SingleButton:IsVisible() and (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not _Primal_elemental_summoned)) and ConRO:BurstMode(_FireElemental, 150));
	ConRO:AbilityBurst(_StormElemental, _StormElemental_RDY and (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not _Primal_elemental_summoned)) and ConRO:BurstMode(_StormElemental, 150));
	ConRO:AbilityBurst(_EarthElemental, _EarthElemental_RDY and not (_StormElemental_RDY or _FireElemental_RDY) and (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not _Primal_elemental_summoned)));
	ConRO:AbilityBurst(_Ascendance, _Ascendance_RDY and ConRO_SingleButton:IsVisible() and ConRO:BurstMode(_Ascendance));
	ConRO:AbilityBurst(_Stormkeeper, _Stormkeeper_RDY and currentSpell ~= _Stormkeeper and ConRO:BurstMode(_Stormkeeper));
	ConRO:AbilityBurst(_LiquidMagmaTotem, _LiquidMagmaTotem_RDY and ConRO:BurstMode(_LiquidMagmaTotem));
		
	ConRO:AbilityBurst(_FaeTransfusion, _FaeTransfusion_RDY and ConRO:BurstMode(_FaeTransfusion));
	ConRO:AbilityBurst(_ChainHarvest, _ChainHarvest_RDY and ConRO:BurstMode(_ChainHarvest));
	ConRO:AbilityBurst(_VesperTotem, _VesperTotem_RDY and ConRO:BurstMode(_VesperTotem));
	ConRO:AbilityBurst(_PrimordialWave, _PrimordialWave_RDY and not _PrimordialWave_BUFF and ConRO:BurstMode(_PrimordialWave));
	
	ConRO:AbilityRaidBuffs(_EarthShield, _EarthShield_RDY and not ConRO:OneBuff(ids.Ele_Buff.EarthShield));
	ConRO:AbilityRaidBuffs(_LightningShield, _LightningShield_RDY and not _LightningShield_BUFF);
	
--Rotations	
	if not _in_combat then
		if _VesperTotem_RDY and ConRO:FullMode(_VesperTotem) then
			return _VesperTotem;
		end

		if _Stormkeeper_RDY and currentSpell ~= _Stormkeeper and ConRO:FullMode(_Stormkeeper) then
			return _Stormkeeper;
		end

		if (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not _Primal_elemental_summoned)) then
			if tChosen[ids.Ele_Talent.StormElemental] then
				if _StormElemental_RDY and ConRO:FullMode(_StormElemental, 150) then
					return _StormElemental;
				end
			else
				if _FireElemental_RDY and ConRO:FullMode(_FireElemental, 150) then
					return _FireElemental;
				end
			end
		end

		if _PrimordialWave_RDY and not _FlameShock_DEBUFF and (currentSpell == _ElementalBlast or currentSpell == _LavaBurst or currentSpell == _LightningBolt) then
			return _PrimordialWave;
		end
		
		if _FlameShock_RDY and not _FlameShock_DEBUFF and (currentSpell == _ElementalBlast or currentSpell == _LavaBurst or currentSpell == _LightningBolt) then
			return _FlameShock;
		end	

		if _ElementalBlast_RDY and currentSpell ~= _ElementalBlast then
			return _ElementalBlast;
		end
		
		if _LavaBurst_RDY and currentSpell ~= _LavaBurst then
			return _LavaBurst;
		end
		
		if _LightningBolt_RDY and currentSpell ~= _LightningBolt then
			return _LightningBolt;
		end
	
	elseif _Ascendance_BUFF then
		if _EarthShock_RDY and _Maelstrom > 90 then
			return _EarthShock;
		end
		
		if _ElementalBlast_RDY and currentSpell ~= ids.Ele_Talent.ElementalBlast then
			return _ElementalBlast;
		end
		
		if _LavaBurst_RDY then
			return _LavaBurst;
		end
			
	elseif _is_moving then
		if _FlameShock_RDY and not _FlameShock_DEBUFF then
			return _FlameShock;
		end	
	
		if _LavaBurst_RDY and _LavaSurge_BUFF then
			return _LavaBurst;
		end		
	
		if _Stormkeeper_BUFF then
			if ConRO_AoEButton:IsVisible() then
				if _ChainLightning_RDY then
					return _ChainLightning;
				end
			else
				if _LightningBolt_RDY then
					return _LightningBolt;
				end	
			end
		end
		
		if _FrostShock_RDY then
			return _FrostShock;
		end
	end
	
	if _PrimordialWave_RDY and not _FlameShock_DEBUFF and _WindGust_COUNT <= 18 and ConRO:FullMode(_PrimordialWave) then
		return _PrimordialWave;
	end
	
	if _FlameShock_RDY and not _FlameShock_DEBUFF and _WindGust_COUNT <= 18 then
		return _FlameShock;
	end

	if (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not _Primal_elemental_summoned)) then
		if tChosen[ids.Ele_Talent.StormElemental] then
			if _StormElemental_RDY and ConRO:FullMode(_StormElemental, 150) then
				return _StormElemental;
			end
		else
			if _FireElemental_RDY and ConRO:FullMode(_FireElemental, 150) then
				return _FireElemental;
			end
		end
	end	
	
	if ConRO_AoEButton:IsVisible() then
		if _CallLightning_RDY and _Storm_elemental_summoned and _StormElemental_CD >= 135 and _current_pet_spell ~= _CallLightning then
			return _CallLightning;
		end
		
		if _EyeoftheStorm_RDY and _Storm_elemental_summoned and tChosen[ids.Ele_Talent.PrimalElementalist] and _current_pet_spell ~= _EyeoftheStorm and _current_pet_spell ~= _CallLightning then
			return _EyeoftheStorm;
		end

		if _LavaBurst_RDY and _LavaSurge_BUFF and ((_Maelstrom >= 50 and tChosen[ids.Ele_Talent.MasteroftheElements]) or _PrimordialWave_BUFF) then
			return _LavaBurst;
		end	
		
		if _PrimordialWave_RDY and not _PrimordialWave_BUFF and ConRO:FullMode(_PrimordialWave) then
			return _PrimordialWave;
		end		

		if _Stormkeeper_RDY and currentSpell ~= _Stormkeeper then
			return _Stormkeeper;
		end	

		if _ChainHarvest_RDY and currentSpell ~= _ChainHarvest and ConRO:FullMode(_ChainHarvest) then
			return _ChainHarvest;
		end

		if _EchoingShock_RDY and _Maelstrom >= 60 then
			return _EchoingShock;
		end

		if _Earthquake_RDY and _Maelstrom >= 60 and _EchoingShock_BUFF then
			return _Earthquake;
		end

		if _VesperTotem_RDY and ConRO:FullMode(_VesperTotem) then
			return _VesperTotem;
		end

		if _FaeTransfusion_RDY and ConRO:FullMode(_FaeTransfusion) then
			return _FaeTransfusion;
		end

		if _LiquidMagmaTotem_RDY and ConRO:FullMode(_LiquidMagmaTotem) then
			return _LiquidMagmaTotem;
		end

		if _Earthquake_RDY and _Maelstrom >= 60 then
			return _Earthquake;
		end	

		if _ElementalBlast_RDY and currentSpell ~= _ElementalBlast then
			return _ElementalBlast;
		end
		
		if _ChainLightning_RDY then
			return _ChainLightning;
		end
		
	else
		if _Ascendance_RDY and ConRO:FullMode(_Ascendance) then
			return _Ascendance;
		end

		if _FaeTransfusion_RDY and _MasteroftheElements_BUFF and ConRO:FullMode(_FaeTransfusion) then
			return _FaeTransfusion;
		end
		
		if _Earthquake_RDY and _Maelstrom >= 100 and _EchoesofGreatSundering_BUFF then
			return _Earthquake;
		end	

		if _EarthShock_RDY and _Maelstrom >= 100 then
			return _EarthShock;
		end

		if _ElementalBlast_RDY and currentSpell ~= _ElementalBlast then
			return _ElementalBlast;
		end

		if _FaeTransfusion_RDY and ConRO:FullMode(_FaeTransfusion) then
			return _FaeTransfusion;
		end
		
		if _Stormkeeper_RDY and currentSpell ~= _Stormkeeper and ConRO:FullMode(_Stormkeeper) then
			return _Stormkeeper;
		end

		if _PrimordialWave_RDY and not _PrimordialWave_BUFF and ConRO:FullMode(_PrimordialWave) then
			return _PrimordialWave;
		end
		
		if _Earthquake_RDY and _Maelstrom >= 60 and _MasteroftheElements_BUFF and _EchoesofGreatSundering_BUFF then
			return _Earthquake;
		end	

		if _EchoingShock_RDY and (_Maelstrom >= 60 or _LavaBurst_RDY) then
			return _EchoingShock;
		end

		if _LavaBurst_RDY and _LavaBurst_CHARGES >= 1 and _EchoingShock_BUFF then
			return _LavaBurst;
		end

		if _VesperTotem_RDY and ConRO:FullMode(_VesperTotem) then
			return _VesperTotem;
		end

		if _LiquidMagmaTotem_RDY and ConRO:FullMode(_LiquidMagmaTotem) then
			return _LiquidMagmaTotem;
		end

		if _LightningBolt_RDY and _Stormkeeper_BUFF and _MasteroftheElements_BUFF or (_Storm_elemental_summoned and _WindGust_COUNT >= 18) then
			return _LightningBolt;
		end

		if _FrostShock_RDY and _Icefury_BUFF and _MasteroftheElements_BUFF then
			return _FrostShock;
		end
	
		if _LavaBurst_RDY and _LavaBurst_CHARGES >= 1 then
			return _LavaBurst;
		end		

		if _FlameShock_RDY and _FlameShock_DUR <= 5 then
			return _FlameShock;
		end		
	
		if _Earthquake_RDY and _Maelstrom >= 60 and _EchoesofGreatSundering_BUFF then
			return _Earthquake;
		end	

		if _EarthShock_RDY and _Maelstrom >= 60 then
			return _EarthShock;
		end

		if _FrostShock_RDY and _Icefury_BUFF then
			return _FrostShock;
		end		

		if _Icefury_RDY and currentSpell ~= _Icefury then
			return _Icefury;
		end		

		if _ChainHarvest_RDY and currentSpell ~= _ChainHarvest and ConRO:FullMode(_ChainHarvest) then
			return _ChainHarvest;
		end

		if _StaticDischarge_RDY and _LightningShield_BUFF then
			return _StaticDischarge;
		end
		
		if _LightningBolt_RDY then
			return _LightningBolt;
		end
	end
end

function ConRO.Shaman.ElementalDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Maelstrom, _Maelstrom_Max																	= ConRO:PlayerPower('Maelstrom');
	
--Abilities
	local _AstralShift, _AstralShift_RDY																= ConRO:AbilityReady(ids.Ele_Ability.AstralShift, timeShift);

	local _FaeTransfusionEND, _FaeTransfusionEND_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.FaeTransfusionEND, timeShift);	
		local _FaeTransfusion_BUFF, _, _FaeTransfusion_DUR													= ConRO:Aura(ids.Covenant_Buff.FaeTransfusion, timeShift);
	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations	
	if _Fleshcraft_RDY and _in_combat then
		return _Fleshcraft;
	end
	
	if _FaeTransfusionEND_RDY and _FaeTransfusion_BUFF and _FaeTransfusion_DUR <= 2 then
		return _FaeTransfusionEND;
	end
	
	if _AstralShift_RDY then
		return _AstralShift;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Shaman.Enhancement(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Maelstrom, _Maelstrom_Max																	= ConRO:PlayerPower('Maelstrom');
	
--Abilities
	local _ChainLightning, _ChainLightning_RDY															= ConRO:AbilityReady(ids.Enh_Ability.ChainLightning, timeShift);
	local _CrashLightning, _CrashLightning_RDY 															= ConRO:AbilityReady(ids.Enh_Ability.CrashLightning, timeShift);
		local _CrashLightning_BUFF 																			= ConRO:Aura(ids.Enh_Buff.CrashLightning, timeShift);
	local _FeralSpirit, _FeralSpirit_RDY, _FeralSpirit_CD 												= ConRO:AbilityReady(ids.Enh_Ability.FeralSpirit, timeShift);
	local _FlameShock, _FlameShock_RDY																	= ConRO:AbilityReady(ids.Enh_Ability.FlameShock, timeShift + 1);
		local _FlameShock_DEBUFF, _, _FlameShock_DUR														= ConRO:TargetAura(ids.Ele_Debuff.FlameShock, timeShift);
	local _FlametongueWeapon, _FlametongueWeapon_RDY													= ConRO:AbilityReady(ids.Enh_Ability.FlametongueWeapon, timeShift);
		local _FlametongueWeapon_BUFF, _, _FlametongueWeapon_DUR											= ConRO:UnitAura(ids.Enh_Buff.FlametongueWeapon, timeShift, _, _, "Weapon");
	local _FrostShock, _FrostShock_RDY, _FrostShock_CD													= ConRO:AbilityReady(ids.Enh_Ability.FrostShock, timeShift);
		local _Hailstorm_BUFF																				= ConRO:Aura(ids.Enh_Buff.Hailstorm, timeShift);
	local _LavaLash, _LavaLash_RDY																		= ConRO:AbilityReady(ids.Enh_Ability.LavaLash, timeShift);
		local _HotHand_BUFF																					= ConRO:Aura(ids.Enh_Buff.HotHand, timeShift);
		local _LashingFlames_DEBUFF																			= ConRO:TargetAura(ids.Enh_Debuff.LashingFlames, timeShift);		
	local _LightningBolt, _LightningBolt_RDY															= ConRO:AbilityReady(ids.Enh_Ability.LightningBolt, timeShift);
		local _, _MaelstromWeapon_COUNT																		= ConRO:Aura(ids.Enh_Buff.MaelstromWeapon, timeShift);
	local _LightningShield, _LightningShield_RDY														= ConRO:AbilityReady(ids.Enh_Ability.LightningShield, timeShift);
		local _LightningShield_BUFF																			= ConRO:Aura(ids.Enh_Buff.LightningShield, timeShift);
	local _Purge, _Purge_RDY 																			= ConRO:AbilityReady(ids.Enh_Ability.Purge, timeShift);
	local _PrimalStrike, _PrimalStrike_RDY 																= ConRO:AbilityReady(ids.Enh_Ability.PrimalStrike, timeShift);
	local _Stormstrike, _Stormstrike_RDY																= ConRO:AbilityReady(ids.Enh_Ability.Stormstrike, timeShift);
		local _Stormbringer_BUFF 																			= ConRO:Aura(ids.Enh_Buff.Stormbringer, timeShift);
	local _WindShear, _WindShear_RDY 																	= ConRO:AbilityReady(ids.Enh_Ability.WindShear, timeShift);
	local _WindfuryTotem, _WindfuryTotem_RDY															= ConRO:AbilityReady(ids.Enh_Ability.WindfuryTotem, timeShift);
		local _WindfuryTotem_BUFF																			= ConRO:Form(ids.Enh_Form.WindfuryTotem);
	local _WindfuryWeapon, _WindfuryWeapon_RDY															= ConRO:AbilityReady(ids.Enh_Ability.WindfuryWeapon, timeShift);
		local _WindfuryWeapon_BUFF, _, _WindfuryWeapon_DUR													= ConRO:UnitAura(ids.Enh_Buff.WindfuryWeapon, timeShift, _, _, "Weapon");

	local _Ascendance, _Ascendance_RDY 																	= ConRO:AbilityReady(ids.Enh_Talent.Ascendance, timeShift);
		local _Ascendance_BUFF																				= ConRO:Aura(ids.Enh_Buff.Ascendance, timeShift);
		local _Windstrike, _Windstrike_RDY												 					= ConRO:AbilityReady(ids.Enh_Talent.Windstrike, timeShift);
	local _EarthenSpike, _EarthenSpike_RDY																= ConRO:AbilityReady(ids.Enh_Talent.EarthenSpike, timeShift);
		local _, _EarthenSpike_RANGE 																		= ConRO:Targets(ids.Enh_Talent.EarthenSpike);	
	local _Sundering, _Sundering_RDY 																	= ConRO:AbilityReady(ids.Enh_Talent.Sundering, timeShift);	
	local _EarthShield, _EarthShield_RDY																= ConRO:AbilityReady(ids.Enh_Talent.EarthShield, timeShift);
	local _ElementalBlast, _ElementalBlast_RDY															= ConRO:AbilityReady(ids.Enh_Talent.ElementalBlast, timeShift);
	local _IceStrike, _IceStrike_RDY																	= ConRO:AbilityReady(ids.Enh_Talent.IceStrike, timeShift);
	local _FireNova, _FireNova_RDY																		= ConRO:AbilityReady(ids.Enh_Talent.FireNova, timeShift);
	local _FeralLunge, _FeralLunge_RDY																	= ConRO:AbilityReady(ids.Enh_Talent.FeralLunge, timeShift);
		local _, _FeralLunge_RANGE 																			= ConRO:Targets(ids.Enh_Talent.FeralLunge);	
	local _Stormkeeper, _Stormkeeper_RDY																= ConRO:AbilityReady(ids.Enh_Talent.Stormkeeper, timeShift);
		local _Stormkeeper_BUFF																				= ConRO:Aura(ids.Enh_Buff.Stormkeeper, timeShift);

	local _ChainHarvest, _ChainHarvest_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.ChainHarvest, timeShift);
	local _FaeTransfusion, _FaeTransfusion_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.FaeTransfusion, timeShift);	
		local _FaeTransfusionEND, _FaeTransfusionEND_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.FaeTransfusionEND, timeShift);	
	local _PrimordialWave, _PrimordialWave_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.PrimordialWave, timeShift);
		local _PrimordialWave_BUFF																			= ConRO:Aura(ids.Ele_Buff.PrimordialWave, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _VesperTotem, _VesperTotem_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.VesperTotem, timeShift);

	local _DoomWinds_EQUIPPED																			= ConRO:ItemEquipped(ids.Legendary.DoomWinds_Head) or ConRO:ItemEquipped(ids.Legendary.DoomWinds_Waist);
		local _DoomWinds_BUFF																				= ConRO:Aura(ids.Legendary_Buff.DoomWinds, timeShift);
		local _DoomWinds_DEBUFF																				= ConRO:Aura(ids.Legendary_Debuff.DoomWinds, timeShift, 'HARMFUL');

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
		
--Indicators
	ConRO:AbilityInterrupt(_WindShear, _WindShear_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Purge, _Purge_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_FeralLunge, _FeralLunge_RDY and _FeralLunge_RANGE);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);

	ConRO:AbilityRaidBuffs(_EarthShield, _EarthShield_RDY and not ConRO:OneBuff(ids.Enh_Buff.EarthShield));
	ConRO:AbilityRaidBuffs(_LightningShield, _LightningShield_RDY and not _LightningShield_BUFF);
	ConRO:AbilityRaidBuffs(_WindfuryWeapon, _WindfuryWeapon_RDY and not _WindfuryWeapon_BUFF or (not _in_combat and _WindfuryWeapon_DUR < 600));
	ConRO:AbilityRaidBuffs(_FlametongueWeapon, _FlametongueWeapon_RDY and not _FlametongueWeapon_BUFF or (not _in_combat and _FlametongueWeapon_DUR < 600));

	ConRO:AbilityBurst(_Ascendance, _Ascendance_RDY and not _Stormstrike_RDY and ConRO:BurstMode(_Ascendance));
	ConRO:AbilityBurst(_FeralSpirit, _FeralSpirit_RDY and ftBuff and ConRO:BurstMode(_FeralSpirit));
	ConRO:AbilityBurst(_Stormkeeper, _Stormkeeper_RDY and currentSpell ~= _Stormkeeper and ConRO:BurstMode(_Stormkeeper));
	ConRO:AbilityBurst(_WindfuryTotem, _WindfuryTotem_RDY and not _WindfuryTotem_BUFF and ConRO_BurstButton:IsVisible());

	ConRO:AbilityBurst(_ChainHarvest, _ChainHarvest_RDY and _MaelstromWeapon_COUNT >= 5 and ConRO:BurstMode(_ChainHarvest));
	ConRO:AbilityBurst(_FaeTransfusion, _FaeTransfusion_RDY and ConRO:BurstMode(_FaeTransfusion));
	ConRO:AbilityBurst(_PrimordialWave, _PrimordialWave_RDY and not _PrimordialWave_BUFF and ConRO:BurstMode(_PrimordialWave));
	ConRO:AbilityBurst(_VesperTotem, _VesperTotem_RDY and ConRO:BurstMode(_VesperTotem));
	
--Warnings	

--Rotations
	if not _in_combat then
		if _WindfuryTotem_RDY and (not _WindfuryTotem_BUFF or (_DoomWinds_EQUIPPED and not _DoomWinds_DEBUFF)) and ConRO_FullButton:IsVisible() then
			return _WindfuryTotem;
		end
		
		if _Stormkeeper_RDY and currentSpell ~= _Stormkeeper and ConRO:FullMode(_Stormkeeper) then
			return _Stormkeeper;
		end			
		
		if _VesperTotem_RDY and ConRO:FullMode(_VesperTotem) then
			return _VesperTotem;
		end

		if _PrimordialWave_RDY and not _FlameShock_DEBUFF and ConRO:FullMode(_PrimordialWave) then
			return _PrimordialWave;
		end
		
		if _FlameShock_RDY and not _FlameShock_DEBUFF then
			return _FlameShock;
		end

		if _EarthenSpike_RDY and _EarthenSpike_RANGE then
			return _EarthenSpike;
		end

		if _Stormstrike_RDY and not _Ascendance_BUFF then
			return _Stormstrike;
		end
		
		if _FeralSpirit_RDY and ConRO:FullMode(_FeralSpirit) then
			return _FeralSpirit;
		end			

		if _Stormstrike_RDY and _Ascendance_BUFF then
			return _Windstrike;
		end

		if _Ascendance_RDY and not _Stormstrike_RDY and ConRO:FullMode(_Ascendance) then
			return _Ascendance;
		end
		
	elseif tChosen[ids.Enh_Talent.Hailstorm] and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
		if _WindfuryTotem_RDY and (not _WindfuryTotem_BUFF or (_DoomWinds_EQUIPPED and not _DoomWinds_DEBUFF)) and ConRO_FullButton:IsVisible() then
			return _WindfuryTotem;
		end
		
		if _VesperTotem_RDY and ConRO:FullMode(_VesperTotem) then
			return _VesperTotem;
		end

		if _FrostShock_RDY and _Hailstorm_BUFF then
			return _FrostShock;
		end
		
		if _FaeTransfusion_RDY and ConRO:FullMode(_FaeTransfusion) then
			return _FaeTransfusion;
		end

		if _Ascendance_RDY and not _Stormstrike_RDY and ConRO:FullMode(_Ascendance) then
			return _Ascendance;
		end
		
		if _Sundering_RDY and _target_in_10yrds then
			return _Sundering;
		end
	
		if _FeralSpirit_RDY and _MaelstromWeapon_COUNT <= 3 and ConRO:FullMode(_FeralSpirit) then
			return _FeralSpirit;
		end	
		
		if _ChainHarvest_RDY and _MaelstromWeapon_COUNT >= 5 and ConRO:FullMode(_ChainHarvest) then
			return _ChainHarvest;
		end

		if _ChainLightning_RDY and _MaelstromWeapon_COUNT >= 5 then
			return _ChainLightning;
		end

		if _CrashLightning_RDY then
			return _CrashLightning;
		end

		if _Stormstrike_RDY and _Ascendance_BUFF then
			return _Windstrike;
		end
		
		if _Stormstrike_RDY and not _Ascendance_BUFF then
			return _Stormstrike;
		end

		if _LavaLash_RDY then
			return _LavaLash;
		end
		
	else
		if _WindfuryTotem_RDY and (not _WindfuryTotem_BUFF or (_DoomWinds_EQUIPPED and not _DoomWinds_DEBUFF)) and ConRO_FullButton:IsVisible() then
			return _WindfuryTotem;
		end

		if _PrimordialWave_RDY then
			return _PrimordialWave;
		end
		
		if _FlameShock_RDY and not _FlameShock_DEBUFF then
			return _FlameShock;
		end

		if _FeralSpirit_RDY and _MaelstromWeapon_COUNT <= 3 and ConRO:FullMode(_FeralSpirit) then
			return _FeralSpirit;
		end	

		if _LavaLash_RDY and (tChosen[ids.Enh_Talent.LashingFlames] and not _LashingFlames_DEBUFF) and not _Ascendance_BUFF then
			return _LavaLash;
		end
		
		if _Ascendance_RDY and not _Stormstrike_RDY and ConRO:FullMode(_Ascendance) then
			return _Ascendance;
		end
		
		if _Stormstrike_RDY and _Ascendance_BUFF then
			return _Windstrike;
		end
		
		if _VesperTotem_RDY and ConRO:FullMode(_VesperTotem) then
			return _VesperTotem;
		end
		
		if _FrostShock_RDY and _Hailstorm_BUFF then
			return _FrostShock;
		end
		
		if _EarthenSpike_RDY and _EarthenSpike_RANGE then
			return _EarthenSpike;
		end

		if _FaeTransfusion_RDY and ConRO:FullMode(_FaeTransfusion) then
			return _FaeTransfusion;
		end

		if _ChainLightning_RDY and _Stormkeeper_BUFF then
			return _ChainLightning;
		end

		if _ElementalBlast_RDY and _MaelstromWeapon_COUNT >= 5 then
			return _ElementalBlast;
		end

		if _ChainHarvest_RDY and _MaelstromWeapon_COUNT >= 5 and ConRO:FullMode(_ChainHarvest) then
			return _ChainHarvest;
		end
		
		if _Stormkeeper_RDY and _MaelstromWeapon_COUNT >= 5 then
			return _Stormkeeper;
		end

		if _MaelstromWeapon_COUNT >= 8 then
			if (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() then
				if _ChainLightning_RDY then
					return _ChainLightning;
				end
			else
				if _LightningBolt_RDY then
					return _LightningBolt;
				end
			end
		end

		if _LavaLash_RDY and _HotHand_BUFF then
			return _LavaLash;
		end

		if _CrashLightning_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			return _CrashLightning;
		end

		if _Stormstrike_RDY and not _Ascendance_BUFF then
			return _Stormstrike;
		end
		
		if _CrashLightning_RDY and tChosen[ids.Enh_Talent.CrashingStorm] and _target_in_melee then
			return _CrashLightning;
		end
		
		if _LavaLash_RDY then
			return _LavaLash;
		end			

		if _CrashLightning_RDY and _target_in_melee then
			return _CrashLightning;
		end
		
		if _FlameShock_RDY and _FlameShock_DUR <= 5 then
			return _FlameShock;
		end			

		if _FrostShock_RDY then
			return _FrostShock;
		end
		
		if _IceStrike_RDY and (not _FrostShock_RDY or _FrostShock_CD > 2) then
			return _IceStrike;
		end

		if _Sundering_RDY and _target_in_10yrds then
			return _Sundering;
		end		

		if _FireNova_RDY and _FlameShock_DEBUFF then
			return _FireNova;
		end

		if _MaelstromWeapon_COUNT >= 5 then
			if (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() then
				if _ChainLightning_RDY then
					return _ChainLightning;
				end
			else
				if _LightningBolt_RDY then
					return _LightningBolt;
				end
			end
		end
		
		if _PrimalStrike_RDY and _Player_Level < 20 then
			return _PrimalStrike;
		end
	end
return nil;
end

function ConRO.Shaman.EnhancementDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Maelstrom, _Maelstrom_Max																	= ConRO:PlayerPower('Maelstrom');
	
--Abilities	
	local _AstralShift, _AstralShift_RDY 																= ConRO:AbilityReady(ids.Enh_Ability.AstralShift, timeShift);
	local _HealingStreamTotem, _HealingStreamTotem_RDY													= ConRO:AbilityReady(ids.Enh_Ability.HealingStreamTotem, timeShift);
	local _HealingSurge, _HealingSurge_RDY																= ConRO:AbilityReady(ids.Enh_Ability.HealingSurge, timeShift);

		local _, _MaelstromWeapon_COUNT																		= ConRO:Aura(ids.Enh_Buff.MaelstromWeapon, timeShift);

	local _FaeTransfusionEND, _FaeTransfusionEND_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.FaeTransfusionEND, timeShift);	
		local _FaeTransfusion_BUFF, _, _FaeTransfusion_DUR													= ConRO:Aura(ids.Covenant_Buff.FaeTransfusion, timeShift);
	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations	
	if _Fleshcraft_RDY and _in_combat then
		return _Fleshcraft;
	end
	
	if _FaeTransfusionEND_RDY and _FaeTransfusion_BUFF and _FaeTransfusion_DUR <= 2 then
		return _FaeTransfusionEND;
	end
	
	if _HealingSurge_RDY and _Player_Percent_Health <= 80 and _MaelstromWeapon_COUNT >= 5 then
		return _HealingSurge;
	end
	
	if _HealingStreamTotem_RDY and _Player_Percent_Health <= 80 then
		return _HealingStreamTotem;
	end	
	
	if _AstralShift_RDY then
		return _AstralShift;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end	
return nil;
end

function ConRO.Shaman.Restoration(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Maelstrom, _Maelstrom_Max																	= ConRO:PlayerPower('Maelstrom');
	
--Abilities
	local _Purge, _Purge_RDY 																			= ConRO:AbilityReady(ids.Resto_Ability.Purge, timeShift);	
	local _WindShear, _WindShear_RDY 																	= ConRO:AbilityReady(ids.Resto_Ability.WindShear, timeShift);
	local _LightningBolt, _LightningBolt_RDY															= ConRO:AbilityReady(ids.Resto_Ability.LightningBolt, timeShift);
	local _ChainLightning, _ChainLightning_RDY															= ConRO:AbilityReady(ids.Resto_Ability.ChainLightning, timeShift);
	local _EarthElemental, _EarthElemental_RDY, _EarthElemental_CD, _EarthElemental_MaxCD				= ConRO:AbilityReady(ids.Resto_Ability.EarthElemental, timeShift);
	local _LavaBurst, _LavaBurst_RDY																	= ConRO:AbilityReady(ids.Resto_Ability.LavaBurst, timeShift);
		local _LavaBurst_CHARGES																			= ConRO:SpellCharges(ids.Resto_Ability.LavaBurst);
		local _LavaSurge_BUFF 																				= ConRO:Aura(ids.Resto_Buff.LavaSurge, timeShift);
	local _FlameShock, _FlameShock_RDY																	= ConRO:AbilityReady(ids.Resto_Ability.FlameShock, timeShift);
		local _FlameShock_DEBUFF 																			= ConRO:TargetAura(ids.Resto_Debuff.FlameShock, timeShift + 4);
	local _HealingStreamTotem, _HealingStreamTotem_RDY													= ConRO:AbilityReady(ids.Resto_Ability.HealingStreamTotem, timeShift);
		
	local _EarthShield, _EarthShield_RDY																= ConRO:AbilityReady(ids.Resto_Ability.EarthShield, timeShift);

	local _ChainHarvest, _ChainHarvest_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.ChainHarvest, timeShift);
	local _FaeTransfusion, _FaeTransfusion_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.FaeTransfusion, timeShift);	
		local _FaeTransfusionEND, _FaeTransfusionEND_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.FaeTransfusionEND, timeShift);	
	local _PrimordialWave, _PrimordialWave_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.PrimordialWave, timeShift);
		local _PrimordialWave_BUFF																			= ConRO:Aura(ids.Ele_Buff.PrimordialWave, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _VesperTotem, _VesperTotem_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.VesperTotem, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
		if currentSpell == _LavaBurst then
			_LavaBurst_CHARGES = _LavaBurst_CHARGES - 1;
		end
		
--Indicators
	ConRO:AbilityInterrupt(_WindShear, _WindShear_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Purge, _Purge_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityRaidBuffs(_EarthShield, _EarthShield_RDY and not ConRO:OneBuff(ids.Resto_Buff.EarthShield));
	ConRO:AbilityRaidBuffs(_HealingStreamTotem, _HealingStreamTotem_RDY);
	
	ConRO:AbilityBurst(_EarthElemental, _EarthElemental_RDY and _is_Enemy);

	ConRO:AbilityBurst(_FaeTransfusion, _FaeTransfusion_RDY and _is_Enemy);
	ConRO:AbilityBurst(_ChainHarvest, _ChainHarvest_RDY and _is_Enemy);
	ConRO:AbilityBurst(_VesperTotem, _VesperTotem_RDY and _is_Enemy);
	ConRO:AbilityBurst(_PrimordialWave, _PrimordialWave_RDY and not _PrimordialWave_BUFF and _is_Enemy);
	
--Rotations
	if _is_Enemy then
		if _FlameShock_RDY and not _FlameShock_DEBUFF then
			return _FlameShock;
		end	
		
		if _LavaBurst_RDY and _LavaBurst_CHARGES >= 1 then
			return _LavaBurst;
		end
		
		if _LightningBolt_RDY then
			return _LightningBolt;
		end
	end
return nil;
end

function ConRO.Shaman.RestorationDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Maelstrom, _Maelstrom_Max																	= ConRO:PlayerPower('Maelstrom');
	
--Abilities	
	local _AstralShift, _AstralShift_RDY 																= ConRO:AbilityReady(ids.Resto_Ability.AstralShift, timeShift);

	local _FaeTransfusionEND, _FaeTransfusionEND_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.FaeTransfusionEND, timeShift);	
		local _FaeTransfusion_BUFF, _, _FaeTransfusion_DUR													= ConRO:Aura(ids.Covenant_Buff.FaeTransfusion, timeShift);
	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations	
	if _Fleshcraft_RDY and _in_combat then
		return _Fleshcraft;
	end
	
	if _FaeTransfusionEND_RDY and _FaeTransfusion_BUFF and _FaeTransfusion_DUR <= 2 then
		return _FaeTransfusionEND;
	end

	if _AstralShift_RDY then
		return _AstralShift;
	end
	
	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end