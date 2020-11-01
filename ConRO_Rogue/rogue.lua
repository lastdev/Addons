ConRO.Rogue = {};
ConRO.Rogue.CheckTalents = function()
end
local ConRO_Rogue, ids = ...;

function ConRO:EnableRotationModule(mode)
    mode = mode or 1;
    self.ModuleOnEnable = ConRO.Rogue.CheckTalents;
	self.ModuleOnEnable = ConRO.Rogue.CheckPvPTalents;
    if mode == 1 then
	    self.Description = 'Rogue [Assassination]';
        self.NextSpell = ConRO.Rogue.Assassination;
		self.ToggleDamage();
    end;
    if mode == 2 then
	    self.Description = 'Rogue [Outlaw]';
        self.NextSpell = ConRO.Rogue.Outlaw;
		self.ToggleDamage();
    end;
    if mode == 3 then
	    self.Description = 'Rogue [Sublety]';
        self.NextSpell = ConRO.Rogue.Subtlety;
		self.ToggleDamage();
    end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Rogue.CheckTalents;
	self.ModuleOnEnable = ConRO.Rogue.CheckPvPTalents;
	if mode == 1 then
		self.NextDef = ConRO.Rogue.AssassinationDef;
	end;
	if mode == 2 then
		self.NextDef = ConRO.Rogue.OutlawDef;
	end;
	if mode == 3 then
		self.NextDef = ConRO.Rogue.SubletyDef;
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Rogue.Assassination(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources
	local energy 											= UnitPower('player', Enum.PowerType.Energy);
	local energyMax 										= UnitPowerMax('player', Enum.PowerType.Energy);
	local energyPercent 									= math.max(0, energy) / math.max(1, energyMax) * 100;	
    local combo 											= UnitPower('player', Enum.PowerType.ComboPoints);
	local comboMax 											= UnitPowerMax('player', Enum.PowerType.ComboPoints);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities
	local ambushRDY											= ConRO:AbilityReady(ids.Ass_Ability.Ambush, timeShift);
	local kick 												= ConRO:AbilityReady(ids.Ass_Ability.Kick, timeShift);
	local sprint 											= ConRO:AbilityReady(ids.Ass_Ability.Sprint, timeShift);	
	local sstep												= ConRO:AbilityReady(ids.Ass_Ability.Shadowstep, timeShift);
	local pknife											= ConRO:AbilityReady(ids.Ass_Ability.PoisonedKnife, timeShift);	
	local stealth 											= ConRO:AbilityReady(ids.Ass_Ability.Stealth, timeShift);
		local _, substealth										= ConRO:AbilityReady(ids.Ass_Talent.SubStealth, timeShift);
		local subBuff											= ConRO:Aura(ids.Ass_Buff.Subterfuge, timeShift);	
		local maBuff											= ConRO:Aura(ids.Ass_Buff.MasterAssassin, timeShift);			
	local garrote 											= ConRO:AbilityReady(ids.Ass_Ability.Garrote, timeShift);
		local gDebuff, _, gDur									= ConRO:TargetAura(ids.Ass_Debuff.Garrote, timeShift);
	local vanish 											= ConRO:AbilityReady(ids.Ass_Ability.Vanish, timeShift);
		local vaBuff											= ConRO:Aura(ids.Ass_Buff.Vanish, timeShift);
	local vendetta 											= ConRO:AbilityReady(ids.Ass_Ability.Vendetta, timeShift);
		local vDebuff											= ConRO:TargetAura(ids.Ass_Debuff.Vendetta, timeShift);
	local fok 												= ConRO:AbilityReady(ids.Ass_Ability.FanofKnives, timeShift);
		local hBladesBUFF, hBladesCOUNT							= ConRO:Form(ids.Ass_Buff.HiddenBlades);
	local muti 												= ConRO:AbilityReady(ids.Ass_Ability.Mutilate, timeShift);
	local envenom											= ConRO:AbilityReady(ids.Ass_Ability.Envenom, timeShift);
		local eBuff											= ConRO:Aura(ids.Ass_Buff.Envenom, timeShift + 1);
	local rupture											= ConRO:AbilityReady(ids.Ass_Ability.Rupture, timeShift);		
		local rDebuff, _, rDur									= ConRO:TargetAura(ids.Ass_Debuff.Rupture, timeShift);
	local sndRDY											= ConRO:AbilityReady(ids.Ass_Ability.SliceandDice, timeShift);
		local sndBUFF											= ConRO:Aura(ids.Ass_Buff.SliceandDice, timeShift);

	local bside												= ConRO:AbilityReady(ids.Ass_Talent.Blindside, timeShift);	
		local bsBuff											= ConRO:Aura(ids.Ass_Buff.Blindside, timeShift);
	local exsang, exCD, exMaxCD								= ConRO:AbilityReady(ids.Ass_Talent.Exsanguinate, timeShift);
	local ctempest											= ConRO:AbilityReady(ids.Ass_Talent.CrimsonTempest, timeShift);
		local ctDebuff											= ConRO:TargetAura(ids.Ass_Debuff.CrimsonTempest, timeShift + 2);	
	local mdeath 											= ConRO:AbilityReady(ids.Ass_Talent.MarkedforDeath, timeShift);
		local modDebuff											= ConRO:TargetAura(ids.Ass_Debuff.MarkedforDeath, timeShift);
	
	local dpoison 											= ConRO:Aura(ids.Ass_Buff.DeadlyPoison, timeShift);
		local dpDebuff											= ConRO:TargetAura(ids.Ass_Debuff.DeadlyPoison, timeShift);
	local ipoison 											= ConRO:Aura(ids.Ass_Buff.InstantPoison, timeShift);
	local wpoison 											= ConRO:Aura(ids.Ass_Buff.WoundPoison, timeShift);
	local cpoison 											= ConRO:Aura(ids.Ass_Buff.CripplingPoison, timeShift);
	local epBuff	 										= ConRO:Aura(ids.Ass_Buff.ElaboratePlanning, timeShift);

	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	local azEssence_FocusedAzeriteBeam						= ConRO:AbilityReady(ids.AzEssence.FocusedAzeriteBeam, timeShift);
	
--Conditions	
	local inMelee 											= ConRO:IsSpellInRange(GetSpellInfo(ids.Ass_Ability.Kick), 'target');
	local inMovementRange									= ConRO:IsSpellInRange(GetSpellInfo(ids.Ass_Ability.Shadowstep), 'target');
	local incombat 											= UnitAffectingCombat('player');
	local stealthed											= IsStealthed();
	local targetPh 											= ConRO:PercentHealth('target');	
	local toClose 											= CheckInteractDistance("target", 3);
	local tarInMelee										= ConRO:Targets(ids.Ass_Ability.Kick);
	
	local castStealth = ids.Ass_Ability.Stealth
	if tChosen[ids.Ass_Talent.Subterfuge] then
		stealth = substealth;
		castStealth = ids.Ass_Talent.SubStealth;
	end
	
	local lethalp = false;
		if ipoison then
			lethalp = true;
		elseif dpoison then
			lethalp = true;
		elseif wpoison then
			lethalp = true;
		end

--Indicators		
	ConRO:AbilityInterrupt(ids.Ass_Ability.Kick, kick and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and toClose and ConRO:Purgable());
	ConRO:AbilityMovement(ids.Ass_Ability.Shadowstep, sstep and inMovementRange and not inMelee);	
	ConRO:AbilityMovement(ids.Ass_Ability.Sprint, sprint and not inMelee);	
	
	ConRO:AbilityBurst(ids.Ass_Ability.Vendetta, vendetta and rDebuff and gDebuff and energy <= (energyMax - 30) and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Ass_Ability.Vanish, vanish and incombat and not ConRO:TarYou() and ((combo >= comboMax and not rDebuff and tChosen[ids.Ass_Talent.Subterfuge]) or (tChosen[ids.Ass_Talent.Subterfuge] and not gDebuff)) and ConRO_BurstButton:IsVisible());

	ConRO:AbilityBurst(ids.AzEssence.FocusedAzeriteBeam, azEssence_FocusedAzeriteBeam and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 2) or ConRO_SingleButton:IsVisible()));

