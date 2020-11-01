ConRO.Shaman = {};
ConRO.Shaman.CheckTalents = function()
end
local ConRO_Shaman, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Shaman.CheckTalents;
	if mode == 1 then
		self.Description = 'Shaman Module [Elemental - Caster]';
		self.NextSpell = ConRO.Shaman.Elemental;
		self.ToggleDamage();
	end;
	if mode == 2 then
		self.Description = 'Shaman Module [Enhancement - Melee]';
		self.NextSpell = ConRO.Shaman.Enhancement;
		self.ToggleDamage();
	end;
	if mode == 3 then
		self.Description = 'Shaman Module [Restoration - Healer]';
		self.NextSpell = ConRO.Shaman.Restoration;
		self.ToggleHealer();
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 1;
	self.ModuleOnEnable = ConRO.Shaman.CheckTalents;
	if mode == 1 then
		self.NextDef = ConRO.Shaman.ElementalDef;
	end;
	if mode == 2 then
		self.NextDef = ConRO.Shaman.EnhancementDef;
	end;
	if mode == 3 then
		self.NextDef = ConRO.Shaman.RestorationDef;
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Shaman.Elemental(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local mael 												= UnitPower('player', Enum.PowerType.Maelstorm);
	local maelMax 											= UnitPowerMax('player', Enum.PowerType.Maelstorm);

--Abilities	
	local purge 											= ConRO:AbilityReady(ids.Shaman_Ability.Purge, timeShift);
	local lbolt												= ConRO:AbilityReady(ids.Shaman_Ability.LightningBolt, timeShift);
	local clight											= ConRO:AbilityReady(ids.Shaman_Ability.ChainLightning, timeShift);
	local wshear 											= ConRO:AbilityReady(ids.Shaman_Ability.WindShear, timeShift);
	local felem, feCD, feMCD								= ConRO:AbilityReady(ids.Ele_Ability.FireElemental, timeShift);
	local eelem, eeCD, eeMCD								= ConRO:AbilityReady(ids.Shaman_Ability.EarthElemental, timeShift);
	local lburst											= ConRO:AbilityReady(ids.Ele_Ability.LavaBurst, timeShift);
		local lavaCharges										= ConRO:SpellCharges(ids.Ele_Ability.LavaBurst);
		local lsurgeBuff 										= ConRO:Aura(ids.Ele_Buff.LavaSurge, timeShift);
		local moteBuff 											= ConRO:Aura(ids.Ele_Buff.MasteroftheElements, timeShift);
	local equake											= ConRO:AbilityReady(ids.Ele_Ability.Earthquake, timeShift);
	local eshock 											= ConRO:AbilityReady(ids.Ele_Ability.EarthShock, timeShift);
		local sopBuff											= ConRO:Aura(ids.Ele_Buff.SurgeofPower, timeShift);
	local fshock											= ConRO:AbilityReady(ids.Shaman_Ability.FlameShock, timeShift);
		local fsDebuff 											= ConRO:TargetAura(ids.Shaman_Debuff.FlameShock, timeShift + 6);
	local frshock											= ConRO:AbilityReady(ids.Shaman_Ability.FrostShock, timeShift);
	
	local ifury 											= ConRO:AbilityReady(ids.Ele_Talent.Icefury, timeShift);
		local ifBuff 											= ConRO:Aura(ids.Ele_Buff.Icefury, timeShift);	
	local ascen, ascenCD 									= ConRO:AbilityReady(ids.Ele_Talent.Ascendance, timeShift);
		local ascenBuff 										= ConRO:Aura(ids.Ele_Buff.Ascendance, timeShift);
		local lbeam 											= ConRO:AbilityReady(ids.Ele_Talent.LavaBeam, timeShift);
	local elemblast 										= ConRO:AbilityReady(ids.Ele_Talent.ElementalBlast, timeShift);
	local lmtotem 											= ConRO:AbilityReady(ids.Ele_Talent.LiquidMagmaTotem, timeShift);
	local skeeper 											= ConRO:AbilityReady(ids.Ele_Talent.Stormkeeper, timeShift);
		local skBuff 											= ConRO:Aura(ids.Ele_Buff.Stormkeeper, timeShift);
	local selem, seCD, seMCD								= ConRO:AbilityReady(ids.Ele_Talent.StormElemental, timeShift);
		local wgBuff, wgBCount									= ConRO:Form(ids.Ele_Form.WindGust);
	local eshield											= ConRO:AbilityReady(ids.Ele_Talent.EarthShield, timeShift);

	local azEssence_ConcentratedFlame						= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	
--Conditions
	local incombat 											= UnitAffectingCombat('player');
	local moving 											= ConRO:PlayerSpeed();
	local elemOut											= IsPetActive();
	
	local elemName = UnitName("pet");
	local selemOut = false;
		if elemOut and (elemName == "Greater Storm Elemental" or elemName == "Primal Storm Elemental") then
			selemOut = true;
		end
	
	if currentSpell == ids.Ele_Ability.LavaBurst then
		mael = mael + 10;
		if lavaCharges > 0 then
			lavaCharges = lavaCharges - 1;
		end
	elseif currentSpell == ids.Shaman_Ability.LightningBolt then
		mael = mael + 8;
	elseif currentSpell == ids.Ele_Talent.Icefury then
		mael = mael + 15;
	end

	if tChosen[ids.Ele_Talent.EchooftheElements] and lburst then
		lavaCharges = 1;
	end

--Indicators	
	ConRO:AbilityInterrupt(ids.Shaman_Ability.WindShear, wshear and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Shaman_Ability.Purge, purge and ConRO:Purgable());
	
	ConRO:AbilityBurst(ids.Ele_Ability.FireElemental, felem and ConRO_SingleButton:IsVisible() and (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not elemOut)) and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Ele_Talent.StormElemental, selem and (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not elemOut)) and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Shaman_Ability.EarthElemental, eelem and not (selem or felem) and (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not elemOut)));
	ConRO:AbilityBurst(ids.Ele_Talent.Ascendance, ascen and ConRO_SingleButton:IsVisible() and ConRO_BurstButton:IsVisible());

	ConRO:AbilityRaidBuffs(ids.Ele_Talent.EarthShield, eshield and not ConRO:OneBuff(ids.Ele_Buff.EarthShield));
	
