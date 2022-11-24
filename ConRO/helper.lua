ConRO.RaidBuffs = {};
ConRO.WarningFlags = {};

-- Global cooldown spell id
-- GlobalCooldown = 61304;

local INF = 2147483647;

function ConRO:SpecName()
	local currentSpec = GetSpecialization();
	local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or 'None';
	return currentSpecName;
end

function ConRO:CheckTalents()
	self.PlayerTalents = {};
	wipe(self.PlayerTalents)
	local specID = PlayerUtil.GetCurrentSpecID();
	local configID = C_ClassTalents.GetLastSelectedSavedConfigID(specID) or C_ClassTalents.GetActiveConfigID();
	local configInfo = C_Traits.GetConfigInfo(configID);
	local treeID = configInfo.treeIDs[1];
	local nodes = C_Traits.GetTreeNodes(treeID);

	for _, nodeID in ipairs(nodes) do
		local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID);
			if nodeInfo.currentRank and nodeInfo.currentRank > 0 then
				local entryID = nodeInfo.activeEntry and nodeInfo.activeEntry.entryID and nodeInfo.activeEntry.entryID;
				local entryInfo = entryID and C_Traits.GetEntryInfo(configID, entryID)
				local definitionInfo = entryInfo and entryInfo.definitionID and C_Traits.GetDefinitionInfo(entryInfo.definitionID)
				if definitionInfo ~= nil then
					local name = TalentUtil.GetTalentName(definitionInfo.overrideName, definitionInfo.spellID)
					tinsert(self.PlayerTalents, entryID);
					self.PlayerTalents[entryID] = {};
					tinsert(self.PlayerTalents[entryID], {["talentName"] = name, ["rank"] = nodeInfo.currentRank})
				end
			end
	end
end

function ConRO:IsPvP()
	local _is_PvP = UnitIsPVP('player');
	local _is_Arena, _is_Registered = IsActiveBattlefieldArena();
	local _Flagged = false;
		if _is_PvP or _is_Arena then
			_Flagged = true;
		end
	return _Flagged;
end

function ConRO:CheckPvPTalents()
	self.PvPTalents = {};
	local talents = C_SpecializationInfo.GetAllSelectedPvpTalentIDs();
	for k,v in ipairs(talents) do
		local _, name, _, _, _, id = GetPvpTalentInfoByID(v or 0);
		self.PvPTalents[id] = name;
	end
end

function ConRO:TalentChosen(entryCheck, rankCheck)
	if rankCheck ~= nil and self.PlayerTalents.entryCheck[rank] >= rankCheck then
		return true;
	else
		return self.PlayerTalents[entryCheck];
	end
end

function ConRO:PvPTalentChosen(talent)
	return self.PvPTalents[talent];
end

function ConRO:BurstMode(_Spell_ID, timeShift)
	local _Burst = ConRO_BurstButton:IsVisible();
	local timeShift = timeShift or ConRO:EndCast();
	local _Burst_Threshold = ConRO.db.profile._Burst_Threshold;
	local _, _, baseCooldown = ConRO:Cooldown(_Spell_ID, timeShift);
	local _Burst_Mode = false;

	if _Burst and baseCooldown >= _Burst_Threshold then
		_Burst_Mode = true;
	end

	return _Burst_Mode;
end

function ConRO:FullMode(_Spell_ID, timeShift)
	local _Full = ConRO_FullButton:IsVisible();
	local _Burst = ConRO_BurstButton:IsVisible();
	local timeShift = timeShift or ConRO:EndCast();
	local _Burst_Threshold = ConRO.db.profile._Burst_Threshold;
	local _, _, baseCooldown = ConRO:Cooldown(_Spell_ID, timeShift);
	local _Full_Mode = false;

	if _Burst and baseCooldown < _Burst_Threshold then
		_Full_Mode = true;
	elseif _Full then
		_Full_Mode = true;
	end

	return _Full_Mode;
