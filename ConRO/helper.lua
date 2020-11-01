ConRO.RaidBuffs = {};

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
	for talentRow = 1, 7 do
		for talentCol = 1, 3 do
			local _, name, _, sel, _, id = GetTalentInfo(talentRow, talentCol, 1);
			if sel then
				self.PlayerTalents[id] = name;
			end
		end
	end
end

function ConRO:CheckPvPTalents()
	self.PvPTalents = {};
	local talents = C_SpecializationInfo.GetAllSelectedPvpTalentIDs();
	for k,v in ipairs(talents) do
		local _, name, _, _, _, id = GetPvpTalentInfoByID(v or 0);
		self.PvPTalents[id] = name;
--		self:Print(self.Colors.Info .. k .. v .. ' ' .. id .. ' ' .. name);
	end	
end

function ConRO:TalentChosen(talent)
	return self.PlayerTalents[talent];
end

function ConRO:PvPTalentChosen(talent)
	return self.PvPTalents[talent];
end

function ConRO:AzPowerChosen(spellid)
	local count = 0;
	local have = false;
	for _, itemLocation in AzeriteUtil.EnumerateEquipedAzeriteEmpoweredItems() do
		local tierInfo = C_AzeriteEmpoweredItem.GetAllTierInfo(itemLocation);
		for i = 1, #tierInfo do
			for x = 1, #tierInfo[i].azeritePowerIDs do
				local powerId = tierInfo[i].azeritePowerIDs[x];
				if C_AzeriteEmpoweredItem.IsPowerSelected(itemLocation, powerId) then
					local Id = C_AzeriteEmpoweredItem.GetPowerInfo(powerId).spellID;
					if Id == spellid then
						count = count + 1;
						have = true;
					end
				end
			end
		end
	end
    return have, count;
end

function ConRO:AzEssenceChosen()
	local have = "false";
	local canHave = "false";
	local milestones = C_AzeriteEssence.GetMilestones();

	for i = 1, #milestones do
		if milestones[i].ID then
			local essenceID = C_AzeriteEssence.GetMilestoneEssence(milestones[i].ID);
			local spellID = C_AzeriteEssence.GetMilestoneSpell(milestones[i].ID);
			
			if milestones[i].slot then
				slot = milestones[i].slot;
			else 
				slot = "nil";
			end
			
			if spellID then
				sID = spellID;
			else
				sID = "nil";
			end
			
			print("ID = " .. milestones[i].ID .. ", Req LVL = " .. milestones[i].requiredLevel .. ", Slot = " .. slot  .. ", Spell ID = " .. sID);
			
			if essenceID then
				local info = C_AzeriteEssence.GetEssenceInfo(essenceID);
				print("Essence ID = " .. info.ID .. ", Name = " .. info.name .. ", Rank = " .. info.rank);
			end
		else
			print("Nope");
		end
	end
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

function ConRO:Targets(spellID)
	local inRange = 0
	for i = 1, 40 do
		if UnitExists('nameplate' .. i) and ConRO:IsSpellInRange(GetSpellInfo(spellID), 'nameplate' .. i) then
			inRange = inRange + 1
		end
	end
--	print(inRange)
	return inRange;
end

function ConRO:UnitAura(spellID, timeShift, unit, filter)
	timeShift = timeShift or 0;
	for i=1,40 do
		local _, _, count, _, _, expirationTime, _, _, _, spell = UnitAura(unit, i, filter);
		if spell == spellID then
			if expirationTime ~= nil and (expirationTime - GetTime()) > timeShift then
				local dur = expirationTime - GetTime() - (timeShift or 0);
				return true, count, dur;
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
	if numGroupMembers >= 5 then
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
			for i = 1, numGroupMembers do -- For each raid member
				local unit = "raid" .. i;
				if UnitExists(unit) then
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
				end
			end
		elseif numGroupMembers >= 1 then
			for i = 1, 4 do -- For each party member
				local unit = "party" .. i;
				if UnitExists(unit) then
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
				end
			end
		end
		if UnitExists('player') then
			for x=1, 40 do
				local spell = select(10, UnitAura('player', x, 'HELPFUL')); 
				if spell == spellID then
					selfhasBuff = true;
					break;
				end
			end
		end
		if numGroupMembers == 0 then
			haveBuff = true;
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
		elseif numGroupMembers >= 1 and numGroupMembers <= 5 then
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
		if UnitExists('player') then
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

function ConRO:IsSpellInRange(spell, unit)
	local unit = unit or 'target';
	local range = false;

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
	
    return range;
end

function ConRO:AbilityReady(spellid, timeShift, pet)
	local cd, maxCooldown = ConRO:Cooldown(spellid, timeShift);
	local have = ConRO:TalentChosen(spellid);
	local known = IsPlayerSpell(spellid);
	local usable, notEnough = IsUsableSpell(spellid);
	local inRange = ConRO:IsSpellInRange(GetSpellInfo(spellid), "target")
	local castTimeMilli = select(4, GetSpellInfo(spellid));
	local rdy = false;
		if pet == 'pet' then
			have = IsSpellKnown(spellid, true);
		end
		if have then
			known = true;
		end
		if known and usable and cd <= 0 and not notEnough then
			rdy = true;
		else
			rdy = false;
		end
		if castTimeMilli ~= nil then
			castTime = castTimeMilli/1000;
		end
	return rdy, cd, maxCooldown, castTime, inRange;
end

function ConRO:ItemReady(itemid, timeShift)
	local cd, maxCooldown = ConRO:ItemCooldown(itemid, timeShift);
	local equipped = IsEquippedItem(itemid);
	local rdy = false;
		if equipped and cd <= 0 then
			rdy = true;
		else
			rdy = false;
		end
	return rdy, cd, maxCooldown;
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
	local tlvl = UnitLevel("target")
	local plvl = UnitLevel("player")
	local strong = false
		if tlvl == -1 or tlvl > plvl then
			strong = true;
		end	
	return strong
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
	if enabled and maxCooldown == 0 and start == 0 then
		return 0, maxCooldown;
	elseif enabled then
		return (maxCooldown - (GetTime() - start) - (timeShift or 0)), maxCooldown;
	else
		return 100000, maxCooldown;
	end;
end

function ConRO:ItemCooldown(itemid, timeShift)
	local start, maxCooldown, enabled = GetItemCooldown(itemid);
	if enabled and maxCooldown == 0 and start == 0 then
		return 0, maxCooldown;
	elseif enabled then
		return (maxCooldown - (GetTime() - start) - (timeShift or 0)), maxCooldown;
	else
		return 100000, maxCooldown;
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