--Rotations	
	if not incombat then
		if skeeper and currentSpell ~= ids.Ele_Talent.Stormkeeper then
			return ids.Ele_Talent.Stormkeeper;
		end	
		
		if ConRO_FullButton:IsVisible() and (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not elemOut)) then
			if tChosen[ids.Ele_Talent.StormElemental] then
				if selem then
					return ids.Ele_Talent.StormElemental;
				end
			else
				if felem then
					return ids.Ele_Ability.FireElemental;
				end
			end
		end
		
		if fshock and not fsDebuff and (currentSpell == ids.Ele_Talent.ElementalBlast or currentSpell == ids.Ele_Ability.LavaBurst or currentSpell == ids.Shaman_Ability.LightningBolt) then
			return ids.Shaman_Ability.FlameShock;
		end	

		if elemblast then
			return ids.Ele_Talent.ElementalBlast;
		end
		
		if lburst then
			return ids.Ele_Ability.LavaBurst;
		end
		
		if lbolt then
			return ids.Shaman_Ability.LightningBolt;
		end
	
	elseif ascenBuff then
		if eshock and mael > 90 then
			return ids.Ele_Ability.EarthShock;
		end
		
		if elemblast and currentSpell ~= ids.Ele_Talent.ElementalBlast then
			return ids.Ele_Talent.ElementalBlast;
		end
		
		if lburst then
			return ids.Ele_Ability.LavaBurst;
		end
			
	elseif moving then
		if fshock and not fsDebuff then
			return ids.Shaman_Ability.FlameShock;
		end	
	
		if lburst and lsurgeBuff then
			return ids.Ele_Ability.LavaBurst;
		end		
	
		if skBuff then
			if ConRO_AoEButton:IsVisible() then
				if clight then
					return ids.Shaman_Ability.ChainLightning;
				end
			else
				if lbolt then
					return ids.Shaman_Ability.LightningBolt;
				end	
			end
		end
		
		if frshock then
			return ids.Shaman_Ability.FrostShock;
		end
	
	elseif ConRO_AoEButton:IsVisible() then
		if skeeper and currentSpell ~= ids.Ele_Talent.Stormkeeper then
			return ids.Ele_Talent.Stormkeeper;
		end	
		
		if lmtotem then
			return ids.Ele_Talent.LiquidMagmaTotem;
		end
		
		if fshock and not fsDebuff then
			return ids.Shaman_Ability.FlameShock;
		end	

		if equake and mael >= 60 then
			return ids.Ele_Ability.Earthquake;
		end	

		if elemblast and currentSpell ~= ids.Ele_Talent.ElementalBlast then
			return ids.Ele_Talent.ElementalBlast;
		end
		
		if selem and tChosen[ids.Ele_Talent.StormElemental] and tChosen[ids.Ele_Talent.PrimalElementalist] and not elemOut and ConRO_FullButton:IsVisible() then
			return ids.Ele_Talent.StormElemental;
		end
		
		if clight then
			return ids.Shaman_Ability.ChainLightning;
		end
		
	else
		if fshock and not fsDebuff and not sopBuff and wgBCount <= 13 then
			return ids.Shaman_Ability.FlameShock;
		end
	
		if ConRO_FullButton:IsVisible() and (not tChosen[ids.Ele_Talent.PrimalElementalist] or (tChosen[ids.Ele_Talent.PrimalElementalist] and not elemOut)) then
			if tChosen[ids.Ele_Talent.StormElemental] then
				if selem then
					return ids.Ele_Talent.StormElemental;
				end
			else
				if felem then
					return ids.Ele_Ability.FireElemental;
				end
			end
		end

		if eshock and mael > 60 and moteBuff then
			return ids.Ele_Ability.EarthShock;
		end
			
		if elemblast and not moteBuff and not selemOut and currentSpell ~= ids.Ele_Talent.ElementalBlast then
			return ids.Ele_Talent.ElementalBlast;
		end	
		
		if azEssence_ConcentratedFlame then
			return ids.AzEssence.ConcentratedFlame;
		end
		
		if lmtotem then
			return ids.Ele_Talent.LiquidMagmaTotem;
		end
		
		if skeeper and (not tChosen[ids.Ele_Talent.SurgeofPower] or (tChosen[ids.Ele_Talent.SurgeofPower] and sopBuff )) and currentSpell ~= ids.Ele_Talent.Stormkeeper then
			return ids.Ele_Talent.Stormkeeper;
		end
		
		if lbolt and sopBuff or (skBuff and (not tChosen[ids.Ele_Talent.SurgeofPower] and moteBuff)) then
			return ids.Shaman_Ability.LightningBolt;
		end		
		
		if eshock and mael >= 90 then
			return ids.Ele_Ability.EarthShock;
		end
				
		if lbolt and selemOut or wgBuff or (seCD > seMCD - 10) then
			return ids.Shaman_Ability.LightningBolt;
		end

		if frshock and ifBuff and moteBuff then
			return ids.Shaman_Ability.FrostShock;
		end
		
		if lburst and lavaCharges >= 1 then
			return ids.Ele_Ability.LavaBurst;
		end
		
		if ascen and ConRO_SingleButton:IsVisible() and ConRO_FullButton:IsVisible() then
			return ids.Ele_Talent.Ascendance;
		end

		if eshock and mael >= 60 then
			return ids.Ele_Ability.EarthShock;
		end
		
		if frshock and ifBuff then
			return ids.Shaman_Ability.FrostShock;
		end
		
		if ifury then
			return ids.Ele_Talent.Icefury;
		end
	
		if lbolt then
			return ids.Shaman_Ability.LightningBolt;
		end
	end
