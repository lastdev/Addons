ConRO.Monk = {};
ConRO.Monk.CheckTalents = function()
end
local ConRO_Monk, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Monk.CheckTalents;
	if mode == 1 then
		self.Description = "Monk [Brewmaster - Tank]";
		self.NextSpell = ConRO.Monk.Brewmaster;
		self.ToggleHealer();
	end;
	if mode == 2 then
		self.Description = "Monk [Mistweaver - Healer]";
		self.NextSpell = ConRO.Monk.Mistweaver;
		self.ToggleHealer();
	end;
	if mode == 3 then
		self.Description = "Monk [Windwalker - Melee]";
		self.NextSpell = ConRO.Monk.Windwalker;
		self.ToggleDamage();
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Monk.CheckTalents;
	if mode == 1 then
		self.NextDef = ConRO.Monk.BrewmasterDef;
	end;
	if mode == 2 then
		self.NextDef = ConRO.Monk.MistweaverDef;
	end;
	if mode == 3 then
		self.NextDef = ConRO.Monk.WindwalkerDef;
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Monk.Brewmaster(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local energy					 						= UnitPower('player', Enum.PowerType.Energy);
	local energyMax 										= UnitPowerMax('player', Enum.PowerType.Energy);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local proRDY											= ConRO:AbilityReady(ids.Bm_Ability.Provoke, timeShift);
	local bKickRDY												= ConRO:AbilityReady(ids.Bm_Ability.BlackoutKick, timeShift);
		local bcBUFF											= ConRO:Aura(ids.Bm_Buff.BlackoutCombo, timeShift);
	local bofRDY											= ConRO:AbilityReady(ids.Bm_Ability.BreathofFire, timeShift);
	local ksRDY												= ConRO:AbilityReady(ids.Bm_Ability.KegSmash, timeShift);
		local ksDEBUFF											= ConRO:TargetAura(ids.Bm_Debuff.KegSmash, timeShift);
	local tpRDY												= ConRO:AbilityReady(ids.Bm_Ability.TigerPalm, timeShift);
	local shsRDY 											= ConRO:AbilityReady(ids.Bm_Ability.SpearHandStrike, timeShift);
	local rollRDY											= ConRO:AbilityReady(ids.Bm_Ability.Roll, timeShift);		
		
	local cbRDY												= ConRO:AbilityReady(ids.Bm_Talent.ChiBurst, timeShift);
	local cwRDY												= ConRO:AbilityReady(ids.Bm_Talent.ChiWave, timeShift);
	local rjwRDY											= ConRO:AbilityReady(ids.Bm_Talent.RushingJadeWind, timeShift);
		local rjwBUFF											= ConRO:Aura(ids.Bm_Buff.RushingJadeWind, timeShift);	
	local ctRDY												= ConRO:AbilityReady(ids.Bm_Talent.ChiTorpedo, timeShift);
		local ctBUFF											= ConRO:Aura(ids.Bm_Buff.ChiTorpedo, timeShift);	
	local tlRDY												= ConRO:AbilityReady(ids.Bm_Talent.TigersLust, timeShift);
	
--Conditions
	local Close 											= CheckInteractDistance("target", 3);
	local tarInMelee										= ConRO:Targets(ids.Bm_Ability.SpearHandStrike);
	
--Indicators
	ConRO:AbilityInterrupt(ids.Bm_Ability.SpearHandStrike, shsRDY and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityMovement(ids.Bm_Ability.Roll, rollRDY and not tChosen[ids.Bm_Talent.ChiTorpedo]);
	ConRO:AbilityMovement(ids.Bm_Talent.ChiTorpedo, ctRDY and not ctBUFF);
	ConRO:AbilityMovement(ids.Bm_Talent.TigersLust, tlRDY);
	
	ConRO:AbilityTaunt(ids.Bm_Ability.Provoke, proRDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));
	
--Rotations
	if bcBUFF and tChosen[ids.Bm_Talent.BlackoutCombo] and ConRO.lastSpellId == ids.Bm_Ability.BlackoutKick then
		if tpRDY then
			return ids.Bm_Ability.TigerPalm;
		end
	end
	
	if ksRDY then
		return ids.Bm_Ability.KegSmash;
	end

	if bofRDY and tarInMelee >= 2 then
		return ids.Bm_Ability.BreathofFire;
	end
	
	if bKickRDY then
		return ids.Bm_Ability.BlackoutKick;
	end

	if bofRDY then
		return ids.Bm_Ability.BreathofFire;
	end

	if rjwRDY and not rjwBUFF then
		return ids.Bm_Talent.RushingJadeWind;
	end

	if tpRDY and energy >= 65 and not tChosen[ids.Bm_Talent.BlackoutCombo] then
		return ids.Bm_Ability.TigerPalm;
	end 

	if cbRDY then
		return ids.Bm_Talent.ChiBurst;
	end		

	if cwRDY then
		return ids.Bm_Talent.ChiWave;
	end
return nil;
end

function ConRO.Monk.BrewmasterDef(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local energy					 						= UnitPower('player', Enum.PowerType.Energy);
	local energyMax 										= UnitPowerMax('player', Enum.PowerType.Energy);

--Abilities
	local pbRDY												= ConRO:AbilityReady(ids.Bm_Ability.PurifyingBrew, timeShift);

		local hsDEBUFF											= ConRO:Aura(ids.Bm_Debuff.HighStagger, timeShift, 'HARMFUL');		
	local zmRDY												= ConRO:AbilityReady(ids.Bm_Ability.ZenMeditation, timeShift);		
	local fbRDY												= ConRO:AbilityReady(ids.Bm_Ability.FortifyingBrew, timeShift);
	local ehRDY												= ConRO:AbilityReady(ids.Bm_Ability.ExpelHarm, timeShift);	

	local heRDY												= ConRO:AbilityReady(ids.Bm_Talent.HealingElixir, timeShift);	
	local dhRDY												= ConRO:AbilityReady(ids.Bm_Talent.DampenHarm, timeShift);	
	
--Conditions
	local playerPh 											= ConRO:PercentHealth('player');	

--Indicators
	
--Rotations
	if pbRDY and hsDEBUFF and brewCharges >= 1 then
		return ids.Bm_Ability.PurifyingBrew;
	end
	
	if heRDY and playerPh <= 80 then
		return ids.Bm_Talent.HealingElixir;
	end	
	
	if ehRDY and playerPh <= 50 then
		return ids.Bm_Ability.ExpelHarm;
	end	
	
	if dhRDY then
		return ids.Bm_Talent.DampenHarm;
	end
	
	if fbRDY then
		return ids.Bm_Ability.FortifyingBrew;
	end	
	
return nil;
end

function ConRO.Monk.Mistweaver(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local mana					 							= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	
--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities
	local tp 												= ConRO:AbilityReady(ids.Mw_Ability.TigerPalm, timeShift);
		local totmBuff, totmCount								= ConRO:Aura(ids.Mw_Buff.TeachingsoftheMonastery, timeShift);
	local rsk, rskCD, rskMCD								= ConRO:AbilityReady(ids.Mw_Ability.RisingSunKick, timeShift);
	local bok 												= ConRO:AbilityReady(ids.Mw_Ability.BlackoutKick, timeShift);
	local rollRDY											= ConRO:AbilityReady(ids.Mw_Ability.Roll, timeShift);
	local rmRDY												= ConRO:AbilityReady(ids.Mw_Ability.RenewingMist, timeShift);
	
	local ctRDY												= ConRO:AbilityReady(ids.Mw_Talent.ChiTorpedo, timeShift);
		local ctBUFF											= ConRO:Aura(ids.Mw_Buff.ChiTorpedo, timeShift);	
	local tlRDY												= ConRO:AbilityReady(ids.Mw_Talent.TigersLust, timeShift);
	local sjssRDY												= ConRO:AbilityReady(ids.Mw_Talent.SummonJadeSerpentStatue, timeShift);
	
	local azChosen_MistyPeaks								= ConRO:AzPowerChosen(ids.AzTrait.MistyPeaks);
	
--Conditions	
	local isEnemy 											= ConRO:TarHostile();
	local Close 											= CheckInteractDistance("target", 3);
	
	local mStatue = 'Jade Serpent Statue';
	local sjssActive = false;
	if tChosen[ids.Mw_Talent.SummonJadeSerpentStatue] then
		for slot = 1, 2 do
			local found, name, _, _, texture = GetTotemInfo(slot)
			if found and name == mStatue then
				sjssActive = true;
			end
		end
	end
	
--Indicators
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityMovement(ids.Mw_Ability.Roll, rollRDY and not tChosen[ids.Mw_Talent.ChiTorpedo]);
	ConRO:AbilityMovement(ids.Mw_Talent.ChiTorpedo, ctRDY and not ctBUFF);
	ConRO:AbilityMovement(ids.Mw_Talent.TigersLust, tlRDY);

	ConRO:AbilityRaidBuffs(ids.Mw_Talent.SummonJadeSerpentStatue, sjssRDY and not sjssActive);
	ConRO:AbilityRaidBuffs(ids.Mw_Ability.RenewingMist, rmRDY and azChosen_MistyPeaks and not ConRO:OneBuff(ids.Mw_Buff.RenewingMist));
	
--Rotations
	if isEnemy then
		if rsk then
			return ids.Mw_Ability.RisingSunKick;
		end
		if bok and not rsk and rskCD > rskMCD - 6 then
			return ids.Mw_Ability.BlackoutKick;
		end		
		
		if tp and (not totmBuff or totmCount < 3) then
			return ids.Mw_Ability.TigerPalm;
		end
	end
return nil;
end

function ConRO.Monk.MistweaverDef(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local mana					 							= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);

--Abilities	
	local fbRDY												= ConRO:AbilityReady(ids.Mw_Ability.FortifyingBrew, timeShift);

	local heRDY												= ConRO:AbilityReady(ids.Mw_Talent.HealingElixir, timeShift);	
	local dhRDY												= ConRO:AbilityReady(ids.Mw_Talent.DampenHarm, timeShift);	
	
--Conditions
	local playerPh 											= ConRO:PercentHealth('player');	

--Rotations
	if heRDY and playerPh <= 80 then
		return ids.Mw_Talent.HealingElixir;
	end	

	if fbRDY then
		return ids.Mw_Ability.FortifyingBrew;
	end
	
	if dhRDY then
		return ids.Mw_Talent.DampenHarm;
	end	
	
return nil;
end

function ConRO.Monk.Windwalker(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local energy					 						= UnitPower('player', Enum.PowerType.Energy);
	local energyMax 										= UnitPowerMax('player', Enum.PowerType.Energy);
	local chi 												= UnitPower('player', Enum.PowerType.Chi);
	local chiMax 											= UnitPowerMax('player', Enum.PowerType.Chi);	
	
--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities
	local cjLightning, _, _, _, cjlRANGE					= ConRO:AbilityReady(ids.Ww_Ability.CracklingJadeLightning, timeShift);
		local tecBuff, tecStacks								= ConRO:Form(ids.Ww_Form.TheEmperorsCapacitor);
	local shs 												= ConRO:AbilityReady(ids.Ww_Ability.SpearHandStrike, timeShift);
	local fof, fofCD, _, _, fofRANGE						= ConRO:AbilityReady(ids.Ww_Ability.FistsofFury, timeShift);
	local tp, _, _, _, meleeRANGE 							= ConRO:AbilityReady(ids.Ww_Ability.TigerPalm, timeShift);
	local rsk, rskCD										= ConRO:AbilityReady(ids.Ww_Ability.RisingSunKick, timeShift);
	local bok 												= ConRO:AbilityReady(ids.Ww_Ability.BlackoutKick, timeShift);
	local tod 												= ConRO:AbilityReady(ids.Ww_Ability.TouchofDeath, timeShift);
		local todDebuff											= ConRO:TargetAura(ids.Ww_Debuff.TouchofDeath, timeShift);
	local sef												= ConRO:AbilityReady(ids.Ww_Ability.StormEarthandFire, timeShift);
		local sefBuff											= ConRO:Aura(ids.Ww_Buff.StormEarthandFire, timeShift);
		local sefCharges, sefMaxCharges							= ConRO:SpellCharges(ids.Ww_Ability.StormEarthandFire);	
	local sck 												= ConRO:AbilityReady(ids.Ww_Ability.SpinningCraneKick, timeShift);
		local motcDebuff										= ConRO:TargetAura(ids.Ww_Debuff.MarkoftheCrane, timeShift);
	local rollRDY											= ConRO:AbilityReady(ids.Ww_Ability.Roll, timeShift);
	local fskRDY											= ConRO:AbilityReady(ids.Ww_Ability.FlyingSerpentKick, timeShift);
	local invokeRDY 										= ConRO:AbilityReady(ids.Ww_Ability.InvokeXuentheWhiteTiger, timeShift);
	local eHarmRDY	 										= ConRO:AbilityReady(ids.Ww_Ability.ExpelHarm, timeShift);
	
	local ctRDY												= ConRO:AbilityReady(ids.Ww_Talent.ChiTorpedo, timeShift);
		local ctBUFF											= ConRO:Aura(ids.Ww_Buff.ChiTorpedo, timeShift);	
	local tlRDY												= ConRO:AbilityReady(ids.Ww_Talent.TigersLust, timeShift);	
	local ee 												= ConRO:AbilityReady(ids.Ww_Talent.EnergizingElixir, timeShift);	
	local wdp, wdpCD 										= ConRO:AbilityReady(ids.Ww_Talent.WhirlingDragonPunch, timeShift);
	local cwave 											= ConRO:AbilityReady(ids.Ww_Talent.ChiWave, timeShift);
	local sere 												= ConRO:AbilityReady(ids.Ww_Talent.Serenity, timeShift);
	local rjw 												= ConRO:AbilityReady(ids.Ww_Talent.RushingJadeWind, timeShift);
	local cburst 											= ConRO:AbilityReady(ids.Ww_Talent.ChiBurst, timeShift);
	local fotwtRDY 											= ConRO:AbilityReady(ids.Ww_Talent.FistoftheWhiteTiger, timeShift);


	local azChosen_DanceofChiJi								= ConRO:AzPowerChosen(ids.AzTrait.DanceofChiJi);
		local dofcjAzBuff 										= ConRO:Aura(ids.AzTraitBuff.DanceofChiJi, timeShift);
	
	local serBuff, _, serDur								= ConRO:Aura(ids.Ww_Buff.Serenity, timeShift);
	local bkBuff 											= ConRO:Aura(ids.Ww_Buff.BlackoutKick, timeShift);

	local azEssence_ConcentratedFlame, _, _, _, cfAzRANGE	= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	local azEssence_ReapingFlames, _, _, _, rfAzRANGE		= ConRO:AbilityReady(ids.AzEssence.ReapingFlames, timeShift);
	
--Conditions
	local incombat 											= UnitAffectingCombat('player');
	local Close 											= CheckInteractDistance("target", 3);
	local tarInMelee										= ConRO:Targets(ids.Ww_Ability.TigerPalm);
	
--Indicators
	ConRO:AbilityInterrupt(ids.Ww_Ability.SpearHandStrike, shs and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityMovement(ids.Ww_Ability.Roll, rollRDY and not tChosen[ids.Ww_Talent.ChiTorpedo]);
	ConRO:AbilityMovement(ids.Ww_Talent.ChiTorpedo, ctRDY and not ctBUFF);
	ConRO:AbilityMovement(ids.Ww_Talent.TigersLust, tlRDY);
	ConRO:AbilityMovement(ids.Ww_Ability.FlyingSerpentKick, fskRDY);
	
	ConRO:AbilityBurst(ids.Ww_Ability.TouchofDeath, tod and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Ww_Ability.InvokeXuentheWhiteTiger, invokeRDY and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Ww_Ability.StormEarthandFire, sef and not sefBuff and not tChosen[ids.Ww_Talent.Serenity] and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Ww_Talent.Serenity, sere and fofCD == 0 and ConRO_BurstButton:IsVisible());

--Rotations
	if ee and energy <= 20 and chi <= 3 then
		return ids.Ww_Talent.EnergizingElixir;
	end
	
	if serBuff then
		if rsk and meleeRANGE and ConRO.lastSpellId ~= ids.Ww_Ability.RisingSunKick then
			return ids.Ww_Ability.RisingSunKick;
		end
		
		if fof and meleeRANGE and serDur >= 9 and currentSpell ~= ids.Ww_Ability.FistsofFury then
			return ids.Ww_Ability.FistsofFury;
		end
		
		if bok and meleeRANGE and ConRO.lastSpellId ~= ids.Ww_Ability.BlackoutKick then
			return ids.Ww_Ability.BlackoutKick;
		end	

		if fof and meleeRANGE and currentSpell ~= ids.Ww_Ability.FistsofFury then
			return ids.Ww_Ability.FistsofFury;
		end
		
		if tChosen[ids.Ww_Talent.FistoftheWhiteTiger] then
			if fotwtRDY and meleeRANGE then
				return ids.Ww_Talent.FistoftheWhiteTiger;
			end
		else
			if sck and meleeRANGE then
				return ids.Ww_Ability.SpinningCraneKick;
			end		
		end
	else
		if incombat and sef and not sefBuff and not tChosen[ids.Ww_Talent.Serenity] and ConRO_FullButton:IsVisible() then
			return ids.Ww_Ability.StormEarthandFire;
		end
		
		if incombat and sere and fofCD == 0 and ConRO_FullButton:IsVisible() then
			return ids.Ww_Talent.Serenity;
		end

		if incombat and invokeRDY and ConRO_FullButton:IsVisible() then
			return ids.Ww_Ability.InvokeXuentheWhiteTiger;
		end
		
		if incombat and tod and meleeRANGE and ConRO_FullButton:IsVisible() then
			return ids.Ww_Ability.TouchofDeath;
		end
		
		if fotwtRDY and meleeRANGE and chi < 3 and energy >= energyMax - 15 and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 2) or ConRO_SingleButton:IsVisible()) then
			return ids.Ww_Talent.FistoftheWhiteTiger;
		end
		
		if eHarmRDY and meleeRANGE and chi <= 4 and energy >= energyMax - 15 and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 2) or ConRO_SingleButton:IsVisible()) then
			return ids.Ww_Ability.ExpelHarm;
		end
		
		if tp and meleeRANGE and chi < 4 and energy >= energyMax - 15 and ConRO.lastSpellId ~= ids.Ww_Ability.TigerPalm and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 2) or ConRO_SingleButton:IsVisible()) then
			return ids.Ww_Ability.TigerPalm;
		end			
		
		if wdp and meleeRANGE and fofCD > 0 and rskCD > 0 then
			return ids.Ww_Talent.WhirlingDragonPunch;
		end
		
		if azEssence_ConcentratedFlame and cfAzRANGE then
			return ids.AzEssence.ConcentratedFlame;
		end

		if azEssence_ReapingFlames and rfAzRANGE then
			return ids.AzEssence.ReapingFlames;
		end		

		if fof and fofRANGE and currentSpell ~= ids.Ww_Ability.FistsofFury then
			return ids.Ww_Ability.FistsofFury;
		end

		if fofCD > 1.5 then
			if rjw and fofRANGE and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
				return ids.Ww_Ability.RushingJadeWind;
			end

			if rsk and meleeRANGE and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 2) or ConRO_SingleButton:IsVisible() or (tChosen[ids.Ww_Talent.WhirlingDragonPunch] and not wdp and wdpCD < 3)) then
				return ids.Ww_Ability.RisingSunKick;
			end
		end

		if cburst and cjlRANGE and chi <= 4 and currentSpell ~= ids.Ww_Talent.ChiBurst then
			return ids.Ww_Talent.ChiBurst;
		end
		
		if sck and fofRANGE and fofCD > 2 and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible()) then
			return ids.Ww_Ability.SpinningCraneKick;
		end
		
		if fotwtRDY and meleeRANGE and chi < 3 then
			return ids.Ww_Talent.FistoftheWhiteTiger;
		end
		
		if sck and fofRANGE and dofcjAzBuff then
			return ids.Ww_Ability.SpinningCraneKick;
		end
		
		if rsk and meleeRANGE and fofCD > 1.5 and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible()) then
			return ids.Ww_Ability.RisingSunKick;
		end
		
		if bok and meleeRANGE and ConRO.lastSpellId ~= ids.Ww_Ability.BlackoutKick and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 2) or ConRO_SingleButton:IsVisible() or not motcDebuff) then
			return ids.Ww_Ability.BlackoutKick;
		end	
		
		if cwave and cjlRANGE then
			return ids.Ww_Talent.ChiWave;
		end
		
		if eHarmRDY and meleeRANGE then
			return ids.Ww_Ability.ExpelHarm;
		end		
		
		if tp and meleeRANGE then
			if ((ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible()) then
				return ids.Ww_Ability.TigerPalm;
			elseif ((ConRO_AutoButton:IsVisible() and tarInMelee <= 2) or ConRO_SingleButton:IsVisible()) and ConRO.lastSpellId ~= ids.Ww_Ability.TigerPalm then
				return ids.Ww_Ability.TigerPalm;
			end
		end
	end
return nil;
end

function ConRO.Monk.WindwalkerDef(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local energy 											= UnitPower('player', Enum.PowerType.Energy);
	local chi 												= UnitPower('player', Enum.PowerType.Chi);
--Abilities
	local tok 												= ConRO:AbilityReady(ids.Ww_Ability.TouchofKarma, timeShift);

	local dhRDY												= ConRO:AbilityReady(ids.Ww_Talent.DampenHarm, timeShift);	
		
--Rotations	
	if tok then
		return ids.Ww_Ability.TouchofKarma;
	end

	if dhRDY then
		return ids.Ww_Talent.DampenHarm;
	end	
	
return nil;
end
