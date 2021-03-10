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

function ConRO.Paladin.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Paladin.Holy(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _HolyPower, _HolyPower_Max																	= ConRO:PlayerPower('HolyPower');
	
--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _AvengingWrath, _AvengingWrath_RDY 															= ConRO:AbilityReady(ids.Holy_Ability.AvengingWrath, timeShift);
	local _AuraMastery, _AuraMastery_RDY 																= ConRO:AbilityReady(ids.Holy_Ability.AuraMastery, timeShift);
	local _BeaconofLight, _BeaconofLight_RDY 															= ConRO:AbilityReady(ids.Holy_Ability.BeaconofLight, timeShift);
	local _ConcentrationAura, _ConcentrationAura_RDY 													= ConRO:AbilityReady(ids.Holy_Ability.ConcentrationAura, timeShift);
		local _ConcentrationAura_FORM 																		= ConRO:Form(ids.Holy_Form.ConcentrationAura);		
	local _Consecration, _Consecration_RDY 																= ConRO:AbilityReady(ids.Holy_Ability.Consecration, timeShift);
	local _CrusaderAura, _CrusaderAura_RDY 																= ConRO:AbilityReady(ids.Holy_Ability.CrusaderAura, timeShift);
		local _CrusaderAura_FORM 																			= ConRO:Form(ids.Holy_Form.CrusaderAura);		
	local _CrusaderStrike, _CrusaderStrike_RDY				 											= ConRO:AbilityReady(ids.Holy_Ability.CrusaderStrike, timeShift);
		local _CrusaderStrike_CHARGES																		= ConRO:SpellCharges(ids.Holy_Ability.CrusaderStrike);
	local _DevotionAura, _DevotionAura_RDY 																= ConRO:AbilityReady(ids.Holy_Ability.DevotionAura, timeShift);
		local _DevotionAura_FORM 																			= ConRO:Form(ids.Holy_Form.DevotionAura);		
	local _HammerofJustice, _HammerofJustice_RDY 														= ConRO:AbilityReady(ids.Holy_Ability.HammerofJustice, timeShift);
	local _HammerofWrath, _HammerofWrath_RDY 															= ConRO:AbilityReady(ids.Holy_Ability.HammerofWrath, timeShift);
	local _HolyShock, _HolyShock_RDY 																	= ConRO:AbilityReady(ids.Holy_Ability.HolyShock, timeShift);
	local _Judgment, _Judgment_RDY	 																	= ConRO:AbilityReady(ids.Holy_Ability.Judgment, timeShift);
	local _LightofDawn, _LightofDawn_RDY	 															= ConRO:AbilityReady(ids.Holy_Ability.LightofDawn, timeShift);
	local _RetributionAura, _RetributionAura_RDY 														= ConRO:AbilityReady(ids.Holy_Ability.RetributionAura, timeShift);
		local _RetributionAura_FORM 																		= ConRO:Form(ids.Holy_Form.RetributionAura);
	local _WordofGlory, _WordofGlory_RDY	 															= ConRO:AbilityReady(ids.Holy_Ability.WordofGlory, timeShift);
		local _DivinePurpose_BUFF																			= ConRO:Aura(ids.Holy_Buff.DivinePurpose, timeShift);	

	local _AvengingCrusader, _AvengingCrusader_RDY 														= ConRO:AbilityReady(ids.Holy_Talent.AvengingCrusader, timeShift);
	local _BeaconofFaith, _BeaconofFaith_RDY 															= ConRO:AbilityReady(ids.Holy_Talent.BeaconofFaith, timeShift);
	local _BeaconofVirtue, _BeaconofVirtue_RDY 															= ConRO:AbilityReady(ids.Holy_Talent.BeaconofVirtue, timeShift);
	local _BlindingLight, _BlindingLight_RDY 															= ConRO:AbilityReady(ids.Holy_Talent.BlindingLight, timeShift);
	local _HolyAvenger, _HolyAvenger_RDY 																= ConRO:AbilityReady(ids.Holy_Talent.HolyAvenger, timeShift);
	local _HolyPrism, _HolyPrism_RDY 																	= ConRO:AbilityReady(ids.Holy_Talent.HolyPrism, timeShift);
	local _LightsHammer, _LightsHammer_RDY 																= ConRO:AbilityReady(ids.Holy_Talent.LightsHammer, timeShift);
	local _RuleofLaw, _RuleofLaw_RDY 																	= ConRO:AbilityReady(ids.Holy_Talent.RuleofLaw, timeShift);
	local _Seraphim, _Seraphim_RDY 																		= ConRO:AbilityReady(ids.Holy_Talent.Seraphim, timeShift);

	local _AshenHallow, _AshenHallow_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.AshenHallow, timeShift);
		local _AshenHallow_BUFF																				= ConRO:Aura(ids.Covenant_Buff.AshenHallow, timeShift);	
	local _BlessingoftheSeasons, _BlessingoftheSeasons_RDY 												= nil;
		local _BlessingofSpring, _BlessingofSpring_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofSpring, timeShift);
		local _BlessingofSummer, _BlessingofSummer_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofSummer, timeShift);
		local _BlessingofAutumn, _BlessingofAutumn_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofAutumn, timeShift);
		local _BlessingofWinter, _BlessingofWinter_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofWinter, timeShift);
	local _DivineToll, _DivineToll_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.DivineToll, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _VanquishersHammer, _VanquishersHammer_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.VanquishersHammer, timeShift);
		local _VanquishersHammer_BUFF																		= ConRO:Aura(ids.Covenant_Buff.VanquishersHammer, timeShift);	

		local _TheMagistratesJudgment_BUFF																	= ConRO:Aura(ids.Legendary_Buff.TheMagistratesJudgment, timeShift);	
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_execute																					= _Target_Percent_Health <= 20;

		if _TheMagistratesJudgment_BUFF then
			_HolyPower = _HolyPower + 1;
		end	
		
		if _DivinePurpose_BUFF then
			_HolyPower = 5;
		end
		
		if ConRO:FindCurrentSpell(_BlessingofSpring) then
			_BlessingoftheSeasons_RDY = _BlessingofSpring_RDY;
			_BlessingoftheSeasons = _BlessingofSpring;
		end
		if ConRO:FindCurrentSpell(_BlessingofSummer) then
			_BlessingoftheSeasons_RDY = _BlessingofSummer_RDY;
			_BlessingoftheSeasons = _BlessingofSummer;
		end
		if ConRO:FindCurrentSpell(_BlessingofAutumn) then
			_BlessingoftheSeasons_RDY = _BlessingofAutumn_RDY;
			_BlessingoftheSeasons = _BlessingofAutumn;
		end
		if ConRO:FindCurrentSpell(_BlessingofWinter) then
			_BlessingoftheSeasons_RDY = _BlessingofWinter_RDY;
			_BlessingoftheSeasons = _BlessingofWinter;
		end

