ConRO.Druid = {};
ConRO.Druid.CheckTalents = function()
end
local ConRO_Druid, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Druid.CheckTalents;
	if mode == 1 then
		self.Description = "Druid [Balance - Caster]";
		self.NextSpell = ConRO.Druid.Balance;
		self.ToggleDamage();
	end;
	if mode == 2 then
		self.Description = "Druid [Feral - Melee]";
		self.NextSpell = ConRO.Druid.Feral;
		self.ToggleDamage();
	end;
	if mode == 3 then
		self.Description = "Druid [Guardian - Tank]";
		self.NextSpell = ConRO.Druid.Guardian;
		self.ToggleHealer();
	end;
	if mode == 4 then
		self.Description = "Druid [Restoration - Healer]";
		self.NextSpell = ConRO.Druid.Restoration;
		self.ToggleHealer();
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Druid.CheckTalents;
	if mode == 1 then
		self.NextDef = ConRO.Druid.BalanceDef;
	end;
	if mode == 2 then
		self.NextDef = ConRO.Druid.FeralDef;
	end;
	if mode == 3 then
		self.NextDef = ConRO.Druid.GuardianDef;
	end;
	if mode == 4 then
		self.NextDef = ConRO.Druid.RestorationDef;
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Druid.Balance(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources	
	local plvl 												= UnitLevel("player");
	local lunar 											= UnitPower('player', Enum.PowerType.LunarPower);

--Abilities
	local tracial											= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);

	local soothe											= ConRO:AbilityReady(ids.Druid_Ability.Soothe, timeShift); 
	local calign											= ConRO:AbilityReady(ids.Bal_Ability.CelestialAlignment, timeShift);
		local calignBUFF										= ConRO:Aura(ids.Bal_Buff.CelestialAlignment, timeShift);
	local sbeam 											= ConRO:AbilityReady(ids.Bal_Ability.SolarBeam, timeShift);
	local mfire 											= ConRO:AbilityReady(ids.Druid_Ability.Moonfire, timeShift);
		local mfDebuff											= ConRO:TargetAura(ids.Druid_Debuff.Moonfire, timeShift + 5);
		local mfDebuffMoving									= ConRO:TargetAura(ids.Druid_Debuff.Moonfire, timeShift + 10);
	local sfire 											= ConRO:AbilityReady(ids.Bal_Ability.Sunfire, timeShift);
		local sfDebuff											= ConRO:TargetAura(ids.Bal_Debuff.Sunfire, timeShift + 3);
		local sfDebuffMoving									= ConRO:TargetAura(ids.Bal_Debuff.Sunfire, timeShift + 8);
	local wrath												= ConRO:AbilityReady(ids.Bal_Ability.Wrath, timeShift);
	local starfire											= ConRO:AbilityReady(ids.Bal_Ability.Starfire, timeShift);
	local ssurge											= ConRO:AbilityReady(ids.Bal_Ability.Starsurge, timeShift);
	local sfall 											= ConRO:AbilityReady(ids.Bal_Ability.Starfall, timeShift);
	local mkForm											= ConRO:AbilityReady(ids.Bal_Ability.MoonkinForm, timeShift);
	
	local sflare											= ConRO:AbilityReady(ids.Bal_Talent.StellarFlare, timeShift);	
		local stDebuff 											= ConRO:TargetAura(ids.Bal_Debuff.StellarFlare, timeShift + 7);	
	local woe 												= ConRO:AbilityReady(ids.Bal_Talent.WarriorofElune, timeShift);	
	local foe 												= ConRO:AbilityReady(ids.Bal_Talent.FuryofElune, timeShift);
	local fon 												= ConRO:AbilityReady(ids.Bal_Talent.ForceofNature, timeShift);
	local icoe 												= ConRO:AbilityReady(ids.Bal_Talent.IncarnationChosenofElune, timeShift);
		local icoeBUFF											= ConRO:Aura(ids.Bal_Buff.IncarnationChosenofElune, timeShift);
	local newmoon	  										= ConRO:AbilityReady(ids.Bal_Talent.NewMoon, timeShift);
		local newCharges										= ConRO:SpellCharges(ids.Bal_Talent.NewMoon);
		
	local mf 												= ConRO:Form(ids.Bal_Form.MoonkinForm);
	local woeBuff 											= ConRO:Form(ids.Bal_Form.WarriorofElune);
	
	local eLunarBuff			 							= ConRO:Aura(ids.Bal_Buff.EclipseLunar, timeShift);
	local eSolarBuff 										= ConRO:Aura(ids.Bal_Buff.EclipseSolar, timeShift);
	local sfBuff 											= ConRO:Aura(ids.Bal_Buff.Starfall, timeShift);
	local ofBuff 											= ConRO:Aura(ids.Bal_Buff.OwlkinFrenzy, timeShift);
	local slBuff, slCharges									= ConRO:Aura(ids.Bal_Buff.Starlord, timeShift);
	

	local fmoon 											= ConRO:TargetAura(ids.Bal_Debuff.Moonfire, timeShift + 18);
	local fsun 												= ConRO:TargetAura(ids.Bal_Debuff.Sunfire, timeShift + 15);
	local fstellar 											= ConRO:TargetAura(ids.Bal_Debuff.StellarFlare, timeShift + 18);

	local azEssence_BloodoftheEnemy							= ConRO:AbilityReady(ids.AzEssence.BloodoftheEnemy, timeShift);	
	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	local azEssence_GuardianofAzeroth						= ConRO:AbilityReady(ids.AzEssence.GuardianofAzeroth, timeShift);
	local azEssence_MemoryofLucidDream						= ConRO:AbilityReady(ids.AzEssence.MemoryofLucidDream, timeShift);
		local moldAzEssBuff										= ConRO:Aura(ids.AzEssenceBuff.MemoryofLucidDream, timeShift);
		
