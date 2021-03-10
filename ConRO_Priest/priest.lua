ConRO.Priest = {};
ConRO.Priest.CheckTalents = function()
end
ConRO.Priest.CheckPvPTalents = function()
end
local ConRO_Priest, ids = ...;
	
function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Priest.CheckTalents;
	self.ModuleOnEnable = ConRO.Priest.CheckPvPTalents;	
	ConRO_AtonementButton:Hide();
	ConRO_RaidAtonementButton:Hide();
	if mode == 0 then
		self.Description = "Priest [No Specialization Under 10]";
		self.NextSpell = ConRO.Priest.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = "Priest [Discipline - Healer]";
		if ConRO.db.profile._Spec_1_Enabled then			
			self.NextSpell = ConRO.Priest.Discipline;
			self.ToggleDamage();
			ConROButtonFrame:SetAlpha(1);
			ConRO_ShowAtonement();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Priest.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 2 then
		self.Description = "Priest [Holy - Healer]";
		if ConRO.db.profile._Spec_2_Enabled then			
			self.NextSpell = ConRO.Priest.Holy;
			self.ToggleHealer();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Priest.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);			
		end
	end;
	if mode == 3 then
		self.Description = "Priest [Shadow - Caster]";
		if ConRO.db.profile._Spec_3_Enabled then			
			self.NextSpell = ConRO.Priest.Shadow;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Priest.Disabled;
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
		self.NextDef = ConRO.Priest.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then		
			self.NextDef = ConRO.Priest.DisciplineDef;
		else
			self.NextDef = ConRO.Priest.Disabled;
		end	
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then		
			self.NextDef = ConRO.Priest.HolyDef;
		else
			self.NextDef = ConRO.Priest.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Priest.ShadowDef;
		else
			self.NextDef = ConRO.Priest.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Priest.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

function ConRO.Priest.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Priest.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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

function ConRO.Priest.Discipline(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
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
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);	

--Abilities	
	local _DispelMagic, _DispelMagic_RDY 																= ConRO:AbilityReady(ids.Disc_Ability.DispelMagic, timeShift);
	local _HolyNova, _HolyNova_RDY																		= ConRO:AbilityReady(ids.Disc_Ability.HolyNova, timeShift);
	local _MindBlast, _MindBlast_RDY																	= ConRO:AbilityReady(ids.Disc_Ability.MindBlast, timeShift);
	local _PainSuppression, _PainSuppression_RDY 														= ConRO:AbilityReady(ids.Disc_Ability.PainSuppression, timeShift);
	local _Penance, _Penance_RDY 																		= ConRO:AbilityReady(ids.Disc_Ability.Penance, timeShift);
	local _PowerInfusion, _PowerInfusion_RDY 															= ConRO:AbilityReady(ids.Disc_Ability.PowerInfusion, timeShift);	
	local _PowerWordBarrier, _PowerWordBarrier_RDY 														= ConRO:AbilityReady(ids.Disc_Ability.PowerWordBarrier, timeShift);
	local _PowerWordFortitude, _PowerWordFortitude_RDY 													= ConRO:AbilityReady(ids.Disc_Ability.PowerWordFortitude, timeShift);
	local _PowerWordShield, _PowerWordShield_RDY														= ConRO:AbilityReady(ids.Disc_Ability.PowerWordShield, timeShift);
		local _WeakenedSoul_DEBUFF 																			= ConRO:UnitAura(ids.Disc_Debuff.WeakenedSoul, timeShift, 'target', 'HARMFUL');	
	local _PowerWordRadiance, _PowerWordRadiance_RDY													= ConRO:AbilityReady(ids.Disc_Ability.PowerWordRadiance, timeShift);
		local _PowerWordRadiance_CHARGES 																	= ConRO:SpellCharges(_PowerWordRadiance);
		local _Atonement_BUFF 																				= ConRO:UnitAura(ids.Disc_Buff.Atonement, timeShift, 'target', 'HELPFUL');			
		local _Atonement_COUNT		 																		= ConRO:GroupBuffCount(ids.Disc_Buff.Atonement);
		local _Atonement_THRESHOLD																			= ConRO_AtonementBox:GetNumber();
	local _PsychicScream, _PsychicScream_RDY															= ConRO:AbilityReady(ids.Disc_Ability.PsychicScream, timeShift);
	local _Rapture, _Rapture_RDY																		= ConRO:AbilityReady(ids.Disc_Ability.Rapture, timeShift);
		local _Rapture_BUFF	 																				= ConRO:Aura(ids.Disc_Buff.Rapture, timeShift);		
	local _ShadowMend, _ShadowMend_RDY																	= ConRO:AbilityReady(ids.Disc_Ability.ShadowMend, timeShift);	
	local _ShadowWordDeath, _ShadowWordDeath_RDY														= ConRO:AbilityReady(ids.Disc_Ability.ShadowWordDeath, timeShift);
	local _ShadowWordPain, _ShadowWordPain_RDY 															= ConRO:AbilityReady(ids.Disc_Ability.ShadowWordPain, timeShift);
		local _ShadowWordPain_DEBUFF 																		= ConRO:TargetAura(ids.Disc_Debuff.ShadowWordPain, timeShift + 3);
		local _PoweroftheDarkSide_BUFF	 																	= ConRO:Aura(ids.Disc_Buff.PoweroftheDarkSide, timeShift);
	local _Shadowfiend, _Shadowfiend_RDY																= ConRO:AbilityReady(ids.Disc_Ability.Shadowfiend, timeShift);
		local _Shadowfiend_ID																				= select(7, GetSpellInfo(GetSpellInfo(ids.Disc_Ability.Shadowfiend)));
	local _Smite, _Smite_RDY 																			= ConRO:AbilityReady(ids.Disc_Ability.Smite, timeShift);
	
	local _AngelicFeather, _AngelicFeather_RDY															= ConRO:AbilityReady(ids.Disc_Talent.AngelicFeather, timeShift);		
	local _DivineStar, _DivineStar_RDY 																	= ConRO:AbilityReady(ids.Disc_Talent.DivineStar, timeShift);
	local _Evangelism, _Evangelism_RDY, _Evangelism_CD													= ConRO:AbilityReady(ids.Disc_Talent.Evangelism, timeShift);
	local _Halo, _Halo_RDY 																				= ConRO:AbilityReady(ids.Disc_Talent.Halo, timeShift);
	local _Mindbender, _Mindbender_RDY 																	= ConRO:AbilityReady(ids.Disc_Talent.Mindbender, timeShift);
	local _PowerWordSolace, _PowerWordSolace_RDY														= ConRO:AbilityReady(ids.Disc_Talent.PowerWordSolace, timeShift);
	local _PurgetheWicked, _PurgetheWicked_RDY 															= ConRO:AbilityReady(ids.Disc_Talent.PurgetheWicked, timeShift);
		local _PurgetheWicked_DEBUFF																		= ConRO:TargetAura(ids.Disc_Debuff.PurgetheWicked, timeShift + 3);
	local _Schism, _Schism_RDY 																			= ConRO:AbilityReady(ids.Disc_Talent.Schism, timeShift);
	local _ShiningForce, _ShiningForce_RDY 																= ConRO:AbilityReady(ids.Disc_Talent.ShiningForce, timeShift);
	local _SpiritShell, _SpiritShell_RDY 																= ConRO:AbilityReady(ids.Disc_Talent.SpiritShell, timeShift);
		local _SpiritShell_BUFF	 																			= ConRO:Aura(ids.Disc_Buff.SpiritShell, timeShift);
		
	local _BoonoftheAscended, _BoonoftheAscended_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.BoonoftheAscended, timeShift);
		local _BoonoftheAscended_BUFF																		= ConRO:Aura(ids.Covenant_Buff.BoonoftheAscended, timeShift);
	local _AscendedBlast, _, _AscendedBlast_CD															= ConRO:AbilityReady(ids.Covenant_Ability.AscendedBlast, timeShift + .05);
	local _AscendedNova, _AscendedNova_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.AscendedNova, timeShift);
	local _FaeGuardians, _FaeGuardians_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.FaeGuardians, timeShift);
	local _Mindgames, _Mindgames_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Mindgames, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _UnholyNova, _UnholyNova_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.UnholyNova, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_Execute																					= _Target_Percent_Health < 20;

	ConRO:Atonements(_Atonement_COUNT);
	
