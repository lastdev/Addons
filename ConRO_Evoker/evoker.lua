ConRO.Evoker = {};
ConRO.Evoker.CheckTalents = function()
end
ConRO.Evoker.CheckPvPTalents = function()
end
local ConRO_Evoker, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Evoker.CheckTalents;
	self.ModuleOnEnable = ConRO.Evoker.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Evoker [No Specialization Under 60]";
		self.NextSpell = ConRO.Evoker.Under60;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = "Evoker [Devastation - Caster]";
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Evoker.Devastation;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Evoker.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 2 then
		self.Description = "Evoker [Preservation - Healer]";
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Evoker.Preservation;
			self.ToggleHealer();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Evoker.Disabled;
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
		self.NextDef = ConRO.Evoker.Under60Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Evoker.DevastationDef;
		else
			self.NextDef = ConRO.Evoker.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Evoker.PreservationDef;
		else
			self.NextDef = ConRO.Evoker.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Evoker.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Evoker.Under60(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

--Abilities

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Warnings

--Rotations


	return nil;
end

function ConRO.Evoker.Under60Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

--Abilities

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Warnings

--Rotations

	return nil;
end

function ConRO.Evoker.Devastation(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Dev_Ability, ids.Dev_Passive, ids.Dev_Form, ids.Dev_Buff, ids.Dev_Debuff, ids.Dev_PetAbility, ids.Dev_PvPTalent, ids.Glyph;
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
	local _Essence, _Essence_Max = ConRO:PlayerPower('Essence');

--Racials
	local _TailSwipe, _TailSwipe_RDY = ConRO:AbilityReady(Racial.TailSwipe, timeShift);
	local _WingBuffet, _WingBuffet_RDY = ConRO:AbilityReady(Racial.WingBuffet, timeShift);

--Abilities
	local _AzureStrike, _AzureStrike_RDY = ConRO:AbilityReady(Ability.AzureStrike, timeShift);
	local _DeepBreath, _DeepBreath_RDY = ConRO:AbilityReady(Ability.DeepBreath, timeShift);
	local _Disintegrate, _Disintegrate_RDY = ConRO:AbilityReady(Ability.Disintegrate, timeShift);
	local _Dragonrage, _Dragonrage_RDY = ConRO:AbilityReady(Ability.Dragonrage, timeShift);
		local _Dragonrage_BUFF = ConRO:Aura(Buff.Dragonrage, timeShift);
	local _EternitySurge, _EternitySurge_RDY = ConRO:AbilityReady(Ability.EternitySurge, timeShift);
	local _EternitySurge_FoM, _EternitySurge_FoM_RDY = ConRO:AbilityReady(Ability.EternitySurge_FoM, timeShift);
	local _FireBreath, _FireBreath_RDY = ConRO:AbilityReady(Ability.FireBreath, timeShift);
	local _FireBreath_FoM, _FireBreath_FoM_RDY = ConRO:AbilityReady(Ability.FireBreath_FoM, timeShift);
		local _Burnout_BUFF, _Burnout_COUNT = ConRO:Aura(Buff.Burnout, timeShift);
	local _Firestorm, _Firestorm_RDY = ConRO:AbilityReady(Ability.Firestorm, timeShift);
	local _Hover, _Hover_RDY = ConRO:AbilityReady(Ability.Hover, timeShift);
	local _Landslide, _Landslide_RDY = ConRO:AbilityReady(Ability.Landslide, timeShift);
	local _LivingFlame, _LivingFlame_RDY = ConRO:AbilityReady(Ability.LivingFlame, timeShift);
		local _EssenceBurst_BUFF, _EssenceBurst_COUNT = ConRO:Aura(Buff.EssenceBurst, timeShift);
	local _Pyre, _Pyre_RDY = ConRO:AbilityReady(Ability.Pyre, timeShift);
	local _Quell, _Quell_RDY = ConRO:AbilityReady(Ability.Quell, timeShift);
	local _ShatteringStar, _ShatteringStar_RDY = ConRO:AbilityReady(Ability.ShatteringStar, timeShift);
	local _TiptheScales, _TiptheScales_RDY = ConRO:AbilityReady(Ability.TiptheScales, timeShift);
	local _Unravel, _Unravel_RDY = ConRO:AbilityReady(Ability.Unravel, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

	if tChosen[Passive.FontofMagic.talentID] then
		_EternitySurge, _EternitySurge_RDY, _FireBreath, _FireBreath_RDY = _EternitySurge_FoM, _EternitySurge_FoM_RDY, _FireBreath_FoM, _FireBreath_FoM_RDY;
	end

--Indicators
	ConRO:AbilityInterrupt(_Quell, _Quell_RDY and ConRO:Interrupt());

	ConRO:AbilityBurst(_TiptheScales, _TiptheScales_RDY and _EternitySurge_RDY and ConRO_AoEButton:IsVisible() and ConRO:BurstMode(_TiptheScales));
	ConRO:AbilityBurst(_Dragonrage, _Dragonrage_RDY and _EssenceBurst_COUNT == 0 and ConRO:BurstMode(_Dragonrage));

--Rotations
	for i = 1, 2, 1 do
		if select(2, ConRO:EndChannel()) == _Disintegrate and select(1, ConRO:EndChannel()) > 1 then
			tinsert(ConRO.SuggestedSpells, _Disintegrate);
		end

		if _FireBreath_RDY then
			tinsert(ConRO.SuggestedSpells, _FireBreath);
			_FireBreath_RDY = false;
		end

		if _ShatteringStar_RDY then
			tinsert(ConRO.SuggestedSpells, _ShatteringStar);
			_ShatteringStar_RDY = false;
		end

		if _EternitySurge_RDY then
			tinsert(ConRO.SuggestedSpells, _EternitySurge);
			_EternitySurge_RDY = false;
		end

		if ConRO_AoEButton:IsVisible() then
			if _Pyre_RDY  and (_Essence >= 2 or _EssenceBurst_COUNT >= 1) then
				tinsert(ConRO.SuggestedSpells, _Pyre);
				if _EssenceBurst_COUNT >= 1 then
					_EssenceBurst_COUNT = _EssenceBurst_COUNT - 1;
				else
					_Essence = _Essence - 2;
				end				
			end
		else
			if _Disintegrate_RDY and (_Essence >= 3 or _EssenceBurst_COUNT >= 1) then
				tinsert(ConRO.SuggestedSpells, _Disintegrate);
				if _EssenceBurst_COUNT >= 1 then
					_EssenceBurst_COUNT = _EssenceBurst_COUNT - 1;
				else
					_Essence = _Essence - 3;
				end
			end
		end

		if _Dragonrage_RDY and _EssenceBurst_COUNT == 0 and ConRO:FullMode(_Dragonrage) then
			tinsert(ConRO.SuggestedSpells, _Dragonrage);
			_Dragonrage_RDY = false;
		end

		if _DeepBreath_RDY and ConRO_AoEButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _DeepBreath);
			_DeepBreath_RDY = false;
		end

		if _AzureStrike_RDY and ConRO_AoEButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _AzureStrike);
		end

		if _LivingFlame_RDY and _Burnout_COUNT >= 1 then
			tinsert(ConRO.SuggestedSpells, _LivingFlame);
			_Burnout_COUNT = _Burnout_COUNT - 1;
		end

		if _AzureStrike_RDY and (_is_moving or _Dragonrage_BUFF) then
			tinsert(ConRO.SuggestedSpells, _AzureStrike);
		end

		if _LivingFlame_RDY then
			tinsert(ConRO.SuggestedSpells, _LivingFlame);
		end
	end
	return nil;
end

function ConRO.Evoker.DevastationDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Dev_Ability, ids.Dev_Passive, ids.Dev_Form, ids.Dev_Buff, ids.Dev_Debuff, ids.Dev_PetAbility, ids.Dev_PvPTalent, ids.Glyph;
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
	local _Essence, _Essence_Max = ConRO:PlayerPower('Essence');

--Abilities

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations

	return nil;
end

function ConRO.Evoker.Preservation(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Pres_Ability, ids.Pres_Passive, ids.Pres_Form, ids.Pres_Buff, ids.Pres_Debuff, ids.Pres_PetAbility, ids.Pres_PvPTalent, ids.Glyph;
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
	local _Essence, _Essence_Max = ConRO:PlayerPower('Essence');

--Racials
	local _TailSwipe, _TailSwipe_RDY = ConRO:AbilityReady(Racial.TailSwipe, timeShift);
	local _WingBuffet, _WingBuffet_RDY = ConRO:AbilityReady(Racial.WingBuffet, timeShift);

--Abilities
	local _AzureStrike, _AzureStrike_RDY = ConRO:AbilityReady(Ability.AzureStrike, timeShift);
	local _DeepBreath, _DeepBreath_RDY = ConRO:AbilityReady(Ability.DeepBreath, timeShift);
	local _Disintegrate, _Disintegrate_RDY = ConRO:AbilityReady(Ability.Disintegrate, timeShift);
	local _FireBreath, _FireBreath_RDY = ConRO:AbilityReady(Ability.FireBreath, timeShift);
	local _FireBreath_FoM, _FireBreath_FoM_RDY = ConRO:AbilityReady(Ability.FireBreath_FoM, timeShift);
	local _Hover, _Hover_RDY = ConRO:AbilityReady(Ability.Hover, timeShift);
	local _Landslide, _Landslide_RDY = ConRO:AbilityReady(Ability.Landslide, timeShift);
	local _LivingFlame, _LivingFlame_RDY = ConRO:AbilityReady(Ability.LivingFlame, timeShift);
		local _EssenceBurst_BUFF, _EssenceBurst_COUNT = ConRO:Aura(Buff.EssenceBurst, timeShift);
	local _Quell, _Quell_RDY = ConRO:AbilityReady(Ability.Quell, timeShift);
	local _TiptheScales, _TiptheScales_RDY = ConRO:AbilityReady(Ability.TiptheScales, timeShift);
	local _Unravel, _Unravel_RDY = ConRO:AbilityReady(Ability.Unravel, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");

	if tChosen[Passive.FontofMagic.talentID] then
		_FireBreath, _FireBreath_RDY =_FireBreath_FoM, _FireBreath_FoM_RDY;
	end

--Indicators
	ConRO:AbilityInterrupt(_Quell, _Quell_RDY and ConRO:Interrupt());

--Rotations
	if _is_Enemy then
		if select(2, ConRO:EndChannel()) == _Disintegrate and select(1, ConRO:EndChannel()) > 1 then
			tinsert(ConRO.SuggestedSpells, _Disintegrate);
		end

		if _FireBreath_RDY then
			tinsert(ConRO.SuggestedSpells, _FireBreath);
			_FireBreath_RDY = false;
		end

		if _Disintegrate_RDY and _Essence >= 3 then
			tinsert(ConRO.SuggestedSpells, _Disintegrate);
			_Essence = _Essence - 3;
		end

		if _DeepBreath_RDY and _enemies_in_10yrds >= 3 then
			tinsert(ConRO.SuggestedSpells, _DeepBreath);
			_DeepBreath_RDY = false;
		end

		if _AzureStrike_RDY and (_is_moving or _enemies_in_10yrds >= 3) then
			tinsert(ConRO.SuggestedSpells, _AzureStrike);
		end

		if _LivingFlame_RDY then
			tinsert(ConRO.SuggestedSpells, _LivingFlame);
		end
	end
	return nil;
end

function ConRO.Evoker.PreservationDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Pres_Ability, ids.Pres_Passive, ids.Pres_Form, ids.Pres_Buff, ids.Pres_Debuff, ids.Pres_PetAbility, ids.Pres_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health  = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Mana, _Mana_Max, _Mana_Percent = ConRO:PlayerPower('Mana');
	local _Essence, _Essence_Max = ConRO:PlayerPower('Essence');

--Abilities

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations

	return nil;
end