end

function ConRO.Shaman.ElementalDef(_, timeShift, currentSpell, gcd, tChosen)
--Abilities
	local astral											 = ConRO:AbilityReady(ids.Shaman_Ability.AstralShift, timeShift);

--Rotations	
	if astral then
		return ids.Shaman_Ability.AstralShift;
	end
return nil;
end

function ConRO.Shaman.Enhancement(_, timeShift, currentSpell, gcd, tChosen)
--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	local manaPercent 										= math.max(0, mana) / math.max(1, manaMax) * 100;
	
--Abilities
	local purge 											= ConRO:AbilityReady(ids.Shaman_Ability.Purge, timeShift);
	local ss												= ConRO:AbilityReady(ids.Enh_Ability.Stormstrike, timeShift);
		local sbBuff 											= ConRO:Aura(ids.Enh_Buff.Stormbringer, timeShift);
	local fs, fsCD 											= ConRO:AbilityReady(ids.Enh_Ability.FeralSpirit, timeShift);
	local cl 												= ConRO:AbilityReady(ids.Enh_Ability.CrashLightning, timeShift);
		local clBuff 											= ConRO:Aura(ids.Enh_Buff.CrashLightning, timeShift);

		local hhBuff 											= ConRO:Aura(ids.Enh_Buff.HotHand, timeShift);

	local wshear 											= ConRO:AbilityReady(ids.Shaman_Ability.WindShear, timeShift);
	local lb, _, _, _, lbRANGE								= ConRO:AbilityReady(ids.Shaman_Ability.LightningBolt, timeShift);
	local ll, _, _, _, meleeRANGE							= ConRO:AbilityReady(ids.Enh_Ability.LavaLash, timeShift);
	
	local ascen 											= ConRO:AbilityReady(ids.Enh_Talent.Ascendance, timeShift);
		local asBuff											= ConRO:Aura(ids.Enh_Buff.Ascendance, timeShift);
		local wstrike, _, _, _, wstrikeRANGE 					= ConRO:AbilityReady(ids.Enh_Talent.Windstrike, timeShift);

	local espike, _, _, _, espikeRANGE						= ConRO:AbilityReady(ids.Enh_Talent.EarthenSpike, timeShift);

	local sunder 											= ConRO:AbilityReady(ids.Enh_Talent.Sundering, timeShift);	
	local eshield											= ConRO:AbilityReady(ids.Enh_Talent.EarthShield, timeShift);
	local lshield											= ConRO:AbilityReady(ids.Shaman_Ability.LightningShield, timeShift);
		local lsBuff											= ConRO:Aura(ids.Shaman_Buff.LightningShield, timeShift);

	local azEssence_ConcentratedFlame, _, _, _, cfAzRANGE	= ConRO:AbilityReady(ids.AzEssence.ConcentratedFlame, timeShift);
	