--Warnings
	ConRO:Warnings("Select an Aura!", GetShapeshiftForm() == 0 and GetNumShapeshiftForms() >= 1);
	
--Indicators	
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityRaidBuffs(_BeaconofLight, _BeaconofLight_RDY and not ConRO:OneBuff(ids.Holy_Form.BeaconofLight));
	ConRO:AbilityRaidBuffs(_BeaconofFaith, _BeaconofFaith_RDY and not ConRO:OneBuff(ids.Holy_Form.BeaconofFaith));
	
	ConRO:AbilityBurst(_AvengingWrath, _AvengingWrath_RDY and ConRO:BurstMode(_AvengingWrath));
	ConRO:AbilityBurst(_LightsHammer, _LightsHammer_RDY and _is_Enemy and _HolyPower < 3 and ConRO:BurstMode(_LightsHammer));

	ConRO:AbilityRaidBuffs(_LightofDawn, _LightofDawn_RDY and _HolyPower >= 3 and not _VanquishersHammer_BUFF);
	ConRO:AbilityRaidBuffs(_WordofGlory, _WordofGlory_RDY and _HolyPower >= 3);
	
	ConRO:AbilityBurst(_AuraMastery, _AuraMastery_RDY and _in_combat);

	ConRO:AbilityBurst(_AshenHallow, _AshenHallow_RDY and ConRO:BurstMode(_AshenHallow));
	ConRO:AbilityBurst(_DivineToll, _DivineToll_RDY and _HolyPower <= 0 and ConRO:BurstMode(_DivineToll));

	ConRO:AbilityRaidBuffs(_BlessingofSpring, _BlessingofSpring_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofSpring));
	ConRO:AbilityRaidBuffs(_BlessingofSummer, _BlessingofSummer_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofSummer));
	ConRO:AbilityRaidBuffs(_BlessingofAutumn, _BlessingofAutumn_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofAutumn));
	ConRO:AbilityRaidBuffs(_BlessingofWinter, _BlessingofWinter_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofWinter));
	
--Rotations
	if _is_Enemy then
		if _HolyPower >= _HolyPower_Max then
			return nil;
		end

		if _HammerofWrath_RDY and (_AshenHallow_BUFF or _can_execute) then
			return _HammerofWrath;
		end
		
		if _VanquishersHammer_RDY then
			return _VanquishersHammer;
		end		

		if _DivineToll_RDY and _HolyPower <= 0 and ConRO:FullMode(_DivineToll) then
			return _DivineToll;
		end

		if _AshenHallow_RDY and ConRO:FullMode(_AshenHallow) then
			return _AshenHallow;
		end

		if _HolyPrism_RDY then
			return _HolyPrism;
		end
		
		if _HolyShock_RDY and _HolyPower <= 4 then
			return _HolyShock;
		end

		if _CrusaderStrike_RDY and _CrusaderStrike_CHARGES >= 2 and tChosen[ids.Holy_Talent.CrusadersMight] then
			return _CrusaderStrike;
		end
		
		if _HolyPower >= 3 then
			return nil;
		end		
		
		if _Judgment_RDY then
			return _Judgment;
		end
		
		if _LightsHammer_RDY and ConRO:FullMode(_LightsHammer) then
			return _LightsHammer;
		end
		
		if _CrusaderStrike_RDY and _CrusaderStrike_CHARGES >= 1 then
			return _CrusaderStrike;
		end
		
		if _Consecration_RDY then
			return _Consecration;
		end
	end	
return nil;
end

function ConRO.Paladin.HolyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _HolyPower, _HolyPower_Max																	= ConRO:PlayerPower('HolyPower');
	
