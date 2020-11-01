ConRO.Priest = {};
ConRO.Priest.CheckTalents = function()
end
local ConRO_Priest, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Priest.CheckTalents;
	if mode == 1 then
		self.Description = "Priest [Discipline - Healer]";
		self.NextSpell = ConRO.Priest.Discipline;
		self.ToggleHealer();
	end;
	if mode == 2 then
		self.Description = "Priest [Holy - Healer]";
		self.NextSpell = ConRO.Priest.Holy;
		self.ToggleHealer();
	end;
	if mode == 3 then
		self.Description = "Priest [Shadow - Caster]";
		self.NextSpell = ConRO.Priest.Shadow;
		self.ToggleDamage();
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Priest.CheckTalents;
	if mode == 1 then
		self.NextDef = ConRO.Priest.DisciplineDef;
	end;
	if mode == 2 then
		self.NextDef = ConRO.Priest.HolyDef;
	end;
	if mode == 3 then
		self.NextDef = ConRO.Priest.ShadowDef;
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Priest.Discipline(_, timeShift, currentSpell, gcd, tChosen)
--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities	
	local dispel 											= ConRO:AbilityReady(ids.Disc_Ability.DispelMagic, timeShift);
	local pwf 												= ConRO:AbilityReady(ids.Disc_Ability.PowerWordFortitude, timeShift);
	local pwshield											= ConRO:AbilityReady(ids.Disc_Ability.PowerWordShield, timeShift);
		local wsDebuff 											= ConRO:UnitAura(ids.Disc_Debuff.WeakenedSoul, timeShift, 'player', 'HARMFUL');	
	local swp 												= ConRO:AbilityReady(ids.Disc_Ability.ShadowWordPain, timeShift);
		local swpDebuff 										= ConRO:TargetAura(ids.Disc_Debuff.ShadowWordPain, timeShift + 3);
		local potdsBuff	 										= ConRO:Aura(ids.Disc_Buff.PoweroftheDarkSide, timeShift);
	local smi 												= ConRO:AbilityReady(ids.Disc_Ability.Smite, timeShift);

	local ps 												= ConRO:AbilityReady(ids.Disc_Ability.PainSuppression, timeShift);
	local penance 											= ConRO:AbilityReady(ids.Disc_Ability.Penance, timeShift);
	local pwb 												= ConRO:AbilityReady(ids.Disc_Ability.PowerWordBarrier, timeShift);
	local pwradiance										= ConRO:AbilityReady(ids.Disc_Ability.PowerWordRadiance, timeShift);
		local pwrCharges 										= ConRO:SpellCharges(ids.Disc_Ability.PowerWordRadiance);
		local aBuff		 										= ConRO:Aura(ids.Disc_Buff.Atonement, timeShift);
	local shadowF											= ConRO:AbilityReady(ids.Disc_Ability.Shadowfiend, timeShift);

	local afeather											= ConRO:AbilityReady(ids.Disc_Talent.AngelicFeather, timeShift);		
	local ptw 												= ConRO:AbilityReady(ids.Disc_Talent.PurgetheWicked, timeShift);
		local ptwDebuff											= ConRO:TargetAura(ids.Disc_Debuff.PurgetheWicked, timeShift + 3);
	local mbender 											= ConRO:AbilityReady(ids.Disc_Talent.Mindbender, timeShift);
	local sch 												= ConRO:AbilityReady(ids.Disc_Talent.Schism, timeShift);
	local evan 												= ConRO:AbilityReady(ids.Disc_Talent.Evangelism, timeShift);	
	local pwsolace											= ConRO:AbilityReady(ids.Disc_Talent.PowerWordSolace, timeShift);
	local dstar 											= ConRO:AbilityReady(ids.Disc_Talent.DivineStar, timeShift);

	local sfiendID											= select(7, GetSpellInfo(GetSpellInfo(ids.Disc_Ability.Shadowfiend)));
	
--Conditions	
	local isEnemy 											= ConRO:TarHostile();
	local moving 											= ConRO:PlayerSpeed();
	local Close 											= CheckInteractDistance("target", 3);
	
