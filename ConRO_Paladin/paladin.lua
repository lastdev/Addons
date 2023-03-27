ConRO.Paladin = {};
ConRO.Paladin.CheckTalents = function()
end
ConRO.Paladin.CheckPvPTalents = function()
end
local ConRO_Paladin, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Paladin.CheckTalents;
	self.ModuleOnEnable = ConRO.Paladin.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Paladin [No Specialization Under 10]";
		self.NextSpell = ConRO.Paladin.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = "Paladin [Holy - Healer]";
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Paladin.Holy;
			self.ToggleDamage();
			self.BlockAoE();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Paladin.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 2 then
		self.Description = "Paladin [Protection - Tank]";
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Paladin.Protection;
			self.ToggleDamage();
			self.BlockAoE();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Paladin.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 3 then
		self.Description = "Paladin [Retribution - Melee]";
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.Paladin.Retribution;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Paladin.Disabled;
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
		self.NextDef = ConRO.Paladin.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Paladin.HolyDef;
		else
			self.NextDef = ConRO.Paladin.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Paladin.ProtectionDef;
		else
			self.NextDef = ConRO.Paladin.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Paladin.RetributionDef;
		else
			self.NextDef = ConRO.Paladin.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Paladin.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Paladin.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Warnings

--Rotations


	return nil;
end

function ConRO.Paladin.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Warnings

--Rotations

	return nil;
end

function ConRO.Paladin.Holy(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Holy_Ability, ids.Holy_Form, ids.Holy_Buff, ids.Holy_Debuff, ids.Holy_PetAbility, ids.Holy_PvPTalent, ids.Glyph;
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
	local _Mana, _Mana_Max, _Mana_Percent																					= ConRO:PlayerPower('Mana');
	local _HolyPower, _HolyPower_Max																							= ConRO:PlayerPower('HolyPower');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	--Paladin
	local _AvengingWrath, _AvengingWrath_RDY 																			= ConRO:AbilityReady(Ability.AvengingWrath, timeShift);
	local _BlessingofFreedom, _BlessingofFreedom_RDY	 														= ConRO:AbilityReady(Ability.BlessingofFreedom, timeShift);
	local _BlindingLight, _BlindingLight_RDY	 																		= ConRO:AbilityReady(Ability.BlindingLight, timeShift);
	local _Consecration, _Consecration_RDY 																				= ConRO:AbilityReady(Ability.Consecration, timeShift);
	local _CrusaderStrike, _CrusaderStrike_RDY				 														= ConRO:AbilityReady(Ability.CrusaderStrike, timeShift);
		local _CrusaderStrike_CHARGES																									= ConRO:SpellCharges(Ability.CrusaderStrike.spellID);
	local _DivineSteed, _DivineSteed_RDY	 																				= ConRO:AbilityReady(Ability.DivineSteed, timeShift);
	local _HammerofJustice, _HammerofJustice_RDY 																	= ConRO:AbilityReady(Ability.HammerofJustice, timeShift);
	local _HammerofWrath, _HammerofWrath_RDY 																			= ConRO:AbilityReady(Ability.HammerofWrath, timeShift);
	local _HolyAvenger, _HolyAvenger_RDY	 																				= ConRO:AbilityReady(Ability.HolyAvenger, timeShift);
	local _Judgment, _Judgment_RDY	 																							= ConRO:AbilityReady(Ability.Judgment, timeShift);
	local _Rebuke, _Rebuke_RDY	 																									= ConRO:AbilityReady(Ability.Rebuke, timeShift);
	local _Repentance, _Repentance_RDY	 																					= ConRO:AbilityReady(Ability.Repentance, timeShift);
	local _Seraphim, _Seraphim_RDY	 																							= ConRO:AbilityReady(Ability.Seraphim, timeShift);
	local _ShieldoftheRighteous, _ShieldoftheRighteous_RDY	 											= ConRO:AbilityReady(Ability.ShieldoftheRighteous, timeShift);
	local _TurnEvil, _TurnEvil_RDY	 																							= ConRO:AbilityReady(Ability.TurnEvil, timeShift);
	local _WordofGlory, _WordofGlory_RDY	 																				= ConRO:AbilityReady(Ability.WordofGlory, timeShift);
		local _DivinePurpose_BUFF																											= ConRO:Aura(Buff.DivinePurpose);
  --Holy
	local _AuraMastery, _AuraMastery_RDY 																					= ConRO:AbilityReady(Ability.AuraMastery, timeShift);
	local _AvengingCrusader, _AvengingCrusader_RDY 																= ConRO:AbilityReady(Ability.AvengingCrusader, timeShift);
	local _BeaconofFaith, _BeaconofFaith_RDY 																			= ConRO:AbilityReady(Ability.BeaconofFaith, timeShift);
	local _BeaconofLight, _BeaconofLight_RDY 																			= ConRO:AbilityReady(Ability.BeaconofLight, timeShift);
	local _BlessingofAutumn, _BlessingofAutumn_RDY 																= ConRO:AbilityReady(Ability.BlessingofAutumn, timeShift);
	local _BlessingofSpring, _BlessingofSpring_RDY 																= ConRO:AbilityReady(Ability.BlessingofSpring, timeShift);
	local _BlessingofSummer, _BlessingofSummer_RDY 																= ConRO:AbilityReady(Ability.BlessingofSummer, timeShift);
	local _BlessingofWinter, _BlessingofWinter_RDY 																= ConRO:AbilityReady(Ability.BlessingofWinter, timeShift);
	local _DivineToll, _DivineToll_RDY 																						= ConRO:AbilityReady(Ability.DivineToll, timeShift);
	local _HolyPrism, _HolyPrism_RDY 																							= ConRO:AbilityReady(Ability.HolyPrism, timeShift);
	local _HolyShock, _HolyShock_RDY 																							= ConRO:AbilityReady(Ability.HolyShock, timeShift);
	local _LightofDawn, _LightofDawn_RDY	 																				= ConRO:AbilityReady(Ability.LightofDawn, timeShift);
	local _LightsHammer, _LightsHammer_RDY																				= ConRO:AbilityReady(Ability.LightsHammer, timeShift);

		if tChosen[Ability.SanctifiedWrath.talentID] then
			_AvengingWrath, _AvengingWrath_RDY																					= ConRO:AbilityReady(Ability.SanctifiedWrath, timeShift);
		elseif tChosen[Ability.AvengingWrathMight.talentID] then
			_AvengingWrath, _AvengingWrath_RDY																					= ConRO:AbilityReady(Ability.AvengingWrathMight, timeShift);
		end

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);
	local _can_execute																														= _Target_Percent_Health <= 20;

		if _DivinePurpose_BUFF then
			_HolyPower = 5;
		end

	local _BlessingoftheSeasons_RDY = _BlessingofSummer_RDY;
	local _BlessingoftheSeasons = false;
		if ConRO:FindCurrentSpell(_BlessingofSpring) then
			_BlessingoftheSeasons = _BlessingofSpring;
		end
		if ConRO:FindCurrentSpell(_BlessingofSummer) then
			_BlessingoftheSeasons = _BlessingofSummer;
		end
		if ConRO:FindCurrentSpell(_BlessingofAutumn) then
			_BlessingoftheSeasons = _BlessingofAutumn;
		end
		if ConRO:FindCurrentSpell(_BlessingofWinter) then
			_BlessingoftheSeasons = _BlessingofWinter;
		end