--Abilities		
	local _BlessingofProtection, _BlessingofProtection_RDY 												= ConRO:AbilityReady(ids.Holy_Ability.BlessingofProtection, timeShift);
	local _DivineProtection, _DivineProtection_RDY 														= ConRO:AbilityReady(ids.Holy_Ability.DivineProtection, timeShift);
	local _DivineShield, _DivineShield_RDY 																= ConRO:AbilityReady(ids.Holy_Ability.DivineShield, timeShift);
	local _LayonHands, _LayonHands_RDY 																	= ConRO:AbilityReady(ids.Holy_Ability.LayonHands, timeShift);
		local _Forbearance_BUFF 																			= ConRO:Aura(ids.Holy_Debuff.Forbearance, timeShift, 'HARMFUL');

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _SummonSteward, _SummonSteward_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.SummonSteward, timeShift);
		local _PhialofSerenity, _PhialofSerenity_RDY, _, _, _PhialofSerenity_COUNT							= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);	
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end

	if _SummonSteward_RDY and not _in_combat and _PhialofSerenity_COUNT <= 0 then
		return _SummonSteward;
	end	
	
	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _LayonHands_RDY and not _Forbearance_BUFF and _Player_Percent_Health <= 10 then
		return _LayonHands;
	end
	
	if _DivineProtection_RDY then
		return _DivineProtection;
	end
	
	if _DivineShield_RDY and not _Forbearance_BUFF then
		return _DivineShield;
	elseif _BlessingofProtection_RDY and not _Forbearance_BUFF then 
		return _BlessingofProtection;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
	
return nil;
end

function ConRO.Paladin.Protection(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _HolyPower, _HolyPower_Max																	= ConRO:PlayerPower('HolyPower');	
	
--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local _AvengersShield, _AvengersShield_RDY															= ConRO:AbilityReady(ids.Prot_Ability.AvengersShield, timeShift);
		local _AvengersShield_enemies, _AvengersShield_RANGE												= ConRO:Targets(ids.Prot_Ability.AvengersShield);	
	local _AvengingWrath, _AvengingWrath_RDY, _AvengingWrath_CD											= ConRO:AbilityReady(ids.Prot_Ability.AvengingWrath, timeShift);
		local _AvengingWrath_BUFF																			= ConRO:Aura(ids.Prot_Buff.AvengingWrath, timeShift);	
	local _ConcentrationAura, _ConcentrationAura_RDY 													= ConRO:AbilityReady(ids.Prot_Ability.ConcentrationAura, timeShift);
		local _ConcentrationAura_FORM 																		= ConRO:Form(ids.Prot_Form.ConcentrationAura);		
	local _Consecration, _Consecration_RDY 																= ConRO:AbilityReady(ids.Prot_Ability.Consecration, timeShift);
		local _Consecration_FORM 																			= ConRO:Form(ids.Prot_Form.Consecration);	
	local _CrusaderAura, _CrusaderAura_RDY 																= ConRO:AbilityReady(ids.Prot_Ability.CrusaderAura, timeShift);
		local _CrusaderAura_FORM 																			= ConRO:Form(ids.Prot_Form.CrusaderAura);
	local _DevotionAura, _DevotionAura_RDY 																= ConRO:AbilityReady(ids.Prot_Ability.DevotionAura, timeShift);
		local _DevotionAura_FORM 																			= ConRO:Form(ids.Prot_Form.DevotionAura);
	local _HammeroftheRighteous, _HammeroftheRighteous_RDY 												= ConRO:AbilityReady(ids.Prot_Ability.HammeroftheRighteous, timeShift);
	local _HammerofWrath, _HammerofWrathRDY																= ConRO:AbilityReady(ids.Prot_Ability.HammerofWrath, timeShift);
	local _HandofReckoning, _HandofReckoning_RDY 														= ConRO:AbilityReady(ids.Prot_Ability.HandofReckoning, timeShift);
	local _Judgment, _Judgment_RDY 																		= ConRO:AbilityReady(ids.Prot_Ability.Judgment, timeShift);
	local _Rebuke, _Rebuke_RDY 																			= ConRO:AbilityReady(ids.Prot_Ability.Rebuke, timeShift);
	local _RetributionAura, _RetributionAura_RDY 														= ConRO:AbilityReady(ids.Prot_Ability.RetributionAura, timeShift);
		local _RetributionAura_FORM 																		= ConRO:Form(ids.Prot_Form.RetributionAura);
	local _ShieldoftheRighteous, _ShieldoftheRighteous_RDY								 				= ConRO:AbilityReady(ids.Prot_Ability.ShieldoftheRighteous, timeShift);
		local _ShieldoftheRighteous_BUFF																	= ConRO:Aura(ids.Prot_Buff.ShieldoftheRighteous, timeShift + 1);
		local _, _ShiningLight_COUNT, _ShiningLight_DUR														= ConRO:Aura(ids.Prot_Buff.ShiningLight_Stack, timeShift);		
		local _DivinePurpose_BUFF 																			= ConRO:Aura(ids.Prot_Buff.DivinePurpose, timeShift);
	local _WordofGlory, _WordofGlory_RDY								 								= ConRO:AbilityReady(ids.Prot_Ability.WordofGlory, timeShift);
	
	local _BlessedHammer, _BlessedHammer_RDY 															= ConRO:AbilityReady(ids.Prot_Talent.BlessedHammer, timeShift);
		local _BlessedHammer_CHARGES, _BlessedHammer_MaxCHARGES												= ConRO:SpellCharges(ids.Prot_Talent.BlessedHammer);			
		local _BlessedHammer_DEBUFF 																		= ConRO:TargetAura(ids.Prot_Debuff.BlessedHammer, timeShift);
	local _Seraphim, _Seraphim_RDY 																		= ConRO:AbilityReady(ids.Prot_Talent.Seraphim, timeShift);

	local _AshenHallow, _AshenHallow_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.AshenHallow, timeShift);
		local _AshenHallow_BUFF																				= ConRO:Aura(ids.Covenant_Buff.AshenHallow, timeShift);	
	local _BlessingoftheSeasons, _BlessingoftheSeasons_RDY 												= nil;
		local _BlessingofSpring, _BlessingofSpring_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofSpring, timeShift);
		local _BlessingofSummer, _BlessingofSummer_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofSummer, timeShift);
		local _BlessingofAutumn, _BlessingofAutumn_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofAutumn, timeShift);
		local _BlessingofWinter, _BlessingofWinter_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofWinter, timeShift);
	local _DivineToll, _DivineToll_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.DivineToll, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _VanquishersHammer, _VanquishersHammer_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.VanquishersHammer, timeShift);
		local _VanquishersHammer_BUFF																		= ConRO:Aura(ids.Covenant_Buff.VanquishersHammer, timeShift);	

		local _TheMagistratesJudgment_BUFF																	= ConRO:Aura(ids.Legendary_Buff.TheMagistratesJudgment, timeShift);	

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_execute																					= _Target_Percent_Health <= 20;

		if _TheMagistratesJudgment_BUFF then
			_HolyPower = _HolyPower + 1;
		end	

		if _DivinePurpose_BUFF then
			_HolyPower = 5;
		end

