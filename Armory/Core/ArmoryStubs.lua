--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 513 2012-09-09T20:38:34Z
    URL: http://www.wow-neighbours.com

    License:
        This program is free software; you can redistribute it and/or
        modify it under the terms of the GNU General Public License
        as published by the Free Software Foundation; either version 2
        of the License, or (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program(see GPL.txt); if not, write to the Free Software
        Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

    Note:
        This AddOn's source code is specifically designed to work with
        World of Warcraft's interpreted AddOn system.
        You have an implicit licence to use this AddOn with these facilities
        since that is it's designated purpose as per:
        http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]

local Armory, _ = Armory;

function Armory:GetActiveSpecGroup(inspect)
    return self:SetGetCharacterValue("ActiveSpecGroup", _G.GetActiveSpecGroup()) or 1;
end

function Armory:GetAdjustedSkillPoints()
    return self:SetGetCharacterValue("AdjustedSkillPoints", _G.GetAdjustedSkillPoints());
end

function Armory:GetAttackPowerForStat(index, effectiveStat)
    return self:SetGetCharacterValue("AttackPowerForStat"..index, _G.GetAttackPowerForStat(index, effectiveStat));
end

function Armory:GetAverageItemLevel()
    return self:SetGetCharacterValue("AverageItemLevel", _G.GetAverageItemLevel());
end

function Armory:GetBlockChance()
    return self:SetGetCharacterValue("BlockChance", _G.GetBlockChance());
end

 function Armory:GetCombatRating(index)
    if ( index ) then
        return self:SetGetCharacterValue("CombatRating"..index, _G.GetCombatRating(index)) or 0;
    end
end

function Armory:GetCombatRatingBonus(index)
    if ( index ) then
        return self:SetGetCharacterValue("CombatRatingBonus"..index, _G.GetCombatRatingBonus(index)) or 0;
    end
end

function Armory:GetCritChance()
    return self:SetGetCharacterValue("CritChance", _G.GetCritChance());
end

