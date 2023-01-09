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
	local _Player_Level																														= UnitLevel("player");
	local _Player_Percent_Health 																									= ConRO:PercentHealth('player');
	local _is_PvP																																	= ConRO:IsPvP();
	local _in_combat 																															= UnitAffectingCombat('player');
	local _party_size																															= GetNumGroupMembers();

	local _is_PC																																	= UnitPlayerControlled("target");
	local _is_Enemy 																															= ConRO:TarHostile();
	local _Target_Health 																													= UnitHealth('target');
	local _Target_Percent_Health 																									= ConRO:PercentHealth('target');

--Resources

--Racials
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Warnings

--Rotations

	return nil;
end

function ConRO.Priest.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
--Info
	local _Player_Level																														= UnitLevel("player");
	local _Player_Percent_Health 																									= ConRO:PercentHealth('player');
	local _is_PvP																																	= ConRO:IsPvP();
	local _in_combat 																															= UnitAffectingCombat('player');
	local _party_size																															= GetNumGroupMembers();

	local _is_PC																																	= UnitPlayerControlled("target");
	local _is_Enemy 																															= ConRO:TarHostile();
	local _Target_Health 																													= UnitHealth('target');
	local _Target_Percent_Health 																									= ConRO:PercentHealth('target');

--Resources

--Racials
	local _AncestralCall, _AncestralCall_RDY																			= ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	local _ArcanePulse, _ArcanePulse_RDY																					= ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	local _Berserking, _Berserking_RDY																						= ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	local _ArcaneTorrent, _ArcaneTorrent_RDY																			= ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);

--Abilities

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);

--Warnings

--Rotations

	return nil;
end