--Warnings	
		if not lethalp and (incombat or stealthed) then
			UIErrorsFrame:AddMessage("Put lethal poison on your weapon!!!", 1.0, 0.0, 0.0, 53, 5);
		end
		
--Rotations	
	if not incombat then	
		if stealth and not stealthed and not vaBuff then
			return castStealth;
		end

		if mdeath and combo < 5 then
			return ids.Ass_Talent.MarkedforDeath;
		end
		
		if sndRDY and not sndBUFF and combo >= 5 then
			return ids.Ass_Ability.SliceandDice;
		end
		
		if rupture and not rDebuff and combo >= 5 then
			return ids.Ass_Ability.Rupture;
		end

		if garrote and not gDebuff and tChosen[ids.Ass_Talent.Subterfuge] then
			return ids.Ass_Ability.Garrote;
		end	
		
		if ambushRDY and combo <= (comboMax - 1) then
			return ids.Ass_Ability.Ambush;
		end
		
	else
		if pknife and energyPercent >= 90 and tarInMelee == 0 then
			return ids.Ass_Ability.PoisonedKnife;
		end
		
		if azEssence_ConcentratedFlame then
			return ids.AzEssence.ConcentratedFlame;
		end
		
		if mdeath and combo == 0 and not subBuff and not maBuff then
			return ids.Ass_Talent.MarkedforDeath;
		end
		
		if vendetta and rDebuff and gDebuff and not stealthed and not subBuff and not maBuff and ConRO_FullButton:IsVisible() then
			return ids.Ass_Ability.Vendetta;
		end
		
		if exsang and not stealthed and not subBuff and not maBuff then
			if tChosen[ids.Ass_Talent.DeeperStratagem] then
				if rDur >= 29 and gDur >= 6 then
					return ids.Ass_Talent.Exsanguinate;
				end					
			else
				if rDur >= 25 and gDur >= 6 then
					return ids.Ass_Talent.Exsanguinate;
				end
			end
		end
		
		if vanish and not stealthed and not subBuff and not maBuff and not ConRO:TarYou() and ConRO_FullButton:IsVisible() then
			if tChosen[ids.Ass_Talent.Subterfuge] then			
				if tChosen[ids.Ass_Talent.Exsanguinate] then
					if (exsang and combo == comboMax) or not gDebuff then
						return ids.Ass_Ability.Vanish;
					end
				else
					if not gDebuff or (gDebuff and gDur <= 6) then
						return ids.Ass_Ability.Vanish;
					end
				end
			elseif tChosen[ids.Ass_Talent.Nightstalker] then
				if tChosen[ids.Ass_Talent.Exsanguinate] then
					if not rDebuff and exsang and combo == comboMax then
						return ids.Ass_Ability.Vanish;
					end
				else
					if (not rDebuff or (rDebuff and rDur <= 7)) and combo == comboMax then
						return ids.Ass_Ability.Vanish;
					end
				end	
			else
				if rDebuff and gDebuff then
					return ids.Ass_Ability.Vanish;
				end
			end
		end

		if rupture and combo >= (comboMax - 1) and (not rDebuff or (rDebuff and rDur <= 7)) then	
			return ids.Ass_Ability.Rupture;
		end		

		if tChosen[ids.Ass_Talent.Subterfuge] then
			if garrote and (not gDebuff	or (gDebuff and gDur <= 18 and subBuff)) then
				return ids.Ass_Ability.Garrote;
			end
		else
			if garrote and (not gDebuff	or (gDebuff and gDur <= 3)) then
				return ids.Ass_Ability.Garrote;
			end
		end
		
		if sndRDY and not sndBUFF and combo >= (comboMax - 1) then
			return ids.Ass_Ability.SliceandDice;
		end
		
		if ctempest and not ctDebuff and combo >= (comboMax - 1) and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
			return ids.Ass_Talent.CrimsonTempest;
		end
	
		if envenom and combo >= (comboMax - 1) and not ebuff then
			return ids.Ass_Ability.Envenom;
		end

		if fok and combo <= (comboMax - 1) and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible() or hBladesCOUNT >= 20) then
			return ids.Ass_Ability.FanofKnives;
		end
		
		if ambushRDY and bsBuff and combo <= (comboMax - 1) then
			return ids.Ass_Ability.Ambush;
		end

		if muti and combo <= (comboMax - 1) and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 3) or ConRO_SingleButton:IsVisible()) then
			return ids.Ass_Ability.Mutilate;
		end
	end
