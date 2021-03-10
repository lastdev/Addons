ConRO.Hunter = {};
ConRO.Hunter.CheckTalents = function()
end
ConRO.Hunter.CheckPvPTalents = function()
end
local ConRO_Hunter, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Hunter.CheckTalents;
	self.ModuleOnEnable = ConRO.Hunter.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Hunter [No Specialization Under 10]";
		self.NextSpell = ConRO.Hunter.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = 'Hunter [Beast Mastery - Ranged]';
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Hunter.BeastMastery;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Hunter.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);	
		end
	end;
	if mode == 2 then
		self.Description = 'Hunter [Marksmanship - Ranged]';
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Hunter.Marksmanship;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Hunter.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 3 then
		self.Description = 'Hunter [Survival - Melee]';
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.Hunter.Survival;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Hunter.Disabled;
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
		self.NextDef = ConRO.Hunter.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Hunter.BeastMasteryDef;
		else
			self.NextDef = ConRO.Hunter.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then	
			self.NextDef = ConRO.Hunter.MarksmanshipDef;
		else
			self.NextDef = ConRO.Hunter.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then			
			self.NextDef = ConRO.Hunter.SurvivalDef;
		else
			self.NextDef = ConRO.Hunter.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' and spellID ~= 75 then
		self.lastSpellId = spellID;
	end
end

function ConRO.Hunter.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Hunter.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Hunter.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Hunter.BeastMastery(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Focus, _Focus_Max																			= ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF																	= ConRO:Heroism();

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _ArcaneShot, _ArcaneShot_RDY					 												= ConRO:AbilityReady(ids.BM_Ability.ArcaneShot, timeShift);
	local _AspectoftheWild, _AspectoftheWild_RDY, _AspectoftheWild_CD									= ConRO:AbilityReady(ids.BM_Ability.AspectoftheWild, timeShift);
		local _AspectoftheWild_BUFF				 															= ConRO:Aura(ids.BM_Buff.AspectoftheWild, timeShift);
	local _BarbedShot, _BarbedShot_RDY, _BarbedShot_CD													= ConRO:AbilityReady(ids.BM_Ability.BarbedShot, timeShift);
		local _BarbedShot_CHARGES, _BarbedShot_MaxCHARGES, _BarbedShot_CCD, _BarbedShot_MCCD 				= ConRO:SpellCharges(ids.BM_Ability.BarbedShot);
		local _Frenzy_BUFF, _Frenzy_COUNT, _Frenzy_DUR														= ConRO:UnitAura(ids.BM_Buff.Frenzy, timeShift, 'pet');
	local _BestialWrath, _BestialWrath_RDY, _BestialWrath_CD											= ConRO:AbilityReady(ids.BM_Ability.BestialWrath, timeShift);
		local _BestialWrath_BUFF				 															= ConRO:Aura(ids.BM_Buff.BestialWrath, timeShift);
	local _CallPet, _CallPet_RDY						 												= ConRO:AbilityReady(ids.BM_Ability.CallPetOne, timeShift);	
	local _CobraShot, _CobraShot_RDY					 												= ConRO:AbilityReady(ids.BM_Ability.CobraShot, timeShift);	
	local _CommandPet, _CommandPet_RDY					 												= ConRO:AbilityReady(ids.BM_Ability.CommandPet, timeShift);
	local _CounterShot, _CounterShot_RDY 																= ConRO:AbilityReady(ids.BM_Ability.CounterShot, timeShift);
	local _Flare, _Flare_RDY																			= ConRO:AbilityReady(ids.BM_Ability.Flare, timeShift);
	local _FreezingTrap, _FreezingTrap_RDY																= ConRO:AbilityReady(ids.BM_Ability.FreezingTrap, timeShift);
	local _HuntersMark, _HuntersMark_RDY 																= ConRO:AbilityReady(ids.BM_Ability.HuntersMark, timeShift);
		local _HuntersMark_DEBUFF																			= ConRO:PersistentDebuff(ids.BM_Debuff.HuntersMark);
	local _KillCommand, _KillCommand_RDY, _KillCommand_CD	 											= ConRO:AbilityReady(ids.BM_Ability.KillCommand, timeShift);
	local _KillShot, _KillShot_RDY																		= ConRO:AbilityReady(ids.BM_Ability.KillShot, timeShift);
	local _MultiShot, _MultiShot_RDY 																	= ConRO:AbilityReady(ids.BM_Ability.MultiShot, timeShift);
		local _BeastCleave_BUFF, _, _BeastCleave_DUR 														= ConRO:Aura(ids.BM_Buff.BeastCleave, timeShift + 1);
	local _TarTrap, _TarTrap_RDY																		= ConRO:AbilityReady(ids.BM_Ability.TarTrap, timeShift);
		local _TarTrap_DEBUFF																				= ConRO:TargetAura(ids.BM_Debuff.TarTrap, timeShift);
	local _TranquilizingShot, _TranquilizingShot_RDY													= ConRO:AbilityReady(ids.BM_Ability.TranquilizingShot, timeShift);

	local _AMurderofCrows, _AMurderofCrows_RDY			 												= ConRO:AbilityReady(ids.BM_Talent.AMurderofCrows, timeShift);	
	local _Barrage, _Barrage_RDY						 												= ConRO:AbilityReady(ids.BM_Talent.Barrage, timeShift);
	local _Bloodshed, _Bloodshed_RDY																	= ConRO:AbilityReady(ids.BM_Talent.Bloodshed, timeShift);
	local _ChimaeraShot, _ChimaeraShot_RDY					 											= ConRO:AbilityReady(ids.BM_Talent.ChimaeraShot, timeShift);
	local _DireBeast, _DireBeast_RDY, _DireBeast_CD	 													= ConRO:AbilityReady(ids.BM_Talent.DireBeast, timeShift);		
	local _Stampede, _Stampede_RDY						 												= ConRO:AbilityReady(ids.BM_Talent.Stampede, timeShift);	

	local _DeathChakram, _DeathChakram_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.DeathChakram, timeShift);
	local _FlayedShot, _FlayedShot_RDY	 																= ConRO:AbilityReady(ids.Covenant_Ability.FlayedShot, timeShift);
		local _FlayersMark_BUFF					 															= ConRO:Aura(ids.Covenant_Buff.FlayersMark, timeShift);	
	local _ResonatingArrow, _ResonatingArrow_RDY	 													= ConRO:AbilityReady(ids.Covenant_Ability.ResonatingArrow, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _WildSpirits, _WildSpirits_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.WildSpirits, timeShift);

	local _NesingwarysTrappingApparatus_EQUIPPED														= ConRO:ItemEquipped(ids.Legendary.NesingwarysTrappingApparatus_Feet) or ConRO:ItemEquipped(ids.Legendary.NesingwarysTrappingApparatus_Waist);
	local _SoulforgeEmbers_EQUIPPED																		= ConRO:ItemEquipped(ids.Legendary.SoulforgeEmbers_Head) or ConRO:ItemEquipped(ids.Legendary.SoulforgeEmbers_Shoulder);
		local _SoulforgeEmbers_DEBUFF																		= ConRO:TargetAura(ids.Legendary_Debuff.SoulforgeEmbers, timeShift);
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_execute																					= _Target_Percent_Health <= 20;
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	
--Indicators
	ConRO:AbilityInterrupt(_CounterShot, _CounterShot_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_TranquilizingShot, _TranquilizingShot_RDY and ConRO:Purgable());	
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityBurst(_AspectoftheWild, _AspectoftheWild_RDY and ConRO:BurstMode(_AspectoftheWild));
	ConRO:AbilityBurst(_BestialWrath, _BestialWrath_RDY and (_AspectoftheWild_BUFF or _AspectoftheWild_CD > 20) and ConRO:BurstMode(_BestialWrath));
	ConRO:AbilityBurst(_Stampede, _Stampede_RDY and ((_BestialWrath_BUFF and _AspectoftheWild_BUFF) or (_AspectoftheWild_BUFF and _in_combat)) and ConRO:BurstMode(_Stampede));
	ConRO:AbilityBurst(_Bloodshed, _Bloodshed_RDY and ConRO:BurstMode(_Bloodshed));
	ConRO:AbilityBurst(_AMurderofCrows, _AMurderofCrows_RDY and ConRO:BurstMode(_AMurderofCrows));

	ConRO:AbilityBurst(_ResonatingArrow, _ResonatingArrow_RDY and ConRO:BurstMode(_ResonatingArrow));
	ConRO:AbilityBurst(_DeathChakram, _DeathChakram_RDY and ConRO:BurstMode(_DeathChakram));
	ConRO:AbilityBurst(_WildSpirits, _WildSpirits_RDY and ConRO:BurstMode(_WildSpirits));

	ConRO:AbilityBurst(_TarTrap, _TarTrap_RDY and _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _SoulforgeEmbers_DEBUFF and ConRO:BurstMode(_TarTrap));
	ConRO:AbilityBurst(_Flare, _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _TarTrap_RDY and not _SoulforgeEmbers_DEBUFF);