--Indicators
	ConRO:AbilityInterrupt(_PsychicScream, _PsychicScream_RDY and ((ConRO:Interrupt() and _target_in_melee) or (_target_in_melee and ConRO:TarYou())));
	ConRO:AbilityInterrupt(_ShiningForce, _ShiningForce_RDY and ((ConRO:Interrupt() and _target_in_melee) or (_target_in_melee and ConRO:TarYou())));
	ConRO:AbilityPurge(_DispelMagic, _DispelMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_AngelicFeather, _AngelicFeather_RDY);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityBurst(_Mindbender, _Mindbender_RDY and _is_Enemy and (tChosen[ids.Disc_Talent.Lenience] or _SpiritShell_BUFF or _Evangelism_CD >= 85));
	ConRO:AbilityBurst(ids.Glyph.Sha, _Shadowfiend_ID == ids.Glyph.Sha and _Shadowfiend_RDY and _is_Enemy and (tChosen[ids.Disc_Talent.Lenience] or _SpiritShell_BUFF or _Evangelism_CD >= 85) and not tChosen[ids.Disc_Talent.Mindbender]);
	ConRO:AbilityBurst(ids.Glyph.Voidling, _Shadowfiend_ID == ids.Glyph.Voidling and _Shadowfiend_RDY and _is_Enemy and (tChosen[ids.Disc_Talent.Lenience] or _SpiritShell_BUFF or _Evangelism_CD >= 85) and not tChosen[ids.Disc_Talent.Mindbender]);
	ConRO:AbilityBurst(ids.Glyph.Lightspawn, _Shadowfiend_ID == ids.Glyph.Lightspawn and _Shadowfiend_RDY and _is_Enemy and (tChosen[ids.Disc_Talent.Lenience] or _SpiritShell_BUFF or _Evangelism_CD >= 85) and not tChosen[ids.Disc_Talent.Mindbender]);
	ConRO:AbilityBurst(_Shadowfiend, _Shadowfiend_ID == _Shadowfiend and _Shadowfiend_RDY and _is_Enemy and (tChosen[ids.Disc_Talent.Lenience] or _SpiritShell_BUFF or _Evangelism_CD >= 85) and not tChosen[ids.Disc_Talent.Mindbender]);

	ConRO:AbilityBurst(_PowerInfusion, _PowerInfusion_RDY and ((ConRO:IsSolo() and _Atonement_COUNT < 1) or (ConRO:InParty() and _Atonement_COUNT < _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT < _Atonement_THRESHOLD)));	
	ConRO:AbilityBurst(_Evangelism, _Evangelism_RDY and ((ConRO:IsSolo() and _Atonement_COUNT == 1) or (ConRO:InParty() and _Atonement_COUNT >= _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT > _Atonement_THRESHOLD)));
	ConRO:AbilityBurst(_SpiritShell, _SpiritShell_RDY and ((ConRO:IsSolo() and _Atonement_COUNT == 1) or (ConRO:InParty() and _Atonement_COUNT >= _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT > _Atonement_THRESHOLD)));	
	
	ConRO:AbilityBurst(_BoonoftheAscended, _BoonoftheAscended_RDY and (tChosen[ids.Disc_Talent.Lenience] or _SpiritShell_BUFF or _Evangelism_CD >= 85) and not _BoonoftheAscended_BUFF);
	ConRO:AbilityBurst(_FaeGuardians, _FaeGuardians_RDY and (tChosen[ids.Disc_Talent.Lenience] or not _SpiritShell_BUFF or (_Evangelism_CD <= 70 or _Evangelism_RDY)));

	ConRO:AbilityRaidBuffs(_PowerWordFortitude, _PowerWordFortitude_RDY and not ConRO:RaidBuff(ids.Disc_Buff.PowerWordFortitude));

	ConRO:AbilityRaidBuffs(_PowerWordShield, _PowerWordShield_RDY and not _Atonement_BUFF and not _WeakenedSoul_DEBUFF and _Target_Percent_Health > 95 and not is_Enemy and (ConRO:InParty() and _Atonement_COUNT < _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT < _Atonement_THRESHOLD));
	ConRO:AbilityRaidBuffs(_ShadowMend, _ShadowMend_RDY and not _Atonement_BUFF and _Target_Percent_Health <= 95 and not is_Enemy and (ConRO:InParty() and _Atonement_COUNT < _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT < _Atonement_THRESHOLD));

	ConRO:AbilityRaidBuffs(_PowerWordRadiance, _PowerWordRadiance_RDY and _Atonement_BUFF and not is_Enemy and (ConRO:InParty() and _Atonement_COUNT < _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT < _Atonement_THRESHOLD));