--Warnings
	ConRO:Warnings("Select an Aura!", GetShapeshiftForm() == 0 and GetNumShapeshiftForms() >= 1);

--Indicators
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());

	ConRO:AbilityRaidBuffs(_BeaconofLight, _BeaconofLight_RDY and not ConRO:OneBuff(Form.BeaconofLight));
	ConRO:AbilityRaidBuffs(_BeaconofFaith, _BeaconofFaith_RDY and not ConRO:OneBuff(Form.BeaconofFaith));

	ConRO:AbilityBurst(_AvengingWrath, _AvengingWrath_RDY and ConRO:BurstMode(_AvengingWrath));
	ConRO:AbilityBurst(_LightsHammer, _LightsHammer_RDY and _is_Enemy and _HolyPower < 3 and ConRO:BurstMode(_LightsHammer));

	ConRO:AbilityRaidBuffs(_LightofDawn, _LightofDawn_RDY and _HolyPower >= 3 and not _VanquishersHammer_BUFF);
	ConRO:AbilityRaidBuffs(_WordofGlory, _WordofGlory_RDY and _HolyPower >= 3);

	ConRO:AbilityBurst(_AuraMastery, _AuraMastery_RDY and _in_combat);

	ConRO:AbilityRaidBuffs(_BlessingoftheSeasons, _BlessingoftheSeasons_RDY);

