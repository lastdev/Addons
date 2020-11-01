ConRO.Warrior = {};
ConRO.Warrior.CheckTalents = function()
end
local ConRO_Warrior, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Warrior.CheckTalents;
	if mode == 1 then
		self.Description = 'Warrior [Arms - Melee]';
		self.NextSpell = ConRO.Warrior.Arms;
		self.ToggleDamage();
	end;
	if mode == 2 then
		self.Description = 'Warrior [Fury - Melee]';
		self.NextSpell = ConRO.Warrior.Fury;
		self.ToggleDamage();
	end;
	if mode == 3 then
		self.Description = 'Warrior [Protection - Tank]';
		self.NextSpell = ConRO.Warrior.Protection;
		self.ToggleDamage();
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;	
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Warrior.CheckTalents;
	if mode == 1 then
		self.NextDef = ConRO.Warrior.ArmsDef;
	end;
	if mode == 2 then
		self.NextDef = ConRO.Warrior.FuryDef;
	end;
	if mode == 3 then
		self.NextDef = ConRO.Warrior.ProtectionDef;
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Warrior.Arms(_, timeShift, currentSpell, gcd, tChosen)
--Resources	
	local rage 												= UnitPower('player', Enum.PowerType.Rage);
	local rageMax 											= UnitPowerMax('player', Enum.PowerType.Rage);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities	
	local pummel											= ConRO:AbilityReady(ids.Arms_Ability.Pummel, timeShift);
	local bshout											= ConRO:AbilityReady(ids.Arms_Ability.BattleShout, timeShift);
	local hthrow											= ConRO:AbilityReady(ids.Arms_Ability.HeroicThrow, timeShift);	
	local csmash, csCD										= ConRO:AbilityReady(ids.Arms_Ability.ColossusSmash, timeShift);
		local csDebuff											= ConRO:TargetAura(ids.Arms_Debuff.ColossusSmash, timeShift);
	local mstrike											= ConRO:AbilityReady(ids.Arms_Ability.MortalStrike, timeShift);
		local dwDebuff											= ConRO:TargetAura(ids.Arms_Debuff.DeepWounds, timeShift + 1.5);
	local charge 											= ConRO:AbilityReady(ids.Arms_Ability.Charge, timeShift);
		local inChRange 										= ConRO:IsSpellInRange(GetSpellInfo(ids.Arms_Ability.Charge), 'target');
	local slam 												= ConRO:AbilityReady(ids.Arms_Ability.Slam, timeShift);
		local caAzBuff											= ConRO:Aura(ids.AzTraitBuff.CrushingAssault, timeShift);	
	local ww 												= ConRO:AbilityReady(ids.Arms_Ability.Whirlwind, timeShift);
	local bstorm 											= ConRO:AbilityReady(ids.Arms_Ability.Bladestorm, timeShift);
	local exe												= ConRO:AbilityReady(ids.Arms_Ability.Execute, timeShift);
		local mexeCD 											= ConRO:Cooldown(ids.Arms_Talent.MassacreExecute, timeShift);
		local sdBuff											= ConRO:Aura(ids.Arms_Buff.SuddenDeath, timeShift);
	local opower											= ConRO:AbilityReady(ids.Arms_Ability.Overpower, timeShift);
		local opCharges											= ConRO:SpellCharges(ids.Arms_Ability.Overpower);
		local opBuff, opBCount									= ConRO:Aura(ids.Arms_Buff.Overpower, timeShift);
	local sstrikes											= ConRO:AbilityReady(ids.Arms_Ability.SweepingStrikes, timeShift);
		local ssBuff											= ConRO:Aura(ids.Arms_Buff.SweepingStrikes, timeShift);
		
	local ssplit											= ConRO:AbilityReady(ids.Arms_Talent.Skullsplitter, timeShift);
	local sbolt												= ConRO:AbilityReady(ids.Arms_Talent.StormBolt, timeShift);
	local wbreaker, wbCD									= ConRO:AbilityReady(ids.Arms_Talent.Warbreaker, timeShift);
	local cleave 											= ConRO:AbilityReady(ids.Arms_Talent.Cleave, timeShift);
	local avatar 											= ConRO:AbilityReady(ids.Arms_Talent.Avatar, timeShift);
	local dcalm 											= ConRO:AbilityReady(ids.Arms_Talent.DeadlyCalm, timeShift);
	local rend 												= ConRO:AbilityReady(ids.Arms_Talent.Rend, timeShift);
		local rDebuff											= ConRO:TargetAura(ids.Arms_Debuff.Rend, timeShift + 4);
	local ravager											= ConRO:AbilityReady(ids.Arms_Talent.Ravager, timeShift);

	local azChosen_TestofMight								= ConRO:AzPowerChosen(ids.AzTrait.TestofMight);
		local tomAzBuff											= ConRO:Aura(ids.AzTraitBuff.TestofMight, timeShift);

	local azEssence_BloodoftheEnemy							= ConRO:AbilityReady(ids.AzEssence.BloodoftheEnemy, timeShift);	
	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	local azEssence_GuardianofAzeroth						= ConRO:AbilityReady(ids.AzEssence.GuardianofAzeroth, timeShift);
	local azEssence_MemoryofLucidDream						= ConRO:AbilityReady(ids.AzEssence.MemoryofLucidDream, timeShift);
		local moldAzEssBuff										= ConRO:Aura(ids.AzEssenceBuff.MemoryofLucidDream, timeShift);
		