--Warnings	
	ConRO:Warnings("Refresh Atonement!", _is_Enemy and (ConRO:InParty() and _Atonement_COUNT < _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT < _Atonement_THRESHOLD));

--Rotations	
	if _BoonoftheAscended_BUFF then
		if _Smite_RDY and _AscendedBlast_CD <= 0 then
			return _AscendedBlast;
		end
		
		if _Schism_RDY and currentSpell ~= _Schism then
			return _Schism;
		end

		if _AscendedNova_RDY and _enemies_in_melee >= 2 then
			return _AscendedNova;
		end
	elseif _Rapture_BUFF then
		if _PowerWordShield_RDY then
			return _PowerWordShield;
		end
	elseif _is_Enemy then
		if not _in_combat then
			if _PurgetheWicked_RDY and not _PurgetheWicked_DEBUFF and (currentSpell == _Schism or currentSpell == _MindBlast or currentSpell == _Smite) then
				return _PurgetheWicked;
			elseif not tChosen[ids.Disc_Talent.PurgetheWicked] and _ShadowWordPain_RDY and not _ShadowWordPain_DEBUFF and (currentSpell == _Schism or currentSpell == _MindBlast or currentSpell == _Smite) then
				return _ShadowWordPain;
			end
		
			if _Schism_RDY and currentSpell ~= _Schism then
				return _Schism;
			end

			if _Penance_RDY then
				return _Penance;
			end
		
			if _MindBlast_RDY and currentSpell ~= _MindBlast then
				return _MindBlast;
			end
		
			if _Smite_RDY and currentSpell ~= _Smite and not _BoonoftheAscended_BUFF then
				return _Smite;
			end
		end
		
		if _HolyNova_RDY and _enemies_in_melee >= 3 then
			return _HolyNova;
		end
	
		if _ShadowWordDeath_RDY and _can_Execute then
			return _ShadowWordDeath;
		end
		
		if _PurgetheWicked_RDY and not _PurgetheWicked_DEBUFF then
			return _PurgetheWicked;
		elseif not tChosen[ids.Disc_Talent.PurgetheWicked] and _ShadowWordPain_RDY and not _ShadowWordPain_DEBUFF then
			return _ShadowWordPain;
		end

		if _UnholyNova_RDY then
			return _UnholyNova;
		end
		
		if _Schism_RDY and currentSpell ~= ids.Disc_Talent.Schism then
			return _Schism;
		end
		
		if _Mindgames_RDY then
			return _Mindgames;
		end

		if _DivineStar_RDY then
			return _DivineStar;
		end

		if _Halo_RDY then
			return _Halo;
		end
		
		if _Penance_RDY then
			return _Penance;
		end
		
		if _PowerWordSolace_RDY then
			return _PowerWordSolace;
		end

		if _MindBlast_RDY and currentSpell ~= _MindBlast then
			return _MindBlast;
		end

		if _Smite_RDY and not _BoonoftheAscended_BUFF then
			return _Smite;
		end
	end
return nil;
end

function ConRO.Priest.DisciplineDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');

	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	
--Abilities	
	local _DesperatePrayer, _DesperatePrayer_RDY														= ConRO:AbilityReady(ids.Disc_Ability.DesperatePrayer, timeShift);
	local _Fade, _Fade_RDY																				= ConRO:AbilityReady(ids.Disc_Ability.Fade, timeShift);
	local _PainSuppression, _PainSuppression_RDY 														= ConRO:AbilityReady(ids.Disc_Ability.PainSuppression, timeShift);
	local _PowerWordShield, _PowerWordShield_RDY														= ConRO:AbilityReady(ids.Disc_Ability.PowerWordShield, timeShift);
		local _WeakenedSoul_DEBUFF 																			= ConRO:UnitAura(ids.Disc_Debuff.WeakenedSoul, timeShift, 'player', 'HARMFUL');	
		local _Atonement_BUFF 																				= ConRO:UnitAura(ids.Disc_Buff.Atonement, timeShift, 'player', 'HELPFUL');	
	local _ShadowMend, _ShadowMend_RDY																	= ConRO:AbilityReady(ids.Disc_Ability.ShadowMend, timeShift);		

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations		
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end	
	
	if ConRO:IsSolo() and not _Atonement_BUFF then	
		if _PowerWordShield_RDY and not _WeakenedSoul_DEBUFF and _Player_Percent_Health > 95 then
			return _PowerWordShield;
		end
		
		if _ShadowMend_RDY and _Target_Percent_Health <= 95 then
			return _ShadowMend;
		end
	end

	if _PainSuppression_RDY and not _is_Enemy and _Target_Percent_Health <= 25 then
		return _PainSuppression;
	end

	if _DesperatePrayer_RDY and _Player_Percent_Health <= 50 then
		return _DesperatePrayer;
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fade_RDY and not ConRO:IsSolo() and (ConRO:TarYou() or _enemies_in_melee >= 1) then
		return _Fade;
	end

	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end

return nil;
end