--Conditions
	local incombat 											= UnitAffectingCombat('player');
	local moving 											= ConRO:PlayerSpeed();
	
	if currentSpell == ids.Bal_Talent.FullMoon then
		lunar = lunar + 40;
	elseif currentSpell == ids.Bal_Talent.NewMoon then
		lunar = lunar + 10;
	elseif currentSpell == ids.Bal_Talent.HalfMoon then
		lunar = lunar + 20;
	elseif currentSpell == ids.Bal_Ability.Wrath then
		lunar = lunar + 6;
	elseif currentSpell == ids.Bal_Ability.Starfire then
		lunar = lunar + 8;
	end
	
	local newMoonPhase = ids.Bal_Talent.FullMoon;
	
	if ConRO:FindSpell(ids.Bal_Talent.NewMoon) then
		newMoonPhase = ids.Bal_Talent.NewMoon;
	elseif ConRO:FindSpell(ids.Bal_Talent.HalfMoon) then
		newMoonPhase = ids.Bal_Talent.HalfMoon;
	end

--Indicators
	ConRO:AbilityInterrupt(ids.Bal_Ability.SolarBeam, sbeam and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Druid_Ability.Soothe, soothe and ConRO:Purgable());
	
	ConRO:AbilityBurst(ids.Bal_Talent.IncarnationChosenofElune, icoe and mfDebuff and sfDebuff and (not tChosen[ids.Bal_Talent.StellarFlare] or (tChosen[ids.Bal_Talent.StellarFlare] and sfDebuff)) and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Bal_Ability.CelestialAlignment, calign and mfDebuff and sfDebuff and (not tChosen[ids.Bal_Talent.StellarFlare] or (tChosen[ids.Bal_Talent.StellarFlare] and sfDebuff)) and ConRO_BurstButton:IsVisible() and not tChosen[ids.Bal_Talent.IncarnationChosenofElune]);
	