function ConRO.Priest.Discipline(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Disc_Ability, ids.Disc_Passive, ids.Disc_Form, ids.Disc_Buff, ids.Disc_Debuff, ids.Disc_PetAbility, ids.Disc_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');
	local _party_size = GetNumGroupMembers();

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _DispelMagic, _DispelMagic_RDY = ConRO:AbilityReady(Ability.DispelMagic, timeShift);
	local _HolyNova, _HolyNova_RDY																								= ConRO:AbilityReady(Ability.HolyNova, timeShift);
	local _MindBlast, _MindBlast_RDY																							= ConRO:AbilityReady(Ability.MindBlast, timeShift);
	local _PainSuppression, _PainSuppression_RDY 																	= ConRO:AbilityReady(Ability.PainSuppression, timeShift);
	local _Penance, _Penance_RDY 																									= ConRO:AbilityReady(Ability.Penance, timeShift);
	local _PowerInfusion, _PowerInfusion_RDY 																			= ConRO:AbilityReady(Ability.PowerInfusion, timeShift);
	local _PowerWordBarrier, _PowerWordBarrier_RDY 																= ConRO:AbilityReady(Ability.PowerWordBarrier, timeShift);
	local _PowerWordFortitude, _PowerWordFortitude_RDY 														= ConRO:AbilityReady(Ability.PowerWordFortitude, timeShift);
	local _PowerWordShield, _PowerWordShield_RDY																	= ConRO:AbilityReady(Ability.PowerWordShield, timeShift);
		local _WeakenedSoul_DEBUFF 																										= ConRO:UnitAura(Debuff.WeakenedSoul, timeShift, 'target', 'HARMFUL');
	local _PowerWordRadiance, _PowerWordRadiance_RDY															= ConRO:AbilityReady(Ability.PowerWordRadiance, timeShift);
		local _PowerWordRadiance_CHARGES 																							= ConRO:SpellCharges(_PowerWordRadiance);
		local _Atonement_BUFF 																												= ConRO:UnitAura(Buff.Atonement, timeShift, 'target', 'HELPFUL');
		local _Atonement_COUNT		 																										= ConRO:GroupBuffCount(Buff.Atonement);
		local _Atonement_THRESHOLD																										= ConRO_AtonementBox:GetNumber();
	local _PsychicScream, _PsychicScream_RDY																			= ConRO:AbilityReady(Ability.PsychicScream, timeShift);
	local _Rapture, _Rapture_RDY																									= ConRO:AbilityReady(Ability.Rapture, timeShift);
		local _Rapture_BUFF	 																													= ConRO:Aura(Buff.Rapture, timeShift);
	local _ShadowWordDeath, _ShadowWordDeath_RDY																	= ConRO:AbilityReady(Ability.ShadowWordDeath, timeShift);
	local _ShadowWordPain, _ShadowWordPain_RDY 																		= ConRO:AbilityReady(Ability.ShadowWordPain, timeShift);
		local _ShadowWordPain_DEBUFF 																									= ConRO:TargetAura(Debuff.ShadowWordPain, timeShift + 3);
		local _PoweroftheDarkSide_BUFF	 																							= ConRO:Aura(Buff.PoweroftheDarkSide, timeShift);
	local _Shadowfiend, _Shadowfiend_RDY																					= ConRO:AbilityReady(Ability.Shadowfiend, timeShift);
		local _Shadowfiend_ID																													= select(7, GetSpellInfo(GetSpellInfo(Ability.Shadowfiend)));
	local _Smite, _Smite_RDY 																											= ConRO:AbilityReady(Ability.Smite, timeShift);

	local _AngelicFeather, _AngelicFeather_RDY																		= ConRO:AbilityReady(Ability.AngelicFeather, timeShift);
	local _DivineStar, _DivineStar_RDY 																						= ConRO:AbilityReady(Ability.DivineStar, timeShift);
	local _Evangelism, _Evangelism_RDY, _Evangelism_CD														= ConRO:AbilityReady(Ability.Evangelism, timeShift);
	local _Halo, _Halo_RDY 																												= ConRO:AbilityReady(Ability.Halo, timeShift);
	local _Mindbender, _Mindbender_RDY 																						= ConRO:AbilityReady(Ability.Mindbender, timeShift);
	local _PowerWordSolace, _PowerWordSolace_RDY																	= ConRO:AbilityReady(Ability.PowerWordSolace, timeShift);
	local _PurgetheWicked, _PurgetheWicked_RDY 																		= ConRO:AbilityReady(Ability.PurgetheWicked, timeShift);
		local _PurgetheWicked_DEBUFF																									= ConRO:TargetAura(Debuff.PurgetheWicked, timeShift + 3);
	local _Schism, _Schism_RDY 																										= ConRO:AbilityReady(Ability.Schism, timeShift);
	local _Mindgames, _Mindgames_RDY																							= ConRO:AbilityReady(Ability.Mindgames, timeShift);

--Conditions
	local _is_moving 																															= ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee																			= ConRO:Targets("Melee");
	local _target_in_10yrds 																											= CheckInteractDistance("target", 3);
	local _can_Execute																														= _Target_Percent_Health < 20;

	ConRO:Atonements(_Atonement_COUNT);

--Indicators
	ConRO:AbilityInterrupt(_PsychicScream, _PsychicScream_RDY and ((ConRO:Interrupt() and _target_in_melee) or (_target_in_melee and ConRO:TarYou())));
	ConRO:AbilityPurge(_DispelMagic, _DispelMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_AngelicFeather, _AngelicFeather_RDY);

	ConRO:AbilityBurst(_Mindbender, _Mindbender_RDY and _is_Enemy and (tChosen[Passive.Lenience.talentID] or _SpiritShell_BUFF or _Evangelism_CD >= 85));
	ConRO:AbilityBurst(ids.Glyph.Sha, _Shadowfiend_ID == ids.Glyph.Sha and _Shadowfiend_RDY and _is_Enemy and (tChosen[Passive.Lenience.talentID] or _SpiritShell_BUFF or _Evangelism_CD >= 85) and not tChosen[Passive.Mindbender.talentID]);
	ConRO:AbilityBurst(ids.Glyph.Voidling, _Shadowfiend_ID == ids.Glyph.Voidling and _Shadowfiend_RDY and _is_Enemy and (tChosen[Passive.Lenience.talentID] or _SpiritShell_BUFF or _Evangelism_CD >= 85) and not tChosen[Passive.Mindbender.talentID]);
	ConRO:AbilityBurst(ids.Glyph.Lightspawn, _Shadowfiend_ID == ids.Glyph.Lightspawn and _Shadowfiend_RDY and _is_Enemy and (tChosen[Passive.Lenience.talentID] or _SpiritShell_BUFF or _Evangelism_CD >= 85) and not tChosen[Passive.Mindbender.talentID]);
	ConRO:AbilityBurst(_Shadowfiend, _Shadowfiend_ID == _Shadowfiend and _Shadowfiend_RDY and _is_Enemy and (tChosen[Passive.Lenience.talentID] or _SpiritShell_BUFF or _Evangelism_CD >= 85) and not tChosen[Passive.Mindbender.talentID]);

	ConRO:AbilityBurst(_PowerInfusion, _PowerInfusion_RDY and ((ConRO:IsSolo() and _Atonement_COUNT < 1) or (ConRO:InParty() and _Atonement_COUNT < _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT < _Atonement_THRESHOLD)));
	ConRO:AbilityBurst(_Evangelism, _Evangelism_RDY and ((ConRO:IsSolo() and _Atonement_COUNT == 1) or (ConRO:InParty() and _Atonement_COUNT >= _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT > _Atonement_THRESHOLD)));

	ConRO:AbilityRaidBuffs(_PowerWordFortitude, _PowerWordFortitude_RDY and not ConRO:RaidBuff(Buff.PowerWordFortitude));

	ConRO:AbilityRaidBuffs(_PowerWordShield, _PowerWordShield_RDY and not _Atonement_BUFF and not _WeakenedSoul_DEBUFF and _Target_Percent_Health > 95 and not is_Enemy and (ConRO:InParty() and _Atonement_COUNT < _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT < _Atonement_THRESHOLD));
	ConRO:AbilityRaidBuffs(_PowerWordRadiance, _PowerWordRadiance_RDY and _Atonement_BUFF and not is_Enemy and (ConRO:InParty() and _Atonement_COUNT < _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT < _Atonement_THRESHOLD));

--Warnings
	ConRO:Warnings("Refresh Atonement!", _is_Enemy and (ConRO:InParty() and _Atonement_COUNT < _Atonement_THRESHOLD) or (ConRO:InRaid() and _Atonement_COUNT < _Atonement_THRESHOLD));

--Rotations
	if _Rapture_BUFF then
		if _PowerWordShield_RDY then
			tinsert(ConRO.SuggestedSpells, _PowerWordShield);
		end
	elseif _is_Enemy then
		if not _in_combat then
			if _PurgetheWicked_RDY and not _PurgetheWicked_DEBUFF and (currentSpell == _Schism or currentSpell == _MindBlast or currentSpell == _Smite) then
				tinsert(ConRO.SuggestedSpells, _PurgetheWicked);
			elseif not tChosen[Ability.PurgetheWicked.talentID] and _ShadowWordPain_RDY and not _ShadowWordPain_DEBUFF and (currentSpell == _Schism or currentSpell == _MindBlast or currentSpell == _Smite) then
				tinsert(ConRO.SuggestedSpells, _ShadowWordPain);
			end

			if _Schism_RDY and currentSpell ~= _Schism then
				tinsert(ConRO.SuggestedSpells, _Schism);
			end

			if _Penance_RDY then
				tinsert(ConRO.SuggestedSpells, _Penance);
			end

			if _MindBlast_RDY and currentSpell ~= _MindBlast then
				tinsert(ConRO.SuggestedSpells, _MindBlast);
			end

			if _Smite_RDY and currentSpell ~= _Smite and not _BoonoftheAscended_BUFF then
				tinsert(ConRO.SuggestedSpells, _Smite);
			end
		end

		if _HolyNova_RDY and _enemies_in_melee >= 3 then
			tinsert(ConRO.SuggestedSpells, _HolyNova);
		end

		if _ShadowWordDeath_RDY and _can_Execute then
			tinsert(ConRO.SuggestedSpells, _ShadowWordDeath);
		end

		if _PurgetheWicked_RDY and not _PurgetheWicked_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _PurgetheWicked);
		elseif not tChosen[Ability.PurgetheWicked.talentID] and _ShadowWordPain_RDY and not _ShadowWordPain_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _ShadowWordPain);
		end

		if _Schism_RDY and currentSpell ~= Ability.Schism then
			tinsert(ConRO.SuggestedSpells, _Schism);
		end

		if _Mindgames_RDY then
			tinsert(ConRO.SuggestedSpells, _Mindgames);
		end

		if _DivineStar_RDY then
			tinsert(ConRO.SuggestedSpells, _DivineStar);
		end

		if _Halo_RDY then
			tinsert(ConRO.SuggestedSpells, _Halo);
		end

		if _Penance_RDY then
			tinsert(ConRO.SuggestedSpells, _Penance);
		end

		if _PowerWordSolace_RDY then
			tinsert(ConRO.SuggestedSpells, _PowerWordSolace);
		end

		if _MindBlast_RDY and currentSpell ~= _MindBlast then
			tinsert(ConRO.SuggestedSpells, _MindBlast);
		end

		if _Smite_RDY and not _BoonoftheAscended_BUFF then
			tinsert(ConRO.SuggestedSpells, _Smite);
		end
	end