--Rotations
	if _is_Enemy then
		if _HammerofWrath_RDY and _can_execute then
			tinsert(ConRO.SuggestedSpells, _HammerofWrath);
		end

		if _DivineToll_RDY and _HolyPower <= 0 and ConRO:FullMode(_DivineToll) then
			tinsert(ConRO.SuggestedSpells, _DivineToll);
		end

		if _HolyPrism_RDY then
			tinsert(ConRO.SuggestedSpells, _HolyPrism);
		end

		if _HolyShock_RDY and _HolyPower <= 4 then
			tinsert(ConRO.SuggestedSpells, _HolyShock);
		end

		if _CrusaderStrike_RDY and _CrusaderStrike_CHARGES >= 2 and tChosen[Ability.CrusadersMight] then
			tinsert(ConRO.SuggestedSpells, _CrusaderStrike);
		end

		if _Judgment_RDY then
			tinsert(ConRO.SuggestedSpells, _Judgment);
		end

		if _LightsHammer_RDY and ConRO:FullMode(_LightsHammer) then
			tinsert(ConRO.SuggestedSpells, _LightsHammer);
		end

		if _CrusaderStrike_RDY and _CrusaderStrike_CHARGES >= 1 then
			tinsert(ConRO.SuggestedSpells, _CrusaderStrike);
		end

		if _Consecration_RDY then
			tinsert(ConRO.SuggestedSpells, _Consecration);
		end
	end
	return nil;
end

function ConRO.Paladin.HolyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Holy_Ability, ids.Holy_Form, ids.Holy_Buff, ids.Holy_Debuff, ids.Holy_PetAbility, ids.Holy_PvPTalent, ids.Glyph;
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
	local _Mana, _Mana_Max, _Mana_Percent																					= ConRO:PlayerPower('Mana');
	local _HolyPower, _HolyPower_Max																							= ConRO:PlayerPower('HolyPower');

--Abilities
	local _BlessingofProtection, _BlessingofProtection_RDY 												= ConRO:AbilityReady(ids.Holy_Ability.BlessingofProtection, timeShift);
	local _DivineProtection, _DivineProtection_RDY 																= ConRO:AbilityReady(ids.Holy_Ability.DivineProtection, timeShift);
	local _DivineShield, _DivineShield_RDY 																				= ConRO:AbilityReady(ids.Holy_Ability.DivineShield, timeShift);
	local _LayonHands, _LayonHands_RDY 																						= ConRO:AbilityReady(ids.Holy_Ability.LayonHands, timeShift);
		local _Forbearance_BUFF 																											= ConRO:Aura(ids.Holy_Debuff.Forbearance, timeShift, 'HARMFUL');

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Rotations
		if _LayonHands_RDY and not _Forbearance_BUFF and _Player_Percent_Health <= 10 then
			tinsert(ConRO.SuggestedDefSpells, _LayonHands);
		end

		if _DivineProtection_RDY then
			tinsert(ConRO.SuggestedDefSpells, _DivineProtection);
		end

		if _DivineShield_RDY and not _Forbearance_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _DivineShield);
		elseif _BlessingofProtection_RDY and not _Forbearance_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _BlessingofProtection);
		end
	return nil;
end