--Rotations	
	if mkForm and not mf then
		return ids.Bal_Ability.MoonkinForm;
	end

	if not incombat then
		if wrath and ConRO_SingleButton:IsVisible() then
			return ids.Bal_Ability.Wrath;
		elseif starfire and ConRO_AoEButton:IsVisible() then
			return ids.Bal_Ability.Starfire;
		end
	elseif moving then
		if azEssence_ConcentratedFlame then
			return ids.AzEssence.ConcentratedFlame;
		end
		
		if mfire and not mfDebuffMoving then
			return ids.Druid_Ability.Moonfire;
		elseif sfire and not sfDebuffMoving	then
			return ids.Bal_Ability.Sunfire;
		end
		if sfall and lunar >= 50 and not sfBuff and ConRO_AoEButton:IsVisible() and not ConRO:AzPowerChosen(ids.AzTrait.ArcanicPulsar) then
			return ids.Bal_Ability.Starfall;
		end	
		if ssurge and lunar >= 40 then
			return ids.Bal_Ability.Starsurge;
		end
		if starfire and woeBuff then
			return ids.Bal_Ability.Starfire;
		end
	else
		if ssurge and lunar >= 40 and tChosen[ids.Bal_Talent.Starlord] and slBuff and slCharges < 3 then
			return ids.Bal_Ability.Starsurge;
		end
		
		if mfire and not mfDebuff then
			return ids.Druid_Ability.Moonfire;
		elseif sflare and not stDebuff and currentSpell ~= ids.Bal_Talent.StellarFlare then
			return ids.Bal_Talent.StellarFlare;
		elseif sfire and not sfDebuff then
			return ids.Bal_Ability.Sunfire;
		end
		
		if azEssence_ConcentratedFlame then
			return ids.AzEssence.ConcentratedFlame;
		end
		
		if calign and not calignBUFF and ConRO_FullButton:IsVisible() and not tChosen[ids.Bal_Talent.IncarnationChosenofElune] then
			return ids.Bal_Ability.CelestialAlignment;
		end
		
		if icoe and not icoeBUFF and ConRO_FullButton:IsVisible() then
			return ids.Bal_Talent.IncarnationChosenofElune;
		end
		
		if foe then
			return ids.Bal_Talent.FuryofElune;
		end
		
		if woe and not woeBuff then
			return ids.Bal_Talent.WarriorofElune;
		end
		
		if fon then
			return ids.Bal_Talent.ForceofNature;
		end

		if ssurge and lunar >= 80 and (not tChosen[ids.Bal_Talent.Starlord] or (tChosen[ids.Bal_Talent.Starlord] and not slBuff)) and (ConRO_SingleButton:IsVisible() or ConRO:AzPowerChosen(ids.AzTrait.ArcanicPulsar)) then
			if not (ConRO:AzPowerChosen(ids.AzTrait.StreakingStars) and (calignBUFF or icoeBUFF) and (currentSpell == ids.Bal_Ability.Starsurge or ConRO.lastSpellId == ids.Bal_Ability.Starsurge)) then
				return ids.Bal_Ability.Starsurge;
			end
		end
		
		if sfall and lunar >= 50 and not sfBuff and ConRO_AoEButton:IsVisible() and not ConRO:AzPowerChosen(ids.AzTrait.ArcanicPulsar) then
			if not (ConRO:AzPowerChosen(ids.AzTrait.StreakingStars) and (calignBUFF or icoeBUFF) and (currentSpell == ids.Bal_Ability.Starfall or ConRO.lastSpellId == ids.Bal_Ability.Starfall)) then
				return ids.Bal_Ability.Starfall;
			end
		end
		
		if newmoon and newCharges > 1 then
			return newMoonPhase;
		elseif newmoon and newCharges == 1 and (currentSpell ~= ids.Bal_Talent.NewMoon and currentSpell ~= ids.Bal_Talent.HalfMoon and currentSpell ~= ids.Bal_Talent.FullMoon) then
			return newMoonPhase;
		end
		
		if wrath and ConRO_SingleButton:IsVisible() then
			return ids.Bal_Ability.Wrath;
		elseif starfire and ConRO_AoEButton:IsVisible() then
			return ids.Bal_Ability.Starfire;
		end
	end
end

function ConRO.Druid.BalanceDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities	
	local bark 												= ConRO:AbilityReady(ids.Druid_Ability.Barkskin, timeShift);
	
	local renewal 											= ConRO:AbilityReady(ids.Bal_Talent.Renewal, timeShift);

--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');

--Rotations	
	if renewal and playerPh <= 60 then
		return ids.Bal_Talent.Renewal;
	end
	
	if bark then
		return ids.Druid_Ability.Barkskin;
	end
	
	return nil;
end