--Conditions	
	local targetPh 											= ConRO:PercentHealth('target');
	local canExe											= targetPh <= 25;
	local Close 											= CheckInteractDistance("target", 3);
	local tarInMelee										= ConRO:Targets(ids.Arms_Ability.Pummel);
	
	local castExecute = ids.Arms_Ability.Execute;
		if tChosen[ids.Arms_Talent.Massacre] then
			canExe = targetPh <= 35;
			exe = exe and mexeCD <= 0;
			castExecute = ids.Arms_Talent.MassacreExecute;
		end
	
--Indicators		
	ConRO:AbilityInterrupt(ids.Arms_Ability.Pummel, pummel and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityRaidBuffs(ids.Arms_Ability.BattleShout, bshout and not ConRO:RaidBuff(ids.Arms_Ability.BattleShout));
	ConRO:AbilityMovement(ids.Arms_Ability.Charge, charge and inChRange);
	
	ConRO:AbilityBurst(ids.Arms_Talent.Avatar, avatar and (csCD < 10 or (tChosen[ids.Arms_Talent.Warbreaker] and wbCD < 10)) and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Arms_Ability.Bladestorm, bstorm and not ssBuff and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Arms_Talent.Ravager, ravager and ConRO_BurstButton:IsVisible());
	
--Warnings	
	
--Rotations	
	if azEssence_ConcentratedFlame and not csDebuff and not tomAzBuff then
		return ids.AzEssence.ConcentratedFlame;
	end
	
	if ((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) and canExe then
		if ssplit and rage < 60 then
			return ids.Arms_Talent.Skullsplitter;
		end

		if azEssence_GuardianofAzeroth and ((csmash and not tChosen[ids.Arms_Talent.Warbreaker]) or (wbreaker and tChosen[ids.Arms_Talent.Warbreaker])) then
			return ids.AzEssence.GuardianofAzeroth;
		end

		if azEssence_MemoryofLucidDream and ((csmash and not tChosen[ids.Arms_Talent.Warbreaker]) or (wbreaker and tChosen[ids.Arms_Talent.Warbreaker])) then
			return ids.AzEssence.MemoryofLucidDream;
		end

		if avatar and (csCD < 5 or (tChosen[ids.Arms_Talent.Warbreaker] and wbCD < 5)) and ConRO_FullButton:IsVisible() then
			return ids.Arms_Talent.Avatar;
		end

		if tChosen[ids.Arms_Talent.Ravager] then
			if ravager and ConRO_FullButton:IsVisible() then
				return ids.Arms_Talent.Ravager;
			end
		else
			if bstorm and rage < 30 and (csDebuff or (not csDebuff and azChosen_TestofMight)) and ConRO_FullButton:IsVisible() then
				return ids.Arms_Ability.Bladestorm;
			end
		end

		if tChosen[ids.Arms_Talent.Warbreaker] then
			if wbreaker then
				return ids.Arms_Talent.Warbreaker;
			end
		else	
			if csmash then
				return ids.Arms_Ability.ColossusSmash;
			end
		end	

		if azEssence_BloodoftheEnemy and ((csmash and not azChosen_TestofMight) or tomAzBuff) then
			return ids.AzEssence.BloodoftheEnemy;
		end

		if dcalm then
			return ids.Arms_Talent.DeadlyCalm;
		end	
		
		if slam and caAzBuff then
			return ids.Arms_Ability.Slam;
		end

		if mstrike and not dwDebuff then
			return ids.Arms_Ability.MortalStrike;
		end

		if opower and not moldAzEssBuff then
			return ids.Arms_Ability.Overpower;
		end
		
		if exe then
			return castExecute;
		end
	else
		if azEssence_GuardianofAzeroth and ((csmash and not tChosen[ids.Arms_Talent.Warbreaker]) or (wbreaker and tChosen[ids.Arms_Talent.Warbreaker])) and (((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) or (((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) and (ssBuff or tChosen[ids.Arms_Talent.Cleave]))) then
			return ids.AzEssence.GuardianofAzeroth;
		end
		
		if sstrikes and not tChosen[ids.Arms_Talent.Cleave] and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) and (ConRO_BurstButton:IsVisible() or ((not bstorm or tChosen[ids.Arms_Talent.Ravager]) and ConRO_FullButton:IsVisible())) then
			return ids.Arms_Ability.SweepingStrikes;
		end	
	
		if rend and not rDebuff and not csDebuff and (((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) or (((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) and (ssBuff or tChosen[ids.Arms_Talent.Cleave]))) then
			return ids.Arms_Talent.Rend;
		end

		if ssplit and rage < 60 then
			return ids.Arms_Talent.Skullsplitter;
		end

		if azEssence_MemoryofLucidDream and ((csmash and not tChosen[ids.Arms_Talent.Warbreaker]) or (wbreaker and tChosen[ids.Arms_Talent.Warbreaker])) and (((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) or (((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) and ssBuff)) then
			return ids.AzEssence.MemoryofLucidDream;
		end
		
		if avatar and (csCD < 5 or (tChosen[ids.Arms_Talent.Warbreaker] and wbCD < 5)) and ConRO_FullButton:IsVisible() then
			return ids.Arms_Talent.Avatar;
		end

		if ravager and tChosen[ids.Arms_Talent.Ravager] and (csDebuff or (not csDebuff and azChosen_TestofMight)) and ConRO_FullButton:IsVisible() then
			return ids.Arms_Talent.Ravager;
		end
		
		if tChosen[ids.Arms_Talent.Warbreaker] then
			if wbreaker then
				return ids.Arms_Talent.Warbreaker;
			end
		else	
			if csmash and (((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) or (((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) and (ssBuff or tChosen[ids.Arms_Talent.Cleave]))) then
				return ids.Arms_Ability.ColossusSmash;
			end
		end

		if bstorm and (csDebuff or (not csDebuff and azChosen_TestofMight)) and  ((ConRO_AutoButton:IsVisible() and tarInMelee >= 4) or ConRO_AoEButton:IsVisible()) and ConRO_FullButton:IsVisible() then
			return ids.Arms_Ability.Bladestorm;
		end
		
		if azEssence_BloodoftheEnemy and ((csmash and not azChosen_TestofMight) or tomAzBuff) then
			return ids.AzEssence.BloodoftheEnemy;
		end

		if dcalm then
			return ids.Arms_Talent.DeadlyCalm;
		end	
		
		if cleave and not dwDebuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
			return ids.Arms_Talent.Cleave;
		end
		
		if exe and sdBuff and (((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) or (((ConRO_AutoButton:IsVisible() and tarInMelee >= 2 and tarInMelee <= 4) or ConRO_AoEButton:IsVisible()) and (ssBuff or tChosen[ids.Arms_Talent.Cleave]))) then
			return castExecute;
		end
		
		if opower and (opBCount ~= 2 or ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible())) and not (csDebuff and moldAzEssBuff) then
			return ids.Arms_Ability.Overpower;
		end		

		if mstrike and not dwDebuff and (((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) or ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2 and tarInMelee <= 4) or ConRO_AoEButton:IsVisible()) or opBCount == 2 or (csDebuff and moldAzEssBuff)) then
			return ids.Arms_Ability.MortalStrike;
		end
		
		if bstorm and (csDebuff or (not csDebuff and azChosen_TestofMight)) and ConRO_FullButton:IsVisible() then
			return ids.Arms_Ability.Bladestorm;
		end
		
		if slam and not tChosen[ids.Arms_Talent.FervorofBattle] and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible() or ssBuff) and rage >= 50 then
			return ids.Arms_Ability.Slam;
		end
		
		if ww and (rage >= 60 or (csDebuff and moldAzEssBuff)) and (tChosen[ids.Arms_Talent.FervorofBattle] or ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible())) then
			return ids.Arms_Ability.Whirlwind;
		end
	end
return nil;
end

function ConRO.Warrior.ArmsDef(_, timeShift, currentSpell, gcd, tChosen)
--Abilities	
	local rcry												= ConRO:AbilityReady(ids.Arms_Ability.RallyingCry, timeShift);
	local dbts 												= ConRO:AbilityReady(ids.Arms_Ability.DiebytheSword, timeShift);
	local vrush 											= ConRO:AbilityReady(ids.Arms_Ability.VictoryRush, timeShift);
		local vBuff												= ConRO:Aura(ids.Arms_Buff.Victorious, timeShift);
	
	local dstance											= ConRO:AbilityReady(ids.Arms_Talent.DefensiveStance, timeShift);
		local defform											= ConRO:Form(ids.Arms_Form.DefensiveStance);
	local ivic	 											= ConRO:AbilityReady(ids.Arms_Talent.ImpendingVictory, timeShift);
	
--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');

--Rotations	
	if tChosen[ids.Arms_Talent.ImpendingVictory] then
		if ivic and playerPh <= 80 then	
			return ids.Arms_Talent.ImpendingVictory;
		end
	else
		if vrush and vBuff and playerPh < 100 then	
			return ids.Arms_Ability.VictoryRush;
		end
	end
	
	if dbts then
		return ids.Arms_Ability.DiebytheSword;
	end
	
	if rcry then
		return ids.Arms_Ability.RallyingCry;
	end
	
	if dstance and not defform then
		return ids.Arms_Talent.DefensiveStance;
	end	
return nil;
end

function ConRO.Warrior.Fury(_, timeShift, currentSpell, gcd, tChosen)
--Resources	
	local rage 												= UnitPower('player', Enum.PowerType.Rage);
	local rageMax 											= UnitPowerMax('player', Enum.PowerType.Rage);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities	
	local bt 												= ConRO:AbilityReady(ids.Fury_Ability.Bloodthirst, timeShift + 0.5);
		local eBuff 											= ConRO:Aura(ids.Fury_Buff.Enrage, timeShift);
	local rb 												= ConRO:AbilityReady(ids.Fury_Ability.RagingBlow, timeShift + 0.5);
		local rbCharges											= ConRO:SpellCharges(ids.Fury_Ability.RagingBlow);		
	local charge 											= ConRO:AbilityReady(ids.Fury_Ability.Charge, timeShift);
		local inChRange 										= ConRO:IsSpellInRange(GetSpellInfo(ids.Fury_Ability.Charge), 'target');
	local pummel 											= ConRO:AbilityReady(ids.Fury_Ability.Pummel, timeShift);
	local ramp 												= ConRO:AbilityReady(ids.Fury_Ability.Rampage, timeShift);
	local exe 												= ConRO:AbilityReady(ids.Fury_Ability.Execute, timeShift);
		local mexeCD 											= ConRO:Cooldown(ids.Fury_Talent.MassacreExecute, timeShift);
		local sdBuff 											= ConRO:Aura(ids.Fury_Buff.SuddenDeath, timeShift);	
	local ww 												= ConRO:AbilityReady(ids.Fury_Ability.Whirlwind, timeShift);
		local wwBuff, wwBCount									= ConRO:Aura(ids.Fury_Buff.Whirlwind, timeShift + 2);
	local bshout											= ConRO:AbilityReady(ids.Fury_Ability.BattleShout, timeShift);	
	local reck, reckCD										= ConRO:AbilityReady(ids.Fury_Ability.Recklessness, timeShift);
		local reckBuff 											= ConRO:Aura(ids.Fury_Buff.Recklessness, timeShift);
	
	local dr 												= ConRO:AbilityReady(ids.Fury_Talent.DragonRoar, timeShift);
	local bstorm 											= ConRO:AbilityReady(ids.Fury_Talent.Bladestorm, timeShift);
	local sbreaker											= ConRO:AbilityReady(ids.Fury_Talent.Siegebreaker, timeShift);
		local sbDebuff											= ConRO:TargetAura(ids.Fury_Debuff.Siegebreaker, timeShift);
	local onslaughtRDY										= ConRO:AbilityReady(ids.Fury_Talent.Onslaught, timeShift);
	
	local azChosen_CSteelHBlood, azCount_CSteelHBlood		= ConRO:AzPowerChosen(ids.AzTrait.ColdSteelHotBlood);

	local azEssence_BloodoftheEnemy							= ConRO:AbilityReady(ids.AzEssence.BloodoftheEnemy, timeShift);	
	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	local azEssence_GuardianofAzeroth						= ConRO:AbilityReady(ids.AzEssence.GuardianofAzeroth, timeShift);
	local azEssence_MemoryofLucidDream						= ConRO:AbilityReady(ids.AzEssence.MemoryofLucidDream, timeShift);
		local moldAzEssBuff										= ConRO:Aura(ids.AzEssenceBuff.MemoryofLucidDream, timeShift);
	
--Conditions	
	local targetPh 											= ConRO:PercentHealth('target');
	local canExe											= targetPh <= 25;
	local Close 											= CheckInteractDistance("target", 3);
	local tarInMelee										= ConRO:Targets(ids.Fury_Ability.Pummel);
	local incombat 											= UnitAffectingCombat('player');
	
	local castExecute = ids.Fury_Ability.Execute;
		if tChosen[ids.Fury_Talent.Massacre] then
			canExe = targetPh <= 35;
			exe = exe and mexeCD <= 0;
			castExecute = ids.Fury_Talent.MassacreExecute;
		end

--Indicators	
	ConRO:AbilityInterrupt(ids.Fury_Ability.Pummel, pummel and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityRaidBuffs(ids.Fury_Ability.BattleShout, bshout and not ConRO:RaidBuff(ids.Fury_Ability.BattleShout));
	ConRO:AbilityMovement(ids.Fury_Ability.Charge, charge and inChRange);
	
	ConRO:AbilityBurst(ids.Fury_Ability.Recklessness, reck and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Fury_Talent.Bladestorm, bstorm and ConRO_BurstButton:IsVisible());
	
--Warnings	


--Rotations	
	if azEssence_GuardianofAzeroth and (not incombat or reck) then
		return ids.AzEssence.GuardianofAzeroth;
	end
	
	if azEssence_ConcentratedFlame and not (reckBuff or sbDebuff) then
		return ids.AzEssence.ConcentratedFlame;
	end
	
	if ramp and (not eBuff or reckBuff or rage >= 90) and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) then
		return ids.Fury_Ability.Rampage;
	end		

	if azEssence_MemoryofLucidDream and (not tChosen[ids.Fury_Talent.AngerManagement] or (tChosen[ids.Fury_Talent.AngerManagement] and reck)) then
		return ids.AzEssence.MemoryofLucidDream;
	end

	if bt and not eBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
		return ids.Fury_Ability.Bloodthirst;
	end

	if ww and not wwBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
		return ids.Fury_Ability.Whirlwind;
	end	

	if azEssence_BloodoftheEnemy and reckBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
		return ids.AzEssence.BloodoftheEnemy;
	end
	
	if reck and ConRO_FullButton:IsVisible() then
		return ids.Fury_Ability.Recklessness;
	end	

	if azEssence_BloodoftheEnemy and reckBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) then
		return ids.AzEssence.BloodoftheEnemy;
	end
	
	if ramp and not eBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
		return ids.Fury_Ability.Rampage;
	end		

	if bstorm and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) and ConRO_FullButton:IsVisible() then
		return ids.Fury_Talent.Bladestorm;
	end

	if dr and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
		return ids.Fury_Talent.DragonRoar;
	end

	if sbreaker and (reckBuff or reckCD >= 20) and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) then
		return ids.Fury_Talent.Siegebreaker;
	end	

	if exe and eBuff and (sdBuff or canExe) then
		return castExecute;
	end
	
	if bt and (not eBuff or azCount_CSteelHBlood >= 2) then
		return ids.Fury_Ability.Bloodthirst;
	end	
	
	if onslaughtRDY and eBuff then
		return ids.Fury_Talent.Onslaught;
	end
	
	if rb and rbCharges >= 2 then
		return ids.Fury_Ability.RagingBlow;
	end

	if bt then
		return ids.Fury_Ability.Bloodthirst;
	end	
	
	if dr and eBuff then
		return ids.Fury_Talent.DragonRoar;
	end
		
	if bstorm and eBuff and ConRO_FullButton:IsVisible() then
		return ids.Fury_Talent.Bladestorm;
	end	
	
	if rb then
		return ids.Fury_Ability.RagingBlow;
	end	
			
	if ww then
		return ids.Fury_Ability.Whirlwind;
	end
return nil;
end

function ConRO.Warrior.FuryDef(_, timeShift, currentSpell, gcd, tChosen)
--Abilities	
	local rcry 												= ConRO:AbilityReady(ids.Fury_Ability.RallyingCry, timeShift);
	local eregen											= ConRO:AbilityReady(ids.Fury_Ability.EnragedRegeneration, timeShift);
	local vrush 											= ConRO:AbilityReady(ids.Fury_Ability.VictoryRush, timeShift);
		local vBuff												= ConRO:Aura(ids.Fury_Buff.Victorious, timeShift);

	local ivic	 											= ConRO:AbilityReady(ids.Fury_Talent.ImpendingVictory, timeShift);

--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');
	
--Rotations	
	if tChosen[ids.Fury_Talent.ImpendingVictory] then
		if ivic and playerPh <= 80 then	
			return ids.Fury_Talent.ImpendingVictory;
		end
	else
		if vrush and vBuff and playerPh < 100 then	
			return ids.Fury_Ability.VictoryRush;
		end
	end
	
	if eregen then
		return ids.Fury_Ability.EnragedRegeneration;
	end
		
	if rcry then
		return ids.Fury_Ability.RallyingCry;
	end
	
	return nil;
end

function ConRO.Warrior.Protection(_, timeShift, currentSpell, gcd, tChosen)
--Resources	
	local rage 												= UnitPower('player', Enum.PowerType.Rage);
	local rageMax 											= UnitPowerMax('player', Enum.PowerType.Rage);

--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
	
--Abilities	
	local taunt 											= ConRO:AbilityReady(ids.Prot_Ability.Taunt, timeShift);
	local revenge 											= ConRO:AbilityReady(ids.Prot_Ability.Revenge, timeShift);
		local rBuff 											= ConRO:Aura(ids.Prot_Buff.Revenge, timeShift);
	local sslam, ssCD										= ConRO:AbilityReady(ids.Prot_Ability.ShieldSlam, timeShift);
	local tclap												= ConRO:AbilityReady(ids.Prot_Ability.ThunderClap, timeShift);
	local pummel 											= ConRO:AbilityReady(ids.Prot_Ability.Pummel, timeShift);
	local charge 											= ConRO:AbilityReady(ids.Fury_Ability.Charge, timeShift);
		local inChRange 										= ConRO:IsSpellInRange(GetSpellInfo(ids.Fury_Ability.Charge), 'target');
	local devas 											= ConRO:AbilityReady(ids.Prot_Ability.Devastate, timeShift);
	local bshout 											= ConRO:AbilityReady(ids.Prot_Ability.BattleShout, timeShift);	
	local avatar 											= ConRO:AbilityReady(ids.Prot_Ability.Avatar, timeShift);
		local avBuff 											= ConRO:Aura(ids.Prot_Buff.Avatar, timeShift);
	local sw 												= ConRO:AbilityReady(ids.Prot_Ability.Shockwave, timeShift);
	local demoshout											= ConRO:AbilityReady(ids.Prot_Ability.DemoralizingShout, timeShift);
	local sblock 											= ConRO:AbilityReady(ids.Prot_Ability.ShieldBlock, timeShift);
		local sbCharges											= ConRO:SpellCharges(ids.Prot_Ability.ShieldBlock);
		local sbBuff 											= ConRO:Aura(ids.Prot_Buff.ShieldBlock, timeShift);
		
	local ravager 											= ConRO:AbilityReady(ids.Prot_Talent.Ravager, timeShift);
	local sb 												= ConRO:AbilityReady(ids.Prot_Talent.StormBolt, timeShift);

--Conditions	
	local ph 												= ConRO:PercentHealth('target');
	local Close 											= CheckInteractDistance("target", 3);
	local tarInMelee										= ConRO:Targets(ids.Prot_Ability.Pummel);
	
--Indicators		
	ConRO:AbilityInterrupt(ids.Prot_Ability.Pummel, pummel and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityRaidBuffs(ids.Prot_Ability.BattleShout, bshout and not ConRO:RaidBuff(ids.Prot_Ability.BattleShout));
	ConRO:AbilityTaunt(ids.Prot_Ability.Taunt, taunt and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));
	ConRO:AbilityMovement(ids.Prot_Ability.Charge, charge and inChRange);
	
	ConRO:AbilityBurst(ids.Prot_Talent.Ravager, ravager);
	ConRO:AbilityBurst(ids.Prot_Ability.Avatar, avatar and ConRO_BurstButton:IsVisible());

--Warnings	

--Rotations	
	if avatar and ConRO_FullButton:IsVisible() then
		return ids.Prot_Ability.Avatar;
	end

	if tclap and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
		return ids.Prot_Ability.ThunderClap;
	end
	
	if demoshout and tChosen[ids.Prot_Talent.BoomingVoice] then
		return ids.Prot_Ability.DemoralizingShout;
	end

	if revenge and (rBuff or rage >= 60) and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
		return ids.Prot_Ability.Revenge;
	end
	
	if sblock and (sslam or ssCD < 2) and not sbBuff and sbCharges >= 2 then
		return ids.Prot_Ability.ShieldBlock;
	end
	
	if sslam then
		return ids.Prot_Ability.ShieldSlam;
	end	
	
	if tclap and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) then
		return ids.Prot_Ability.ThunderClap;
	end		
	
	if revenge and rBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee <= 1) or ConRO_SingleButton:IsVisible()) then
		return ids.Prot_Ability.Revenge;
	end		
	
	if devas and not tChosen[ids.Prot_Talent.Devastator] then
		return ids.Prot_Ability.Devastate;
	end
	return nil;