function Armory:GetCritChanceFromAgility(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("CritChanceFromAgility", _G.GetCritChanceFromAgility(unit));
    end
    return self:SetGetCharacterValue("CritChanceFromAgility", _G.GetCritChanceFromAgility(unit));
end

function Armory:GetCurrencyInfo(index)
    --  61 Dalaran Jewelcrafter's Token
    --  81 Dalarn Cooking Award
    -- 241 Champion's Seal
    -- 361 Illustrious Jewelcrafter's Token
    -- 390 Conquest Points
    -- 391 Tol Barad Commendation
    -- 392 Honor Points
    -- 395 Justice Points 
    -- 396 Valor Points
    -- 402 Chef's Award

    if ( _G.GetCurrencyInfo(index) ) then
        local name, quantity, icon, earnedThisWeek, earnablePerWeek, cap, isDiscovered = self:SetGetCharacterValue("CurrencyInfo"..index, _G.GetCurrencyInfo(index));
        
        if ( time() >= self:GetQuestResetTime() ) then
            earnedThisWeek = 0;
        end

        return name, quantity, icon, earnedThisWeek, earnablePerWeek, cap, isDiscovered;
    end
end

function Armory:GetCurrentPet()
    local pets = self:GetPets();
    local pet = self:UnitName("pet") or UNKNOWN;
    if ( not self.selectedPet ) then
        self.selectedPet = pet;
    end
    if ( not self:PetExists(self.selectedPet) ) then
        if ( #pets > 0 ) then
            self.selectedPet = pets[1];
        else
            self.selectedPet = pet;
        end
    end
    return self.selectedPet;
end

function Armory:GetDodgeChance()
    return self:SetGetCharacterValue("DodgeChance", _G.GetDodgeChance());
end

function Armory:GetExpertise()
    return self:SetGetCharacterValue("Expertise", _G.GetExpertise());
end

function Armory:GetGuildInfo(unit)
    return self:SetGetCharacterValue("Guild", _G.GetGuildInfo("player"));
end

function Armory:GetHitModifier()
    return self:SetGetCharacterValue("HitModifier", _G.GetHitModifier());
end

function Armory:GetInventoryAlertStatus(index)
    if ( index ) then
        return self:SetGetCharacterValue("InventoryAlertStatus"..index, _G.GetInventoryAlertStatus(index));
    end
end

function Armory:GetInventoryItemBroken(unit, index)
    if ( index ) then
        return self:SetGetCharacterValue("InventoryItemBroken"..index, _G.GetInventoryItemBroken("player", index));
    end
end

function Armory:GetInventoryItemCount(unit, index)
    if ( index ) then
        return self:SetGetCharacterValue("InventoryItemCount"..index, _G.GetInventoryItemCount("player", index));
    end
end

function Armory:GetInventoryItemLink(unit, index)
    if ( index ) then
        if ( index >= EQUIPPED_FIRST and index <= EQUIPPED_LAST ) then
            return self:GetCharacterValue("InventoryItemLink"..index);
        elseif ( not ArmoryInventoryFrame.bankOpen and self:IsBankBagSlot(index) ) then
            return self:GetCharacterValue("InventoryItemLink"..index);
        else
            return self:SetGetCharacterValue("InventoryItemLink"..index, _G.GetInventoryItemLink(unit, index));
        end
    end
end

function Armory:GetInventoryItemTexture(unit, index)
    if ( index ) then
        if ( not ArmoryInventoryFrame.bankOpen and self:IsBankBagSlot(index) ) then
            return self:GetCharacterValue("InventoryItemTexture"..index);
        else
            return self:SetGetCharacterValue("InventoryItemTexture"..index, _G.GetInventoryItemTexture("player", index));
        end
    end
end

function Armory:GetInventoryItemQuality(unit, index)
    if ( index ) then
        return self:SetGetCharacterValue("InventoryItemQuality"..index, _G.GetInventoryItemQuality("player", index));
    end
end

function Armory:GetLatestThreeSenders()
    return self:SetGetCharacterValue("LatestThreeSenders", _G.GetLatestThreeSenders());
end

function Armory:GetLFGDungeonRewardCapBarInfo(id)
    if ( _G.GetLFGDungeonRewardCapBarInfo and _G.GetLFGDungeonRewardCapBarInfo(id) ) then -- Patch 4.1.0
        local currencyID, dungeonID, quantity, limit, overallQuantity, overallLimit, periodPurseQuantity, periodPurseLimit = self:SetGetCharacterValue("DungeonRewardCap"..id, _G.GetLFGDungeonRewardCapBarInfo(id));

        if ( time() >= self:GetQuestResetTime() ) then
            quantity = 0;
            overallQuantity = 0;
            periodPurseQuantity = 0;
        end

	    return currencyID, dungeonID, quantity, limit, overallQuantity, overallLimit, periodPurseQuantity, periodPurseLimit;
	end
end

function Armory:GetManaRegen()
    return self:SetGetCharacterValue("ManaRegen", _G.GetManaRegen());
end

function Armory:GetMasteryEffect()
    return self:SetGetCharacterValue("MasteryEffect", _G.GetMasteryEffect());
end

function Armory:GetMeleeHaste()
    return self:SetGetCharacterValue("MeleeHaste", _G.GetMeleeHaste());
end

function Armory:GetMoney()
    return self:SetGetCharacterValue("Money", _G.GetMoney()) or 0;
end

function Armory:GetOverrideAPBySpellPower()
    return self:SetGetCharacterValue("OverrideAPBySpellPower", _G.GetOverrideAPBySpellPower());
end

function Armory:GetOverrideSpellPowerByAP()
    return self:SetGetCharacterValue("OverrideSpellPowerByAP", _G.GetOverrideSpellPowerByAP());
end

function Armory:GetParryChance()
    return self:SetGetCharacterValue("ParryChance", _G.GetParryChance());
end

function Armory:GetPetExperience()
    return self:SetGetPetValue("Experience", _G.GetPetExperience());
end

function Armory:GetPetFoodTypes()
    return self:SetGetPetValue("FoodTypes", _G.GetPetFoodTypes());
end

function Armory:GetPetIcon()
    local _, isHunterPet = self:HasPetUI();
    if ( isHunterPet ) then
        return self:SetGetPetValue("Icon", _G.GetPetIcon());
    end

    local _, className = self:UnitClass("player");
    if ( className == "DEATHKNIGHT" ) then
        return "Interface\\Icons\\Spell_Shadow_RaiseDead"; --Spell_Shadow_AnimateDead";
    elseif ( className == "MAGE" ) then
        return "Interface\\Icons\\Spell_Frost_SummonWaterElemental_2"; 
    elseif ( self:UnitCreatureFamily("pet") ) then
        return "Interface\\Icons\\Spell_Shadow_Summon"..self:UnitCreatureFamily("pet");
    else
        return "Interface\\Icons\\INV_Misc_QuestionMark";
    end
end

local pets = {};
local oldPets = {};
function Armory:GetPets(unit)
    table.wipe(pets);
    table.wipe(oldPets);
   
    if ( self:PetsEnabled() ) then 
        local dbEntry = self.selectedDbBaseEntry;
        if ( unit == "player" ) then
            dbEntry = self.playerDbBaseEntry;
        end
        if ( dbEntry and dbEntry:Contains("Pets") ) then
            for pet in pairs(dbEntry:GetValue("Pets")) do
                -- sanity check
                if ( pet == UNKNOWN or not dbEntry:GetValue("Pets", pet, "Family") ) then
                    table.insert(oldPets, pet);
                else
                    table.insert(pets, pet);
                end
            end
            table.sort(pets);

            -- should never happen, but better save than sorry
            for _, pet in ipairs(oldPets) do
                self:DeletePet(pet, unit);
                self:PrintDebug("Pet", pet, "removed");
            end
        end
    end

    return pets;
end

function Armory:GetPetSpellBonusDamage()
    return self:SetGetPetValue("SpellBonusDamage", _G.GetPetSpellBonusDamage());
end

function Armory:GetPortraitTexture(unit)
    local portrait = "Interface\\CharacterFrame\\TemporaryPortrait";

    if ( strlower(unit) == "pet" ) then
        portrait = portrait .. "-Pet";
    else
        local sex = self:UnitSex(unit);
        local _, raceEn = self:UnitRace(unit);
        if ( sex == 2 ) then
            portrait = portrait .. "-Male-" .. raceEn;
        elseif ( sex == 3 ) then
            portrait = portrait .. "-Female-" .. raceEn;
        end
    end

    return portrait;
end

function Armory:GetPowerRegen()
    return self:SetGetCharacterValue("PowerRegen", _G.GetPowerRegen());
end

function Armory:GetPVPLifetimeStats()
    return self:SetGetCharacterValue("PVPLifetimeStats", _G.GetPVPLifetimeStats());
end

function Armory:GetPVPSessionStats()
    local timestamp, hk, cp = self:SetGetCharacterValue("PVPSessionStats", time(), _G.GetPVPSessionStats());

    if ( not (hk and self:IsToday(timestamp)) ) then
        hk = 0;
        cp = 0;
    end

    return hk, cp;
end

function Armory:GetPVPYesterdayStats(update)
    local timestamp, hk, cp;
    if ( update ) then
        timestamp, hk, cp = self:SetGetCharacterValue("PVPYesterdayStats", time(), _G.GetPVPYesterdayStats());
    else
        timestamp, hk, cp = self:GetCharacterValue("PVPYesterdayStats");
    end
    
    if ( not (hk and self:IsToday(timestamp)) ) then
        hk = 0;
        cp = 0;
    end

    return hk, cp;
end

function Armory:GetQuestResetTime()
    return self:SetGetCharacterValue("QuestResetTime", time() + _G.GetQuestResetTime()) or 0;
end

function Armory:GetRangedCritChance()
    return self:SetGetCharacterValue("RangedCritChance", _G.GetRangedCritChance());
end

function Armory:GetRangedHaste()
    return self:SetGetCharacterValue("RangedHaste", _G.GetRangedHaste());
end

function Armory:GetRestState()
    return self:SetGetCharacterValue("RestState", _G.GetRestState());
end

function Armory:GetRuneCooldown(index)
    return self:SetGetCharacterValue("RuneCooldown"..index, _G.GetRuneCooldown(index));
end

function Armory:GetShieldBlock()
    return self:SetGetCharacterValue("ShieldBlock", _G.GetShieldBlock());
end

function Armory:GetSpecialization(inspect, pet, talentGroup)
    local activeTalentGroup = _G.GetActiveSpecGroup() or 1;
    local numTalentGroups = _G.GetNumSpecGroups();
    for i = 1, numTalentGroups do
        if ( pet ) then
            if ( i == activeTalentGroup ) then
                local _, isHunterPet = _G.HasPetUI();
                if ( isHunterPet and self:IsPersistentPet() ) then
                    local name = self:GetPetName();
                    self:SetPetValue(name, "Specialization"..i, _G.GetSpecialization(false, true));
                end
            end
        else            
	        self:SetCharacterValue("Specialization"..i, _G.GetSpecialization(false, false, i));
        end
	end
	
	talentGroup = talentGroup or self:GetActiveSpecGroup();
	if ( not pet ) then
        return self:GetCharacterValue("Specialization"..talentGroup);
    elseif ( self:PetExists(self:GetCurrentPet()) ) then
        return self:GetPetValue(self:GetCurrentPet(), "Specialization"..talentGroup);
    end
end

function Armory:GetSpecializationMasterySpells()
    local primaryTree = _G.GetSpecialization();
    if ( not primaryTree ) then
        return self:SetGetCharacterValue("MaterySpells", nil);
    end
    return self:SetGetCharacterValue("MaterySpells", _G.GetSpecializationMasterySpells(primaryTree));
end

function Armory:GetSpellBonusDamage(holySchool)
    if ( holySchool ) then
        return self:SetGetCharacterValue("SpellBonusDamage"..holySchool, _G.GetSpellBonusDamage(holySchool));
    end
end

function Armory:GetSpellBonusHealing()
    return self:SetGetCharacterValue("SpellBonusHealing", _G.GetSpellBonusHealing());
end

function Armory:GetSpellCritChance(holySchool)
    if ( holySchool ) then
        return self:SetGetCharacterValue("SpellCritChance"..holySchool, _G.GetSpellCritChance(holySchool));
    end
end

function Armory:GetSpellCritChanceFromIntellect(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("SpellCritChanceFromIntellect", _G.GetSpellCritChanceFromIntellect(unit));
    end
    return self:SetGetCharacterValue("SpellCritChanceFromIntellect", _G.GetSpellCritChanceFromIntellect(unit));
end

function Armory:GetSpellHitModifier()
    return self:SetGetCharacterValue("SpellHitModifier", _G.GetSpellHitModifier());
end

function Armory:GetSpellPenetration()
    return self:SetGetCharacterValue("SpellPenetration", _G.GetSpellPenetration());
end

function Armory:GetSubZoneText()
    return self:SetGetCharacterValue("SubZone", _G.GetSubZoneText());
end

function Armory:GetUnitHealthModifier(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("HealthModifier", _G.GetUnitHealthModifier(unit));
    end
    return self:SetGetCharacterValue("HealthModifier", _G.GetUnitHealthModifier(unit));
end

function Armory:GetUnitManaRegenRateFromSpirit(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("ManaRegenRateFromSpirit", _G.GetUnitManaRegenRateFromSpirit(unit));
    end
    return self:SetGetCharacterValue("ManaRegenRateFromSpirit", _G.GetUnitManaRegenRateFromSpirit(unit));
end

function Armory:GetUnitMaxHealthModifier(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("MaxHealthModifier", _G.GetUnitMaxHealthModifier(unit));
    end
    return self:SetGetCharacterValue("MaxHealthModifier", _G.GetUnitMaxHealthModifier(unit));
end

function Armory:GetUnitPowerModifier(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("PowerModifier", _G.GetUnitPowerModifier(unit));
    end
    return self:SetGetCharacterValue("PowerModifier", _G.GetUnitPowerModifier(unit));
end

function Armory:GetUnitSpeed(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("Speed", _G.GetUnitSpeed(unit));
    end
    return self:SetGetCharacterValue("Speed", _G.GetUnitSpeed(unit));
end

function Armory:GetXPExhaustion()
    return self:SetGetCharacterValue("XPExhaustion", _G.GetXPExhaustion(), time());
end

function Armory:GetZoneText()
    return self:SetGetCharacterValue("Zone", _G.GetZoneText());
end

function Armory:HasNewMail()
    return self:SetGetCharacterValue("HasMail", _G.HasNewMail());
end

function Armory:HasPetUI()
    if ( self:PetsEnabled() ) then
        local pets = self:GetPets();
        if ( #pets == 0 and self.character == self.player ) then
            return _G.HasPetUI();
        end
        local _, unitClass = self:UnitClass("player");
        return #pets > 0, strupper(unitClass) == "HUNTER";
    end
end

function Armory:HasWandEquipped()
    return self:SetGetCharacterValue("HasWandEquipped", _G.HasWandEquipped());
end

function Armory:IsBankBagSlot(index)
    if ( index ) then
        return index >= _G.ContainerIDToInventoryID(NUM_BAG_SLOTS + 1) and index <= _G.ContainerIDToInventoryID(NUM_BAG_SLOTS + NUM_BANKBAGSLOTS);
    end
end

function Armory:IsFalling(unit)
    if ( self:IsPlayerSelected() ) then
        return _G.IsFalling(unit);
    end
    return false;
end

function Armory:IsFlying(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("IsFlying", _G.IsFlying(unit));
    end
    return self:SetGetCharacterValue("IsFlying", _G.IsFlying(unit));
end

function Armory:InRepairMode()
   return self:SetGetCharacterValue("InRepairMode", _G.InRepairMode());
end

function Armory:IsDualWielding()
   return self:SetGetCharacterValue("IsDualWielding", _G.IsDualWielding());
end

function Armory:IsMetaActive(unit)
    return self:GetCharacterValue("IsMetaActive", unit);
end

function Armory:IsPersistentPet()
    if ( (_G.UnitName("pet") or UNKNOWN) ~= UNKNOWN and _G.UnitCreatureFamily("pet") ) then
        return true;
    end
end

function Armory:IsRangedWeapon()
    return self:SetGetCharacterValue("IsRangedWeapon", _G.IsRangedWeapon());
end

function Armory:IsResting()
   return self:SetGetCharacterValue("IsResting", _G.IsResting());
end

function Armory:IsSwimming(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("IsSwimming", _G.IsSwimming(unit));
    end
    return self:SetGetCharacterValue("IsSwimming", _G.IsSwimming(unit));
end

function Armory:IsXPUserDisabled()
   return self:SetGetCharacterValue("IsXPUserDisabled", _G.IsXPUserDisabled());
end

function Armory:PetExists(pet, unit)
    local dbEntry = self.selectedDbBaseEntry;

    if ( unit == "player" ) then
        dbEntry = self.playerDbBaseEntry;
    end
    
    return dbEntry and dbEntry:Contains("Pets", pet);
end

----------------------------------------------------------

function Armory:SetBagItem(id, index)
    local link, tinker, anchor = self:GetContainerItemLink(id, index);
    if ( link ) then
        self:SetHyperlink(GameTooltip, link, tinker, anchor);

        if ( id == ARMORY_MAIL_CONTAINER ) then
            local daysLeft = self:GetContainerItemExpiration(ARMORY_MAIL_CONTAINER, index);
            --local daysLeft = Armory:GetContainerInboxItemDaysLeft(id, index);
            if ( daysLeft ) then
                if ( daysLeft >= 1 ) then
                    daysLeft = LIGHTYELLOW_FONT_COLOR_CODE.."  "..format(DAYS_ABBR, floor(daysLeft)).." "..FONT_COLOR_CODE_CLOSE;
                else
                    daysLeft = RED_FONT_COLOR_CODE.."  "..SecondsToTime(floor(daysLeft * 24 * 60 * 60))..FONT_COLOR_CODE_CLOSE;
                end
                GameTooltip:AppendText(daysLeft);
                GameTooltip:Show();
            end

        elseif ( id == ARMORY_AUCTIONS_CONTAINER or id == ARMORY_NEUTRAL_AUCTIONS_CONTAINER ) then
            local timeLeft, _, remaining = self:GetContainerItemExpiration(id, index);
            if ( timeLeft ) then
                local timeLeftScanned = SecondsToTime(remaining, true);
                if ( timeLeftScanned ~= "" ) then
                    timeLeftScanned = " "..string.format(GUILD_BANK_LOG_TIME, timeLeftScanned);
                end
 
            --local timeLeft, timestamp = self:GetInventoryContainerValue(id, "TimeLeft"..index);
            --if ( timeLeft ) then
                --local timeLeftScanned = SecondsToTime(time() - timestamp, true);
                --if ( timeLeftScanned ~= "" ) then
                    --timeLeftScanned = " "..string.format(GUILD_BANK_LOG_TIME, timeLeftScanned);
                --end

                local tooltipLines = self:Tooltip2Table(GameTooltip);
                local remaining = "?";
                if ( _G["AUCTION_TIME_LEFT"..timeLeft] ) then
                    remaining = _G["AUCTION_TIME_LEFT"..timeLeft];
                end
                table.insert(tooltipLines, 2, self:Text2String(remaining..timeLeftScanned, 1.0, 1.0, 0.6));
                self:Table2Tooltip(GameTooltip, tooltipLines);
                GameTooltip:Show();
            end
        
        elseif ( not self:IsDummyContainer(id) ) then
            self:AddEquipmentSet(GameTooltip);
        
        end
    end
end

function Armory:SetInventoryItem(unit, index, dontShow, tooltip, link)
    if ( index ) then
        local hasItem, hasCooldown, repairCost, tinker, anchor;
        if ( link ) then
            hasItem = true;
        else
            hasItem, hasCooldown, repairCost = self:GetInventoryItem(index);
            link, tinker, anchor = self:GetInventoryItemLink("player", index);
        end
        if ( link and hasItem and not dontShow ) then
            if ( not tooltip ) then
                self:SetHyperlink(GameTooltip, link, tinker, anchor);
                self:AddEquipmentSet(GameTooltip);
            else
                self:SetHyperlink(tooltip, link, tinker, anchor);
                if ( PawnUpdateTooltip ) then
                     PawnUpdateTooltip(tooltip:GetName(), "SetHyperlink", link);
                     if ( PawnAttachIconToTooltip ) then
                        PawnAttachIconToTooltip(tooltip, true, link);
                     end
                end

                local tooltipLines = self:Tooltip2Table(tooltip, true);
                local realm, character = self:GetPaperDollLastViewed();
                table.insert(tooltipLines, 1, self:Text2String(character.." "..realm, 0.5, 0.5, 0.5));
                self:Table2Tooltip(tooltip, tooltipLines, 4);
                tooltip:Show();
            end
        end
        return hasItem, hasCooldown, repairCost;
    end
end

function Armory:GetInventoryItem(index)
    if ( index ) then
        return self:GetCharacterValue("InventoryItem"..index);
    end
end

function Armory:SetInventoryItemInfo(index)
    local link = _G.GetInventoryItemLink("player", index);
    local hasItem, hasCooldown, repairCost;
    local tinker, anchor;
    local emptySockets, activeMeta;
    local invalid;
    
    if ( link ) then
        local tooltip1 = self:AllocateTooltip();
        hasItem, hasCooldown, repairCost = tooltip1:SetInventoryItem("player", index);
        if ( not self:IsValidTooltip(tooltip1) ) then
            invalid = true;
        elseif ( index ~= ARMORY_SLOTID.ShirtSlot and index ~= ARMORY_SLOTID.TabardSlot ) then
            local tooltip2 = self:AllocateTooltip();
            tooltip2:SetHyperlink(link);
            if ( self:IsValidTooltip(tooltip2) ) then
                tinker, anchor = self:GetTinkerFromTooltip(tooltip1, tooltip2);
                emptySockets, activeMeta = self:GetInventoryItemSocketInfo(tooltip1);
            else
                invalid = true;
            end
            self:ReleaseTooltip(tooltip2);
        end
        self:ReleaseTooltip(tooltip1);
    end
    
    if ( not invalid ) then
        self:SetCharacterValue("InventoryItem"..index, hasItem, hasCooldown, repairCost);
        self:SetCharacterValue("InventoryItemLink"..index, link, tinker, anchor, emptySockets);
        
        if ( index == ARMORY_SLOTID.HeadSlot ) then
            self:SetCharacterValue("IsMetaActive", activeMeta);
        end
        -- not really needed but may be useful for others
        self:SetCharacterValue("InventoryItemGems"..index, self:GetItemGemString(link));
    else
        self:PrintDebug("No data for", ARMORY_SLOT[index], "slot; skipping update")
    end
end

function Armory:GetInventoryItemInfo(index, unit)
    local hasItem, hasCooldown, repairCost = self:GetCharacterValue("InventoryItem"..index, unit);
    local link, tinker, anchor, emptySockets = self:GetCharacterValue("InventoryItemLink"..index, unit);
    return hasItem, hasCooldown, repairCost, link, tinker, anchor, emptySockets;
end

function Armory:SetItemLink(button, link)
    -- stub to enable hooks
    button.link = link;
end

function Armory:SetPortraitTexture(frame, unit)
    frame:SetTexture(self:GetPortraitTexture(unit));
    return "Portrait1";
end

function Armory:SetGlyph(id, talentGroup)
    local link = self:GetGlyphLink(id, talentGroup);
    if ( (link or "") ~= "" ) then
        self:SetHyperlink(GameTooltip, link);
    end
end

function Armory:SetQuestLogItem(itemType, id)
    local link = self:GetQuestLogItemLink(itemType, id);
    if ( link ) then
        self:SetHyperlink(GameTooltip, link);
    end
end

function Armory:SetQuestLogRewardSpell()
    local link = self:GetQuestLogSpellLink();
    if ( link ) then
        self:SetHyperlink(GameTooltip, link);
    end
end

function Armory:SetQuestLogCurrency(itemType, id)
    -- TODO
end

function Armory:SetSpell(id, bookType, specialization)
    local link = self:GetSpellLink(id, bookType, specialization);
    if ( link ) then
        self:SetHyperlink(GameTooltip, link);
    end
end

function Armory:SetTalent(index, inspect, talentGroup)
    local link = self:GetTalentLink(index, inspect, talentGroup);
    if ( link ) then
        self:SetHyperlink(GameTooltip, link);
    end
end

function Armory:SetTradeSkillItem(index, reagent)
    if ( index ) then
        local link;
        if ( reagent ) then
            link = self:GetTradeSkillReagentItemLink(index, reagent);
        else
            link = self:GetTradeSkillItemLink(index);
        end
        if ( link ) then
            self:SetHyperlink(GameTooltip, link);
        end
    end
end

function Armory:SetUnitAura(unit, index, filter)
    local tooltipLines = self:GetBuffTooltip(unit, index, filter);
    if ( tooltipLines ) then
        self:Table2Tooltip(GameTooltip, tooltipLines, 1);
    else
        local name = self:UnitAura(unit, index, filter);
        GameTooltip:SetText(name);
    end
    GameTooltip:Show();
end

----------------------------------------------------------

function Armory:UnitArmor(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("Armor", _G.UnitArmor(unit));
    end
    return self:SetGetCharacterValue("Armor", _G.UnitArmor(unit));
end

function Armory:UnitAttackPower(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("AttackPower", _G.UnitAttackPower(unit));
    end
    return self:SetGetCharacterValue("AttackPower", _G.UnitAttackPower(unit));
end

function Armory:UnitAttackSpeed(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("AttackSpeed", _G.UnitAttackSpeed(unit));
    end
    return self:SetGetCharacterValue("AttackSpeed", _G.UnitAttackSpeed(unit));
end

function Armory:UnitAura(unit, index, filter)
    return self:GetBuff(unit, index, filter);
end

function Armory:UnitCharacterPoints(unit)
    return self:SetGetCharacterValue("CharacterPoints", _G.UnitCharacterPoints("player"));
end

function Armory:UnitClass(unit)
    return self:SetGetCharacterValue("Class", _G.UnitClass("player"));
end

function Armory:UnitCreatureFamily(unit)
    return self:SetGetPetValue("Family", _G.UnitCreatureFamily("pet"));
end

function Armory:UnitDamage(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("Damage", _G.UnitDamage(unit));
    end
    return self:SetGetCharacterValue("Damage", _G.UnitDamage(unit));
end

function Armory:UnitFactionGroup(unit)
    return self:SetGetCharacterValue("FactionGroup", _G.UnitFactionGroup("player"));
end

function Armory:UnitHasMana(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("HasMana", _G.UnitHasMana(unit));
    end
    return self:SetGetCharacterValue("HasMana", _G.UnitHasMana(unit));
end

function Armory:UnitHasRelicSlot(unit)
    return self:SetGetCharacterValue("HasRelicSlot", _G.UnitHasRelicSlot("player"));
end

function Armory:UnitHasResSickness(unit)
    local hasResSickness = false;
    local texture;
    local index = 1;

    unit = "player";

    if ( _G.UnitDebuff(unit, index) ) then
        while ( _G.UnitDebuff(unit, index) ) do
            texture = _G.UnitDebuff(unit, index);
            if ( texture == "Interface\\Icons\\Spell_Shadow_DeathScream" ) then
                hasResSickness = true;
                break;
            end
            index = index + 1;
        end
    end

    return self:SetGetCharacterValue("HasResSickness", hasResSickness);
end

function Armory:UnitHealthMax(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("HealthMax", _G.UnitHealthMax(unit));
    end
    return self:SetGetCharacterValue("HealthMax", _G.UnitHealthMax(unit));
end

function Armory:UnitHPPerStamina(unit)
    return self:SetGetCharacterValue("HPPerStamina", _G.UnitHPPerStamina("player"));
end

function Armory:UnitIsDeadOrGhost(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("IsDead", _G.UnitIsDeadOrGhost(unit));
    end
    return self:SetGetCharacterValue("IsDead", _G.UnitIsDeadOrGhost(unit));
end

function Armory:UnitLevel(unit)
    --if ( strlower(unit) == "pet" ) then
        --return self:SetGetPetValue("Level", _G.UnitLevel(unit));
    --end
    --return self:SetGetCharacterValue("Level", _G.UnitLevel(unit));
    return self:SetGetCharacterValue("Level", _G.UnitLevel("player"));
end

function Armory:UnitName(unit)
    if ( strlower(unit) == "pet" ) then
        if ( self:GetPetName() ) then
            self:SetCharacterValue("Pet", self:GetPetName());
        else
            self:SetCharacterValue("Pet", nil);
        end
        return self:GetCharacterValue("Pet");
    end
    return self.character; --:SetGetCharacterValue("Name", _G.UnitName(unit));
end

function Armory:UnitPowerMax(unit)
    if ( strlower(unit) == "pet" ) then
        return self:SetGetPetValue("PowerMax", _G.UnitPowerMax(unit));
    end
    return self:SetGetCharacterValue("PowerMax", _G.UnitPowerMax(unit));
end

function Armory:UnitPowerType(unit)
    return self:SetGetCharacterValue("PowerType", _G.UnitPowerType("player"));
end

function Armory:UnitPVPName(unit)
    return self:SetGetCharacterValue("PVPName", _G.UnitPVPName("player"));
end

function Armory:UnitRace(unit)
    return self:SetGetCharacterValue("Race", _G.UnitRace("player"));
end

function Armory:UnitRangedAttack(unit)
    return self:SetGetCharacterValue("RangedAttack", _G.UnitRangedAttack("player"));
end

function Armory:UnitRangedAttackPower(unit)
    return self:SetGetCharacterValue("RangedAttackPower", _G.UnitRangedAttackPower("player"));
end

function Armory:UnitRangedDamage(unit)
    return self:SetGetCharacterValue("RangedDamage", _G.UnitRangedDamage("player"));
end

function Armory:UnitSex(unit)
    return self:SetGetCharacterValue("Sex", _G.UnitSex("player"));
end

function Armory:UnitSpellHaste(unit)
    return self:SetGetCharacterValue("SpellHaste", _G.UnitSpellHaste("player"));
end

function Armory:UnitStat(unit, index)
    if ( index ) then
        if ( strlower(unit) == "pet" ) then
            return self:SetGetPetValue("Stat"..index, _G.UnitStat(unit, index));
        end
        return self:SetGetCharacterValue("Stat"..index, _G.UnitStat(unit, index));
    end
end

function Armory:UnitXP(unit)
    return self:SetGetCharacterValue("XP", _G.UnitXP("player"));
end

function Armory:UnitXPMax(unit)
    return self:SetGetCharacterValue("XPMax", _G.UnitXPMax("player"));
end

----------------------------------------------------------
-- Miscellaneous stubs
----------------------------------------------------------

function Armory:ComputePetBonus(stat, value)
    local _, unitClass = Armory:UnitClass("player");
    unitClass = strupper(unitClass);
    if( unitClass == "WARLOCK" ) then
        if( WARLOCK_PET_BONUS[stat] ) then
            return value * WARLOCK_PET_BONUS[stat];
        else
            return 0;
        end
    elseif( unitClass == "HUNTER" ) then
        if( HUNTER_PET_BONUS[stat] ) then
            return value * HUNTER_PET_BONUS[stat];
        else
            return 0;
        end
    end

    return 0;
end

function Armory:GetGuildLogoInfo(unit)
    return self:SetGetCharacterValue("GuildLogo", _G.GetGuildLogoInfo("player"));
end

function Armory:SetLargeGuildTabardTextures(unit, emblemTexture, backgroundTexture, borderTexture, tabardData)
    -- texure dimensions are 1024x1024, icon dimensions are 64x64
    local emblemSize, columns, offset;
    if ( emblemTexture ) then
        emblemSize = 64 / 1024;
        columns = 16
        offset = 0;
        emblemTexture:SetTexture("Interface\\GuildFrame\\GuildEmblemsLG_01");
    end
    self:SetGuildTabardTextures(emblemSize, columns, offset, unit, emblemTexture, backgroundTexture, borderTexture, tabardData);
end

function Armory:SetGuildTabardTextures(emblemSize, columns, offset, unit, emblemTexture, backgroundTexture, borderTexture, tabardData)
    local bkgR, bkgG, bkgB, borderR, borderG, borderB, emblemR, emblemG, emblemB, emblemFilename;
    if ( tabardData ) then
        bkgR = tabardData[1];
        bkgG = tabardData[2];
        bkgB = tabardData[3];
        borderR = tabardData[4];
        borderG = tabardData[5];
        borderB = tabardData[6];
        emblemR = tabardData[7];
        emblemG = tabardData[8];
        emblemB = tabardData[9];
        emblemFilename = tabardData[10];
    else
        bkgR, bkgG, bkgB, borderR, borderG, borderB, emblemR, emblemG, emblemB, emblemFilename = self:GetGuildLogoInfo(unit);
    end
    if ( emblemFilename ) then
        if ( backgroundTexture ) then
            backgroundTexture:SetVertexColor(bkgR / 255, bkgG / 255, bkgB / 255);
        end
        if ( borderTexture ) then
            borderTexture:SetVertexColor(borderR / 255, borderG / 255, borderB / 255);
        end
        if ( emblemSize ) then
            local index = emblemFilename:match("([%d]+)");
            if ( index) then
                index = tonumber(index);
                xCoord = mod(index, columns) * emblemSize;
                yCoord = floor(index / columns) * emblemSize;
                emblemTexture:SetTexCoord(xCoord + offset, xCoord + emblemSize - offset, yCoord + offset, yCoord + emblemSize - offset);
            end
            emblemTexture:SetVertexColor(emblemR / 255, emblemG / 255, emblemB / 255);
        elseif ( emblemTexture ) then
            emblemTexture:SetTexture(emblemFilename);
            emblemTexture:SetVertexColor(emblemR / 255, emblemG / 255, emblemB / 255);
        end
    else
        -- tabard lacks design
        if ( backgroundTexture ) then
            backgroundTexture:SetVertexColor(0.2245, 0.2088, 0.1794);
        end
        if ( borderTexture ) then
            borderTexture:SetVertexColor(0.2, 0.2, 0.2);
        end
        if ( emblemTexture ) then
            if ( emblemSize ) then
                if ( emblemSize == 18 / 256 ) then
                    emblemTexture:SetTexture("Interface\\GuildFrame\\GuildLogo-NoLogoSm");
                else
                    emblemTexture:SetTexture("Interface\\GuildFrame\\GuildLogo-NoLogo");
                end
                emblemTexture:SetTexCoord(0, 1, 0, 1);
                emblemTexture:SetVertexColor(1, 1, 1, 1);
            else
                emblemTexture:SetTexture("");
            end
        end
    end
end