end

function ConRO:Warnings(_Message, _Condition)
	if self.WarningFlags[_Message] == nil then
		self.WarningFlags[_Message] = 0;
	end
	if _Condition then
		self.WarningFlags[_Message] = self.WarningFlags[_Message] + 1;
		if self.WarningFlags[_Message] == 1 then
			UIErrorsFrame:AddMessage(_Message, 1.0, 1.0, 0.0, 1.0);
		elseif self.WarningFlags[_Message] == 15 then
			self.WarningFlags[_Message] = 0;
		end
	else
		self.WarningFlags[_Message] = 0;
	end
end

ConRO.ItemSlotList = {
	"HeadSlot",
	"NeckSlot",
	"ShoulderSlot",
	"BackSlot",
	"ChestSlot",
	"WristSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	"Finger0Slot",
	"Finger1Slot",
	"Trinket0Slot",
	"Trinket1Slot",
	"MainHandSlot",
	"SecondaryHandSlot",
}

function ConRO:ItemEquipped(_item_string)
	local _match_item_NAME = false;
	local _, _item_LINK = GetItemInfo(_item_string);

	if _item_LINK ~= nil then
		local _item_NAME = GetItemInfo(_item_LINK);

		for i, v in ipairs(ConRO.ItemSlotList) do
			local _slot_LINK = GetInventoryItemLink("player", GetInventorySlotInfo(v));
			if _slot_LINK then
				local _slot_item_NAME = GetItemInfo(_slot_LINK);

				if _slot_item_NAME == _item_NAME then
					_match_item_NAME = true;
					break;
				end
			end
		end
	end
	return _match_item_NAME;
end

function ConRO:PlayerSpeed()
	local speed  = (GetUnitSpeed("player") / 7) * 100;
	local moving = false;
		if speed > 0 then
			moving = true;
		else
			moving = false;
		end
	return moving;
end

ConRO.EnergyList = {
	[0]	= 'Mana',
	[1] = 'Rage',
	[2]	= 'Focus',
	[3] = 'Energy',
	[4]	= 'Combo',
	[6] = 'RunicPower',
	[7]	= 'SoulShards',
	[8] = 'LunarPower',
	[9] = 'HolyPower',
	[11] = 'Maelstrom',
	[12] = 'Chi',
	[13] = 'Insanity',
	[16] = 'ArcaneCharges',
	[17] = 'Fury',
}

function ConRO:PlayerPower(_EnergyType)
	for k, v in pairs(ConRO.EnergyList) do
		if v == _EnergyType then
			resource = k;
			break
		end
	end

	local _Resource = UnitPower('player', resource);
	local _Resource_Max	= UnitPowerMax('player', resource);
	local _Resource_Percent = math.max(0, _Resource) / math.max(1, _Resource_Max) * 100;

	return _Resource, _Resource_Max, _Resource_Percent;
end

function ConRO:Targets(spellID)
	local target_in_range = false;
	local number_in_range = 0;
		if spellID == "Melee" then
			if IsItemInRange(37727, "target") then
				target_in_range = true;
			end

			for i = 1, 15 do
				if not UnitIsFriend("player", 'nameplate' .. i) then
					if UnitExists('nameplate' .. i) and IsItemInRange(37727, "nameplate"..i) == true then
						number_in_range = number_in_range + 1
					end
				end
			end
		else
			if ConRO:IsSpellInRange(spellID, "target") then
				target_in_range = true;
			end

			for i = 1, 15 do
				if UnitExists('nameplate' .. i) and ConRO:IsSpellInRange(spellID, 'nameplate' .. i) then
					number_in_range = number_in_range + 1
				end
			end
		end
--	print(number_in_range .. " " .. target_in_range)
	return number_in_range, target_in_range;
end