return nil;
end

function ConRO.Rogue.AssassinationDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities	
	local eva 												= ConRO:AbilityReady(ids.Ass_Ability.Evasion, timeShift);
	local crim 												= ConRO:AbilityReady(ids.Ass_Ability.CrimsonVial, timeShift);

--Conditions	
	local ph 												= ConRO:PercentHealth('player');
	local stealthed											= IsStealthed();

--Rotations	
	if crim and ph <= 70 then
		return ids.Ass_Ability.CrimsonVial;
	end
	
	if not stealthed then
		if eva then
			return ids.Ass_Ability.Evasion;
		end
	end
	return nil;
end

function ConRO.Rogue.Outlaw(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources
	local energy 											= UnitPower('player', Enum.PowerType.Energy);
	local energyMax 										= UnitPowerMax('player', Enum.PowerType.Energy);
    local combo 											= UnitPower('player', Enum.PowerType.ComboPoints);
	local comboMax 											= UnitPowerMax('player', Enum.PowerType.ComboPoints);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities	
	local kick 												= ConRO:AbilityReady(ids.Out_Ability.Kick, timeShift);
	local stealth 											= ConRO:AbilityReady(ids.Out_Ability.Stealth, timeShift);
	local sprint 											= ConRO:AbilityReady(ids.Out_Ability.Sprint, timeShift);
	local adren 											= ConRO:AbilityReady(ids.Out_Ability.AdrenalineRush, timeShift);
		local arBuff 											= ConRO:Aura(ids.Out_Buff.AdrenalineRush, timeShift);
		local lDiceBUFF											= ConRO:Aura(ids.Out_Buff.LoadedDice, timeShift);
	local ps 												= ConRO:AbilityReady(ids.Out_Ability.PistolShot, timeShift);
		local opBuff											= ConRO:Aura(ids.Out_Buff.Opportunity, timeShift);
	local rtb 												= ConRO:AbilityReady(ids.Out_Ability.RolltheBones, timeShift);
	local amb 												= ConRO:AbilityReady(ids.Out_Ability.Ambush, timeShift);
	local sstrike											= ConRO:AbilityReady(ids.Out_Ability.SinisterStrike, timeShift);
	local dispatch											= ConRO:AbilityReady(ids.Out_Ability.Dispatch, timeShift);
	local ghook												= ConRO:AbilityReady(ids.Out_Ability.GrapplingHook, timeShift);
	local bflurry											= ConRO:AbilityReady(ids.Out_Ability.BladeFlurry, timeShift);
		local bfBuff											= ConRO:Aura(ids.Out_Buff.BladeFlurry, timeShift);	
		local bfCharges											= ConRO:SpellCharges(ids.Out_Ability.BladeFlurry);
	local bteyes											= ConRO:AbilityReady(ids.Out_Ability.BetweentheEyes, timeShift);
	local vanish											= ConRO:AbilityReady(ids.Out_Ability.Vanish, timeShift);
	local sndice 											= ConRO:AbilityReady(ids.Out_Ability.SliceandDice, timeShift);
		local sndBuff 											= ConRO:Aura(ids.Out_Buff.SliceandDice, timeShift + 7);

	local ipoison 											= ConRO:Aura(ids.Ass_Buff.InstantPoison, timeShift);
	local wpoison 											= ConRO:Aura(ids.Ass_Buff.WoundPoison, timeShift);
	
	local gstrike 											= ConRO:AbilityReady(ids.Out_Talent.GhostlyStrike, timeShift + 3);
		local gsDebuff											= ConRO:TargetAura(ids.Out_Debuff.GhostlyStrike, timeShift);
	local mdeath 											= ConRO:AbilityReady(ids.Out_Talent.MarkedforDeath, timeShift);
	local brush, brCD										= ConRO:AbilityReady(ids.Out_Talent.BladeRush, timeShift);
	local kspree, ksCD 										= ConRO:AbilityReady(ids.Out_Talent.KillingSpree, timeShift);

	local azChosen_AceUpYourSleeve							= ConRO:AzPowerChosen(ids.AzTrait.AceUpYourSleeve);		
	local azChosen_Deadshot									= ConRO:AzPowerChosen(ids.AzTrait.Deadshot);
		local azBuff_Deadshot									= ConRO:Form(ids.AzTraitBuff.Deadshot);	
	local azChosen_SnakeEyes, azCount_SnakeEyes				= ConRO:AzPowerChosen(ids.AzTrait.SnakeEyes);
	local azChosen_KeepYourWitsAboutYou						= ConRO:AzPowerChosen(ids.AzTrait.KeepYourWitsAboutYou);
		local azBuff_KeepYourWitsAboutYou, kywayCount			= ConRO:Aura(ids.AzTraitBuff.KeepYourWitsAboutYou, timeShift);	
	
    local rtbBuff = {
        tb 													= ConRO:Aura(ids.Out_Buff.TrueBearing, timeShift + 3),
        rp 													= ConRO:Aura(ids.Out_Buff.RuthlessPrecision, timeShift + 3),
        sc 													= ConRO:Aura(ids.Out_Buff.SkullandCrossbones, timeShift + 3),
        gm 													= ConRO:Aura(ids.Out_Buff.GrandMelee, timeShift + 3),
        bs 													= ConRO:Aura(ids.Out_Buff.Broadside, timeShift + 3),
        bt 													= ConRO:Aura(ids.Out_Buff.BuriedTreasure, timeShift + 3),
    }

	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
		local azCharges_ConcentratedFlame, azMaxCharges_ConcentratedFlame = ConRO:SpellCharges(ids.AzEssence.ConcentratedFlame);
	local azEssence_FocusedAzeriteBeam						= ConRO:AbilityReady(ids.AzEssence.FocusedAzeriteBeam, timeShift);
	local azEssence_GuardianofAzeroth						= ConRO:AbilityReady(ids.AzEssence.GuardianofAzeroth, timeShift);	
	
--Conditions
	local inMelee 											= ConRO:IsSpellInRange(GetSpellInfo(ids.Out_Ability.Dispatch), 'target');	
	local incombat 											= UnitAffectingCombat('player');
	local stealthed											= IsStealthed();
	local toClose 											= CheckInteractDistance("target", 3);
	local tarInMelee										= ConRO:Targets(ids.Out_Ability.Kick);
	
	local rtbCount = 0;
		for k, v in pairs(rtbBuff) do
			if v then
				rtbCount = rtbCount + 1;
			end
		end

    local shouldRoll = false;
		if rtbCount <= 1 and lDiceBUFF then
			shouldRoll = true;
		end
		if (rtbCount == 1 and rtbBuff.bt or rtbBuff.gm) or (rtbCount == 2 and rtbBuff.bt and rtbBuff.gm) then
			shouldRoll = true;
		end
		if rtbCount <= 0 then
			shouldRoll = true;
		end
	
	local broadsideReward = 0
	local oppReward = 0	
		if rtbBuff.bs then
			broadsideReward = broadsideReward + 1;
		end
		if tChosen[ids.Out_Talent.QuickDraw] and opBuff then
			oppReward = oppReward + 1;
		end
	
	local lethalp = false;
		if ipoison then
			lethalp = true;
		elseif wpoison then
			lethalp = true;
		end
		
--Indicators	
	ConRO:AbilityInterrupt(ids.Out_Ability.Kick, kick and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and toClose and ConRO:Purgable());
	ConRO:AbilityMovement(ids.Out_Ability.GrapplingHook, ghook and not inMelee);	
	ConRO:AbilityMovement(ids.Out_Ability.Sprint, sprint and not inMelee);		
	
    ConRO:AbilityBurst(ids.Out_Ability.AdrenalineRush, adren and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Out_Ability.Vanish, vanish and incombat and not ConRO:TarYou());
	ConRO:AbilityBurst(ids.Out_Talent.KillingSpree, kspree and not arBuff and ConRO_BurstButton:IsVisible());	

	ConRO:AbilityBurst(ids.AzEssence.FocusedAzeriteBeam, azEssence_FocusedAzeriteBeam and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 2) or ConRO_SingleButton:IsVisible()));