return nil;
end

function ConRO.Priest.DisciplineDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Disc_Ability, ids.Disc_Passive, ids.Disc_Form, ids.Disc_Buff, ids.Disc_Debuff, ids.Disc_PetAbility, ids.Disc_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');

--Abilities
	local _DesperatePrayer, _DesperatePrayer_RDY = ConRO:AbilityReady(Ability.DesperatePrayer, timeShift);
	local _Fade, _Fade_RDY = ConRO:AbilityReady(Ability.Fade, timeShift);
	local _PainSuppression, _PainSuppression_RDY = ConRO:AbilityReady(Ability.PainSuppression, timeShift);
	local _PowerWordLife, _PowerWordLife_RDY = ConRO:AbilityReady(Ability.PowerWordLife, timeShift);
	local _PowerWordShield, _PowerWordShield_RDY = ConRO:AbilityReady(Ability.PowerWordShield, timeShift);
		local _Atonement_BUFF = ConRO:UnitAura(Buff.Atonement, timeShift, 'player', 'HELPFUL');

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations
	if ConRO:IsSolo() and not _Atonement_BUFF then
		if _PowerWordShield_RDY and _Player_Percent_Health > 95 then
			tinsert(ConRO.SuggestedDefSpells, _PowerWordShield);
		end
	end

	if _PainSuppression_RDY and not _is_Enemy and _Target_Percent_Health <= 25 then
		tinsert(ConRO.SuggestedDefSpells, _PainSuppression);
	end

	if _DesperatePrayer_RDY and _Player_Percent_Health <= 50 then
		tinsert(ConRO.SuggestedDefSpells, _DesperatePrayer);
	end

	if _Fade_RDY and not ConRO:IsSolo() and (ConRO:TarYou() or _enemies_in_melee >= 1) then
		tinsert(ConRO.SuggestedDefSpells, _Fade);
	end

return nil;
end