function ConRO:UnitAura(spellID, timeShift, unit, filter, isWeapon)
	timeShift = timeShift or 0;
	if isWeapon == "Weapon" then
		local hasMainHandEnchant, mainHandExpiration, _, mainBuffId, hasOffHandEnchant, offHandExpiration, _, offBuffId = GetWeaponEnchantInfo()
		if hasMainHandEnchant and mainBuffId == spellID then
			if mainHandExpiration ~= nil and (mainHandExpiration/1000) > timeShift then
				local dur = (mainHandExpiration/1000) - (timeShift or 0);
				return true, count, dur;
			end
		elseif hasOffHandEnchant and offBuffId == spellID then
			if offHandExpiration ~= nil and (offHandExpiration/1000) > timeShift then
				local dur = (offHandExpiration/1000) - (timeShift or 0);
				return true, count, dur;
			end
		end
	else
		for i=1,40 do
			local _, _, count, _, _, expirationTime, _, _, _, spell = UnitAura(unit, i, filter);
			if spell == spellID then
				if expirationTime ~= nil and (expirationTime - GetTime()) > timeShift then
					local dur = expirationTime - GetTime() - (timeShift or 0);
					return true, count, dur;
				end
			end
		end
	end
	return false, 0, 0;
end

function ConRO:Form(spellID)
	for i=1,40 do
		local _, _, count, _, _, _, _, _, _, spell = UnitAura("player", i);
			if spell == spellID then
				return true, count;
			end
	end
	return false, 0;
end

function ConRO:PersistentDebuff(spellID)
	for i=1,40 do
		local _, _, count, _, _, _, _, _, _, spell = UnitAura("target", i, 'PLAYER|HARMFUL');
			if spell == spellID then
				return true, count;
			end

	end
	return false, 0;
end

function ConRO:Aura(spellID, timeShift, filter)
	return self:UnitAura(spellID, timeShift, 'player', filter);
end

function ConRO:TargetAura(spellID, timeShift)
	return self:UnitAura(spellID, timeShift, 'target', 'PLAYER|HARMFUL');
end

function ConRO:Purgable()
	local purgable = false;
	for i=1,40 do
	local _, _, _, _, _, _, _, isStealable = UnitAura('target', i, 'HELPFUL');
		if isStealable == true then
			purgable = true;
		end
	end
	return purgable;
end

function ConRO:Heroism()
	local _Bloodlust = 2825;
	local _TimeWarp	= 80353;
	local _Heroism = 32182;
	local _AncientHysteria = 90355;
	local _Netherwinds = 160452;
	local _DrumsofFury = 120257;
	local _DrumsofFuryBuff = 178207;
	local _DrumsoftheMountain = 142406;
	local _DrumsoftheMountainBuff = 230935;

	local _Exhaustion = 57723;
	local _Sated = 57724;
	local _TemporalDisplacement = 80354;
	local _Insanity = 95809;
	local _Fatigued = 160455;

	local buffed = false;
	local sated = false;

		local hasteBuff = {
			bl = ConRO:Aura(_Bloodlust, timeShift);
			tw = ConRO:Aura(_TimeWarp, timeShift);
			hero = ConRO:Aura(_Heroism, timeShift);
			ah = ConRO:Aura(_AncientHysteria, timeShift);
			nw = ConRO:Aura(_Netherwinds, timeShift);
			dof = ConRO:Aura(_DrumsofFuryBuff, timeShift);
			dotm = ConRO:Aura(_DrumsoftheMountainBuff, timeShift);
		}
		local satedDebuff = {
			ex = UnitDebuff('player', _Exhaustion);
			sated = UnitDebuff('player', _Sated);
			td = UnitDebuff('player', _TemporalDisplacement);
			ins = UnitDebuff('player', _Insanity);
			fat = UnitDebuff('player', _Fatigued);
		}
		local hasteCount = 0;
			for k, v in pairs(hasteBuff) do
				if v then
					hasteCount = hasteCount + 1;
				end
			end

		if hasteCount > 0 then
			buffed = true;
		end

		local satedCount = 0;
			for k, v in pairs(satedDebuff) do
				if v then
					satedCount = satedCount + 1;
				end
			end

		if satedCount > 0 then
			sated = true;
		end

	return buffed, sated;