--Warnings	
		if not lethalp and (incombat or stealthed) then
			UIErrorsFrame:AddMessage("Put lethal poison on your weapon!!!", 1.0, 0.0, 0.0, 53, 5);
		end
		
--Rotations
	if stealth and not stealthed then
		return ids.Out_Ability.Stealth;
	end
		
	if not incombat or stealthed then
		if mdeath and combo < 5 then
			return ids.Out_Talent.MarkedforDeath;
		end
		
		if sndice and not sndBuff and combo >= (comboMax - 1) then
			return ids.Out_Ability.SliceandDice;
		end
		
		if rtb and shouldRoll then
			return ids.Out_Ability.RolltheBones;
		end
		
		if amb and combo <= comboMax - 1 then
			return ids.Out_Ability.Ambush;
		end
	else
		if azEssence_ConcentratedFlame and not bfBuff and azCharges_ConcentratedFlame == azMaxCharges_ConcentratedFlame then
			return ids.AzEssence.ConcentratedFlame;
		end

		if azEssence_GuardianofAzeroth then
			return ids.AzEssence.GuardianofAzeroth;
		end

		if azEssence_FocusedAzeriteBeam and not bfBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible()) then
			return ids.AzEssence.FocusedAzeriteBeam;
		end
		
		if bflurry and not bfBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
			return ids.Out_Ability.BladeFlurry;
		end

		if rtb and shouldRoll then
			return ids.Out_Ability.RolltheBones;
		end

		if sndice and not sndBuff and combo >= (comboMax - 1) then
			return ids.Out_Ability.SliceandDice;
		end

		if gstrike and not gsDebuff and combo <= (comboMax - 1 - broadsideReward) and (((ConRO_AutoButton:IsVisible() and tarInMelee == 1) or ConRO_SingleButton:IsVisible()) or (bfBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()))) then
			return ids.Out_Talent.GhostlyStrike;
		end
		
		if kspree and not arBuff and energy <= energyMax - 35 and ConRO_FullButton:IsVisible() and (((ConRO_AutoButton:IsVisible() and tarInMelee == 1) or ConRO_SingleButton:IsVisible()) or (bfBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()))) then
			return ids.Out_Talent.KillingSpree;
		end		
		
		if brush and (((ConRO_AutoButton:IsVisible() and tarInMelee == 1) or ConRO_SingleButton:IsVisible()) or (bfBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()))) then
			return ids.Out_Talent.BladeRush;
		end	

		if adren and ConRO_FullButton:IsVisible() then
			return ids.Out_Ability.AdrenalineRush;
		end	

		if mdeath and combo <= 1 then
			return ids.Out_Talent.MarkedforDeath;
		end

		if bteyes and combo >= (comboMax - 1) then
			return ids.Out_Ability.BetweentheEyes;
		end
		
		if dispatch and combo >= (comboMax - 1) then
			return ids.Out_Ability.Dispatch;
		end

		if ps and opBuff and combo <= 3 then
			return ids.Out_Ability.PistolShot;
		end

		if sstrike and combo <= (comboMax - 1) then
			return ids.Out_Ability.SinisterStrike;
		end
		
		if azEssence_ConcentratedFlame and azCharges_ConcentratedFlame >= 1 then
			return ids.AzEssence.ConcentratedFlame;
		end		
	end