function ConRO.Priest.Holy(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Holy_Ability, ids.Holy_Passive, ids.Holy_Form, ids.Holy_Buff, ids.Holy_Debuff, ids.Holy_PetAbility, ids.Holy_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _AngelicFeather, _AngelicFeather_RDY = ConRO:AbilityReady(Ability.AngelicFeather, timeShift);
	local _Apotheosis, _Apotheosis_RDY = ConRO:AbilityReady(Ability.Apotheosis, timeShift);
	local _DispelMagic, _DispelMagic_RDY = ConRO:AbilityReady(Ability.DispelMagic, timeShift);
	local _DivineHymn, _DivineHymn_RDY = ConRO:AbilityReady(Ability.DivineHymn, timeShift);
	local _HolyFire, _HolyFire_RDY = ConRO:AbilityReady(Ability.HolyFire, timeShift);
	local _HolyNova, _HolyNova_RDY = ConRO:AbilityReady(Ability.HolyNova, timeShift);
	local _HolyWordChastise, _HolyWordChastise_RDY = ConRO:AbilityReady(Ability.HolyWordChastise, timeShift);
	local _PowerWordFortitude, _PowerWordFortitude_RDY = ConRO:AbilityReady(Ability.PowerWordFortitude, timeShift);
	local _PsychicScream, _PsychicScream_RDY = ConRO:AbilityReady(Ability.PsychicScream, timeShift);
	local _ShadowWordDeath, _ShadowWordDeath_RDY = ConRO:AbilityReady(Ability.ShadowWordDeath, timeShift);
	local _ShadowWordPain, _ShadowWordPain_RDY = ConRO:AbilityReady(Ability.ShadowWordPain, timeShift);
		local _ShadowWordPain_DEBUFF = ConRO:TargetAura(Debuff.ShadowWordPain, timeShift + 3);
	local _Smite, _Smite_RDY = ConRO:AbilityReady(Ability.Smite, timeShift);


	local _DivineStar, _DivineStar_RDY = ConRO:AbilityReady(Ability.DivineStar, timeShift);
	local _Halo, _Halo_RDY = ConRO:AbilityReady(Ability.Halo, timeShift);
	local _HolyWordSalvation, _HolyWordSalvation_RDY = ConRO:AbilityReady(Ability.HolyWordSalvation, timeShift);
	local _Mindgames, _Mindgames_RDY = ConRO:AbilityReady(Ability.Mindgames, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);
	local _can_Execute = _Target_Percent_Health < 20;

--Indicators
	ConRO:AbilityInterrupt(_PsychicScream, _PsychicScream_RDY and ((ConRO:Interrupt() and _target_in_melee) or (_target_in_melee and ConRO:TarYou())));
	ConRO:AbilityPurge(_DispelMagic, _DispelMagic_RDY and ConRO:Purgable())
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_AngelicFeather, _AngelicFeather_RDY);

	ConRO:AbilityRaidBuffs(_PowerWordFortitude, _PowerWordFortitude_RDY and not ConRO:RaidBuff(Buff.PowerWordFortitude));

	ConRO:AbilityBurst(_DivineHymn, _DivineHymn_RDY and _in_combat);
	ConRO:AbilityBurst(_Apotheosis, _Apotheosis_RDY and _in_combat);
	ConRO:AbilityBurst(_HolyWordSalvation, _HolyWordSalvation_RDY and _in_combat);

	ConRO:AbilityBurst(_Mindgames, _Mindgames_RDY and _in_combat);

--Warnings

--Rotations
	if _is_Enemy then
		if _DivineStar_RDY then
			tinsert(ConRO.SuggestedSpells, _DivineStar);
		end

		if _Halo_RDY then
			tinsert(ConRO.SuggestedSpells, _Halo);
		end

		if _HolyWordChastise_RDY then
			tinsert(ConRO.SuggestedSpells, _HolyWordChastise);
		end

		if _HolyFire_RDY and currentSpell ~= Ability.HolyFire then
			tinsert(ConRO.SuggestedSpells, _HolyFire);
		end

		if _ShadowWordPain_RDY and not _ShadowWordPain_DEBUFF then
			tinsert(ConRO.SuggestedSpells, _ShadowWordPain);
		end

		if _HolyNova_RDY and _enemies_in_melee >= 3 then
			tinsert(ConRO.SuggestedSpells, _HolyNova);
		end

		if _Smite_RDY then
			tinsert(ConRO.SuggestedSpells, _Smite);
		end
	end
return nil;
end

function ConRO.Priest.HolyDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Holy_Ability, ids.Holy_Passive, ids.Holy_Form, ids.Holy_Buff, ids.Holy_Debuff, ids.Holy_PetAbility, ids.Holy_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');

--Abilities
	local _GuardianSpirit, _GuardianSpirit_RDY = ConRO:AbilityReady(Ability.GuardianSpirit, timeShift);
	local _DesperatePrayer, _DesperatePrayer_RDY = ConRO:AbilityReady(Ability.DesperatePrayer, timeShift);
	local _PowerWordLife, _PowerWordLife_RDY = ConRO:AbilityReady(Ability.PowerWordLife, timeShift);
	local _PowerWordShield, _PowerWordShield_RDY = ConRO:AbilityReady(Ability.PowerWordShield, timeShift);
		local _WeakenedSoul_DEBUFF = ConRO:UnitAura(Debuff.WeakenedSoul, timeShift, 'player', 'HARMFUL');
		local _PowerWordShield_BUFF = ConRO:Aura(Buff.PowerWordShield, timeShift);
	local _Fade, _Fade_RDY = ConRO:AbilityReady(Ability.Fade, timeShift);

--Conditions
	local _is_Enemy = ConRO:TarHostile();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Rotations
	if _PowerWordLife_RDY and _Player_Percent_Health <= 35 then
		tinsert(ConRO.SuggestedDefSpells, _PowerWordLife);
	end

	if _GuardianSpirit_RDY and _Target_Percent_Health <= 25 and not _is_Enemy then
		tinsert(ConRO.SuggestedDefSpells, _GuardianSpirit);
	end

	if _DesperatePrayer_RDY and _Player_Percent_Health <= 50 then
		tinsert(ConRO.SuggestedDefSpells, _DesperatePrayer);
	end

	if _Fade_RDY and not ConRO:IsSolo() and (ConRO:TarYou() or _enemies_in_melee >= 1) then
		tinsert(ConRO.SuggestedDefSpells, _Fade);
	end

	if _PowerWordShield_RDY and not _WeakenedSoul_DEBUFF and not _PowerWordShield_BUFF then
		tinsert(ConRO.SuggestedDefSpells, _PowerWordShield);
	end
	return nil;
end

function ConRO.Priest.Shadow(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Shad_Ability, ids.Shad_Passive, ids.Shad_Form, ids.Shad_Buff, ids.Shad_Debuff, ids.Shad_PetAbility, ids.Shad_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');
	local _Insanity = ConRO:PlayerPower('Insanity');

--Racials
	local _ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);

