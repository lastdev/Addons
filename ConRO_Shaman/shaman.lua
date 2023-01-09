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
			self.ToggleDamage();
			self.BlockBurst();
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
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Shaman_Ability, ids.Shaman_Passive, ids.Shaman_Form, ids.Shaman_Buff, ids.Shaman_Debuff, ids.Shaman_PetAbility, ids.Shaman_PvPTalent, ids.Glyph;
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
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Shaman_Ability, ids.Shaman_Passive, ids.Shaman_Form, ids.Shaman_Buff, ids.Shaman_Debuff, ids.Shaman_PetAbility, ids.Shaman_PvPTalent, ids.Glyph;
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
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ele_Ability, ids.Ele_Passive, ids.Ele_Form, ids.Ele_Buff, ids.Ele_Debuff, ids.Ele_PetAbility, ids.Ele_PvPTalent, ids.Glyph;
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
	local _ChainLightning, _ChainLightning_RDY = ConRO:AbilityReady(Ability.ChainLightning, timeShift);
	local _EarthElemental, _EarthElemental_RDY, _EarthElemental_CD, _EarthElemental_MaxCD = ConRO:AbilityReady(Ability.EarthElemental, timeShift);
	local _Earthquake, _Earthquake_RDY = ConRO:AbilityReady(Ability.Earthquake, timeShift);
	local _EarthShock, _EarthShock_RDY = ConRO:AbilityReady(Ability.EarthShock, timeShift);
		local _SurgeofPower_BUFF = ConRO:Aura(Buff.SurgeofPower, timeShift);
	local _ElementalBlast, _ElementalBlast_RDY = ConRO:AbilityReady(Ability.ElementalBlast, timeShift);
		local _ElementalBlast_CriticalStrike = ConRO:Aura(Buff.ElementalBlast.CriticalStrike, timeShift);
		local _ElementalBlast_Haste = ConRO:Aura(Buff.ElementalBlast.Haste, timeShift);
		local _ElementalBlast_Mastery = ConRO:Aura(Buff.ElementalBlast.Mastery, timeShift);
	local _FireElemental, _FireElemental_RDY, _FireElemental_CD, _FireElemental_MaxCD = ConRO:AbilityReady(Ability.FireElemental, timeShift);
		local _Meteor, _Meteor_RDY = ConRO:AbilityReady(PetAbility.Meteor, timeShift, 'pet');
	local _FlameShock, _FlameShock_RDY = ConRO:AbilityReady(Ability.FlameShock, timeShift);
		local _FlameShock_DEBUFF, _, _FlameShock_DUR = ConRO:TargetAura(Debuff.FlameShock, timeShift);
	local _FrostShock, _FrostShock_RDY = ConRO:AbilityReady(Ability.FrostShock, timeShift);
	local _LavaBurst, _LavaBurst_RDY = ConRO:AbilityReady(Ability.LavaBurst, timeShift);
		local _LavaBurst_CHARGES = ConRO:SpellCharges(_LavaBurst);
		local _LavaSurge_BUFF = ConRO:Aura(Buff.LavaSurge, timeShift);
		local _MasteroftheElements_BUFF = ConRO:Aura(Buff.MasteroftheElements, timeShift);
	local _LightningBolt, _LightningBolt_RDY															= ConRO:AbilityReady(Ability.LightningBolt, timeShift);
	local _LightningShield, _LightningShield_RDY														= ConRO:AbilityReady(Ability.LightningShield, timeShift);
		local _LightningShield_BUFF																			= ConRO:Aura(Buff.LightningShield, timeShift);
	local _Purge, _Purge_RDY 																			= ConRO:AbilityReady(Ability.Purge, timeShift);
	local _Thunderstorm, _Thunderstorm_RDY																= ConRO:AbilityReady(Ability.Thunderstorm, timeShift);
	local _WindShear, _WindShear_RDY 																	= ConRO:AbilityReady(Ability.WindShear, timeShift);
	local _Ascendance, _Ascendance_RDY, _Ascendance_CD 													= ConRO:AbilityReady(Ability.Ascendance, timeShift);
		local _Ascendance_BUFF 																				= ConRO:Aura(Buff.Ascendance, timeShift);
		local _LavaBeam, _LavaBeam_RDY 																	= ConRO:AbilityReady(Ability.LavaBeam, timeShift);
	local _EarthShield, _EarthShield_RDY																= ConRO:AbilityReady(Ability.EarthShield, timeShift);
	local _Icefury, _Icefury_RDY 																		= ConRO:AbilityReady(Ability.Icefury, timeShift);
		local _Icefury_BUFF, _Icefury_COUNT = ConRO:Aura(Buff.Icefury, timeShift);
	local _LiquidMagmaTotem, _LiquidMagmaTotem_RDY 														= ConRO:AbilityReady(Ability.LiquidMagmaTotem, timeShift);
	local _StormElemental, _StormElemental_RDY, _StormElemental_CD, _StormElemental_MaxCD = ConRO:AbilityReady(Ability.StormElemental, timeShift);
		local _WindGust_BUFF, _WindGust_COUNT = ConRO:Form(Form.WindGust);
		local _CallLightning, _CallLightning_RDY = ConRO:AbilityReady(PetAbility.CallLightning, timeShift, 'pet');
		local _Tempest, _Tempest_RDY = ConRO:AbilityReady(PetAbility.Tempest, timeShift, 'pet');
	local _Stormkeeper, _Stormkeeper_RDY = ConRO:AbilityReady(Ability.Stormkeeper, timeShift);
		local _Stormkeeper_BUFF = ConRO:Aura(Buff.Stormkeeper, timeShift);
		local _Stormkeeper_CHARGES = ConRO:SpellCharges(_Stormkeeper);
	local _PrimordialWave, _PrimordialWave_RDY															= ConRO:AbilityReady(Ability.PrimordialWave, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

	local _Primal_elemental_summoned = ConRO:CallPet();
	local _Elemental_name = UnitName("pet");
	local _Elemental_summoned = false;
	local _current_pet_spell																			= select(9, UnitCastingInfo('pet'));

	local _ElementalBlast_BUFF = false;
		if _ElementalBlast_CriticalStrike or _ElementalBlast_Haste or _ElementalBlast_Mastery then
			_ElementalBlast_BUFF = true;
		end

		if (_Primal_elemental_summoned and _Elemental_name == ("Primal Storm Elemental" or "Primal Fire Elemental")) or (_StormElemental_CD >= _StormElemental_MaxCD - 30) or (_FireElemental_CD >= _FireElemental_MaxCD - 30) then
			_Elemental_summoned = true;
		end

		if not tChosen[Passive.EchooftheElements.talentID] and _LavaBurst_RDY then
			_LavaBurst_CHARGES = 1;
		end

	local _LavaBurst_Mael, _LightningBolt_Mael, _Icefury_Mael = 10, 8, 25;
		if tChosen[Passive.FlowofPower.talentID] then
			_LavaBurst_Mael = _LavaBurst_Mael + 2;
			_LightningBolt_Mael = _LightningBolt_Mael + 2;
		end
		if currentSpell == _LavaBurst then
			_Maelstrom = _Maelstrom + _LavaBurst_Mael;
			_LavaBurst_CHARGES = _LavaBurst_CHARGES - 1;
		end
		if currentSpell == _LightningBolt then
			_Maelstrom = _Maelstrom + _LavaBurst_Mael;
		end
		if currentSpell == _Icefury then
			_Maelstrom = _Maelstrom + _Icefury_Mael;
		end

		if ConRO_AoEButton:IsVisible() then
			_LightningBolt, _LightningBolt_RDY = _ChainLightning, _ChainLightning_RDY;
		end
--Indicators	
	ConRO:AbilityInterrupt(_WindShear, _WindShear_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Purge, _Purge_RDY and ConRO:Purgable());

	ConRO:AbilityBurst(_Thunderstorm, _Thunderstorm_RDY and ((ConRO:Interrupt() and not _WindShear_RDY and _target_in_melee) or (_target_in_melee and ConRO:TarYou())));
	ConRO:AbilityBurst(_FireElemental, _FireElemental_RDY and ConRO_SingleButton:IsVisible() and (not tChosen[Passive.PrimalElementalist.talentID] or (tChosen[Passive.PrimalElementalist.talentID] and not _Primal_elemental_summoned)) and ConRO:BurstMode(_FireElemental, 150));
	ConRO:AbilityBurst(_StormElemental, _StormElemental_RDY and (not tChosen[Passive.PrimalElementalist.talentID] or (tChosen[Passive.PrimalElementalist.talentID] and not _Primal_elemental_summoned)) and ConRO:BurstMode(_StormElemental, 150));
	ConRO:AbilityBurst(_EarthElemental, _EarthElemental_RDY and not (_StormElemental_RDY or _FireElemental_RDY) and (not tChosen[Passive.PrimalElementalist.talentID] or (tChosen[Passive.PrimalElementalist.talentID] and not _Primal_elemental_summoned)));
	ConRO:AbilityBurst(_Ascendance, _Ascendance_RDY and ConRO_SingleButton:IsVisible() and ConRO:BurstMode(_Ascendance));
	ConRO:AbilityBurst(_Stormkeeper, _Stormkeeper_RDY and currentSpell ~= _Stormkeeper and ConRO:BurstMode(_Stormkeeper));
	ConRO:AbilityBurst(_LiquidMagmaTotem, _LiquidMagmaTotem_RDY and ConRO:BurstMode(_LiquidMagmaTotem));
	ConRO:AbilityBurst(_PrimordialWave, _PrimordialWave_RDY and not _PrimordialWave_BUFF and ConRO:BurstMode(_PrimordialWave));

	ConRO:AbilityRaidBuffs(_EarthShield, _EarthShield_RDY and not ConRO:OneBuff(Buff.EarthShield));
	ConRO:AbilityRaidBuffs(_LightningShield, _LightningShield_RDY and not _LightningShield_BUFF);

--Rotations	
	for i = 1, 2, 1 do
		if _LiquidMagmaTotem_RDY and ConRO:FullMode(_LiquidMagmaTotem) and ConRO_AoEButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _LiquidMagmaTotem);
			_LiquidMagmaTotem_RDY = false;
		end

		if _PrimordialWave_RDY and not _FlameShock_DEBUFF and ConRO:FullMode(_PrimordialWave) then
			tinsert(ConRO.SuggestedSpells, _PrimordialWave);
			_PrimordialWave_RDY = false;
			_FlameShock_DEBUFF = true;
			_FlameShock_DUR = 18;
		end

		if _FlameShock_RDY and not _FlameShock_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _FlameShock);
			_FlameShock_RDY = false;
			_FlameShock_DEBUFF = true;
			_FlameShock_DUR = 18;
		end

		if (not tChosen[Passive.PrimalElementalist.talentID] or (tChosen[Passive.PrimalElementalist.talentID] and not _Primal_elemental_summoned)) then
			if tChosen[Ability.StormElemental.talentID] then
				if _StormElemental_RDY and ConRO:FullMode(_StormElemental, 150) then
					tinsert(ConRO.SuggestedSpells, _StormElemental);
				end
			else
				if _FireElemental_RDY and ConRO:FullMode(_FireElemental, 150) then
					tinsert(ConRO.SuggestedSpells, _FireElemental);
				end
			end
		end

		if _Meteor_RDY and _Elemental_summoned and _FireElemental_CD >= 135 then
			tinsert(ConRO.SuggestedSpells, _Meteor);
			_Meteor_RDY = false;
		end

		if _CallLightning_RDY and _Elemental_summoned and _StormElemental_CD >= 135 and _current_pet_spell ~= _CallLightning then
			tinsert(ConRO.SuggestedSpells, _CallLightning);
			_CallLightning_RDY = false;
		end

		if _Tempest_RDY and _Elemental_summoned and tChosen[Passive.PrimalElementalist.talentID] and _current_pet_spell ~= _Tempest and _current_pet_spell ~= _CallLightning then
			tinsert(ConRO.SuggestedSpells, _Tempest);
			_Tempest_RDY = false;
		end

		if _ElementalBlast_RDY and _Maelstrom >= 75 and currentSpell ~= _ElementalBlast then
			tinsert(ConRO.SuggestedSpells, _ElementalBlast);
			_Maelstrom = _Maelstrom - 75;
		end

		if _EarthShock_RDY and not tChosen[Ability.ElementalBlast.talentID] and _Maelstrom >= 90 and ConRO_SingleButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _EarthShock);
			_Maelstrom = _Maelstrom - 60;
		end

		if (tChosen[Passive.SurgeofPower.talentID] and _Maelstrom >= 58) or not tChosen[Passive.SurgeofPower.talentID] then
			if _Stormkeeper_RDY and currentSpell ~= _Stormkeeper and not _Stormkeeper_BUFF and ConRO:FullMode(_Stormkeeper) then
				tinsert(ConRO.SuggestedSpells, _Stormkeeper);
				_Stormkeeper_RDY = false;
			end
		end

		if _SurgeofPower_BUFF then
			if ConRO_AoEButton:IsVisible() then
				if _Earthquake_RDY and _Maelstrom >= 60 and _MasteroftheElements_BUFF then
					tinsert(ConRO.SuggestedSpells, _Earthquake);
					_MasteroftheElements_BUFF = false;
					_Maelstrom = _Maelstrom - 60;
				end
			else
				if _EarthShock_RDY and not tChosen[Ability.ElementalBlast.talentID] and _Maelstrom >= 60 then
					tinsert(ConRO.SuggestedSpells, _EarthShock);
					_MasteroftheElements_BUFF = false;
					_Maelstrom = _Maelstrom - 60;
				end
			end
			if _LightningBolt_RDY and _Stormkeeper_BUFF then
				tinsert(ConRO.SuggestedSpells, _LightningBolt);
				_MasteroftheElements_BUFF = false;
				_Maelstrom = _Maelstrom + _LightningBolt_Mael;
			end
		end

		if _LightningBolt_RDY and _Stormkeeper_BUFF and _MasteroftheElements_BUFF then
			tinsert(ConRO.SuggestedSpells, _LightningBolt);
			_MasteroftheElements_BUFF = false;
			_Maelstrom = _Maelstrom + _LightningBolt_Mael;
		end

		if _LiquidMagmaTotem_RDY and ConRO:FullMode(_LiquidMagmaTotem) then
			tinsert(ConRO.SuggestedSpells, _LiquidMagmaTotem);
			_LiquidMagmaTotem_RDY = false;
		end


		if _Ascendance_RDY and ConRO_AoEButton:IsVisible() and ConRO:FullMode(_Ascendance) then
			tinsert(ConRO.SuggestedSpells, _Ascendance);
			_Ascendance_RDY = false;
		end

		if ConRO_AoEButton:IsVisible() then
			if _Earthquake_RDY and _Maelstrom >= 60 and (_MasteroftheElements_BUFF or _Ascendance_BUFF) then
				tinsert(ConRO.SuggestedSpells, _Earthquake);
				_MasteroftheElements_BUFF = false;
				_Maelstrom = _Maelstrom - 60;
			end
		else
			if _EarthShock_RDY and not tChosen[Ability.ElementalBlast.talentID] and _Maelstrom >= 60 and (_MasteroftheElements_BUFF or _Ascendance_BUFF) then
				tinsert(ConRO.SuggestedSpells, _EarthShock);
				_MasteroftheElements_BUFF = false;
				_Maelstrom = _Maelstrom - 60;
			end
		end

		if _LavaBeam_RDY and _Ascendance_BUFF then
			tinsert(ConRO.SuggestedSpells, _LavaBeam);
		end

		if _FrostShock_RDY and _Icefury_BUFF and _Icefury_COUNT >= 1 and (tChosen[Passive.ElectrifiedShocks.talentID] and not _ElectrifiedShocks_Debuff) then
			tinsert(ConRO.SuggestedSpells, _FrostShock);
			_Icefury_COUNT = _Icefury_COUNT - 1;
			_ElectrifiedShocks_Debuff = true;
		end

		if _LightningBolt_RDY and _Storm_elemental_summoned then
			tinsert(ConRO.SuggestedSpells, _LightningBolt);
			_Maelstrom = _Maelstrom + _LightningBolt_Mael;
		end

		if _PrimordialWave_RDY and _FlameShock_DUR < 6 and ConRO:FullMode(_PrimordialWave) then
			tinsert(ConRO.SuggestedSpells, _PrimordialWave);
			_PrimordialWave_RDY = false;
			_FlameShock_DEBUFF = true;
			_FlameShock_DUR = 18;
		end

		if _FlameShock_RDY and _FlameShock_DUR < 6 then
			tinsert(ConRO.SuggestedSpells, _FlameShock);
			_FlameShock_RDY = false;
			_FlameShock_DEBUFF = true;
			_FlameShock_DUR = 18;
		end

		if _Icefury_RDY and currentSpell ~= _Icefury then
			tinsert(ConRO.SuggestedSpells, _Icefury);
			_Icefury_RDY = false;
			_Maelstrom = _Maelstrom + _Icefury_Mael;
		end

		if _LavaBurst_RDY and _LavaBurst_CHARGES >= 1 or _LavaSurge_BUFF then
			tinsert(ConRO.SuggestedSpells, _LavaBurst);
			_LavaSurge_BUFF = false;
			_LavaBurst_CHARGES = _LavaBurst_CHARGES - 1;
		end

		if _FrostShock_RDY and _Icefury_BUFF and _Icefury_COUNT >= 1 and not tChosen[Passive.ElectrifiedShocks.talentID] then
			tinsert(ConRO.SuggestedSpells, _FrostShock);
			_Icefury_COUNT = _Icefury_COUNT - 1;
		end

		if _LightningBolt_RDY then
			tinsert(ConRO.SuggestedSpells, _LightningBolt);
		end
	end
	return nil;