--Indicators
	ConRO:AbilityPurge(ids.Disc_Ability.DispelMagic, dispel and ConRO:Purgable());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityMovement(ids.Disc_Talent.AngelicFeather, afeather);
	
	ConRO:AbilityBurst(ids.Disc_Talent.Mindbender, mbender and isEnemy);
	ConRO:AbilityBurst(ids.Glyph.Sha, sfiendID == ids.Glyph.Sha and shadowF and isEnemy and not tChosen[ids.Disc_Talent.Mindbender]);
	ConRO:AbilityBurst(ids.Glyph.Voidling, sfiendID == ids.Glyph.Voidling and shadowF and isEnemy and not tChosen[ids.Disc_Talent.Mindbender]);
	ConRO:AbilityBurst(ids.Glyph.Lightspawn, sfiendID == ids.Glyph.Lightspawn and shadowF and isEnemy and not tChosen[ids.Disc_Talent.Mindbender]);
	ConRO:AbilityBurst(ids.Disc_Ability.Shadowfiend, sfiendID == ids.Shad_Ability.Shadowfiend and shadowF and isEnemy and not tChosen[ids.Disc_Talent.Mindbender]);
	
	ConRO:AbilityBurst(ids.Disc_Talent.Evangelism, evan and aBuff and pwrCharges <= 1);
	
	ConRO:AbilityRaidBuffs(ids.Disc_Ability.PowerWordFortitude, pwf and not ConRO:RaidBuff(ids.Disc_Buff.PowerWordFortitude));
	ConRO:AbilityRaidBuffs(ids.Disc_Ability.PowerWordShield, pwshield and not ConRO:OneBuff(ids.Disc_Buff.Atonement));
	
--Warnings	
	
--Rotations	
	if isEnemy then
		if ptw and not ptwDebuff then
			return ids.Disc_Talent.PurgetheWicked;
		elseif not tChosen[ids.Disc_Talent.PurgetheWicked] and swp and not swpDebuff then
			return ids.Disc_Ability.ShadowWordPain;
		end
		
		if sch and currentSpell ~= ids.Disc_Talent.Schism then
			return ids.Disc_Talent.Schism;
		end
		
		if pwsolace then
			return ids.Disc_Talent.PowerWordSolace;
		end
		
		if penance and (moving or potdsBuff) and currentSpell ~= ids.Disc_Ability.Penance then
			return ids.Disc_Ability.Penance;
		end
		
		if dstar then
			return ids.Disc_Talent.DivineStar;
		end
	
		if smi then
			return ids.Disc_Ability.Smite;
		end
	end
	
return nil;
end

function ConRO.Priest.DisciplineDef(_, timeShift, currentSpell, gcd, tChosen)
--Abilities	
	local dprayer											= ConRO:AbilityReady(ids.Disc_Ability.DesperatePrayer, timeShift);

	local pains 											= ConRO:AbilityReady(ids.Disc_Ability.PainSuppression, timeShift);

--Conditions	
	local isEnemy 											= ConRO:TarHostile();
	local playerPh 											= ConRO:PercentHealth('player');
	local targetPh 											= ConRO:PercentHealth('target');
	
--Rotations		
	if pains and not isEnemy and targetPh <= 25 then
		return ids.Disc_Ability.PainSuppression;
	end
	
	if dprayer and playerPh <= 50 then
		return ids.Disc_Ability.DesperatePrayer;
	end
	
	return nil;
end

function ConRO.Priest.Holy(_, timeShift, currentSpell, gcd, tChosen)
--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities	
	local dispel 											= ConRO:AbilityReady(ids.Holy_Ability.DispelMagic, timeShift);
	local pwf 												= ConRO:AbilityReady(ids.Holy_Ability.PowerWordFortitude, timeShift);
	local smi												= ConRO:AbilityReady(ids.Holy_Ability.Smite, timeShift);

	local hf												= ConRO:AbilityReady(ids.Holy_Ability.HolyFire, timeShift);
	local hwc 												= ConRO:AbilityReady(ids.Holy_Ability.HolyWordChastise, timeShift);
	local divineh 											= ConRO:AbilityReady(ids.Holy_Ability.DivineHymn, timeShift);

	local afeather											= ConRO:AbilityReady(ids.Holy_Talent.AngelicFeather, timeShift);
	local apoth 											= ConRO:AbilityReady(ids.Holy_Talent.Apotheosis, timeShift);

--Conditions	
	local isEnemy 											= ConRO:TarHostile();
	local Close 											= CheckInteractDistance("target", 3);
	
--Indicators	
	ConRO:AbilityPurge(ids.Holy_Ability.DispelMagic, dispel and ConRO:Purgable())
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityMovement(ids.Holy_Talent.AngelicFeather, afeather);
	
	ConRO:AbilityRaidBuffs(ids.Holy_Ability.PowerWordFortitude, pwf and not ConRO:RaidBuff(ids.Holy_Buff.PowerWordFortitude));
	
	ConRO:AbilityBurst(ids.Holy_Ability.DivineHymn, divineh)
	ConRO:AbilityBurst(ids.Holy_Talent.Apotheosis, apoth)	