function ConRO.Priest.Holy(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');

	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	
--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities	
	local _DispelMagic, _DispelMagic_RDY																= ConRO:AbilityReady(ids.Holy_Ability.DispelMagic, timeShift);
	local _DivineHymn, _DivineHymn_RDY																	= ConRO:AbilityReady(ids.Holy_Ability.DivineHymn, timeShift);
	local _HolyFire, _HolyFire_RDY																		= ConRO:AbilityReady(ids.Holy_Ability.HolyFire, timeShift);
	local _HolyNova, _HolyNova_RDY																		= ConRO:AbilityReady(ids.Holy_Ability.HolyNova, timeShift);
	local _HolyWordChastise, _HolyWordChastise_RDY														= ConRO:AbilityReady(ids.Holy_Ability.HolyWordChastise, timeShift);
	local _PowerWordFortitude, _PowerWordFortitude_RDY													= ConRO:AbilityReady(ids.Holy_Ability.PowerWordFortitude, timeShift);
	local _PsychicScream, _PsychicScream_RDY															= ConRO:AbilityReady(ids.Holy_Ability.PsychicScream, timeShift);
	local _ShadowWordDeath, _ShadowWordDeath_RDY														= ConRO:AbilityReady(ids.Holy_Ability.ShadowWordDeath, timeShift);
	local _ShadowWordPain, _ShadowWordPain_RDY															= ConRO:AbilityReady(ids.Holy_Ability.ShadowWordPain, timeShift);	
		local _ShadowWordPain_DEBUFF 																		= ConRO:TargetAura(ids.Shad_Debuff.ShadowWordPain, timeShift + 3);
	local _Smite, _Smite_RDY																			= ConRO:AbilityReady(ids.Holy_Ability.Smite, timeShift);
	
	local _AngelicFeather, _AngelicFeather_RDY															= ConRO:AbilityReady(ids.Holy_Talent.AngelicFeather, timeShift);
	local _Apotheosis, _Apotheosis_RDY																	= ConRO:AbilityReady(ids.Holy_Talent.Apotheosis, timeShift);
	local _DivineStar, _DivineStar_RDY																	= ConRO:AbilityReady(ids.Holy_Talent.DivineStar, timeShift);
	local _Halo, _Halo_RDY																				= ConRO:AbilityReady(ids.Holy_Talent.Halo, timeShift);
	local _HolyWordSalvation, _HolyWordSalvation_RDY													= ConRO:AbilityReady(ids.Holy_Talent.HolyWordSalvation, timeShift);
	local _ShiningForce, _ShiningForce_RDY 																= ConRO:AbilityReady(ids.Holy_Talent.ShiningForce, timeShift);

	local _BoonoftheAscended, _BoonoftheAscended_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.BoonoftheAscended, timeShift);
		local _BoonoftheAscended_BUFF																		= ConRO:Aura(ids.Covenant_Buff.BoonoftheAscended, timeShift);
	local _AscendedBlast, _, _AscendedBlast_CD															= ConRO:AbilityReady(ids.Covenant_Ability.AscendedBlast, timeShift + .05);
	local _AscendedNova, _AscendedNova_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.AscendedNova, timeShift);
	local _FaeGuardians, _FaeGuardians_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.FaeGuardians, timeShift);
	local _Mindgames, _Mindgames_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Mindgames, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _UnholyNova, _UnholyNova_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.UnholyNova, timeShift);

--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_Execute																					= _Target_Percent_Health < 20;
	
--Indicators	
	ConRO:AbilityInterrupt(_PsychicScream, _PsychicScream_RDY and ((ConRO:Interrupt() and _target_in_melee) or (_target_in_melee and ConRO:TarYou())));
	ConRO:AbilityInterrupt(_ShiningForce, _ShiningForce_RDY and ((ConRO:Interrupt() and _target_in_melee) or (_target_in_melee and ConRO:TarYou())));
	ConRO:AbilityPurge(_DispelMagic, _DispelMagic_RDY and ConRO:Purgable())
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_AngelicFeather, _AngelicFeather_RDY);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityRaidBuffs(_PowerWordFortitude, _PowerWordFortitude_RDY and not ConRO:RaidBuff(ids.Holy_Buff.PowerWordFortitude));
	
	ConRO:AbilityBurst(_DivineHymn, _DivineHymn_RDY and _in_combat);
	ConRO:AbilityBurst(_Apotheosis, _Apotheosis_RDY and _in_combat);
	ConRO:AbilityBurst(_HolyWordSalvation, _HolyWordSalvation_RDY and _in_combat);

	ConRO:AbilityBurst(_BoonoftheAscended, _BoonoftheAscended_RDY and not _BoonoftheAscended_BUFF and _in_combat);
	ConRO:AbilityBurst(_FaeGuardians, _FaeGuardians_RDY and _in_combat);
	ConRO:AbilityBurst(_Mindgames, _Mindgames_RDY and _in_combat);

--Warnings	

--Rotations
	if _is_Enemy then
		if _DivineStar_RDY then
			return _DivineStar;
		end
		
		if _Halo_RDY then
			return _Halo;
		end

		if _HolyWordChastise_RDY then
			return _HolyWordChastise;
		end
		
		if _HolyFire_RDY and currentSpell ~= ids.Holy_Ability.HolyFire then
			return _HolyFire;
		end
		
		if _ShadowWordPain_RDY and not _ShadowWordPain_DEBUFF then
			return _ShadowWordPain;
		end		

		if _HolyNova_RDY and _enemies_in_melee >= 3 then
			return _HolyNova;
		end
	
		if _Smite_RDY then
			return _Smite;
		end
	end
return nil;
end

function ConRO.Priest.HolyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');

	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	