--Conditions	
	local inMelee 											= ConRO:IsSpellInRange(GetSpellInfo(ids.Enh_Ability.LavaLash), 'target')
	local tarInMelee										= ConRO:Targets(ids.Enh_Ability.LavaLash);
	local tar10RANGE										= CheckInteractDistance("target", 3);
	
--Indicators	
	ConRO:AbilityInterrupt(ids.Shaman_Ability.WindShear, wshear and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Shaman_Ability.Purge, purge and ConRO:Purgable());
	
	ConRO:AbilityBurst(ids.Enh_Talent.Ascendance, ascen and not ss and ConRO_BurstButton:IsVisible());
	ConRO:AbilityBurst(ids.Enh_Ability.FeralSpirit, fs and ftBuff and ConRO_BurstButton:IsVisible());

	ConRO:AbilityRaidBuffs(ids.Enh_Talent.EarthShield, eshield and not ConRO:OneBuff(ids.Enh_Buff.EarthShield));
	ConRO:AbilityRaidBuffs(ids.Shaman_Ability.LightningShield, lshield and not lsBuff);
	
--Rotations
	if cl and meleeRANGE and not clBuff and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
		return ids.Enh_Ability.CrashLightning;
	end

	if azEssence_ConcentratedFlame and cfAzRANGE then
		return ids.AzEssence.ConcentratedFlame;
	end
		
	if ss and wstrikeRANGE and asBuff then
		return ids.Enh_Talent.Windstrike;
	end

	if fs and ConRO_FullButton:IsVisible() then
		return ids.Enh_Ability.FeralSpirit;
	end

	if espike and espikeRANGE then
		return ids.Enh_Talent.EarthenSpike;
	end

	if ascen and not ss and ConRO_FullButton:IsVisible() then
		return ids.Enh_Talent.Ascendance;
	end
	
	if ss and meleeRANGE and sbBuff and not asBuff	then
		return ids.Enh_Ability.Stormstrike;
	end

	if ll and meleeRANGE and hhBuff then
		return ids.Enh_Ability.LavaLash;
	end

	if ss and meleeRANGE and not asBuff then
		return ids.Enh_Ability.Stormstrike;
	end

	if cl and meleeRANGE and ((ConRO_AutoButton:IsVisible() and tarInMelee >= 3) or ConRO_AoEButton:IsVisible()) then
		return ids.Enh_Ability.CrashLightning;
	end

	if sunder and tar10RANGE then
		return ids.Enh_Talent.Sundering;
	end	
	
	if cl and meleeRANGE and (tChosen[ids.Enh_Talent.CrashingStorm] or (ConRO_AutoButton:IsVisible() and tarInMelee >= 2) or ConRO_AoEButton:IsVisible()) then
		return ids.Enh_Ability.CrashLightning;
	end	
	
	if ll and meleeRANGE then
		return ids.Enh_Ability.LavaLash;
	end	
	
	return nil;