end

function ConRO:InRaid()
	local numGroupMembers = GetNumGroupMembers();
	if numGroupMembers >= 6 then
		return true;
	else
		return false;
	end
end

function ConRO:InParty()
	local numGroupMembers = GetNumGroupMembers();
	if numGroupMembers >= 2 and numGroupMembers <= 5 then
		return true;
	else
		return false;
	end
end

function ConRO:IsSolo()
	local numGroupMembers = GetNumGroupMembers();
	if numGroupMembers <= 1 then
		return true;
	else
		return false;
	end
end

function ConRO:RaidBuff(spellID)
	local selfhasBuff = false;
	local haveBuff = false;
	local buffedRaid = false;

	local numGroupMembers = GetNumGroupMembers();
		if numGroupMembers >= 6 then
			selfhasBuff = true;
			for i = 1, numGroupMembers do -- For each raid member
				local unit = "raid" .. i;
				if UnitExists(unit) then
					if not UnitIsDeadOrGhost(unit) and UnitInRange(unit) then
						for x=1, 40 do
							local spell = select(10, UnitAura(unit, x, 'HELPFUL'));
							if spell == spellID then
								haveBuff = true;
								break;
							end
						end
						if not haveBuff then
							break;
						end
					else
						haveBuff = true;
					end
				end
			end
		elseif numGroupMembers >= 2 and numGroupMembers <= 5 then
			for i = 1, 4 do -- For each party member
				local unit = "party" .. i;
				if UnitExists(unit) then
					if not UnitIsDeadOrGhost(unit) and UnitInRange(unit) then
						for x=1, 40 do
							local spell = select(10, UnitAura(unit, x, 'HELPFUL'));
							if spell == spellID then
								haveBuff = true;
								break;
							end
						end
						if not haveBuff then
							break;
						end
					else
						haveBuff = true;
					end
				end
			end
			for x=1, 40 do
				local spell = select(10, UnitAura('player', x, 'HELPFUL'));
				if spell == spellID then
					selfhasBuff = true;
					break;
				end
			end
		elseif numGroupMembers <= 1 then
			for x=1, 40 do
				local spell = select(10, UnitAura('player', x, 'HELPFUL'));
				if spell == spellID then
					selfhasBuff = true;
					haveBuff = true;
					break;
				end
			end
		end
		if selfhasBuff and haveBuff then
			buffedRaid = true;
		end
--	self:Print(self.Colors.Info .. numGroupMembers);
	return buffedRaid;
end

function ConRO:OneBuff(spellID)
	local selfhasBuff = false;
	local haveBuff = false;
	local someoneHas = false;

	local numGroupMembers = GetNumGroupMembers();
		if numGroupMembers >= 6 then
			for i = 1, numGroupMembers do -- For each raid member
				local unit = "raid" .. i;
				if UnitExists(unit) then
					for x=1, 40 do
						local spell = select(10, UnitAura(unit, x, 'PLAYER|HELPFUL'));
						if spell == spellID then
							haveBuff = true;
							break;
						end
					end
					if haveBuff then
						break;
					end
				end
			end
		elseif numGroupMembers >= 2 and numGroupMembers <= 5 then
			for x=1, 40 do
				local spell = select(10, UnitAura('player', x, 'PLAYER|HELPFUL'));
				if spell == spellID then
					selfhasBuff = true;
					break;
				end
			end
			if not selfhasBuff then
				for i = 1, 4 do -- For each party member
					local unit = "party" .. i;
					if UnitExists(unit) then
						for x=1, 40 do
							local spell = select(10, UnitAura(unit, x, 'PLAYER|HELPFUL'));
							if spell == spellID then
								haveBuff = true;
								break;
							end
						end
						if haveBuff then
							break;
						end
					end
				end
			end
		elseif numGroupMembers <= 1 then
			for x=1, 40 do
				local spell = select(10, UnitAura('player', x, 'PLAYER|HELPFUL'));
				if spell == spellID then
					selfhasBuff = true;
					break;
				end
			end
		end
		if selfhasBuff or haveBuff then
			someoneHas = true;
		end