function ConRO.Paladin.Protection(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Prot_Ability, ids.Prot_Form, ids.Prot_Buff, ids.Prot_Debuff, ids.Prot_PetAbility, ids.Prot_PvPTalent, ids.Glyph;
--Info
	local _Player_Level	= UnitLevel("player");
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
	local _HolyPower, _HolyPower_Max = ConRO:PlayerPower('HolyPower');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _AvengersShield, _AvengersShield_RDY = ConRO:AbilityReady(Ability.AvengersShield, timeShift);
		local _AvengersShield_enemies, _AvengersShield_RANGE = ConRO:Targets(Ability.AvengersShield);
	local _AvengingWrath, _AvengingWrath_RDY, _AvengingWrath_CD = ConRO:AbilityReady(Ability.AvengingWrath, timeShift);
		local _AvengingWrath_BUFF = ConRO:Aura(Buff.AvengingWrath, timeShift);
	local _BlessedHammer, _BlessedHammer_RDY = ConRO:AbilityReady(Ability.BlessedHammer, timeShift);
		local _BlessedHammer_CHARGES, _BlessedHammer_MaxCHARGES	= ConRO:SpellCharges(Ability.BlessedHammer.spellID);
		local _BlessedHammer_DEBUFF = ConRO:TargetAura(Debuff.BlessedHammer, timeShift);
	local _Consecration, _Consecration_RDY = ConRO:AbilityReady(Ability.Consecration, timeShift);
		local _Consecration_FORM = ConRO:Form(Form.Consecration);
	local _HammeroftheRighteous, _HammeroftheRighteous_RDY = ConRO:AbilityReady(Ability.HammeroftheRighteous, timeShift);
	local _HammerofWrath, _HammerofWrath_RDY = ConRO:AbilityReady(Ability.HammerofWrath, timeShift);
	local _HandofReckoning, _HandofReckoning_RDY = ConRO:AbilityReady(Ability.HandofReckoning, timeShift);
	local _Judgment, _Judgment_RDY = ConRO:AbilityReady(Ability.Judgment, timeShift);
	local _Rebuke, _Rebuke_RDY = ConRO:AbilityReady(Ability.Rebuke, timeShift);
	local _ShieldoftheRighteous, _ShieldoftheRighteous_RDY = ConRO:AbilityReady(Ability.ShieldoftheRighteous, timeShift);
		local _ShieldoftheRighteous_BUFF = ConRO:Aura(Buff.ShieldoftheRighteous, timeShift + 1);
		local _, _ShiningLight_COUNT, _ShiningLight_DUR = ConRO:Aura(Buff.ShiningLight_Stack, timeShift);
		local _DivinePurpose_BUFF = ConRO:Aura(Buff.DivinePurpose, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);
	local _can_execute = _Target_Percent_Health <= 20;

		if _DivinePurpose_BUFF then
			_HolyPower = 5;
		end

--Warnings
	ConRO:Warnings("Select an Aura!", GetShapeshiftForm() == 0 and GetNumShapeshiftForms() >= 1);

--Indicators
	ConRO:AbilityInterrupt(_AvengersShield, _AvengersShield_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_Rebuke, _Rebuke_RDY and not _AvengersShield_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());

	ConRO:AbilityTaunt(_HandofReckoning, _HandofReckoning_RDY);

	ConRO:AbilityBurst(_AvengingWrath, _AvengingWrath_RDY and ConRO:BurstMode(_AvengingWrath));

--Rotations
	if not _in_combat then
		if _AvengersShield_RDY and (_enemies_in_melee >= 3 or _AvengersShield_enemies >= 3) then
			tinsert(ConRO.SuggestedSpells, _AvengersShield);
			_AvengersShield_RDY = false;
		end

		if _Judgment_RDY and not _target_in_melee then
			tinsert(ConRO.SuggestedSpells, _Judgment);
			_Judgment_RDY = false;
		end
	end

	if _Consecration_RDY and not _Consecration_FORM then
		tinsert(ConRO.SuggestedSpells, _Consecration);
		_Consecration_RDY = false;
	end

	if _AvengingWrath_RDY and ConRO:FullMode(_AvengingWrath) then
		tinsert(ConRO.SuggestedSpells, _AvengingWrath);
		_AvengingWrath_RDY = false;
	end

	if _Seraphim_RDY and _HolyPower >= 3 and (_AvengingWrath_BUFF or _AvengingWrath_CD >= 40 or ConRO:BurstMode(_AvengingWrath)) and ConRO:FullMode(_Seraphim) then
		tinsert(ConRO.SuggestedSpells, _Seraphim);
		_Seraphim_RDY = false;
	end

	if _ShieldoftheRighteous_RDY and (_HolyPower >= 5 and not _ShieldoftheRighteous_BUFF) then
		tinsert(ConRO.SuggestedSpells, _ShieldoftheRighteous);
		_ShieldoftheRighteous_BUFF = true;
	end

	if _DivineToll_RDY and ConRO:FullMode(_DivineToll) then
		tinsert(ConRO.SuggestedSpells, _DivineToll);
		_DivineToll_RDY = false;
	end

	if _AvengersShield_RDY and _enemies_in_melee >= 3 then
		tinsert(ConRO.SuggestedSpells, _AvengersShield);
		_AvengersShield_RDY = false;
	end

	if _Judgment_RDY and ConRO.lastSpellId ~= _Judgment then
		tinsert(ConRO.SuggestedSpells, _Judgment);
		_Judgment_RDY = false;
	end

	if _HammerofWrath_RDY then
		tinsert(ConRO.SuggestedSpells, _HammerofWrath);
		_HammerofWrath_RDY = false;
	end

	if _AvengersShield_RDY then
		tinsert(ConRO.SuggestedSpells, _AvengersShield);
		_AvengersShield_RDY = false;
	end

	if _BlessedHammer_RDY and (_BlessedHammer_CHARGES == _BlessedHammer_MaxCHARGES or not _BlessedHammer_DEBUFF) then
		tinsert(ConRO.SuggestedSpells, _BlessedHammer);
		_BlessedHammer_CHARGES = _BlessedHammer_CHARGES - 1;
		_BlessedHammer_DEBUFF = true;
	elseif not tChosen[Ability.BlessedHammer] and _HammeroftheRighteous_RDY then
		tinsert(ConRO.SuggestedSpells, _HammeroftheRighteous);
		_HammeroftheRighteous = false;
	end

	if _Consecration_RDY then
		tinsert(ConRO.SuggestedSpells, _Consecration);
		_Consecration_RDY = false;
	end

	return nil;
end

function ConRO.Paladin.ProtectionDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Prot_Ability, ids.Prot_Form, ids.Prot_Buff, ids.Prot_Debuff, ids.Prot_PetAbility, ids.Prot_PvPTalent, ids.Glyph;
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
	local _HolyPower, _HolyPower_Max = ConRO:PlayerPower('HolyPower');

--Abilities
	local _ArdentDefender, _ArdentDefender_RDY, _ArdentDefender_CD = ConRO:AbilityReady(Ability.ArdentDefender, timeShift);
		local _ArdentDefender_BUFF = ConRO:Aura(Buff.ArdentDefender, timeShift);
	local _BlessingofProtection, _BlessingofProtection_RDY = ConRO:AbilityReady(Ability.BlessingofProtection, timeShift);
	local _DivineShield, _DivineShield_RDY = ConRO:AbilityReady(Ability.DivineShield, timeShift);
	local _EyeofTyr, _EyeofTyr_RDY = ConRO:AbilityReady(Ability.EyeofTyr, timeShift);
	local _GuardianofAncientKings, _GuardianofAncientKings_RDY = ConRO:AbilityReady(Ability.GuardianofAncientKings, timeShift);
		local _GuardianofAncientKings_BUFF = ConRO:Aura(Buff.GuardianofAncientKings, timeShift);
		local _GuardianofAncientKings_ID = select(7, GetSpellInfo("Guardian of Ancient Kings"));
	local _ShieldoftheRighteous, _ShieldoftheRighteous_RDY = ConRO:AbilityReady(Ability.ShieldoftheRighteous, timeShift);
		local _ShieldoftheRighteous_BUFF = ConRO:Aura(Buff.ShieldoftheRighteous, timeShift + 1);
		local _ShiningLight_BUFF, _, _ShiningLight_DUR = ConRO:Aura(Buff.ShiningLight, timeShift);
	local _LayonHands, _LayonHands_RDY = ConRO:AbilityReady(Ability.LayonHands, timeShift);
		local _Forbearance_BUFF = ConRO:Aura(Debuff.Forbearance, timeShift, 'HARMFUL');
	local _WordofGlory, _WordofGlory_RDY = ConRO:AbilityReady(Ability.WordofGlory, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations
		if _WordofGlory_RDY and ((_HolyPower >= 3 or _ShiningLight_BUFF) and _Player_Percent_Health <= 80) then
			tinsert(ConRO.SuggestedDefSpells, _WordofGlory);
		end

		if _LayonHands_RDY and not _Forbearance_BUFF and _Player_Percent_Health <= 10 then
			tinsert(ConRO.SuggestedDefSpells, _LayonHands);
		end

		if _ShieldoftheRighteous_RDY and not _ShieldoftheRighteous_BUFF and _HolyPower >= 3 and not _ArdentDefender_BUFF and not _GuardianofAncientKings_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _ShieldoftheRighteous);
		end

		if _EyeofTyr_RDY and _target_in_melee then
			tinsert(ConRO.SuggestedDefSpells, _EyeofTyr);
		end

		if _ArdentDefender_RDY and not _ArdentDefender_BUFF and not _GuardianofAncientKings_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _ArdentDefender);
		end

		if _GuardianofAncientKings_RDY and not _GuardianofAncientKings_BUFF and not _ArdentDefender_BUFF then
			if _GuardianofAncientKings_ID == ids.Glyph.Queen then
				tinsert(ConRO.SuggestedDefSpells, ids.Glyph.Queen);
			elseif _GuardianofAncientKings_ID == ids.Prot_Ability.GuardianofAncientKings then
				tinsert(ConRO.SuggestedDefSpells, _GuardianofAncientKings);
			end
		end
	return nil;