return nil;
end

function ConRO.Rogue.OutlawDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities	
	local evaRDY											= ConRO:AbilityReady(ids.Out_Ability.Evasion, timeShift);
	local crim 												= ConRO:AbilityReady(ids.Out_Ability.CrimsonVial, timeShift);
	
--Conditions	
	local ph 												= ConRO:PercentHealth('player');
	local stealthed											= IsStealthed();

--Rotations	
	if crim and ph <= 70 then
		return ids.Out_Ability.CrimsonVial;
	end
	
	if not stealthed then
		if evaRDY then
			return ids.Out_Ability.Evasion;
		end
	end
return nil;
end

function ConRO.Rogue.Subtlety(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Resources	
	local energy 											= UnitPower('player', Enum.PowerType.Energy);
	local energyMax											= UnitPowerMax('player', Enum.PowerType.Energy);
    local combo 											= UnitPower('player', Enum.PowerType.ComboPoints);
	local comboMax 											= UnitPowerMax('player', Enum.PowerType.ComboPoints);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	local shadowmeld										= ConRO:AbilityReady(ids.Racial.Shadowmeld, timeShift);
		local smBuff 											= ConRO:Aura(ids.Racial.Shadowmeld, timeShift);		
--Abilities	
	local kick 												= ConRO:AbilityReady(ids.Sub_Ability.Kick, timeShift);
	local sprint 											= ConRO:AbilityReady(ids.Sub_Ability.Sprint, timeShift);	
	local sod 												= ConRO:AbilityReady(ids.Sub_Ability.SymbolsofDeath, timeShift);
		local sodBuff 											= ConRO:Aura(ids.Sub_Buff.SymbolsofDeath, timeShift);
	local stealth 											= ConRO:AbilityReady(ids.Sub_Ability.Stealth, timeShift);
		local _, substealth 									= ConRO:AbilityReady(ids.Sub_Talent.SubStealth, timeShift);
	local sstrike 											= ConRO:AbilityReady(ids.Sub_Ability.Shadowstrike, timeShift);
		local fwDebuff 											= ConRO:TargetAura(ids.Sub_Debuff.FindWeakness, timeShift);	
	local sd, sdCD											= ConRO:AbilityReady(ids.Sub_Ability.ShadowDance, timeShift);
		local sdCharges, sdMaxCharges, sdCCD					= ConRO:SpellCharges(ids.Sub_Ability.ShadowDance);
		local sdBuff 											= ConRO:Aura(ids.Sub_Buff.ShadowDance, timeShift);
	local evis 												= ConRO:AbilityReady(ids.Sub_Ability.Eviscerate, timeShift);
	local bstab 											= ConRO:AbilityReady(ids.Sub_Ability.Backstab, timeShift);
	local sblades 											= ConRO:AbilityReady(ids.Sub_Ability.ShadowBlades, timeShift);
		local sbBuff 											= ConRO:Aura(ids.Sub_Buff.ShadowBlades, timeShift);
	local sstorm 											= ConRO:AbilityReady(ids.Sub_Ability.ShurikenStorm, timeShift);
	local sstep												= ConRO:AbilityReady(ids.Sub_Ability.Shadowstep, timeShift);
	local vanish											= ConRO:AbilityReady(ids.Sub_Ability.Vanish, timeShift);
		local vanBuff 											= ConRO:Aura(ids.Sub_Buff.Vanish, timeShift);
	local sndRDY											= ConRO:AbilityReady(ids.Sub_Ability.SliceandDice, timeShift);
		local sndBUFF											= ConRO:Aura(ids.Sub_Buff.SliceandDice, timeShift);
	local rupRDY											= ConRO:AbilityReady(ids.Ass_Ability.Rupture, timeShift);		
		local rupDEBUFF, _, rupDUR								= ConRO:TargetAura(ids.Ass_Debuff.Rupture, timeShift);
	
	local ipoison 											= ConRO:Aura(ids.Ass_Buff.InstantPoison, timeShift);
	local wpoison 											= ConRO:Aura(ids.Ass_Buff.WoundPoison, timeShift);
	
	local gblade											= ConRO:AbilityReady(ids.Sub_Talent.Gloomblade, timeShift);
	local mdeath											= ConRO:AbilityReady(ids.Sub_Talent.MarkedforDeath, timeShift);
		local mDebuff 											= ConRO:TargetAura(ids.Sub_Debuff.MarkedforDeath, timeShift);	
	local stech												= ConRO:AbilityReady(ids.Sub_Talent.SecretTechnique, timeShift);
	local stornado											= ConRO:AbilityReady(ids.Sub_Talent.ShurikenTornado, timeShift);

	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	local azEssence_FocusedAzeriteBeam						= ConRO:AbilityReady(ids.AzEssence.FocusedAzeriteBeam, timeShift);
	
--Conditions
	local inMelee 											= ConRO:IsSpellInRange(GetSpellInfo(ids.Sub_Ability.Rupture), 'target');	
	local inMovementRange									= ConRO:IsSpellInRange(GetSpellInfo(ids.Sub_Ability.Shadowstep), 'target');	
	local incombat 											= UnitAffectingCombat('player');
	local stealthed											= IsStealthed();
	local toClose 											= CheckInteractDistance("target", 3);
	local tarInMelee										= ConRO:Targets(ids.Out_Ability.Kick);
	
	local castStealth = ids.Sub_Ability.Stealth
	if tChosen[ids.Sub_Talent.Subterfuge] then
		stealth = substealth;
		castStealth = ids.Sub_Talent.SubStealth;
	end
	
	local combatStealth = stealthed or sdBuff or vanBuff or smBuff;
	
	local comboReward = 0;
		if sbBuff then
			comboReward = 1;
		end
		
	local castBstab = ids.Sub_Ability.Backstab;
		if tChosen[ids.Sub_Talent.Gloomblade] then
			bstab = gblade;
			castBstab = ids.Sub_Talent.Gloomblade;
		end		
	local castSstrike = ids.Sub_Ability.Shadowstrike;
		if (ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible() then
			sstrike = sstorm;
			castSstrike = ids.Sub_Ability.ShurikenStorm;
		end

		if (ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible() then
			bstab = sstorm;			
			castBstab = ids.Sub_Ability.ShurikenStorm;
		end

	local lethalp = false;
		if ipoison then
			lethalp = true;
		elseif wpoison then
			lethalp = true;
		end
		
--Indicators		
	ConRO:AbilityInterrupt(ids.Sub_Ability.Kick, kick and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and toClose and ConRO:Purgable());
	ConRO:AbilityMovement(ids.Sub_Ability.Shadowstep, sstep and inMovementRange and not inMelee);	
	ConRO:AbilityMovement(ids.Sub_Ability.Sprint, sprint and not inMelee);		
	
	ConRO:AbilityBurst(ids.Sub_Ability.ShadowBlades, sblades and (ConRO_BurstButton:IsVisible() or ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible())))
	ConRO:AbilityBurst(ids.Sub_Ability.Vanish, vanish and not ConRO:TarYou() and not combatStealth and energy >= 45 and combo <= 3 and ConRO_BurstButton:IsVisible())

	ConRO:AbilityBurst(ids.AzEssence.FocusedAzeriteBeam, azEssence_FocusedAzeriteBeam and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 2) or ConRO_SingleButton:IsVisible()));

