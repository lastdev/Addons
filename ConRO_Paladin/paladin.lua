ConRO.Paladin = {};
ConRO.Paladin.CheckTalents = function()
end
ConRO.Paladin.CheckPvPTalents = function()
end
local ConRO_Paladin, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Paladin.CheckTalents;
	self.ModuleOnEnable = ConRO.Paladin.CheckPvPTalents;	
	if mode == 1 then
		self.Description = "Paladin [Holy - Healer]";
		self.NextSpell = ConRO.Paladin.Holy;
		self.ToggleHealer();
	end;
	if mode == 2 then
		self.Description = "Paladin [Protection - Tank]";
		self.NextSpell = ConRO.Paladin.Protection;
		self.ToggleHealer();
	end;
	if mode == 3 then
		self.Description = "Paladin [Retribution - Melee]";
		self.NextSpell = ConRO.Paladin.Retribution;
		self.ToggleDamage();
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Paladin.CheckTalents;
	self.ModuleOnEnable = ConRO.Paladin.CheckPvPTalents;	
	if mode == 1 then
		self.NextDef = ConRO.Paladin.HolyDef;
	end;
	if mode == 2 then
		self.NextDef = ConRO.Paladin.ProtectionDef;
	end;
	if mode == 3 then
		self.NextDef = ConRO.Paladin.RetributionDef;
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Paladin.Holy(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local avenge 											= ConRO:AbilityReady(ids.Paladin_Ability.AvengingWrath, timeShift);
	local auram 											= ConRO:AbilityReady(ids.Holy_Ability.AuraMastery, timeShift);
	local boLight 											= ConRO:AbilityReady(ids.Holy_Ability.BeaconofLight, timeShift);
	local judg	 											= ConRO:AbilityReady(ids.Paladin_Ability.JudgmentHoly, timeShift);
	local shock 											= ConRO:AbilityReady(ids.Holy_Ability.HolyShock, timeShift);
	local cstrike				 							= ConRO:AbilityReady(ids.Paladin_Ability.CrusaderStrike, timeShift);
		local csCharges											= ConRO:SpellCharges(ids.Paladin_Ability.CrusaderStrike);

	local boFaith 											= ConRO:AbilityReady(ids.Holy_Talent.BeaconofFaith, timeShift);
	
--Conditions	
	local isEnemy 											= ConRO:TarHostile()
	local Close 											= CheckInteractDistance("target", 3);
	
--Indicators	
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	
	ConRO:AbilityBurst(ids.Paladin_Ability.AvengingWrath, avenge);
	ConRO:AbilityBurst(ids.Holy_Ability.AuraMastery, auram);

	ConRO:AbilityRaidBuffs(ids.Holy_Ability.BeaconofLight, boLight and not ConRO:OneBuff(ids.Holy_Form.BeaconofLight));
	ConRO:AbilityRaidBuffs(ids.Holy_Talent.BeaconofFaith, boFaith and not ConRO:OneBuff(ids.Holy_Form.BeaconofFaith));
	
--Rotations
	if isEnemy then
		if judg then
			return ids.Paladin_Ability.JudgmentHoly;
		end
		
		if shock then
			return ids.Holy_Ability.HolyShock;
		end
		
		if cstrike and csCharges >= 1 then
			return ids.Paladin_Ability.CrusaderStrike;
		end
	end	
	return nil;
end

function ConRO.Paladin.HolyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities		
	local loh 												= ConRO:AbilityReady(ids.Paladin_Ability.LayonHands, timeShift);
	local dish 												= ConRO:AbilityReady(ids.Paladin_Ability.DivineShield, timeShift);
	local bop 												= ConRO:AbilityReady(ids.Paladin_Ability.BlessingofProtection, timeShift);
	
	local forb 												= ConRO:Aura(ids.Paladin_Debuff.Forbearance, timeShift, 'HARMFUL');

--Conditions
	local playerPh 											= ConRO:PercentHealth('player');

--Rotations
	if loh and not forb and playerPh <= 10 then
		return ids.Paladin_Ability.LayonHands;
	end
	
	if dish and not forb then
		return ids.Paladin_Ability.DivineShield;
	elseif bop and not forb then 
		return ids.Paladin_Ability.BlessingofProtection;
	end
	
	return nil;
end

function ConRO.Paladin.Protection(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local hofreck 											= ConRO:AbilityReady(ids.Paladin_Ability.HandofReckoning, timeShift);
	local rebuke 											= ConRO:AbilityReady(ids.Prot_Ability.Rebuke, timeShift);
	local judge 											= ConRO:AbilityReady(ids.Paladin_Ability.JudgmentProt, timeShift);
	local ashield											= ConRO:AbilityReady(ids.Prot_Ability.AvengersShield, timeShift);
	local avenge 											= ConRO:AbilityReady(ids.Paladin_Ability.AvengingWrath, timeShift);
	local sotr								 				= ConRO:AbilityReady(ids.Paladin_Ability.ShieldoftheRighteous, timeShift);
	local con 												= ConRO:AbilityReady(ids.Paladin_Ability.Consecration, timeShift);
	local hotr 												= ConRO:AbilityReady(ids.Prot_Ability.HammeroftheRighteous, timeShift);
	
	local bh 												= ConRO:AbilityReady(ids.Prot_Talent.BlessedHammer, timeShift);
		local bhCharges, bhMaxCharges							= ConRO:SpellCharges(ids.Prot_Talent.BlessedHammer);			
	local sera 												= ConRO:AbilityReady(ids.Prot_Talent.Seraphim, timeShift);
	
	local conBuff 											= ConRO:Form(ids.Paladin_Form.Consecration);
	
	local bhDebuff 											= ConRO:TargetAura(ids.Prot_Debuff.BlessedHammer, timeShift);

--Conditions
	local incombat 											= UnitAffectingCombat('player');
	local inRange 											= ConRO:IsSpellInRange(GetSpellInfo(ids.Prot_Ability.Rebuke), 'target');
	local Close 											= CheckInteractDistance("target", 3);
	
--Indicators
	ConRO:AbilityInterrupt(ids.Prot_Ability.AvengersShield, ashield and ConRO:Interrupt());
	ConRO:AbilityInterrupt(ids.Prot_Ability.Rebuke, rebuke and not ashield and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	
	ConRO:AbilityTaunt(ids.Paladin_Ability.HandofReckoning, hofreck);
	
	ConRO:AbilityBurst(ids.Paladin_Ability.AvengingWrath, avenge);
	ConRO:AbilityBurst(ids.Prot_Talent.Seraphim, sera and sotrCharges >= 2);

--Rotations	
	if not inRange and judge then
		return ids.Paladin_Ability.JudgmentProt;
	end
	
	if con and not conBuff then
		return ids.Paladin_Ability.Consecration;
	end
	
	if judge then
		return ids.Paladin_Ability.JudgmentProt;
	end
	
	if ashield then
		return ids.Prot_Ability.AvengersShield;
	end
	
	if bh and (bhCharges == bhMaxCharges or not bhDebuff) then
		return ids.Prot_Talent.BlessedHammer;
	elseif not tChosen[ids.Prot_Talent.BlessedHammer] and hotr then
		return ids.Prot_Ability.HammeroftheRighteous;
	end
	return nil;
end

function ConRO.Paladin.ProtectionDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities	
	local ad, adCD			 								= ConRO:AbilityReady(ids.Prot_Ability.ArdentDefender, timeShift);
	local goak 												= ConRO:AbilityReady(ids.Prot_Ability.GuardianofAncientKings, timeShift);
	local sotr, sotrCD										= ConRO:AbilityReady(ids.Paladin_Ability.ShieldoftheRighteous, timeShift);
	local dish 												= ConRO:AbilityReady(ids.Paladin_Ability.DivineShield, timeShift);
	local bop 												= ConRO:AbilityReady(ids.Paladin_Ability.BlessingofProtection, timeShift);
	local loh 												= ConRO:AbilityReady(ids.Paladin_Ability.LayonHands, timeShift);
		
	local forb 												= ConRO:Aura(ids.Paladin_Debuff.Forbearance, timeShift, 'HARMFUL');

	local goakID											= select(7, GetSpellInfo("Guardian of Ancient Kings"));
	
--Conditions	
	local inRange 											= ConRO:IsSpellInRange(GetSpellInfo(ids.Paladin_Ability.ShieldoftheRighteous), 'target');
	local playerPh 											= ConRO:PercentHealth('player');

--Rotations
	if loh and not forb and playerPh <= 10 then
		return ids.Paladin_Ability.LayonHands;
	end

	if sotr then
		return ids.Paladin_Ability.ShieldoftheRighteous;
	end

	if ad then
		return ids.Prot_Ability.ArdentDefender;
	end
			
	if goak then
		if goakID == ids.Glyph.Queen then
			return ids.Glyph.Queen;
		elseif goakID == ids.Prot_Ability.GuardianofAncientKings then
			return ids.Prot_Ability.GuardianofAncientKings;
		end
	end

	return nil;
end

function ConRO.Paladin.Retribution(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources	
	local hpower 											= UnitPower ('player', Enum.PowerType.HolyPower);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local con												= ConRO:AbilityReady(ids.Paladin_Ability.Consecration, timeShift);
	local cstrike, _, _, _, meleeRANGE						= ConRO:AbilityReady(ids.Paladin_Ability.CrusaderStrike, timeShift);
		local csCharges											= ConRO:SpellCharges(ids.Paladin_Ability.CrusaderStrike);
	local hofw, _, _, _, hofwRANGE							= ConRO:AbilityReady(ids.Paladin_Ability.HammerofWrath, timeShift);
		
	local temp 												= ConRO:AbilityReady(ids.Ret_Ability.TemplarsVerdict, timeShift);
	local dstorm 											= ConRO:AbilityReady(ids.Ret_Ability.DivineStorm, timeShift);
	local blade, _, _, _, bladeRANGE						= ConRO:AbilityReady(ids.Ret_Ability.BladeofJustice, timeShift);
	local judge, _, _, _, judgeRANGE						= ConRO:AbilityReady(ids.Paladin_Ability.Judgment, timeShift);
		local jDebuff 											= ConRO:TargetAura(ids.Paladin_Debuff.Judgment, timeShift);
	local awrath, awCD										= ConRO:AbilityReady(ids.Paladin_Ability.AvengingWrath, timeShift);
		local awBuff											= ConRO:Aura(ids.Paladin_Buff.AvengingWrath, timeShift);
	local rebuke 											= ConRO:AbilityReady(ids.Ret_Ability.Rebuke, timeShift);	
	local washes											= ConRO:AbilityReady(ids.Ret_Ability.WakeofAshes, timeShift);
	
	local cru, cruCD										= ConRO:AbilityReady(ids.Ret_Talent.Crusade, timeShift);
		local cBuff, cCount										= ConRO:Aura(ids.Ret_Buff.Crusade, timeShift);
	local jveng												= ConRO:AbilityReady(ids.Ret_Talent.JusticarsVengeance, timeShift);
	local esent, _, _, _, esentRANGE						= ConRO:AbilityReady(ids.Ret_Talent.ExecutionSentence, timeShift);

		
	local dpBuff 											= ConRO:Aura(ids.Ret_Buff.DivinePurpose, timeShift);
	local fofjBuff											= ConRO:Aura(ids.Ret_Buff.FiresofJustice, timeShift);

	local epAzBuff											= ConRO:Aura(ids.AzTraitBuff.EmpyreanPower, timeShift);

	local azEssence_BloodoftheEnemy							= ConRO:AbilityReady(ids.AzEssence.BloodoftheEnemy, timeShift);
	local azEssence_ConcentratedFlame, _, _, _, cfAzRANGE	= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	local azEssence_GuardianofAzeroth						= ConRO:AbilityReady(ids.AzEssence.GuardianofAzeroth, timeShift);
	local azEssence_MemoryofLucidDream						= ConRO:AbilityReady(ids.AzEssence.MemoryofLucidDream, timeShift);
	local azEssence_ReapingFlames, _, _, _, rpAzRANGE		= ConRO:AbilityReady(ids.AzEssence.ReapingFlames, timeShift);
	
--Conditions
	local targetPh 											= ConRO:PercentHealth('target');
	local Close 											= CheckInteractDistance("target", 3);
	local canExe 											= targetPh < 20;
	local tarInMelee										= ConRO:Targets(ids.Ret_Ability.Rebuke);	
	
	if fofjBuff then
		hpower = hpower + 1;
	end
	
	if dpBuff then
		hpower = 5;
	end	
	
--Indicators		
	ConRO:AbilityInterrupt(ids.Ret_Ability.Rebuke, rebuke and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	
	ConRO:AbilityBurst(ids.Ret_Talent.Crusade, cru and not cBuff and hpower >= 3 and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Paladin_Ability.AvengingWrath, awrath and not awBuff and ConRO_BurstButton:IsVisible());
	
--Rotations	
	if azEssence_GuardianofAzeroth and (((awrath or awCD >= 10) and not tChosen[ids.Ret_Talent.Crusade]) or (((cBuff and cCount >= 10) or cruCD >= 10) and tChosen[ids.Ret_Talent.Crusade])) then
		return ids.AzEssence.GuardianofAzeroth;
	end
	
	if cru and not cBuff and hpower >= 3 and ConRO_FullButton:IsVisible() then
		return ids.Ret_Talent.Crusade;
	end

	if awrath and not awBuff and not tChosen[ids.Ret_Talent.Crusade] and ConRO_FullButton:IsVisible() then
		return ids.Paladin_Ability.AvengingWrath;
	end

	if azEssence_MemoryofLucidDream and hpower <= 3 and (awBuff or (cBuff and cCount >= 10)) then
		return ids.AzEssence.MemoryofLucidDream;
	end

	if azEssence_BloodoftheEnemy and (awBuff or (cBuff and cCount >= 10)) then
		return ids.AzEssence.BloodoftheEnemy;
	end
	
	if esent and esentRANGE and hpower >= 3 then
		return ids.Ret_Talent.ExecutionSentence;
	end

	if dstorm and meleeRANGE and epAzBuff and not jDebuff then
		return ids.Ret_Ability.DivineStorm;
	end
	
	if (ConRO_AutoButton:IsVisible() and ((tarInMelee >= 2 and not tChosen[ids.Ret_Talent.RighteousVerdict]) or tarInMelee >= 3)) or ConRO_AoEButton:IsVisible() then
		if dstorm and meleeRANGE and hpower >= 5 then
			return ids.Ret_Ability.DivineStorm;
		end
	else
		if temp and meleeRANGE and hpower >= 5 then
			return ids.Ret_Ability.TemplarsVerdict;
		end
	end	
	
	if washes and bladeRANGE and hpower == 0 and ((tChosen[ids.Ret_Talent.Crusade] and (cBuff or cruCD >= 45)) or (not tChosen[ids.Ret_Talent.Crusade] and (awBuff or awCD >= 45))) then
		return ids.Ret_Ability.WakeofAshes;
	end	
	
	if azEssence_ReapingFlames and rpAzRANGE then
		return ids.AzEssence.ReapingFlames;
	end
	
	if blade and bladeRANGE and hpower <= 3 then
		return ids.Ret_Ability.BladeofJustice;
	end	
	
	if washes and bladeRANGE and hpower == 1 and ((tChosen[ids.Ret_Talent.Crusade] and (cBuff or cruCD >= 45)) or (not tChosen[ids.Ret_Talent.Crusade] and (awBuff or awCD >= 45))) then
		return ids.Ret_Ability.WakeofAshes;
	end	

	if judge and judgeRANGE and hpower <= 4 then
		return ids.Paladin_Ability.Judgment;
	end
	
	if hofw and hofwRANGE and hpower <= 4 and (canExe or cBuff or awBuff) then
		return ids.Paladin_Ability.HammerofWrath;
	end
	
	if con and meleeRANGE and hpower <= 4 then
		return ids.Paladin_Ability.Consecration;
	end
		
	if cstrike and meleeRANGE and hpower <= 4 then
		return ids.Paladin_Ability.CrusaderStrike;
	end

	if (ConRO_AutoButton:IsVisible() and ((tarInMelee >= 2 and not tChosen[ids.Ret_Talent.RighteousVerdict]) or tarInMelee >= 3)) or ConRO_AoEButton:IsVisible() then
		if dstorm and meleeRANGE and hpower >= 3 then
			return ids.Ret_Ability.DivineStorm;
		end
	else
		if temp and meleeRANGE and hpower >= 3 then
			return ids.Ret_Ability.TemplarsVerdict;
		end
	end
	
	if azEssence_ConcentratedFlame and cfAzRANGE then
		return ids.AzEssence.ConcentratedFlame;
	end	
	
	if arctorrent and meleeRANGE and hpower <= 4 then
		return ids.Racial.ArcaneTorrent;
	end	
end

function ConRO.Paladin.RetributionDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources	
	local hpower 											= UnitPower ('player', Enum.PowerType.HolyPower);

--Abilities
	local sov 												= ConRO:AbilityReady(ids.Ret_Ability.ShieldofVengeance, timeShift);
	local dish 												= ConRO:AbilityReady(ids.Paladin_Ability.DivineShield, timeShift);
	local bop 												= ConRO:AbilityReady(ids.Paladin_Ability.BlessingofProtection, timeShift);
	local loh 												= ConRO:AbilityReady(ids.Paladin_Ability.LayonHands, timeShift);
		local forb 												= ConRO:Aura(ids.Paladin_Debuff.Forbearance, timeShift, 'HARMFUL')	
		
	local efoe 												= ConRO:AbilityReady(ids.Ret_Talent.EyeforanEye, timeShift);
	local jveng												= ConRO:AbilityReady(ids.Ret_Talent.JusticarsVengeance, timeShift);
	
--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');

--Rotations	
	if loh and not forb and playerPh <= 10 then
		return ids.Paladin_Ability.LayonHands;
	end
	
	if jveng and hpower >= 5 and playerPh <= 50 then
		return ids.Ret_Talent.JusticarsVengeance;
	end
	
	if sov then
		return ids.Ret_Ability.ShieldofVengeance;
	end
	
	if efoe then
		return ids.Ret_Talent.EyeforanEye;
	end	
	
	if dish and not forb then
		return ids.Paladin_Ability.DivineShield;
	end
	
	if bop and not forb then 
		return ids.Paladin_Ability.BlessingofProtection;
	end
	
	return nil;
end