--Warnings
	ConRO:Warnings("Select an Aura!", GetShapeshiftForm() == 0 and GetNumShapeshiftForms() >= 1);
	
--Indicators
	ConRO:AbilityInterrupt(_AvengersShield, _AvengersShield_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_Rebuke, _Rebuke_RDY and not _AvengersShield_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityTaunt(_HandofReckoning, _HandofReckoning_RDY);
	
	ConRO:AbilityBurst(_AvengingWrath, _AvengingWrath_RDY and ConRO:BurstMode(_AvengingWrath));
	ConRO:AbilityBurst(_Seraphim, _Seraphim_RDY and _HolyPower >= 3 and (_AvengingWrath_BUFF or _AvengingWrath_CD >= 40 or ConRO:BurstMode(_AvengingWrath)) and ConRO:BurstMode(_Seraphim));

	ConRO:AbilityBurst(_AshenHallow, _AshenHallow_RDY and ConRO:BurstMode(_AshenHallow));
	ConRO:AbilityBurst(_DivineToll, _DivineToll_RDY and _HolyPower <= 0 and ConRO:BurstMode(_DivineToll));

	ConRO:AbilityRaidBuffs(_BlessingofSpring, _BlessingofSpring_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofSpring));
	ConRO:AbilityRaidBuffs(_BlessingofSummer, _BlessingofSummer_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofSummer));
	ConRO:AbilityRaidBuffs(_BlessingofAutumn, _BlessingofAutumn_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofAutumn));
	ConRO:AbilityRaidBuffs(_BlessingofWinter, _BlessingofWinter_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofWinter));
	
--Rotations	
	if not _in_combat then
		if _AvengersShield_RDY and (_enemies_in_melee >= 3 or _AvengersShield_enemies >= 3) then
			return _AvengersShield;
		end
		
		if _Judgment_RDY and not _target_in_melee then
			return _Judgment;
		end
	end

	if _AvengersShield_RDY and ConRO:Interrupt() then
		return _AvengersShield;
	end
	
	if _Consecration_RDY and not _Consecration_FORM then
		return _Consecration;
	end

	if _AshenHallow_RDY and currentSpell ~= _AshenHallow and ConRO:FullMode(_AshenHallow) then
		return _AshenHallow;
	end

	if _AvengingWrath_RDY and ConRO:FullMode(_AvengingWrath) then
		return _AvengingWrath;
	end

	if _Seraphim_RDY and _HolyPower >= 3 and (_AvengingWrath_BUFF or _AvengingWrath_CD >= 40 or ConRO:BurstMode(_AvengingWrath)) and ConRO:FullMode(_Seraphim) then
		return _Seraphim;
	end
	
	if _ShieldoftheRighteous_RDY and (_HolyPower >= 5 and not _ShieldoftheRighteous_BUFF) then
		return _ShieldoftheRighteous;
	end

	if _DivineToll_RDY and ConRO:FullMode(_DivineToll) then
		return _DivineToll;
	end
		
	if _AvengersShield_RDY and _enemies_in_melee >= 3 then
		return _AvengersShield;
	end

	if _VanquishersHammer_RDY then
		return _VanquishersHammer;
	end
	
	if _Judgment_RDY and ConRO.lastSpellId ~= _Judgment then
		return _Judgment;
	end
	
	if _HammerofWrathRDY then
		return _HammerofWrath;
	end	
	
	if _AvengersShield_RDY then
		return _AvengersShield;
	end
	
	if _BlessedHammer_RDY and (_BlessedHammer_CHARGES == _BlessedHammer_MaxCHARGES or not _BlessedHammer_DEBUFF) then
		return _BlessedHammer;
	elseif not tChosen[ids.Prot_Talent.BlessedHammer] and _HammeroftheRighteous_RDY then
		return _HammeroftheRighteous;
	end
return nil;
end

function ConRO.Paladin.ProtectionDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _HolyPower, _HolyPower_Max																	= ConRO:PlayerPower('HolyPower');
	