end

function ConRO.Paladin.Retribution(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ret_Ability, ids.Ret_Form, ids.Ret_Buff, ids.Ret_Debuff, ids.Ret_PetAbility, ids.Ret_PvPTalent, ids.Glyph;
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
	local _HolyPower, _HolyPower_Max = ConRO:PlayerPower('HolyPower');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _AvengingWrath, _AvengingWrath_RDY, _AvengingWrath_CD = ConRO:AbilityReady(Ability.AvengingWrath, timeShift);
		local _AvengingWrath_BUFF = ConRO:Aura(Buff.AvengingWrath, timeShift);
	local _BladeofJustice, _BladeofJustice_RDY = ConRO:AbilityReady(Ability.BladeofJustice, timeShift);
	local _BlindingLight, _BlindingLight_RDY = ConRO:AbilityReady(Ability.BlindingLight, timeShift);
	local _Consecration, _Consecration_RDY = ConRO:AbilityReady(Ability.Consecration, timeShift);
		local _Consecration_DEBUFF = ConRO:TargetAura(Debuff.Consecration, timeShift);
	local _Crusade, _Crusade_RDY, _Crusade_CD = ConRO:AbilityReady(Ability.Crusade, timeShift);
		local _Crusade_BUFF, _Crusade_COUNT	= ConRO:Aura(Buff.Crusade, timeShift);
	local _CrusaderStrike, _CrusaderStrike_RDY = ConRO:AbilityReady(Ability.CrusaderStrike, timeShift);
		local _CrusaderStrike_CHARGES = ConRO:SpellCharges(_CrusaderStrike);
		local _EmpyreanPower_BUFF = ConRO:Aura(Buff.EmpyreanPower, timeShift);
		local _TemplarStrike, _TemplarStrike_RDY = ConRO:AbilityReady(Ability.TemplarStrike, timeShift);
		local _TemplarSlash, _TemplarSlash_RDY = ConRO:AbilityReady(Ability.TemplarSlash, timeShift);
	local _DivineHammer, _DivineHammer_RDY = ConRO:AbilityReady(Ability.DivineHammer, timeShift);
	local _DivineStorm, _DivineStorm_RDY = ConRO:AbilityReady(Ability.DivineStorm, timeShift);
		local _DivinePurpose_BUFF = ConRO:Aura(Buff.DivinePurpose, timeShift);
	local _DivineToll, _DivineToll_RDY = ConRO:AbilityReady(Ability.DivineToll, timeShift);
	local _ExecutionSentence, _ExecutionSentence_RDY = ConRO:AbilityReady(Ability.ExecutionSentence, timeShift);
	local _FinalReckoning, _FinalReckoning_RDY = ConRO:AbilityReady(Ability.FinalReckoning, timeShift);
	local _HammerofJustice, _HammerofJustice_RDY = ConRO:AbilityReady(Ability.HammerofJustice, timeShift);
	local _HammerofWrath, _HammerofWrath_RDY = ConRO:AbilityReady(Ability.HammerofWrath, timeShift);
	local _Judgment, _Judgment_RDY = ConRO:AbilityReady(Ability.Judgment, timeShift);
		local _Judgment_DEBUFF = ConRO:TargetAura(Debuff.Judgment, timeShift);
	local _JusticarsVengeance, _JusticarsVengeance_RDY = ConRO:AbilityReady(Ability.JusticarsVengeance, timeShift);
	local _Rebuke, _Rebuke_RDY = ConRO:AbilityReady(Ability.Rebuke, timeShift);
	local _TemplarsVerdict, _TemplarsVerdict_RDY = ConRO:AbilityReady(Ability.TemplarsVerdict, timeShift);
		local _FinalVerdict, _FinalVerdict_RDY, _FinalVerdict_CD = ConRO:AbilityReady(Ability.FinalVerdict, timeShift);
		local _DivineArbiter_BUFF, _DivineArbiter_COUNT = ConRO:Aura(Buff.DivineArbiter, timeShift);
	local _WakeofAshes, _WakeofAshes_RDY = ConRO:AbilityReady(Ability.WakeofAshes, timeShift);
	local _WordofGlory, _WordofGlory_RDY = ConRO:AbilityReady(Ability.WordofGlory, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
	local _enemies_in_30yrds, _target_in_30yrds = ConRO:Targets(Ability.Judgment);
	local _can_execute = _Target_Percent_Health <= 20;

	if _DivinePurpose_BUFF then
		_HolyPower = 5;
	end

	if tChosen[Ability.FinalVerdict.talentID] then
		_TemplarsVerdict, _TemplarsVerdict_RDY = _FinalVerdict, _FinalVerdict_RDY;
	end

	if tChosen[Ability.DivineHammer.talentID] then
		_Consecration, _Consecration_RDY = _DivineHammer, _DivineHammer_RDY;
	end

--Warnings
	ConRO:Warnings("Select an Aura!", GetShapeshiftForm() == 0 and GetNumShapeshiftForms() >= 1);

--Indicators
	ConRO:AbilityInterrupt(_Rebuke, _Rebuke_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());

	ConRO:AbilityBurst(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and _HolyPower <= 4);
	ConRO:AbilityBurst(_Crusade, _Crusade_RDY and not _Crusade_BUFF and _HolyPower >= 3 and ConRO:BurstMode(_Crusade, 120));
	ConRO:AbilityBurst(_AvengingWrath, _AvengingWrath_RDY and not _AvengingWrath_BUFF and ConRO:BurstMode(_AvengingWrath));
	ConRO:AbilityBurst(_FinalReckoning, _FinalReckoning_RDY and (not tChosen[Ability.DivineAuxiliary.talentID] or (tChosen[Ability.DivineAuxiliary.talentID] and _HolyPower <= 2)) and ConRO:BurstMode(_FinalReckoning));
	ConRO:AbilityBurst(_ExecutionSentence, _ExecutionSentence_RDY and (not tChosen[Ability.DivineAuxiliary.talentID] or (tChosen[Ability.DivineAuxiliary.talentID] and _HolyPower <= 2)) and ConRO:BurstMode(_ExecutionSentence));

--Rotations
	for i = 1, 2, 1 do
		if not _in_combat then
			if _BladeofJustice_RDY and _HolyPower <= 3 then
				tinsert(ConRO.SuggestedSpells, _BladeofJustice);
				_BladeofJustice_RDY = false;
				_HolyPower = _HolyPower + 2;
			end

			if _Judgment_RDY and _HolyPower <= 4 then
				tinsert(ConRO.SuggestedSpells, _Judgment);
				_Judgment_RDY = false;
				_HolyPower = _HolyPower + 1;
			end

			if _ExecutionSentence_RDY and _HolyPower >= 3 and ConRO:FullMode(_ExecutionSentence) then
				tinsert(ConRO.SuggestedSpells, _ExecutionSentence);
				_ExecutionSentence_RDY = false;
				_HolyPower = _HolyPower - 3;
			end
		end

		if _Crusade_RDY and not _Crusade_BUFF and _HolyPower >= 3 and ConRO:FullMode(_Crusade, 120) then
			tinsert(ConRO.SuggestedSpells, _Crusade);
			_Crusade_RDY = false;
			_Crusade_BUFF = true;
		end

		if _AvengingWrath_RDY and not _AvengingWrath_BUFF and _HolyPower >= 3 and not tChosen[Ability.Crusade.talentID] and ConRO:FullMode(_AvengingWrath) then
			tinsert(ConRO.SuggestedSpells, _AvengingWrath);
			_AvengingWrath_RDY = false;
			_AvengingWrath_BUFF = true;
		end

		if _FinalReckoning_RDY and (not tChosen[Ability.DivineAuxiliary.talentID] or (tChosen[Ability.DivineAuxiliary.talentID] and _HolyPower <= 2)) and ConRO:FullMode(_FinalReckoning) then
			tinsert(ConRO.SuggestedSpells, _FinalReckoning);
			_FinalReckoning_RDY = false;
		end

		if _ExecutionSentence_RDY and (not tChosen[Ability.DivineAuxiliary.talentID] or (tChosen[Ability.DivineAuxiliary.talentID] and _HolyPower <= 2)) and ConRO:FullMode(_ExecutionSentence) then
			tinsert(ConRO.SuggestedSpells, _ExecutionSentence);
			_ExecutionSentence_RDY = false;
		end

		if _HolyPower <= _HolyPower_Max then
			if _WakeofAshes_RDY and _HolyPower <= 2 and ConRO:FullMode(_WakeofAshes) then
				tinsert(ConRO.SuggestedSpells, _WakeofAshes);
				_WakeofAshes_RDY = false;
				_HolyPower = _HolyPower + 3;
			end

			if _DivineToll_RDY and not _Judgment_DEBUFF and _target_in_30yrds and ConRO:FullMode(_DivineToll) then
				tinsert(ConRO.SuggestedSpells, _DivineToll);
				_DivineToll_RDY = false;
				_HolyPower = _HolyPower + _enemies_in_30yrds;
			end

			if _HammerofWrath_RDY and (_can_execute or _Crusade_BUFF or _AvengingWrath_BUFF) and ((ConRO_AutoButton:IsVisible() and (_enemies_in_melee <= 1)) or ConRO_SingleButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _HammerofWrath);
				_HammerofWrath_RDY = false;
				_HolyPower = _HolyPower + 1;
			end

			if _BladeofJustice_RDY and _HolyPower <= 3 then
				tinsert(ConRO.SuggestedSpells, _BladeofJustice);
				_BladeofJustice_RDY = false;
				_HolyPower = _HolyPower + 2;
			end

			if _Judgment_RDY and not _Judgment_DEBUFF and _HolyPower <= 3 then
				tinsert(ConRO.SuggestedSpells, _Judgment);
				_Judgment_RDY = false;
				_HolyPower = _HolyPower + 1;
			end

			if _Consecration_RDY and not tChosen[Ability.ConsecratedBlade.talentID] and (ConRO_AutoButton:IsVisible() and (_enemies_in_melee >= 2)) then
				tinsert(ConRO.SuggestedSpells, _Consecration);
				_Consecration_RDY = false;
			end

			if _DivineStorm_RDY and _EmpyreanPower_BUFF then
				tinsert(ConRO.SuggestedSpells, _DivineStorm);
				_EmpyreanPower_BUFF = false;
			end

			if _CrusaderStrike_RDY and not tChosen[Ability.TemplarStrikes.talentID] then
				tinsert(ConRO.SuggestedSpells, _CrusaderStrike);
				_CrusaderStrike_CHARGES = _CrusaderStrike_CHARGES -1;
				_HolyPower = _HolyPower + 1;
			end
		end

		if (ConRO_AutoButton:IsVisible() and (_enemies_in_melee >= 2)) and _DivineArbiter_COUNT < 25 then
			if _DivineStorm_RDY and _HolyPower >= 4 then
				tinsert(ConRO.SuggestedSpells, _DivineStorm);
				_HolyPower = _HolyPower - 3;
			end
		else
			if _TemplarsVerdict_RDY and _HolyPower >= 4 then
				tinsert(ConRO.SuggestedSpells, _TemplarsVerdict);
				_HolyPower = _HolyPower - 3;
			end
		end

		if _TemplarSlash_RDY then
			tinsert(ConRO.SuggestedSpells, _TemplarStrike);
			_TemplarSlash_RDY = false;
			_HolyPower = _HolyPower + 1;
		end

		if _TemplarStrike_RDY then
			tinsert(ConRO.SuggestedSpells, _TemplarStrike);
			_TemplarStrike_RDY = false;
			_HolyPower = _HolyPower + 1;
		end

		if _Judgment_RDY then
			tinsert(ConRO.SuggestedSpells, _Judgment);
			_Judgment_RDY = false;
			_HolyPower = _HolyPower + 1;
		end

		if _HammerofWrath_RDY and (_can_execute or _Crusade_BUFF or _AvengingWrath_BUFF) then
			tinsert(ConRO.SuggestedSpells, _HammerofWrath);
			_HammerofWrath_RDY = false;
			_HolyPower = _HolyPower + 1;
		end

		if _Consecration_RDY and _target_in_melee and not tChosen[Ability.ConsecratedBlade.talentID] then
			tinsert(ConRO.SuggestedSpells, _Consecration);
			_Consecration_RDY = false;
			_HolyPower = _HolyPower + 1;
		end
	end
	return nil;
end

function ConRO.Paladin.RetributionDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Ret_Ability, ids.Ret_Form, ids.Ret_Buff, ids.Ret_Debuff, ids.Ret_PetAbility, ids.Ret_PvPTalent, ids.Glyph;
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
	local _HolyPower, _HolyPower_Max = ConRO:PlayerPower('HolyPower');

--Abilities
	local _BlessingofProtection, _BlessingofProtection_RDY = ConRO:AbilityReady(Ability.BlessingofProtection, timeShift);
	local _DivineShield, _DivineShield_RDY = ConRO:AbilityReady(Ability.DivineShield, timeShift);
	local _FlashofLight, _FlashofLight_RDY = ConRO:AbilityReady(Ability.FlashofLight, timeShift);
		local _, _SelflessHealer_COUNT = ConRO:Aura(Buff.SelflessHealer, timeShift);
	local _LayonHands, _LayonHands_RDY = ConRO:AbilityReady(Ability.LayonHands, timeShift);
		local _Forbearance_BUFF = ConRO:Aura(Debuff.Forbearance, timeShift, 'HARMFUL');
	local _ShieldofVengeance, _ShieldofVengeance_RDY = ConRO:AbilityReady(Ability.ShieldofVengeance, timeShift);
	local _WordofGlory, _WordofGlory_RDY = ConRO:AbilityReady(Ability.WordofGlory, timeShift);

	local _JusticarsVengeance, _JusticarsVengeance_RDY = ConRO:AbilityReady(Ability.JusticarsVengeance, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations
		if _LayonHands_RDY and not _Forbearance_BUFF and _Player_Percent_Health <= 10 then
			tinsert(ConRO.SuggestedDefSpells, _LayonHands);
		end

		if _FlashofLight_RDY and _SelflessHealer_COUNT >= 4 and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _FlashofLight);
		end

		if _WordofGlory_RDY and _HolyPower >= 3 and _Player_Percent_Health <= 40 then
			tinsert(ConRO.SuggestedDefSpells, _WordofGlory);
		end

		if _JusticarsVengeance_RDY and _HolyPower >= 5 and _Player_Percent_Health <= 50 then
			tinsert(ConRO.SuggestedDefSpells, _JusticarsVengeance);
		end

		if _ShieldofVengeance_RDY then
			tinsert(ConRO.SuggestedDefSpells, _ShieldofVengeance);
		end

		if _DivineShield_RDY and not _Forbearance_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _DivineShield);
		end

		if _BlessingofProtection_RDY and not _Forbearance_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _BlessingofProtection);
		end
	return nil;
end
