ConRO.Warlock = {};
ConRO.Warlock.CheckTalents = function()
end
ConRO.Warlock.CheckPvPTalents = function()
end
local ConRO_Warlock, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Warlock.CheckTalents;
	self.ModuleOnEnable = ConRO.Warlock.CheckPvPTalents;	
	if mode == 0 then
		self.Description = "Warlock [No Specialization Under 10]";
		self.NextSpell = ConRO.Warlock.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = 'Warlock [Affliction - Caster]';
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Warlock.Affliction;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Warlock.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 2 then
		self.Description = 'Warlock [Demonology - Caster]';
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Warlock.Demonology;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Warlock.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 3 then
		self.Description = 'Warlock [Destruction - Caster]';
		if ConRO.db.profile._Spec_3_Enabled then	
			self.NextSpell = ConRO.Warlock.Destruction;
			self.ToggleDamage();
			self.BlockAoE();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Warlock.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED');
	self.lastSpellId = 0;	
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 0;
	if mode == 0 then
		self.NextDef = ConRO.Warlock.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Warlock.AfflictionDef;
		else
			self.NextDef = ConRO.Warlock.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Warlock.DemonologyDef;
		else
			self.NextDef = ConRO.Warlock.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Warlock.DestructionDef;
		else
			self.NextDef = ConRO.Warlock.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Warlock.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Warlock.Under10(_, timeShift, currentSpell, gcd)
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
	local _SoulShards																					= ConRO:PlayerPower('SoulShards');

--Racials
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);