--Abilities	
	local _ArdentDefender, _ArdentDefender_RDY, _ArdentDefender_CD			 							= ConRO:AbilityReady(ids.Prot_Ability.ArdentDefender, timeShift);
		local _ArdentDefender_BUFF																			= ConRO:Aura(ids.Prot_Buff.ArdentDefender, timeShift);
	local _BlessingofProtection, _BlessingofProtection_RDY 												= ConRO:AbilityReady(ids.Prot_Ability.BlessingofProtection, timeShift);
	local _DivineShield, _DivineShield_RDY 																= ConRO:AbilityReady(ids.Prot_Ability.DivineShield, timeShift);
	local _GuardianofAncientKings, _GuardianofAncientKings_RDY 											= ConRO:AbilityReady(ids.Prot_Ability.GuardianofAncientKings, timeShift);
		local _GuardianofAncientKings_BUFF																	= ConRO:Aura(ids.Prot_Buff.GuardianofAncientKings, timeShift);
		local _GuardianofAncientKings_ID																	= select(7, GetSpellInfo("Guardian of Ancient Kings"));
	local _ShieldoftheRighteous, _ShieldoftheRighteous_RDY												= ConRO:AbilityReady(ids.Prot_Ability.ShieldoftheRighteous, timeShift);
		local _ShieldoftheRighteous_BUFF																	= ConRO:Aura(ids.Prot_Buff.ShieldoftheRighteous, timeShift + 1);
		local _ShiningLight_BUFF, _, _ShiningLight_DUR														= ConRO:Aura(ids.Prot_Buff.ShiningLight, timeShift);	
	local _LayonHands, _LayonHands_RDY 																	= ConRO:AbilityReady(ids.Prot_Ability.LayonHands, timeShift);
		local _Forbearance_BUFF 																			= ConRO:Aura(ids.Prot_Debuff.Forbearance, timeShift, 'HARMFUL');
	local _WordofGlory, _WordofGlory_RDY								 								= ConRO:AbilityReady(ids.Prot_Ability.WordofGlory, timeShift);
	
	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _SummonSteward, _SummonSteward_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.SummonSteward, timeShift);
		local _PhialofSerenity, _PhialofSerenity_RDY, _, _, _PhialofSerenity_COUNT							= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);	

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end
	
	if _SummonSteward_RDY and not _in_combat and _PhialofSerenity_COUNT <= 0 then
		return _SummonSteward;
	end	
	
	if _WordofGlory_RDY and ((_HolyPower >= 3 or _ShiningLight_BUFF) and _Player_Percent_Health <= 80) then
		return _WordofGlory;
	end
	
	if _LayonHands_RDY and not _Forbearance_BUFF and _Player_Percent_Health <= 10 then
		return _LayonHands;
	end

	if _ShieldoftheRighteous_RDY and not _ShieldoftheRighteous_BUFF and _HolyPower >= 3 and not _ArdentDefender_BUFF and not _GuardianofAncientKings_BUFF then
		return _ShieldoftheRighteous;
	end

	if _ArdentDefender_RDY and not _ArdentDefender_BUFF and not _GuardianofAncientKings_BUFF then
		return _ArdentDefender;
	end
			
	if _GuardianofAncientKings_RDY and not _GuardianofAncientKings_BUFF and not _ArdentDefender_BUFF then
		if _GuardianofAncientKings_ID == ids.Glyph.Queen then
			return ids.Glyph.Queen;
		elseif _GuardianofAncientKings_ID == ids.Prot_Ability.GuardianofAncientKings then
			return _GuardianofAncientKings;
		end
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end

