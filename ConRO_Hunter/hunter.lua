ConRO.Hunter = {};
ConRO.Hunter.CheckTalents = function()
end
local ConRO_Hunter, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Hunter.CheckTalents;
	self.ModuleOnEnable = ConRO.Hunter.CheckPvPTalents;
	if mode == 1 then
		self.Description = 'Hunter [Beast Mastery - Ranged]';
		self.NextSpell = ConRO.Hunter.BeastMastery;
		self.ToggleDamage();
	end;
	if mode == 2 then
		self.Description = 'Hunter [Marksmanship - Ranged]';
		self.NextSpell = ConRO.Hunter.Marksmanship;
		self.ToggleDamage();
	end;
	if mode == 3 then
		self.Description = 'Hunter [Survival - Melee]';
		self.NextSpell = ConRO.Hunter.Survival;
		self.ToggleDamage();
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Hunter.CheckTalents;
	self.ModuleOnEnable = ConRO.Hunter.CheckPvPTalents;
	if mode == 1 then
		self.NextDef = ConRO.Hunter.BeastMasteryDef;
	end;
	if mode == 2 then
		self.NextDef = ConRO.Hunter.MarksmanshipDef;
	end;
	if mode == 3 then
		self.NextDef = ConRO.Hunter.SurvivalDef;
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Hunter.BeastMastery(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources
	local focus 											= UnitPower('player', Enum.PowerType.Focus);
	local focusMax 											= UnitPowerMax('player', Enum.PowerType.Focus);
	local raidHaste, raidSated 								= ConRO:Heroism();

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local aShotRDY 											= ConRO:AbilityReady(ids.BM_Ability.ArcaneShot, timeShift);	
	local cPetRDY 											= ConRO:AbilityReady(ids.BM_Ability.CommandPet, timeShift);
	local hMarkRDY 											= ConRO:AbilityReady(ids.BM_Ability.HuntersMark, timeShift);
		local hmDebuff 											= ConRO:PersistentDebuff(ids.BM_Debuff.HuntersMark);	
	local kShotRDY											= ConRO:AbilityReady(ids.BM_Ability.KillShot, timeShift);
	local tranqShotRDY										= ConRO:AbilityReady(ids.BM_Ability.TranquilizingShot, timeShift);	
	local aotw, aotwCD										= ConRO:AbilityReady(ids.BM_Ability.AspectoftheWild, timeShift);
		local aotwBuff 											= ConRO:Aura(ids.BM_Buff.AspectoftheWild, timeShift);	
	local bshot, bsCD										= ConRO:AbilityReady(ids.BM_Ability.BarbedShot, timeShift);
		local bsCharges, bsMaxCharges, bsCCD, bsMCCD			= ConRO:SpellCharges(ids.BM_Ability.BarbedShot);
		local frenzyBuff, frenzyCount, frenzyDUR				= ConRO:UnitAura(ids.BM_Buff.Frenzy, timeShift, 'pet');
	local bw, bwCD											= ConRO:AbilityReady(ids.BM_Ability.BestialWrath, timeShift);
		local bwBuff 											= ConRO:Aura(ids.BM_Buff.BestialWrath, timeShift);		
	local cobra 											= ConRO:AbilityReady(ids.BM_Ability.CobraShot, timeShift);		
	local cshot 											= ConRO:AbilityReady(ids.BM_Ability.CounterShot, timeShift);	
	local kc, kcCD	 										= ConRO:AbilityReady(ids.BM_Ability.KillCommand, timeShift);
	local multi 											= ConRO:AbilityReady(ids.BM_Ability.MultiShot, timeShift);
		local bcBuff, _, bcBuffDur 								= ConRO:Aura(ids.BM_Buff.BeastCleave, timeShift + 1);

	local db, dbCD	 										= ConRO:AbilityReady(ids.BM_Talent.DireBeast, timeShift);		
	local stamp 											= ConRO:AbilityReady(ids.BM_Talent.Stampede, timeShift);	
	local amoc 												= ConRO:AbilityReady(ids.BM_Talent.AMurderofCrows, timeShift);	
	local chimaera 											= ConRO:AbilityReady(ids.BM_Talent.ChimaeraShot, timeShift);
	local barrage 											= ConRO:AbilityReady(ids.BM_Talent.Barrage, timeShift);
	local bshedRDY 											= ConRO:AbilityReady(ids.BM_Talent.Bloodshed, timeShift);

	local azChosen_DanceofDeath, azCount_DanceofDeath		= ConRO:AzPowerChosen(ids.AzTrait.DanceofDeath);	
		local dodAzBuff											= ConRO:Aura(ids.AzTraitBuff.DanceofDeath, timeShift);

	local azEssence_BloodoftheEnemy							= ConRO:AbilityReady(ids.AzEssence.BloodoftheEnemy, timeShift);
	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);	
	local azEssence_FocusedAzeriteBeam						= ConRO:AbilityReady(ids.AzEssence.FocusedAzeriteBeam, timeShift);	
	local azEssence_GuardianofAzeroth						= ConRO:AbilityReady(ids.AzEssence.GuardianofAzeroth, timeShift);	
	local azEssence_ReapingFlames							= ConRO:AbilityReady(ids.AzEssence.ReapingFlames, timeShift);
	