end

function ConRO.Warrior.ProtectionDef(_, timeShift, currentSpell, gcd, tChosen)
--Resources	
	local rage 												= UnitPower('player', Enum.PowerType.Rage);

--Abilities	
	local swall 											= ConRO:AbilityReady(ids.Prot_Ability.ShieldWall, timeShift);
	local sblock											= ConRO:AbilityReady(ids.Prot_Ability.ShieldBlock, timeShift);
		local sbCharges											= ConRO:SpellCharges(ids.Prot_Ability.ShieldBlock);
		local sbBuff 											= ConRO:Aura(ids.Prot_Buff.ShieldBlock, timeShift);
	local lstand 											= ConRO:AbilityReady(ids.Prot_Ability.LastStand, timeShift);
	local dshout											= ConRO:AbilityReady(ids.Prot_Ability.DemoralizingShout, timeShift);
	local vrush 											= ConRO:AbilityReady(ids.Prot_Ability.VictoryRush, timeShift);
		local vBuff 											= ConRO:Aura(ids.Prot_Buff.Victorious, timeShift);
	local ipain 											= ConRO:AbilityReady(ids.Prot_Ability.IgnorePain, timeShift);
		local ipBuff 											= ConRO:Aura(ids.Prot_Buff.IgnorePain, timeShift);
	local sReflection										= ConRO:AbilityReady(ids.Prot_Ability.SpellReflection, timeShift);
		
	local ivic 												= ConRO:AbilityReady(ids.Prot_Talent.ImpendingVictory, timeShift);

--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');
	
--Rotations	
	if tChosen[ids.Prot_Talent.ImpendingVictory] then
		if ivic and playerPh <= 80 then	
			return ids.Prot_Talent.ImpendingVictory;
		end
	else
		if vrush and vBuff and playerPh < 100 then	
			return ids.Prot_Ability.VictoryRush;
		end
	end
	
	if sReflection and (ConRO:BossCast() or ConRO:Interrupt()) then
		return ids.Prot_Ability.SpellReflection;
	end
	
	if lstand and playerPh <= 40 then
		return ids.Prot_Ability.LastStand;
	end
	
	if ipain and not ipBuff and playerPh <= 90 and rage >= 70 then
		return ids.Prot_Ability.IgnorePain;
	end
	
	if sblock and sbCharges >= 1 and ConRO:TarYou() then
		return ids.Prot_Ability.ShieldBlock;
	end
	
	if demo then
		return ids.Prot_Ability.DemoralizingShout;
	end
	
	if swall then
		return ids.Prot_Ability.ShieldWall;
	end
	
	return nil;
end