--	self:Print(self.Colors.Info .. numGroupMembers);
	return someoneHas;
end

function ConRO:GroupBuffCount(spellID)
	local buffCount = 0;

	local numGroupMembers = GetNumGroupMembers();
		if numGroupMembers >= 6 then
			for i = 1, numGroupMembers do -- For each raid member
				local unit = "raid" .. i;
				if UnitExists(unit) then
					for x=1, 40 do
						local spell = select(10, UnitAura(unit, x, 'HELPFUL'));
						if spell == spellID then
							buffCount = buffCount + 1;
						end
					end
				end
			end
		elseif numGroupMembers >= 2 and numGroupMembers <= 5 then
			for i = 1, 4 do -- For each party member
				local unit = "party" .. i;
				if UnitExists(unit) then
					for x=1, 40 do
						local spell = select(10, UnitAura(unit, x, 'HELPFUL'));
						if spell == spellID then
							buffCount = buffCount + 1;
						end
					end
				end
			end
			for x=1, 40 do
				local spell = select(10, UnitAura('player', x, 'HELPFUL'));
				if spell == spellID then
					buffCount = buffCount + 1;
				end
			end
		elseif numGroupMembers <= 1 then
			for x=1, 40 do
				local spell = select(10, UnitAura('player', x, 'HELPFUL'));
				if spell == spellID then
					buffCount = buffCount + 1;
				end
			end
		end

--	self:Print(self.Colors.Info .. numGroupMembers);
	return buffCount;
end

function ConRO:EndCast(target)
	target = target or 'player';
	local t = GetTime();
	local c = t * 1000;
	local gcd = 0;
	local _, _, _, _, endTime, _, _, _, spellId = UnitCastingInfo(target or 'player');

	-- we can only check player global cooldown
	if target == 'player' then
		local gstart, gduration = GetSpellCooldown(61304);
		gcd = gduration - (t - gstart);

		if gcd < 0 then
			gcd = 0;
		end;
	end

	if not endTime then
		return gcd, nil, gcd;
	end

	local timeShift = (endTime - c) / 1000;
	if gcd > timeShift then
		timeShift = gcd;
	end

	return timeShift, spellId, gcd;
end

function ConRO:EndChannel(target)
	target = target or 'player';
	local t = GetTime();
	local c = t * 1000;
	local gcd = 0;
	local _, _, _, _, endTime, _, _, spellId = UnitChannelInfo(target or 'player');

	-- we can only check player global cooldown
	if target == 'player' then
		local gstart, gduration = GetSpellCooldown(61304);
		gcd = gduration - (t - gstart);

		if gcd < 0 then
			gcd = 0;
		end;
	end

	if not endTime then
		return gcd, nil, gcd;
	end

	local timeShift = (endTime - c) / 1000;
	if gcd > timeShift then
		timeShift = gcd;
	end

	return timeShift, spellId, gcd;
end

function ConRO:SameSpell(spell1, spell2)
	local spellName1 = GetSpellInfo(spell1);
	local spellName2 = GetSpellInfo(spell2);
	return spellName1 == spellName2;
end

function ConRO:TarYou()
	local targettarget = UnitName('targettarget');
	local targetplayer = UnitName('player');
	if targettarget == targetplayer then
		return 1;
	end
end

function ConRO:TarHostile()
	local isEnemy = UnitReaction("player","target");
	local isDead = UnitIsDead("target");
		if isEnemy ~= nil then
			if isEnemy <= 4 and not isDead then
				return true;
			else
				return false;
			end
		end
	return false;