--Warnings
	ConRO:Warnings("Call your pet!", _CallPet_RDY and not _Pet_summoned);
	
--Rotations
	if not _in_combat then
		if _AspectoftheWild_RDY and (_BestialWrath_RDY or _BestialWrath_CD > 15) and ConRO:FullMode(_AspectoftheWild) then
			return _AspectoftheWild;
		end

		if _TarTrap_RDY and _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _SoulforgeEmbers_DEBUFF and ConRO:FullMode(_TarTrap) then
			return _TarTrap;
		end
		
		if _BarbedShot_RDY and _BarbedShot_CHARGES >= 1 and tChosen[ids.BM_Talent.ScentofBlood] and _BestialWrath_RDY and not _BestialWrath_BUFF and (_AspectoftheWild_BUFF or _AspectoftheWild_CD > 15) and ConRO:FullMode(_BestialWrath) then
			return _BarbedShot;
		end		
		
		if _BestialWrath_RDY and not _BestialWrath_BUFF and (_AspectoftheWild_BUFF or _AspectoftheWild_CD > 15) and ConRO:FullMode(_BestialWrath) then
			return _BestialWrath;
		end;
		
		if _BarbedShot_RDY and (not _Frenzy_BUFF or (_Frenzy_BUFF and _Frenzy_DUR < 1.5)) then
			return _BarbedShot;
		end

		if _ChimaeraShot_RDY and ConRO_AoEButton:IsVisible() then
			return _ChimaeraShot;
		end
	
		if _KillCommand_RDY then
			return _KillCommand;
		end
	end	
				
	if _BarbedShot_RDY and (_BarbedShot_CHARGES == 2 or (_Frenzy_BUFF and _Frenzy_DUR < 2 and _Frenzy_DUR > .25)) then
		return _BarbedShot;
	end

	if _MultiShot_RDY and not _BeastCleave_BUFF and ConRO_AoEButton:IsVisible() then
		return _MultiShot;
	end

	if _Bloodshed_RDY and ConRO:FullMode(_Bloodshed) then
		return _Bloodshed;
	end
		
	if _Stampede_RDY and _BestialWrath_BUFF and _AspectoftheWild_BUFF and ConRO:FullMode(_Stampede) then
		return _Stampede;
	end

	if _Barrage_RDY and ConRO_AoEButton:IsVisible() then
		return _Barrage;
	end
	
	if _TarTrap_RDY and _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _SoulforgeEmbers_DEBUFF and ConRO_AoEButton:IsVisible() and ConRO:FullMode(_TarTrap) then
		return _TarTrap;
	end
		
	if _AspectoftheWild_RDY and (_BestialWrath_RDY or _BestialWrath_CD > 15) and ConRO:FullMode(_AspectoftheWild) then
		return _AspectoftheWild;
	end

	if _TarTrap_RDY and _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _SoulforgeEmbers_DEBUFF and ConRO:FullMode(_TarTrap) then
		return _TarTrap;
	end
		
	if _WildSpirits_RDY and ConRO:FullMode(_WildSpirits) then
		return _WildSpirits;
	end

	if _BarbedShot_RDY and _BarbedShot_CHARGES >= 1 and tChosen[ids.BM_Talent.ScentofBlood] and _BestialWrath_RDY and not _BestialWrath_BUFF and (_AspectoftheWild_BUFF or _AspectoftheWild_CD > 15) and ConRO:FullMode(_BestialWrath) then
		return _BarbedShot;
	end	
			
	if _BestialWrath_RDY and not _BestialWrath_BUFF and (_AspectoftheWild_BUFF or _AspectoftheWild_CD > 15) and ConRO:FullMode(_BestialWrath) then
		return _BestialWrath;
	end
		
	if _ResonatingArrow_RDY and ConRO:FullMode(_ResonatingArrow) then
		return _ResonatingArrow;
	end
	
	if _FlayedShot_RDY then
		return _FlayedShot;
	end
	
	if _DeathChakram_RDY and ConRO:FullMode(_DeathChakram) then
		return _DeathChakram;
	end	
	
	if _ChimaeraShot_RDY and ConRO_AoEButton:IsVisible() then
		return _ChimaeraShot;
	end

	if _KillShot_RDY and (_can_execute or _FlayersMark_BUFF) then
		return _KillShot;
	end
		
	if _KillCommand_RDY then
		return _KillCommand;
	end

	if _ChimaeraShot_RDY then
		return _ChimaeraShot;
	end

	if _AMurderofCrows_RDY and ConRO:FullMode(_AMurderofCrows) then
		return _AMurderofCrows;
	end

	if _DireBeast_RDY then
		return _DireBeast;
	end

	if _BarbedShot_RDY and _BarbedShot_CHARGES == 1 and _BarbedShot_CCD <= 1.5 then
		return _BarbedShot;
	end

	if _Barrage_RDY then
		return _Barrage;
	end
		
	if _CobraShot_RDY and (((_KillCommand_CD >= 2 or _Focus >= _Focus_Max - 15) and ConRO_SingleButton:IsVisible()) or (_Focus >= 90 and _BeastCleave_BUFF and ConRO_AoEButton:IsVisible())) then
		return _CobraShot;
	end
	
	if _NesingwarysTrappingApparatus_EQUIPPED and _Focus < 50 and ConRO.lastSpellId ~= _TarTrap and ConRO.lastSpellId ~= _FreezingTrap then
		if _TarTrap_RDY then
			return _TarTrap;
		end
		
		if _FreezingTrap_RDY then
			return _FreezingTrap;
		end		
	end