--Conditions	
	local targetPh 											= ConRO:PercentHealth('target');
	local summoned 											= ConRO:CallPet();
	local assist 											= ConRO:PetAssist();
	local Close 											= CheckInteractDistance("target", 3);
	local incombat 											= UnitAffectingCombat('player');
	
--Indicators
	ConRO:AbilityInterrupt(ids.BM_Ability.CounterShot, cshot and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityPurge(ids.BM_Ability.TranquilizingShot, tranqShotRDY and ConRO:Purgable());	
	
	ConRO:AbilityBurst(ids.BM_Talent.Stampede, stamp and ((bwBuff and aotwBuff) or (aotwBuff and not incombat)) and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.BM_Ability.AspectoftheWild, aotw and (not ConRO:AzPowerChosen(ids.AzTrait.PrimalInstincts) or (ConRO:AzPowerChosen(ids.AzTrait.PrimalInstincts) and bsCharges < bsMaxCharges)) and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.BM_Ability.BestialWrath, bw and (aotwBuff or aotwCD > 20) and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.AzEssence.FocusedAzeriteBeam, azEssence_FocusedAzeriteBeam and bcBuff and CheckInteractDistance("target", 1) and ConRO_SingleButton:IsVisible());	
	ConRO:AbilityBurst(ids.AzEssence.ReapingFlames, azEssence_ReapingFlames and targetPh > 20 and targetPh < 80);	
	
--Warnings
	if not summoned then
		UIErrorsFrame:AddMessage("Call your pet!!!", 1.0, 0.0, 0.0, 10);
	end
	
--Rotations
	if not incombat then
		if aotw and (bw or bwCD > 15) and ConRO_FullButton:IsVisible() then
			if not ConRO:AzPowerChosen(ids.AzTrait.PrimalInstincts) then
				return ids.BM_Ability.AspectoftheWild;
			elseif ConRO:AzPowerChosen(ids.AzTrait.PrimalInstincts) and bsCharges <= 0 then
				return ids.BM_Ability.AspectoftheWild;
			end
		end
		
		if bshot and bsCharges >= 1 and tChosen[ids.BM_Talent.ScentofBlood] and bw and not bwBuff and (ConRO:AzPowerChosen(ids.AzTrait.PrimalInstincts) or (aotwBuff or aotwCD > 15)) and ConRO_FullButton:IsVisible() then
			return ids.BM_Ability.BarbedShot;
		end		
		
		if bw and not bwBuff and (ConRO:AzPowerChosen(ids.AzTrait.PrimalInstincts) or (aotwBuff or aotwCD > 15)) and ConRO_FullButton:IsVisible() then
			return ids.BM_Ability.BestialWrath;
		end;
		
		if bshot and (not frenzyBuff or (frenzyBuff and frenzyDUR < 1.5)) then
			return ids.BM_Ability.BarbedShot;
		end

		if chimaera and ConRO_AoEButton:IsVisible() then
			return ids.BM_Talent.ChimaeraShot;
		end
	
		if kc then
			return ids.BM_Ability.KillCommand;
		end
	end	

	if azEssence_GuardianofAzeroth and bwBuff and aotwBuff then
		return ids.AzEssence.GuardianofAzeroth;
	end
	
	if aotw and bwBuff and ConRO:AzPowerChosen(ids.AzTrait.PrimalInstincts) and bsCharges <= 0 and ConRO_FullButton:IsVisible() then
		return ids.BM_Ability.AspectoftheWild;
	end	
		
	if bshot and (bsCharges == 2 or (bsCharges == 1 and bsCCD <= 2) or (frenzyBuff and frenzyDUR < 2 and frenzyDUR > .25)) then
		return ids.BM_Ability.BarbedShot;
	end

	if multi and not bcBuff and ConRO_AoEButton:IsVisible() then
		return ids.BM_Ability.MultiShot;
	end

	if bshedRDY then
		return ids.BM_Talent.Bloodshed;
	end
	
	if azEssence_FocusedAzeriteBeam and bcBuff and CheckInteractDistance("target", 1) and ConRO_AoEButton:IsVisible() then
		return ids.AzEssence.FocusedAzeriteBeam;
	end

	if azEssence_ReapingFlames and (targetPh < 20 or targetPh > 80) then
		return ids.AzEssence.ReapingFlames;
	end

	if stamp and bwBuff and aotwBuff and ConRO_FullButton:IsVisible() then
		return ids.BM_Talent.Stampede;
	end

	if barrage and ConRO_AoEButton:IsVisible() then
		return ids.BM_Talent.Barrage;
	end
	
	if aotw and (bw or bwCD > 15) and ConRO_FullButton:IsVisible() then
		if not ConRO:AzPowerChosen(ids.AzTrait.PrimalInstincts) then
			return ids.BM_Ability.AspectoftheWild;
		elseif ConRO:AzPowerChosen(ids.AzTrait.PrimalInstincts) and bsCharges <= 0 then
			return ids.BM_Ability.AspectoftheWild;
		end
	end

	if bshot and bsCharges >= 1 and tChosen[ids.BM_Talent.ScentofBlood] and bw and not bwBuff and (aotwBuff or aotwCD > 15) and ConRO_FullButton:IsVisible() then
		return ids.BM_Ability.BarbedShot;
	end	
		
	if bw and not bwBuff and (aotwBuff or aotwCD > 15) and ConRO_FullButton:IsVisible() then
		return ids.BM_Ability.BestialWrath;
	end
	
	if azEssence_BloodoftheEnemy and bwBuff and CheckInteractDistance("target", 2) then
		return ids.AzEssence.BloodoftheEnemy;
	end

	if chimaera and ConRO_AoEButton:IsVisible() then
		return ids.BM_Talent.ChimaeraShot;
	end

	if kShotRDY and targetPh <= 20 then
		return ids.BM_Ability.KillShot;
	end
	
	if kc then
		return ids.BM_Ability.KillCommand;
	end

	if bshot and azCount_DanceofDeath >= 2 and not dodAzBuff then
		return ids.BM_Ability.BarbedShot;
	end	
	
	if chimaera then
		return ids.BM_Talent.ChimaeraShot;
	end		
	
	if azEssence_ConcentratedFlame and not bwBuff then
		return ids.AzEssence.ConcentratedFlame;
	end

	if azEssence_FocusedAzeriteBeam and CheckInteractDistance("target", 1) and ConRO_SingleButton:IsVisible() then
		return ids.AzEssence.FocusedAzeriteBeam;
	end	

	if amoc then
		return ids.BM_Talent.AMurderofCrows;
	end

	if db then
		return ids.BM_Talent.DireBeast;
	end	

	if bshot and bsCharges == 1 and bsCCD <= 1.5 then
		return ids.BM_Ability.BarbedShot;
	end

	if barrage then
		return ids.BM_Talent.Barrage;
	end
	
	if cobra and (kcCD >= 2.5 or focus >= focusMax - 15) and ConRO_SingleButton:IsVisible() then
		return ids.BM_Ability.CobraShot;
	end
return nil;
end

function ConRO.Hunter.BeastMasteryDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities
	local exhil												= ConRO:AbilityReady(ids.BM_Ability.Exhilaration, timeShift);
	local aott 												= ConRO:AbilityReady(ids.BM_Ability.AspectoftheTurtle, timeShift);
	local mendpet											= ConRO:AbilityReady(ids.BM_Ability.MendPet, timeShift);	
	local feedpet											= ConRO:AbilityReady(ids.BM_Ability.FeedPet, timeShift);

--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');
	local petPh												= ConRO:PercentHealth('pet');
	local incombat 											= UnitAffectingCombat('player');
	local summoned 											= ConRO:CallPet();
	
--Rotations	
	if feedpet and not incombat and summoned and petPh <= 60 then
		return ids.BM_Ability.FeedPet;
	end	
	
	if exhil and (playerPh <= 50 or petPh <= 20) then
		return ids.BM_Ability.Exhilaration;
	end
	
	if mendpet and summoned and petPh <= 60 then
		return ids.BM_Ability.MendPet;
	end	
	
	if aott then
		return ids.BM_Ability.AspectoftheTurtle;
	end
	
	return nil;
end

function ConRO.Hunter.Marksmanship(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources
	local focus 											= UnitPower('player', Enum.PowerType.Focus)
	local focusMax 											= UnitPowerMax('player', Enum.PowerType.Focus);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local aShotRDY											= ConRO:AbilityReady(ids.MM_Ability.ArcaneShot, timeShift);
	local sShotRDY											= ConRO:AbilityReady(ids.MM_Ability.SteadyShot, timeShift);
		local lsBuff											= ConRO:Aura(ids.MM_Buff.LethalShots, timeShift);
	local hm												= ConRO:AbilityReady(ids.MM_Ability.HuntersMark, timeShift);		
		local hmDebuff 											= ConRO:PersistentDebuff(ids.MM_Debuff.HuntersMark);
	local tranqShotRDY										= ConRO:AbilityReady(ids.MM_Ability.TranquilizingShot, timeShift);
	local kShotRDY											= ConRO:AbilityReady(ids.MM_Ability.KillShot, timeShift);
		local dEyeBUFF											= ConRO:Aura(ids.MM_Buff.DeadEye, timeShift);
	local cshot 											= ConRO:AbilityReady(ids.MM_Ability.CounterShot, timeShift);
	local mShotRDY											= ConRO:AbilityReady(ids.MM_Ability.MultiShot, timeShift);
		local tsBUFF											= ConRO:Aura(ids.MM_Buff.TrickShots, timeShift);
	local aimShotRDY								 		= ConRO:AbilityReady(ids.MM_Ability.AimedShot, timeShift);
		local asCharges, _, asCCD, asMCCD						= ConRO:SpellCharges(ids.MM_Ability.AimedShot);		
		local psBUFF											= ConRO:Aura(ids.MM_Buff.PreciseShots, timeShift);
	local rFireRDY											= ConRO:AbilityReady(ids.MM_Ability.RapidFire, timeShift);
	local tShotRDY 											= ConRO:AbilityReady(ids.MM_Ability.Trueshot, timeShift);
		local tShotBUFF, _, tsDUR								= ConRO:Aura(ids.MM_Buff.Trueshot, timeShift);
		
	local amoc 												= ConRO:AbilityReady(ids.MM_Talent.AMurderofCrows, timeShift);
	local expShotRDY										= ConRO:AbilityReady(ids.MM_Talent.ExplosiveShot, timeShift);
	local barrage 											= ConRO:AbilityReady(ids.MM_Talent.Barrage, timeShift);
	local chimaeraShot										= ConRO:AbilityReady(ids.MM_Talent.ChimaeraShot, timeShift);
	local sStingRDY											= ConRO:AbilityReady(ids.MM_Talent.SerpentSting, timeShift);
		local sStingDEBUFF										= ConRO:TargetAura(ids.MM_Debuff.SerpentSting, timeShift + 5);
	local dtap												= ConRO:AbilityReady(ids.MM_Talent.DoubleTap, timeShift);
		local dtBUFF											= ConRO:Aura(ids.MM_Buff.DoubleTap, timeShift);
	local volleyRDY											= ConRO:AbilityReady(ids.MM_Talent.Volley, timeShift);
		local volleyBUFF										= ConRO:TargetAura(ids.MM_Debuff.Volley, timeShift);

	local snipershot										= ConRO:AbilityReady(ids.MM_PvPTalent.SniperShot, timeShift);
		
		local lolBUFF											= ConRO:Aura(ids.MM_Buff.LockandLoad, timeShift);
		local sfBUFF, _, sfDUR									= ConRO:Aura(ids.MM_Buff.SteadyFocus, timeShift);

	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	
--Conditions	
	local targetPh 											= ConRO:PercentHealth('target');
	local summoned 											= ConRO:CallPet();
	local assist 											= ConRO:PetAssist();
	local incombat 											= UnitAffectingCombat('player');
	local ispvp												= UnitIsPVP('player');
	local Close 											= CheckInteractDistance("target", 3);
	
	local _, _, _, aimedShotTimemil = GetSpellInfo(ids.MM_Ability.AimedShot);
	local aimedShotTime = aimedShotTimemil*.001;
	local aimedShotError = 0.3;

	if currentSpell == ids.MM_Ability.AimedShot then
		focus = focus - 35;
		asCharges = asCharges -1;
	end
	
	local rfFocusCutOff = 70
	
	if tChosen[ids.MM_Talent.Streamline] then
		rfFocusCutOff = 64;
	end
	
	if lol then
		aimedShotTime = gcd;
	end

--Indicators	
	ConRO:AbilityInterrupt(ids.MM_Ability.CounterShot, cshot and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityPurge(ids.MM_Ability.TranquilizingShot, tranqShotRDY and ConRO:Purgable());
	
	ConRO:AbilityBurst(ids.MM_Ability.Trueshot, tshot and asCharges == 0 and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.MM_Talent.DoubleTap, dtap and ConRO_BurstButton:IsVisible());
	
--Warnings

--Rotations
	if not incombat then
		if dtap and ConRO_FullButton:IsVisible() then
			return ids.MM_Talent.DoubleTap;
		end
		
		if expShotRDY and ConRO_AoEButton:IsVisible() then
			return ids.MM_Talent.ExplosiveShot;
		end
		
		if volleyRDY and ConRO_AoEButton:IsVisible() then
			return ids.MM_Talent.Volley;
		end
		
		if aimShotRDY and currentSpell ~= ids.MM_Ability.AimedShot then
			return ids.MM_Ability.AimedShot;
		end
		
		if rFireRDY then
			return ids.MM_Ability.RapidFire;
		end
	end

	if sShotRDY and currentSpell == ids.MM_Ability.SteadyShot and ConRO.lastSpellId ~= ids.MM_Ability.SteadyShot and tChosen[ids.MM_Talent.SteadyFocus] and (not sfBUFF and sfDUR <= 2) then
		return ids.MM_Ability.SteadyShot;
	end
	
	if tShotRDY and ConRO_FullButton:IsVisible() then
		return ids.MM_Ability.Trueshot;
	end
	
	if kShotRDY and targetPh <= 20 and not dEyeBUFF then
		return ids.MM_Ability.KillShot;
	end
	
	if sStingRDY and not sStingDEBUFF and ConRO_SingleButton:IsVisible() then
		return ids.MM_Talent.SerpentSting;
	end

	if dtap and (rFireRDY or (aimshot and targetPh >= 70 and tChosen[ids.MM_Talent.CarefulAim])) then
		return ids.MM_Talent.DoubleTap;
	end
	
	if ConRO_AoEButton:IsVisible() then
		if tsBUFF then
			if rFireRDY	then
				return ids.MM_Ability.RapidFire;
			end

			if aimShotRDY and (asCharges == 2 or (asCharges == 1 and asCCD <= aimedShotTime + .5) or (lolBUFF and not psBUFF) or dtBUFF) and currentSpell ~= ids.MM_Ability.AimedShot then
				return ids.MM_Ability.AimedShot;
			end			
		end
		
		if barrage then
			return ids.MM_Talent.Barrage;
		end
	else
		if rFireRDY then
			return ids.MM_Ability.RapidFire;
		end

		if aimShotRDY and (asCharges == 2 or (asCharges == 1 and asCCD <= aimedShotTime + .5) or (lolBUFF and not psBUFF) or dtBUFF) and currentSpell ~= ids.MM_Ability.AimedShot then
			return ids.MM_Ability.AimedShot;
		end
	end
	
	if tChosen[ids.MM_Talent.CarefulAim] and targetPh > 70 then
		if aimShotRDY and asCharges >= 1 then
			return ids.MM_Ability.AimedShot;
		end
			
		if sShotRDY then
			return ids.MM_Ability.SteadyShot;
		end
	else
		if expShotRDY then
			return ids.MM_Talent.ExplosiveShot;
		end
		
		if volleyRDY and (rFireRDY or aimShotRDY) then
			return ids.MM_Talent.Volley;
		end
			
		if azEssence_ConcentratedFlame then
			return ids.AzEssence.ConcentratedFlame;
		end

		if amoc and ConRO_SingleButton:IsVisible() then
			return ids.MM_Talent.AMurderofCrows;
		end	
		
		if ConRO_AoEButton:IsVisible() then 
			if mShotRDY and (psBUFF or currentSpell == ids.MM_Ability.AimedShot) then
				return ids.MM_Ability.MultiShot;
			end
		else
			if tChosen[ids.MM_Talent.ChimaeraShot] then
				if chimaeraShot and (psBUFF or currentSpell == ids.MM_Ability.AimedShot) then
					return ids.MM_Talent.ChimaeraShot;
				end
			else
				if aShotRDY and (psBUFF or currentSpell == ids.MM_Ability.AimedShot) then
					return ids.MM_Ability.ArcaneShot;
				end
			end
		end

		if aimShotRDY and not psBUFF and asCharges >= 1 then
			return ids.MM_Ability.AimedShot;
		end
			
		if sShotRDY then
			return ids.MM_Ability.SteadyShot;
		end
	end
	return nil;
end

function ConRO.Hunter.MarksmanshipDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities	
	local exhil 											= ConRO:AbilityReady(ids.MM_Ability.Exhilaration, timeShift);
	local aott 												= ConRO:AbilityReady(ids.MM_Ability.AspectoftheTurtle, timeShift);
	local sotf												= ConRO:AbilityReady(ids.MM_Ability.SurvivaloftheFittestLW, timeShift);
		local lw												= ConRO:Form(ids.MM_Form.LoneWolf);
	local mendpet											= ConRO:AbilityReady(ids.MM_Ability.MendPet, timeShift);	
	local feedpet											= ConRO:AbilityReady(ids.MM_Ability.FeedPet, timeShift);

--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');
	local petPh												= ConRO:PercentHealth('pet');
	local incombat 											= UnitAffectingCombat('player');
	local summoned 											= ConRO:CallPet();
	
--Rotations	
	if feedpet and summoned and not incombat and petPh <= 60 then
		return ids.MM_Ability.FeedPet;
	end	
	
	if exhil and (playerPh <= 50 or petPh <= 20) then
		return ids.MM_Ability.Exhilaration;
	end
	
	if mendpet and summoned and petPh <= 60 then
		return ids.MM_Ability.MendPet;
	end	
	
	if aott then
		return ids.MM_Ability.AspectoftheTurtle;
	end
	
	if sotf and lw and incombat then
		return ids.MM_Ability.SurvivaloftheFittestLW;
	end
	
	return nil;
end

function ConRO.Hunter.Survival(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources	
	local focus 											= UnitPower('player', Enum.PowerType.Focus);
	local focusMax											= UnitPowerMax('player', Enum.PowerType.Focus);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local prage 											= ConRO:AbilityReady(ids.Surv_Ability.CommandPet, timeShift);	
	local tranqShotRDY										= ConRO:AbilityReady(ids.Surv_Ability.TranquilizingShot, timeShift);	
	
	local muz 												= ConRO:AbilityReady(ids.Surv_Ability.Muzzle, timeShift);
	local aote 												= ConRO:AbilityReady(ids.Surv_Ability.AspectoftheEagle, timeShift);
		local aoteBuff											= ConRO:Aura(ids.Surv_Buff.AspectoftheEagle, timeShift);
	local harpoon 											= ConRO:AbilityReady(ids.Surv_Ability.Harpoon, timeShift);
		local inHarRange 										= ConRO:IsSpellInRange(GetSpellInfo(ids.Surv_Ability.Harpoon), 'target');
	local carve 											= ConRO:AbilityReady(ids.Surv_Ability.Carve, timeShift);
	local kc 												= ConRO:AbilityReady(ids.Surv_Ability.KillCommand, timeShift);
		local kcCharges, _, kcCCD								= ConRO:SpellCharges(ids.Surv_Ability.KillCommand);	
	local kShotRDY											= ConRO:AbilityReady(ids.Surv_Ability.KillShot, timeShift);
	local rstrike 											= ConRO:AbilityReady(ids.Surv_Ability.RaptorStrike, timeShift);
		local vvBuff 											= ConRO:Aura(ids.Surv_Buff.VipersVenom, timeShift);
	local sStingRDY											= ConRO:AbilityReady(ids.Surv_Ability.SerpentSting, timeShift);
		local sStingDEBUFF, _, sStingDUR						= ConRO:TargetAura(ids.Surv_Debuff.SerpentSting, timeShift + 3);
	local wfBombRDY											= ConRO:AbilityReady(ids.Surv_Ability.WildfireBomb, timeShift);
		local wfbCharges, _, wfbCCD								= ConRO:SpellCharges(ids.Surv_Ability.WildfireBomb);		
		local wfbDebuff 										= ConRO:TargetAura(ids.Surv_Debuff.WildfireBomb, timeShift + 1);
	local sBombRDY											= false;
		local sbDebuff											= ConRO:TargetAura(ids.Surv_Debuff.ShrapnelBomb, timeShift + 1);
	local vBombRDY 											= false;
		local vbDebuff											= ConRO:TargetAura(ids.Surv_Debuff.VolatileBomb, timeShift + 1);
	local pBombRDY											= false;
		local pbDebuff											= ConRO:TargetAura(ids.Surv_Debuff.PheromoneBomb, timeShift + 1);
	local cassault											= ConRO:AbilityReady(ids.Surv_Ability.CoordinatedAssault, timeShift);
		local caBUFF 											= ConRO:Aura(ids.Surv_Buff.CoordinatedAssault, timeShift);	

	
	local mb												= ConRO:AbilityReady(ids.Surv_Talent.MongooseBite, timeShift);
		local mfBuff, mfCount, mfDur							= ConRO:Aura(ids.Surv_Buff.MongooseFury, timeShift);	
	local fs 												= ConRO:AbilityReady(ids.Surv_Talent.FlankingStrike, timeShift);	
	local butch 											= ConRO:AbilityReady(ids.Surv_Talent.Butchery, timeShift);	
	local amoc 												= ConRO:AbilityReady(ids.Surv_Talent.AMurderofCrows, timeShift);
	local strap												= ConRO:AbilityReady(ids.Surv_Talent.SteelTrap, timeShift);
	local chakrams											= ConRO:AbilityReady(ids.Surv_Talent.Chakrams, timeShift);

	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	
--Conditions	
	local inMelee											= ConRO:IsSpellInRange(GetSpellInfo(ids.Surv_Ability.WingClip), 'target');	
	local tarInMelee										= ConRO:Targets(ids.Surv_Ability.WingClip);
	local incombat 											= UnitAffectingCombat('player');
	local summoned 											= ConRO:CallPet();
	local assist 											= ConRO:PetAssist();
	local Close 											= CheckInteractDistance("target", 3);

	if ConRO:FindCurrentSpell(ids.Surv_Talent.ShrapnelBomb) then
		sBombRDY = wfBombRDY;
		wildfireBomb = ids.Surv_Talent.ShrapnelBomb;
	end
	if ConRO:FindCurrentSpell(ids.Surv_Talent.PheromoneBomb) then
		pBombRDY = wfBombRDY;
		wildfireBomb = ids.Surv_Talent.PheromoneBomb;
	end
	if ConRO:FindCurrentSpell(ids.Surv_Talent.VolatileBomb) then
		vBombRDY = wfBombRDY;
	end

	local raptorStrike = ids.Surv_Ability.RaptorStrike;
	local mongooseBite = ids.Surv_Talent.MongooseBite;

	if aoteBuff then
		raptorStrike = ids.Surv_Ability.RaptorStrikeRanged;
		mongooseBite = ids.Surv_Talent.MongooseBiteRanged;
	end

--Indicators	
	ConRO:AbilityInterrupt(ids.Surv_Ability.Muzzle, muz and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityPurge(ids.Surv_Ability.TranquilizingShot, tranqShotRDY and ConRO:Purgable());

	ConRO:AbilityMovement(ids.Surv_Ability.Harpoon, harpoon and inHarRange and not inMelee);
	
	ConRO:AbilityBurst(ids.Surv_Ability.CoordinatedAssault, cassault and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Surv_Ability.AspectoftheEagle, aote and incombat and not inMelee);
	
--Warnings	
	if not summoned then
		UIErrorsFrame:AddMessage("Call your pet!!!", 1.0, 0.0, 0.0, 53, 5);
	end

--Rotations
	if not incombat then
		if sStingRDY and not sStingDEBUFF then
			return ids.Surv_Ability.SerpentSting;
		end
	end

	if kShotRDY then
		return ids.Surv_Ability.KillShot;
	end

	if mb and mfDur >= .5 and mfCount >= 4 then
		return mongooseBite;
	end
	
	if tChosen[ids.Surv_Talent.BirdsofPrey] and caBUFF then
		if tChosen[ids.Surv_Talent.MongooseBite] then
			if mb and focus > 30 then
				return mongooseBite;
			end
		else
			if rstrike and focus > 30 then
				return raptorStrike;
			end
		end
	end

	if azEssence_ConcentratedFlame then
		return ids.AzEssence.ConcentratedFlame;
	end
	
	if tChosen[ids.Surv_Talent.MongooseBite] and tChosen[ids.Surv_Talent.AlphaPredator] then	
		if kc and (kcCharges == 2 or (kcCharges == 1 and kcCCD <= 1)) and focus <= 75 then
			return ids.Surv_Ability.KillCommand;
		end	
	else
		if kc and focus <= 85 then
			return ids.Surv_Ability.KillCommand;
		end
	end

	if vBombRDY and (sStingDUR <= 3 or wfbCharges == 2 or (wfbCharges == 1 and wfbCCD <= 1)) then
		return ids.Surv_Talent.VolatileBomb;
	end

	if sStingRDY and not sStingDEBUFF and (vvBuff or not caBUFF) then
		return ids.Surv_Ability.SerpentSting;
	end
	
	if not tChosen[ids.Surv_Talent.WildfireInfusion] then
		if tChosen[ids.Surv_Talent.MongooseBite] then
			if wfbomb and (wfbCharges == 2 or (wfbCharges == 1 and wfbCCD <= 1)) then
				return wildfireBomb;
			end	
		else
			if wfBombRDY and not wfbDebuff then
				return ids.Surv_Ability.WildfireBomb;
			end	
		end
	end
	
	if cassault and ConRO_FullButton:IsVisible() then
		return ids.Surv_Ability.CoordinatedAssault;
	end
	
	if chakrams then
		return ids.Surv_Talent.Chakrams;
	end
	
	if strap then
		return ids.Surv_Talent.SteelTrap;
	end
	
	if amoc then
		return ids.Surv_Talent.AMurderofCrows;
	end
	
	if sBombRDY and (focus >= 60 or wfbCharges == 2 or (wfbCharges == 1 and wfbCCD <= 1)) then
		return ids.Surv_Talent.ShrapnelBomb;	
	end
	
	if (ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible() then
		if tChosen[ids.Surv_Talent.Butchery] then
			if butch then
				return ids.Surv_Talent.Butchery;
			end
		else
			if carve then
				return ids.Surv_Ability.Carve;
			end
		end
	end	
	
	if harpoon and tChosen[ids.Surv_Talent.TermsofEngagement] then
		return ids.Surv_Ability.Harpoon;
	end

	if fs and focus <= 50 then
		return ids.Surv_Talent.FlankingStrike;
	end
	
	if tChosen[ids.Surv_Talent.MongooseBite] then
		if mb and ((not mfBuff and focus >= 60) or (mfDur >= .5 and mfCount >= 1)) then
			return mongooseBite;
		end
	else
		if rstrike and focus > 30 then
			return raptorStrike;
		end
	end
	
	if pBombRDY and (focus <= 40 or wfbCharges == 2 or (wfbCharges == 1 and wfbCCD <= 1)) then
		return ids.Surv_Talent.PheromoneBomb;
	end

	if tChosen[ids.Surv_Talent.MongooseBite] then
		if wfbomb and not wfbDebuff then
			return wildfireBomb;
		end
	end
	
	if tChosen[ids.Surv_Talent.MongooseBite] and tChosen[ids.Surv_Talent.AlphaPredator] then	
		if kc and kcCharges == 1 and focus <= 85 then
			return ids.Surv_Ability.KillCommand;
		end	
	end
		
	return nil;
end

function ConRO.Hunter.SurvivalDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities
	local exhil 											= ConRO:AbilityReady(ids.Surv_Ability.Exhilaration, timeShift);
	local aott 												= ConRO:AbilityReady(ids.Surv_Ability.AspectoftheTurtle, timeShift);
	local mendpet											= ConRO:AbilityReady(ids.Surv_Ability.MendPet, timeShift);	
	local feedpet											= ConRO:AbilityReady(ids.Surv_Ability.FeedPet, timeShift);

--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');
	local petPh												= ConRO:PercentHealth('pet');
	local incombat 											= UnitAffectingCombat('player');
	local summoned 											= ConRO:CallPet();
	
--Rotations	
	if feedpet and summoned and not incombat and petPh <= 60 then
		return ids.Surv_Ability.FeedPet;
	end	
	
	if exhil and (playerPh <= 50 or petPh <= 20) then
		return ids.Surv_Ability.Exhilaration;
	end
	
	if mendpet and summoned and petPh <= 60 then
		return ids.Surv_Ability.MendPet;
	end	
	
	if aott then
		return ids.Surv_Ability.AspectoftheTurtle;
	end
	
	return nil;
end