end

function ConRO:PercentHealth(unit)
	local unit = unit or 'target';
	local health = UnitHealth(unit);
	local healthMax = UnitHealthMax(unit);
	if health <= 0 or healthMax <= 0 then
		return 101;
	end
	return (health/healthMax)*100;
end

ConRO.Spellbook = {};
function ConRO:FindSpellInSpellbook(spellID)
	local spellName = GetSpellInfo(spellID);
	if ConRO.Spellbook[spellName] then
		return ConRO.Spellbook[spellName];
	end

	local _, _, offset, numSpells = GetSpellTabInfo(2);
	local booktype = 'spell';

	for index = offset + 1, numSpells + offset do
		local spellID = select(2, GetSpellBookItemInfo(index, booktype));
		if spellID and spellName == GetSpellBookItemName(index, booktype) then
			ConRO.Spellbook[spellName] = index;
			return index;
		end
	end

	local _, _, offset, numSpells = GetSpellTabInfo(3);
	local booktype = 'spell';

	for index = offset + 1, numSpells + offset do
		local spellID = select(2, GetSpellBookItemInfo(index, booktype));
		if spellID and spellName == GetSpellBookItemName(index, booktype) then
			ConRO.Spellbook[spellName] = index;
			return index;
		end
	end

	return nil;
end

function ConRO:FindCurrentSpell(spellID)
	local spellName = GetSpellInfo(spellID);
	local _, _, offset, numSpells = GetSpellTabInfo(2);
	local booktype = 'spell';
	local hasSpell = false;

	for index = offset + 1, numSpells + offset do
		local spellID = select(2, GetSpellBookItemInfo(index, booktype));
		if spellID and spellName == GetSpellBookItemName(index, booktype) then
			hasSpell = true;
		end
	end

	local _, _, offset, numSpells = GetSpellTabInfo(3);
	local booktype = 'spell';

	for index = offset + 1, numSpells + offset do
		local spellID = select(2, GetSpellBookItemInfo(index, booktype));
		if spellID and spellName == GetSpellBookItemName(index, booktype) then
			hasSpell = true;
		end
	end

	return hasSpell;
end

function ConRO:IsSpellInRange(spellCheck, unit)
	local unit = unit or 'target';
	local range = false;
	local spellid = spellCheck.spellID;
	local talentID = spellCheck.talentID;
	local spell = GetSpellInfo(spellid);
	local have = ConRO:TalentChosen(talentID);
	local known = IsPlayerSpell(spellid);

	if have then
		known = true;
	end

	if known and ConRO:TarHostile() then
		local inRange = IsSpellInRange(spell, unit);
		if inRange == nil then
			local myIndex = nil;
			local name, texture, offset, numSpells, isGuild = GetSpellTabInfo(2);
			local booktype = "spell";
			for index = offset + 1, numSpells + offset do
				local spellID = select(2, GetSpellBookItemInfo(index, booktype));
				if spellID and spell == GetSpellBookItemName(index, booktype) then
					myIndex = index;
					break;
				end
			end

			local numPetSpells = HasPetSpells();
			if myIndex == 0 and numPetSpells then
				booktype = "pet";
				for index = 1, numPetSpells do
					local spellID = select(2, GetSpellBookItemInfo(index, booktype));
					if spellID and spell == GetSpellBookItemName(index, booktype) then
						myIndex = index;
						break;
					end
				end
			end

			if myIndex then
				inRange = IsSpellInRange(myIndex, booktype, unit);
			end

			if inRange == 1 then
				range = true;
			end

			return range;
		end

		if inRange == 1 then
			range = true;
		end
	end
  return range;
end