--Warnings	
	
--Rotations	
	if isEnemy then
		if hf then
			return ids.Holy_Ability.HolyFire;
		end
		
		if hwc then
			return ids.Holy_Ability.HolyWordChastise;
		end
		
		if smi then
			return ids.Holy_Ability.Smite;
		end
	end	
	
return nil;
end

function ConRO.Priest.HolyDef(_, timeShift, currentSpell, gcd, tChosen)
--Abilities		
	local gspirit											= ConRO:AbilityReady(ids.Holy_Ability.GuardianSpirit, timeShift);
	local dprayer											= ConRO:AbilityReady(ids.Holy_Ability.DesperatePrayer, timeShift);
	
--Conditions	
	local playerPh 											= ConRO:PercentHealth('player');
	local targetPh 											= ConRO:PercentHealth('target');
	
--Rotations
	if gspirit and targetPh <= 25 then
		return ids.Holy_Ability.GuardianSpirit;
	end
	
	if dprayer and playerPh <= 50 then
		return ids.Holy_Ability.DesperatePrayer;
	end
	
return nil;
end

function ConRO.Priest.Shadow(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local insa 												= UnitPower('player', Enum.PowerType.Insanity);
	local playerPh 											= ConRO:PercentHealth('player');
	
--Racials
	local arctorrent										= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities
	local dPlagueRDY										= ConRO:AbilityReady(ids.Shad_Ability.DevouringPlague, timeShift);
	local dispelRDY											= ConRO:AbilityReady(ids.Shad_Ability.DispelMagic, timeShift);
	local mBlastRDY											= ConRO:AbilityReady(ids.Shad_Ability.MindBlast, timeShift + 0.5);
	local mFlayRDY											= ConRO:AbilityReady(ids.Shad_Ability.MindFlay, timeShift);
		local dThoughtsBUFF										= ConRO:Aura(ids.Shad_Buff.DarkThoughts, timeShift);
	local mSearRDY											= ConRO:AbilityReady(ids.Shad_Ability.MindSear, timeShift);
		local thBUFF											= ConRO:Aura(ids.AzTraitBuff.ThoughtHarvester, timeShift);
	local pInfusionRDY										= ConRO:AbilityReady(ids.Shad_Ability.PowerInfusion, timeShift);
		local pInfusionBUFF										= ConRO:Aura(ids.Shad_Buff.PowerInfusion, timeShift);
	local pwfRDY											= ConRO:AbilityReady(ids.Shad_Ability.PowerWordFortitude, timeShift);
	local pwsRDY											= ConRO:AbilityReady(ids.Shad_Ability.PowerWordShield, timeShift);
		local wsDEBUFF 											= ConRO:UnitAura(ids.Shad_Debuff.WeakenedSoul, timeShift, 'player', 'HARMFUL');
		local pwsBUFF 											= ConRO:Aura(ids.Shad_Buff.PowerWordShield, timeShift);	
	local sFiendRDY											= ConRO:AbilityReady(ids.Shad_Ability.Shadowfiend, timeShift + 1);
	local silenceRDY										= ConRO:AbilityReady(ids.Shad_Ability.Silence, timeShift);
	local swdRDY											= ConRO:AbilityReady(ids.Shad_Ability.ShadowWordDeath, timeShift + 0.5);
	local swpRDY 											= ConRO:AbilityReady(ids.Shad_Ability.ShadowWordPain, timeShift);
		local swpDEBUFF, _, swpDur 								= ConRO:TargetAura(ids.Shad_Debuff.ShadowWordPain, timeShift + 3);
	local vEruptRDY											= ConRO:AbilityReady(ids.Shad_Ability.VoidEruption, timeShift);
		local vBoltCD											= ConRO:Cooldown(ids.Shad_Ability.VoidBolt, timeShift);
	local vTouchRDY											= ConRO:AbilityReady(ids.Shad_Ability.VampiricTouch, timeShift);
		local vTouchDEBUFF, _, vtDur 							= ConRO:TargetAura(ids.Shad_Debuff.VampiricTouch, timeShift + 4);

	local damnationRDY										= ConRO:AbilityReady(ids.Shad_Talent.Damnation, timeShift);
	local mBenderRDY										= ConRO:AbilityReady(ids.Shad_Talent.Mindbender, timeShift);
	local sNightmareRDY										= ConRO:AbilityReady(ids.Shad_Talent.SearingNightmare, timeShift);
	local sCrashRDY											= ConRO:AbilityReady(ids.Shad_Talent.ShadowCrash, timeShift);
		local sCrashCharges										= ConRO:SpellCharges(ids.Shad_Talent.ShadowCrash);
		local sCrashDEBUFF										= ConRO:TargetAura(ids.Shad_Debuff.ShadowCrash, timeShift);
	local stmRDY											= ConRO:AbilityReady(ids.Shad_Talent.SurrendertoMadness, timeShift);
	local vTorrentRDY										= ConRO:AbilityReady(ids.Shad_Talent.VoidTorrent, timeShift);
		
	local sFORM 											= ConRO:Form(ids.Shad_Form.Shadowform);
	local vFORM, vCharges 									= ConRO:Form(ids.Shad_Form.Voidform);
	local stmBUFF											= ConRO:Form(ids.Shad_Form.SurrendertoMadness);

	local azChosen_ThoughtHarvester							= ConRO:AzPowerChosen(ids.AzTrait.ThoughtHarvester);

	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
		local cFlameDEBUFF										= ConRO:TargetAura(ids.AzEssenceDebuff.ConcentratedFlame, timeShift);
	local azEssence_FocusedAzeriteBeam						= ConRO:AbilityReady(ids.AzEssence.FocusedAzeriteBeam, timeShift);	
	local azEssence_MemoryofLucidDream						= ConRO:AbilityReady(ids.AzEssence.MemoryofLucidDream, timeShift);
	local azEssence_ReapingFlames							= ConRO:AbilityReady(ids.AzEssence.ReapingFlames, timeShift);
	
--Conditions
	local targetPh 											= ConRO:PercentHealth('target');
	local canDeath 											= targetPh < 20;
	local incombat 											= UnitAffectingCombat('player');
	local Close 											= CheckInteractDistance("target", 3);
	local moving 											= ConRO:PlayerSpeed();
	local sfiendID											= select(7, GetSpellInfo(GetSpellInfo(ids.Shad_Ability.Shadowfiend)));

--Indicators	
	ConRO:AbilityInterrupt(ids.Shad_Ability.Silence, silenceRDY and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Shad_Ability.DispelMagic, dispelRDY and ConRO:Purgable());
	ConRO:AbilityPurge(ids.Racial.ArcaneTorrent, arctorrent and Close and ConRO:Purgable());
	ConRO:AbilityMovement(ids.Shad_Ability.PowerWordShield, pwsRDY and not wsDEBUFF and tChosen[ids.Shad_Talent.BodyandSoul]);
	
	ConRO:AbilityRaidBuffs(ids.Shad_Ability.PowerWordFortitude, pwfRDY and not ConRO:RaidBuff(ids.Shad_Buff.PowerWordFortitude));
	
	ConRO:AbilityBurst(ids.Shad_Talent.SurrendertoMadness, stmRDY and not vFORM);
	ConRO:AbilityBurst(ids.Shad_Ability.VoidEruption, vEruptRDY and not vFORM and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.AzEssence.MemoryofLucidDream, azEssence_MemoryofLucidDream and vFORM and vCharges >= 20 and insa <= 50 and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.AzEssence.ReapingFlames, azEssence_ReapingFlames and (targetPh > 20 and targetPh < 80));
		
	ConRO:AbilityBurst(ids.Glyph.Sha, sfiendID == ids.Glyph.Sha and sFiendRDY and not tChosen[ids.Shad_Talent.Mindbender] and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Glyph.Voidling, sfiendID == ids.Glyph.Voidling and sFiendRDY and not tChosen[ids.Shad_Talent.Mindbender] and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Glyph.Lightspawn, sfiendID == ids.Glyph.Lightspawn and sFiendRDY and not tChosen[ids.Shad_Talent.Mindbender] and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Shad_Ability.Shadowfiend, sfiendID == ids.Shad_Ability.Shadowfiend and sFiendRDY and not tChosen[ids.Shad_Talent.Mindbender] and ConRO_BurstButton:IsVisible());

	ConRO:AbilityBurst(ids.AzEssence.FocusedAzeriteBeam, azEssence_FocusedAzeriteBeam and not vFORM and CheckInteractDistance("target", 1) and ConRO_SingleButton:IsVisible());
	
--Warnings	
	
--Rotations	
	if not sFORM and not vFORM then
		return ids.Shad_Ability.Shadowform;
	end
	
	if dThoughtsBUFF and (select(8, UnitChannelInfo("player")) == ids.Shad_Ability.MindSear or select(8, UnitChannelInfo("player")) == ids.Shad_Ability.MindFlay or moving) then
		return ids.Shad_Ability.MindBlast;
	end
	
	if not incombat then		
		if vTouchRDY and (not vTouchDEBUFF or (tChosen[ids.Shad_Talent.Misery] and not (vTouchDEBUFF or swpDEBUFF))) and currentSpell ~= ids.Shad_Ability.VampiricTouch then
			return ids.Shad_Ability.VampiricTouch;
		end
		
		if swpRDY and ((not swpDEBUFF and not tChosen[ids.Shad_Talent.Misery]) or (moving and swpDur <= 5)) then
			return ids.Shad_Ability.ShadowWordPain;
		end
	end
	
	if azEssence_MemoryofLucidDream and vFORM and vCharges >= 20 and insa <= 60 and ConRO_FullButton:IsVisible() then
		return ids.AzEssence.MemoryofLucidDream;
	end
	
	if ConRO_AoEButton:IsVisible() then
		if select(8, UnitChannelInfo("player")) == ids.Shad_Ability.MindSear and azChosen_ThoughtHarvester then -- Do not break cast
			return ids.Shad_Ability.MindSear;
		end

		if tChosen[ids.Shad_Talent.Mindbender] then
			if mBenderRDY then
				return ids.Shad_Talent.Mindbender;
			end
		else
			if sFiendRDY and ConRO_FullButton:IsVisible() then
				if sfiendID == ids.Glyph.Sha then
					return ids.Glyph.Sha;				
				elseif sfiendID == ids.Glyph.Voidling then
					return ids.Glyph.Voidling;		
				elseif sfiendID == ids.Glyph.Lightspawn then
					return ids.Glyph.Lightspawn;					
				else
					return ids.Shad_Ability.Shadowfiend;
				end
			end
		end	

		if pInfusionRDY and vEruptRDY and not vFORM and insa >= 40 and ConRO_FullButton:IsVisible() then
			return ids.Shad_Ability.PowerInfusion;
		end
		
		if vEruptRDY and not vFORM and (insa >= 40 or pInfusionBUFF) and ConRO_FullButton:IsVisible() then
			return ids.Shad_Ability.VoidEruption;
		end
		
		if (vEruptRDY or vBoltCD <= .5) and vFORM and insa < 85 then
			return ids.Shad_Ability.VoidBolt;
		end
		
		if azEssence_ReapingFlames and (targetPh < 20 or targetPh > 80) then
			return ids.AzEssence.ReapingFlames;
		end

		if dPlagueRDY and not tChosen[ids.Shad_Talent.SearingNightmare] then
			return ids.Shad_Ability.DevouringPlague;
		end	
		
		if vTouchRDY and (not vTouchDEBUFF or (tChosen[ids.Shad_Talent.Misery] and not (vTouchDEBUFF or swpDEBUFF))) and currentSpell ~= ids.Shad_Ability.VampiricTouch then
			return ids.Shad_Ability.VampiricTouch;
		end
		
		if swpRDY and ((not swpDEBUFF and not tChosen[ids.Shad_Talent.Misery] and not tChosen[ids.Shad_Talent.SearingNightmare]) or (moving and swpDur <= 5)) then
			return ids.Shad_Ability.ShadowWordPain;
		end
		
		if azEssence_FocusedAzeriteBeam and CheckInteractDistance("target", 1) then
			return ids.AzEssence.FocusedAzeriteBeam;
		end

		if sCrashRDY then
			return ids.Shad_Talent.ShadowCrash;
		end

		if vTorrentRDY and not vFORM and vTouchDEBUFF and swpDEBUFF then
			return ids.Shad_Talent.VoidTorrent;
		end
		
		if sNightmareRDY and select(8, UnitChannelInfo("player")) == ids.Shad_Ability.MindSear then
			return ids.Shad_Talent.SearingNightmare;
		end
		
		if mSearRDY then
			return ids.Shad_Ability.MindSear;
		end
	else
		if pInfusionRDY and vEruptRDY and not vFORM and insa >= 40 and ConRO_FullButton:IsVisible() then
			return ids.Shad_Ability.PowerInfusion;
		end
		
		if vEruptRDY and not vFORM and (insa >= 40 or pInfusionBUFF) and ConRO_FullButton:IsVisible() then
			return ids.Shad_Ability.VoidEruption;
		end

		if azEssence_ReapingFlames and (targetPh < 20 or targetPh > 80) then
			return ids.AzEssence.ReapingFlames;
		end
		
		if azEssence_ConcentratedFlame and not cFlameDEBUFF and ConRO.lastSpellId ~= ids.AzEssence.ConcentratedFlame then
			return ids.AzEssence.ConcentratedFlame;
		end
		
		if damnationRDY and not vTouchDEBUFF and not swpDEBUFF then
			return ids.Shad_Talent.Damnation;
		end

		if vTouchRDY and (not vTouchDEBUFF or (tChosen[ids.Shad_Talent.Misery] and not (vTouchDEBUFF or swpDEBUFF))) and currentSpell ~= ids.Shad_Ability.VampiricTouch then
			return ids.Shad_Ability.VampiricTouch;
		end
		
		if swpRDY and ((not swpDEBUFF and not tChosen[ids.Shad_Talent.Misery]) or (moving and swpDur <= 5)) then
			return ids.Shad_Ability.ShadowWordPain;
		end

		if dPlagueRDY then
			return ids.Shad_Ability.DevouringPlague;
		end

		if (vEruptRDY or vBoltCD <= .5) and vFORM and insa < 85 then
			return ids.Shad_Ability.VoidBolt;
		end
		
		if swdRDY and canDeath and playerPh >= 50 then
			return ids.Shad_Ability.ShadowWordDeath;
		end

		if tChosen[ids.Shad_Talent.Mindbender] then
			if mBenderRDY then
				return ids.Shad_Talent.Mindbender;
			end
		else
			if sFiendRDY and ConRO_FullButton:IsVisible() then
				if sfiendID == ids.Glyph.Sha then
					return ids.Glyph.Sha;				
				elseif sfiendID == ids.Glyph.Voidling then
					return ids.Glyph.Voidling;		
				elseif sfiendID == ids.Glyph.Lightspawn then
					return ids.Glyph.Lightspawn;					
				else
					return ids.Shad_Ability.Shadowfiend;
				end
			end
		end

		if vTorrentRDY and not vFORM and vTouchDEBUFF and swpDEBUFF then
			return ids.Shad_Talent.VoidTorrent;
		end

		if sCrashRDY and (sCrashCharges >= 3 or sCrashDEBUFF) then
			return ids.Shad_Talent.ShadowCrash;
		end
		
		if select(8, UnitChannelInfo("player")) == ids.Shad_Ability.MindSear and azChosen_ThoughtHarvester then -- Do not break cast
			return ids.Shad_Ability.MindSear;
		end
		
		if mFlayRDY and dThoughtsBUFF then
			return ids.Shad_Ability.MindFlay;
		end

		if mSearRDY and thBUFF and azChosen_ThoughtHarvester then
			return ids.Shad_Ability.MindSear;
		end
		
		if mBlastRDY and currentSpell ~= ids.Shad_Ability.MindBlast then
			return ids.Shad_Ability.MindBlast;
		end

		if swdRDY and moving then
			return ids.Shad_Ability.ShadowWordDeath;
		end

		if mFlayRDY then
			return ids.Shad_Ability.MindFlay;
		end
	end
return nil;
end

function ConRO.Priest.ShadowDef(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local insa 												= UnitPower('player', Enum.PowerType.Insanity);

--Abilities
	local pwsRDY 											= ConRO:AbilityReady(ids.Shad_Ability.PowerWordShield, timeShift);
		local wsDEBUFF										= ConRO:UnitAura(ids.Shad_Debuff.WeakenedSoul, timeShift, 'player', 'HARMFUL');
		local pwsBUFF 										= ConRO:Aura(ids.Shad_Buff.PowerWordShield, timeShift);	
	
	local dispRDY											= ConRO:AbilityReady(ids.Shad_Ability.Dispersion, timeShift);		
	local vEmbraceRDY										= ConRO:AbilityReady(ids.Shad_Ability.VampiricEmbrace, timeShift);
	
--Conditions

--Indicators	

--Warnings	
	
--Rotations
	local playerPh = ConRO:PercentHealth('player');
	
	if vEmbraceRDY and playerPh <= 50 then
		return ids.Shad_Ability.VampiricEmbrace;
	end
	
	if dispRDY and playerPh <= 25 then
		return ids.Shad_Ability.Dispersion;
	end
	
	if pwsRDY and not wsDEBUFF and not pwsBUFF then
		return ids.Shad_Ability.PowerWordShield;
	end	
return nil;
end