end

function ConRO.Shaman.EnhancementDef(_, timeShift, currentSpell, gcd, tChosen)
--Resources	
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	local manaPercent 										= math.max(0, mana) / math.max(1, manaMax) * 100;
	
--Abilities	
	local astral 											= ConRO:AbilityReady(ids.Shaman_Ability.AstralShift, timeShift);
	local hsurge											= ConRO:AbilityReady(ids.Shaman_Ability.HealingSurge, timeShift);
	
--Conditions	
	local ph = ConRO:PercentHealth('player');

--Rotations
	if hsurge and ph <= 80 then
		return ids.Shaman_Ability.HealingSurge;
	end
		
	if astral then
		return ids.Shaman_Ability.AstralShift;
	end
return nil;
end

function ConRO.Shaman.Restoration(_, timeShift, currentSpell, gcd, tChosen)
--Abilities
	local purge 											= ConRO:AbilityReady(ids.Shaman_Ability.Purge, timeShift);	
	local wshear 											= ConRO:AbilityReady(ids.Shaman_Ability.WindShear, timeShift);
	local lbolt												= ConRO:AbilityReady(ids.Shaman_Ability.LightningBolt, timeShift);
	local clight											= ConRO:AbilityReady(ids.Shaman_Ability.ChainLightning, timeShift);
	local eelem, eeCD, eeMCD								= ConRO:AbilityReady(ids.Shaman_Ability.EarthElemental, timeShift);
	local lburst											= ConRO:AbilityReady(ids.Resto_Ability.LavaBurst, timeShift);
		local lavaCharges										= ConRO:SpellCharges(ids.Resto_Ability.LavaBurst);
		local lsurgeBuff 										= ConRO:Aura(ids.Resto_Buff.LavaSurge, timeShift);
	local fshock											= ConRO:AbilityReady(ids.Shaman_Ability.FlameShock, timeShift);
		local fsDebuff 											= ConRO:TargetAura(ids.Shaman_Debuff.FlameShock, timeShift + 6);
	local hsTotem											= ConRO:AbilityReady(ids.Shaman_Ability.HealingStreamTotem, timeShift);
		
	local eshield											= ConRO:AbilityReady(ids.Resto_Ability.EarthShield, timeShift);
	
--Conditions	
	local isEnemy 											= ConRO:TarHostile();

	if currentSpell == ids.Ele_Ability.LavaBurst then
		lavaCharges = lavaCharges - 1;
	end
		
--Indicators
	ConRO:AbilityInterrupt(ids.Shaman_Ability.WindShear, wshear and ConRO:Interrupt());
	ConRO:AbilityPurge(ids.Shaman_Ability.Purge, purge and ConRO:Purgable());

	ConRO:AbilityRaidBuffs(ids.Resto_Ability.EarthShield, eshield and not ConRO:OneBuff(ids.Resto_Buff.EarthShield));
	ConRO:AbilityRaidBuffs(ids.Shaman_Ability.HealingStreamTotem, hsTotem);
	
	ConRO:AbilityBurst(ids.Shaman_Ability.EarthElemental, eelem and isEnemy);

--Rotations
	if isEnemy then
		if fshock and not fsDebuff then
			return ids.Shaman_Ability.FlameShock;
		end	
		
		if lburst and lavaCharges >= 1 then
			return ids.Resto_Ability.LavaBurst;
		end
		
		if lbolt then
			return ids.Shaman_Ability.LightningBolt;
		end
	end
return nil;
end

function ConRO.Shaman.RestorationDef(_, timeShift, currentSpell, gcd, tChosen)
--Abilities	
	local astral 											= ConRO:AbilityReady(ids.Shaman_Ability.AstralShift, timeShift);

--Rotations	
	if astral then
		return ids.Shaman_Ability.AstralShift;
	end

	return nil;
end