function ConRO.Paladin.Retribution(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _HolyPower, _HolyPower_Max																	= ConRO:PlayerPower('HolyPower');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local _AvengingWrath, _AvengingWrath_RDY, _AvengingWrath_CD											= ConRO:AbilityReady(ids.Ret_Ability.AvengingWrath, timeShift);
		local _AvengingWrath_BUFF																			= ConRO:Aura(ids.Ret_Buff.AvengingWrath, timeShift);
	local _BladeofJustice, _BladeofJustice_RDY															= ConRO:AbilityReady(ids.Ret_Ability.BladeofJustice, timeShift);
	local _ConcentrationAura, _ConcentrationAura_RDY 													= ConRO:AbilityReady(ids.Ret_Ability.ConcentrationAura, timeShift);
		local _ConcentrationAura_FORM 																		= ConRO:Form(ids.Ret_Form.ConcentrationAura);
	local _Consecration, _Consecration_RDY																= ConRO:AbilityReady(ids.Ret_Ability.Consecration, timeShift);
	local _CrusaderAura, _CrusaderAura_RDY 																= ConRO:AbilityReady(ids.Ret_Ability.CrusaderAura, timeShift);
		local _CrusaderAura_FORM 																			= ConRO:Form(ids.Ret_Form.CrusaderAura);
	local _CrusaderStrike, _CrusaderStrike_RDY															= ConRO:AbilityReady(ids.Ret_Ability.CrusaderStrike, timeShift);
		local _CrusaderStrike_CHARGES																		= ConRO:SpellCharges(ids.Ret_Ability.CrusaderStrike);
		local _EmpyreanPower_BUFF																			= ConRO:Aura(ids.Ret_Buff.EmpyreanPower, timeShift);
		local _FiresofJustice_BUFF																			= ConRO:Aura(ids.Ret_Buff.FiresofJustice, timeShift);
	local _DevotionAura, _DevotionAura_RDY 																= ConRO:AbilityReady(ids.Ret_Ability.DevotionAura, timeShift);
		local _DevotionAura_FORM 																			= ConRO:Form(ids.Ret_Form.DevotionAura);
	local _DivineStorm, _DivineStorm_RDY 																= ConRO:AbilityReady(ids.Ret_Ability.DivineStorm, timeShift);
		local _DivinePurpose_BUFF 																			= ConRO:Aura(ids.Ret_Buff.DivinePurpose, timeShift);
	local _HammerofJustice, _HammerofJustice_RDY														= ConRO:AbilityReady(ids.Ret_Ability.HammerofJustice, timeShift);
	local _HammerofWrath, _HammerofWrath_RDY															= ConRO:AbilityReady(ids.Ret_Ability.HammerofWrath, timeShift);
	local _Judgment, _Judgment_RDY																		= ConRO:AbilityReady(ids.Ret_Ability.Judgment, timeShift);
		local _Judgment_DEBUFF 																				= ConRO:TargetAura(ids.Ret_Debuff.Judgment, timeShift);
	local _Rebuke, _Rebuke_RDY 																			= ConRO:AbilityReady(ids.Ret_Ability.Rebuke, timeShift);	
	local _RetributionAura, _RetributionAura_RDY 														= ConRO:AbilityReady(ids.Ret_Ability.RetributionAura, timeShift);
		local _RetributionAura_FORM 																		= ConRO:Form(ids.Ret_Form.RetributionAura);
	local _TemplarsVerdict, _TemplarsVerdict_RDY 														= ConRO:AbilityReady(ids.Ret_Ability.TemplarsVerdict, timeShift);
	local _WakeofAshes, _WakeofAshes_RDY																= ConRO:AbilityReady(ids.Ret_Ability.WakeofAshes, timeShift);
	local _WordofGlory, _WordofGlory_RDY																= ConRO:AbilityReady(ids.Ret_Ability.WordofGlory, timeShift);

	local _BlindingLight, _BlindingLight_RDY															= ConRO:AbilityReady(ids.Ret_Talent.BlindingLight, timeShift);	
	local _Crusade, _Crusade_RDY, _Crusade_CD															= ConRO:AbilityReady(ids.Ret_Talent.Crusade, timeShift);
		local _Crusade_BUFF, _Crusade_COUNT																	= ConRO:Aura(ids.Ret_Buff.Crusade, timeShift);
	local _ExecutionSentence, _ExecutionSentence_RDY													= ConRO:AbilityReady(ids.Ret_Talent.ExecutionSentence, timeShift);
	local _FinalReckoning, _FinalReckoning_RDY															= ConRO:AbilityReady(ids.Ret_Talent.FinalReckoning, timeShift);
	local _HolyAvenger, _HolyAvenger_RDY																= ConRO:AbilityReady(ids.Ret_Talent.HolyAvenger, timeShift);	
	local _JusticarsVengeance, _JusticarsVengeance_RDY													= ConRO:AbilityReady(ids.Ret_Talent.JusticarsVengeance, timeShift);
	local _Seraphim, _Seraphim_RDY																		= ConRO:AbilityReady(ids.Ret_Talent.Seraphim, timeShift);

	local _AshenHallow, _AshenHallow_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.AshenHallow, timeShift);
		local _AshenHallow_BUFF																				= ConRO:Aura(ids.Covenant_Buff.AshenHallow, timeShift);	
	local _BlessingoftheSeasons, _BlessingoftheSeasons_RDY 												= nil;
		local _BlessingofSpring, _BlessingofSpring_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofSpring, timeShift);
		local _BlessingofSummer, _BlessingofSummer_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofSummer, timeShift);
		local _BlessingofAutumn, _BlessingofAutumn_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofAutumn, timeShift);
		local _BlessingofWinter, _BlessingofWinter_RDY														= ConRO:AbilityReady(ids.Covenant_Ability.BlessingofWinter, timeShift);
	local _DivineToll, _DivineToll_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.DivineToll, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _VanquishersHammer, _VanquishersHammer_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.VanquishersHammer, timeShift);
		local _VanquishersHammer_BUFF																		= ConRO:Aura(ids.Covenant_Buff.VanquishersHammer, timeShift);

	local _FinalVerdict_EQUIPPED																		= ConRO:ItemEquipped(ids.Legendary.FinalVerdict_Back) or ConRO:ItemEquipped(ids.Legendary.FinalVerdict_Chest);
	local _FinalVerdict, _, _FinalVerdict_CD															= ConRO:AbilityReady(ids.Legendary_Ability.FinalVerdict, timeShift);
		local _TheMagistratesJudgment_BUFF																	= ConRO:Aura(ids.Legendary_Buff.TheMagistratesJudgment, timeShift);	

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _, _target_in_12yrds 																			= ConRO:Targets(ids.Ret_Ability.BladeofJustice);
	local _, _target_in_30yrds 																			= ConRO:Targets(ids.Ret_Ability.Judgment);	
	local _can_execute																					= _Target_Percent_Health <= 20;
		
		if _FiresofJustice_BUFF then
			_HolyPower = _HolyPower + 1;
		end

		if _TheMagistratesJudgment_BUFF then
			_HolyPower = _HolyPower + 1;
		end
		
		if _DivinePurpose_BUFF then
			_HolyPower = 5;
		end

		if _FinalVerdict_EQUIPPED then
			_TemplarsVerdict_RDY = _TemplarsVerdict_RDY and _FinalVerdict_CD <= 0;
			_TemplarsVerdict = _FinalVerdict;
		end

		if ConRO:AnimaPowerChosen(ids.Torghast_Powers.RingofUnburdening) then
			_HolyPower = _HolyPower + 1;
		end
		