--Abilities
	local _Damnation, _Damnation_RDY = ConRO:AbilityReady(Ability.Damnation, timeShift);
	local _DarkAscension, _DarkAscension_RDY = ConRO:AbilityReady(Ability.DarkAscension, timeShift);
		local _DarkAscension_BUFF = ConRO:Aura(Buff.DarkAscension, timeShift);
	local _DarkVoid, _DarkVoid_RDY = ConRO:AbilityReady(Ability.DarkVoid, timeShift);
	local _DevouringPlague, _DevouringPlague_RDY = ConRO:AbilityReady(Ability.DevouringPlague, timeShift);
		local _DevouringPlague_DEBUFF, _, _DevouringPlague_DUR = ConRO:TargetAura(Debuff.DevouringPlague, timeShift);
	local _DispelMagic, _DispelMagic_RDY = ConRO:AbilityReady(Ability.DispelMagic, timeShift);
	local _DivineStar, _DivineStar_RDY = ConRO:AbilityReady(Ability.DivineStar, timeShift);
	local _Halo, _Halo_RDY = ConRO:AbilityReady(Ability.Halo, timeShift);
	local _MindBlast, _MindBlast_RDY = ConRO:AbilityReady(Ability.MindBlast, timeShift + 0.5);
		local _MindBlast_CHARGE, _MindBlast_MCHARGE, _MindBlast_CHARGECD = ConRO:SpellCharges(_MindBlast);
	local _MindFlay, _MindFlay_RDY = ConRO:AbilityReady(Ability.MindFlay, timeShift);
	local _MindFlayInsanity, _MindFlayInsanity_RDY = ConRO:AbilityReady(Ability.MindFlayInsanity, timeShift);
	local _MindFlayInsanity_BUFF = ConRO:Aura(Buff.MindFlayInsanity, timeShift);
	local _MindSear, _MindSear_RDY = ConRO:AbilityReady(Ability.MindSear, timeShift);
	local _MindSpike, _MindSpike_RDY = ConRO:AbilityReady(Ability.MindSpike, timeShift);
		local _MindMelt_BUFF, _MindMelt_COUNT = ConRO:Aura(Buff.MindMelt, timeShift);
		local _SurgeofDarkness_Buff = ConRO:Aura(Buff.SurgeofDarkness, timeShift);
	local _Mindbender, _Mindbender_RDY = ConRO:AbilityReady(Ability.Mindbender, timeShift);
		local _Mindbender_ACTIVE, _Mindbender_DUR = ConRO:Totem(_Mindbender);
	local _Mindgames, _Mindgames_RDY = ConRO:AbilityReady(Ability.Mindgames, timeShift);
	local _PowerInfusion, _PowerInfusion_RDY = ConRO:AbilityReady(Ability.PowerInfusion, timeShift);
		local _PowerInfusion_BUFF = ConRO:Aura(Buff.PowerInfusion, timeShift);
	local _PowerWordFortitude, _PowerWordFortitude_RDY = ConRO:AbilityReady(Ability.PowerWordFortitude, timeShift);
	local _PowerWordShield, _PowerWordShield_RDY = ConRO:AbilityReady(Ability.PowerWordShield, timeShift);
		local _PowerWordShield_BUFF  = ConRO:Aura(Buff.PowerWordShield, timeShift);
	local _PsychicHorror, _PsychicHorror_RDY = ConRO:AbilityReady(Ability.PsychicHorror, timeShift);
	local _PsychicScream, _PsychicScream_RDY = ConRO:AbilityReady(Ability.PsychicScream, timeShift);
	local _Shadowfiend, _Shadowfiend_RDY = ConRO:AbilityReady(Ability.Shadowfiend, timeShift + 1);
		local _Shadowfiend_ID = select(7, GetSpellInfo(GetSpellInfo(Ability.Shadowfiend)));
	local _Silence, _Silence_RDY = ConRO:AbilityReady(Ability.Silence, timeShift);
	local _ShadowCrash, _ShadowCrash_RDY, _ShadowCrash_CD = ConRO:AbilityReady(Ability.ShadowCrash, timeShift);
	local _ShadowWordDeath, _ShadowWordDeath_RDY = ConRO:AbilityReady(Ability.ShadowWordDeath, timeShift + 0.5);
	local _ShadowWordPain, _ShadowWordPain_RDY = ConRO:AbilityReady(Ability.ShadowWordPain, timeShift);
		local _ShadowWordPain_DEBUFF, _, _ShadowWordPain_DUR = ConRO:TargetAura(Debuff.ShadowWordPain, timeShift + 3);

	local _Shadowform, _Shadowform_RDY = ConRO:AbilityReady(Ability.Shadowform, timeShift);
		local _Shadowform_FORM = ConRO:Form(Form.Shadowform);
	local _VoidEruption, _VoidEruption_RDY = ConRO:AbilityReady(Ability.VoidEruption, timeShift);
		local _Voidform_BUFF = ConRO:Aura(Buff.Voidform);
	local _VoidBolt, _VoidBolt_RDY = ConRO:AbilityReady(Ability.VoidBolt, timeShift);
	local _VampiricTouch, _VampiricTouch_RDY = ConRO:AbilityReady(Ability.VampiricTouch, timeShift);
		local _VampiricTouch_DEBUFF, _, _VampiricTouch_DUR = ConRO:TargetAura(Debuff.VampiricTouch, timeShift + 4);
	local _VoidTorrent, _VoidTorrent_RDY = ConRO:AbilityReady(Ability.VoidTorrent, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
	local _enemies_in_40yrds, _target_in_40yrds = ConRO:Targets("40");
	local _can_Execute = _Target_Percent_Health < 20;

	if tChosen[Passive.MindMelt.talentID] and currentSpell == _MindSpike then
		_MindMelt_COUNT = _MindMelt_COUNT + 1;
	end

--Indicators
	ConRO:AbilityInterrupt(_Silence, _Silence_RDY and ConRO:Interrupt());
	ConRO:AbilityInterrupt(_PsychicHorror, _PsychicHorror_RDY and (ConRO:Interrupt() and not _Silence_RDY and _is_PC and _is_Enemy));
	ConRO:AbilityInterrupt(_PsychicScream, _PsychicScream_RDY and ((ConRO:Interrupt() and not _Silence_RDY and _target_in_melee) or (_target_in_melee and ConRO:TarYou())) and _is_PC and _is_Enemy);
	ConRO:AbilityPurge(_DispelMagic, _DispelMagic_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityMovement(_PowerWordShield, _PowerWordShield_RDY and not _WeakenedSoul_DEBUFF and tChosen[Passive.BodyandSoul.talentID]);

	ConRO:AbilityRaidBuffs(_PowerWordFortitude, _PowerWordFortitude_RDY and not ConRO:RaidBuff(Buff.PowerWordFortitude));

	ConRO:AbilityBurst(_VoidEruption, _VoidEruption_RDY and not _Voidform_BUFF and ConRO:BurstMode(_VoidEruption));
	ConRO:AbilityBurst(_PowerInfusion, _PowerInfusion_RDY and not _Voidform_BUFF and _Insanity >= 40 and ConRO:BurstMode(_PowerInfusion));
	ConRO:AbilityBurst(_VoidTorrent, _VoidTorrent_RDY and not _Voidform_BUFF and _VampiricTouch_DEBUFF and _ShadowWordPain_DEBUFF and ConRO:BurstMode(_VoidTorrent));
	ConRO:AbilityBurst(_Damnation, _Damnation_RDY and not _VampiricTouch_DEBUFF and not _ShadowWordPain_DEBUFF and currentSpell ~= _VampiricTouch and ConRO:BurstMode(_Damnation));

	ConRO:AbilityBurst(ids.Glyph.Sha, _Shadowfiend_ID == ids.Glyph.Sha and _Shadowfiend_RDY and not tChosen[Ability.Mindbender.talentID] and ConRO:BurstMode(_Shadowfiend));
	ConRO:AbilityBurst(ids.Glyph.Voidling, _Shadowfiend_ID == ids.Glyph.Voidling and _Shadowfiend_RDY and not tChosen[Ability.Mindbender.talentID] and ConRO:BurstMode(_Shadowfiend));
	ConRO:AbilityBurst(ids.Glyph.Lightspawn, _Shadowfiend_ID == ids.Glyph.Lightspawn and _Shadowfiend_RDY and not tChosen[Ability.Mindbender.talentID] and ConRO:BurstMode(_Shadowfiend));
	ConRO:AbilityBurst(_Shadowfiend, _Shadowfiend_ID == _Shadowfiend and _Shadowfiend_RDY and not tChosen[Ability.Mindbender.talentID] and ConRO:BurstMode(_Shadowfiend));
	ConRO:AbilityBurst(_Mindbender, _Mindbender_RDY and ConRO:BurstMode(_Mindbender, timeShift));
	ConRO:AbilityBurst(_Mindgames, _Mindgames_RDY and (_Voidform_BUFF or (_VampiricTouch_DEBUFF and _ShadowWordPain_DEBUFF and _DevouringPlague_DEBUFF)) and ConRO:BurstMode(_Mindgames));

--Warnings

--Rotations
	if select(2, ConRO:EndChannel()) == _VoidTorrent and select(1, ConRO:EndChannel()) > 1 then
		tinsert(ConRO.SuggestedSpells, _VoidTorrent);
	end

	if _Shadowform_RDY and not _Shadowform_FORM and not _Voidform_BUFF then
		tinsert(ConRO.SuggestedSpells, _Shadowform);
		_Shadowform_FORM = true;
	end

	if not _in_combat then
		if _ShadowCrash_RDY then
			tinsert(ConRO.SuggestedSpells, _ShadowCrash);
			_ShadowCrash_RDY = false;
			_VampiricTouch_DEBUFF = true;
		end

		if _VampiricTouch_RDY and (not _VampiricTouch_DEBUFF or (tChosen[Passive.Misery.talentID] and not _ShadowWordPain_DEBUFF)) and currentSpell ~= _VampiricTouch and ConRO.lastSpellId ~= _ShadowCrash then
			tinsert(ConRO.SuggestedSpells, _VampiricTouch);
			_VampiricTouch_DEBUFF = true;
		end

		if _ShadowWordPain_RDY and ((not _ShadowWordPain_DEBUFF and not tChosen[Passive.Misery.talentID]) or (_is_moving and _ShadowWordPain_DEBUFF and _ShadowWordPain_DUR <= 5)) then
			tinsert(ConRO.SuggestedSpells, _ShadowWordPain);
			_ShadowWordPain_DEBUFF = true;
		end
	end

	if _ShadowCrash_RDY and not _VampiricTouch_DEBUFF then
		tinsert(ConRO.SuggestedSpells, _ShadowCrash);
		_ShadowCrash_RDY = false;
		_VampiricTouch_DEBUFF = true;
	end

	if _VampiricTouch_RDY and (not _VampiricTouch_DEBUFF or (tChosen[Passive.Misery.talentID] and not _ShadowWordPain_DEBUFF)) and currentSpell ~= _VampiricTouch and ConRO.lastSpellId ~= _ShadowCrash then
		tinsert(ConRO.SuggestedSpells, _VampiricTouch);
		_VampiricTouch_DEBUFF = true;
	end

	if _ShadowWordPain_RDY and ((not _ShadowWordPain_DEBUFF and not tChosen[Passive.Misery.talentID]) or (_is_moving and _ShadowWordPain_DEBUFF and _ShadowWordPain_DUR <= 5)) then
		tinsert(ConRO.SuggestedSpells, _ShadowWordPain);
		_ShadowWordPain_DEBUFF = true;
	end

	if tChosen[Ability.Mindbender.talentID] then
		if _Mindbender_RDY and ConRO:FullMode(_Mindbender) then
			tinsert(ConRO.SuggestedSpells, _Mindbender);
			_Mindbender_RDY = false;
		end
	else
		if _Shadowfiend_RDY and ConRO:FullMode(_Shadowfiend) then
			if _Shadowfiend_ID == Glyph.Sha then
				tinsert(ConRO.SuggestedSpells, Glyph.Sha);
			elseif _Shadowfiend_ID == ids.Glyph.Voidling then
				tinsert(ConRO.SuggestedSpells, Glyph.Voidling);
			elseif _Shadowfiend_ID == ids.Glyph.Lightspawn then
				tinsert(ConRO.SuggestedSpells, Glyph.Lightspawn);
			else
				tinsert(ConRO.SuggestedSpells, _Shadowfiend);
			end
		end
	end

	if _VoidEruption_RDY and currentSpell ~= _VoidEruption and not _Voidform_BUFF and ConRO:FullMode(_VoidEruption) then
		tinsert(ConRO.SuggestedSpells, _VoidEruption);
		_VoidEruption_RDY = false;
	end

	if _DarkAscension_RDY and currentSpell ~= _DarkAscension and ConRO:FullMode(_DarkAscension) then
		tinsert(ConRO.SuggestedSpells, _DarkAscension);
		_DarkAscension_RDY = false;
	end

	if _PowerInfusion_RDY and (_DarkAscension_BUFF or _Voidform_BUFF or currentSpell == _DarkAscension or currentSpell == _VoidEruption) and ConRO:FullMode(_PowerInfusion) then
		tinsert(ConRO.SuggestedSpells, _PowerInfusion);
		_PowerInfusion_RDY = false;
	end

	if _ShadowWordDeath_RDY and _Mindbender_ACTIVE and tChosen[Passive.InescapableTorment.talentID] then
		tinsert(ConRO.SuggestedSpells, _ShadowWordDeath);
		_ShadowWordDeath_RDY = false;
	end

	if _MindSpike_RDY and (tChosen[Passive.MindMelt.talentID] and not tChosen[Passive.IdolofCThun.talentID]) and ((_MindBlast_CHARGE >= _MindBlast_MCHARGE) or (_MindBlast_CHARGE >= _MindBlast_MCHARGE -1 and _MindBlast_CHARGECD < 3))  and _MindMelt_COUNT < 2 then
		tinsert(ConRO.SuggestedSpells, _MindSpike);
		_MindMelt_COUNT = _MindMelt_COUNT + 1;
	end

	if _MindBlast_RDY and ((_MindBlast_CHARGE >= _MindBlast_MCHARGE) or (_MindMelt_COUNT >= 2)) and currentSpell ~= _MindBlast then
		tinsert(ConRO.SuggestedSpells, _MindBlast);
		_MindBlast_CHARGE = _MindBlast_CHARGE - 1;
	end

	if _Damnation_RDY and not _VampiricTouch_DEBUFF and not _ShadowWordPain_DEBUFF and currentSpell ~= _VampiricTouch and ConRO:FullMode(_Damnation) then
		tinsert(ConRO.SuggestedSpells, _Damnation);
		_Damnation_RDY = false;
	end

	if _VoidBolt_RDY and _Voidform_BUFF then
		tinsert(ConRO.SuggestedSpells, _VoidBolt);
		_VoidBolt_RDY = false;
	end

	if _MindSear_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
		tinsert(ConRO.SuggestedSpells, _MindSear);
	else
		if _DevouringPlague_RDY and (not _DevouringPlague_DEBUFF or _DevouringPlague_DUR <= 1 or _Insanity > 90) then
			tinsert(ConRO.SuggestedSpells, _DevouringPlague);
		end
	end

	if _VampiricTouch_RDY and (not _VampiricTouch_DEBUFF or (tChosen[Passive.Misery.talentID] and not _ShadowWordPain_DEBUFF)) and currentSpell ~= _VampiricTouch and ConRO.lastSpellId ~= _ShadowCrash and (not tChosen[Ability.ShadowCrash.talentID] or (tChosen[Ability.ShadowCrash.talentID] and _ShadowCrash_CD >= (_VampiricTouch_DUR + 1))) then
		tinsert(ConRO.SuggestedSpells, _VampiricTouch);
		_VampiricTouch_RDY = false;
	end

	if _ShadowWordPain_RDY and ((not _ShadowWordPain_DEBUFF and not tChosen[Passive.Misery.talentID]) or (_is_moving and _ShadowWordPain_DEBUFF and _ShadowWordPain_DUR <= 4)) then
		tinsert(ConRO.SuggestedSpells, _ShadowWordPain);
		_ShadowWordPain_RDY = false;
	end

	if _ShadowWordDeath_RDY and _can_Execute and _Player_Percent_Health >= 50 then
		tinsert(ConRO.SuggestedSpells, _ShadowWordDeath);
		_ShadowWordDeath_RDY = false;
	end

	if _MindSpike_RDY and (tChosen[Passive.MindMelt.talentID] and not tChosen[Passive.IdolofCThun.talentID]) and _MindBlast_RDY and _MindMelt_COUNT < 2 then
		tinsert(ConRO.SuggestedSpells, _MindSpike);
		_MindMelt_COUNT = _MindMelt_COUNT + 1;
	end

	if _MindBlast_RDY and currentSpell ~= _MindBlast then
		tinsert(ConRO.SuggestedSpells, _MindBlast);
		_MindBlast_RDY = false;
	end

	if _Mindgames_RDY and currentSpell ~= _Mindgames and ConRO:FullMode(_Mindgames) then
		tinsert(ConRO.SuggestedSpells, _Mindgames);
		_Mindgames_RDY = false;
	end

	if _ShadowCrash_RDY then
		tinsert(ConRO.SuggestedSpells, _ShadowCrash);
		_ShadowCrash_RDY = false;
	end

	if _DarkVoid_RDY then
		tinsert(ConRO.SuggestedSpells, _DarkVoid);
		_DarkVoid_RDY = false;
	end

	if _VoidTorrent_RDY and (_Insanity <= 35) and _VampiricTouch_DEBUFF and _ShadowWordPain_DEBUFF and ConRO:FullMode(_VoidTorrent) then
		tinsert(ConRO.SuggestedSpells, _VoidTorrent);
		_VoidTorrent_RDY = false;
	end

	if _MindSpike_RDY and _SurgeofDarkness_Buff then
		tinsert(ConRO.SuggestedSpells, _MindSpike);
		_MindMelt_COUNT = _MindMelt_COUNT + 1;
	end

	if _MindFlayInsanity_RDY and _MindFlayInsanity_BUFF and select(2, ConRO:EndChannel()) ~= _MindFlayInsanity and tChosen[Passive.ScreamsoftheVoid.talentID] then
		tinsert(ConRO.SuggestedSpells, _MindFlayInsanity);
	end

	if _Halo_RDY and currentSpell ~= _Halo then
		tinsert(ConRO.SuggestedSpells, _Halo);
		_Halo_RDY = false;
	end

	if _DivineStar_RDY then
		tinsert(ConRO.SuggestedSpells, _DivineStar);
		_DivineStar_RDY = false;
	end

	if _MindFlayInsanity_RDY and _MindFlayInsanity_BUFF and select(2, ConRO:EndChannel()) ~= _MindFlayInsanity then
		tinsert(ConRO.SuggestedSpells, _MindFlayInsanity);
	end

	if _MindSpike_RDY then
		tinsert(ConRO.SuggestedSpells, _MindSpike);
	end

	if _MindFlay_RDY then
		tinsert(ConRO.SuggestedSpells, _MindFlay);
	end
	return nil;
end

function ConRO.Priest.ShadowDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells)
	local Racial, Ability, Passive, Form, Buff, Debuff, PetAbility, PvPTalent, Glyph = ids.Racial, ids.Shad_Ability, ids.Shad_Passive, ids.Shad_Form, ids.Shad_Buff, ids.Shad_Debuff, ids.Shad_PetAbility, ids.Shad_PvPTalent, ids.Glyph;
--Info
	local _Player_Level = UnitLevel("player");
	local _Player_Percent_Health = ConRO:PercentHealth('player');
	local _is_PvP = ConRO:IsPvP();
	local _in_combat = UnitAffectingCombat('player');

	local _is_PC = UnitPlayerControlled("target");
	local _is_Enemy = ConRO:TarHostile();
	local _Target_Health = UnitHealth('target');
	local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
	local _Mana, _Mana_Max = ConRO:PlayerPower('Mana');
	local _Insanity = ConRO:PlayerPower('Insanity');

--Abilities
	local _PowerWordLife, _PowerWordLife_RDY = ConRO:AbilityReady(Ability.PowerWordLife, timeShift);
	local _PowerWordShield, _PowerWordShield_RDY = ConRO:AbilityReady(Ability.PowerWordShield, timeShift);
		local _WeakenedSoul_DEBUFF = ConRO:UnitAura(Debuff.WeakenedSoul, timeShift, 'player', 'HARMFUL');
		local _PowerWordShield_BUFF = ConRO:Aura(Buff.PowerWordShield, timeShift);
	local _DesperatePrayer, _DesperatePrayer_RDY = ConRO:AbilityReady(Ability.DesperatePrayer, timeShift);
	local _Fade, _Fade_RDY = ConRO:AbilityReady(Ability.Fade, timeShift);
	local _Dispersion, _Dispersion_RDY = ConRO:AbilityReady(Ability.Dispersion, timeShift);
	local _VampiricEmbrace, _VampiricEmbrace_RDY = ConRO:AbilityReady(Ability.VampiricEmbrace, timeShift);

--Conditions
	local _is_moving = ConRO:PlayerSpeed();
	local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	local _target_in_10yrds = CheckInteractDistance("target", 3);

--Indicators

--Warnings

--Rotations
		if _PowerWordLife_RDY and _Player_Percent_Health <= 35 then
			tinsert(ConRO.SuggestedDefSpells, _PowerWordLife);
		end

		if _DesperatePrayer_RDY and _Player_Percent_Health <= 50 then
			tinsert(ConRO.SuggestedDefSpells, _DesperatePrayer);
		end

		if _VampiricEmbrace_RDY and _Player_Percent_Health <= 75 then
			tinsert(ConRO.SuggestedDefSpells, _VampiricEmbrace);
		end

		if _Dispersion_RDY and _Player_Percent_Health <= 40 then
			tinsert(ConRO.SuggestedDefSpells, _Dispersion);
		end

		if _Fade_RDY and not ConRO:IsSolo() and (ConRO:TarYou() or _enemies_in_melee >= 1) then
			tinsert(ConRO.SuggestedDefSpells, _Fade);
		end

		if _PowerWordShield_RDY and not _PowerWordShield_BUFF then
			tinsert(ConRO.SuggestedDefSpells, _PowerWordShield);
		end
	return nil;
end