end

function ConRO.Shaman.ElementalDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ele_Ability, ids.Ele_Passive, ids.Ele_Form, ids.Ele_Buff, ids.Ele_Debuff, ids.Ele_PetAbility, ids.Ele_PvPTalent, ids.Glyph;
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

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

--Rotations	
	if _AstralShift_RDY then
		tinsert(ConRO.SuggestedDefSpells, _AstralShift);
	end
	return nil;
end

function ConRO.Shaman.Enhancement(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Enh_Ability, ids.Enh_Passive, ids.Enh_Form, ids.Enh_Buff, ids.Enh_Debuff, ids.Enh_PetAbility, ids.Enh_PvPTalent, ids.Glyph;
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
	local _Mana, _Mana_Max, _Mana_Percent = ConRO:PlayerPower('Mana');
	local _Maelstrom, _Maelstrom_Max = ConRO:PlayerPower('Maelstrom');

--Abilities
	local _Ascendance, _Ascendance_RDY = ConRO:AbilityReady(Ability.Ascendance, timeShift);
		local _Ascendance_BUFF = ConRO:Aura(Buff.Ascendance, timeShift);
		local _Windstrike, _Windstrike_RDY = ConRO:AbilityReady(Ability.Windstrike, timeShift);
	local _ChainLightning, _ChainLightning_RDY = ConRO:AbilityReady(Ability.ChainLightning, timeShift);
	local _CrashLightning, _CrashLightning_RDY = ConRO:AbilityReady(Ability.CrashLightning, timeShift);
		local _CrashLightning_BUFF = ConRO:Aura(Buff.CrashLightning, timeShift);
	local _DoomWinds, _DoomWinds_RDY = ConRO:AbilityReady(Ability.DoomWinds, timeShift);
	local _ElementalBlast, _ElementalBlast_RDY = ConRO:AbilityReady(Ability.ElementalBlast, timeShift);
		local _ElementalBlast_CHARGES, _ElementalBlast_MCHARGES = ConRO:SpellCharges(_ElementalBlast);
	local _FeralSpirit, _FeralSpirit_RDY, _FeralSpirit_CD = ConRO:AbilityReady(Ability.FeralSpirit, timeShift);
		local _CracklingSurge_BUFF = ConRO:Aura(Buff.ElementalSpirits.CrashLightning, timeShift);
		local _IcyEdge_BUFF = ConRO:Aura(Buff.ElementalSpirits.CrashLightning, timeShift);
		local _MoltenWeapon_BUFF = ConRO:Aura(Buff.ElementalSpirits.CrashLightning, timeShift);
	local _FlameShock, _FlameShock_RDY = ConRO:AbilityReady(Ability.FlameShock, timeShift + 1);
		local _FlameShock_DEBUFF, _, _FlameShock_DUR = ConRO:TargetAura(Debuff.FlameShock, timeShift);
	local _FlametongueWeapon, _FlametongueWeapon_RDY = ConRO:AbilityReady(Ability.FlametongueWeapon, timeShift);
		local _FlametongueWeapon_BUFF, _, _FlametongueWeapon_DUR = ConRO:UnitAura(Buff.FlametongueWeapon, timeShift, _, _, "Weapon");
	local _FrostShock, _FrostShock_RDY, _FrostShock_CD = ConRO:AbilityReady(Ability.FrostShock, timeShift);
		local _Hailstorm_BUFF = ConRO:Aura(Buff.Hailstorm, timeShift);
	local _LavaBurst, _LavaBurst_RDY = ConRO:AbilityReady(Ability.LavaBurst, timeShift);
	local _LavaLash, _LavaLash_RDY = ConRO:AbilityReady(Ability.LavaLash, timeShift);
		local _HotHand_BUFF = ConRO:Aura(Buff.HotHand, timeShift);
		local _LashingFlames_DEBUFF	= ConRO:TargetAura(Debuff.LashingFlames, timeShift);
		local _, _AshenCatalyst_COUNT = ConRO:Aura(Buff.AshenCatalyst, timeShift);
	local _LightningBolt, _LightningBolt_RDY = ConRO:AbilityReady(Ability.LightningBolt, timeShift);
		local _, _MaelstromWeapon_COUNT	= ConRO:Aura(Buff.MaelstromWeapon, timeShift);
	local _LightningShield, _LightningShield_RDY														= ConRO:AbilityReady(Ability.LightningShield, timeShift);
		local _LightningShield_BUFF																			= ConRO:Aura(Buff.LightningShield, timeShift);
	local _Purge, _Purge_RDY 																			= ConRO:AbilityReady(Ability.Purge, timeShift);
	local _PrimalStrike, _PrimalStrike_RDY 																= ConRO:AbilityReady(Ability.PrimalStrike, timeShift);
	local _PrimordialWave, _PrimordialWave_RDY															= ConRO:AbilityReady(Ability.PrimordialWave, timeShift);
		local _PrimordialWave_BUFF																			= ConRO:Aura(Buff.PrimordialWave, timeShift);
	local _Stormstrike, _Stormstrike_RDY																= ConRO:AbilityReady(Ability.Stormstrike, timeShift);
		local _Stormbringer_BUFF 																			= ConRO:Aura(Buff.Stormbringer, timeShift);
	local _WindShear, _WindShear_RDY 																	= ConRO:AbilityReady(Ability.WindShear, timeShift);
	local _WindfuryTotem, _WindfuryTotem_RDY															= ConRO:AbilityReady(Ability.WindfuryTotem, timeShift);
		local _WindfuryTotem_BUFF																			= ConRO:Form(Form.WindfuryTotem);
		local _, _WindfuryTotem_DUR = ConRO:Totem(_WindfuryTotem);
	local _WindfuryWeapon, _WindfuryWeapon_RDY															= ConRO:AbilityReady(Ability.WindfuryWeapon, timeShift);
		local _WindfuryWeapon_BUFF, _, _WindfuryWeapon_DUR													= ConRO:UnitAura(Buff.WindfuryWeapon, timeShift, _, _, "Weapon");

	local _Sundering, _Sundering_RDY 																	= ConRO:AbilityReady(Ability.Sundering, timeShift);
	local _EarthShield, _EarthShield_RDY																= ConRO:AbilityReady(Ability.EarthShield, timeShift);

	local _IceStrike, _IceStrike_RDY																	= ConRO:AbilityReady(Ability.IceStrike, timeShift);
	local _FireNova, _FireNova_RDY																		= ConRO:AbilityReady(Ability.FireNova, timeShift);
	local _FeralLunge, _FeralLunge_RDY																	= ConRO:AbilityReady(Ability.FeralLunge, timeShift);
		local _, _FeralLunge_RANGE 																			= ConRO:Targets(Ability.FeralLunge);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Indicators
	ConRO:AbilityInterrupt(_WindShear, _WindShear_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Purge, _Purge_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_FeralLunge, _FeralLunge_RDY and _FeralLunge_RANGE);

	ConRO:AbilityRaidBuffs(_EarthShield, _EarthShield_RDY and not ConRO:OneBuff(ids.Enh_Buff.EarthShield));
	ConRO:AbilityRaidBuffs(_LightningShield, _LightningShield_RDY and not _LightningShield_BUFF);
	ConRO:AbilityRaidBuffs(_WindfuryWeapon, _WindfuryWeapon_RDY and not _WindfuryWeapon_BUFF or (not _in_combat and _WindfuryWeapon_DUR < 600));
	ConRO:AbilityRaidBuffs(_FlametongueWeapon, _FlametongueWeapon_RDY and not _FlametongueWeapon_BUFF or (not _in_combat and _FlametongueWeapon_DUR < 600));

	ConRO:AbilityBurst(_Ascendance, _Ascendance_RDY and not _Stormstrike_RDY and ConRO:BurstMode(_Ascendance));
	ConRO:AbilityBurst(_DoomWinds, _DoomWinds_RDY and ConRO:BurstMode(_DoomWinds));
	ConRO:AbilityBurst(_FeralSpirit, _FeralSpirit_RDY and ConRO:BurstMode(_FeralSpirit));
	ConRO:AbilityBurst(_WindfuryTotem, _WindfuryTotem_RDY and not _WindfuryTotem_BUFF and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(_PrimordialWave, _PrimordialWave_RDY and not _PrimordialWave_BUFF and ConRO:BurstMode(_PrimordialWave));

--Warnings	

--Rotations
	for i = 1, 2, 1 do
		if not _in_combat then
			if _WindfuryTotem_RDY and (not _WindfuryTotem_BUFF) and ConRO_FullButton:IsVisible() then
				tinsert(ConRO.SuggestedSpells, _WindfuryTotem);
				_WindfuryTotem_BUFF = true;
			end

			if _PrimordialWave_RDY and not _FlameShock_DEBUFF and ConRO:FullMode(_PrimordialWave) then
				tinsert(ConRO.SuggestedSpells, _PrimordialWave);
				_PrimordialWave_RDY = false;
				_FlameShock_DEBUFF = true;
			end

			if _FlameShock_RDY and not _FlameShock_DEBUFF then
				tinsert(ConRO.SuggestedSpells, _FlameShock);
				_FlameShock_DEBUFF = true;
			end

			if _Stormstrike_RDY and not _Ascendance_BUFF then
				tinsert(ConRO.SuggestedSpells, _Stormstrike);
				_Stormstrike_RDY = false;
			end

			if _FeralSpirit_RDY and ConRO:FullMode(_FeralSpirit) then
				tinsert(ConRO.SuggestedSpells, _FeralSpirit);
				_FeralSpirit_RDY = false;
			end

			if _Stormstrike_RDY and _Ascendance_BUFF then
				tinsert(ConRO.SuggestedSpells, _Windstrike);
			end

			if _Ascendance_RDY and not _Stormstrike_RDY and ConRO:FullMode(_Ascendance) then
				tinsert(ConRO.SuggestedSpells, _Ascendance);
				_Ascendance_RDY = false;
			end
		end

		if _WindfuryTotem_RDY and (not _WindfuryTotem_BUFF) and ConRO_FullButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _WindfuryTotem);
			_WindfuryTotem_BUFF = true;
		end

		if _FeralSpirit_RDY and ConRO:FullMode(_FeralSpirit) then
			tinsert(ConRO.SuggestedSpells, _FeralSpirit);
			_FeralSpirit_RDY = true;
		end

		if _Ascendance_RDY and not _Stormstrike_RDY and ConRO:FullMode(_Ascendance) then
			tinsert(ConRO.SuggestedSpells, _Ascendance);
			_Ascendance_RDY = false;
		end

		if _DoomWinds_RDY and ConRO:FullMode(_DoomWinds) then
			tinsert(ConRO.SuggestedSpells, _DoomWinds);
			_DoomWinds_RDY = false;
		end

		if _Stormstrike_RDY and _Ascendance_BUFF then
			tinsert(ConRO.SuggestedSpells, _Windstrike);
		end

		if _LavaLash_RDY and (_HotHand_BUFF or _AshenCatalyst_COUNT >= 6) then
			tinsert(ConRO.SuggestedSpells, _LavaLash);
			_LavaLash_RDY = false;
		end

		if _FlameShock_RDY and not _FlameShock_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _FlameShock);
			_FlameShock_RDY = false;
			_FlameShock_DEBUFF = true;
		end

		if _MaelstromWeapon_COUNT >= 10 and tChosen[Passive.OverflowingMaelstrom.talentID] then
			if (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() and not _PrimordialWave_BUFF then
				if _ChainLightning_RDY then
					tinsert(ConRO.SuggestedSpells, _ChainLightning);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 10;
				end
			else
				if _LightningBolt_RDY and _PrimordialWave_BUFF then
					tinsert(ConRO.SuggestedSpells, _LightningBolt);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 10;
				end
			end
		end

		if _MaelstromWeapon_COUNT >= 5 and not tChosen[Passive.OverflowingMaelstrom.talentID] then
			if (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() and not _PrimordialWave_BUFF then
				if _ChainLightning_RDY then
					tinsert(ConRO.SuggestedSpells, _ChainLightning);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			else
				if _LightningBolt_RDY and _PrimordialWave_BUFF then
					tinsert(ConRO.SuggestedSpells, _LightningBolt);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			end
		end

		if _PrimordialWave_RDY and not _PrimordialWave_BUFF then
			tinsert(ConRO.SuggestedSpells, _PrimordialWave);
			_PrimordialWave_RDY = false;
			_PrimordialWave_BUFF = true;
		end

		if _MaelstromWeapon_COUNT >= 10 and tChosen[Passive.OverflowingMaelstrom.talentID] then
			if tChosen[Ability.ElementalBlast.talentID] then
				if _ElementalBlast_RDY and _ElementalBlast_CHARGES >= 1 and (_MoltenWeapon_BUFF or _IcyEdge_BUFF or _CracklingSurge_BUFF) then
					tinsert(ConRO.SuggestedSpells, _ElementalBlast);
					_ElementalBlast_CHARGES = _ElementalBlast_CHARGES - 1;
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 10;
				end
			else
				if _LavaBurst_RDY and _MoltenWeapon_BUFF then
					_LavaBurst_RDY = false;
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 10;
				end
			end
		end

		if _MaelstromWeapon_COUNT >= 5 and not tChosen[Passive.OverflowingMaelstrom.talentID] then
			if tChosen[Ability.ElementalBlast.talentID] then
				if _ElementalBlast_RDY and _ElementalBlast_CHARGES >= 1 and (_MoltenWeapon_BUFF or _IcyEdge_BUFF or _CracklingSurge_BUFF) then
					tinsert(ConRO.SuggestedSpells, _ElementalBlast);
					_ElementalBlast_CHARGES = _ElementalBlast_CHARGES - 1;
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			else
				if _LavaBurst_RDY and _MoltenWeapon_BUFF then
					_LavaBurst_RDY = false;
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			end
		end

		if _Sundering_RDY and tChosen[Passive.LegacyoftheFrostWitch.talentID] and _target_in_10yrds then
			tinsert(ConRO.SuggestedSpells, _Sundering);
			_Sundering_RDY = false;
		end

		if _IceStrike_RDY then
			tinsert(ConRO.SuggestedSpells, _IceStrike);
			_IceStrike_RDY = false;
		end

		if _FrostShock_RDY and _Hailstorm_BUFF then
			tinsert(ConRO.SuggestedSpells, _FrostShock);
			_FrostShock_RDY = false;
		end

		if _CrashLightning_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and _target_in_melee then
			tinsert(ConRO.SuggestedSpells, _CrashLightning);
			_CrashLightning_RDY = false;
		end

		if _LavaLash_RDY and tChosen[Passive.MoltenAssault.talentID] and _FlameShock_DUR < 4 then
			tinsert(ConRO.SuggestedSpells, _LavaLash);
			_LavaLash_RDY = false;
		end

		if _MaelstromWeapon_COUNT >= 10 and tChosen[Passive.OverflowingMaelstrom.talentID] then
			if tChosen[Ability.ElementalBlast.talentID] then
				if _ElementalBlast_RDY and _ElementalBlast_CHARGES == _ElementalBlast_MCHARGES then
					tinsert(ConRO.SuggestedSpells, _ElementalBlast);
					_ElementalBlast_CHARGES = _ElementalBlast_CHARGES - 1;
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 10;
				end
			else
				if _LavaBurst_RDY then
					_LavaBurst_RDY = false;
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 10;
				end
			end
		end

		if _MaelstromWeapon_COUNT >= 5 and not tChosen[Passive.OverflowingMaelstrom.talentID] then
			if tChosen[Ability.ElementalBlast.talentID] then
				if _ElementalBlast_RDY and _ElementalBlast_CHARGES == _ElementalBlast_MCHARGES then
					tinsert(ConRO.SuggestedSpells, _ElementalBlast);
					_ElementalBlast_CHARGES = _ElementalBlast_CHARGES - 1;
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			else
				if _LavaBurst_RDY then
					_LavaBurst_RDY = false;
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			end
		end

		if _MaelstromWeapon_COUNT >= 10 then
			if (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() then
				if _ChainLightning_RDY then
					tinsert(ConRO.SuggestedSpells, _ChainLightning);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			else
				if _LightningBolt_RDY then
					tinsert(ConRO.SuggestedSpells, _LightningBolt);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			end
		end

		if _Stormstrike_RDY then
			tinsert(ConRO.SuggestedSpells, _Stormstrike);
			_Stormstrike_RDY = false;
		end

		if _LavaLash_RDY then
			tinsert(ConRO.SuggestedSpells, _LavaLash);
			_LavaLash_RDY = false;
		end

		if _MaelstromWeapon_COUNT >= 8 and tChosen[Passive.OverflowingMaelstrom.talentID] then
			if _LavaBurst_RDY and not tChosen[Ability.ElementalBlast.talentID] then
				_LavaBurst_RDY = false;
				_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 10;
			end

			if (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() then
				if _ChainLightning_RDY then
					tinsert(ConRO.SuggestedSpells, _ChainLightning);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 10;
				end
			else
				if _LightningBolt_RDY then
					tinsert(ConRO.SuggestedSpells, _LightningBolt);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 10;
				end
			end
		end

		if _MaelstromWeapon_COUNT >= 5 and not tChosen[Passive.OverflowingMaelstrom.talentID] then
			if _LavaBurst_RDY and not tChosen[Ability.ElementalBlast.talentID] then
				_LavaBurst_RDY = false;
				_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
			end

			if (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() then
				if _ChainLightning_RDY then
					tinsert(ConRO.SuggestedSpells, _ChainLightning);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			else
				if _LightningBolt_RDY then
					tinsert(ConRO.SuggestedSpells, _LightningBolt);
					_MaelstromWeapon_COUNT = _MaelstromWeapon_COUNT - 5;
				end
			end
		end

		if _Sundering_RDY and _target_in_10yrds then
			tinsert(ConRO.SuggestedSpells, _Sundering);
			_Sundering_RDY = false;
		end

		if _FrostShock_RDY then
			tinsert(ConRO.SuggestedSpells, _FrostShock);
			_FrostShock_RDY = false;
		end

		if _CrashLightning_RDY and _target_in_melee then
			tinsert(ConRO.SuggestedSpells, _CrashLightning);
			_CrashLightning_RDY = false;
		end

		if _FireNova_RDY and _FlameShock_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _FireNova);
			_FireNova_RDY = false;
		end

		if _FlameShock_RDY then
			tinsert(ConRO.SuggestedSpells, _FlameShock);
			_FlameShock_RDY = false;
		end

		if _WindfuryTotem_RDY and _WindfuryTotem_DUR <= 30 and ConRO_FullButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _WindfuryTotem);
			_WindfuryTotem_BUFF = true;
			_WindfuryTotem_DUR = 120;
		end
	end
	return nil;
end

function ConRO.Shaman.EnhancementDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Enh_Ability, ids.Enh_Passive, ids.Enh_Form, ids.Enh_Buff, ids.Enh_Debuff, ids.Enh_PetAbility, ids.Enh_PvPTalent, ids.Glyph;
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
	local _Mana, _Mana_Max, _Mana_Percent = ConRO:PlayerPower('Mana');
	local _Maelstrom, _Maelstrom_Max = ConRO:PlayerPower('Maelstrom');

--Abilities	
	local _AstralShift, _AstralShift_RDY = ConRO:AbilityReady(Ability.AstralShift, timeShift);
	local _HealingStreamTotem, _HealingStreamTotem_RDY = ConRO:AbilityReady(Ability.HealingStreamTotem, timeShift);
	local _HealingSurge, _HealingSurge_RDY = ConRO:AbilityReady(Ability.HealingSurge, timeShift);

		local _, _MaelstromWeapon_COUNT = ConRO:Aura(Buff.MaelstromWeapon, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations	
	if _HealingSurge_RDY and _Player_Percent_Health <= 80 and _MaelstromWeapon_COUNT >= 5 then
		tinsert(ConRO.SuggestedDefSpells, _HealingSurge);
	end

	if _HealingStreamTotem_RDY and _Player_Percent_Health <= 80 then
		tinsert(ConRO.SuggestedDefSpells, _HealingStreamTotem);
	end

	if _AstralShift_RDY then
		tinsert(ConRO.SuggestedDefSpells, _AstralShift);
	end
	return nil;
end

function ConRO.Shaman.Restoration(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Resto_Ability, ids.Resto_Passive, ids.Resto_Form, ids.Resto_Buff, ids.Resto_Debuff, ids.Resto_PetAbility, ids.Resto_PvPTalent, ids.Glyph;
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
	local _Mana, _Mana_Max, _Mana_Percent = ConRO:PlayerPower('Mana');
	local _Maelstrom, _Maelstrom_Max = ConRO:PlayerPower('Maelstrom');

--Abilities
	local _EarthlivingWeapon, _EarthlivingWeapon_RDY = ConRO:AbilityReady(Ability.EarthlivingWeapon, timeShift);
		local _EarthlivingWeapon_BUFF, _, _EarthlivingWeapon_DUR = ConRO:UnitAura(Buff.EarthlivingWeapon, timeShift, _, _, "Weapon");
	local _Purge, _Purge_RDY 																			= ConRO:AbilityReady(Ability.Purge, timeShift);
	local _WindShear, _WindShear_RDY 																	= ConRO:AbilityReady(Ability.WindShear, timeShift);
	local _LightningBolt, _LightningBolt_RDY															= ConRO:AbilityReady(Ability.LightningBolt, timeShift);
	local _ChainLightning, _ChainLightning_RDY															= ConRO:AbilityReady(Ability.ChainLightning, timeShift);
	local _EarthElemental, _EarthElemental_RDY, _EarthElemental_CD, _EarthElemental_MaxCD				= ConRO:AbilityReady(Ability.EarthElemental, timeShift);
	local _LavaBurst, _LavaBurst_RDY																	= ConRO:AbilityReady(Ability.LavaBurst, timeShift);
		local _LavaBurst_CHARGES																			= ConRO:SpellCharges(_LavaBurst);
		local _LavaSurge_BUFF 																				= ConRO:Aura(Buff.LavaSurge, timeShift);
	local _FlameShock, _FlameShock_RDY																	= ConRO:AbilityReady(Ability.FlameShock, timeShift);
		local _FlameShock_DEBUFF 																			= ConRO:TargetAura(Debuff.FlameShock, timeShift + 6);
	local _HealingStreamTotem, _HealingStreamTotem_RDY													= ConRO:AbilityReady(Ability.HealingStreamTotem, timeShift);
	local _Stormkeeper, _Stormkeeper_RDY = ConRO:AbilityReady(Ability.Stormkeeper, timeShift);
	local _EarthShield, _EarthShield_RDY = ConRO:AbilityReady(Ability.EarthShield, timeShift);
	local _LightningShield, _LightningShield_RDY = ConRO:AbilityReady(Ability.LightningShield, timeShift);
		local _LightningShield_BUFF = ConRO:Aura(Buff.LightningShield, timeShift);
	local _WaterShield, _WaterShield_RDY = ConRO:AbilityReady(Ability.WaterShield, timeShift);
		local _WaterShield_BUFF = ConRO:Aura(Buff.WaterShield, timeShift);

	local _PrimordialWave, _PrimordialWave_RDY															= ConRO:AbilityReady(Ability.PrimordialWave, timeShift);
		local _PrimordialWave_BUFF																			= ConRO:Aura(Buff.PrimordialWave, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

		if currentSpell == _LavaBurst then
			_LavaBurst_CHARGES = _LavaBurst_CHARGES - 1;
		end

--Indicators
	ConRO:AbilityInterrupt(_WindShear, _WindShear_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Purge, _Purge_RDY and ConRO:Purgable());

	ConRO:AbilityRaidBuffs(_EarthShield, _EarthShield_RDY and not ConRO:OneBuff(Buff.EarthShield));
	ConRO:AbilityRaidBuffs(_HealingStreamTotem, _HealingStreamTotem_RDY);
	ConRO:AbilityRaidBuffs(_WaterShield, _WaterShield_RDY and not (_WaterShield_BUFF or _LightningShield_BUFF));
	ConRO:AbilityRaidBuffs(_EarthlivingWeapon, _EarthlivingWeapon_RDY and not _EarthlivingWeapon_BUFF or (not _in_combat and _EarthlivingWeapon_DUR < 600));

	ConRO:AbilityBurst(_EarthElemental, _EarthElemental_RDY and _is_Enemy);
	ConRO:AbilityBurst(_PrimordialWave, _PrimordialWave_RDY and not _PrimordialWave_BUFF and _is_Enemy);

--Rotations
	if _is_Enemy then
		if _Stormkeeper_RDY then
			tinsert(ConRO.SuggestedSpells, _Stormkeeper);
			_Stormkeeper_RDY = false;
		end

		if _FlameShock_RDY and not _FlameShock_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _FlameShock);
			_FlameShock_DEBUFF = true;
		end

		if _LavaBurst_RDY and _LavaBurst_CHARGES >= 1 and ConRO_SingleButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _LavaBurst);
			_LavaBurst_CHARGES = _LavaBurst_CHARGES - 1;
		end

		if _LavaBurst_RDY and _LavaSurge_BUFF and ConRO_AoEButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _LavaBurst);
			_LavaSurge_BUFF = false;
		end

		if _ChainLightning_RDY and ConRO_AoEButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _ChainLightning);
		end

		if _LightningBolt_RDY and ConRO_SingleButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _LightningBolt);
		end
	end
return nil;
end

function ConRO.Shaman.RestorationDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max, _Mana_Percent																= ConRO:PlayerPower('Mana');
	local _Maelstrom, _Maelstrom_Max																	= ConRO:PlayerPower('Maelstrom');

--Abilities	
	local _AstralShift, _AstralShift_RDY 																= ConRO:AbilityReady(Ability.AstralShift, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

--Rotations	
	if _AstralShift_RDY then
		tinsert(ConRO.SuggestedDefSpells, _AstralShift);
	end
	return nil;
end