--Abilities		
	local _GuardianSpirit, _GuardianSpirit_RDY															= ConRO:AbilityReady(ids.Holy_Ability.GuardianSpirit, timeShift);
	local _DesperatePrayer, _DesperatePrayer_RDY														= ConRO:AbilityReady(ids.Holy_Ability.DesperatePrayer, timeShift);
	local _PowerWordShield, _PowerWordShield_RDY 														= ConRO:AbilityReady(ids.Holy_Ability.PowerWordShield, timeShift);
		local _WeakenedSoul_DEBUFF																			= ConRO:UnitAura(ids.Holy_Debuff.WeakenedSoul, timeShift, 'player', 'HARMFUL');
		local _PowerWordShield_BUFF 																		= ConRO:Aura(ids.Holy_Buff.PowerWordShield, timeShift);	
	local _Fade, _Fade_RDY																				= ConRO:AbilityReady(ids.Holy_Ability.Fade, timeShift);

	local _GreaterFade, _GreaterFade_RDY																= ConRO:AbilityReady(ids.Holy_PvPTalent.GreaterFade, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
	
--Conditions	
	local _is_Enemy 																					= ConRO:TarHostile();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Rotations
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end	
	
	if _GuardianSpirit_RDY and _Target_Percent_Health <= 25 and not _is_Enemy then
		return _GuardianSpirit;
	end
	
	if _DesperatePrayer_RDY and _Player_Percent_Health <= 50 then
		return _DesperatePrayer;
	end

	if pvpChosen[ids.Holy_PvPTalent.GreaterFade] and _is_PvP then
		if _GreaterFade_RDY and (ConRO:TarYou() or _enemies_in_melee >= 1) then
			return _GreaterFade;
		end	
	else
		if _Fade_RDY and not ConRO:IsSolo() and (ConRO:TarYou() or _enemies_in_melee >= 1) then
			return _Fade;
		end
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end	
	
	if _PowerWordShield_RDY and not _WeakenedSoul_DEBUFF and not _PowerWordShield_BUFF then
		return _PowerWordShield;
	end
return nil;
end

function ConRO.Priest.Shadow(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');

	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	local _Insanity 																					= ConRO:PlayerPower('Insanity');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY															= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities
	local _DevouringPlague, _DevouringPlague_RDY														= ConRO:AbilityReady(ids.Shad_Ability.DevouringPlague, timeShift);
		local _DevouringPlague_DEBUFF, _, _DevouringPlague_DUR												= ConRO:TargetAura(ids.Shad_Debuff.DevouringPlague, timeShift + 4);
	local _DispelMagic, _DispelMagic_RDY																= ConRO:AbilityReady(ids.Shad_Ability.DispelMagic, timeShift);
	local _MindBlast, _MindBlast_RDY																	= ConRO:AbilityReady(ids.Shad_Ability.MindBlast, timeShift + 0.5);
	local _MindFlay, _MindFlay_RDY																		= ConRO:AbilityReady(ids.Shad_Ability.MindFlay, timeShift);
		local _DarkThoughts_BUFF																			= ConRO:Aura(ids.Shad_Buff.DarkThoughts, timeShift);
	local _MindSear, _MindSear_RDY																		= ConRO:AbilityReady(ids.Shad_Ability.MindSear, timeShift);
		local _MindSear_enemies, _MindSear_RANGE															= ConRO:Targets(ids.Shad_Ability.MindSear);
	local _PowerInfusion, _PowerInfusion_RDY, _PowerInfusion_CD											= ConRO:AbilityReady(ids.Shad_Ability.PowerInfusion, timeShift);
		local _PowerInfusion_BUFF																			= ConRO:Aura(ids.Shad_Buff.PowerInfusion, timeShift);
	local _PowerWordFortitude, _PowerWordFortitude_RDY													= ConRO:AbilityReady(ids.Shad_Ability.PowerWordFortitude, timeShift);
	local _PowerWordShield, _PowerWordShield_RDY														= ConRO:AbilityReady(ids.Shad_Ability.PowerWordShield, timeShift);
		local _WeakenedSoul_DEBUFF 																			= ConRO:UnitAura(ids.Shad_Debuff.WeakenedSoul, timeShift, 'player', 'HARMFUL');
		local _PowerWordShield_BUFF 																		= ConRO:Aura(ids.Shad_Buff.PowerWordShield, timeShift);	
	local _PsychicScream, _PsychicScream_RDY															= ConRO:AbilityReady(ids.Shad_Ability.PsychicScream, timeShift);
	local _Shadowfiend, _Shadowfiend_RDY																= ConRO:AbilityReady(ids.Shad_Ability.Shadowfiend, timeShift + 1);
		local _Shadowfiend_ID																				= select(7, GetSpellInfo(GetSpellInfo(ids.Shad_Ability.Shadowfiend)));
	local _Silence, _Silence_RDY																		= ConRO:AbilityReady(ids.Shad_Ability.Silence, timeShift);
	local _ShadowWordDeath, _ShadowWordDeath_RDY														= ConRO:AbilityReady(ids.Shad_Ability.ShadowWordDeath, timeShift + 0.5);
	local _ShadowWordPain, _ShadowWordPain_RDY 															= ConRO:AbilityReady(ids.Shad_Ability.ShadowWordPain, timeShift);
		local _ShadowWordPain_DEBUFF, _, _ShadowWordPain_DUR 												= ConRO:TargetAura(ids.Shad_Debuff.ShadowWordPain, timeShift + 3);
	local _Shadowform, _Shadowform_RDY 																	= ConRO:AbilityReady(ids.Shad_Ability.Shadowform, timeShift);	
		local _Shadowform_FORM 																				= ConRO:Form(ids.Shad_Form.Shadowform);	
	local _VoidEruption, _VoidEruption_RDY																= ConRO:AbilityReady(ids.Shad_Ability.VoidEruption, timeShift);
		local _Voidform_FORM, _Voidform_CHARGES 															= ConRO:Form(ids.Shad_Form.Voidform);
	local _VoidBolt, _, _VoidBolt_CD																	= ConRO:AbilityReady(ids.Shad_Ability.VoidBolt, timeShift);
	local _VampiricTouch, _VampiricTouch_RDY															= ConRO:AbilityReady(ids.Shad_Ability.VampiricTouch, timeShift);
		local _VampiricTouch_DEBUFF, _, _VampiricTouch_DUR 													= ConRO:TargetAura(ids.Shad_Debuff.VampiricTouch, timeShift + 4);
		local _UnfurlingDarkness_BUFF																		= ConRO:Aura(ids.Shad_Buff.UnfurlingDarkness, timeShift);

	local _Damnation, _Damnation_RDY																	= ConRO:AbilityReady(ids.Shad_Talent.Damnation, timeShift);
	local _Mindbender, _Mindbender_RDY																	= ConRO:AbilityReady(ids.Shad_Talent.Mindbender, timeShift);
	local _PsychicHorror, _PsychicHorror_RDY															= ConRO:AbilityReady(ids.Shad_Talent.PsychicHorror, timeShift);
	local _SearingNightmare, _SearingNightmare_RDY														= ConRO:AbilityReady(ids.Shad_Talent.SearingNightmare, timeShift);
	local _ShadowCrash, _ShadowCrash_RDY																= ConRO:AbilityReady(ids.Shad_Talent.ShadowCrash, timeShift);
	local _SurrendertoMadness, _SurrendertoMadness_RDY													= ConRO:AbilityReady(ids.Shad_Talent.SurrendertoMadness, timeShift);
		local _SurrendertoMadness_FORM																		= ConRO:Form(ids.Shad_Form.SurrendertoMadness);	
	local _VoidTorrent, _VoidTorrent_RDY																= ConRO:AbilityReady(ids.Shad_Talent.VoidTorrent, timeShift);

	local _BoonoftheAscended, _BoonoftheAscended_RDY													= ConRO:AbilityReady(ids.Covenant_Ability.BoonoftheAscended, timeShift);
		local _BoonoftheAscended_BUFF																		= ConRO:Aura(ids.Covenant_Buff.BoonoftheAscended, timeShift);
	local _AscendedBlast, _, _AscendedBlast_CD															= ConRO:AbilityReady(ids.Covenant_Ability.AscendedBlast, timeShift + .05);
	local _AscendedNova, _AscendedNova_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.AscendedNova, timeShift);
	local _FaeGuardians, _FaeGuardians_RDY																= ConRO:AbilityReady(ids.Covenant_Ability.FaeGuardians, timeShift);
	local _Mindgames, _Mindgames_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Mindgames, timeShift);
	local _Soulshape, _Soulshape_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Soulshape, timeShift);
	local _UnholyNova, _UnholyNova_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.UnholyNova, timeShift);

	local _DissonantEchoes_VoidBolt, _, _DissonantEchoes_VoidBolt_CD									= ConRO:AbilityReady(ids.Covenant_Conduit.DissonantEchoes_VoidBolt, timeShift);
		local _DissonantEchoes_BUFF																			= ConRO:Aura(ids.Covenant_Buff.DissonantEchoes, timeShift);
		local _MindDevourer_BUFF																			= ConRO:Aura(ids.Covenant_Buff.MindDevourer, timeShift);
		
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	local _can_Execute																					= _Target_Percent_Health < 20;