function ConRO.Druid.Feral(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources
	local combo 											= UnitPower('player', Enum.PowerType.ComboPoints);
	local energy 											= UnitPower('player', Enum.PowerType.Energy);
	local energyMax 										= UnitPowerMax('player', Enum.PowerType.Energy);

--Abilities	
	local soothe											= ConRO:AbilityReady(ids.Druid_Ability.Soothe, timeShift); 
	local prowl 											= ConRO:AbilityReady(ids.Druid_Ability.Prowl, timeShift);
		local pr 												= ConRO:Form(ids.Druid_Form.Prowl);
	local shred												= ConRO:AbilityReady(ids.Druid_Ability.Shred, timeShift);
	local mang												= ConRO:AbilityReady(ids.Druid_Ability.Mangle, timeShift);
	local fbite												= ConRO:AbilityReady(ids.Druid_Ability.FerociousBite, timeShift);
	local catform 											= ConRO:AbilityReady(ids.Druid_Ability.CatForm, timeShift);
		local bf												= ConRO:Form(ids.Druid_Form.BearForm);
		local cf												= ConRO:Form(ids.Druid_Form.CatForm);
	local regrow 											= ConRO:AbilityReady(ids.Druid_Ability.Regrowth, timeShift);
	
	local tfury 											= ConRO:AbilityReady(ids.Feral_Ability.TigersFury, timeShift + 0.5);
		local tfBuff											= ConRO:Aura(ids.Feral_Buff.TigersFury, timeShift);
	local berserk											= ConRO:AbilityReady(ids.Feral_Ability.Berserk, timeShift);
		local berBuff											= ConRO:Aura(ids.Feral_Buff.Berserk, timeShift);
	local sbash 											= ConRO:AbilityReady(ids.Feral_Ability.SkullBash, timeShift);
	local rake												= ConRO:AbilityReady(ids.Feral_Ability.Rake, timeShift);
		local rakeDebuff 										= ConRO:TargetAura(ids.Feral_Debuff.Rake, timeShift + 4);
		local rakeStun 											= ConRO:TargetAura(ids.Feral_Debuff.RakeStun, timeShift);
	local rip												= ConRO:AbilityReady(ids.Feral_Ability.Rip, timeShift);
		local ripDebuff, _, ripDur 								= ConRO:TargetAura(ids.Feral_Debuff.Rip, timeShift);
	local mfire												= ConRO:AbilityReady(ids.Feral_Talent.Moonfire_Cat, timeShift);
		local mfDebuff											= ConRO:TargetAura(ids.Feral_Debuff.Moonfire, timeShift + 4);
	local thrash											= ConRO:AbilityReady(ids.Feral_Ability.Thrash, timeShift);
		local thrDebuff 										= ConRO:TargetAura(ids.Feral_Debuff.Thrash_Cat, timeShift + 2);
		local thrBCD 											= ConRO:Cooldown(ids.Feral_Ability.Thrash_Bear, timeShift);
		local thrBDebuff, thrBCount 							= ConRO:TargetAura(ids.Feral_Debuff.Thrash_Bear, timeShift);
	local swipe												= ConRO:AbilityReady(ids.Feral_Ability.Swipe, timeShift);
	local swipeB											= ConRO:AbilityReady(ids.Feral_Ability.Swipe_Bear, timeShift);
	local maim												= ConRO:AbilityReady(ids.Feral_Ability.Maim, timeShift);

		local psBuff											= ConRO:Aura(ids.Feral_Buff.PredatorySwiftness, timeShift);
		local ccBuff 											= ConRO:Aura(ids.Feral_Buff.Clearcasting, timeShift);
		
	local kotj												= ConRO:AbilityReady(ids.Feral_Talent.IncarnationKingoftheJungle, timeShift);
		local kotjBuff 											= ConRO:Aura(ids.Feral_Buff.IncarnationKingoftheJungle, timeShift);
	local bslash											= ConRO:AbilityReady(ids.Feral_Talent.BrutalSlash, timeShift);
		local bsCharges, bsMaxCharges, bsCCD					= ConRO:SpellCharges(ids.Feral_Talent.BrutalSlash);
	local ffrenzy			 								= ConRO:AbilityReady(ids.Feral_Talent.FeralFrenzy, timeShift);
	local sroar				 								= ConRO:AbilityReady(ids.Feral_Talent.SavageRoar, timeShift);
		local srBuff, _, srDur									= ConRO:Aura(ids.Feral_Buff.SavageRoar, timeShift);
	local wcharge 											= ConRO:AbilityReady(ids.Feral_Talent.WildCharge, timeShift);
	local pwrath 											= ConRO:AbilityReady(ids.Feral_Talent.PrimalWrath, timeShift);

	local azChosen_IronJaws, azCount_IronJaws				= ConRO:AzPowerChosen(ids.AzTrait.IronJaws);
		local ijAzBuff											= ConRO:Aura(ids.AzTraitBuff.IronJaws, timeShift);
	
	local azEssence_BloodoftheEnemy							= ConRO:AbilityReady(ids.AzEssence.BloodoftheEnemy, timeShift);	
	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
		local cfAzDebuff										= ConRO:TargetAura(ids.AzTraitDebuff.ConcentratedFlame, timeShift)
	local azEssence_GuardianofAzeroth						= ConRO:AbilityReady(ids.AzEssence.GuardianofAzeroth, timeShift);
	local azEssence_MemoryofLucidDream						= ConRO:AbilityReady(ids.AzEssence.MemoryofLucidDream, timeShift);
		local moldAzEssBuff										= ConRO:Aura(ids.AzEssenceBuff.MemoryofLucidDream, timeShift);
			
--Conditions
	local inMelee 											= ConRO:IsSpellInRange(GetSpellInfo(ids.Feral_Ability.Rake), 'target');	
	local incombat 											= UnitAffectingCombat('player');
	local targetPh 											= ConRO:PercentHealth('target');
	local tarInMelee										= ConRO:Targets(ids.Feral_Ability.Rake);
	
--Indicators		
	ConRO:AbilityInterrupt(ids.Feral_Ability.SkullBash, sbash and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Druid_Ability.Soothe, soothe and ConRO:Purgable());
	
	ConRO:AbilityBurst(ids.Feral_Ability.Berserk, berserk and ConRO_BurstButton:IsVisible() and not tChosen[ids.Feral_Talent.IncarnationKingoftheJungle]);
	ConRO:AbilityBurst(ids.Feral_Talent.IncarnationKingoftheJungle, kotj and ConRO_BurstButton:IsVisible());

--Rotations	
	if bf then
		if not inMelee and wcharge then
			return ids.Feral_Talent.WildCharge_Bear;
		end

		if thrash and thrBCD <= 0 and thrBCount < 3 then
			return ids.Feral_Ability.Thrash_Bear;
		end

		if mang then
			return ids.Druid_Ability.Mangle;
		end
		
		if thrash and thrBCD <= 0 then
			return ids.Feral_Ability.Thrash_Bear;
		end
		
		if swipe then
			return ids.Feral_Ability.Swipe_Bear;
		end
	
		return;
	end
	
	if not incombat then 
		if catform and not cf then
			return ids.Druid_Ability.CatForm;
		end
		
		if prowl and not pr then
			return ids.Druid_Ability.Prowl;
		end

		if wcharge and not inMelee then
			return ids.Feral_Talent.WildCharge_Cat;
		end
		
		if rake and not rakeDebuff then
			return ids.Feral_Ability.Rake;
		end		
	
	elseif (ConRO_AutoButton:IsVisible() and tarInMelee >= 4) or ConRO_AoEButton:IsVisible() then
		if catform and not cf then
			return ids.Druid_Ability.CatForm;
		end

		if regrow and psBuff and not btBuff and combo >= 4 and tChosen[ids.Feral_Talent.Bloodtalons] then
			return ids.Druid_Ability.Regrowth;
		end

		if tfury and not tfBuff and energy <= energyMax - 50 then
			return ids.Feral_Ability.TigersFury;
		end

		if ffrenzy and combo <= 0 then
			return ids.Feral_Talent.FeralFrenzy;
		end
		
		if berserk and ConRO_FullButton:IsVisible() and not tChosen[ids.Feral_Talent.IncarnationKingoftheJungle] then
			return ids.Feral_Ability.Berserk;
		end

		if kotj and ConRO_FullButton:IsVisible() then
			return ids.Feral_Talent.IncarnationKingoftheJungle;
		end
		
		if bslash and (bsCharges == bsMaxCharges or (bsCharges == bsMaxCharges - 1 and bsCCD <= 1.5)) then
			return ids.Feral_Talent.BrutalSlash;
		end
		
		if pwrath and combo == 5 then
			return ids.Feral_Talent.PrimalWrath;
		end

		if thrash and not thrDebuff then
			return ids.Feral_Ability.Thrash_Cat;
		end
		
		if rake and not rakeDebuff then
			return ids.Feral_Ability.Rake;
		end
		
		if sroar and (not srBuff or srDur <= 10) and combo == 5 then
			return ids.Feral_Talent.SavageRoar;
		end
		
		if rip and not ripDebuff and combo == 5 then
			return ids.Feral_Ability.Rip;
		end
		
		if fbite and combo >= 5 and ripDebuff then
			return ids.Druid_Ability.FerociousBite;
		end
			
		if bslash and thrDebuff and bsCharges >= 1 and combo <= 4 then
			return ids.Feral_Talent.BrutalSlash;
		end

		if swipe and rakeDebuff and not tChosen[ids.Feral_Talent.BrutalSlash] and combo <= 4 then
			return ids.Feral_Ability.Swipe_Cat;
		end
	else
		if catform and not cf then
			return ids.Druid_Ability.CatForm;
		end

		if azEssence_ConcentratedFlame and tfBuff and not cfAzDebuff then
			return ids.AzEssence.ConcentratedFlame;
		end
		
		if regrow and psBuff and combo >= 4 and not btBuff and tChosen[ids.Feral_Talent.Bloodtalons] then
			return ids.Druid_Ability.Regrowth;
		end

		if tfury and not tfBuff and energy <= energyMax - 70 then
			return ids.Feral_Ability.TigersFury;
		end

		if ffrenzy and combo <= 0 then
			return ids.Feral_Talent.FeralFrenzy;
		end
		
		if berserk and ConRO_FullButton:IsVisible() and not tChosen[ids.Feral_Talent.IncarnationKingoftheJungle] then
			return ids.Feral_Ability.Berserk;
		end

		if kotj and ConRO_FullButton:IsVisible() then
			return ids.Feral_Talent.IncarnationKingoftheJungle;
		end
		
		if pwrath and combo == 5 and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible()) then
			return ids.Feral_Talent.PrimalWrath;
		end		
		
		if bslash and (bsCharges == bsMaxCharges or (bsCharges == bsMaxCharges - 1 and bsCCD <= 1.5)) and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
			return ids.Feral_Talent.BrutalSlash;
		end	
		
		if rip and not ripDebuff and combo >= 5 then
			return ids.Feral_Ability.Rip;
		end
			
		if tChosen[ids.Feral_Talent.Sabertooth] then
			if fbite and ripDur <= 9 and combo >= 5 then
				return ids.Druid_Ability.FerociousBite;
			end
		else
			if rip and ripDur <= 7 and combo >= 5 then
				return ids.Feral_Ability.Rip;
			end
		end
		
		if rake and not rakeDebuff then
			return ids.Feral_Ability.Rake;
		end	
		
		if sroar and (not srBuff or srDur <= 9) and combo >= 5 then
			return ids.Feral_Talent.SavageRoar;
		end
		
		if maim and combo >= 5 and azChosen_IronJaws and azCount_IronJaws >= 2 and ijAzBuff then
			return ids.Feral_Ability.Maim;
		end
		
		if fbite and apBuff then
			return ids.Druid_Ability.FerociousBite;
		end
		
		if fbite and combo >= 5 and ripDur >= 10 and (not tChosen[ids.Feral_Talent.SavageRoar] or (tChosen[ids.Feral_Talent.SavageRoar] and srDur >= 10)) then
			return ids.Druid_Ability.FerociousBite;
		end

		if mfire and not mfDebuff and tChosen[ids.Feral_Talent.LunarInspiration] then
			return ids.Feral_Talent.Moonfire_Cat;
		end
		
		if thrash and not thrDebuff and (ConRO:AzPowerChosen(ids.AzTrait.WildFleshrending) or (ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
			return ids.Feral_Ability.Thrash_Cat;
		end
		
		if swipe and rakeDebuff and not tChosen[ids.Feral_Talent.BrutalSlash] and combo <= 4 and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible()) then
			return ids.Feral_Ability.Swipe_Cat;
		end
		
		if bslash and combo <= 4 and ((ConRO_AutoButton:IsVisible() and not ccBuff) or ConRO_AoEButton:IsVisible()) then
			return ids.Feral_Talent.BrutalSlash;
		end
		
		if shred and combo <= 4 then
			return ids.Druid_Ability.Shred;
		end
	end
return nil;
end

function ConRO.Druid.FeralDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities
	local surv 												= ConRO:AbilityReady(ids.Feral_Ability.SurvivalInstincts, timeShift);
	
	local renewal 											= ConRO:AbilityReady(ids.Feral_Talent.Renewal, timeShift);

--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');

--Rotations	
	if renewal and playerPh <= 60 then
		return ids.Feral_Talent.Renewal;
	end
	
	if surv then
		return ids.Feral_Ability.SurvivalInstincts;
	end
	
	return nil;
end

function ConRO.Druid.Guardian(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources
	local rage 												= UnitPower('player', Enum.PowerType.Rage);
	local rageMax 											= UnitPowerMax('player', Enum.PowerType.Rage);

--Abilities	
	local soothe											= ConRO:AbilityReady(ids.Druid_Ability.Soothe, timeShift); 
	local bearform 											= ConRO:AbilityReady(ids.Druid_Ability.BearForm, timeShift);
		local bf 												= ConRO:Form(ids.Druid_Form.BearForm);
	local growl 											= ConRO:AbilityReady(ids.Druid_Ability.Growl, timeShift);
	local mfire 											= ConRO:AbilityReady(ids.Druid_Ability.Moonfire, timeShift);
		local ggBuff 											= ConRO:Aura(ids.Guard_Buff.GalacticGuardian, timeShift);
		local mfDebuff 											= ConRO:TargetAura(ids.Druid_Debuff.Moonfire, timeShift);
	local mang 												= ConRO:AbilityReady(ids.Druid_Ability.Mangle, timeShift);
	local thr 												= ConRO:AbilityReady(ids.Guard_Ability.Thrash, timeShift);
		local thrCD 											= ConRO:Cooldown(ids.Guard_Ability.Thrash_Bear, timeShift);
		local thrDebuff, thrCount 								= ConRO:TargetAura(ids.Guard_Debuff.Thrash, timeShift);
	local swipe 											= ConRO:AbilityReady(ids.Guard_Ability.Swipe, timeShift);
	local sbash 											= ConRO:AbilityReady(ids.Guard_Ability.SkullBash, timeShift);
	local maul												= ConRO:AbilityReady(ids.Guard_Ability.Maul, timeShift);
	
	local wildG 											= ConRO:AbilityReady(ids.Guard_Talent.WildCharge, timeShift);
	local pulv 												= ConRO:AbilityReady(ids.Guard_Talent.Pulverize, timeShift);
		local pulvBuff 											= ConRO:Aura(ids.Guard_Buff.PulverizeBuff, timeShift + 3);
	local gou	 											= ConRO:AbilityReady(ids.Guard_Talent.IncarnationGuardianofUrsoc, timeShift);
		local gouBuff 											= ConRO:Aura(ids.Guard_Buff.IncarnationGuardianofUrsoc, timeShift);
	
		local gwAzTBuff, gwAzTBCount							= ConRO:Aura(ids.AzTraitBuff.GuardiansWrath, timeShift);
	
--Conditions	
	local inRange 											= ConRO:IsSpellInRange(GetSpellInfo(ids.Guard_Talent.WildCharge_Bear), 'target');
	local incombat 											= UnitAffectingCombat('player');
	local tarInMelee										= ConRO:Targets(ids.Druid_Ability.Mangle);
	
--Indicators	
	ConRO:AbilityInterrupt(ids.Guard_Ability.SkullBash, sbash and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Druid_Ability.Soothe, soothe and ConRO:Purgable());
	
	ConRO:AbilityTaunt(ids.Druid_Ability.Growl, growl);

	ConRO:AbilityBurst(ids.Guard_Talent.IncarnationGuardianofUrsoc, gou and incombat and ConRO:TarYou());
	
--Rotations	
	if bearform and not bf then
		return ids.Druid_Ability.BearForm;
	end
	
	if inRange and wildG then
		return ids.Guard_Talent.WildCharge_Bear;
	end
	
	if tarInMelee >= 3 then
		if mang and gouBuff and tarInMelee <= 4 then
			return ids.Druid_Ability.Mangle;
		end
		
		if thr and thrCD <= 0 then
			return ids.Guard_Ability.Thrash_Bear;
		end	

		if mfire and not mfDebuff and not tChosen[ids.Feral_Talent.GalacticGuardian] and not gouBuff and tarInMelee <= 4 then
			return ids.Druid_Ability.Moonfire;
		end		

		if swipe then
			return ids.Guard_Ability.Swipe_Bear;
		end		
	else
		if mfire and not mfDebuff then
			return ids.Druid_Ability.Moonfire;
		end

		if thr and thrCD <= 0 and thrCount < 3 then
			return ids.Guard_Ability.Thrash_Bear;
		end

		if pulv and not pulvBuff and thrCount >= 3 then
			return ids.Guard_Talent.Pulverize;
		end
		
		if thr and thrCD <= 0 and tarInMelee >= 2 then
			return ids.Guard_Ability.Thrash_Bear;
		end	
		
		if mang then
			return ids.Druid_Ability.Mangle;
		end
		
		if mfire and ggBuff then
			return ids.Druid_Ability.Moonfire;
		end
		
		if thr and thrCD <= 0 then
			return ids.Guard_Ability.Thrash_Bear;
		end	
		
		if maul and not ConRO:TarYou() and (rage >= 90 or (ConRO:AzPowerChosen(ids.AzTrait.GuardiansWrath) and gwAzTBCount < 3)) then
			return ids.Guard_Ability.Maul;
		end	
		
		if swipe then
			return ids.Guard_Ability.Swipe_Bear;
		end
	end
	return nil;
end

function ConRO.Druid.GuardianDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources
	local rage 												= UnitPower('player', Enum.PowerType.Rage);
	local rageMax 											= UnitPowerMax('player', Enum.PowerType.Rage);	

--Abilities	
	local surv 												= ConRO:AbilityReady(ids.Guard_Ability.SurvivalInstincts, timeShift);
	local bark 												= ConRO:AbilityReady(ids.Druid_Ability.Barkskin, timeShift);
	local iron 												= ConRO:AbilityReady(ids.Druid_Ability.Ironfur, timeShift);
	local fregen 											= ConRO:AbilityReady(ids.Guard_Ability.FrenziedRegeneration, timeShift);
	
	local ironBuff, ifBCount								= ConRO:Aura(ids.Druid_Buff.Ironfur, timeShift);

--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');

--Rotations	
	if fregen and playerPh <= 60 then
		return ids.Guard_Ability.FrenziedRegeneration;
	end
	
	if iron and ConRO:TarYou() and ifBCount < 4 then
		return ids.Druid_Ability.Ironfur;
	end
	
	if bark then
		return ids.Druid_Ability.Barkskin;
	end
	
	if surv then
		return ids.Guard_Ability.SurvivalInstincts;
	end	
	
	return nil;
end

function ConRO.Druid.Restoration(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities
	local soothe											= ConRO:AbilityReady(ids.Druid_Ability.Soothe, timeShift); 
	local tranq 											= ConRO:AbilityReady(ids.Resto_Ability.Tranquility, timeShift);
	local lbloom 											= ConRO:AbilityReady(ids.Resto_Ability.Lifebloom, timeShift);
	local regrow 											= ConRO:AbilityReady(ids.Druid_Ability.Regrowth, timeShift);
	
--Indicators	
	ConRO:AbilityPurge(ids.Druid_Ability.Soothe, soothe and ConRO:Purgable());
	
	ConRO:AbilityBurst(ids.Resto_Ability.Tranquility, tranq);

	ConRO:AbilityRaidBuffs(ids.Resto_Ability.Lifebloom, lbloom and not ConRO:OneBuff(ids.Resto_Buff.Lifebloom));
	
	return nil;
end

function ConRO.Druid.RestorationDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities
	local bark 												= ConRO:AbilityReady(ids.Druid_Ability.Barkskin, timeShift);
	
	local renewal 											= ConRO:AbilityReady(ids.Resto_Talent.Renewal, timeShift);

--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');

--Rotations	
	if renewal and playerPh <= 60 then
		return ids.Resto_Talent.Renewal;
	end
	
	if bark then
		return ids.Druid_Ability.Barkskin;
	end
		
	return nil;
end