function ConRO:AbilityReady(spellCheck, timeShift, spelltype)
	local spellid = spellCheck.spellID;
	local entryID = spellCheck.talentID;
	local _CD, _MaxCD = ConRO:Cooldown(spellid, timeShift);
	local have = ConRO:TalentChosen(entryID);

	local known = IsPlayerSpell(spellid);
	local usable, notEnough = IsUsableSpell(spellid);
	local castTimeMilli = select(4, GetSpellInfo(spellid));
	local rdy = false;
		if spelltype == 'pet' then
			have = IsSpellKnown(spellid, true);
		end
		if have then
			known = true;
		end
		if known and usable and _CD <= 0 and not notEnough then
			rdy = true;
		else
			rdy = false;
		end
		if castTimeMilli ~= nil then
			castTime = castTimeMilli/1000;
		end
	return spellid, rdy, _CD, _MaxCD, castTime;
end

function ConRO:ItemReady(_Item_ID, timeShift)
	local _CD, _MaxCD = ConRO:ItemCooldown(_Item_ID, timeShift);
	local _Item_COUNT = GetItemCount(_Item_ID, false, true);
	local _RDY = false;
		if _CD <= 0 and _Item_COUNT >= 1 then
			_RDY = true;
		else
			_RDY = false;
		end
	return _Item_ID, _RDY, _CD, _MaxCD, _Item_COUNT;
end

function ConRO:SpellCharges(spellid)
	local currentCharges, maxCharges, cooldownStart, maxCooldown = GetSpellCharges(spellid);
	local currentCooldown = 10000;
		if currentCharges ~= nil and currentCharges < maxCharges then
			currentCooldown = (maxCooldown - (GetTime() - cooldownStart));
		end
	return currentCharges, maxCharges, currentCooldown, maxCooldown;
end

function ConRO:Raidmob()
	local tlvl = UnitLevel("target");
	local plvl = UnitLevel("player");
	local strong = false;
		if tlvl == -1 or tlvl > plvl then
			strong = true;
		end
	return strong;
end

function ConRO:ExtractTooltipDamage(_Spell_ID)
    _Spell_Description = GetSpellDescription(_Spell_ID);
    _Damage = _Spell_Description:match("%d+([%d%,]+)"); --Need to get correct digits here.
	if _Damage == nil then
		_Damage = _Spell_Description:match("(%d+)");
	end
	local _My_HP = tonumber("1560");
	local _Will_Kill = "false";
	local _Damage_Number = _Damage;

--	if _Damage_Number >= _My_HP then
--		_Will_Kill = "true";
--	end

	print(_Damage_Number .. " - " .. _My_HP .. " -- " .. _Will_Kill);
end

function ConRO:ExtractTooltip(spell, pattern)
	local _pattern = gsub(pattern, "%%s", "([%%d%.,]+)");

	if not TDSpellTooltip then
		CreateFrame('GameTooltip', 'TDSpellTooltip', UIParent, 'GameTooltipTemplate');
		TDSpellTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	end
	TDSpellTooltip:SetSpellByID(spell);

	for i = 2, 4 do
		local line = _G['TDSpellTooltipTextLeft' .. i];
		local text = line:GetText();

		if text then
			local cost = strmatch(text, _pattern);
			if cost then
				cost = cost and tonumber((gsub(cost, "%D", "")));
				return cost;
			end
		end
	end

	return 0;
end

function ConRO:GlobalCooldown()
	local _, duration, enabled = GetSpellCooldown(61304);
		return duration;
end

function ConRO:Cooldown(spellid, timeShift)
	local start, maxCooldown, enabled = GetSpellCooldown(spellid);
	local baseCooldownMS, gcdMS = GetSpellBaseCooldown(spellid);

	if baseCooldownMS ~= nil then
		baseCooldown = (baseCooldownMS/1000) + (timeShift or 0);
	end

	if enabled and maxCooldown == 0 and start == 0 then
		return 0, maxCooldown, baseCooldown;
	elseif enabled then
		return (maxCooldown - (GetTime() - start) - (timeShift or 0)), maxCooldown, baseCooldown;
	else
		return 100000, maxCooldown, baseCooldown;
	end;
