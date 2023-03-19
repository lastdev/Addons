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
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Hunter_Ability, ids.Hunter_Passive, ids.Hunter_Form, ids.Hunter_Buff, ids.Hunter_Debuff, ids.Hunter_PetAbility, ids.Hunter_PvPTalent, ids.Glyph;
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
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

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
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Hunter_Ability, ids.Hunter_Passive, ids.Hunter_Form, ids.Hunter_Buff, ids.Hunter_Debuff, ids.Hunter_PetAbility, ids.Hunter_PvPTalent, ids.Glyph;
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
	local _AncestralCall, _AncestralCall_RDY															= ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																= ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																	= ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

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
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.BM_Ability, ids.BM_Passive, ids.BM_Form, ids.BM_Buff, ids.BM_Debuff, ids.BM_PetAbility, ids.BM_PvPTalent, ids.Glyph;
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
	local _Focus, _Focus_Max = ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF = ConRO:Heroism();

--Racials
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities	
	local _AMurderofCrows, _AMurderofCrows_RDY = ConRO:AbilityReady(Ability.AMurderofCrows, timeShift);
	local _ArcaneShot, _ArcaneShot_RDY = ConRO:AbilityReady(Ability.ArcaneShot, timeShift);
	local _AspectoftheWild, _AspectoftheWild_RDY, _AspectoftheWild_CD = ConRO:AbilityReady(Ability.AspectoftheWild, timeShift);
		local _AspectoftheWild_BUFF = ConRO:Aura(Buff.AspectoftheWild, timeShift);
	local _BarbedShot, _BarbedShot_RDY, _BarbedShot_CD = ConRO:AbilityReady(Ability.BarbedShot, timeShift);
		local _BarbedShot_CHARGES, _BarbedShot_MaxCHARGES, _BarbedShot_CCD, _BarbedShot_MCCD = ConRO:SpellCharges(_BarbedShot);
		local _Frenzy_BUFF, _Frenzy_COUNT, _Frenzy_DUR = ConRO:UnitAura(Buff.Frenzy, timeShift, 'pet');
	local _Barrage, _Barrage_RDY = ConRO:AbilityReady(Ability.Barrage, timeShift);
	local _BestialWrath, _BestialWrath_RDY, _BestialWrath_CD = ConRO:AbilityReady(Ability.BestialWrath, timeShift);
		local _BestialWrath_BUFF = ConRO:Aura(Buff.BestialWrath, timeShift);
	local _Bloodshed, _Bloodshed_RDY = ConRO:AbilityReady(Ability.Bloodshed, timeShift);
	local _CalloftheWild, _CalloftheWild_RDY = ConRO:AbilityReady(Ability.CalloftheWild, timeShift);
		local _CalloftheWild_BUFF= ConRO:Aura(Buff.CalloftheWild, timeShift);
	local _CallPet, _CallPet_RDY = ConRO:AbilityReady(Ability.CallPet.One, timeShift);
	local _CobraShot, _CobraShot_RDY = ConRO:AbilityReady(Ability.CobraShot, timeShift);
	local _CounterShot, _CounterShot_RDY = ConRO:AbilityReady(Ability.CounterShot, timeShift);
	local _DeathChakram, _DeathChakram_RDY = ConRO:AbilityReady(Ability.DeathChakram, timeShift);
	local _DireBeast, _DireBeast_RDY, _DireBeast_CD = ConRO:AbilityReady(Ability.DireBeast, timeShift);
	local _ExplosiveShot, _ExplosiveShot_RDY = ConRO:AbilityReady(Ability.ExplosiveShot, timeShift);
	local _Flare, _Flare_RDY = ConRO:AbilityReady(Ability.Flare, timeShift);
	local _FreezingTrap, _FreezingTrap_RDY = ConRO:AbilityReady(Ability.FreezingTrap, timeShift);
	local _HuntersMark, _HuntersMark_RDY = ConRO:AbilityReady(Ability.HuntersMark, timeShift);
		local _HuntersMark_DEBUFF = ConRO:PersistentDebuff(Debuff.HuntersMark);
	local _KillCommand, _KillCommand_RDY, _KillCommand_CD = ConRO:AbilityReady(Ability.KillCommand, timeShift);
		local _KillCommand_CHARGES, _KillCommand_MaxCHARGES = ConRO:SpellCharges(_KillCommand);
	local _KillShot, _KillShot_RDY = ConRO:AbilityReady(Ability.KillShot, timeShift);
		local _HuntersPrey_BUFF = ConRO:Aura(Buff.HuntersPrey, timeShift);
	local _MultiShot, _MultiShot_RDY = ConRO:AbilityReady(Ability.MultiShot, timeShift);
		local _BeastCleave_BUFF, _, _BeastCleave_DUR = ConRO:Aura(Buff.BeastCleave, timeShift + 1);
	local _PrimalRageCR = ConRO:AbilityReady(Ability.CommandPet.PrimalRage, timeShift);
	local _PrimalRage, _PrimalRage_RDY = ConRO:AbilityReady(PetAbility.PrimalRage, timeShift, 'pet');
	local _SerpentSting, _SerpentSting_RDY = ConRO:AbilityReady(Ability.SerpentSting, timeShift);
		local _SerpentSting_BUFF = ConRO:Aura(Buff.SerpentSting, timeShift + 5);
	local _Stampede, _Stampede_RDY = ConRO:AbilityReady(Ability.Stampede, timeShift);
	local _SteelTrap, _SteelTrap_RDY = ConRO:AbilityReady(Ability.SteelTrap, timeShift);
	local _TarTrap, _TarTrap_RDY = ConRO:AbilityReady(Ability.TarTrap, timeShift);
		local _TarTrap_DEBUFF = ConRO:TargetAura(Debuff.TarTrap, timeShift);
	local _TranquilizingShot, _TranquilizingShot_RDY = ConRO:AbilityReady(Ability.TranquilizingShot, timeShift);
	local _WailingArrow, _WailingArrow_RDY = ConRO:AbilityReady(Ability.WailingArrow, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_range, _target_in_range = ConRO:Targets(Ability.ArcaneShot);
	local _can_execute = _Target_Percent_Health <= 20;

	local _Pet_summoned = ConRO:CallPet();
	local _Pet_assist = ConRO:PetAssist();
	local _Pet_Percent_Health = ConRO:PercentHealth('pet');

--Indicators
	ConRO:AbilityInterrupt(_CounterShot, _CounterShot_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_TranquilizingShot, _TranquilizingShot_RDY and ConRO:Purgable());

	ConRO:AbilityBurst(_AMurderofCrows, _AMurderofCrows_RDY and _in_combat and ConRO:BurstMode(_AMurderofCrows));
	ConRO:AbilityBurst(_AspectoftheWild, _AspectoftheWild_RDY and _in_combat and ConRO:BurstMode(_AspectoftheWild));
	ConRO:AbilityBurst(_BestialWrath, _BestialWrath_RDY and _in_combat and ConRO:BurstMode(_BestialWrath));
	ConRO:AbilityBurst(_Bloodshed, _Bloodshed_RDY and _in_combat and ConRO:BurstMode(_Bloodshed));
	ConRO:AbilityBurst(_CalloftheWild, _CalloftheWild_RDY and _in_combat and ConRO:BurstMode(_CalloftheWild));
	ConRO:AbilityBurst(_DeathChakram, _DeathChakram_RDY and _in_combat and ConRO:BurstMode(_DeathChakram));
	ConRO:AbilityBurst(_Stampede, _Stampede_RDY and ((_BestialWrath_BUFF and _AspectoftheWild_BUFF) or (_AspectoftheWild_BUFF and _in_combat)) and ConRO:BurstMode(_Stampede));
	ConRO:AbilityBurst(_PrimalRage, _PrimalRage_RDY and _party_size <= 1 and _in_combat and not _Heroism_BUFF and not _Sated_DEBUFF);
	ConRO:AbilityBurst(_PrimalRageCR, _PrimalRage_RDY and _party_size <= 1 and _in_combat and not _Heroism_BUFF and not _Sated_DEBUFF);

--Warnings
	ConRO:Warnings("Call your pet!", _CallPet_RDY and not _Pet_summoned);

--Rotations
	for i = 1, 2, 1 do
		if not _in_combat then
			if _WailingArrow_RDY then
				tinsert(ConRO.SuggestedSpells, _WailingArrow);
				_WailingArrow_RDY = false;
			end

			if _BarbedShot_RDY and _BarbedShot_CHARGES >= 1 then
				tinsert(ConRO.SuggestedSpells, _BarbedShot);
				_BarbedShot_CHARGES = _BarbedShot_CHARGES - 1;
			end

			if _Bloodshed_RDY and ConRO:FullMode(_Bloodshed) then
				tinsert(ConRO.SuggestedSpells, _Bloodshed);
				_Bloodshed_RDY = false;
			end

			if _BestialWrath_RDY and not _BestialWrath_BUFF and ConRO:FullMode(_BestialWrath) then
				tinsert(ConRO.SuggestedSpells, _BestialWrath);
			end

			if _KillCommand_RDY then
				tinsert(ConRO.SuggestedSpells, _KillCommand);
				_KillCommand_RDY = false;
			end
		end

		if _BarbedShot_RDY and (_Frenzy_BUFF and _Frenzy_DUR < 2 and _Frenzy_DUR > .25) or (_BarbedShot_CHARGES >= _BarbedShot_MaxCHARGES - 1 and _BarbedShot_CCD <= 3 and not _Frenzy_BUFF) then
			tinsert(ConRO.SuggestedSpells, _BarbedShot);
			_BarbedShot_CHARGES = _BarbedShot_CHARGES - 1;
		end

		if _BarbedShot_RDY and ((_BarbedShot_CHARGES >= _BarbedShot_MaxCHARGES - 1 and _BarbedShot_CCD <= 3) or (_BarbedShot_CHARGES >= 1 and _BestialWrath_CD <= 20 and tChosen[Passive.ScentofBlood.talentID])) and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _BarbedShot);
			_BarbedShot_CHARGES = _BarbedShot_CHARGES - 1;
		end

		if _MultiShot_RDY and tChosen[Passive.BeastCleave.talentID] and not _BeastCleave_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _MultiShot);
			_BeastCleave_BUFF = true;
		end

		if _KillCommand_RDY and (_KillCommand_CHARGES >= _KillCommand_MaxCHARGES or (_KillCommand_CHARGES >= 1 and _KillCommand_CD >= 2))  then
			tinsert(ConRO.SuggestedSpells, _KillCommand);
			_KillCommand_CHARGES = _KillCommand_CHARGES - 1;
		end

		if _CalloftheWild_RDY and ConRO:FullMode(_CalloftheWild) then
			tinsert(ConRO.SuggestedSpells, _CalloftheWild);
			_CalloftheWild_RDY = false;
		end

		if _ExplosiveShot_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _ExplosiveShot);
			_ExplosiveShot_RDY = false;
		end

		if _Bloodshed_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 1) or ConRO_SingleButton:IsVisible()) and ConRO:FullMode(_Bloodshed) then
			tinsert(ConRO.SuggestedSpells, _Bloodshed);
			_Bloodshed_RDY = false;
		end

		if _Stampede_RDY and ConRO:FullMode(_Stampede) then
			tinsert(ConRO.SuggestedSpells, _Stampede);
			_Stampede_RDY = false;
		end

		if _DeathChakram_RDY and ConRO:FullMode(_DeathChakram) then
			tinsert(ConRO.SuggestedSpells, _DeathChakram);
			_DeathChakram_RDY = false;
		end

		if _AMurderofCrows_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 1) or ConRO_SingleButton:IsVisible()) and ConRO:FullMode(_AMurderofCrows) then
			tinsert(ConRO.SuggestedSpells, _AMurderofCrows);
			_AMurderofCrows_RDY = false;
		end

		if _SteelTrap_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 1) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _SteelTrap);
			_SteelTrap_RDY = false;
		end

		if _ExplosiveShot_RDY then
			tinsert(ConRO.SuggestedSpells, _ExplosiveShot);
			_ExplosiveShot_RDY = false;
		end

		if _Bloodshed_RDY and ConRO:FullMode(_Bloodshed) then
			tinsert(ConRO.SuggestedSpells, _Bloodshed);
			_Bloodshed_RDY = false;
		end

		if _BestialWrath_RDY and ConRO:FullMode(_BestialWrath) then
			tinsert(ConRO.SuggestedSpells, _BestialWrath);
			_BestialWrath_RDY = false;
		end

		if _AMurderofCrows_RDY and ConRO:FullMode(_AMurderofCrows) then
			tinsert(ConRO.SuggestedSpells, _AMurderofCrows);
			_AMurderofCrows_RDY = false;
		end

		if _SteelTrap_RDY then
			tinsert(ConRO.SuggestedSpells, _SteelTrap);
			_SteelTrap_RDY = false;
		end

		if _BarbedShot_RDY and ((_BarbedShot_CHARGES >= _BarbedShot_MaxCHARGES - 1 and _BarbedShot_CCD <= 8) or _CalloftheWild_BUFF) and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _BarbedShot);
			_BarbedShot_CHARGES = _BarbedShot_CHARGES - 1;
		end

		if _KillCommand_RDY and _KillCommand_CHARGES >= 1 and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 1) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _KillCommand);
			_KillCommand_CHARGES = _KillCommand_CHARGES - 1;
		end

		if _BarbedShot_RDY and ((_BarbedShot_CHARGES >= _BarbedShot_MaxCHARGES - 1 and _BarbedShot_CCD <= 6) or (_BarbedShot_CHARGES >= 1 and _BestialWrath_CD <= 20 and tChosen[Passive.ScentofBlood.talentID]) or _CalloftheWild_BUFF) and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 2) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _BarbedShot);
			_BarbedShot_CHARGES = _BarbedShot_CHARGES - 1;
		end

		if _DireBeast_RDY then
			tinsert(ConRO.SuggestedSpells, _DireBeast);
			_DireBeast_RDY = false;
		end

		if _SerpentSting_RDY and not _SerpentSting_BUFF then
			tinsert(ConRO.SuggestedSpells, _SerpentSting);
			_SerpentSting_RDY = false;
		end

		if _Barrage_RDY and _Frenzy_DUR >= 4 and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _Barrage);
			_Barrage_RDY = false;
		end

		if _KillShot_RDY and (_can_execute or _HuntersPrey_BUFF) then
			tinsert(ConRO.SuggestedSpells, _KillShot);
			_KillShot_RDY = false;
		end

		if _AspectoftheWild_RDY and ConRO:FullMode(_AspectoftheWild) then
			tinsert(ConRO.SuggestedSpells, _AspectoftheWild);
			_AspectoftheWild_RDY = false;
		end

		if _CobraShot_RDY then
			tinsert(ConRO.SuggestedSpells, _CobraShot);
		end

		if _WailingArrow_RDY and _Frenzy_DUR >= 3 then
			tinsert(ConRO.SuggestedSpells, _WailingArrow);
			_WailingArrow_RDY = false;
		end
	end
	return nil;