--Warnings
	ConRO:Warnings("Select an Aura!", GetShapeshiftForm() == 0 and GetNumShapeshiftForms() >= 1);
	
--Indicators		
	ConRO:AbilityInterrupt(_Rebuke, _Rebuke_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and not _target_in_melee);
	
	ConRO:AbilityBurst(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and _HolyPower <= 4);	
	ConRO:AbilityBurst(_Crusade, _Crusade_RDY and not _Crusade_BUFF and _HolyPower >= 3 and ConRO:BurstMode(_Crusade, 120));
	ConRO:AbilityBurst(_AvengingWrath, _AvengingWrath_RDY and not _AvengingWrath_BUFF and ConRO:BurstMode(_AvengingWrath));
	ConRO:AbilityBurst(_HolyAvenger, _HolyAvenger_RDY and _HolyPower < 3 and ConRO:BurstMode(_HolyAvenger));
	ConRO:AbilityBurst(_Seraphim, _Seraphim_RDY and _HolyPower >= 3 and ConRO:BurstMode(_Seraphim));
	ConRO:AbilityBurst(_FinalReckoning, _FinalReckoning_RDY and _HolyPower >= 5 and _target_in_30yrds and ConRO:BurstMode(_FinalReckoning));
	ConRO:AbilityBurst(_ExecutionSentence, _ExecutionSentence_RDY and _HolyPower >= 3 and _target_in_30yrds and ConRO:BurstMode(_ExecutionSentence));

	ConRO:AbilityBurst(_AshenHallow, _AshenHallow_RDY and _HolyPower >= 3 and (_Crusade_RDY or (_AvengingWrath_RDY and not tChosen[ids.Ret_Talent.Crusade])) and currentSpell ~= _AshenHallow and _target_in_melee and ConRO:BurstMode(_AshenHallow));
	ConRO:AbilityBurst(_DivineToll, _DivineToll_RDY and _HolyPower <= 0 and _target_in_30yrds and ConRO:BurstMode(_DivineToll));
	
	ConRO:AbilityRaidBuffs(_BlessingofSpring, _BlessingofSpring_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofSpring));
	ConRO:AbilityRaidBuffs(_BlessingofSummer, _BlessingofSummer_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofSummer));
	ConRO:AbilityRaidBuffs(_BlessingofAutumn, _BlessingofAutumn_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofAutumn));
	ConRO:AbilityRaidBuffs(_BlessingofWinter, _BlessingofWinter_RDY and not ConRO:OneBuff(ids.Covenant_Buff.BlessingofWinter));
	
--Rotations	
	if not _in_combat then
		if _BladeofJustice_RDY and _HolyPower <= 3 then
			return _BladeofJustice;
		end
	end
	
	if _AshenHallow_RDY and _HolyPower >= 3 and (_Crusade_RDY or (_AvengingWrath_RDY and not tChosen[ids.Ret_Talent.Crusade])) and currentSpell ~= _AshenHallow and _target_in_melee and ConRO:FullMode(_AshenHallow) then
		return _AshenHallow; 
	end

	if _Crusade_RDY and not _Crusade_BUFF and _HolyPower >= 3 and ConRO:FullMode(_Crusade, 120) then
		return _Crusade;
	end

	if _AvengingWrath_RDY and not _AvengingWrath_BUFF and _HolyPower >= 3 and not tChosen[ids.Ret_Talent.Crusade] and ConRO:FullMode(_AvengingWrath) then
		return _AvengingWrath;
	end

	if _HolyAvenger_RDY and _HolyPower < 3 and ConRO:FullMode(_HolyAvenger) then
		return _HolyAvenger;
	end

	if _Seraphim_RDY and _HolyPower >= 3 and ConRO:FullMode(_Seraphim) then
		return _Seraphim;
	end

	if _Consecration_RDY and _target_in_melee and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) or ConRO_AoEButton:IsVisible()) then
		return _Consecration;
	end
	
	if _FinalReckoning_RDY and _HolyPower >= 5 and _target_in_30yrds and ConRO:FullMode(_FinalReckoning) then
		return _FinalReckoning;
	end
	
	if _ExecutionSentence_RDY and _HolyPower >= 3 and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee <= 2) or ConRO_SingleButton:IsVisible()) and _target_in_30yrds and ConRO:FullMode(_ExecutionSentence) then
		return _ExecutionSentence;
	end
	
	if _VanquishersHammer_RDY and _target_in_30yrds then
		return _VanquishersHammer;
	end	
	
	if (ConRO_AutoButton:IsVisible() and ((_enemies_in_melee >= 2 and not tChosen[ids.Ret_Talent.RighteousVerdict]) or _enemies_in_melee >= 3)) or ConRO_AoEButton:IsVisible() then
		if _DivineStorm_RDY and _HolyPower >= 5 and _target_in_melee then
			return _DivineStorm;
		end
	else
		if _TemplarsVerdict_RDY and _HolyPower >= 5 and _target_in_melee then
			return _TemplarsVerdict;
		end
	end
	
	if _DivineToll_RDY and not _Judgment_DEBUFF and _target_in_30yrds and ConRO:FullMode(_DivineToll) then
		return _DivineToll;
	end
	
	if _WakeofAshes_RDY and _HolyPower <= 2 and _target_in_12yrds and ConRO:FullMode(_WakeofAshes) then
		return _WakeofAshes;
	end
	
	if _HammerofWrath_RDY and _HolyPower <= 4 and _target_in_30yrds then
		return _HammerofWrath;
	end

	if _BladeofJustice_RDY and _HolyPower <= 3 and _target_in_12yrds then
		return _BladeofJustice;
	end	
	
	if _Judgment_RDY and _HolyPower <= 4 and _target_in_30yrds then
		return _Judgment;
	end

	if _DivineStorm_RDY and _target_in_melee and _EmpyreanPower_BUFF and not _Judgment_DEBUFF then
		return _DivineStorm;
	end
		
	if _CrusaderStrike_RDY and _target_in_melee and _CrusaderStrike_CHARGES >= 2 and _HolyPower <= 4 then
		return _CrusaderStrike;
	end

	if (ConRO_AutoButton:IsVisible() and ((_enemies_in_melee >= 2 and not tChosen[ids.Ret_Talent.RighteousVerdict]) or _enemies_in_melee >= 3)) or ConRO_AoEButton:IsVisible() then
		if _DivineStorm_RDY and _HolyPower >= 3 and _target_in_melee then
			return _DivineStorm;
		end
	else
		if _TemplarsVerdict_RDY and _HolyPower >= 3 and _target_in_melee then
			return _TemplarsVerdict;
		end
	end
	
	if _Consecration_RDY and _target_in_melee then
		return _Consecration;
	end
	
	if _CrusaderStrike_RDY and _HolyPower <= 4 and _target_in_melee then
		return _CrusaderStrike;
	end
	
	if not _target_in_melee then
		if _HammerofWrath_RDY and _target_in_30yrds then
			return _HammerofWrath;
		end

		if _BladeofJustice_RDY and _target_in_12yrds then
			return _BladeofJustice;
		end	
		
		if _Judgment_RDY and _target_in_30yrds then
			return _Judgment;
		end
	end