end

function ConRO:ItemCooldown(itemid, timeShift)
	local start, maxCooldown, enabled = GetItemCooldown(itemid);
	local baseCooldownMS, gcdMS = GetSpellBaseCooldown(itemid);

	if baseCooldownMS ~= nil then
		baseCooldown = baseCooldownMS/1000;
	end

	if enabled and maxCooldown == 0 and start == 0 then
		return 0, maxCooldown, baseCooldown;
	elseif enabled then
		return (maxCooldown - (GetTime() - start) - (timeShift or 0)), maxCooldown, baseCooldown;
	else
		return 100000, maxCooldown, baseCooldown;
	end;
end

function ConRO:Interrupt()
	if UnitCanAttack ('player', 'target') then
		local tarchan, _, _, _, _, _, cnotInterruptible = UnitChannelInfo("target");
		local tarcast, _, _, _, _, _, _, notInterruptible = UnitCastingInfo("target");

		if tarcast and not notInterruptible then
			return true;
		elseif tarchan and not cnotInterruptible then
			return true;
		else
			return false;
		end
	end
end

function ConRO:BossCast()
	if UnitCanAttack ('player', 'target') then
		local tarchan, _, _, _, _, _, cnotInterruptible = UnitChannelInfo("target");
		local tarcast, _, _, _, _, _, _, notInterruptible = UnitCastingInfo("target");

		if tarcast and notInterruptible then
			return true;
		elseif tarchan and cnotInterruptible then
			return true;
		else
			return false;
		end
	end
end

function ConRO:CallPet()
	local petout = IsPetActive();
	local incombat = UnitAffectingCombat('player');
	local mounted = IsMounted();
	local inVehicle = UnitHasVehicleUI("player");
	local summoned = true;
		if not petout and not mounted and not inVehicle and incombat then
			summoned = false;
		end
	return summoned;
end

function ConRO:PetAssist()
	local incombat = UnitAffectingCombat('player');
	local mounted = IsMounted();
	local inVehicle = UnitHasVehicleUI("player");
	local affectingCombat = IsPetAttackActive();
	local attackstate = true;
	local assist = false;
	local petspell = select(9, UnitCastingInfo("pet"))
		for i = 1, 24 do
			local name, _, _, isActive = GetPetActionInfo(i)
			if name == 'PET_MODE_ASSIST' and isActive then
				assist = true;
			end
		end
		if not (affectingCombat or assist) and incombat and not mounted and not inVehicle then
			attackstate = false;
		end
	return attackstate, petspell;
end

function ConRO:Totem(slot)
	local havetotem, totemName, startTime, duration = GetTotemInfo(slot);
	local est_dur = startTime + duration - GetTime()

	return havetotem, est_dur;
end

function ConRO:FormatTime(left)
	local seconds = left >= 0        and math.floor((left % 60)    / 1   ) or 0;
	local minutes = left >= 60       and math.floor((left % 3600)  / 60  ) or 0;
	local hours   = left >= 3600     and math.floor((left % 86400) / 3600) or 0;
	local days    = left >= 86400    and math.floor((left % 31536000) / 86400) or 0;
	local years   = left >= 31536000 and math.floor( left / 31536000) or 0;

	if years > 0 then
		return string.format("%d [Y] %d [D] %d:%d:%d [H]", years, days, hours, minutes, seconds);
	elseif days > 0 then
		return string.format("%d [D] %d:%d:%d [H]", days, hours, minutes, seconds);
	elseif hours > 0 then
		return string.format("%d:%d:%d [H]", hours, minutes, seconds);
	elseif minutes > 0 then
		return string.format("%d:%d [M]", minutes, seconds);
	else
		return string.format("%d [S]", seconds);
	end
end