--Abilities
	local _Corruption, _Corruption_RDY																	= ConRO:AbilityReady(ids.Warlock_Ability.Corruption, timeShift);	
		local _Corruption_DEBUFF, _, _Corruption_DUR														= ConRO:TargetAura(ids.Warlock_Debuff.Corruption, timeShift);
	local _ShadowBolt, _ShadowBolt_RDY																	= ConRO:AbilityReady(ids.Warlock_Ability.ShadowBolt, timeShift);
	local _SummonImp, _SummonImp_RDY																	= ConRO:AbilityReady(ids.Warlock_Ability.SummonImp, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	local _Void_out																						= IsSpellKnown(ids.Demo_PetAbility.ThreateningPresence, true);
	
--Warnings
	ConRO:Warnings("Summon your demon!", _SummonImp_RDY and not _Pet_summoned);

--Rotations	
	if _Corruption_RDY and not _Corruption_DEBUFF and currentSpell ~= _Corruption then
		return _Corruption;
	end

	if _ShadowBolt_RDY then
		return _ShadowBolt;
	end	
return nil;
end

function ConRO.Warlock.Under10Def(_, timeShift, currentSpell, gcd)
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
	local _SoulShards																					= ConRO:PlayerPower('SoulShards');

--Racials
	local _Cannibalize, _Cannibalize_RDY																= ConRO:AbilityReady(ids.Racial.Cannibalize, timeShift);

--Abilities
	local _CreateHealthstone, _CreateHealthstone_RDY													= ConRO:AbilityReady(ids.Warlock_Ability.CreateHealthstone, timeShift);
		local _Healthstone, _Healthstone_RDY, _, _, _Healthstone_COUNT										= ConRO:ItemReady(ids.Warlock_Ability.Healthstone, timeShift);
	local _DrainLife, _DrainLife_RDY																	= ConRO:AbilityReady(ids.Warlock_Ability.DrainLife, timeShift);	
	local _HealthFunnel, _HealthFunnel_RDY																= ConRO:AbilityReady(ids.Warlock_Ability.HealthFunnel, timeShift);
	local _UnendingResolve, _UnendingResolve_RDY 														= ConRO:AbilityReady(ids.Warlock_Ability.UnendingResolve, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');

--Rotations	
	if _CreateHealthstone_RDY and not _in_combat and _Healthstone_COUNT <= 0 then
		return _CreateHealthstone;
	end
	
	if _DrainLife_RDY and _Player_Percent_Health <= 80 then
		return _DrainLife;
	end	

	if _HealthFunnel_RDY and _Pet_summoned and _Pet_Percent_Health <= 50 then
		return _HealthFunnel;
	end
	
	if _Healthstone_RDY and _Player_Percent_Health <= 50 then
		return _Healthstone;
	end
	
	if _UnendingResolve_RDY then
		return _UnendingResolve;
	end
return nil;
end

function ConRO.Warlock.Affliction(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _SoulShards																					= ConRO:PlayerPower('SoulShards');

--Racials
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local _Agony, _Agony_RDY																			= ConRO:AbilityReady(ids.Aff_Ability.Agony, timeShift);
		local _Agony_DEBUFF, _, _Agony_DUR																	= ConRO:TargetAura(ids.Aff_Debuff.Agony, timeShift);
		local _InevitableDemise_BUFF, _InevitableDemise_COUNT, _InevitableDemise_DUR 						= ConRO:Aura(ids.Aff_Buff.InevitableDemise, timeShift);		
	local _Corruption, _Corruption_RDY																	= ConRO:AbilityReady(ids.Aff_Ability.Corruption, timeShift);	
		local _Corruption_DEBUFF, _, _Corruption_DUR														= ConRO:TargetAura(ids.Aff_Debuff.Corruption, timeShift);
	local _CommandDemon_SpellLock																		= ConRO:AbilityReady(ids.Aff_Ability.CommandDemon.SpellLock, timeShift);	
	local _DrainLife, _DrainLife_RDY																	= ConRO:AbilityReady(ids.Aff_Ability.DrainLife, timeShift);	
	local _MaleficRapture, _MaleficRapture_RDY															= ConRO:AbilityReady(ids.Aff_Ability.MaleficRapture, timeShift);
	local _SeedofCorruption, _SeedofCorruption_RDY														= ConRO:AbilityReady(ids.Aff_Ability.SeedofCorruption, timeShift);
		local _SeedofCorruption_DEBUFF																		= ConRO:TargetAura(ids.Aff_Debuff.SeedofCorruption, timeShift);	
	local _ShadowBolt, _ShadowBolt_RDY																	= ConRO:AbilityReady(ids.Aff_Ability.ShadowBolt, timeShift);
		local _ShadowEmbrace_DEBUFF, _ShadowEmbrace_COUNT, _ShadowEmbrace_DUR								= ConRO:TargetAura(ids.Aff_Debuff.ShadowEmbrace, timeShift);		
	local _SummonDarkglare, _SummonDarkglare_RDY, _SummonDarkglare_CD									= ConRO:AbilityReady(ids.Aff_Ability.SummonDarkglare, timeShift);
	local _SummonFelhunter, _SummonFelhunter_RDY														= ConRO:AbilityReady(ids.Aff_Ability.SummonFelhunter, timeShift);
	local _UnstableAffliction, _UnstableAffliction_RDY													= ConRO:AbilityReady(ids.Aff_Ability.UnstableAffliction, timeShift);
		local _UnstableAffliction_DEBUFF, _, _UnstableAffliction_DUR										= ConRO:TargetAura(ids.Aff_Debuff.UnstableAffliction, timeShift);

	local _SpellLock, _SpellLock_RDY																	= ConRO:AbilityReady(ids.Aff_PetAbility.SpellLock, timeShift, 'pet');
	local _DevourMagic, _DevourMagic_RDY																= ConRO:AbilityReady(ids.Aff_PetAbility.DevourMagic, timeShift, 'pet');
	
	local _DarkSoulMisery, _DarkSoulMisery_RDY															= ConRO:AbilityReady(ids.Aff_Talent.DarkSoulMisery, timeShift);
	local _DrainSoul, _DrainSoul_RDY																	= ConRO:AbilityReady(ids.Aff_Talent.DrainSoul, timeShift);
		local _DrainSoul_DEBUFF																				= ConRO:TargetAura(ids.Aff_Debuff.DrainSoul, timeShift);
	local _GrimoireofSacrifice, _GrimoireofSacrifice_RDY 												= ConRO:AbilityReady(ids.Aff_Talent.GrimoireofSacrifice, timeShift);
		local _GrimoireofSacrifice_BUFF																	= ConRO:Aura(ids.Aff_Buff.GrimoireofSacrifice, timeShift);
	local _Haunt, _Haunt_RDY																			= ConRO:AbilityReady(ids.Aff_Talent.Haunt, timeShift);
	local _PhantomSingularity, _PhantomSingularity_RDY 													= ConRO:AbilityReady(ids.Aff_Talent.PhantomSingularity, timeShift);
		local _PhantomSingularity_DEBUFF, _, _PhantomSingularity_DUR										= ConRO:TargetAura(ids.Aff_Debuff.PhantomSingularity, timeShift);
	local _SiphonLife, _SiphonLife_RDY																	= ConRO:AbilityReady(ids.Aff_Talent.SiphonLife, timeShift);
		local _SiphonLife_DEBUFF, _, _SiphonLife_DUR														= ConRO:TargetAura(ids.Aff_Debuff.SiphonLife, timeShift);
	local _UnstableAffliction_RampantAfflictions, _, _UnstableAffliction_RampantAfflictions_CD			= ConRO:AbilityReady(ids.Aff_PvPTalent.UnstableAffliction_RampantAfflictions, timeShift);
	local _VileTaint, _VileTaint_RDY																	= ConRO:AbilityReady(ids.Aff_Talent.VileTaint, timeShift);
		local _VileTaint_DEBUFF, _, _VileTaint_DUR															= ConRO:TargetAura(ids.Aff_Debuff.VileTaint, timeShift);

	local _Deathbolt, _Deathbolt_RDY																	= ConRO:AbilityReady(ids.Aff_PvPTalent.Deathbolt, timeShift);

	local _DecimatingBolt, _DecimatingBolt_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.DecimatingBolt, timeShift);
	local _ImpendingCatastrophe, _ImpendingCatastrophe_RDY												= ConRO:AbilityReady(ids.Covenant_Ability.ImpendingCatastrophe, timeShift);
	local _ScouringTithe, _ScouringTithe_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.ScouringTithe, timeShift);
	local _SoulRot, _SoulRot_RDY																		= ConRO:AbilityReady(ids.Covenant_Ability.SoulRot, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	local _Void_out																						= IsSpellKnown(ids.Demo_PetAbility.ThreateningPresence, true);

		if _is_PvP then
			if pvpChosen[ids.Aff_PvPTalent.RampantAfflictions] then
				_UnstableAffliction_RDY = _UnstableAffliction_RDY and _UnstableAffliction_RampantAfflictions_CD <= 0;
				_UnstableAffliction_DEBUFF, _, _UnstableAffliction_DUR = ConRO:TargetAura(ids.Aff_Debuff.UnstableAffliction_RampantAfflictions, timeShift);			
				_UnstableAffliction = _UnstableAffliction_RampantAfflictions;
			end
		end
	
	if tChosen[ids.Aff_Talent.AbsoluteCorruption] then
		_Corruption_DEBUFF = ConRO:PersistentDebuff(ids.Aff_Debuff.Corruption);
		_Corruption_DUR = 10000;
	end
	
	if currentSpell == _MaleficRapture then
		_SoulShards = _SoulShards - 1;
	elseif currentSpell == _SeedofCorruption then
		_SoulShards = _SoulShards - 1;
	elseif currentSpell == _VileTaint then
		_SoulShards = _SoulShards - 1;
	end

	if _Player_Level >= 27 and ConRO_AoEButton:IsVisible() then
		_Corruption = _SeedofCorruption;
		_Corruption_RDY = _SeedofCorruption_RDY and _SoulShards >= 1;
	end
	
	if currentSpell == _Haunt then
		_ShadowEmbrace_COUNT = _ShadowEmbrace_COUNT + 1;
	elseif currentSpell == _ShadowBolt then
		_ShadowEmbrace_COUNT = _ShadowEmbrace_COUNT + 1;
	end
	
--Indicators
	ConRO:AbilityInterrupt(_CommandDemon_SpellLock, _SpellLock_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_SpellLock, _SpellLock_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_DevourMagic, _DevourMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityBurst(_SummonDarkglare, _SummonDarkglare_RDY and _Agony_DEBUFF and _Corruption_DEBUFF and _UnstableAffliction_DEBUFF and (not tChosen[ids.Aff_Talent.SiphonLife] or (tChosen[ids.Aff_Talent.SiphonLife] and _SiphonLife_DEBUFF)) and (not tChosen[ids.Aff_Talent.PhantomSingularity] or (tChosen[ids.Aff_Talent.PhantomSingularity] and _PhantomSingularity_DEBUFF)) and (not tChosen[ids.Aff_Talent.VileTaint] or (tChosen[ids.Aff_Talent.VileTaint] and _VileTaint_DEBUFF)) and ConRO:BurstMode(_SummonDarkglare));
	ConRO:AbilityBurst(_DarkSoulMisery, _DarkSoulMisery_RDY and _Agony_DEBUFF and _Corruption_DEBUFF and _UnstableAffliction_DEBUFF and (not tChosen[ids.Aff_Talent.SiphonLife] or (tChosen[ids.Aff_Talent.SiphonLife] and _SiphonLife_DEBUFF)) and (not tChosen[ids.Aff_Talent.PhantomSingularity] or (tChosen[ids.Aff_Talent.PhantomSingularity] and _PhantomSingularity_DEBUFF)) and (not tChosen[ids.Aff_Talent.VileTaint] or (tChosen[ids.Aff_Talent.VileTaint] and _VileTaint_DEBUFF)) and ConRO:BurstMode(_DarkSoulMisery));	
	ConRO:AbilityBurst(_PhantomSingularity, _PhantomSingularity_RDY and _Agony_DEBUFF and _Corruption_DEBUFF and _UnstableAffliction_DEBUFF and (not tChosen[ids.Aff_Talent.SiphonLife] or (tChosen[ids.Aff_Talent.SiphonLife] and _SiphonLife_DEBUFF)) and ConRO:BurstMode(_PhantomSingularity));

	ConRO:AbilityBurst(_SoulRot, _SoulRot_RDY and currentSpell ~= _SoulRot and _Agony_DEBUFF and _Corruption_DEBUFF and _UnstableAffliction_DEBUFF and (not tChosen[ids.Aff_Talent.SiphonLife] or (tChosen[ids.Aff_Talent.SiphonLife] and _SiphonLife_DEBUFF)) and ConRO:BurstMode(_SoulRot));
	ConRO:AbilityBurst(_DecimatingBolt, _DecimatingBolt_RDY and currentSpell ~= _DecimatingBolt and _Agony_DEBUFF and _Corruption_DEBUFF and _UnstableAffliction_DEBUFF and (not tChosen[ids.Aff_Talent.SiphonLife] or (tChosen[ids.Aff_Talent.SiphonLife] and _SiphonLife_DEBUFF)) and ConRO:BurstMode(_DecimatingBolt));
	ConRO:AbilityBurst(_ImpendingCatastrophe, _ImpendingCatastrophe_RDY and currentSpell ~= _ImpendingCatastrophe and _Agony_DEBUFF and _Corruption_DEBUFF and _UnstableAffliction_DEBUFF and (not tChosen[ids.Aff_Talent.SiphonLife] or (tChosen[ids.Aff_Talent.SiphonLife] and _SiphonLife_DEBUFF)) and ConRO:BurstMode(_ImpendingCatastrophe));

--Warnings
	ConRO:Warnings("Summon your demon!", not tChosen[ids.Aff_Talent.GrimoireofSacrifice] and not _Pet_summoned);
	ConRO:Warnings("Call your pet to sacrifice!", tChosen[ids.Aff_Talent.GrimoireofSacrifice] and not _GrimoireofSacrifice_BUFF and not _Pet_summoned);

	if _GrimoireofSacrifice_RDY and not _GrimoireofSacrifice_BUFF and not _Void_out then
		return _GrimoireofSacrifice;
	end

--Rotations	
	if _DrainLife_RDY and _InevitableDemise_COUNT == 50 and _InevitableDemise_DUR <= 3 then
		return _DrainLife;
	end
		
	if not _in_combat then		
		if _Haunt_RDY and currentSpell ~= ids.Aff_Talent.Haunt and currentSpell ~= ids.Aff_Ability.ShadowBolt and currentSpell ~= _UnstableAffliction then
			return _Haunt;
		end
		
		if _ShadowBolt_RDY and not tChosen[ids.Aff_Talent.DrainSoul] and currentSpell ~= ids.Aff_Talent.Haunt and currentSpell ~= ids.Aff_Ability.ShadowBolt and currentSpell ~= _UnstableAffliction then
			return _ShadowBolt;
		end
		
		if _UnstableAffliction_RDY and not _UnstableAffliction_DEBUFF and currentSpell ~= ids.Aff_Talent.Haunt and currentSpell ~= ids.Aff_Ability.ShadowBolt and currentSpell ~= _UnstableAffliction then
			return _UnstableAffliction;
		end
		
		if _DarkSoulMisery_RDY and ConRO:FullMode(_DarkSoulMisery) then
			return _DarkSoulMisery;
		end

		if _Corruption_RDY and not (_Corruption_DEBUFF or _SeedofCorruption_DEBUFF) and currentSpell ~= _Corruption then
			return _Corruption;
		end
	else
		if _Agony_RDY and (not _Agony_DEBUFF or _Agony_DUR <= 3) then
			return _Agony;
		elseif _UnstableAffliction_RDY and (not _UnstableAffliction_DEBUFF or _UnstableAffliction_DUR <= 3) and currentSpell ~= _UnstableAffliction then
			return _UnstableAffliction;
		elseif _Corruption_RDY and (not _Corruption_DEBUFF or _Corruption_DUR <= 3) then
			return _Corruption;
		elseif _SiphonLife_RDY and (not _SiphonLife_DEBUFF or _SiphonLife_DUR <= 3) then
			return _SiphonLife;
		end
		
		if _ScouringTithe_RDY and currentSpell ~= _ScouringTithe then
			return _ScouringTithe;
		end
		
		if _Player_Level >= 58 and (_ShadowEmbrace_COUNT <= 0 or _ShadowEmbrace_DUR <= 2) then
			if _DrainSoul_RDY and tChosen[ids.Aff_Talent.DrainSoul] then
				return _DrainSoul;
			elseif _ShadowBolt_RDY and not tChosen[ids.Aff_Talent.DrainSoul] and currentSpell ~= _ShadowBolt then
				return _ShadowBolt;
			end
		end		

		if _Haunt_RDY and currentSpell ~= _Haunt then
			return _Haunt;
		end	

		if _VileTaint_RDY and _SoulShards >= 1 and currentSpell ~= _VileTaint then
			return _VileTaint;
		end	

		if _PhantomSingularity_RDY and ConRO:FullMode(_PhantomSingularity) then
			return _PhantomSingularity;
		end

		if _MaleficRapture_RDY and (_SoulShards == 5 or (_SoulShards >= 1 and ((_SummonDarkglare_CD >= 160 and not tChosen[ids.Aff_Talent.DarkCaller]) or (_SummonDarkglare_CD >= 40 and tChosen[ids.Aff_Talent.DarkCaller])))) then
			return _MaleficRapture;
		end

		if _SoulRot_RDY and currentSpell ~= _SoulRot and ConRO:FullMode(_SoulRot) then
			return _SoulRot;
		end

		if _DecimatingBolt_RDY and currentSpell ~= _DecimatingBolt and ConRO:FullMode(_DecimatingBolt) then
			return _DecimatingBolt;
		end		
	
		if _ImpendingCatastrophe_RDY and currentSpell ~= _ImpendingCatastrophe and ConRO:FullMode(_ImpendingCatastrophe) then
			return _ImpendingCatastrophe;
		end		

		if _DarkSoulMisery_RDY and ConRO:FullMode(_DarkSoulMisery) then
			return _DarkSoulMisery;
		end

		if _SummonDarkglare_RDY and _Agony_DEBUFF and _Corruption_DEBUFF and _UnstableAffliction_DEBUFF and (not tChosen[ids.Aff_Talent.SiphonLife] or (tChosen[ids.Aff_Talent.SiphonLife] and _SiphonLife_DEBUFF)) and (not tChosen[ids.Aff_Talent.PhantomSingularity] or (tChosen[ids.Aff_Talent.PhantomSingularity] and _PhantomSingularity_DEBUFF)) and (not tChosen[ids.Aff_Talent.VileTaint] or (tChosen[ids.Aff_Talent.VileTaint] and _VileTaint_DEBUFF)) and ConRO:FullMode(_SummonDarkglare) then
			return _SummonDarkglare;
		end	

		if _Deathbolt_RDY and currentSpell ~= _Deathbolt and _Agony_DEBUFF and _Corruption_DEBUFF and _UnstableAffliction_DEBUFF and (not tChosen[ids.Aff_Talent.SiphonLife] or (tChosen[ids.Aff_Talent.SiphonLife] and _SiphonLife_DEBUFF)) and (not tChosen[ids.Aff_Talent.PhantomSingularity] or (tChosen[ids.Aff_Talent.PhantomSingularity] and _PhantomSingularity_DEBUFF)) and (not tChosen[ids.Aff_Talent.VileTaint] or (tChosen[ids.Aff_Talent.VileTaint] and _VileTaint_DEBUFF)) then
			return _Deathbolt;
		end	

		if _MaleficRapture_RDY and _SoulShards >= 1 and _SummonDarkglare_CD >= 15 then
			return _MaleficRapture;
		end

		if _DrainLife_RDY and _InevitableDemise_COUNT == 50 then
			return _DrainLife;
		end		

		if _DrainSoul_RDY and tChosen[ids.Aff_Talent.DrainSoul] then
			return _DrainSoul;
		elseif _ShadowBolt_RDY and not tChosen[ids.Aff_Talent.DrainSoul] then
			return _ShadowBolt;
		end
	end
return nil;
end

function ConRO.Warlock.AfflictionDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _SoulShards																					= ConRO:PlayerPower('SoulShards');

--Racials
	local _Cannibalize, _Cannibalize_RDY																= ConRO:AbilityReady(ids.Racial.Cannibalize, timeShift);
	
--Abilities
	local _CreateHealthstone, _CreateHealthstone_RDY													= ConRO:AbilityReady(ids.Aff_Ability.CreateHealthstone, timeShift);
		local _Healthstone, _Healthstone_RDY, _, _, _Healthstone_COUNT										= ConRO:ItemReady(ids.Aff_Ability.Healthstone, timeShift);
	local _DrainLife, _DrainLife_RDY																	= ConRO:AbilityReady(ids.Aff_Ability.DrainLife, timeShift);	
		local _InevitableDemise_BUFF, _InevitableDemise_COUNT, _InevitableDemise_DUR 						= ConRO:Aura(ids.Aff_Buff.InevitableDemise, timeShift);	
	local _HealthFunnel, _HealthFunnel_RDY																= ConRO:AbilityReady(ids.Aff_Ability.HealthFunnel, timeShift);		
	local _UnendingResolve, _UnendingResolve_RDY 														= ConRO:AbilityReady(ids.Aff_Ability.UnendingResolve, timeShift);

	local _DarkPact, _DarkPact_RDY																		= ConRO:AbilityReady(ids.Aff_Talent.DarkPact, timeShift);
	local _MortalCoil, _MortalCoil_RDY																	= ConRO:AbilityReady(ids.Aff_Talent.MortalCoil, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	local _Void_out																						= IsSpellKnown(ids.Aff_PetAbility.ThreateningPresence, true);
	
--Rotations
	if _CreateHealthstone_RDY and not _in_combat and _Healthstone_COUNT <= 0 then
		return _CreateHealthstone;
	end
	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end

	if _DrainLife_RDY and _Player_Percent_Health <= 60 or (_Player_Percent_Health <= 80 and (_InevitableDemise_COUNT >= 50 or _InevitableDemise_DUR <= 3)) then
		return _DrainLife;
	end
	
	if _MortalCoil_RDY and _Player_Percent_Health <= 80 then
		return _MortalCoil;
	end

	if _HealthFunnel_RDY and _Pet_summoned and _Pet_Percent_Health <= 50 then
		return _HealthFunnel;
	end
	
	if _Healthstone_RDY and _Player_Percent_Health <= 50 then
		return _Healthstone;
	end

	if _DarkPact_RDY then
		return _DarkPact;
	end
	
	if _UnendingResolve_RDY then
		return _UnendingResolve;
	end
	
	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Warlock.Demonology(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _SoulShards																					= ConRO:PlayerPower('SoulShards');

--Racials
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local _CallDreadstalkers, _CallDreadstalkers_RDY, _CallDreadstalkers_CD 							= ConRO:AbilityReady(ids.Demo_Ability.CallDreadstalkers, timeShift);
	local _Demonbolt, _Demonbolt_RDY, _, _, _Demonbolt_CastTime											= ConRO:AbilityReady(ids.Demo_Ability.Demonbolt, timeShift);
		local _DemonicCore_BUFF, _DemonicCore_COUNT, _DemonicCore_DUR										= ConRO:Aura(ids.Demo_Buff.DemonicCore, timeShift);
	local _HandofGuldan, _HandofGuldan_RDY 																= ConRO:AbilityReady(ids.Demo_Ability.HandofGuldan, timeShift);
	local _Implosion, _Implosion_RDY																	= ConRO:AbilityReady(ids.Demo_Ability.Implosion, timeShift);
	local _ShadowBolt, _ShadowBolt_RDY					 												= ConRO:AbilityReady(ids.Demo_Ability.ShadowBolt, timeShift);
		local _DemonicCalling_BUFF				 															= ConRO:Aura(ids.Demo_Buff.DemonicCalling, timeShift);
	local _SummonDemonicTyrant, _SummonDemonicTyrant_RDY, _SummonDemonicTyrant_CD						= ConRO:AbilityReady(ids.Demo_Ability.SummonDemonicTyrant, timeShift);
	local _SummonFelguard, _SummonFelguard_RDY															= ConRO:AbilityReady(ids.Demo_Ability.SummonFelguard, timeShift);

	local _AxeToss, _AxeToss_RDY																		= ConRO:AbilityReady(ids.Demo_PetAbility.AxeToss, timeShift, 'pet');
	local _DevourMagic, _DevourMagic_RDY																= ConRO:AbilityReady(ids.Demo_PetAbility.DevourMagic, timeShift, 'pet');
	local _Felstorm, _Felstorm_RDY, _Felstorm_CD														= ConRO:AbilityReady(ids.Demo_PetAbility.Felstorm, timeShift, 'pet');
	local _SpellLock, _SpellLock_RDY					 												= ConRO:AbilityReady(ids.Demo_PetAbility.SpellLock, timeShift, 'pet');

	local _BilescourgeBombers, _BilescourgeBombers_RDY													= ConRO:AbilityReady(ids.Demo_Talent.BilescourgeBombers, timeShift);	
	local _DemonicStrength, _DemonicStrength_RDY														= ConRO:AbilityReady(ids.Demo_Talent.DemonicStrength, timeShift);
	local _Doom, _Doom_RDY 																				= ConRO:AbilityReady(ids.Demo_Talent.Doom, timeShift);
		local _Doom_DEBUFF																					= ConRO:TargetAura(ids.Demo_Debuff.Doom, timeShift + 4);
	local _GrimoireFelguard, _GrimoireFelguard_RDY				 										= ConRO:AbilityReady(ids.Demo_Talent.GrimoireFelguard, timeShift);
	local _NetherPortal, _NetherPortal_RDY, _NetherPortal_CD											= ConRO:AbilityReady(ids.Demo_Talent.NetherPortal, timeShift);
		local _NetherPortal_BUFF 																			= ConRO:Aura(ids.Demo_Buff.NetherPortal, timeShift);
	local _PowerSiphon, _PowerSiphon_RDY																= ConRO:AbilityReady(ids.Demo_Talent.PowerSiphon, timeShift);
	local _SoulStrike, _SoulStrike_RDY																	= ConRO:AbilityReady(ids.Demo_Talent.SoulStrike, timeShift);
	local _SummonVilefiend, _SummonVilefiend_RDY, _SummonVilefiend_CD									= ConRO:AbilityReady(ids.Demo_Talent.SummonVilefiend, timeShift);

	local _CallFelhunter, _CallFelhunter_RDY															= ConRO:AbilityReady(ids.Demo_PvPTalent.CallFelhunter, timeShift);

	local _DecimatingBolt, _DecimatingBolt_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.DecimatingBolt, timeShift);
	local _ImpendingCatastrophe, _ImpendingCatastrophe_RDY												= ConRO:AbilityReady(ids.Covenant_Ability.ImpendingCatastrophe, timeShift);
	local _ScouringTithe, _ScouringTithe_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.ScouringTithe, timeShift);
	local _SoulRot, _SoulRot_RDY																		= ConRO:AbilityReady(ids.Covenant_Ability.SoulRot, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	local _Void_out																						= IsSpellKnown(ids.Demo_PetAbility.ThreateningPresence, true);
	local _Felhunter_out																				= IsSpellKnown(ids.Demo_PetAbility.ShadowBite, true);

	
	if currentSpell == _HandofGuldan then
		_SoulShards = _SoulShards - 3;
	elseif currentSpell == _NetherPortal then
		_SoulShards = _SoulShards - 1;
	elseif currentSpell == _CallDreadstalkers then
		_SoulShards = _SoulShards - 2;
	elseif currentSpell == _SummonVilefiend then
		_SoulShards = _SoulShards - 1;
	elseif currentSpell == _Demonbolt then
		_SoulShards = _SoulShards + 2;		
	elseif currentSpell == _ShadowBolt then
		_SoulShards = _SoulShards + 1;
	end
	
--Indicators
	ConRO:AbilityInterrupt(_CallFelhunter, _CallFelhunter_RDY and _is_PvP and pvpChosen[ids.Demo_PvPTalent.CallFelhunter] and not _Felhunter_out and ConRO:Interrupt());
	ConRO:AbilityInterrupt(ids.Demo_Ability.SpellLock, _SpellLock_RDY and ConRO:Interrupt());	
	ConRO:AbilityInterrupt(_SpellLock, _SpellLock_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_DevourMagic, _DevourMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);

	ConRO:AbilityBurst(_DemonicStrength, _DemonicStrength_RDY and _Felstorm_CD <= 25 and ConRO:BurstMode(_DemonicStrength));
	ConRO:AbilityBurst(_GrimoireFelguard, _GrimoireFelguard_RDY and _SoulShards >= 1 and ConRO:BurstMode(_GrimoireFelguard));
	ConRO:AbilityBurst(_NetherPortal, _NetherPortal_RDY and _SummonDemonicTyrant_RDY and _CallDreadstalkers_RDY and (svilefiend or not tChosen[ids.Demo_Talent.SummonVilefiend]) and _SoulShards >= 1 and currentSpell ~= ids.Demo_Talent.NetherPortal and ConRO:BurstMode(_NetherPortal));
	ConRO:AbilityBurst(_SummonDemonicTyrant, _SummonDemonicTyrant_RDY and currentSpell ~= _SummonDemonicTyrant and _CallDreadstalkers_CD >= 10 and ConRO:ImpsOut() >= 6 and ConRO:BurstMode(_SummonDemonicTyrant));
	ConRO:AbilityBurst(_SummonVilefiend, _SummonVilefiend_RDY and _SoulShards >= 1 and ((_SummonDemonicTyrant_RDY and (_CallDreadstalkers_RDY or _CallDreadstalkers_CD >= 16)) or _SummonDemonicTyrant_CD >= 40) and currentSpell ~= _SummonVilefiend and (not tChosen[ids.Demo_Talent.NetherPortal] or (tChosen[ids.Demo_Talent.NetherPortal] and _NetherPortal_CD > 40)) and ConRO:BurstMode(_SummonVilefiend));
		
	ConRO:AbilityBurst(_SoulRot, _SoulRot_RDY and currentSpell ~= _SoulRot and ConRO:BurstMode(_SoulRot));
	ConRO:AbilityBurst(_DecimatingBolt, _DecimatingBolt_RDY and currentSpell ~= _DecimatingBolt and ConRO:BurstMode(_DecimatingBolt));
	ConRO:AbilityBurst(_ImpendingCatastrophe, _ImpendingCatastrophe_RDY and currentSpell ~= _ImpendingCatastrophe and ConRO:BurstMode(_ImpendingCatastrophe));

--Warnings
	ConRO:Warnings("Summon your Felguard!", not _Pet_summoned);

--Rotations
	if not _in_combat then
		if _Demonbolt_RDY and currentSpell ~= _Demonbolt then
			return _Demonbolt;
		end

		if _Doom_RDY and not _Doom_DEBUFF then
			return _Doom;
		end

		if _HandofGuldan_RDY and _SoulShards >= 1 and currentSpell ~= _HandofGuldan then
			return _HandofGuldan;
		end
	end

	if _is_moving then
		if _Demonbolt_RDY and _DemonicCore_COUNT >= 1 then
			return _Demonbolt;
		end
		
		if _Doom_RDY and not _Doom_DEBUFF then
			return _Doom;
		end
		
		if _DemonicStrength_RDY and _Felstorm_CD <= 25 and ConRO:FullMode(_DemonicStrength) then
			return _DemonicStrength;
		end

		if _SoulStrike_RDY and _SoulShards <= 4 then
			return _SoulStrike;
		end

		if _PowerSiphon_RDY and _DemonicCore_COUNT <= 1 and ConRO:ImpsOut() >= 2 then
			return _PowerSiphon;
		end		
	end
	
	if _Demonbolt_RDY and _DemonicCore_DUR <= 2 and _DemonicCore_COUNT >= 1 then
		return _Demonbolt;
	end

		
	if _ScouringTithe_RDY and currentSpell ~= _ScouringTithe then
		return _ScouringTithe;
	end
	
	if _ImpendingCatastrophe_RDY and currentSpell ~= _ImpendingCatastrophe and ConRO:FullMode(_ImpendingCatastrophe) then
		return _ImpendingCatastrophe;
	end

	if _DecimatingBolt_RDY and currentSpell ~= _DecimatingBolt and ConRO:FullMode(_DecimatingBolt) then
		return _DecimatingBolt;
	end
	
	if _SoulRot_RDY and currentSpell ~= _SoulRot and ConRO:FullMode(_SoulRot) then
		return _SoulRot;
	end
	
	if _Doom_RDY and not _Doom_DEBUFF then
		return _Doom;
	end
		
	if _NetherPortal_RDY and (_SummonDemonicTyrant_RDY or _SummonDemonicTyrant_CD <= 9) and currentSpell ~= _NetherPortal and ConRO:FullMode(_NetherPortal) then	
		if _NetherPortal_RDY and (_SummonDemonicTyrant_RDY or _SummonDemonicTyrant_CD <= 9) and _CallDreadstalkers_RDY and (not tChosen[ids.Demo_Talent.SummonVilefiend] or _SummonVilefiend_RDY) and _SoulShards >= 5 and currentSpell ~= _NetherPortal then
			return _NetherPortal;
		end
		
		if _Demonbolt_RDY and _DemonicCore_COUNT >= 2 and _SoulShards <= 3 then
			return _Demonbolt;
		end

		if _DemonicStrength_RDY and _Felstorm_CD <= 25 and ConRO:FullMode(_DemonicStrength) then
			return _DemonicStrength;
		end

		if _SoulStrike_RDY and _SoulShards <= 4 then
			return _SoulStrike;
		end
		
		if _ShadowBolt_RDY then
			return _ShadowBolt;
		end
	elseif _NetherPortal_BUFF or currentSpell == _NetherPortal then
		if _SummonDemonicTyrant_RDY and (ConRO.lastSpellId == _HandofGuldan or currentSpell == _HandofGuldan) then
			return _SummonDemonicTyrant;
		end
		
		if _BilescourgeBombers_RDY and _SoulShards >= 2 then
			return _BilescourgeBombers;
		end

		if _GrimoireFelguard_RDY and _SoulShards >= 1 then
			return _GrimoireFelguard;
		end

		if _SummonVilefiend_RDY and _SoulShards >= 1 and (_SummonDemonicTyrant_RDY or _SummonDemonicTyrant_CD >= 40) and currentSpell ~= _SummonVilefiend and ConRO:FullMode(_SummonVilefiend) then
			return _SummonVilefiend;
		end
		
		if _CallDreadstalkers_RDY and (_SoulShards >= 2 or (_SoulShards >= 1 and _DemonicCalling_BUFF)) and currentSpell ~= _CallDreadstalkers then
			return _CallDreadstalkers;
		end
		
		if _HandofGuldan_RDY and _SoulShards >= 1 and currentSpell ~= _HandofGuldan then
			return _HandofGuldan;
		end
		
		if _Demonbolt_RDY and _DemonicCore_COUNT >= 1 then
			return _Demonbolt;
		end
	
		if _ShadowBolt_RDY and _SoulShards <= 4 and currentSpell ~= _ShadowBolt then
			return _ShadowBolt;
		end
	else
		if _SummonDemonicTyrant_RDY and currentSpell ~= _SummonDemonicTyrant and _CallDreadstalkers_CD >= 8 and ConRO:ImpsOut() >= 3 and (ConRO.lastSpellId == _HandofGuldan or currentSpell == _HandofGuldan) and ConRO:FullMode(_SummonDemonicTyrant) then
			return _SummonDemonicTyrant;
		end

		if _GrimoireFelguard_RDY and _SoulShards >= 1 and ConRO:FullMode(_GrimoireFelguard) then
			return _GrimoireFelguard;
		end

		if _DemonicStrength_RDY and _Felstorm_CD <= 25 and ConRO:FullMode(_DemonicStrength) then
			return _DemonicStrength;
		end

		if _BilescourgeBombers_RDY and _SoulShards >= 2 then
			return _BilescourgeBombers;
		end

		if _SoulStrike_RDY and _SoulShards <= 4 then
			return _SoulStrike;
		end
		
		if _Implosion_RDY and ConRO:ImpsOut() >= 6 and ConRO_AoEButton:IsVisible() then
			return _Implosion;
		end		
		
		if _SummonVilefiend_RDY and _SoulShards >= 1 and ((_SummonDemonicTyrant_RDY and (_CallDreadstalkers_RDY or _CallDreadstalkers_CD >= 16)) or _SummonDemonicTyrant_CD >= 40) and currentSpell ~= _SummonVilefiend and (not tChosen[ids.Demo_Talent.NetherPortal] or (tChosen[ids.Demo_Talent.NetherPortal] and (_NetherPortal_CD > 40 or ConRO:BurstMode(_NetherPortal)))) and ConRO:FullMode(_SummonVilefiend) then
			return _SummonVilefiend;
		end
		
		if _CallDreadstalkers_RDY and (_SoulShards >= 2 or _DemonicCalling_BUFF) and (_SummonDemonicTyrant_RDY or _SummonDemonicTyrant_CD >= 10) and currentSpell ~= ids.Demo_Ability.CallDreadstalkers and (not tChosen[ids.Demo_Talent.NetherPortal] or (tChosen[ids.Demo_Talent.NetherPortal] and (_NetherPortal_CD > 15 or ConRO:BurstMode(_NetherPortal)))) then
			return _CallDreadstalkers;
		end		
		
		if _HandofGuldan_RDY and _SoulShards >= 3 and currentSpell ~= ids.Demo_Ability.HandofGuldan then
			return _HandofGuldan;
		end		

		if _Demonbolt_RDY and (_DemonicCore_COUNT >= 2 or (_DemonicCore_COUNT >= 1 and _SummonDemonicTyrant_RDY and ConRO:FullMode(_SummonDemonicTyrant))) and _SoulShards <= 3 then
			return _Demonbolt;
		end
		
		if _PowerSiphon_RDY and _DemonicCore_COUNT <= 1 and ConRO:ImpsOut() >= 2 then
			return _PowerSiphon;
		end
			
		if _ShadowBolt_RDY and _SoulShards <= 4 then
			return _ShadowBolt;
		end
	end
return nil;
end

function ConRO.Warlock.DemonologyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _SoulShards																					= ConRO:PlayerPower('SoulShards');

--Racials
	local _Cannibalize, _Cannibalize_RDY																= ConRO:AbilityReady(ids.Racial.Cannibalize, timeShift);
	
--Abilities
	local _CreateHealthstone, _CreateHealthstone_RDY													= ConRO:AbilityReady(ids.Demo_Ability.CreateHealthstone, timeShift);
		local _Healthstone, _Healthstone_RDY, _, _, _Healthstone_COUNT										= ConRO:ItemReady(ids.Demo_Ability.Healthstone, timeShift);
	local _DrainLife, _DrainLife_RDY																	= ConRO:AbilityReady(ids.Demo_Ability.DrainLife, timeShift);	
	local _HealthFunnel, _HealthFunnel_RDY																= ConRO:AbilityReady(ids.Demo_Ability.HealthFunnel, timeShift);
	local _UnendingResolve, _UnendingResolve_RDY 														= ConRO:AbilityReady(ids.Demo_Ability.UnendingResolve, timeShift);

	local _DarkPact, _DarkPact_RDY																		= ConRO:AbilityReady(ids.Demo_Talent.DarkPact, timeShift);
	local _MortalCoil, _MortalCoil_RDY																	= ConRO:AbilityReady(ids.Demo_Talent.MortalCoil, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);

	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	local _Void_out																						= IsSpellKnown(ids.Demo_PetAbility.ThreateningPresence, true);
	
--Rotations	
	if _CreateHealthstone_RDY and not _in_combat and _Healthstone_COUNT <= 0 then
		return _CreateHealthstone;
	end
	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end

	if _DrainLife_RDY and _Player_Percent_Health <= 60 then
		return _DrainLife;
	end
	
	if _MortalCoil_RDY and _Player_Percent_Health <= 80 then
		return _MortalCoil;
	end

	if _HealthFunnel_RDY and _Pet_summoned and _Pet_Percent_Health <= 50 then
		return _HealthFunnel;
	end
	
	if _Healthstone_RDY and _Player_Percent_Health <= 50 then
		return _Healthstone;
	end

	if _DarkPact_RDY then
		return _DarkPact;
	end
	
	if _UnendingResolve_RDY then
		return _UnendingResolve;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Warlock.Destruction(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _SoulShards																					= ConRO:PlayerPower('SoulShards');

--Racials
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _ChaosBolt, _ChaosBolt_RDY					 												= ConRO:AbilityReady(ids.Dest_Ability.ChaosBolt, timeShift);
		local _Eradication_DEBUFF																			=ConRO:TargetAura(ids.Dest_Debuff.Eradication, timeShift);
	local _Conflagrate, _Conflagrate_RDY								 								= ConRO:AbilityReady(ids.Dest_Ability.Conflagrate, timeShift);
		local _Conflagrate_CHARGES																			= ConRO:SpellCharges(ids.Dest_Ability.Conflagrate);
		local _Conflagrate_BUFF																				= ConRO:Aura(ids.Dest_Buff.Conflagrate, timeShift);
		local _BackDraft_BUFF, _BackDraft_COUNT																= ConRO:Aura(ids.Dest_Buff.BackDraft, timeShift);
	local _Havoc, _Havoc_RDY, _Havoc_CD																	= ConRO:AbilityReady(ids.Dest_Ability.Havoc, timeShift);
		local _Havoc_DEBUFF																					=ConRO:TargetAura(ids.Dest_Debuff.Havoc, timeShift);
	local _Immolate, _Immolate_RDY						 												= ConRO:AbilityReady(ids.Dest_Ability.Immolate, timeShift);
		local _Immolate_DEBUFF				 																= ConRO:TargetAura(ids.Dest_Debuff.Immolate, timeShift + 3);
	local _Incinerate, _Incinerate_RDY				 													= ConRO:AbilityReady(ids.Dest_Ability.Incinerate, timeShift);
	local _RainofFire, _RainofFire_RDY																	= ConRO:AbilityReady(ids.Dest_Ability.RainofFire, timeShift);	
	local _SummonInfernal, _SummonInfernal_RDY, _SummonInfernal_CD										= ConRO:AbilityReady(ids.Dest_Ability.SummonInfernal, timeShift);	
	local _SummonImp, _SummonImp_RDY				 													= ConRO:AbilityReady(ids.Dest_Ability.SummonImp, timeShift);
	
	local _SpellLock, _SpellLock_RDY 																	= ConRO:AbilityReady(ids.Dest_PetAbility.SpellLock, timeShift, 'pet');
	local _DevourMagic, _DevourMagic_RDY																= ConRO:AbilityReady(ids.Dest_PetAbility.DevourMagic, timeShift, 'pet');
	
	local _Cataclysm, _Cataclysm_RDY																	= ConRO:AbilityReady(ids.Dest_Talent.Cataclysm, timeShift);
	local _ChannelDemonfire, _ChannelDemonfire_RDY									 					= ConRO:AbilityReady(ids.Dest_Talent.ChannelDemonfire, timeShift);
	local _DarkSoulInstability, _DarkSoulInstability_RDY, _DarkSoulInstability_CD						= ConRO:AbilityReady(ids.Dest_Talent.DarkSoulInstability, timeShift);
		local _DarkSoulInstability_BUFF																		= ConRO:Aura(ids.Dest_Buff.DarkSoulInstability, timeShift);
	local _GrimoireofSacrifice, _GrimoireofSacrifice_RDY 												= ConRO:AbilityReady(ids.Dest_Talent.GrimoireofSacrifice, timeShift);
		local _GrimoireofSacrifice_BUFF 																	= ConRO:Aura(ids.Dest_Buff.GrimoireofSacrifice, timeShift);
	local _Shadowburn, _Shadowburn_RDY						 											= ConRO:AbilityReady(ids.Dest_Talent.Shadowburn, timeShift);
	local _SoulFire, _SoulFire_RDY							 											= ConRO:AbilityReady(ids.Dest_Talent.SoulFire, timeShift);

	local _DecimatingBolt, _DecimatingBolt_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.DecimatingBolt, timeShift);
	local _ImpendingCatastrophe, _ImpendingCatastrophe_RDY												= ConRO:AbilityReady(ids.Covenant_Ability.ImpendingCatastrophe, timeShift);
	local _ScouringTithe, _ScouringTithe_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.ScouringTithe, timeShift);
	local _SoulRot, _SoulRot_RDY																		= ConRO:AbilityReady(ids.Covenant_Ability.SoulRot, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _enemies_in_range, _target_in_range															= ConRO:Targets(ids.Dest_Ability.Immolate);
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	local _Void_out																						= IsSpellKnown(ids.Demo_PetAbility.ThreateningPresence, true);
		
	if currentSpell == _ChaosBolt then
		_SoulShards = _SoulShards - 2;
	elseif currentSpell == _Incinerate then
		if ConRO:ItemEquipped(ids.Legendary.EmbersoftheDiabolicRaiment_Back) or ConRO:ItemEquipped(ids.Legendary.EmbersoftheDiabolicRaiment_Chest) then
			_SoulShards = _SoulShards + 0.4;
		else
			_SoulShards = _SoulShards + 0.2;
		end
	elseif currentSpell == _SoulFire then
		_SoulShards = _SoulShards + 1;
	end
	
--Indicators
	ConRO:AbilityInterrupt(ids.Dest_Ability.SpellLock, _SpellLock_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_SpellLock, _SpellLock_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_DevourMagic, _DevourMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);

	ConRO:AbilityBurst(_RainofFire, _RainofFire_RDY and _SoulShards >= 3 and _enemies_in_range >= 3);	
	ConRO:AbilityBurst(_Havoc, _Havoc_RDY and not _Havoc_DEBUFF and _SoulShards >= 2 and _enemies_in_range >= 2);
	ConRO:AbilityBurst(_SoulFire, _SoulFire_RDY and _SoulShards <= 4 and currentSpell ~= _SoulFire and ConRO:FullMode(_SoulFire));

	ConRO:AbilityBurst(_SummonInfernal, _SummonInfernal_RDY and ConRO:BurstMode(_SummonInfernal));
	ConRO:AbilityBurst(_DarkSoulInstability, _DarkSoulInstability_RDY and _Immolate_DEBUFF and _SoulShards >= 4 and ConRO:BurstMode(_DarkSoulInstability));

	ConRO:AbilityBurst(_SoulRot, _SoulRot_RDY and currentSpell ~= _SoulRot and ConRO:BurstMode(_SoulRot));
	ConRO:AbilityBurst(_DecimatingBolt, _DecimatingBolt_RDY and currentSpell ~= _DecimatingBolt and ConRO:BurstMode(_DecimatingBolt));
	ConRO:AbilityBurst(_ImpendingCatastrophe, _ImpendingCatastrophe_RDY and currentSpell ~= _ImpendingCatastrophe and ConRO:BurstMode(_ImpendingCatastrophe));
	
--Warnings
	ConRO:Warnings("Attack Non-Havoced target!", _Havoc_DEBUFF);
	ConRO:Warnings("Summon your demon!", not tChosen[ids.Dest_Talent.GrimoireofSacrifice] and not _Pet_summoned);
	ConRO:Warnings("Call your pet to sacrifice!", tChosen[ids.Dest_Talent.GrimoireofSacrifice] and not _GrimoireofSacrifice_BUFF and not _Pet_summoned);

	if _GrimoireofSacrifice_RDY and not _GrimoireofSacrifice_BUFF and not _Void_out then
		return _GrimoireofSacrifice;
	end

--Rotations
	if not _in_combat then
		if _SoulFire_RDY and currentSpell ~= _SoulFire and ConRO:FullMode(_SoulFire) then
			return _SoulFire;
		end
		
		if _Incinerate_RDY and currentSpell ~= _Incinerate and currentSpell ~= _SoulFire then
			return _Incinerate;
		end

		if _Conflagrate_RDY and tChosen[ids.Dest_Talent.RoaringBlaze] and not _Conflagrate_BUFF then
			return _Conflagrate;
		end
		
		if _Cataclysm_RDY and not _Immolate_DEBUFF and currentSpell ~= _Cataclysm and currentSpell ~= _Immolate and currentSpell ~= _SoulFire then
			return _Cataclysm;
		end

		if _Immolate_RDY and not _Immolate_DEBUFF and currentSpell ~= _Cataclysm and currentSpell ~= _Immolate and currentSpell ~= _SoulFire then
			return _Immolate;
		end

		if _Conflagrate_RDY and _SoulShards <= 4 then
			return _Conflagrate;
		end
	else
		if _Cataclysm_RDY and not _Immolate_DEBUFF and currentSpell ~= _Cataclysm and currentSpell ~= _Immolate then
			return _Cataclysm;
		end

		if _Immolate_RDY and not _Immolate_DEBUFF and currentSpell ~= _Cataclysm and currentSpell ~= _Immolate then
			return _Immolate;
		end

		if _SummonInfernal_RDY and ConRO:FullMode(_SummonInfernal) then
			return _SummonInfernal;
		end

		if _DarkSoulInstability_RDY and (_SoulShards >= 4 or _SummonInfernal_CD <= 170) and ConRO:FullMode(_DarkSoulInstability) then
			return _DarkSoulInstability;
		end
		
		if _Berserking_RDY and _SummonInfernal_CD <= 170 then
			return _Berserking;
		end
		
		if _ChaosBolt_RDY and (_SoulShards == 5 or (_SoulShards >= 2 and (_DarkSoulInstability_BUFF or _SummonInfernal_CD >= 150 or _Havoc_CD > 20))) then
			return _ChaosBolt;
		end

		if _Cataclysm_RDY and currentSpell ~= _Cataclysm then
			return _Cataclysm;
		end
		
		if _SoulFire_RDY and currentSpell ~= _SoulFire and ConRO:FullMode(_SoulFire) then
			return _SoulFire;
		end
		
		if _ChannelDemonfire_RDY then
			return _ChannelDemonfire;
		end
		
		if _Conflagrate_RDY and _Conflagrate_CHARGES == 2 or (_Conflagrate_CHARGES >= 1 and ((_SoulShards <= 4 or _BackDraft_COUNT <= 2) or (tChosen[ids.Dest_Talent.RoaringBlaze] and not _Conflagrate_BUFF))) then
			return _Conflagrate;
		end
		
		if _ScouringTithe_RDY then
			return _ScouringTithe;
		end

		if _ImpendingCatastrophe_RDY and currentSpell ~= _ImpendingCatastrophe and ConRO:FullMode(_ImpendingCatastrophe) then
			return _ImpendingCatastrophe;
		end
		
		if _DecimatingBolt_RDY and currentSpell ~= _DecimatingBolt and ConRO:FullMode(_DecimatingBolt) then
			return _DecimatingBolt;
		end
		
		if _SoulRot_RDY and currentSpell ~= _SoulRot and ConRO:FullMode(_SoulRot)  then
			return _SoulRot;
		end
		
		if _ChaosBolt_RDY and _SoulShards >= 2 and (_BackDraft_BUFF or (tChosen[ids.Dest_Talent.Eradication] and not _Eradication_DEBUFF)) then
			return _ChaosBolt;
		end

		if _Shadowburn_RDY then
			return _Shadowburn;
		end
		
		if _Incinerate_RDY then
			return _Incinerate;
		end
	end
return nil;
end

function ConRO.Warlock.DestructionDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _SoulShards																					= ConRO:PlayerPower('SoulShards');

--Racials
	local _Cannibalize, _Cannibalize_RDY																= ConRO:AbilityReady(ids.Racial.Cannibalize, timeShift);
	
--Abilities
	local _CreateHealthstone, _CreateHealthstone_RDY													= ConRO:AbilityReady(ids.Dest_Ability.CreateHealthstone, timeShift);
		local _Healthstone, _Healthstone_RDY, _, _, _Healthstone_COUNT										= ConRO:ItemReady(ids.Dest_Ability.Healthstone, timeShift);
	local _DrainLife, _DrainLife_RDY																	= ConRO:AbilityReady(ids.Dest_Ability.DrainLife, timeShift);
	local _HealthFunnel, _HealthFunnel_RDY					 											= ConRO:AbilityReady(ids.Dest_Ability.HealthFunnel, timeShift);		
	local _UnendingResolve, _UnendingResolve_RDY 														= ConRO:AbilityReady(ids.Dest_Ability.UnendingResolve, timeShift);

	local _DarkPact, _DarkPact_RDY																		= ConRO:AbilityReady(ids.Dest_Talent.DarkPact, timeShift);
	local _MortalCoil, _MortalCoil_RDY																	= ConRO:AbilityReady(ids.Dest_Talent.MortalCoil, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);

	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	local _Void_out																						= IsSpellKnown(ids.Demo_PetAbility.ThreateningPresence, true);
	
--Rotations	
	if _CreateHealthstone_RDY and not _in_combat and _Healthstone_COUNT <= 0 then
		return _CreateHealthstone;
	end
	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end

	if _DrainLife_RDY and _Player_Percent_Health <= 60 then
		return _DrainLife;
	end
	
	if _MortalCoil_RDY and _Player_Percent_Health <= 80 then
		return _MortalCoil;
	end

	if _HealthFunnel_RDY and _Pet_summoned and _Pet_Percent_Health <= 50 then
		return _HealthFunnel;
	end
	
	if _Healthstone_RDY and _Player_Percent_Health <= 50 then
		return _Healthstone;
	end

	if _DarkPact_RDY then
		return _DarkPact;
	end
	
	if _UnendingResolve_RDY then
		return _UnendingResolve;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

ConRO.DemonCount = {};
ConRO.ImpCount = {};
ConRO.BasicDemons = { --[demon] = duration (0 to blacklist)
							[688] = 0,     --Imp
							[697] = 0,     --Voidwalker
							[691] = 0,     --Felhunter
							[712] = 0,     --Succubus
							[30146] = 0,   --Felguard
							[112866] = 0,  --Fel Imp
							[112867] = 0,  --Voidlord
							[112869] = 0,  --Observer
							[112868] = 0,  --Shivarra
							[112870] = 0,  --Wrathguard
							[240263] = 0,  --Fel Succubus
							[240266] = 0,  --Shadow Succubus
							[104317] = 0,  --Wild Imps, counted by other means
							[111898] = 15, --Grimoire: Felguard
							[193331] = 12, --Dreadstalker 1
							[193332] = 12, --Dreadstalker 2
							[265187] = 15, --Demonic Tyrant
							[264119] = 15  --Vilefiend
						};
						
function ConRO:COMBAT_LOG_EVENT_UNFILTERED()
	local _, subevent, _, sourceGUID, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo();
	local myGUID = UnitGUID("player");

	local ImpMaxCasts = 5;
	local ImpMaxTime = 20; --seconds
	local randomDemonsDuration = 15; --seconds
	local TyrantDuration = 15; --seconds
	local TyrantStart = 0;
	local TyrantActive = false;

		
		--Imps are summoned
		if subevent == "SPELL_SUMMON" and sourceGUID == myGUID and (spellID == 104317 or spellID == 279910) then 

			local tyrantExtra = TyrantActive and TyrantDuration - (GetTime() - TyrantStart) or 0
			
			ConRO.ImpCount[destGUID] = {ImpMaxCasts, GetTime() + ImpMaxTime + tyrantExtra - 0.1}
			C_Timer.After(ImpMaxTime + tyrantExtra, function()
					
					for k in pairs(ConRO.ImpCount) do
						if GetTime() > ConRO.ImpCount[k][2] then
							ConRO.ImpCount[k] = nil
						end
					end
			end)
			
			--Other demons are summoned
		elseif subevent == "SPELL_SUMMON" and sourceGUID == myGUID and not (spellID == 104317 or spellID == 279910) then
			
			if ConRO.BasicDemons[spellID] and ConRO.BasicDemons[spellID] > 0 then
				ConRO.DemonCount[destGUID] = GetTime() + ConRO.BasicDemons[spellID] - 0.1
				
				C_Timer.After(ConRO.BasicDemons[spellID], function()
						for k, v in pairs(ConRO.DemonCount) do
							if GetTime() > v then
								ConRO.DemonCount[k] = nil
							end
						end
				end)
				
			elseif not ConRO.BasicDemons[spellID] then
				ConRO.DemonCount[destGUID] = GetTime() + randomDemonsDuration - 0.1
				
				C_Timer.After(randomDemonsDuration, function()
						for k, v in pairs(ConRO.DemonCount) do
							if GetTime() > v then
								ConRO.DemonCount[k] = nil
							end
						end
				end)
			end
		end
		
		--Imps succesfully consume energy
		if subevent == "SPELL_CAST_SUCCESS" and ConRO.ImpCount[sourceGUID] and not TyrantActive then
			if ConRO.ImpCount[sourceGUID][1] == 1 then
				ConRO.ImpCount[sourceGUID] = nil
			else
				ConRO.ImpCount[sourceGUID][1] = ConRO.ImpCount[sourceGUID][1] - 1
			end
		end
		
		--Summon Demonic Tyrant
		if subevent == "SPELL_CAST_SUCCESS" and sourceGUID == myGUID and spellID == 265187 then
			local remains
			
			TyrantActive = true
			TyrantStart = GetTime()
			
			if IsPlayerSpell(267215) then
				table.wipe(ConRO.ImpCount)
			end
			
			C_Timer.After(TyrantDuration, function()
					TyrantActive = false
					
					for k in pairs(ConRO.ImpCount) do
						if GetTime() > ConRO.ImpCount[k][2] then
							ConRO.ImpCount[k] = nil
						end
					end 
					
					for k, v in pairs(ConRO.DemonCount) do
						if GetTime() > v then
							ConRO.DemonCount[k] = nil
						end
					end
			end)
			
			for k in pairs(ConRO.ImpCount) do
				remains = ConRO.ImpCount[k][2] - GetTime()
				ConRO.ImpCount[k][2] = ConRO.ImpCount[k][2] + TyrantDuration - 0.1
				
				C_Timer.After(TyrantDuration + remains, function()
						for k in pairs(ConRO.ImpCount) do
							if GetTime() > ConRO.ImpCount[k][2] then
								ConRO.ImpCount[k] = nil
							end
						end      
				end)
			end
			
			for k in pairs(ConRO.DemonCount) do
				remains = ConRO.DemonCount[k] - GetTime()
				ConRO.DemonCount[k] = ConRO.DemonCount[k] + TyrantDuration - 0.1
				
				C_Timer.After(TyrantDuration + remains, function()
						for k, v in pairs(ConRO.DemonCount) do
							if GetTime() > v then
								ConRO.DemonCount[k] = nil
							end
						end
				end)
			end
		end
		
		--Implosion
		if subevent == "SPELL_CAST_SUCCESS" and sourceGUID == myGUID and spellID == 196277 then
			table.wipe(ConRO.ImpCount)
		end
		
		--Power Siphon
		if subevent == "SPELL_CAST_SUCCESS" and sourceGUID == myGUID and spellID == 264130 then
			local oldest, oldestTime = "", 2*GetTime()
			
			for i = 1, 2 do
				for name, imp in pairs(ConRO.ImpCount) do
					oldestTime = math.min(imp[2], oldestTime)
					
					if imp[2] == oldestTime then
						oldest = name
					end
				end
				
				oldestTime = oldestTime*2
				
				ConRO.ImpCount[oldest] = nil
			end
		end
		
		--Death
		if subevent == "UNIT_DIED" or subevent == "SPELL_INSTAKILL" or subevent == "UNIT_DESTROYED" then
			if ConRO.ImpCount[destGUID] then
				ConRO.ImpCount[destGUID] = nil
				
			elseif ConRO.DemonCount[destGUID] then      
				ConRO.DemonCount[destGUID] = nil
				
			elseif destGUID == myGUID then
				table.wipe(ConRO.ImpCount)
				table.wipe(ConRO.DemonCount)
			end
		end		
	return true;
end

function ConRO:ImpsOut()
  local count = 0
	for k in pairs(ConRO.ImpCount) do 
		if k then
			count = count + 1;
		end
	end
--	print("Imp Count: " .. count);
	return count;
end

function ConRO:DemonsOut()
  local count = ConRO:ImpsOut();
	if IsPetActive() then
		count = count + 1;
	end
	for k in pairs(ConRO.DemonCount) do 
		if k then
			count = count + 1;
		end
	end
--	print("Demon Count: " .. count);
	return count;
end