return nil;
end

function ConRO.Paladin.RetributionDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _HolyPower, _HolyPower_Max																	= ConRO:PlayerPower('HolyPower');

--Abilities
	local _BlessingofProtection, _BlessingofProtection_RDY 												= ConRO:AbilityReady(ids.Ret_Ability.BlessingofProtection, timeShift);
	local _DivineShield, _DivineShield_RDY 																= ConRO:AbilityReady(ids.Ret_Ability.DivineShield, timeShift);
	local _FlashofLight, _FlashofLight_RDY																= ConRO:AbilityReady(ids.Ret_Ability.FlashofLight, timeShift);	
		local _, _SelflessHealer_COUNT																		= ConRO:Aura(ids.Ret_Buff.SelflessHealer, timeShift);
	local _LayonHands, _LayonHands_RDY 																	= ConRO:AbilityReady(ids.Ret_Ability.LayonHands, timeShift);
		local _Forbearance_BUFF 																			= ConRO:Aura(ids.Ret_Debuff.Forbearance, timeShift, 'HARMFUL');
	local _ShieldofVengeance, _ShieldofVengeance_RDY 													= ConRO:AbilityReady(ids.Ret_Ability.ShieldofVengeance, timeShift);
	local _WordofGlory, _WordofGlory_RDY																= ConRO:AbilityReady(ids.Ret_Ability.WordofGlory, timeShift);
		
	local _EyeforanEye, _EyeforanEye_RDY 																= ConRO:AbilityReady(ids.Ret_Talent.EyeforanEye, timeShift);
	local _JusticarsVengeance, _JusticarsVengeance_RDY													= ConRO:AbilityReady(ids.Ret_Talent.JusticarsVengeance, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _SummonSteward, _SummonSteward_RDY															= ConRO:AbilityReady(ids.Covenant_Ability.SummonSteward, timeShift);
		local _PhialofSerenity, _PhialofSerenity_RDY, _, _, _PhialofSerenity_COUNT							= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);	
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations	
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end

	if _SummonSteward_RDY and not _in_combat and _PhialofSerenity_COUNT <= 0 then
		return _SummonSteward;
	end	
	
	if _LayonHands_RDY and not _Forbearance_BUFF and _Player_Percent_Health <= 10 then
		return ids.Ret_Ability.LayonHands;
	end

	if _FlashofLight_RDY and _SelflessHealer_COUNT >= 4 and _Player_Percent_Health <= 80 then
		return ids.Ret_Ability.FlashofLight;
	end
	
	if _WordofGlory_RDY and _HolyPower >= 3 and _Player_Percent_Health <= 40 then
		return ids.Ret_Ability.WordofGlory;
	end
	
	if _JusticarsVengeance_RDY and _HolyPower >= 5 and _Player_Percent_Health <= 50 then
		return ids.Ret_Talent.JusticarsVengeance;
	end
	
	if _ShieldofVengeance_RDY then
		return ids.Ret_Ability.ShieldofVengeance;
	end
	
	if _EyeforanEye_RDY then
		return ids.Ret_Talent.EyeforanEye;
	end	

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _DivineShield_RDY and not _Forbearance_BUFF then
		return ids.Ret_Ability.DivineShield;
	end
	
	if _BlessingofProtection_RDY and not _Forbearance_BUFF then 
		return ids.Ret_Ability.BlessingofProtection;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end
return nil;
end