--Warnings	
		if not lethalp and (incombat or stealthed) then
			UIErrorsFrame:AddMessage("Put lethal poison on your weapon!!!", 1.0, 0.0, 0.0, 53, 5);
		end
		
--Rotations
	if not incombat then
		if stealth and not stealthed then
			return castStealth;
		end

		if mdeath and combo <= 1 then
			return ids.Sub_Talent.MarkedforDeath;
		end
		
		if sblades and ConRO_FullButton:IsVisible() then
			return ids.Sub_Ability.ShadowBlades;
		end
		
		if sstrike and combatStealth and combo <= comboMax - 1 then
			return castSstrike;
		end	
	else
		if azEssence_ConcentratedFlame then
			return ids.AzEssence.ConcentratedFlame;
		end

		if sblades and ConRO_FullButton:IsVisible() and ConRO_SingleButton:IsVisible() then
			return ids.Sub_Ability.ShadowBlades;
		end
		
		if sndRDY and not sndBUFF and combo >= (comboMax - 1) then
			return ids.Sub_Ability.SliceandDice;
		end
		
		if rupRDY and not rupDEBUFF and combo >= 5 then
			return ids.Sub_Ability.Rupture;
		end
	
		if sd and not combatStealth and (sdCharges == sdMaxCharges or (sdCharges >= sdMaxCharges - 1 and sdCCD >= 45 and combo >= 4)) then
			return ids.Sub_Ability.ShadowDance;
		end
		
		if sod and sd and energy <= energyMax - 40 then
			return ids.Sub_Ability.SymbolsofDeath;
		end
		
		if mdeath and combo <= 1 then
			return ids.Sub_Talent.MarkedforDeath;
		end
		
		if stornado and combo == 0 and sodBuff and sdBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible()) then
			return ids.Sub_Talent.ShurikenTornado;
		end
		
		if vanish and not ConRO:TarYou() and not combatStealth and not fwDebuff and combo <= comboMax - 2 - comboReward and ConRO_FullButton:IsVisible() then
			return ids.Sub_Ability.Vanish;
		end

		if shadowmeld and not ConRO:TarYou() and not combatStealth and not fwDebuff and combo <= comboMax - 2 - comboReward and ConRO_FullButton:IsVisible() then
			return ids.Racial.Shadowmeld;
		end
		
		if sd and not combatStealth and sodBuff then
			return ids.Sub_Ability.ShadowDance;
		end		
	
		if tChosen[ids.Sub_Talent.DarkShadow] and sdBuff then
			if (ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible() then
				if stech and combo >= comboMax - 1 then
					return ids.Sub_Talent.SecretTechnique;
				end
			end
		else
			if (ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible() then
				if stech and combo >= comboMax - 1 then
					return ids.Sub_Talent.SecretTechnique;
				end
			end
		end
		
		if tChosen[ids.Sub_Talent.DarkShadow] then
			if nb and not nbDebuff and combo >= comboMax - 1 and not sdBuff then
				return ids.Sub_Ability.Nightblade;
			end	
		else
			if nb and not nbDebuff and combo >= comboMax - 1 then
				return ids.Sub_Ability.Nightblade;
			end			
		end
		
		if stech and (sodBuff or (sdBuff and tChosen[ids.Sub_Talent.DarkShadow])) and combo >= comboMax - 1 then
			return ids.Sub_Talent.SecretTechnique;
		end		
		
		if evis and combo >= comboMax - 1 then
			return ids.Sub_Ability.Eviscerate;
		end
		
		if sstrike and combatStealth and combo <= comboMax - 2 - comboReward then
			return castSstrike;
		end		
		
		if bstab and combo <= comboMax - 1 - comboReward then
			return castBstab;
		end
	end
    return nil;
end

function ConRO.Rogue.SubletyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Abilities	
	local eva 												= ConRO:AbilityReady(ids.Sub_Ability.Evasion, timeShift);
	local crim 												= ConRO:AbilityReady(ids.Sub_Ability.CrimsonVial, timeShift);

--Conditions	
	local ph 												= ConRO:PercentHealth('player');
	local stealthed												= IsStealthed();

--Rotations	
	if crim and ph <= 70 then
		return ids.Sub_Ability.CrimsonVial;
	end
		
	if not stealthed then	
		if eva then
			return ids.Sub_Ability.Evasion;
		end
	end
	return nil;
end