return nil;
end

function ConRO.Hunter.BeastMasteryDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Focus, _Focus_Max																			= ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF																	= ConRO:Heroism();
	
--Abilities
	local _Exhilaration, _Exhilaration_RDY																= ConRO:AbilityReady(ids.BM_Ability.Exhilaration, timeShift);
	local _AspectoftheTurtle, _AspectoftheTurtle_RDY		 											= ConRO:AbilityReady(ids.BM_Ability.AspectoftheTurtle, timeShift);
	local _MendPet, _MendPet_RDY																		= ConRO:AbilityReady(ids.BM_Ability.MendPet, timeShift);	
	local _FeedPet, _FeedPet_RDY																		= ConRO:AbilityReady(ids.BM_Ability.FeedPet, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY	 																= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
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
	
	if _FeedPet_RDY and not _in_combat and _Pet_summoned and _Pet_Percent_Health <= 60 then
		return _FeedPet;
	end	
	
	if _Exhilaration_RDY and (_Player_Percent_Health <= 50 or _Pet_Percent_Health <= 20) then
		return _Exhilaration;
	end
	
	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end	
	
	if _MendPet_RDY and _Pet_summoned and _Pet_Percent_Health <= 60 then
		return _MendPet;
	end
	
	if _AspectoftheTurtle_RDY then
		return _AspectoftheTurtle;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Hunter.Marksmanship(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Focus, _Focus_Max																			= ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF																	= ConRO:Heroism();

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _AimedShot, _AimedShot_RDY								 									= ConRO:AbilityReady(ids.MM_Ability.AimedShot, timeShift);
		local _AimedShot_CHARGES, _, _AimedShot_CCD, _AimedShot_MCCD										= ConRO:SpellCharges(ids.MM_Ability.AimedShot);
		local _PreciseShots_BUFF																			= ConRO:Aura(ids.MM_Buff.PreciseShots, timeShift);
		local _LockandLoad_BUFF																				= ConRO:Aura(ids.MM_Buff.LockandLoad, timeShift);
	local _ArcaneShot, _ArcaneShot_RDY																	= ConRO:AbilityReady(ids.MM_Ability.ArcaneShot, timeShift);
	local _CounterShot, _CounterShot_RDY 																= ConRO:AbilityReady(ids.MM_Ability.CounterShot, timeShift);
	local _Disengage, _Disengage_RDY																	= ConRO:AbilityReady(ids.MM_Ability.Disengage, timeShift);
	local _Flare, _Flare_RDY																			= ConRO:AbilityReady(ids.MM_Ability.Flare, timeShift);
	local _FreezingTrap, _FreezingTrap_RDY																= ConRO:AbilityReady(ids.MM_Ability.FreezingTrap, timeShift);
	local _HuntersMark, _HuntersMark_RDY																= ConRO:AbilityReady(ids.MM_Ability.HuntersMark, timeShift);		
		local _HuntersMark_DEBUFF 																			= ConRO:PersistentDebuff(ids.MM_Debuff.HuntersMark);
	local _KillShot, _KillShot_RDY																		= ConRO:AbilityReady(ids.MM_Ability.KillShot, timeShift);
		local _DeadEye_BUFF																					= ConRO:Aura(ids.MM_Buff.DeadEye, timeShift);
	local _MultiShot, _MultiShot_RDY																	= ConRO:AbilityReady(ids.MM_Ability.MultiShot, timeShift);
		local _TrickShots_BUFF																				= ConRO:Aura(ids.MM_Buff.TrickShots, timeShift);
	local _RapidFire, _RapidFire_RDY																	= ConRO:AbilityReady(ids.MM_Ability.RapidFire, timeShift);
	local _SteadyShot, _SteadyShot_RDY																	= ConRO:AbilityReady(ids.MM_Ability.SteadyShot, timeShift);
		local _LethalShots_BUFF																				= ConRO:Aura(ids.MM_Buff.LethalShots, timeShift);
		local _SteadyFocus_BUFF, _, _SteadyFocus_DUR														= ConRO:Aura(ids.MM_Buff.SteadyFocus, timeShift);
	local _TarTrap, _TarTrap_RDY																		= ConRO:AbilityReady(ids.MM_Ability.TarTrap, timeShift);
		local _TarTrap_DEBUFF																				= ConRO:TargetAura(ids.MM_Debuff.TarTrap, timeShift);
	local _TranquilizingShot, _TranquilizingShot_RDY													= ConRO:AbilityReady(ids.MM_Ability.TranquilizingShot, timeShift);
	local _Trueshot, _Trueshot_RDY 																		= ConRO:AbilityReady(ids.MM_Ability.Trueshot, timeShift);
		local _Trueshot_BUFF, _, _Trueshot_DUR																= ConRO:Aura(ids.MM_Buff.Trueshot, timeShift);

	local _AMurderofCrows, _AMurderofCrows_RDY 															= ConRO:AbilityReady(ids.MM_Talent.AMurderofCrows, timeShift);
	local _Barrage, _Barrage_RDY 																		= ConRO:AbilityReady(ids.MM_Talent.Barrage, timeShift);
	local _ChimaeraShot, _ChimaeraShot_RDY																= ConRO:AbilityReady(ids.MM_Talent.ChimaeraShot, timeShift);
	local _DoubleTap, _DoubleTap_RDY																	= ConRO:AbilityReady(ids.MM_Talent.DoubleTap, timeShift);
		local _DoubleTap_BUFF																				= ConRO:Aura(ids.MM_Buff.DoubleTap, timeShift);
	local _ExplosiveShot, _ExplosiveShot_RDY															= ConRO:AbilityReady(ids.MM_Talent.ExplosiveShot, timeShift);
	local _SerpentSting, _SerpentSting_RDY																= ConRO:AbilityReady(ids.MM_Talent.SerpentSting, timeShift);
		local _SerpentSting_DEBUFF																			= ConRO:TargetAura(ids.MM_Debuff.SerpentSting, timeShift + 5);
	local _Volley, _Volley_RDY																			= ConRO:AbilityReady(ids.MM_Talent.Volley, timeShift);
		local _Volley_BUFF																					= ConRO:TargetAura(ids.MM_Debuff.Volley, timeShift);

	local _SniperShot, _SniperShot_RDY																	= ConRO:AbilityReady(ids.MM_PvPTalent.SniperShot, timeShift);

	local _DeathChakram, _DeathChakram_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.DeathChakram, timeShift);
	local _FlayedShot, _FlayedShot_RDY	 																= ConRO:AbilityReady(ids.Covenant_Ability.FlayedShot, timeShift);
		local _FlayersMark_BUFF					 															= ConRO:Aura(ids.Covenant_Buff.FlayersMark, timeShift);	
	local _ResonatingArrow, _ResonatingArrow_RDY	 													= ConRO:AbilityReady(ids.Covenant_Ability.ResonatingArrow, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);	
	local _WildSpirits, _WildSpirits_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.WildSpirits, timeShift);

	local _NesingwarysTrappingApparatus_EQUIPPED														= ConRO:ItemEquipped(ids.Legendary.NesingwarysTrappingApparatus_Feet) or ConRO:ItemEquipped(ids.Legendary.NesingwarysTrappingApparatus_Waist);
	local _SoulforgeEmbers_EQUIPPED																		= ConRO:ItemEquipped(ids.Legendary.SoulforgeEmbers_Head) or ConRO:ItemEquipped(ids.Legendary.SoulforgeEmbers_Shoulder);
		local _SoulforgeEmbers_DEBUFF																		= ConRO:TargetAura(ids.Legendary_Debuff.SoulforgeEmbers, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_execute																					= _Target_Percent_Health <= 20;
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	
	local _, _, _, _AimedShot_timemil = GetSpellInfo(_AimedShot);
	local _AimedShot_time = _AimedShot_timemil*.001;
	local _AimedShot_Error = 0.3;
		if currentSpell == _AimedShot then
			_Focus = _Focus - 35;
			_AimedShot_CHARGES = _AimedShot_CHARGES - 1;
		end
		if _LockandLoad_BUFF then
			_AimedShot_time = gcd;
		end
		
	local _RapidFire_Threshold = 70
		if tChosen[ids.MM_Talent.Streamline] then
			_RapidFire_Threshold = 64;
		end

--Indicators
	ConRO:AbilityInterrupt(_CounterShot, _CounterShot_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_TranquilizingShot, _TranquilizingShot_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_Disengage, _Disengage_RDY and _target_in_melee);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityBurst(_Trueshot, _Trueshot_RDY and _AimedShot_CHARGES >= 1 and ConRO:BurstMode(_Trueshot));
	ConRO:AbilityBurst(_AMurderofCrows, _AMurderofCrows_RDY and ConRO_SingleButton:IsVisible() and ConRO:BurstMode(_AMurderofCrows));
	ConRO:AbilityBurst(_DoubleTap, _DoubleTap_RDY and not _RapidFire_RDY and _AimedShot_RDY and ConRO:BurstMode(_DoubleTap));
	ConRO:AbilityBurst(_Volley, _Volley_RDY and (_RapidFire_RDY or _AimedShot_RDY) and ConRO:BurstMode(_Volley));

	ConRO:AbilityBurst(_ResonatingArrow, _ResonatingArrow_RDY and ConRO:BurstMode(_ResonatingArrow));
	ConRO:AbilityBurst(_DeathChakram, _DeathChakram_RDY and ConRO:BurstMode(_DeathChakram));
	ConRO:AbilityBurst(_WildSpirits, _WildSpirits_RDY and ConRO:BurstMode(_WildSpirits));

	ConRO:AbilityBurst(_TarTrap, _TarTrap_RDY and _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _SoulforgeEmbers_DEBUFF and ConRO:BurstMode(_TarTrap));
	ConRO:AbilityBurst(_Flare, _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _TarTrap_RDY and not _SoulforgeEmbers_DEBUFF);
	
--Warnings

--Rotations
	if not _in_combat then
		if _DoubleTap_RDY and (ConRO:CovenantChosen(ids.Covenant.Venthyr) or ConRO:CovenantChosen(ids.Covenant.Necrolord)) and ConRO:FullMode(_DoubleTap) then
			return _DoubleTap;
		end
		
		if _AimedShot_RDY and currentSpell ~= _AimedShot then
			return _AimedShot;
		end

		if _DoubleTap_RDY and ConRO:FullMode(_DoubleTap) then
			return _DoubleTap;
		end

		if _SteadyShot_RDY and tChosen[ids.MM_Talent.SteadyFocus] and not _SteadyFocus_BUFF then
			return _SteadyShot;
		end
		
		if _ExplosiveShot_RDY and ConRO_AoEButton:IsVisible() then
			return _ExplosiveShot;
		end
		
		if _Volley_RDY and ConRO_AoEButton:IsVisible() then
			return _Volley;
		end

		if _RapidFire_RDY then
			return _RapidFire;
		end
	end

	if _SteadyShot_RDY and currentSpell == _SteadyShot and ConRO.lastSpellId ~= _SteadyShot and tChosen[ids.MM_Talent.SteadyFocus] and (not _SteadyFocus_BUFF or _SteadyFocus_DUR <= 4 or _Trueshot_BUFF) then
		return _SteadyShot;
	end
		
	if _KillShot_RDY and (_can_execute or _FlayersMark_BUFF) and not _DeadEye_BUFF then
		return _KillShot;
	end

	if _DoubleTap_RDY and not _RapidFire_RDY and _AimedShot_RDY and ConRO:FullMode(_DoubleTap) then
		return _DoubleTap;
	end

	if _TarTrap_RDY and _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _SoulforgeEmbers_DEBUFF and ConRO:FullMode(_TarTrap) then
		return _TarTrap;
	end
	
	if _SteadyShot_RDY and tChosen[ids.MM_Talent.SteadyFocus] and not _SteadyFocus_BUFF and currentSpell ~= _SteadyShot then
		return _SteadyShot;
	end

	if _SerpentSting_RDY and not _SerpentSting_DEBUFF and ConRO_SingleButton:IsVisible() then
		return _SerpentSting;
	end

	if _AMurderofCrows_RDY and ConRO_SingleButton:IsVisible() and ConRO:FullMode(_AMurderofCrows) then
		return _AMurderofCrows;
	end
		
	if _ExplosiveShot_RDY then
		return _ExplosiveShot;
	end

	if _WildSpirits_RDY and ConRO:FullMode(_WildSpirits) then
		return _WildSpirits;
	end

	if _ResonatingArrow_RDY and ConRO:FullMode(_ResonatingArrow) then
		return _ResonatingArrow;
	end
	
	if _Volley_RDY and (_RapidFire_RDY or _AimedShot_RDY) and ConRO:FullMode(_Volley) then
		return _Volley;
	end

	if _FlayedShot_RDY and ConRO_SingleButton:IsVisible() then
		return _FlayedShot;
	end

	if _DeathChakram_RDY and ConRO_SingleButton:IsVisible() and ConRO:FullMode(_DeathChakram) then
		return _DeathChakram;
	end
	
	if _Trueshot_RDY and _AimedShot_CHARGES >= 1 and ConRO_FullButton:IsVisible() then
		return _Trueshot;
	end
	
	if ConRO_AoEButton:IsVisible() then
		if _TrickShots_BUFF then
			if _RapidFire_RDY and tChosen[ids.MM_Talent.Streamline] then
				return _RapidFire;
			end

			if _AimedShot_RDY and (_AimedShot_CHARGES == 2 or (_AimedShot_CHARGES == 1 and _AimedShot_CCD <= _AimedShot_time + .5) or (_LockandLoad_BUFF and not _PreciseShots_BUFF) or _DoubleTap_BUFF) and currentSpell ~= _AimedShot then
				return _AimedShot;
			end
			
			if _RapidFire_RDY then
				return _RapidFire;
			end			
		end
		
		if _Barrage_RDY then
			return _Barrage;
		end
	else
		if _AimedShot_RDY and (_AimedShot_CHARGES == 2 or (_AimedShot_CHARGES == 1 and _AimedShot_CCD <= _AimedShot_time + .5) or (_LockandLoad_BUFF and not _PreciseShots_BUFF) or _DoubleTap_BUFF) and currentSpell ~= _AimedShot then
			return _AimedShot;
		end

		if _RapidFire_RDY then
			return _RapidFire;
		end
	end

	if ConRO_AoEButton:IsVisible() then 
		if _MultiShot_RDY and (_PreciseShots_BUFF or currentSpell == _AimedShot) then
			return _MultiShot;
		end
	else
		if tChosen[ids.MM_Talent.ChimaeraShot] then
			if _ChimaeraShot_RDY and (_PreciseShots_BUFF or currentSpell == _AimedShot) then
				return _ChimaeraShot;
			end
		else
			if _ArcaneShot_RDY and (_PreciseShots_BUFF or currentSpell == _AimedShot) then
				return _ArcaneShot;
			end
		end
	end

	if _DeathChakram_RDY and ConRO_AoEButton:IsVisible() and ConRO:FullMode(_DeathChakram) then
		return _DeathChakram;
	end
	
	if _AimedShot_RDY and not _PreciseShots_BUFF and _AimedShot_CHARGES >= 1 then
		return _AimedShot;
	end

	if _FlayedShot_RDY and ConRO_AoEButton:IsVisible() then
		return _FlayedShot;
	end

	if _NesingwarysTrappingApparatus_EQUIPPED and _Focus < 50 and ConRO.lastSpellId ~= _TarTrap and ConRO.lastSpellId ~= _FreezingTrap then
		if _TarTrap_RDY then
			return _TarTrap;
		end
		
		if _FreezingTrap_RDY then
			return _FreezingTrap;
		end		
	end
	
	if _SteadyShot_RDY then
		return _SteadyShot;
	end
return nil;
end

function ConRO.Hunter.MarksmanshipDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Focus, _Focus_Max																			= ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF																	= ConRO:Heroism();
	
--Abilities	
	local _Exhilaration, _Exhilaration_RDY					 											= ConRO:AbilityReady(ids.MM_Ability.Exhilaration, timeShift);
	local _AspectoftheTurtle, _AspectoftheTurtle_RDY		 											= ConRO:AbilityReady(ids.MM_Ability.AspectoftheTurtle, timeShift);
	local _SurvivaloftheFittestLW, _SurvivaloftheFittestLW_RDY											= ConRO:AbilityReady(ids.MM_Ability.SurvivaloftheFittestLW, timeShift);
		local _LoneWolf_FORM																				= ConRO:Form(ids.MM_Form.LoneWolf);
	local _MendPet, _MendPet_RDY																		= ConRO:AbilityReady(ids.MM_Ability.MendPet, timeShift);	
	local _FeedPet, _FeedPet_RDY																		= ConRO:AbilityReady(ids.MM_Ability.FeedPet, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY	 																= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
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
		return ids.Covenant_Ability.Fleshcraft;
	end
	
	if _FeedPet_RDY and _Pet_summoned and not _in_combat and _Pet_Percent_Health <= 60 then
		return ids.MM_Ability.FeedPet;
	end	
	
	if _Exhilaration_RDY and (_Player_Percent_Health <= 50 or _Pet_Percent_Health <= 20) then
		return ids.MM_Ability.Exhilaration;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _MendPet_RDY and _Pet_summoned and _Pet_Percent_Health <= 60 then
		return ids.MM_Ability.MendPet;
	end
	
	if _AspectoftheTurtle_RDY then
		return ids.MM_Ability.AspectoftheTurtle;
	end
	
	if _SurvivaloftheFittestLW_RDY and _LoneWolf_FORM and _in_combat then
		return ids.MM_Ability.SurvivaloftheFittestLW;
	end
	
	if _Fleshcraft_RDY then
		return ids.Covenant_Ability.Fleshcraft;
	end
	
	return nil;
end

function ConRO.Hunter.Survival(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Focus, _Focus_Max																			= ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF																	= ConRO:Heroism();

--Racials
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _AspectoftheEagle, _AspectoftheEagle_RDY														= ConRO:AbilityReady(ids.Surv_Ability.AspectoftheEagle, timeShift);
		local _AspectoftheEagle_BUFF																		= ConRO:Aura(ids.Surv_Buff.AspectoftheEagle, timeShift);
	local _CallPet, _CallPet_RDY						 												= ConRO:AbilityReady(ids.Surv_Ability.CallPetOne, timeShift);	
	local _Carve, _Carve_RDY						 													= ConRO:AbilityReady(ids.Surv_Ability.Carve, timeShift);
	local _CommandPet, _CommandPet_RDY					 												= ConRO:AbilityReady(ids.Surv_Ability.CommandPet, timeShift);	
	local _CoordinatedAssault, _CoordinatedAssault_RDY													= ConRO:AbilityReady(ids.Surv_Ability.CoordinatedAssault, timeShift);
		local _CoordinatedAssault_BUFF 																		= ConRO:Aura(ids.Surv_Buff.CoordinatedAssault, timeShift);	
	local _Flare, _Flare_RDY																			= ConRO:AbilityReady(ids.Surv_Ability.Flare, timeShift);
	local _FreezingTrap, _FreezingTrap_RDY																= ConRO:AbilityReady(ids.Surv_Ability.FreezingTrap, timeShift);
	local _Harpoon, _Harpoon_RDY						 												= ConRO:AbilityReady(ids.Surv_Ability.Harpoon, timeShift);
		local _, _Harpoon_RANGE						 														= ConRO:Targets(ids.Surv_Ability.Harpoon);
	local _KillCommand, _KillCommand_RDY				 												= ConRO:AbilityReady(ids.Surv_Ability.KillCommand, timeShift);
		local _KillCommand_CHARGES, _, _KillCommand_CCD														= ConRO:SpellCharges(ids.Surv_Ability.KillCommand);	
	local _, _TipoftheSpear_COUNT																			= ConRO:Aura(ids.Surv_Buff.TipoftheSpear, timeShift);	
	local _KillShot, _KillShot_RDY																		= ConRO:AbilityReady(ids.Surv_Ability.KillShot, timeShift);
	local _Muzzle, _Muzzle_RDY					 														= ConRO:AbilityReady(ids.Surv_Ability.Muzzle, timeShift);
	local _RaptorStrike, _RaptorStrike_RDY					 											= ConRO:AbilityReady(ids.Surv_Ability.RaptorStrike, timeShift);
		local _VipersVenom_BUFF																				= ConRO:Aura(ids.Surv_Buff.VipersVenom, timeShift);
	local _SerpentSting, _SerpentSting_RDY																= ConRO:AbilityReady(ids.Surv_Ability.SerpentSting, timeShift);
		local _SerpentSting_DEBUFF, _, _SerpentSting_DUR													= ConRO:TargetAura(ids.Surv_Debuff.SerpentSting, timeShift + 2);
	local _TranquilizingShot, _TranquilizingShot_RDY													= ConRO:AbilityReady(ids.Surv_Ability.TranquilizingShot, timeShift);
	local _WildfireBomb, _WildfireBomb_RDY																= ConRO:AbilityReady(ids.Surv_Ability.WildfireBomb, timeShift);
		local _WildfireBomb_CHARGES, _, _WildfireBomb_CCD													= ConRO:SpellCharges(ids.Surv_Ability.WildfireBomb);		
		local _WildfireBomb_DEBUFF																			= ConRO:TargetAura(ids.Surv_Debuff.WildfireBomb, timeShift + 1);
	local _PheromoneBomb, _PheromoneBomb_RDY															= ConRO:AbilityReady(ids.Surv_Talent.PheromoneBomb, timeShift);
		local _PheromoneBomb_DEBUFF																			= ConRO:TargetAura(ids.Surv_Debuff.PheromoneBomb, timeShift + 1);
	local _ShrapnelBomb, _ShrapnelBomb_RDY																= ConRO:AbilityReady(ids.Surv_Talent.ShrapnelBomb, timeShift);
		local _InternalBleeding_DEBUFF, _InternalBleeding_COUNT, _InternalBleeding_DUR						= ConRO:TargetAura(ids.Surv_Debuff.InternalBleeding, timeShift + 1);
		local _ShrapnelBomb_DEBUFF																			= ConRO:TargetAura(ids.Surv_Debuff.ShrapnelBomb, timeShift + 1);
	local _TarTrap, _TarTrap_RDY																		= ConRO:AbilityReady(ids.Surv_Ability.TarTrap, timeShift);
		local _TarTrap_DEBUFF																				= ConRO:TargetAura(ids.Surv_Debuff.TarTrap, timeShift);
	local _VolatileBomb, _VolatileBomb_RDY 																= ConRO:AbilityReady(ids.Surv_Talent.VolatileBomb, timeShift);
		local _VolatileBomb_DEBUFF																			= ConRO:TargetAura(ids.Surv_Debuff.VolatileBomb, timeShift + 1);

	local _AMurderofCrows, _AMurderofCrows_RDY 															= ConRO:AbilityReady(ids.Surv_Talent.AMurderofCrows, timeShift);
	local _Butchery, _Butchery_RDY						 												= ConRO:AbilityReady(ids.Surv_Talent.Butchery, timeShift);
	local _Chakrams, _Chakrams_RDY																		= ConRO:AbilityReady(ids.Surv_Talent.Chakrams, timeShift);
	local _FlankingStrike, _FlankingStrike_RDY			 												= ConRO:AbilityReady(ids.Surv_Talent.FlankingStrike, timeShift);
	local _MongooseBite, _MongooseBite_RDY																= ConRO:AbilityReady(ids.Surv_Talent.MongooseBite, timeShift);
		local _MongooseFury_BUFF, _MongooseFury_COUNT, _MongooseFury_DUR									= ConRO:Aura(ids.Surv_Buff.MongooseFury, timeShift);	
	local _SteelTrap, _SteelTrap_RDY																	= ConRO:AbilityReady(ids.Surv_Talent.SteelTrap, timeShift);

	local _DeathChakram, _DeathChakram_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.DeathChakram, timeShift);
	local _FlayedShot, _FlayedShot_RDY	 																= ConRO:AbilityReady(ids.Covenant_Ability.FlayedShot, timeShift);
		local _FlayersMark_BUFF					 															= ConRO:Aura(ids.Covenant_Buff.FlayersMark, timeShift);	
	local _ResonatingArrow, _ResonatingArrow_RDY	 													= ConRO:AbilityReady(ids.Covenant_Ability.ResonatingArrow, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _WildSpirits, _WildSpirits_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.WildSpirits, timeShift);

	local _NesingwarysTrappingApparatus_EQUIPPED														= ConRO:ItemEquipped(ids.Legendary.NesingwarysTrappingApparatus_Feet) or ConRO:ItemEquipped(ids.Legendary.NesingwarysTrappingApparatus_Waist);
	local _SoulforgeEmbers_EQUIPPED																		= ConRO:ItemEquipped(ids.Legendary.SoulforgeEmbers_Head) or ConRO:ItemEquipped(ids.Legendary.SoulforgeEmbers_Shoulder);
		local _SoulforgeEmbers_DEBUFF																		= ConRO:TargetAura(ids.Legendary_Debuff.SoulforgeEmbers, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_execute																					= _Target_Percent_Health <= 20;
	
	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');
	
		if ConRO:FindCurrentSpell(_ShrapnelBomb) then
			_ShrapnelBomb_RDY = _WildfireBomb_RDY;
			_WildfireBomb = _ShrapnelBomb;
		end
		if ConRO:FindCurrentSpell(_PheromoneBomb) then
			_PheromoneBomb_RDY = _WildfireBomb_RDY;
			_WildfireBomb = _PheromoneBomb;
		end
		if ConRO:FindCurrentSpell(_VolatileBomb) then
			_VolatileBomb_RDY = _WildfireBomb_RDY;
			_WildfireBomb = _VolatileBomb;
		end

		if _AspectoftheEagle_BUFF then
			_RaptorStrike = ids.Surv_Ability.RaptorStrikeRanged;
			_MongooseBite = ids.Surv_Talent.MongooseBiteRanged;
		end

--Indicators	
	ConRO:AbilityInterrupt(_Muzzle, _Muzzle_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_TranquilizingShot, _TranquilizingShot_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_Harpoon, _Harpoon_RDY and _Harpoon_RANGE and not _target_in_melee);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_CoordinatedAssault, _CoordinatedAssault_RDY and ConRO:BurstMode(_CoordinatedAssault));
	ConRO:AbilityBurst(_AspectoftheEagle, _AspectoftheEagle_RDY and not _target_in_melee);
	ConRO:AbilityBurst(_AMurderofCrows, _AMurderofCrows_RDY and ConRO:FullMode(_AMurderofCrows));
	
	ConRO:AbilityBurst(_ResonatingArrow, _ResonatingArrow_RDY and ConRO:BurstMode(_ResonatingArrow));
	ConRO:AbilityBurst(_DeathChakram, _DeathChakram_RDY and ConRO:BurstMode(_DeathChakram));
	ConRO:AbilityBurst(_WildSpirits, _WildSpirits_RDY and ConRO:BurstMode(_WildSpirits));

	ConRO:AbilityBurst(_TarTrap, _TarTrap_RDY and _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _SoulforgeEmbers_DEBUFF and ConRO:BurstMode(_TarTrap));
	ConRO:AbilityBurst(_Flare, _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _TarTrap_RDY and not _SoulforgeEmbers_DEBUFF);

--Warnings	
	ConRO:Warnings("Call your pet!", _CallPet_RDY and not _Pet_summoned);

--Rotations
	if not _in_combat then
		if _TarTrap_RDY and _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _SoulforgeEmbers_DEBUFF and ConRO:FullMode(_TarTrap) then
			return _TarTrap;
		end

		if _CoordinatedAssault_RDY and ConRO:FullMode(_CoordinatedAssault) then
			return _CoordinatedAssault;
		end
	end

	if _TarTrap_RDY and _Flare_RDY and _SoulforgeEmbers_EQUIPPED and not _SoulforgeEmbers_DEBUFF and ConRO:FullMode(_TarTrap) then
		return _TarTrap;
	end

	if _CoordinatedAssault_RDY and ConRO:FullMode(_CoordinatedAssault) then
		return _CoordinatedAssault;
	end
		
	if _KillShot_RDY and (_can_execute or _FlayersMark_BUFF) then
		return _KillShot;
	end
	
	if _WildSpirits_RDY and ConRO:FullMode(_WildSpirits) then
		return _WildSpirits;
	end	
	
	if _ResonatingArrow_RDY and ConRO:FullMode(_ResonatingArrow) then
		return _ResonatingArrow;
	end

	if _FlayedShot_RDY then
		return _FlayedShot;
	end
	
	if _DeathChakram_RDY and _Focus <= 60 and ConRO:FullMode(_DeathChakram) then
		return _DeathChakram;
	end

	if _MongooseBite_RDY and _MongooseFury_DUR >= .5 and _MongooseFury_COUNT >= 1 then
		return _MongooseBite;
	end
	
	if not tChosen[ids.Surv_Talent.MongooseBite] then
		if _RaptorStrike_RDY and _TipoftheSpear_COUNT >= 3 then
			return _RaptorStrike;
		end
	end
	
	if (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible() then
		if tChosen[ids.Surv_Talent.Butchery] then
			if _Butchery_RDY then
				return _Butchery;
			end
		else
			if _Carve_RDY then
				return _Carve;
			end
		end
	end	

	if _ShrapnelBomb_RDY and (_Focus >= 50 or _InternalBleeding_COUNT == 3) then
		return _ShrapnelBomb;
	end

	if _NesingwarysTrappingApparatus_EQUIPPED and _Focus < 50 and ConRO.lastSpellId ~= _SteelTrap and ConRO.lastSpellId ~= _TarTrap and ConRO.lastSpellId ~= _FreezingTrap then
		if _SteelTrap_RDY then
			return _SteelTrap;
		end
		
		if _TarTrap_RDY then
			return _TarTrap;
		end
		
		if _FreezingTrap_RDY then
			return _FreezingTrap;
		end		
	end
	
	if _KillCommand_RDY and _Focus <= 80 then
		return _KillCommand;
	end

	if not tChosen[ids.Surv_Talent.MongooseBite] then	
		if _RaptorStrike_RDY and _ShrapnelBomb_DEBUFF or ConRO:FindCurrentSpell(_PheromoneBomb) then
			return _RaptorStrike;
		end
	end

	if _SerpentSting_RDY and not _SerpentSting_DEBUFF and ConRO.lastSpellId ~= _SerpentSting then
		return _SerpentSting;
	end

	if _VolatileBomb_RDY and _SerpentSting_DUR <= 4 then
		return _VolatileBomb;
	end

	if _WildfireBomb_RDY and (_WildfireBomb_CHARGES == 2 or (_WildfireBomb_CHARGES == 1 and _WildfireBomb_CCD <= 1)) then
		return _WildfireBomb;
	end	

	if _Chakrams_RDY then
		return _Chakrams;
	end
	
	if _SteelTrap_RDY then
		return _SteelTrap;
	end
	
	if _AMurderofCrows_RDY and ConRO:FullMode(_AMurderofCrows) then
		return _AMurderofCrows;
	end
	
	if _Harpoon_RDY and tChosen[ids.Surv_Talent.TermsofEngagement] then
		return _Harpoon;
	end

	if _FlankingStrike_RDY and _Focus <= 50 then
		return _FlankingStrike;
	end

	if not tChosen[ids.Surv_Talent.WildfireInfusion] then	
		if _WildfireBomb_RDY then
			return _WildfireBomb;
		end
	end
	
	if tChosen[ids.Surv_Talent.MongooseBite] then
		if _MongooseBite_RDY and _Focus >= 60 then
			return _MongooseBite;
		end
	else
		if _RaptorStrike_RDY and _Focus >= 60 then
			return _RaptorStrike;
		end
	end

return nil;
end

function ConRO.Hunter.SurvivalDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Focus, _Focus_Max																			= ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF																	= ConRO:Heroism();
	
--Abilities
	local _Exhilaration, _Exhilaration_RDY					 											= ConRO:AbilityReady(ids.Surv_Ability.Exhilaration, timeShift);
	local _AspectoftheTurtle, _AspectoftheTurtle_RDY		 											= ConRO:AbilityReady(ids.Surv_Ability.AspectoftheTurtle, timeShift);
	local _MendPet, _MendPet_RDY																		= ConRO:AbilityReady(ids.Surv_Ability.MendPet, timeShift);	
	local _FeedPet, _FeedPet_RDY																		= ConRO:AbilityReady(ids.Surv_Ability.FeedPet, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY	 																= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
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
	
	if _FeedPet_RDY and _Pet_summoned and not _in_combat and _Pet_Percent_Health <= 60 then
		return _FeedPet;
	end	
	
	if _Exhilaration_RDY and (_Player_Percent_Health <= 50 or _Pet_Percent_Health <= 20) then
		return _Exhilaration;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _MendPet_RDY and _Pet_summoned and _Pet_Percent_Health <= 60 then
		return _MendPet;
	end	

	if _AspectoftheTurtle_RDY then
		return _AspectoftheTurtle;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
	
	return nil;
end