--Indicators	
	ConRO:AbilityInterrupt(_Silence, _Silence_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_PsychicHorror, _PsychicHorror_RDY and (ConRO:Interrupt() and not _Silence_RDY and _is_PC and _is_Enemy));
	ConRO:AbilityInterrupt(_PsychicScream, _PsychicScream_RDY and ((ConRO:Interrupt() and not _Silence_RDY and _target_in_melee) or (_target_in_melee and ConRO:TarYou())) and _is_PC and _is_Enemy);
	ConRO:AbilityPurge(_DispelMagic, _DispelMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_PowerWordShield, _PowerWordShield_RDY and not _WeakenedSoul_DEBUFF and tChosen[ids.Shad_Talent.BodyandSoul]);
	ConRO:AbilityMovement(_Soulshape, _Soulshape_RDY and _target_in_melee);
	
	ConRO:AbilityRaidBuffs(_PowerWordFortitude, _PowerWordFortitude_RDY and not ConRO:RaidBuff(ids.Shad_Buff.PowerWordFortitude));
	
	ConRO:AbilityBurst(_SurrendertoMadness, _SurrendertoMadness_RDY and not _Voidform_FORM);
	ConRO:AbilityBurst(_VoidEruption, _VoidEruption_RDY and not _Voidform_FORM and ConRO:BurstMode(_VoidEruption));
	ConRO:AbilityBurst(_PowerInfusion, _PowerInfusion_RDY and not _Voidform_FORM and _Insanity >= 40 and ConRO:BurstMode(_PowerInfusion));	
	ConRO:AbilityBurst(_VoidTorrent, _VoidTorrent_RDY and not _Voidform_FORM and _VampiricTouch_DEBUFF and _ShadowWordPain_DEBUFF and ConRO:BurstMode(_VoidTorrent));
	ConRO:AbilityBurst(_Damnation, _Damnation_RDY and not _VampiricTouch_DEBUFF and not _ShadowWordPain_DEBUFF and currentSpell ~= _VampiricTouch and ConRO:BurstMode(_Damnation));
		
	ConRO:AbilityBurst(ids.Glyph.Sha, _Shadowfiend_ID == ids.Glyph.Sha and _Shadowfiend_RDY and not tChosen[ids.Shad_Talent.Mindbender] and ConRO:BurstMode(_Shadowfiend));
	ConRO:AbilityBurst(ids.Glyph.Voidling, _Shadowfiend_ID == ids.Glyph.Voidling and _Shadowfiend_RDY and not tChosen[ids.Shad_Talent.Mindbender] and ConRO:BurstMode(_Shadowfiend));
	ConRO:AbilityBurst(ids.Glyph.Lightspawn, _Shadowfiend_ID == ids.Glyph.Lightspawn and _Shadowfiend_RDY and not tChosen[ids.Shad_Talent.Mindbender] and ConRO:BurstMode(_Shadowfiend));
	ConRO:AbilityBurst(_Shadowfiend, _Shadowfiend_ID == _Shadowfiend and _Shadowfiend_RDY and not tChosen[ids.Shad_Talent.Mindbender] and ConRO:BurstMode(_Shadowfiend));
	ConRO:AbilityBurst(_Mindbender, _Mindbender_RDY and ConRO:BurstMode(_Mindbender, timeShift));

	ConRO:AbilityBurst(_BoonoftheAscended, _BoonoftheAscended_RDY and _Voidform_FORM and not _BoonoftheAscended_BUFF and ConRO:BurstMode(_Shadowfiend));
	ConRO:AbilityBurst(_FaeGuardians, _FaeGuardians_RDY and not _VoidEruption_RDY and not _Voidform_FORM and ConRO:BurstMode(_FaeGuardians));
	ConRO:AbilityBurst(_Mindgames, _Mindgames_RDY and (_Voidform_FORM or (_VampiricTouch_DEBUFF and _ShadowWordPain_DEBUFF and _DevouringPlague_DEBUFF)) and ConRO:BurstMode(_Mindgames));
	ConRO:AbilityBurst(_UnholyNova, _UnholyNova_RDY and (_PowerInfusion_BUFF or _PowerInfusion_CD >= 45 or _Player_Level < 58) and ConRO:BurstMode(_UnholyNova));

--Warnings	
	