end

function ConRO.Hunter.BeastMasteryDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.BM_Ability, ids.BM_Passive, ids.BM_Form, ids.BM_Buff, ids.BM_Debuff, ids.BM_PetAbility, ids.BM_PvPTalent, ids.Glyph;
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
	local _Exhilaration, _Exhilaration_RDY																= ConRO:AbilityReady(Ability.Exhilaration, timeShift);
	local _AspectoftheTurtle, _AspectoftheTurtle_RDY		 											= ConRO:AbilityReady(Ability.AspectoftheTurtle, timeShift);
	local _MendPet, _MendPet_RDY																		= ConRO:AbilityReady(Ability.PetUtility.MendPet, timeShift);
	local _FeedPet, _FeedPet_RDY																		= ConRO:AbilityReady(Ability.PetUtility.FeedPet, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');

--Rotations	
		if _FeedPet_RDY and not _in_combat and _Pet_summoned and _Pet_Percent_Health <= 60 then
			tinsert(ConRO.SuggestedDefSpells, _FeedPet);
		end

		if _Exhilaration_RDY and (_Player_Percent_Health <= 50 or _Pet_Percent_Health <= 20) then
			tinsert(ConRO.SuggestedDefSpells, _Exhilaration);
		end

		if _MendPet_RDY and _Pet_summoned and _Pet_Percent_Health <= 60 then
			tinsert(ConRO.SuggestedDefSpells, _MendPet);
		end

		if _AspectoftheTurtle_RDY then
			tinsert(ConRO.SuggestedDefSpells, _AspectoftheTurtle);
		end
	return nil;
end

function ConRO.Hunter.Marksmanship(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.MM_Ability, ids.MM_Passive, ids.MM_Form, ids.MM_Buff, ids.MM_Debuff, ids.MM_PetAbility, ids.MM_PvPTalent, ids.Glyph;
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
	local _Focus, _Focus_Max = ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF = ConRO:Heroism();

--Racials
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities	
	local _AimedShot, _AimedShot_RDY = ConRO:AbilityReady(Ability.AimedShot, timeShift);
		local _AimedShot_CHARGES, _, _AimedShot_CCD, _AimedShot_MCCD = ConRO:SpellCharges(_AimedShot);
		local _PreciseShots_BUFF, _PreciseShots_COUNT = ConRO:Aura(Buff.PreciseShots, timeShift);
		local _LockandLoad_BUFF = ConRO:Aura(Buff.LockandLoad, timeShift);
	local _ArcaneShot, _ArcaneShot_RDY = ConRO:AbilityReady(Ability.ArcaneShot, timeShift);
	local _ChimaeraShot, _ChimaeraShot_RDY = ConRO:AbilityReady(Ability.ChimaeraShot, timeShift);
	local _CounterShot, _CounterShot_RDY = ConRO:AbilityReady(Ability.CounterShot, timeShift);
	local _DeathChakram, _DeathChakram_RDY = ConRO:AbilityReady(Ability.DeathChakram, timeShift);
	local _Disengage, _Disengage_RDY = ConRO:AbilityReady(Ability.Disengage, timeShift);
	local _ExplosiveShot, _ExplosiveShot_RDY = ConRO:AbilityReady(Ability.ExplosiveShot, timeShift);
		local _ExplosiveShot_DEBUFF = ConRO:TargetAura(Debuff.ExplosiveShot);
	local _Flare, _Flare_RDY = ConRO:AbilityReady(Ability.Flare, timeShift);
	local _FreezingTrap, _FreezingTrap_RDY = ConRO:AbilityReady(Ability.FreezingTrap, timeShift);
	local _HuntersMark, _HuntersMark_RDY = ConRO:AbilityReady(Ability.HuntersMark, timeShift);
		local _HuntersMark_DEBUFF = ConRO:PersistentDebuff(Debuff.HuntersMark);
	local _KillShot, _KillShot_RDY = ConRO:AbilityReady(Ability.KillShot, timeShift);
		local _KillShot_CHARGES = ConRO:SpellCharges(_KillShot);
		local _DeadEye_BUFF = ConRO:Aura(Buff.DeadEye, timeShift);
		local _Deathblow_BUFF = ConRO:Aura(Buff.Deathblow, timeShift);
		local _RazorFragments_BUFF = ConRO:Aura(Buff.RazorFragments, timeShift);
	local _MultiShot, _MultiShot_RDY = ConRO:AbilityReady(Ability.MultiShot, timeShift);
		local _TrickShots_BUFF = ConRO:Aura(Buff.TrickShots, timeShift);
	local _PrimalRageCR = ConRO:AbilityReady(Ability.CommandPet.PrimalRage, timeShift);
	local _PrimalRage, _PrimalRage_RDY = ConRO:AbilityReady(PetAbility.PrimalRage, timeShift, 'pet');
	local _RapidFire, _RapidFire_RDY = ConRO:AbilityReady(Ability.RapidFire, timeShift);
	local _Salvo, _Salvo_RDY = ConRO:AbilityReady(Ability.Salvo, timeShift);
	local _SerpentSting, _SerpentSting_RDY = ConRO:AbilityReady(Ability.SerpentSting, timeShift);
		local _SerpentSting_DEBUFF = ConRO:TargetAura(Debuff.SerpentSting, timeShift + 3);
	local _Stampede, _Stampede_RDY = ConRO:AbilityReady(Ability.Stampede, timeShift);
	local _SteadyShot, _SteadyShot_RDY = ConRO:AbilityReady(Ability.SteadyShot, timeShift);
		local _LethalShots_BUFF = ConRO:Aura(Buff.LethalShots, timeShift);
		local _SteadyFocus_BUFF, _, _SteadyFocus_DUR = ConRO:Aura(Buff.SteadyFocus, timeShift);
	local _SteelTrap, _SteelTrap_RDY = ConRO:AbilityReady(Ability.SteelTrap, timeShift);
	local _TarTrap, _TarTrap_RDY = ConRO:AbilityReady(Ability.TarTrap, timeShift);
		local _TarTrap_DEBUFF = ConRO:TargetAura(Debuff.TarTrap, timeShift);
	local _TranquilizingShot, _TranquilizingShot_RDY = ConRO:AbilityReady(Ability.TranquilizingShot, timeShift);
	local _Trueshot, _Trueshot_RDY = ConRO:AbilityReady(Ability.Trueshot, timeShift);
		local _Trueshot_BUFF, _, _Trueshot_DUR = ConRO:Aura(Buff.Trueshot, timeShift);
	local _Volley, _Volley_RDY = ConRO:AbilityReady(Ability.Volley, timeShift);
		local _Volley_BUFF = ConRO:TargetAura(Debuff.Volley, timeShift);
	local _WailingArrow, _WailingArrow_RDY = ConRO:AbilityReady(Ability.WailingArrow, timeShift);


--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_range, _target_in_range = ConRO:Targets(Ability.ArcaneShot);
	local _can_execute = _Target_Percent_Health <= 20;

	local _Pet_summoned = ConRO:CallPet();
	local _Pet_assist = ConRO:PetAssist();
	local _Pet_Percent_Health = ConRO:PercentHealth('pet');

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
		if tChosen[Passive.Streamline.talentID] then
			_RapidFire_Threshold = 64;
		end

	local _ArcaneShot_COST = 40;
		if tChosen[Ability.ChimaeraShot.talentID] then
			_ArcaneShot, _ArcaneShot_RDY = _ChimaeraShot, _ChimaeraShot_RDY;
			_ArcaneShot_COST = 20;
		end

--Indicators
	ConRO:AbilityInterrupt(_CounterShot, _CounterShot_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_TranquilizingShot, _TranquilizingShot_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_Disengage, _Disengage_RDY and _target_in_melee);

	ConRO:AbilityBurst(_Trueshot, _Trueshot_RDY and _AimedShot_CHARGES >= 1 and ConRO:BurstMode(_Trueshot));
	ConRO:AbilityBurst(_Salvo, _Salvo_RDY and ConRO:BurstMode(_Salvo));
	ConRO:AbilityBurst(_Volley, _Volley_RDY and (_RapidFire_RDY or _AimedShot_RDY) and ConRO:BurstMode(_Volley));
	ConRO:AbilityBurst(_Stampede, _Stampede_RDY and ConRO:BurstMode(_Stampede));
	ConRO:AbilityBurst(_DeathChakram, _DeathChakram_RDY and ConRO:BurstMode(_DeathChakram));
	ConRO:AbilityBurst(_PrimalRage, _PrimalRage_RDY and _party_size <= 1 and _in_combat and not _Heroism_BUFF and not _Sated_DEBUFF);
	ConRO:AbilityBurst(_PrimalRageCR, _PrimalRage_RDY and _party_size <= 1 and _in_combat and not _Heroism_BUFF and not _Sated_DEBUFF);

--Warnings

--Rotations
	for i = 1, 2, 1 do
		if not _in_combat then
			if _AimedShot_RDY and _AimedShot_CHARGES >= 1 and currentSpell ~= _AimedShot then
				tinsert(ConRO.SuggestedSpells, _AimedShot);
				_AimedShot_CHARGES = _AimedShot_CHARGES - 1;
				_PreciseShots_COUNT = _PreciseShots_COUNT + 1;
			end

			if _SteadyShot_RDY and tChosen[Passive.SteadyFocus.talentID] and not _SteadyFocus_BUFF and currentSpell ~= _SteadyShot then
				tinsert(ConRO.SuggestedSpells, _SteadyShot);
				_SteadyShot_RDY = false;
			end
		end

		if _SteadyShot_RDY and tChosen[Passive.SteadyFocus.talentID] and (currentSpell == _SteadyShot and ConRO.lastSpellId ~= _SteadyShot) and (_SteadyFocus_DUR <= 5 or not _SteadyFocus_BUFF) then
			tinsert(ConRO.SuggestedSpells, _SteadyShot);
			_SteadyShot_RDY = false;
		end

		if _KillShot_RDY and _KillShot_CHARGES >= 1 and (_can_execute or _Deathblow_BUFF) and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 1) or ConRO_SingleButton:IsVisible() or _RazorFragments_BUFF) then
			tinsert(ConRO.SuggestedSpells, _KillShot);
			_KillShot_CHARGES = _KillShot_CHARGES - 1;
			if _Deathblow_BUFF then
				_Deathblow_BUFF = false;
			end
		end

		if _DeathChakram_RDY and ConRO:FullMode(_DeathChakram) then
			tinsert(ConRO.SuggestedSpells, _DeathChakram);
			_DeathChakram_RDY = false;
		end

		if _Stampede_RDY and ConRO:FullMode(_Stampede) then
			tinsert(ConRO.SuggestedSpells, _Stampede);
			_Stampede_RDY = false;
		end

		if _Salvo_RDY and not _ExplosiveShot_DEBUFF and ConRO:FullMode(_Salvo) then
			tinsert(ConRO.SuggestedSpells, _Salvo);
			_Salvo_RDY = false;
		end

		if _Volley_RDY and ConRO:FullMode(_Volley) then
			tinsert(ConRO.SuggestedSpells, _Volley);
			_Volley_RDY = false;
		end

		if _SerpentSting_RDY and not _SerpentSting_DEBUFF and ConRO.lastSpellId ~= _SerpentSting and not tChosen[Passive.SerpentstalkersTrickery.talentID] and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 1) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _SerpentSting);
			_SerpentSting_DEBUFF = true;
		end

		if _SteelTrap_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_range <= 1) or ConRO_SingleButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _SteelTrap);
			_SteelTrap_RDY = false;
		end

		if _WailingArrow_RDY then
			tinsert(ConRO.SuggestedSpells, _WailingArrow);
			_WailingArrow_RDY = false;
		end

		if _MultiShot_RDY and (not _TrickShots_BUFF or currentSpell == _AimedShot or select(2, ConRO:EndChannel()) == _RapidFire) and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _MultiShot);
			_TrickShots_BUFF = true;
			_PreciseShots_COUNT = _PreciseShots_COUNT - 1;
		end

		if _RapidFire_RDY then
			tinsert(ConRO.SuggestedSpells, _RapidFire);
			_RapidFire_RDY = false;
		end

		if _ExplosiveShot_RDY and not _ExplosiveShot_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _ExplosiveShot);
			_ExplosiveShot_RDY = false;
		end

		if _Barrage_RDY then
			tinsert(ConRO.SuggestedSpells, _Barrage);
			_Barrage_RDY = false;
		end

		if _Trueshot_RDY and ConRO:FullMode(_Trueshot) then
			tinsert(ConRO.SuggestedSpells, _Trueshot);
			_Trueshot_RDY = false;
		end

		if _AimedShot_RDY and (not _PreciseShots_BUFF or _Trueshot_BUFF) and currentSpell ~= _AimedShot then
			tinsert(ConRO.SuggestedSpells, _AimedShot);
			_PreciseShots_COUNT = _PreciseShots_COUNT + 1;
			_AimedShot_RDY = false;
		end

		if _SerpentSting_RDY and not _SerpentSting_DEBUFF and not tChosen[Passive.SerpentstalkersTrickery.talentID] and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _SerpentSting);
			_SerpentSting_DEBUFF = true;
		end

		if _KillShot_RDY and _KillShot_CHARGES >= 1 and (_can_execute or _Deathblow_BUFF) and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _KillShot);
			_KillShot_CHARGES = _KillShot_CHARGES - 1;
			if _Deathblow_BUFF then
				_Deathblow_BUFF = false;
			end
		end

		if _SteelTrap_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _SteelTrap);
			_SteelTrap_RDY = false;
		end

		if _SteadyShot_RDY and tChosen[Passive.SteadyFocus.talentID] and not _SteadyFocus_BUFF and currentSpell ~= _SteadyShot then
			tinsert(ConRO.SuggestedSpells, _SteadyShot);
			_SteadyShot_RDY = false;
		end

		if _MultiShot_RDY and (_PreciseShots_BUFF or currentSpell == _AimedShot or _Focus >= 55) and ((ConRO_AutoButton:IsVisible() and _enemies_in_range >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _MultiShot);
			_Focus = _Focus - 40;
		end

		if _ArcaneShot_RDY and (_PreciseShots_COUNT >= 1 or currentSpell == _AimedShot or _Focus >= 55) then
			tinsert(ConRO.SuggestedSpells, _ArcaneShot);
			_Focus = _Focus - _ArcaneShot_COST;
			_PreciseShots_COUNT = _PreciseShots_COUNT - 1;
		end

		if _SteadyShot_RDY then
			tinsert(ConRO.SuggestedSpells, _SteadyShot);
		end
	end
	return nil;
end

function ConRO.Hunter.MarksmanshipDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.MM_Ability, ids.MM_Passive, ids.MM_Form, ids.MM_Buff, ids.MM_Debuff, ids.MM_PetAbility, ids.MM_PvPTalent, ids.Glyph;
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
	local _Focus, _Focus_Max = ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF = ConRO:Heroism();

--Abilities	
	local _Exhilaration, _Exhilaration_RDY = ConRO:AbilityReady(Ability.Exhilaration, timeShift);
	local _AspectoftheTurtle, _AspectoftheTurtle_RDY = ConRO:AbilityReady(Ability.AspectoftheTurtle, timeShift);
	local _SurvivaloftheFittest, _SurvivaloftheFittest_RDY = ConRO:AbilityReady(Ability.SurvivaloftheFittest, timeShift);
		local _LoneWolf_FORM = ConRO:Form(Form.LoneWolf);
	local _MendPet, _MendPet_RDY = ConRO:AbilityReady(Ability.PetUtility.MendPet, timeShift);
	local _FeedPet, _FeedPet_RDY = ConRO:AbilityReady(Ability.PetUtility.FeedPet, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

	local _Pet_summoned = ConRO:CallPet();
	local _Pet_assist = ConRO:PetAssist();
	local _Pet_Percent_Health = ConRO:PercentHealth('pet');

--Rotations	
	if _FeedPet_RDY and _Pet_summoned and not _in_combat and _Pet_Percent_Health <= 60 then
		tinsert(ConRO.SuggestedDefSpells, _FeedPet);
	end

	if _Exhilaration_RDY and (_Player_Percent_Health <= 50 or _Pet_Percent_Health <= 20) then
		tinsert(ConRO.SuggestedDefSpells, _Exhilaration);
	end

	if _MendPet_RDY and _Pet_summoned and _Pet_Percent_Health <= 60 then
		tinsert(ConRO.SuggestedDefSpells, _MendPet);
	end

	if _AspectoftheTurtle_RDY then
		tinsert(ConRO.SuggestedDefSpells, _AspectoftheTurtle);
	end

	if _SurvivaloftheFittest_RDY and _LoneWolf_FORM and _in_combat then
		tinsert(ConRO.SuggestedDefSpells, _SurvivaloftheFittest);
	end
	return nil;
end

function ConRO.Hunter.Survival(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Surv_Ability, ids.Surv_Passive, ids.Surv_Form, ids.Surv_Buff, ids.Surv_Debuff, ids.Surv_PetAbility, ids.Surv_PvPTalent, ids.Glyph;
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
	local _Focus, _Focus_Max = ConRO:PlayerPower('Focus');
	local _Heroism_BUFF, _Sated_DEBUFF = ConRO:Heroism();

--Racials
	local _AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities	
	local _AspectoftheEagle, _AspectoftheEagle_RDY = ConRO:AbilityReady(Ability.AspectoftheEagle, timeShift);
		local _AspectoftheEagle_BUFF = ConRO:Aura(Buff.AspectoftheEagle, timeShift);
	local _Barrage, _Barrage_RDY = ConRO:AbilityReady(Ability.Barrage, timeShift);
	local _Butchery, _Butchery_RDY = ConRO:AbilityReady(Ability.Butchery, timeShift);
		local _Butchery_CHARGES, _Butchery_MCHARGES	= ConRO:SpellCharges(_Butchery);
	local _CallPet, _CallPet_RDY = ConRO:AbilityReady(Ability.CallPet.One, timeShift);
	local _Carve, _Carve_RDY = ConRO:AbilityReady(Ability.Carve, timeShift);
	local _CoordinatedAssault, _CoordinatedAssault_RDY = ConRO:AbilityReady(Ability.CoordinatedAssault, timeShift);
		local _CoordinatedAssault_BUFF = ConRO:Aura(Buff.CoordinatedAssault, timeShift);
	local _ExplosiveShot, _ExplosiveShot_RDY = ConRO:AbilityReady(Ability.ExplosiveShot, timeShift);
	local _Flare, _Flare_RDY = ConRO:AbilityReady(Ability.Flare, timeShift);
	local _FreezingTrap, _FreezingTrap_RDY = ConRO:AbilityReady(Ability.FreezingTrap, timeShift);
	local _FuryoftheEagle, _FuryoftheEagle_RDY = ConRO:AbilityReady(Ability.FuryoftheEagle, timeShift);
	local _Harpoon, _Harpoon_RDY = ConRO:AbilityReady(Ability.Harpoon, timeShift);
		local _, _Harpoon_RANGE = ConRO:Targets(Ability.Harpoon);
		local _TermsofEngagement_BUFF = ConRO:Aura(Buff.TermsofEngagement, timeShift);
	local _KillCommand, _KillCommand_RDY = ConRO:AbilityReady(Ability.KillCommand, timeShift);
		local _KillCommand_CHARGES, _, _KillCommand_CCD = ConRO:SpellCharges(_KillCommand);
		local _, _TipoftheSpear_COUNT = ConRO:Aura(Buff.TipoftheSpear, timeShift);
	local _KillShot, _KillShot_RDY = ConRO:AbilityReady(Ability.KillShot, timeShift);
	local _Muzzle, _Muzzle_RDY = ConRO:AbilityReady(Ability.Muzzle, timeShift);
	local _PrimalRageCR = ConRO:AbilityReady(Ability.CommandPet.PrimalRage, timeShift);
	local _PrimalRage, _PrimalRage_RDY = ConRO:AbilityReady(PetAbility.PrimalRage, timeShift, 'pet');
	local _RaptorStrike, _RaptorStrike_RDY = ConRO:AbilityReady(Ability.RaptorStrike, timeShift);
		local _VipersVenom_BUFF = ConRO:Aura(Buff.VipersVenom, timeShift);
	local _SerpentSting, _SerpentSting_RDY = ConRO:AbilityReady(Ability.SerpentSting, timeShift);
		local _SerpentSting_DEBUFF, _, _SerpentSting_DUR = ConRO:TargetAura(Debuff.SerpentSting, timeShift);
		local _LatentPoison, _LatentPoison_COUNT = ConRO:TargetAura(Debuff.LatentPoison, timeShift);
	local _TranquilizingShot, _TranquilizingShot_RDY = ConRO:AbilityReady(Ability.TranquilizingShot, timeShift);
	local _WildfireBomb, _WildfireBomb_RDY = ConRO:AbilityReady(Ability.WildfireBomb, timeShift);
		local _WildfireBomb_CHARGES, _WildfireBomb_MCHARGES, _WildfireBomb_CCD = ConRO:SpellCharges(_WildfireBomb);
		local _WildfireBomb_DEBUFF = ConRO:TargetAura(Debuff.WildfireBomb, timeShift + 1);
	local _PheromoneBomb, _PheromoneBomb_RDY = ConRO:AbilityReady(Passive.WildfireInfusion.PheromoneBomb, timeShift);
		local _PheromoneBomb_DEBUFF = ConRO:TargetAura(Debuff.PheromoneBomb, timeShift + 1);
	local _ShrapnelBomb, _ShrapnelBomb_RDY = ConRO:AbilityReady(Passive.WildfireInfusion.ShrapnelBomb, timeShift);
		local _InternalBleeding_DEBUFF, _InternalBleeding_COUNT, _InternalBleeding_DUR = ConRO:TargetAura(Debuff.InternalBleeding, timeShift + 1);
		local _ShrapnelBomb_DEBUFF = ConRO:TargetAura(Debuff.ShrapnelBomb, timeShift + 1);
	local _Spearhead, _Spearhead_RDY = ConRO:AbilityReady(Ability.Spearhead, timeShift);
		local _Spearhead_BUFF = ConRO:Aura(Buff.Spearhead, timeShift);
		local _DeadlyDuo_BUFF, _DeadlyDuo_COUNT = ConRO:Aura(Buff.DeadlyDuo, timeShift);
	local _Stampede, _Stampede_RDY = ConRO:AbilityReady(Ability.Stampede, timeShift);
	local _TarTrap, _TarTrap_RDY = ConRO:AbilityReady(Ability.TarTrap, timeShift);
		local _TarTrap_DEBUFF = ConRO:TargetAura(Debuff.TarTrap, timeShift);
	local _VolatileBomb, _VolatileBomb_RDY = ConRO:AbilityReady(Passive.WildfireInfusion.VolatileBomb, timeShift);
		local _VolatileBomb_DEBUFF = ConRO:TargetAura(Debuff.VolatileBomb, timeShift + 1);

	local _FlankingStrike, _FlankingStrike_RDY			 												= ConRO:AbilityReady(Ability.FlankingStrike, timeShift);
	local _MongooseBite, _MongooseBite_RDY																= ConRO:AbilityReady(Ability.MongooseBite, timeShift);
		local _MongooseFury_BUFF, _MongooseFury_COUNT, _MongooseFury_DUR									= ConRO:Aura(Buff.MongooseFury, timeShift);
	local _SteelTrap, _SteelTrap_RDY																	= ConRO:AbilityReady(Ability.SteelTrap, timeShift);

	local _DeathChakram, _DeathChakram_RDY																= ConRO:AbilityReady(Ability.DeathChakram, timeShift);

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
			_RaptorStrike = Ability.RaptorStrikeRanged;
			_MongooseBite = Ability.MongooseBiteRanged;
		end

--Indicators	
	ConRO:AbilityInterrupt(_Muzzle, _Muzzle_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_TranquilizingShot, _TranquilizingShot_RDY and ConRO:Purgable());
	ConRO:AbilityMovement(_Harpoon, _Harpoon_RDY and _Harpoon_RANGE and not _target_in_melee);

	ConRO:AbilityBurst(_Harpoon, _Harpoon_RDY and tChosen[Passive.TermsofEngagement.talentID] and not _TermsofEngagement_BUFF);
	ConRO:AbilityBurst(_AspectoftheEagle, _AspectoftheEagle_RDY and not _target_in_melee);
	ConRO:AbilityBurst(_CoordinatedAssault, _CoordinatedAssault_RDY and ConRO:BurstMode(_CoordinatedAssault));
	ConRO:AbilityBurst(_DeathChakram, _DeathChakram_RDY and ConRO:BurstMode(_DeathChakram));
	ConRO:AbilityBurst(_PrimalRage, _PrimalRage_RDY and _party_size <= 1 and _in_combat and not _Heroism_BUFF and not _Sated_DEBUFF);
	ConRO:AbilityBurst(_PrimalRageCR, _PrimalRage_RDY and _party_size <= 1 and _in_combat and not _Heroism_BUFF and not _Sated_DEBUFF);

--Warnings	
	ConRO:Warnings("Call your pet!", _CallPet_RDY and not _Pet_summoned);

--Rotations
	for i = 1, 2, 1 do
		if not _in_combat then
			if _WildfireBomb_RDY and _WildfireBomb_CHARGES >= 1 then
				tinsert(ConRO.SuggestedSpells, _WildfireBomb);
				_WildfireBomb_RDY = false;
			end
		end

		if _WildfireBomb_RDY and _WildfireBomb_CHARGES == _WildfireBomb_MCHARGES and (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) then
			tinsert(ConRO.SuggestedSpells, _WildfireBomb);
			_WildfireBomb_CHARGES = _WildfireBomb_CHARGES - 1;
		end

		if _DeathChakram_RDY and ConRO:FullMode(_DeathChakram) then
			tinsert(ConRO.SuggestedSpells, _DeathChakram);
			_DeathChakram_RDY = false;
		end

		if _Stampede_RDY and (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) then
			tinsert(ConRO.SuggestedSpells, _Stampede);
			_DeathChakram_RDY = false;
		end

		if _Spearhead_RDY and _Focus <= _Focus_Max - 20 and not _CoordinatedAssault_BUFF and ConRO:FullMode(_Spearhead) then
			tinsert(ConRO.SuggestedSpells, _Spearhead);
			_Spearhead_RDY = false;
		end

		if _CoordinatedAssault_RDY and not _Spearhead_BUFF and ConRO:FullMode(_CoordinatedAssault) then
			tinsert(ConRO.SuggestedSpells, _CoordinatedAssault);
			_CoordinatedAssault_RDY = false;
		end

		if _KillShot_RDY and _CoordinatedAssault_BUFF and (_can_execute or tChosen[Passive.CoordinatedKill.talentID]) then
			tinsert(ConRO.SuggestedSpells, _KillShot);
			_KillShot_RDY = false;
		end

		if _KillCommand_RDY and _DeadlyDuo_COUNT >= 2 then
			tinsert(ConRO.SuggestedSpells, _KillCommand);
			_KillCommand_RDY = false;
		end

		if (ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) then
			if _ExplosiveShot_RDY then
				tinsert(ConRO.SuggestedSpells, _ExplosiveShot);
				_ExplosiveShot_RDY = false;
			end

			if _Barrage_RDY then
				tinsert(ConRO.SuggestedSpells, _Barrage);
				_Barrage_RDY = false;
			end

			if _Butchery_RDY and (_Butchery_CHARGES >= _Butchery_MCHARGES or _ShrapnelBomb_DEBUFF) then
				tinsert(ConRO.SuggestedSpells, _Butchery);
				_Butchery_CHARGES = _Butchery_CHARGES - 1;
			end

			if _Carve_RDY and not tChosen[Ability.Butchery] and _ShrapnelBomb_DEBUFF then
				tinsert(ConRO.SuggestedSpells, _Carve);
				_Carve_RDY = false;
			end

			if _WildfireBomb_RDY and _WildfireBomb_CHARGES == _WildfireBomb_MCHARGES then
				tinsert(ConRO.SuggestedSpells, _WildfireBomb);
				_WildfireBomb_CHARGES = _WildfireBomb_CHARGES - 1;
			end

			if _FuryoftheEagle_RDY then
				tinsert(ConRO.SuggestedSpells, _FuryoftheEagle);
				_FuryoftheEagle_RDY = false;
			end

			if _FlankingStrike_RDY and _Focus <= _Focus_Max - 30 then
				tinsert(ConRO.SuggestedSpells, _FlankingStrike);
				_FlankingStrike_RDY = false;
			end

			if _Butchery_RDY and _Butchery_CHARGES >= 1 then
				tinsert(ConRO.SuggestedSpells, _Butchery);
				_Butchery_CHARGES = _Butchery_CHARGES - 1;
			end

			if _Carve_RDY and not tChosen[Ability.Butchery] then
				tinsert(ConRO.SuggestedSpells, _Carve);
				_Carve_RDY = false;
			end

			if tChosen[Passive.PoisonInjection.talentID] and _LatentPoison_COUNT >= 8 then
				if tChosen[Ability.MongooseBite.talentID] then
					if _MongooseBite_RDY then
						tinsert(ConRO.SuggestedSpells, _MongooseBite);
					end
				else
					if _RaptorStrike_RDY then
						tinsert(ConRO.SuggestedSpells, _RaptorStrike);
					end
				end
			end

			if _KillCommand_RDY and _Focus <= 75 then
				tinsert(ConRO.SuggestedSpells, _KillCommand);
				_KillCommand_RDY = false;
			end
		end

		if _MongooseBite_RDY and _Spearhead_BUFF then
			tinsert(ConRO.SuggestedSpells, _MongooseBite);
			_MongooseBite_RDY = false;
		end

		if _KillShot_RDY and _can_execute then
			tinsert(ConRO.SuggestedSpells, _KillShot);
			_KillShot_RDY = false;
		end

		if _SerpentSting_RDY and not _SerpentSting_DEBUFF and ConRO.lastSpellId ~= _SerpentSting and not tChosen[Passive.VipersVenom.talentID] then
			tinsert(ConRO.SuggestedSpells, _SerpentSting);
			_SerpentSting_RDY = false;
		end

		if _FlankingStrike_RDY and _Focus <= _Focus_Max - 30 then
			tinsert(ConRO.SuggestedSpells, _FlankingStrike);
			_FlankingStrike_RDY = false;
		end

		if _PheromoneBomb_RDY and _WildfireBomb_CHARGES >= 1 and _Focus <= 50 and not _MongooseFury_BUFF then
			tinsert(ConRO.SuggestedSpells, _PheromoneBomb);
			_WildfireBomb_CHARGES = _WildfireBomb_CHARGES -1;
		end

		if _KillCommand_RDY and _Focus <= 75 then
			tinsert(ConRO.SuggestedSpells, _KillCommand);
			_KillCommand_RDY = false;
		end

		if _ShrapnelBomb_DEBUFF then
			if tChosen[Ability.MongooseBite.talentID] then
				if _MongooseBite_RDY then
					tinsert(ConRO.SuggestedSpells, _MongooseBite);
				end
			else
				if _RaptorStrike_RDY then
					tinsert(ConRO.SuggestedSpells, _RaptorStrike);
				end
			end
		end

		if _WildfireBomb_RDY and _WildfireBomb_CHARGES == _WildfireBomb_MCHARGES then
			tinsert(ConRO.SuggestedSpells, _WildfireBomb);
			_WildfireBomb_CHARGES = _WildfireBomb_CHARGES - 1;
		end

		if _MongooseBite_RDY and _MongooseFury_DUR >= 0.2 and _MongooseFury_COUNT >= 1 then
			tinsert(ConRO.SuggestedSpells, _MongooseBite);
			_MongooseBite_RDY = false;
		end

		if _MongooseBite_RDY and not _MongooseFury_BUFF and _Focus >= 65 then
			tinsert(ConRO.SuggestedSpells, _MongooseBite);
			_MongooseBite_RDY = false;
		end

		if _ExplosiveShot_RDY then
			tinsert(ConRO.SuggestedSpells, _ExplosiveShot);
			_ExplosiveShot_RDY = false;
		end

		if _Barrage_RDY then
			tinsert(ConRO.SuggestedSpells, _Barrage);
			_Barrage_RDY = false;
		end

		if _RaptorStrike_RDY and not tChosen[Ability.MongooseBite.talentID] then
			tinsert(ConRO.SuggestedSpells, _RaptorStrike);
		end

		if _SteelTrap_RDY then
			tinsert(ConRO.SuggestedSpells, _SteelTrap);
			_SteelTrap_RDY = false;
		end

		if _WildfireBomb_RDY and _WildfireBomb_CHARGES >= 1 then
			tinsert(ConRO.SuggestedSpells, _WildfireBomb);
		end

		if _FuryoftheEagle_RDY then
			tinsert(ConRO.SuggestedSpells, _FuryoftheEagle);
			_FuryoftheEagle_RDY = false;
		end
	end
	return nil;
end

function ConRO.Hunter.SurvivalDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Surv_Ability, ids.Surv_Passive, ids.Surv_Form, ids.Surv_Buff, ids.Surv_Debuff, ids.Surv_PetAbility, ids.Surv_PvPTalent, ids.Glyph;
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
	local _Exhilaration, _Exhilaration_RDY					 											= ConRO:AbilityReady(Ability.Exhilaration, timeShift);
	local _AspectoftheTurtle, _AspectoftheTurtle_RDY		 											= ConRO:AbilityReady(Ability.AspectoftheTurtle, timeShift);
	local _MendPet, _MendPet_RDY																		= ConRO:AbilityReady(Ability.PetUtility.MendPet, timeShift);
	local _FeedPet, _FeedPet_RDY																		= ConRO:AbilityReady(Ability.PetUtility.FeedPet, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);

	local _Pet_summoned 																				= ConRO:CallPet();
	local _Pet_assist 																					= ConRO:PetAssist();
	local _Pet_Percent_Health																			= ConRO:PercentHealth('pet');

--Rotations	
	if _FeedPet_RDY and _Pet_summoned and not _in_combat and _Pet_Percent_Health <= 60 then
		tinsert(ConRO.SuggestedDefSpells, _FeedPet);
	end

	if _Exhilaration_RDY and (_Player_Percent_Health <= 50 or _Pet_Percent_Health <= 20) then
		tinsert(ConRO.SuggestedDefSpells, _Exhilaration);
	end

	if _MendPet_RDY and _Pet_summoned and _Pet_Percent_Health <= 60 then
		tinsert(ConRO.SuggestedDefSpells, _MendPet);
	end

	if _AspectoftheTurtle_RDY then
		tinsert(ConRO.SuggestedDefSpells, _AspectoftheTurtle);
	end
	return nil;
end