--Rotations	
	if select(2, ConRO:EndChannel()) == _VoidTorrent and select(1, ConRO:EndChannel()) > 1 then
		return _VoidTorrent;
	end
		
	if _Shadowform_RDY and not _Shadowform_FORM and not _Voidform_FORM then
		return _Shadowform;
	end
	
	if _DarkThoughts_BUFF and (select(8, UnitChannelInfo("player")) == _MindSear or select(8, UnitChannelInfo("player")) == _MindFlay or _is_moving) then
		return _MindBlast;
	end
	
	if _BoonoftheAscended_RDY and _Voidform_FORM and not _BoonoftheAscended_BUFF and currentSpell ~= _BoonoftheAscended and ConRO:FullMode(_BoonoftheAscended) then
		return _BoonoftheAscended;
	end

	if currentSpell == _BoonoftheAscended then
		return _MindFlay;		
	end
		
	if not _in_combat then		
		if _VampiricTouch_RDY and (not _VampiricTouch_DEBUFF or (tChosen[ids.Shad_Talent.Misery] and not _ShadowWordPain_DEBUFF)) and currentSpell ~= _VampiricTouch then
			return _VampiricTouch;
		end
		
		if _ShadowCrash_RDY then
			return _ShadowCrash;
		end		
		
		if _ShadowWordPain_RDY and ((not _ShadowWordPain_DEBUFF and not tChosen[ids.Shad_Talent.Misery]) or (_is_moving and _ShadowWordPain_DUR <= 5)) then
			return _ShadowWordPain;
		end
	end
	
	if ConRO_AoEButton:IsVisible() then
		if _MindFlay_RDY and _AscendedBlast_CD <= 0.5 and _BoonoftheAscended_BUFF and _enemies_in_melee <= 0 then
			return _AscendedBlast;
		end

		if _AscendedNova_RDY and _BoonoftheAscended_BUFF and _enemies_in_melee >= 2 then
			return _AscendedNova;
		end

		if (_VoidEruption_RDY or _DissonantEchoes_VoidBolt_CD <= .5) and _DissonantEchoes_BUFF then
			return _DissonantEchoes_VoidBolt;
		end

		if _VoidEruption_RDY and not _Voidform_FORM and _Insanity >= 40 and ConRO:FullMode(_VoidEruption) then
			return _VoidEruption;
		end

		if _FaeGuardians_RDY and not _VoidEruption_RDY and not _Voidform_FORM and ConRO:FullMode(_FaeGuardians) then
			return _FaeGuardians;
		end

		if _PowerInfusion_RDY and (_Voidform_FORM or not _VoidEruption_RDY) and ConRO:FullMode(_PowerInfusion) then
			return _PowerInfusion;
		end
		
		if _UnholyNova_RDY and (_PowerInfusion_BUFF or _PowerInfusion_CD >= 45) and ConRO:FullMode(_UnholyNova) then
			return _UnholyNova;
		end

		if _Mindgames_RDY and (_Voidform_FORM or (_VampiricTouch_DEBUFF and _ShadowWordPain_DEBUFF and _DevouringPlague_DEBUFF)) and ConRO:FullMode(_Mindgames) then
			return _Mindgames;
		end
		
		if _SearingNightmare_RDY and select(8, UnitChannelInfo("player")) == _MindSear then
			return _SearingNightmare;
		end

		if _DevouringPlague_RDY and not tChosen[ids.Shad_Talent.SearingNightmare] then
			return _DevouringPlague;
		end	

		if (_VoidEruption_RDY or _VoidBolt_CD <= .5) and _Voidform_FORM then
			return _VoidBolt;
		end

		if _ShadowWordDeath_RDY and _can_Execute and tChosen[ids.Shad_Talent.DeathandMadness] and _Player_Percent_Health >= 50 then
			return _ShadowWordDeath;
		end

		if tChosen[ids.Shad_Talent.Mindbender] then
			if _Mindbender_RDY and ConRO:FullMode(_Mindbender, timeShift) then
				return _Mindbender;
			end
		else
			if _Shadowfiend_RDY and ConRO:FullMode(_Shadowfiend, timeShift) then
				if _Shadowfiend_ID == ids.Glyph.Sha then
					return ids.Glyph.Sha;				
				elseif _Shadowfiend_ID == ids.Glyph.Voidling then
					return ids.Glyph.Voidling;		
				elseif _Shadowfiend_ID == ids.Glyph.Lightspawn then
					return ids.Glyph.Lightspawn;					
				else
					return _Shadowfiend;
				end
			end
		end
		
		if _VampiricTouch_RDY and (not _VampiricTouch_DEBUFF or (tChosen[ids.Shad_Talent.Misery] and not _ShadowWordPain_DEBUFF)) and currentSpell ~= _VampiricTouch then
			return _VampiricTouch;
		end

		if _ShadowWordPain_RDY and (not _ShadowWordPain_DEBUFF and not tChosen[ids.Shad_Talent.Misery] and not tChosen[ids.Shad_Talent.SearingNightmare]) then
			return _ShadowWordPain;
		end

		if _ShadowCrash_RDY then
			return _ShadowCrash;
		end

		if _MindSear_RDY then
			return _MindSear;
		end
	else
		if _MindFlay_RDY and _AscendedBlast_CD <= 0.5 and _BoonoftheAscended_BUFF then
			return _AscendedBlast;
		end

		if _AscendedNova_RDY and _BoonoftheAscended_BUFF and _enemies_in_melee >= 2 then
			return _AscendedNova;
		end

		if (_VoidEruption_RDY or _DissonantEchoes_VoidBolt_CD <= .5) and _DissonantEchoes_BUFF then
			return _DissonantEchoes_VoidBolt;
		end
		
		if _VoidEruption_RDY and not _Voidform_FORM and _Insanity >= 40 and ConRO:FullMode(_VoidEruption) then
			return _VoidEruption;
		end
		
		if _FaeGuardians_RDY and not _VoidEruption_RDY and ConRO:FullMode(_FaeGuardians) then
			return _FaeGuardians;
		end

		if _PowerInfusion_RDY and (_Voidform_FORM or not _VoidEruption_RDY) and ConRO:FullMode(_PowerInfusion) then
			return _PowerInfusion;
		end
		
		if (_VoidEruption_RDY or _VoidBolt_CD <= .5) and _Voidform_FORM and _Insanity < 85 then
			return _VoidBolt;
		end

		if _DevouringPlague_RDY and (not _DevouringPlague_DEBUFF or _DevouringPlague_DUR <= 1 or _Insanity > 90 or _MindDevourer_BUFF) then
			return _DevouringPlague;
		end

		if (_VoidEruption_RDY or _VoidBolt_CD <= .5) and _Voidform_FORM then
			return _VoidBolt;
		end

		if _ShadowWordDeath_RDY and _can_Execute and _Player_Percent_Health >= 50 then
			return _ShadowWordDeath;
		end

		if tChosen[ids.Shad_Talent.Mindbender] then
			if _Mindbender_RDY and ConRO:FullMode(_Mindbender) then
				return _Mindbender;
			end
		else
			if _Shadowfiend_RDY and ConRO:FullMode(_Shadowfiend) then
				if _Shadowfiend_ID == ids.Glyph.Sha then
					return ids.Glyph.Sha;				
				elseif _Shadowfiend_ID == ids.Glyph.Voidling then
					return ids.Glyph.Voidling;		
				elseif _Shadowfiend_ID == ids.Glyph.Lightspawn then
					return ids.Glyph.Lightspawn;					
				else
					return _Shadowfiend;
				end
			end
		end

		if _Damnation_RDY and not _VampiricTouch_DEBUFF and not _ShadowWordPain_DEBUFF and currentSpell ~= _VampiricTouch and ConRO:FullMode(_Damnation) then
			return _Damnation;
		end
		
		if _VampiricTouch_RDY and (not _VampiricTouch_DEBUFF or (tChosen[ids.Shad_Talent.Misery] and not _ShadowWordPain_DEBUFF)) and currentSpell ~= _VampiricTouch then
			return _VampiricTouch;
		end
		
		if _ShadowWordPain_RDY and ((not _ShadowWordPain_DEBUFF and not tChosen[ids.Shad_Talent.Misery]) or (_is_moving and _ShadowWordPain_DUR <= 4)) then
			return _ShadowWordPain;
		end		
		
		if _Mindgames_RDY and (_Voidform_FORM or (_VampiricTouch_DEBUFF and _ShadowWordPain_DEBUFF and _DevouringPlague_DEBUFF)) and ConRO:FullMode(_Mindgames) then
			return _Mindgames;
		end
		
		if _ShadowCrash_RDY then
			return _ShadowCrash;
		end

		if _UnholyNova_RDY and (_PowerInfusion_BUFF or _PowerInfusion_CD >= 45) and ConRO:FullMode(_UnholyNova) then
			return _UnholyNova;
		end
		
		if _MindBlast_RDY and currentSpell ~= _MindBlast then
			return _MindBlast;
		end
		
		if _VampiricTouch_RDY and _UnfurlingDarkness_BUFF then
			return _VampiricTouch;
		end		

		if _VoidTorrent_RDY and not _Voidform_FORM and _VampiricTouch_DEBUFF and _ShadowWordPain_DEBUFF and ConRO:FullMode(_VoidTorrent) then
			return _VoidTorrent;
		end

		if _MindFlay_RDY and not _BoonoftheAscended_BUFF then
			return _MindFlay;
		end
	end
return nil;
end

function ConRO.Priest.ShadowDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																					= UnitLevel("player");
	local _Player_Percent_Health 																		= ConRO:PercentHealth('player');
	local _is_PvP																						= ConRO:IsPvP();
	local _in_combat 																					= UnitAffectingCombat('player');

	local _is_PC																						= UnitPlayerControlled("target");
	local _is_Enemy 																					= ConRO:TarHostile();
	local _Target_Health 																				= UnitHealth('target');
	local _Target_Percent_Health 																		= ConRO:PercentHealth('target');
	
--Resources
	local _Mana, _Mana_Max																				= ConRO:PlayerPower('Mana');
	local _Insanity 																					= ConRO:PlayerPower('Insanity');

--Abilities
	local _PowerWordShield, _PowerWordShield_RDY														= ConRO:AbilityReady(ids.Shad_Ability.PowerWordShield, timeShift);
		local _WeakenedSoul_DEBUFF																			= ConRO:UnitAura(ids.Shad_Debuff.WeakenedSoul, timeShift, 'player', 'HARMFUL');
		local _PowerWordShield_BUFF																			= ConRO:Aura(ids.Shad_Buff.PowerWordShield, timeShift);	
	local _DesperatePrayer, _DesperatePrayer_RDY														= ConRO:AbilityReady(ids.Shad_Ability.DesperatePrayer, timeShift);
	local _Fade, _Fade_RDY																				= ConRO:AbilityReady(ids.Shad_Ability.Fade, timeShift);	
	local _Dispersion, _Dispersion_RDY																	= ConRO:AbilityReady(ids.Shad_Ability.Dispersion, timeShift);		
	local _VampiricEmbrace, _VampiricEmbrace_RDY														= ConRO:AbilityReady(ids.Shad_Ability.VampiricEmbrace, timeShift);

	local _GreaterFade, _GreaterFade_RDY																= ConRO:AbilityReady(ids.Shad_PvPTalent.GreaterFade, timeShift);

	local _Fleshcraft, _Fleshcraft_RDY																	= ConRO:AbilityReady(ids.Covenant_Ability.Fleshcraft, timeShift);
	local _PhialofSerenity, _PhialofSerenity_RDY														= ConRO:ItemReady(ids.Covenant_Ability.PhialofSerenity, timeShift);
	
--Conditions
	local _is_moving 																					= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee															= ConRO:Targets("Melee");
	local _target_in_10yrds 																			= CheckInteractDistance("target", 3);
	
--Indicators	

--Warnings	
	
--Rotations
	if _Fleshcraft_RDY and not _in_combat then
		return _Fleshcraft;
	end	
	
	if _DesperatePrayer_RDY and _Player_Percent_Health <= 50 then
		return _DesperatePrayer;
	end	
	
	if _VampiricEmbrace_RDY and _Player_Percent_Health <= 50 then
		return _VampiricEmbrace;
	end
	
	if _Dispersion_RDY and _Player_Percent_Health <= 25 then
		return _Dispersion;
	end

	if pvpChosen[ids.Shad_PvPTalent.GreaterFade] and _is_PvP then
		if _GreaterFade_RDY and (ConRO:TarYou() or _enemies_in_melee >= 1) then
			return _GreaterFade;
		end	
	else
		if _Fade_RDY and not ConRO:IsSolo() and (ConRO:TarYou() or _enemies_in_melee >= 1) then
			return _Fade;
		end
	end

	if _PhialofSerenity_RDY and _Player_Percent_Health <= 80 then
		return _PhialofSerenity;
	end
	
	if _Fleshcraft_RDY then
		return _Fleshcraft;
	end	
	
	if _PowerWordShield_RDY and not _WeakenedSoul_DEBUFF and not _PowerWordShield_BUFF then
		return _PowerWordShield;
	end
return nil;
end