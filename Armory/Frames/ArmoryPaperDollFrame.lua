--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 521 2012-09-16T10:38:05Z
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
local gearSetItems = {};

ARMORY_SLOTINFO = {
    INVTYPE_2HWEAPON = "MainHandSlot", 
    INVTYPE_BODY = "ShirtSlot",
    INVTYPE_CHEST = "ChestSlot",
    INVTYPE_CLOAK = "BackSlot",
    INVTYPE_CROSSBOW = "MainHandSlot",
    INVTYPE_FEET = "FeetSlot",
    INVTYPE_FINGER = "Finger0Slot",
    INVTYPE_FINGER_OTHER = "Finger1Slot",
    INVTYPE_GUN = "MainHandSlot",
    INVTYPE_HAND = "HandsSlot",
    INVTYPE_HEAD = "HeadSlot",
    INVTYPE_HOLDABLE = "SecondaryHandSlot",
    INVTYPE_LEGS = "LegsSlot",
    INVTYPE_NECK = "NeckSlot",
    INVTYPE_RANGED = "MainHandSlot",
    INVTYPE_RANGEDRIGHT = "MainHandSlot",
    --INVTYPE_RELIC = "RangedSlot",
    INVTYPE_ROBE = "ChestSlot",
    INVTYPE_SHIELD = "SecondaryHandSlot",
    INVTYPE_SHOULDER = "ShoulderSlot",
    INVTYPE_TABARD = "TabardSlot",
    INVTYPE_THROWN = "MainHandSlot",
    INVTYPE_TRINKET = "Trinket0Slot",
    INVTYPE_TRINKET_OTHER = "Trinket1Slot",
    INVTYPE_WAIST = "WaistSlot",
    INVTYPE_WEAPON = "MainHandSlot",
    INVTYPE_WEAPON_OTHER = "SecondaryHandSlot",
    INVTYPE_WEAPONMAINHAND = "MainHandSlot",
    INVTYPE_WEAPONOFFHAND = "SecondaryHandSlot",
    INVTYPE_WRIST = "WristSlot",
    INVTYPE_WAND = "MainHandSlot",
};

ARMORY_SLOTID = {
    HeadSlot = 1,
    NeckSlot = 2,
    ShoulderSlot = 3,
    ShirtSlot = 4,
    ChestSlot = 5,
    WaistSlot = 6,
    LegsSlot = 7,
    FeetSlot = 8,
    WristSlot = 9,
    HandsSlot = 10,
    Finger0Slot = 11,
    Finger1Slot = 12,
    Trinket0Slot = 13,
    Trinket1Slot = 14,
    BackSlot = 15,
    MainHandSlot = 16,
    SecondaryHandSlot = 17,
    TabardSlot = 19
};

ARMORY_SLOT = {
    HEADSLOT, -- 1
    NECKSLOT, -- 2
    SHOULDERSLOT, -- 3
    SHIRTSLOT, -- 4
    CHESTSLOT, -- 5
    WAISTSLOT, -- 6
    LEGSSLOT, -- 7
    FEETSLOT, -- 8
    WRISTSLOT, -- 9
    HANDSSLOT, -- 10
    FINGER0SLOT, -- 11
    FINGER1SLOT, -- 12
    TRINKET0SLOT, -- 13
    TRINKET1SLOT, -- 14
    BACKSLOT, -- 15
    MAINHANDSLOT, -- 16
    SECONDARYHANDSLOT, -- 17
    RANGEDSLOT or "", -- 18
    TABARDSLOT  -- 19
};

ARMORY_ANCHOR_SLOTINFO = {
    RIGHT = {point="TOPLEFT",    relativeTo="TOPRIGHT",   xFactor= 1, yFactor=-1, x= 0, y=6},
    LEFT  = {point="TOPRIGHT",   relativeTo="TOPLEFT",    xFactor=-1, yFactor=-1, x= 0, y=6},
    DOWN  = {point="TOPLEFT",    relativeTo="BOTTOMLEFT", xFactor= 1, yFactor=-1, x=-6, y=0},
    UP    = {point="BOTTOMLEFT", relativeTo="TOPLEFT",    xFactor= 1, yFactor= 1, x=-6, y=0}
};

ARMORY_PAPERDOLL_STATINFO = {

    -- General
    ["HEALTH"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetHealth(statFrame, unit); end
    },
    ["POWER"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetPower(statFrame, unit); end
    },
    ["ALTERNATEMANA"] = {
        -- Only appears for Druids when in shapeshift form
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetAlternateMana(statFrame, unit); end
    },
    ["MASTERY"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetMastery(statFrame, unit); end
    },
    ["ITEMLEVEL"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetItemLevel(statFrame, unit); end
    },
    ["MOVESPEED"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetMovementSpeed(statFrame, unit); end
    },
	    
    -- Base stats
    ["STRENGTH"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetStat(statFrame, unit, 1); end 
    },
    ["AGILITY"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetStat(statFrame, unit, 2); end 
    },
    ["STAMINA"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetStat(statFrame, unit, 3); end 
    },
    ["INTELLECT"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetStat(statFrame, unit, 4); end 
    },
    ["SPIRIT"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetStat(statFrame, unit, 5); end 
    },
    
    -- Melee
    ["MELEE_DAMAGE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetDamage(statFrame, unit); end
    },
    ["MELEE_DPS"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetMeleeDPS(statFrame, unit); end
    },
    ["MELEE_AP"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetAttackPower(statFrame, unit); end
    },
    ["MELEE_ATTACKSPEED"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetAttackSpeed(statFrame, unit); end
    },
    ["HASTE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetMeleeHaste(statFrame, unit); end
    },
    ["HITCHANCE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetMeleeHitChance(statFrame, unit); end
    }, 
    ["CRITCHANCE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetMeleeCritChance(statFrame, unit); end
    },
    ["EXPERTISE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetExpertise(statFrame, unit); end
    }, 
    ["ENERGY_REGEN"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetEnergyRegen(statFrame, unit); end
    },
    ["RUNE_REGEN"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetRuneRegen(statFrame, unit); end
    },
    
    -- Ranged
    ["RANGED_DAMAGE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetRangedDamage(statFrame, unit); end
    },
    ["RANGED_DPS"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetRangedDPS(statFrame, unit); end
    },
    ["RANGED_AP"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetRangedAttackPower(statFrame, unit); end
    },
    ["RANGED_ATTACKSPEED"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetRangedAttackSpeed(statFrame, unit); end
    },
    ["RANGED_CRITCHANCE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetRangedCritChance(statFrame, unit); end
    },
    ["RANGED_HITCHANCE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetRangedHitChance(statFrame, unit); end
    }, 
    ["RANGED_HASTE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetRangedHaste(statFrame, unit); end
    },
    ["FOCUS_REGEN"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetFocusRegen(statFrame, unit); end
    },
    
    -- Spell
    ["SPELLDAMAGE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetSpellBonusDamage(statFrame, unit); end
    },
    ["SPELLHEALING"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetSpellBonusHealing(statFrame, unit); end
    },
    ["SPELL_HASTE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetSpellHaste(statFrame, unit); end
    },
    ["SPELL_HITCHANCE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetSpellHitChance(statFrame, unit); end
    },
    ["MANAREGEN"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetManaRegen(statFrame, unit); end
    },
    ["COMBATMANAREGEN"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetCombatManaRegen(statFrame, unit); end
    },
    ["SPELLCRIT"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetSpellCritChance(statFrame, unit); end
    },
    
    -- Defense
    ["ARMOR"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetArmor(statFrame, unit); end
    },
    ["DODGE"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetDodge(statFrame, unit); end
    },
    ["PARRY"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetParry(statFrame, unit); end
    },
    ["BLOCK"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetBlock(statFrame, unit); end
    },
    ["RESILIENCE_REDUCTION"] = {
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetResilience(statFrame, unit); end
    },
	["PVP_POWER"] = {
		updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetPvpPower(statFrame, unit); end
	},
    ["RESILIENCE_CRIT"] = {
        -- TODO
        updateFunc = function(statFrame, unit) ArmoryPaperDollFrame_SetResilience(statFrame, unit); end
    },
};

ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS = {
    "GENERAL",
    "ATTRIBUTES",
    "MELEE",
    "RANGED",
    "SPELL",
    "DEFENSE",
};

ARMORY_MAX_ALTERNATE_SLOTS = 3;
ARMORY_ALTERNATE_SLOT_SIZE = 40;
ARMORY_NUM_GEARSETS_PER_ROW = 5;

local STRIPE_COLOR = {r=0.9, g=0.9, b=1};

function ArmoryPaperDollTalentFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_TALENT_UPDATE");
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
end

function ArmoryPaperDollTalentFrame_OnEvent(self, event, ...)
    if ( self:GetParent() == ArmoryPaperDollOverlayFrame ) then
        ArmoryPaperDollFrame_UpdateTalent(1);
    elseif ( Armory:CanHandleEvents() ) then
        Armory:Execute(ArmoryPaperDollFrame_UpdateTalent);
    end
end

function ArmoryPaperDollTradeSkillFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("SKILL_LINES_CHANGED");
end

function ArmoryPaperDollTradeSkillFrame_OnEvent(self, event, ...)
    if ( self:GetParent() == ArmoryPaperDollOverlayFrame ) then
        ArmoryPaperDollFrame_UpdateSkills(1);
    elseif ( not Armory:CanHandleEvents() ) then
        return
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        if ( Armory.forceScan or not Armory:ProfessionsExists() ) then
            Armory:Execute(ArmoryPaperDollTradeSkillFrame_UpdateSkills);
        end
    elseif ( event == "SKILL_LINES_CHANGED" ) then
        Armory:Execute(ArmoryPaperDollTradeSkillFrame_UpdateSkills);
    end
end

function ArmoryPaperDollTradeSkillFrame_UpdateSkills()
    Armory:UpdateProfessions();
    ArmoryPaperDollFrame_UpdateSkills();
end

function ArmoryPaperDollItemSlotButton_Update(button, itemId)
    local unit = "player";
    local count = 0;
    local texture;
    
    if ( itemId ~= nil ) then
        if ( itemId ~= 0 ) then
            _, link, _, _, _, _, _, _, _, texture = _G.GetItemInfo(itemId);
        end
        button.itemId = itemId;
    else
        link = Armory:GetInventoryItemLink(unit, button:GetID())
        texture = Armory:GetInventoryItemTexture(unit, button:GetID());
        count = Armory:GetInventoryItemCount(unit, button:GetID());
        button.itemId = nil;
    end
    
    if ( texture ) then
        SetItemButtonTexture(button, texture);
        SetItemButtonCount(button, count);
        button.hasItem = 1;
    else
        texture = button.backgroundTextureName;
        if ( button.checkRelic and Armory:UnitHasRelicSlot(unit) ) then
            texture = "Interface\\Paperdoll\\UI-PaperDoll-Slot-Relic.blp";
        end
        SetItemButtonTexture(button, texture);
        SetItemButtonCount(button, 0);
        button.hasItem = nil;
    end
    
    Armory:SetInventoryItem("player", button:GetID(), true);
    button.link = link;
end

function ArmoryPaperDollItemSlotButton_OnLoad(self)
    local slotName = self:GetName();
    local id, textureName, checkRelic = GetInventorySlotInfo(strsub(slotName,7));
    self:SetID(id);
    local texture = _G[slotName.."IconTexture"];
    texture:SetTexture(textureName);
    self.backgroundTextureName = textureName;
    self.checkRelic = checkRelic;
end

function ArmoryPaperDollItemSlotButton_OnEnter(self)
    local hasItem;
    self.anchor = "ANCHOR_RIGHT";
    GameTooltip:SetOwner(self, self.anchor);
    if ( self.itemId == nil ) then
        if ( self:GetID() == 0 or (self:GetID() >= 16 and self:GetID() <= 18) ) then
            ArmoryAlternateSlotFrame_Show(self, "VERTICAL", "DOWN");
        elseif ( self:GetID() ~= 9 and self:GetID() >= 6 and self:GetID() <= 14 ) then
            self.anchor = "ANCHOR_LEFT";
            ArmoryAlternateSlotFrame_Show(self, "HORIZONTAL", "RIGHT");
            if ( ArmoryAlternateSlotFrame:IsShown() ) then
                GameTooltip:SetOwner(ArmoryAlternateSlotFrame, "ANCHOR_RIGHT", -6, -6);
            end
        else
            ArmoryAlternateSlotFrame_Show(self, "HORIZONTAL", "LEFT");
        end
        hasItem = Armory:SetInventoryItem("player", self:GetID());
    elseif ( self.itemId ~= 0 ) then
        local _, link = _G.GetItemInfo(self.itemId);
        Armory:SetInventoryItem("player", self:GetID(), nil, nil, link);
        hasItem = true;
    end
    if ( not hasItem ) then
        local text = _G[strupper(strsub(self:GetName(), 7))];
        if ( self.checkRelic and Armory:UnitHasRelicSlot("player") ) then
            text = RELICSLOT;
        end
        GameTooltip:SetText(text);
    end
end

function ArmoryPaperDollItemSlotButton_OnClick(self)
    if ( IsModifiedClick("CHATLINK") and self.link ) then
        HandleModifiedItemClick(self.link);
    end
end

function ArmoryAttributesFramePlayerStatDropDown_OnLoad(self)
    ArmoryDropDownMenu_Initialize(self, ArmoryAttributesFramePlayerStatDropDown_Initialize);
    ArmoryDropDownMenu_SetSelectedValue(self, ARMORY_PLAYERSTAT_DROPDOWN_SELECTION);
    ArmoryDropDownMenu_SetWidth(self, 212);
    ArmoryDropDownMenu_JustifyText(self, "LEFT");
end

function ArmoryAttributesFramePlayerStatDropDown_Initialize()
    -- Setup buttons
    local info = ArmoryDropDownMenu_CreateInfo();
    local checked;
    for i = 1, getn(ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS) do
        if ( ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS[i] == ARMORY_PLAYERSTAT_DROPDOWN_SELECTION ) then
            checked = 1;
        else
            checked = nil;
        end
        info.text = _G["STAT_CATEGORY_"..ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS[i]];
        info.func = ArmoryAttributesFramePlayerStatDropDown_OnClick;
        info.value = ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS[i];
        info.checked = checked;
        info.owner = ARMORY_DROPDOWNMENU_OPEN_MENU;
        ArmoryDropDownMenu_AddButton(info);
    end
end

function ArmoryAttributesFramePlayerStatDropDown_OnClick(self)
    ArmoryDropDownMenu_SetSelectedValue(_G[self.owner], self.value);
    ARMORY_PLAYERSTAT_DROPDOWN_SELECTION = self.value;
    ArmoryPaperDollFrame_UpdateStatCategory(self.value);
end

function ArmoryPaperDollFrame_SetLevel()
    local unit = "player";
    local class, classEn = Armory:UnitClass(unit);
    local text = format(PLAYER_LEVEL_NO_SPEC, Armory:UnitLevel(unit), Armory:ClassColor(classEn, true), class);
    local xp = Armory:GetXP();
    if ( xp ) then
        text = text.." ("..XP.." "..xp..")";
    end
    ArmoryLevelText:SetText(text);
end

function ArmoryPaperDollFrame_SetGuild()
    local guildName, title = Armory:GetGuildInfo("player");
    if ( guildName ) then
        ArmoryGuildText:Show();
        ArmoryGuildText:SetFormattedText(GUILD_TITLE_TEMPLATE, title, guildName);
    else
        ArmoryGuildText:Hide();
    end
end

function ArmoryPaperDollFrame_SetZone()
    local zoneName = Armory:GetZoneText();
    local subzoneName = Armory:GetSubZoneText();
    if ( subzoneName == zoneName ) then
        subzoneName = "";    
    end

    -- backwards compatible...
    if ( zoneName ) then
        if ( subzoneName ~= "" ) then
            zoneName = zoneName..", "..subzoneName;
        end
        ArmoryZoneText:Show();
        ArmoryZoneText:SetText(zoneName);
    else
        ArmoryZoneText:Hide();
    end
end

function ArmoryGetMeleeMissChance(levelOffset, special)
    if ( levelOffset < 0 or levelOffset > 3 ) then
        return 0;
    end
    local chance = BASE_MISS_CHANCE_PHYSICAL[levelOffset];
    chance = chance - Armory:GetCombatRatingBonus(CR_HIT_MELEE) - Armory:GetHitModifier();
    if ( Armory:IsDualWielding() and not special ) then
        chance = chance + DUAL_WIELD_HIT_PENALTY;
    end
    if ( chance < 0 ) then
        chance = 0;
    elseif ( chance > 100 ) then
        chance = 100;
    end
    return chance;
end

function ArmoryGetRangedMissChance(levelOffset, special)
    if ( levelOffset < 0 or levelOffset > 3 ) then
        return 0;
    end
    local chance = BASE_MISS_CHANCE_PHYSICAL[levelOffset];
    chance = chance - Armory:GetCombatRatingBonus(CR_HIT_RANGED) - Armory:GetHitModifier();
    if ( chance < 0 ) then
        chance = 0;
    elseif ( chance > 100 ) then
        chance = 100;
    end
    return chance;
end

function ArmoryGetSpellMissChance(levelOffset, special)
    if ( levelOffset < 0 or levelOffset > 3 ) then
        return 0;
    end
    local chance = BASE_MISS_CHANCE_SPELL[levelOffset];
    chance = chance - Armory:GetCombatRatingBonus(CR_HIT_SPELL) - Armory:GetSpellHitModifier();
    if ( chance < 0 ) then
        chance = 0;
    elseif ( chance > 100 ) then
        chance = 100;
    end
    return chance;
end

function ArmoryGetEnemyDodgeChance(levelOffset)
    if ( levelOffset < 0 or levelOffset > 3 ) then
        return 0;
    end
    local chance = BASE_ENEMY_DODGE_CHANCE[levelOffset];
    local offhandChance = BASE_ENEMY_DODGE_CHANCE[levelOffset];
	local rangedChance = BASE_ENEMY_DODGE_CHANCE[levelOffset];
	local expertisePct, offhandExpertisePct, rangedExpertisePct = Armory:GetExpertise();
    chance = chance - expertisePct;
    offhandChance = offhandChance - offhandExpertisePct;
	rangedChance = rangedChance - rangedExpertisePct;
    if ( chance < 0 ) then
        chance = 0;
    elseif ( chance > 100 ) then
        chance = 100;
    end
    if ( offhandChance < 0 ) then
        offhandChance = 0;
    elseif ( offhandChance > 100 ) then
        offhandChance = 100;
    end
	if ( rangedChance < 0 ) then
		rangedChance = 0;
	elseif ( rangedChance > 100 ) then
		rangedChance = 100;
	end
	return chance, offhandChance, rangedChance;
end

function ArmoryGetEnemyParryChance(levelOffset)
    if ( levelOffset < 0 or levelOffset > 3 ) then
        return 0;
    end
    local chance = BASE_ENEMY_PARRY_CHANCE[levelOffset];
    local offhandChance = BASE_ENEMY_PARRY_CHANCE[levelOffset];
    local expertisePct, offhandExpertisePct = Armory:GetExpertise();
	local mainhandDodge = BASE_ENEMY_DODGE_CHANCE[levelOffset];
	local offhandDodge = BASE_ENEMY_DODGE_CHANCE[levelOffset];

	expertisePct = expertisePct - mainhandDodge;
	if ( expertisePct < 0 ) then 
		expertisePct = 0;
	end
    chance = chance - expertisePct;
    if ( chance < 0 ) then
        chance = 0;
    elseif ( chance > 100 ) then
        chance = 100;
    end

	offhandExpertisePct = offhandExpertisePct - offhandDodge;
	if ( offhandExpertisePct < 0 ) then
		offhandExpertisePct = 0;
	end
	offhandChance = offhandChance - offhandExpertisePct;
    if ( offhandChance < 0 ) then
        offhandChance = 0;
    elseif ( offhandChance > 100 ) then
        offhandChance = 100;
    end
    return chance, offhandChance;
end

function ArmoryPaperDollFrame_SetHealth(statFrame, unit)
    local health = Armory:UnitHealthMax(unit) or 0;
	health = BreakUpLargeNumbers(health);
    PaperDollFrame_SetLabelAndText(statFrame, HEALTH, health, false);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, HEALTH).." "..health..FONT_COLOR_CODE_CLOSE;
    if ( unit == "player" ) then
        statFrame.tooltip2 = STAT_HEALTH_TOOLTIP;
    elseif ( unit == "pet" ) then
        statFrame.tooltip2 = STAT_HEALTH_PET_TOOLTIP;
    end
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetPower(statFrame, unit)
    local powerType, powerToken = Armory:UnitPowerType(unit);
    local power = Armory:UnitPowerMax(unit) or 0;
	power = BreakUpLargeNumbers(power);
    if ( powerToken and _G[powerToken] ) then
        PaperDollFrame_SetLabelAndText(statFrame, _G[powerToken], power, false);
        statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G[powerToken]).." "..power..FONT_COLOR_CODE_CLOSE;
        statFrame.tooltip2 = _G["STAT_"..powerToken.."_TOOLTIP"];
        statFrame:Show();
    else
        statFrame:Hide();
    end
end

function ArmoryPaperDollFrame_SetAlternateMana(statFrame, unit)
    local _, class = Armory:UnitClass(unit);
    if ( class ~= "DRUID" and (class ~= "MONK" or Armory:GetSpecialization() ~= SPEC_MONK_MISTWEAVER) ) then
        statFrame:Hide();
        return;
    end
    local powerType, powerToken = Armory:UnitPowerType(unit);
    if ( powerToken == "MANA" ) then
        statFrame:Hide();
        return;
    end

    local power = Armory:UnitPowerMax(unit, 0);
	power = BreakUpLargeNumbers(power);
    PaperDollFrame_SetLabelAndText(statFrame, MANA, power, false);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MANA).." "..power..FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = _G["STAT_MANA_TOOLTIP"];
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetStat(statFrame, unit, statIndex)
    local label = _G[statFrame:GetName().."Label"];
    local text = _G[statFrame:GetName().."StatText"];
    local stat, effectiveStat, posBuff, negBuff = Armory:UnitStat(unit, statIndex);
    local statName = _G["SPELL_STAT"..statIndex.."_NAME"];
    label:SetText(format(STAT_FORMAT, statName));
	local effectiveStatDisplay = BreakUpLargeNumbers(effectiveStat);

    -- Set the tooltip text
    local tooltipText = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, statName).." ";

    if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
        text:SetText(effectiveStatDisplay);
        statFrame.tooltip = tooltipText..effectiveStatDisplay..FONT_COLOR_CODE_CLOSE;
    else 
        tooltipText = tooltipText..effectiveStatDisplay;
        if ( posBuff > 0 or negBuff < 0 ) then
            tooltipText = tooltipText.." ("..BreakUpLargeNumbers(stat - posBuff - negBuff)..FONT_COLOR_CODE_CLOSE;
        end
        if ( posBuff > 0 ) then
            tooltipText = tooltipText..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..BreakUpLargeNumbers(posBuff)..FONT_COLOR_CODE_CLOSE;
        end
        if ( negBuff < 0 ) then
            tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..BreakUpLargeNumbers(negBuff)..FONT_COLOR_CODE_CLOSE;
        end
        if ( posBuff > 0 or negBuff < 0 ) then
            tooltipText = tooltipText..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
        end
        statFrame.tooltip = tooltipText;

        -- If there are any negative buffs then show the main number in red even if there are
        -- positive buffs. Otherwise show in green.
        if ( negBuff < 0 ) then
            text:SetText(RED_FONT_COLOR_CODE..effectiveStatDisplay..FONT_COLOR_CODE_CLOSE);
        else
            text:SetText(GREEN_FONT_COLOR_CODE..effectiveStatDisplay..FONT_COLOR_CODE_CLOSE);
        end
    end
    statFrame.tooltip2 = _G["DEFAULT_STAT"..statIndex.."_TOOLTIP"];

    if ( unit == "player" ) then
        local _, unitClass = Armory:UnitClass("player");
        unitClass = strupper(unitClass);

        -- Strength
        if ( statIndex == 1 ) then
            local attackPower = Armory:GetAttackPowerForStat(statIndex, effectiveStat);
            statFrame.tooltip2 = format(statFrame.tooltip2, BreakUpLargeNumbers(attackPower));
        -- Agility
        elseif ( statIndex == 2 ) then
            local attackPower = Armory:GetAttackPowerForStat(statIndex, effectiveStat);
            if ( attackPower > 0 ) then
                statFrame.tooltip2 = format(STAT_TOOLTIP_BONUS_AP, BreakUpLargeNumbers(attackPower)) .. format(statFrame.tooltip2, Armory:GetCritChanceFromAgility("player"));
            else
                statFrame.tooltip2 = format(statFrame.tooltip2, Armory:GetCritChanceFromAgility("player"));
            end
        -- Stamina
        elseif ( statIndex == 3 ) then
            local baseStam = min(20, effectiveStat);
            local moreStam = effectiveStat - baseStam;
            statFrame.tooltip2 = format(statFrame.tooltip2, BreakUpLargeNumbers((baseStam + (moreStam * Armory:UnitHPPerStamina("player"))) * Armory:GetUnitMaxHealthModifier("player")));
        -- Intellect
        elseif ( statIndex == 4 ) then
            if ( Armory:UnitHasMana("player") ) then
                if ( Armory:GetOverrideSpellPowerByAP() ~= nil ) then
                    statFrame.tooltip2 = format(STAT4_NOSPELLPOWER_TOOLTIP, Armory:GetSpellCritChanceFromIntellect("player"));
                else
                    statFrame.tooltip2 = format(statFrame.tooltip2, max(0, effectiveStat - 10), Armory:GetSpellCritChanceFromIntellect("player"));
                end
            else
                statFrame.tooltip2 = STAT_USELESS_TOOLTIP;
            end
        -- Spirit
        elseif ( statIndex == 5 ) then
            -- All mana regen stats are displayed as mana/5 sec.
            if ( Armory:UnitHasMana("player") ) then
                local regen = Armory:GetUnitManaRegenRateFromSpirit("player");
                regen = floor( regen * 5.0 );
                statFrame.tooltip2 = format(MANA_REGEN_FROM_SPIRIT, regen);
            else
                statFrame.tooltip2 = STAT_USELESS_TOOLTIP;
            end
        end
    elseif ( unit == "pet" ) then
        if ( statIndex == 1 ) then
            local attackPower = BreakUpLargeNumbers(effectiveStat - 20);
            statFrame.tooltip2 = format(statFrame.tooltip2, attackPower);
        elseif ( statIndex == 2 ) then
            local critChance = Armory:GetCritChanceFromAgility("pet");
            if ( critChance ) then
                statFrame.tooltip2 = format(statFrame.tooltip2, critChance);
            else
                statFrame.tooltip2 = nil;
            end
        elseif ( statIndex == 3 ) then
            local healthModifier = Armory:GetUnitHealthModifier("pet");
            local maxHealthModifier = Armory:GetUnitMaxHealthModifier("pet");
            if ( healthModifier and maxHealthModifier ) then
                local expectedHealthGain = (((stat - posBuff - negBuff) - 20) * 10 + 20) * healthModifier;
                local realHealthGain = ((effectiveStat - 20) * 10 + 20) * healthModifier;
                local healthGain = BreakUpLargeNumbers((realHealthGain - expectedHealthGain) * maxHealthModifier);
                statFrame.tooltip2 = format(statFrame.tooltip2, healthGain);
            else
                statFrame.tooltip2 = nil;
            end
        elseif ( statIndex == 4 ) then
            if ( Armory:UnitHasMana("pet") ) then
                local manaGain = BreakUpLargeNumbers(((effectiveStat - 20) * 15 + 20) * Armory:GetUnitPowerModifier("pet"));
                statFrame.tooltip2 = format(statFrame.tooltip2, manaGain, max(0, effectiveStat - 10), Armory:GetSpellCritChanceFromIntellect("pet"));
            else
                statFrame.tooltip2 = nil;
            end
        elseif ( statIndex == 5 ) then
            statFrame.tooltip2 = "";
            if ( Armory:UnitHasMana("pet") ) then
                statFrame.tooltip2 = format(MANA_REGEN_FROM_SPIRIT, Armory:GetUnitManaRegenRateFromSpirit("pet"));
            end
        end
    end
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetArmor(statFrame, unit)
    local base, effectiveArmor, armor, posBuff, negBuff = Armory:UnitArmor(unit);
    local level = Armory:UnitLevel(unit);
    
    if ( level and effectiveArmor ) then
        _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, ARMOR));
        local text = _G[statFrame:GetName().."StatText"];

        PaperDollFormatStat(ARMOR, base, posBuff, negBuff, statFrame, text);
        local armorReduction = PaperDollFrame_GetArmorReduction(effectiveArmor, level);
        statFrame.tooltip2 = format(DEFAULT_STATARMOR_TOOLTIP, armorReduction);

        if ( unit == "player" ) then
            local petBonus = Armory:ComputePetBonus( "PET_BONUS_ARMOR", effectiveArmor );
            if( petBonus > 0 ) then
                statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_ARMOR, petBonus);
            end
        end

        statFrame:Show();
   else
        statFrame:Hide();
   end
end

function ArmoryPaperDollFrame_SetDodge(statFrame, unit)
    if ( unit ~= "player" ) then
        statFrame:Hide();
        return;
    end
    
    local chance = Armory:GetDodgeChance();
    PaperDollFrame_SetLabelAndText(statFrame, STAT_DODGE, chance, 1);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, DODGE_CHANCE).." "..string.format("%.2F", chance).."%"..FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = format(CR_DODGE_TOOLTIP, Armory:GetCombatRating(CR_DODGE), Armory:GetCombatRatingBonus(CR_DODGE));
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetBlock(statFrame, unit)
    if ( unit ~= "player" ) then
        statFrame:Hide();
        return;
    end
    
    local chance = Armory:GetBlockChance();
    PaperDollFrame_SetLabelAndText(statFrame, STAT_BLOCK, chance, 1);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, BLOCK_CHANCE).." "..string.format("%.2F", chance).."%"..FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = format(CR_BLOCK_TOOLTIP, Armory:GetCombatRating(CR_BLOCK), Armory:GetCombatRatingBonus(CR_BLOCK), Armory:GetShieldBlock());
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetParry(statFrame, unit)
    if ( unit ~= "player" ) then
        statFrame:Hide();
        return;
    end
    
    local chance = Armory:GetParryChance();
    PaperDollFrame_SetLabelAndText(statFrame, STAT_PARRY, chance, 1);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, PARRY_CHANCE).." "..string.format("%.2F", chance).."%"..FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = format(CR_PARRY_TOOLTIP, Armory:GetCombatRating(CR_PARRY), Armory:GetCombatRatingBonus(CR_PARRY));
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetResilience(statFrame, unit)
    if ( unit ~= "player" ) then
        statFrame:Hide();
        return;
    end
    
    local resilienceRating = BreakUpLargeNumbers(Armory:GetCombatRating(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN));
    local ratingBonus = Armory:GetCombatRatingBonus(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN);
    local damageReduction = ratingBonus + GetModResilienceDamageReduction();
    PaperDollFrame_SetLabelAndText(statFrame, STAT_RESILIENCE, damageReduction, 1);

    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RESILIENCE).." "..format("%.2F%%", damageReduction)..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = RESILIENCE_TOOLTIP .. format(STAT_RESILIENCE_BASE_TOOLTIP, resilienceRating, ratingBonus);
	statFrame:Show();
end

function ArmoryPaperDollFrame_SetPvpPower(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end

	local pvpPower = BreakUpLargeNumbers(Armory:GetCombatRating(CR_PVP_POWER));
	local pvpPowerBonus = Armory:GetCombatRatingBonus(CR_PVP_POWER);
	PaperDollFrame_SetLabelAndText(statFrame, STAT_PVP_POWER, pvpPowerBonus, 1);

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_PVP_POWER).." "..format("%.2F%%", pvpPowerBonus)..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = PVP_POWER_TOOLTIP .. format(PVP_POWER_BASE_TOOLTIP, pvpPower, pvpPowerBonus);
	statFrame:Show();
end

function ArmoryPaperDollFrame_SetDamage(statFrame, unit)
    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, DAMAGE));
    local text = _G[statFrame:GetName().."StatText"];
    local speed, offhandSpeed = Armory:UnitAttackSpeed(unit);

    local minDamage;
    local maxDamage; 
    local minOffHandDamage;
    local maxOffHandDamage; 
    local physicalBonusPos;
    local physicalBonusNeg;
    local percent;
    
    minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = Armory:UnitDamage(unit);
    if ( not minDamage ) then
        statFrame:Hide();
        return;
    end 
    
    local displayMin = max(floor(minDamage),1);
	local displayMinLarge = BreakUpLargeNumbers(displayMin);
    local displayMax = max(ceil(maxDamage),1);
	local displayMaxLarge = BreakUpLargeNumbers(displayMax);

    minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
    maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

    local baseDamage = (minDamage + maxDamage) * 0.5;
    local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
    local totalBonus = (fullDamage - baseDamage);
    local damagePerSecond = (max(fullDamage,1) / speed);
    local damageTooltip = displayMinLarge.." - "..displayMaxLarge;

    local colorPos = "|cff20ff20";
    local colorNeg = "|cffff2020";

    -- epsilon check
    if ( totalBonus < 0.1 and totalBonus > -0.1 ) then
        totalBonus = 0.0;
    end

    if ( totalBonus == 0 ) then
        if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
            text:SetText(displayMinLarge.." - "..displayMaxLarge);    
        else
            text:SetText(displayMinLarge.."-"..displayMaxLarge);
        end
    else

        local color;
        if ( totalBonus > 0 ) then
            color = colorPos;
        else
            color = colorNeg;
        end
        if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
            text:SetText(color..displayMinLarge.." - "..displayMaxLarge.."|r");    
        else
            text:SetText(color..displayMinLarge.."-"..displayMaxLarge.."|r");
        end
        if ( physicalBonusPos > 0 ) then
            damageTooltip = damageTooltip..colorPos.." +"..physicalBonusPos.."|r";
        end
        if ( physicalBonusNeg < 0 ) then
            damageTooltip = damageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
        end
        if ( percent > 1 ) then
            damageTooltip = damageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
        elseif ( percent < 1 ) then
            damageTooltip = damageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
        end

    end
    statFrame.damage = damageTooltip;
    statFrame.attackSpeed = speed;
    statFrame.dps = damagePerSecond;
    statFrame.unit = unit;

    -- If there's an offhand speed then add the offhand info to the tooltip
    if ( offhandSpeed ) then
        minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
        maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;

        local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
        local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
        local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
        local offhandDamageTooltip = BreakUpLargeNumbers(max(floor(minOffHandDamage),1)).." - "..BreakUpLargeNumbers(max(ceil(maxOffHandDamage),1));
        if ( physicalBonusPos > 0 ) then
            offhandDamageTooltip = offhandDamageTooltip..colorPos.." +"..physicalBonusPos.."|r";
        end
        if ( physicalBonusNeg < 0 ) then
            offhandDamageTooltip = offhandDamageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
        end
        if ( percent > 1 ) then
            offhandDamageTooltip = offhandDamageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
        elseif ( percent < 1 ) then
            offhandDamageTooltip = offhandDamageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
        end
        statFrame.offhandDamage = offhandDamageTooltip;
        statFrame.offhandAttackSpeed = offhandSpeed;
        statFrame.offhandDps = offhandDamagePerSecond;
    else
        statFrame.offhandAttackSpeed = nil;
    end
    
    statFrame:SetScript("OnEnter", CharacterDamageFrame_OnEnter);

    statFrame:Show();
end

function ArmoryPaperDollFrame_SetMeleeDPS(statFrame, unit)
    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_DPS_SHORT));
    local text = _G[statFrame:GetName().."StatText"];
    local speed, offhandSpeed = Armory:UnitAttackSpeed(unit);

    local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = Armory:UnitDamage(unit);
    if ( not minDamage ) then
        statFrame:Hide();
        return;
    end 
    
    local displayMin = max(floor(minDamage), 1);
    local displayMax = max(ceil(maxDamage), 1);

    minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
    maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

    local baseDamage = (minDamage + maxDamage) * 0.5;
    local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
    local totalBonus = (fullDamage - baseDamage);
    local damagePerSecond = (max(fullDamage, 1) / speed);
    local damageTooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage), 1);

    local colorPos = "|cff20ff20";
    local colorNeg = "|cffff2020";
    local statText;

    -- epsilon check
    if ( totalBonus < 0.1 and totalBonus > -0.1 ) then
        totalBonus = 0.0;
    end

    if ( totalBonus == 0 ) then
        statText = BreakUpLargeNumbers(damagePerSecond);
    else
        local color;
        if ( totalBonus > 0 ) then
            color = colorPos;
        else
            color = colorNeg;
        end
        statText = color..BreakUpLargeNumbers(damagePerSecond).."|r";
    end

    -- If there's an offhand speed then add the offhand info
    if ( offhandSpeed ) then
        minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
        maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;

        local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
        local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
        local offhandDamagePerSecond = (max(offhandFullDamage, 1) / offhandSpeed);
        local offhandTotalBonus = (offhandFullDamage - offhandBaseDamage);

        -- epsilon check
        if ( offhandTotalBonus < 0.1 and offhandTotalBonus > -0.1 ) then
            offhandTotalBonus = 0.0;
        end
        local separator = " / ";
        if (damagePerSecond > 1000 and offhandDamagePerSecond > 1000) then
            separator = "/";
        end
        if ( offhandTotalBonus == 0 ) then
            statText = statText..separator..BreakUpLargeNumbers(offhandDamagePerSecond);
        else
            local color;
            if ( offhandTotalBonus > 0 ) then
                color = colorPos;
            else
                color = colorNeg;
            end
            statText = statText..separator..color..BreakUpLargeNumbers(offhandDamagePerSecond).."|r";
        end
    end

    text:SetText(statText);
    
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE;
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetRangedDPS(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_DPS_SHORT));
    local text = _G[statFrame:GetName().."StatText"];

    -- If no ranged attack then set to n/a
    local rangedWeapon = Armory:IsRangedWeapon();
    if ( rangedWeapon ) then
        ArmoryPaperDollFrame.noRanged = nil;
    else
        text:SetText(NOT_APPLICABLE);
        ArmoryPaperDollFrame.noRanged = 1;
        statFrame.damage = nil;
        return;
    end

    local rangedAttackSpeed, minDamage, maxDamage, physicalBonusPos, physicalBonusNeg, percent = Armory:UnitRangedDamage(unit);

    -- Round to the third decimal place (i.e. 99.9 percent)
    percent = math.floor(percent  * 10^3 + 0.5) / 10^3;
    local displayMin = max(floor(minDamage),1);
    local displayMax = max(ceil(maxDamage),1);

    local baseDamage;
    local fullDamage;
    local totalBonus;
    local damagePerSecond;
    local tooltip;

    if ( Armory:HasWandEquipped() ) then
        baseDamage = (minDamage + maxDamage) * 0.5;
        fullDamage = baseDamage * percent;
        totalBonus = 0;
        if( rangedAttackSpeed == 0 ) then
            damagePerSecond = 0;
        else
            damagePerSecond = (max(fullDamage, 1) / rangedAttackSpeed);
        end
    else
        minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
        maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

        baseDamage = (minDamage + maxDamage) * 0.5;
        fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
        totalBonus = (fullDamage - baseDamage);
        if( rangedAttackSpeed == 0 ) then
            damagePerSecond = 0;
        else
            damagePerSecond = (max(fullDamage, 1) / rangedAttackSpeed);
        end
    end
	tooltip = BreakUpLargeNumbers(max(floor(minDamage),1)).." - "..BreakUpLargeNumbers(max(ceil(maxDamage),1));

    if ( totalBonus == 0 ) then
        text:SetText(BreakUpLargeNumbers(damagePerSecond));
    else
        local colorPos = "|cff20ff20";
        local colorNeg = "|cffff2020";
        local color;
        if ( totalBonus > 0 ) then
            color = colorPos;
        else
            color = colorNeg;
        end
        text:SetText(color.. BreakUpLargeNumbers(damagePerSecond).."|r");
        if ( physicalBonusPos > 0 ) then
            tooltip = tooltip..colorPos.." +"..BreakUpLargeNumbers(physicalBonusPos).."|r";
        end
        if ( physicalBonusNeg < 0 ) then
            tooltip = tooltip..colorNeg.." "..BreakUpLargeNumbers(physicalBonusNeg).."|r";
        end
        if ( percent > 1 ) then
            tooltip = tooltip..colorPos.." x"..floor(percent * 100 + 0.5).."%|r";
        elseif ( percent < 1 ) then
            tooltip = tooltip..colorNeg.." x"..floor(percent * 100 + 0.5).."%|r";
        end
        --statFrame.tooltip2 = tooltip.." "..format(DPS_TEMPLATE, damagePerSecond);
    end

    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE;
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetAttackSpeed(statFrame, unit)
    local speed, offhandSpeed = Armory:UnitAttackSpeed(unit);
    if ( speed ) then
        local text;    
        if ( offhandSpeed ) then
            text = BreakUpLargeNumbers(speed).." / "..offhandSpeed;
        else
            text = BreakUpLargeNumbers(speed);
        end
        PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, text);

        statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..text..FONT_COLOR_CODE_CLOSE;

        statFrame:Show();
    else
        statFrame:Hide();
    end
end

function ArmoryPaperDollFrame_SetAttackPower(statFrame, unit)
    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_ATTACK_POWER));
    local text = _G[statFrame:GetName().."StatText"];
    local base, posBuff, negBuff = Armory:UnitAttackPower(unit);

    if ( base ) then
		local damageBonus = BreakUpLargeNumbers(max((base + posBuff + negBuff), 0) / ATTACK_POWER_MAGIC_NUMBER);
		local spellPower = 0;
		if ( Armory:GetOverrideAPBySpellPower() ~= nil ) then
			local holySchool = 2;
			-- Start at 2 to skip physical damage
			spellPower = Armory:GetSpellBonusDamage(holySchool);		
			for i=(holySchool+1), MAX_SPELL_SCHOOLS do
				spellPower = min(spellPower, Armory:GetSpellBonusDamage(i));
			end
			spellPower = min(spellPower, Armory:GetSpellBonusHealing()) * Armory:GetOverrideAPBySpellPower();

			PaperDollFormatStat(MELEE_ATTACK_POWER, spellPower, 0, 0, statFrame, text);
			damageBonus = BreakUpLargeNumbers(spellPower / ATTACK_POWER_MAGIC_NUMBER);
		else
			PaperDollFormatStat(MELEE_ATTACK_POWER, base, posBuff, negBuff, statFrame, text);
		end

        local effectiveAP = max(0, base + posBuff + negBuff);
        if ( Armory:GetOverrideSpellPowerByAP() ~= nil ) then
            statFrame.tooltip2 = format(MELEE_ATTACK_POWER_SPELL_POWER_TOOLTIP, damageBonus, BreakUpLargeNumbers(effectiveAP * Armory:GetOverrideSpellPowerByAP() + 0.5));
        else
            statFrame.tooltip2 = format(MELEE_ATTACK_POWER_TOOLTIP, damageBonus);
        end

        statFrame:Show();
    else
        statFrame:Hide();
    end
end

function ArmoryPaperDollFrame_SetRangedAttack(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    local rangedAttackBase, rangedAttackMod = Armory:UnitRangedAttack(unit);
    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, COMBAT_RATING_NAME1));
    local text = _G[statFrame:GetName().."StatText"];

    -- If no ranged texture then set stats to n/a
    local rangedWeapon = Armory:IsRangedWeapon();
    if ( rangedWeapon ) then
        ArmoryPaperDollFrame.noRanged = nil;
    else
        text:SetText(NOT_APPLICABLE);
        ArmoryPaperDollFrame.noRanged = 1;
        statFrame.tooltip = nil;
        return;
    end

    if( rangedAttackMod == 0 ) then
        text:SetText(BreakUpLargeNumbers(rangedAttackBase));
        statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, COMBAT_RATING_NAME1).." "..rangedAttackBase..FONT_COLOR_CODE_CLOSE;
    else
        local color = RED_FONT_COLOR_CODE;
        if( rangedAttackMod > 0 ) then
            color = GREEN_FONT_COLOR_CODE;
            statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, COMBAT_RATING_NAME1).." "..(rangedAttackBase + rangedAttackMod).." ("..rangedAttackBase..color.." +"..rangedAttackMod..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..")";
        else
            statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, COMBAT_RATING_NAME1).." "..(rangedAttackBase + rangedAttackMod).." ("..rangedAttackBase..color.." "..rangedAttackMod..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..")";
        end
        text:SetText(color..BreakUpLargeNumbers(rangedAttackBase + rangedAttackMod)..FONT_COLOR_CODE_CLOSE);
    end
    local total = Armory:GetCombatRating(CR_WEAPON_SKILL) + Armory:GetCombatRating(CR_WEAPON_SKILL_RANGED);
    statFrame.tooltip2 = format(WEAPON_SKILL_RATING, total);
    if ( total > 0 ) then
        statFrame.tooltip2 = statFrame.tooltip2..format(WEAPON_SKILL_RATING_BONUS, BreakUpLargeNumbers(Armory:GetCombatRatingBonus(CR_WEAPON_SKILL) + Armory:GetCombatRatingBonus(CR_WEAPON_SKILL_RANGED)));
    end
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetRangedDamage(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, DAMAGE));
    local text = _G[statFrame:GetName().."StatText"];

    -- If no ranged attack then set to n/a
    local rangedWeapon = Armory:IsRangedWeapon();
    if ( rangedWeapon ) then
        ArmoryPaperDollFrame.noRanged = nil;
    else
        text:SetText(NOT_APPLICABLE);
        ArmoryPaperDollFrame.noRanged = 1;
        statFrame.damage = nil;
        return;
    end

    local rangedAttackSpeed, minDamage, maxDamage, physicalBonusPos, physicalBonusNeg, percent = Armory:UnitRangedDamage(unit);

    -- Round to the third decimal place (i.e. 99.9 percent)
    percent = math.floor(percent  * 10^3 + 0.5) / 10^3
    local displayMin = max(floor(minDamage),1);
    local displayMax = max(ceil(maxDamage),1);

    local baseDamage;
    local fullDamage;
    local totalBonus;
    local damagePerSecond;
    local tooltip;

    if ( Armory:HasWandEquipped() ) then
        baseDamage = (minDamage + maxDamage) * 0.5;
        fullDamage = baseDamage * percent;
        totalBonus = 0;
        if ( rangedAttackSpeed == 0 ) then
            damagePerSecond = 0;
        else
            damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
        end
        tooltip = BreakUpLargeNumbers(max(floor(minDamage),1)).." - "..BreakUpLargeNumbers(max(ceil(maxDamage),1));
    else
        minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
        maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

        baseDamage = (minDamage + maxDamage) * 0.5;
        fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
        totalBonus = (fullDamage - baseDamage);
        if ( rangedAttackSpeed == 0 ) then
            damagePerSecond = 0;
        else
            damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
        end
        tooltip = BreakUpLargeNumbers(max(floor(minDamage),1)).." - "..BreakUpLargeNumbers(max(ceil(maxDamage),1));
    end

    if ( totalBonus == 0 ) then
        if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
            text:SetText(BreakUpLargeNumbers(displayMin).." - "..BreakUpLargeNumbers(displayMax));    
        else
            text:SetText(BreakUpLargeNumbers(displayMin).."-"..BreakUpLargeNumbers(displayMax));
        end
    else
        local colorPos = "|cff20ff20";
        local colorNeg = "|cffff2020";
        local color;
        if ( totalBonus > 0 ) then
            color = colorPos;
        else
            color = colorNeg;
        end
        if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
            text:SetText(color..BreakUpLargeNumbers(displayMin).." - "..BreakUpLargeNumbers(displayMax).."|r");    
        else
            text:SetText(color..BreakUpLargeNumbers(displayMin).."-"..BreakUpLargeNumbers(displayMax).."|r");
        end
        if ( physicalBonusPos > 0 ) then
            tooltip = tooltip..colorPos.." +"..BreakUpLargeNumbers(physicalBonusPos).."|r";
        end
        if ( physicalBonusNeg < 0 ) then
            tooltip = tooltip..colorNeg.." "..BreakUpLargeNumbers(physicalBonusNeg).."|r";
        end
        if ( percent > 1 ) then
            tooltip = tooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
        elseif ( percent < 1 ) then
            tooltip = tooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
        end
        statFrame.tooltip = tooltip.." "..format(DPS_TEMPLATE, BreakUpLargeNumbers(damagePerSecond));
    end
    statFrame.attackSpeed = rangedAttackSpeed;
    statFrame.damage = tooltip;
    statFrame.dps = damagePerSecond;
    statFrame:SetScript("OnEnter", CharacterRangedDamageFrame_OnEnter);
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetRangedAttackSpeed(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    local text;
    -- If no ranged attack then set to n/a
    if ( ArmoryPaperDollFrame.noRanged ) then
        text = NOT_APPLICABLE;
        statFrame.tooltip = nil;
    else
        text = Armory:UnitRangedDamage(unit);
        text = format("%.2F", text);
        statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..text..FONT_COLOR_CODE_CLOSE;
    end
    PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, text);
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetRangedAttackPower(statFrame, unit)
    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_ATTACK_POWER));
    local text = _G[statFrame:GetName().."StatText"];
    local base, posBuff, negBuff = Armory:UnitRangedAttackPower(unit);

	if ( Armory:GetOverrideAPBySpellPower() ~= nil ) then
		local holySchool = 2;
		-- Start at 2 to skip physical damage
		local spellPower = Armory:GetSpellBonusDamage(holySchool);		
		for i = holySchool + 1, MAX_SPELL_SCHOOLS do
			spellPower = min(spellPower, Armory:GetSpellBonusDamage(i));
		end
		spellPower = min(spellPower, Armory:GetSpellBonusHealing()) * Armory:GetOverrideAPBySpellPower();

		PaperDollFormatStat(RANGED_ATTACK_POWER, spellPower, 0, 0, statFrame, text);
	else
	    PaperDollFormatStat(RANGED_ATTACK_POWER, base, posBuff, negBuff, statFrame, text);
	end
	
    local totalAP = base+posBuff+negBuff;
    statFrame.tooltip2 = format(RANGED_ATTACK_POWER_TOOLTIP, BreakUpLargeNumbers(max((totalAP), 0)/ATTACK_POWER_MAGIC_NUMBER));
    local petAPBonus = Armory:ComputePetBonus( "PET_BONUS_RAP_TO_AP", totalAP );
    if( petAPBonus > 0 ) then
        statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_RANGED_ATTACK_POWER, BreakUpLargeNumbers(petAPBonus));
    end

    local petSpellDmgBonus = Armory:ComputePetBonus( "PET_BONUS_RAP_TO_SPELLDMG", totalAP );
    if( petSpellDmgBonus > 0 ) then
        statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_SPELLDAMAGE, BreakUpLargeNumbers(petSpellDmgBonus));
    end

    statFrame:Show();
end

function ArmoryPaperDollFrame_SetSpellBonusDamage(statFrame, unit)
    local text = _G[statFrame:GetName().."StatText"];
    local minModifier = 0;

    if ( unit == "player" ) then
        local holySchool = 2;
        -- Start at 2 to skip physical damage
        minModifier = GetSpellBonusDamage(holySchool);

        if ( statFrame.bonusDamage ) then
            table.wipe(statFrame.bonusDamage);
        else
            statFrame.bonusDamage = {};
        end
        statFrame.bonusDamage[holySchool] = minModifier;
        for i = (holySchool + 1), MAX_SPELL_SCHOOLS do
            local bonusDamage = Armory:GetSpellBonusDamage(i);
            minModifier = min(minModifier, bonusDamage);
            statFrame.bonusDamage[i] = bonusDamage;
        end
    elseif ( unit == "pet" ) then
        minModifier = Armory:GetPetSpellBonusDamage();
        statFrame.bonusDamage = nil;
    end

    local spellHealing = Armory:GetSpellBonusHealing();
    if ( spellHealing and minModifier ) then
        if ( spellHealing == minModifier ) then
            _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_SPELLPOWER));
            statFrame.tooltip = STAT_SPELLPOWER;
            statFrame.tooltip2 = STAT_SPELLPOWER_TOOLTIP;
        else
            _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_SPELLDAMAGE));
            statFrame.tooltip = STAT_SPELLDAMAGE;
            statFrame.tooltip2 = STAT_SPELLDAMAGE_TOOLTIP;
        end

        text:SetText(BreakUpLargeNumbers(minModifier));
        statFrame.minModifier = minModifier;
        statFrame.unit = unit;
        statFrame:SetScript("OnEnter", ArmoryCharacterSpellBonusDamage_OnEnter);
        statFrame:Show();
    else
        statFrame:Hide();
    end
end

function ArmoryPaperDollFrame_SetSpellBonusHealing(statFrame, unit)
    local text = _G[statFrame:GetName().."StatText"];
    local minDamage = 0;

    if ( unit == "player" ) then
        local holySchool = 2;
        -- Start at 2 to skip physical damage
        minDamage = Armory:GetSpellBonusDamage(holySchool);        
        for i = (holySchool + 1), MAX_SPELL_SCHOOLS do
            minDamage = min(minDamage, Armory:GetSpellBonusDamage(i));
        end
    elseif ( unit == "pet" ) then
        --Healing is not needed for pets
        --minDamage = Armory:GetPetSpellBonusDamage();
        statFrame:Hide();
        return;
    end
    statFrame.bonusDamage = nil;

    local spellHealing = Armory:GetSpellBonusHealing();
    if ( spellHealing == minDamage ) then
        statFrame:Hide();
        return;
    end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_SPELLHEALING));
    statFrame.tooltip = STAT_SPELLHEALING;
    statFrame.tooltip2 = STAT_SPELLHEALING_TOOLTIP;
    text:SetText(BreakUpLargeNumbers(spellHealing));
    statFrame.minModifier = spellHealing;
    statFrame.unit = unit;
    statFrame:SetScript("OnEnter", ArmoryCharacterSpellBonusDamage_OnEnter);
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetSpellCritChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, SPELL_CRIT_CHANCE));
    local text = _G[statFrame:GetName().."StatText"];
    local holySchool = 2;
    -- Start at 2 to skip physical damage
    local minCrit = Armory:GetSpellCritChance(holySchool);
    statFrame.spellCrit = {};
    statFrame.spellCrit[holySchool] = minCrit;
    local spellCrit;
    for i = (holySchool+1), MAX_SPELL_SCHOOLS do
        spellCrit = Armory:GetSpellCritChance(i);
        minCrit = min(minCrit, spellCrit);
        statFrame.spellCrit[i] = spellCrit;
    end
    minCrit = format("%.2F%%", minCrit);
    text:SetText(minCrit);
    statFrame.minCrit = minCrit;
    statFrame.rating = Armory:GetCombatRating(CR_CRIT_SPELL);
    statFrame.bonus = Armory:GetCombatRatingBonus(CR_CRIT_SPELL);
    statFrame:SetScript("OnEnter", ArmoryCharacterSpellCritChance_OnEnter);
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetMeleeCritChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MELEE_CRIT_CHANCE));
    local text = _G[statFrame:GetName().."StatText"];
    local critChance = Armory:GetCritChance();
    critChance = format("%.2F%%", critChance);
    text:SetText(critChance);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MELEE_CRIT_CHANCE).." "..critChance..FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = format(CR_CRIT_MELEE_TOOLTIP, BreakUpLargeNumbers(Armory:GetCombatRating(CR_CRIT_MELEE)), Armory:GetCombatRatingBonus(CR_CRIT_MELEE));
end

function ArmoryPaperDollFrame_SetRangedCritChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, RANGED_CRIT_CHANCE));
    local text = _G[statFrame:GetName().."StatText"];
    local critChance = Armory:GetRangedCritChance();
    critChance = format("%.2F%%", critChance);
    text:SetText(critChance);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, RANGED_CRIT_CHANCE).." "..critChance..FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = format(CR_CRIT_RANGED_TOOLTIP, BreakUpLargeNumbers(Armory:GetCombatRating(CR_CRIT_RANGED)), Armory:GetCombatRatingBonus(CR_CRIT_RANGED));
end

function ArmoryMeleeHitChance_OnEnter(statFrame)
    GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
    local hitChance = statFrame.hitChance;
    if ( hitChance >= 0 ) then
        hitChance = format("+%.2F%%", hitChance);
    else
        hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
    end
    GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
    GameTooltip:AddLine(format(STAT_HIT_MELEE_TOOLTIP, BreakUpLargeNumbers(statFrame.rating), statFrame.bonus));
    GameTooltip:AddLine(" ");
    GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
    if ( Armory:IsDualWielding() ) then
        GameTooltip:AddLine(STAT_HIT_NORMAL_ATTACKS, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
    end
    local playerLevel = Armory:UnitLevel("player");
    for i = 0, 3 do
        local missChance = format("%.2F%%", ArmoryGetMeleeMissChance(i, false));
        local level = playerLevel + i;
        if ( i == 3 ) then
            level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
        end
        GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
    end

    if ( Armory:IsDualWielding() ) then
        GameTooltip:AddLine(STAT_HIT_SPECIAL_ATTACKS, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
        for i = 0, 3 do
            local missChance = format("%.2F%%", ArmoryGetMeleeMissChance(i, true));
            local level = playerLevel + i;
            if ( i == 3 ) then
                level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
            end
            GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
        end
    end

    GameTooltip:Show();
end

function ArmoryPaperDollFrame_SetMeleeHitChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HIT_CHANCE));
    local text = _G[statFrame:GetName().."StatText"];
    local hitChance = Armory:GetCombatRatingBonus(CR_HIT_MELEE) + Armory:GetHitModifier();
    statFrame.hitChance = hitChance;
    statFrame.rating = Armory:GetCombatRating(CR_HIT_MELEE);
    statFrame.bonus = Armory:GetCombatRatingBonus(CR_HIT_MELEE);
    statFrame:SetScript("OnEnter", ArmoryMeleeHitChance_OnEnter);
    if ( hitChance >= 0 ) then
        hitChance = format("+%.2F%%", hitChance);
    else
        hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
    end
    text:SetText(hitChance);
    statFrame:Show();
end

function ArmoryRangedHitChance_OnEnter(statFrame)
    GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
    local hitChance = statFrame.hitChance;
    if ( hitChance >= 0 ) then
        hitChance = format("+%.2F%%", hitChance);
    else
        hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
    end
    GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
    GameTooltip:AddLine(format(STAT_HIT_RANGED_TOOLTIP, BreakUpLargeNumbers(statFrame.rating), statFrame.bonus));
    GameTooltip:AddLine(" ");
    GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
    local playerLevel = Armory:UnitLevel("player");
    for i = 0, 3 do
        local missChance = format("%.2F%%", ArmoryGetRangedMissChance(i));
        local level = playerLevel + i;
        if ( i == 3 ) then
            level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
        end
        GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
    end

    GameTooltip:Show();
end

function ArmoryPaperDollFrame_SetRangedHitChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HIT_CHANCE));
    local text = _G[statFrame:GetName().."StatText"];
    local hitChance = Armory:GetCombatRatingBonus(CR_HIT_RANGED) + Armory:GetHitModifier();
    statFrame.hitChance = hitChance;
    statFrame.rating = Armory:GetCombatRating(CR_HIT_RANGED);
    statFrame.bonus = Armory:GetCombatRatingBonus(CR_HIT_RANGED);
    statFrame:SetScript("OnEnter", ArmoryRangedHitChance_OnEnter);
    if ( hitChance >= 0 ) then
        hitChance = format("+%.2F%%", hitChance);
    else
        hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
    end
    text:SetText(hitChance);
    statFrame:Show();
end

function ArmorySpellHitChance_OnEnter(statFrame)
    GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
    local hitChance = statFrame.hitChance;
    if ( hitChance >= 0 ) then
        hitChance = format("+%.2F%%", hitChance);
    else
        hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
    end
    GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
    GameTooltip:AddLine(format(STAT_HIT_SPELL_TOOLTIP, BreakUpLargeNumbers(statFrame.rating), statFrame.bonus));
    GameTooltip:AddLine(" ");
    GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
    local playerLevel = Armory:UnitLevel("player");
    for i = 0, 3 do
        local missChance = format("%.2F%%", ArmoryGetSpellMissChance(i));
        local level = playerLevel + i;
        if ( i == 3 ) then
            level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
        end
        GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
    end

    GameTooltip:Show();
end

function ArmoryPaperDollFrame_SetSpellHitChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HIT_CHANCE));
    local text = _G[statFrame:GetName().."StatText"];
    local hitChance = Armory:GetCombatRatingBonus(CR_HIT_SPELL) + Armory:GetSpellHitModifier();
    statFrame.hitChance = hitChance;
    statFrame.rating = Armory:GetCombatRating(CR_HIT_SPELL);
    statFrame.bonus = Armory:GetCombatRatingBonus(CR_HIT_SPELL);
    statFrame:SetScript("OnEnter", ArmorySpellHitChance_OnEnter);
    if ( hitChance >= 0 ) then
        hitChance = format("+%.2F%%", hitChance);
    else
        hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
    end
    text:SetText(hitChance);
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetEnergyRegen(statFrame, unit)
    if ( unit ~= "player" ) then
        statFrame:Hide();
        return;
    end

    local powerType, powerToken = Armory:UnitPowerType(unit);
    if ( powerToken ~= "ENERGY" ) then
        statFrame:Hide();
        return;
    end

    local regenRate = Armory:GetPowerRegen();
    regenRate = BreakUpLargeNumbers(regenRate);
    PaperDollFrame_SetLabelAndText(statFrame, STAT_ENERGY_REGEN, regenRate, false);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_ENERGY_REGEN).." "..regenRate..FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = STAT_ENERGY_REGEN_TOOLTIP;
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetFocusRegen(statFrame, unit)
    if ( unit ~= "player" ) then
        statFrame:Hide();
        return;
    end

    local powerType, powerToken = Armory:UnitPowerType(unit);
    if ( powerToken ~= "FOCUS" ) then
        statFrame:Hide();
        return;
    end

    local regenRate = Armory:GetPowerRegen();
    regenRate = BreakUpLargeNumbers(regenRate);
    PaperDollFrame_SetLabelAndText(statFrame, STAT_FOCUS_REGEN, regenRate, false);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_FOCUS_REGEN).." "..regenRate..FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = STAT_FOCUS_REGEN_TOOLTIP;
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetRuneRegen(statFrame, unit)
    if ( unit ~= "player" ) then
        statFrame:Hide();
        return;
    end

    local _, class = Armory:UnitClass(unit);
    if ( class ~= "DEATHKNIGHT" ) then
        statFrame:Hide();
        return;
    end

    -- Note: change ArmoryLookup if not 1
    local _, regenRate = Armory:GetRuneCooldown(1); -- Assuming they are all the same for now
    regenRate = format(STAT_RUNE_REGEN_FORMAT, regenRate);
    PaperDollFrame_SetLabelAndText(statFrame, STAT_RUNE_REGEN, regenRate, false);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RUNE_REGEN).." "..regenRate..FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = STAT_RUNE_REGEN_TOOLTIP;
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetMeleeHaste(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
    local haste = Armory:GetMeleeHaste();
    if ( haste < 0 ) then
        haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
    else
        haste = "+"..format("%.2F%%", haste);
    end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HASTE));
    local text = _G[statFrame:GetName().."StatText"];
    text:SetText(haste);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HASTE) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;

    local _, class = Armory:UnitClass(unit);	
    statFrame.tooltip2 = _G["STAT_HASTE_MELEE_"..class.."_TOOLTIP"];
    if ( not statFrame.tooltip2 ) then
        statFrame.tooltip2 = STAT_HASTE_MELEE_TOOLTIP;
    end
    statFrame.tooltip2 = statFrame.tooltip2 .. format(STAT_HASTE_BASE_TOOLTIP, BreakUpLargeNumbers(Armory:GetCombatRating(CR_HASTE_MELEE)), Armory:GetCombatRatingBonus(CR_HASTE_MELEE));

    statFrame:Show();
end

function ArmoryPaperDollFrame_SetRangedHaste(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    local haste = Armory:GetRangedHaste();
    if ( haste < 0 ) then
        haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
    else
        haste = "+"..format("%.2F%%", haste);
    end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HASTE));
    local text = _G[statFrame:GetName().."StatText"];
    text:SetText(haste);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HASTE) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;

    local _, class = Armory:UnitClass(unit);	
    statFrame.tooltip2 = _G["STAT_HASTE_RANGED_"..class.."_TOOLTIP"];
    if ( not statFrame.tooltip2 ) then
        statFrame.tooltip2 = STAT_HASTE_RANGED_TOOLTIP;
    end
    statFrame.tooltip2 = statFrame.tooltip2 .. format(STAT_HASTE_BASE_TOOLTIP, BreakUpLargeNumbers(Armory:GetCombatRating(CR_HASTE_RANGED)), Armory:GetCombatRatingBonus(CR_HASTE_RANGED));

    statFrame:Show();
end

function ArmoryPaperDollFrame_SetSpellHaste(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
    local haste = Armory:UnitSpellHaste(unit);
    if ( haste < 0 ) then
        haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
    else
        haste = "+"..format("%.2F%%", haste);
    end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, SPELL_HASTE));
    local text = _G[statFrame:GetName().."StatText"];
    text:SetText(haste);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HASTE) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;

    local _, class = Armory:UnitClass(unit);	
    statFrame.tooltip2 = _G["STAT_HASTE_SPELL_"..class.."_TOOLTIP"];
    if ( not statFrame.tooltip2 ) then
        statFrame.tooltip2 = STAT_HASTE_SPELL_TOOLTIP;
    end
    statFrame.tooltip2 = statFrame.tooltip2 .. format(STAT_HASTE_BASE_TOOLTIP, BreakUpLargeNumbers(Armory:GetCombatRating(CR_HASTE_SPELL)), Armory:GetCombatRatingBonus(CR_HASTE_SPELL));

    statFrame:Show();
end

function ArmoryPaperDollFrame_SetManaRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MANA_REGEN));
    local text = _G[statFrame:GetName().."StatText"];
    if ( not Armory:UnitHasMana(unit) ) then
        text:SetText(NOT_APPLICABLE);
        statFrame.tooltip = nil;
        return;
    end

    local base, casting = Armory:GetManaRegen();
    -- All mana regen stats are displayed as mana/5 sec.
    base = BreakUpLargeNumbers(floor( base * 5.0 ));
    casting = floor( casting * 5.0 );
    text:SetText(base);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. MANA_REGEN .. FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = format(MANA_REGEN_TOOLTIP, base);
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetCombatManaRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MANA_REGEN_COMBAT));
    local text = _G[statFrame:GetName().."StatText"];
    if ( not Armory:UnitHasMana("player") ) then
        text:SetText(NOT_APPLICABLE);
        statFrame.tooltip = nil;
        return;
    end

    local base, casting = Armory:GetManaRegen();
    -- All mana regen stats are displayed as mana/5 sec.
    base = BreakUpLargeNumbers(floor( base * 5.0 ));
    casting = floor( casting * 5.0 );
    text:SetText(casting);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. MANA_REGEN_COMBAT .. FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = format(MANA_COMBAT_REGEN_TOOLTIP, casting);
    statFrame:Show();
end

function ArmoryExpertise_OnEnter(statFrame)
    GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
    local expertise = format("%.2F%%", statFrame.expertise);
    local offhandExpertise = format("%.2F%%", statFrame.offhandExpertise);
	local rangedExpertise = format("%.2F%%", statFrame.rangedExpertise);
	
	local category = statFrame:GetParent().Category;

    local expertiseDisplay, expertisePercentDisplay;
	if ( category == "MELEE" and Armory:IsDualWielding() ) then
		expertiseDisplay = expertise.." / "..offhandExpertise;
	elseif ( category == "RANGED" ) then
		expertiseDisplay = rangedExpertise;
    else
        expertiseDisplay = expertise;
    end
	
	local expertiseTooltip;
	if ( category == "MELEE" ) then
		expertiseTooltip = CR_EXPERTISE_TOOLTIP;
	else
		expertiseTooltip = CR_RANGED_EXPERTISE_TOOLTIP;
	end

    GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G["COMBAT_RATING_NAME"..CR_EXPERTISE]).." "..expertiseDisplay..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine(format(expertiseTooltip, expertiseDisplay, BreakUpLargeNumbers(statFrame.rating), statFrame.bonus), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
    GameTooltip:AddLine(" ");

    -- Dodge chance
    GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, DODGE_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
    local playerLevel = Armory:UnitLevel("player");
    for i = 0, 3 do
        local mainhandDodge, offhandDodge, rangedDodge = ArmoryGetEnemyDodgeChance(i);
        mainhandDodge = format("%.2F%%", mainhandDodge);
        offhandDodge = format("%.2F%%", offhandDodge);
        rangedDodge = format("%.2F%%", rangedDodge);
        local level = playerLevel + i;
        if ( i == 3 ) then
            level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
        end
        local dodgeDisplay;
        if ( category == "MELEE" and Armory:IsDualWielding() and mainhandDodge ~= offhandDodge ) then
            dodgeDisplay = mainhandDodge.." / "..offhandDodge;
		elseif ( category == "RANGED" ) then
			dodgeDisplay = rangedDodge.."  ";
        else
            dodgeDisplay = mainhandDodge.."  ";
        end
        GameTooltip:AddDoubleLine("      "..level, dodgeDisplay.."  ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
    end

    -- Parry chance
    if ( category == "MELEE" ) then
		GameTooltip:AddLine(" ");
		GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, PARRY_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		local playerLevel = Armory:UnitLevel("player");
		for i = 0, 3 do
			local mainhandParry, offhandParry = ArmoryGetEnemyParryChance(i);
			mainhandParry = format("%.2F%%", mainhandParry);
			offhandParry = format("%.2F%%", offhandParry);
			local level = playerLevel + i;
			if ( i == 3 ) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
			local parryDisplay;
			if ( Armory:IsDualWielding() and mainhandParry ~= offhandParry ) then
				parryDisplay = mainhandParry.." / "..offhandParry;
			else
				parryDisplay = mainhandParry.."  ";
			end
			GameTooltip:AddDoubleLine("      "..level, parryDisplay.."  ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	end
	
    GameTooltip:Show();
end

function ArmoryPaperDollFrame_SetExpertise(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local category = statFrame:GetParent().Category;

    local expertise, offhandExpertise, rangedExpertise = Armory:GetExpertise();
    statFrame.expertise = expertise;
    statFrame.offhandExpertise = offhandExpertise;
    statFrame.rangedExpertise = rangedExpertise;
    statFrame.rating = Armory:GetCombatRating(CR_EXPERTISE);
    statFrame.bonus = Armory:GetCombatRatingBonus(CR_EXPERTISE);
	expertise = format("%.2F%%", expertise);
	offhandExpertise = format("%.2F%%", offhandExpertise);
	rangedExpertise = format("%.2F%%", rangedExpertise);
    local speed, offhandSpeed = Armory:UnitAttackSpeed(unit);
    local text;
    if ( category == "MELEE" and offhandSpeed ) then
        text = expertise.." / "..offhandExpertise;
	elseif ( category == "RANGED" ) then
        text = rangedExpertise;
    else
        text = expertise;
    end
    PaperDollFrame_SetLabelAndText(statFrame, STAT_EXPERTISE, text);
    statFrame:SetScript("OnEnter", ArmoryExpertise_OnEnter);
    statFrame:Show();
end

function ArmoryMastery_OnEnter(statFrame)
    GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");

    local title = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_MASTERY).." "..format("%.2F%%", statFrame.mastery)..FONT_COLOR_CODE_CLOSE;
    if ( statFrame.bonus > 0 ) then
        title = title..HIGHLIGHT_FONT_COLOR_CODE.." ("..format("%.2F%%", statFrame.mastery - statFrame.bonus)..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..format("%.2F%%", statFrame.bonus)..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..")";
    end
    GameTooltip:SetText(title);

    if ( statFrame.primaryTalentTree ) then
        if ( statFrame.masterySpell ) then
            GameTooltip:AddSpellByID(statFrame.masterySpell);
        end
        if ( statFrame.masterySpell2 ) then
            GameTooltip:AddLine(" ");
            GameTooltip:AddSpellByID(statFrame.masterySpell2);
        end
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine(format(STAT_MASTERY_TOOLTIP, statFrame.rating, statFrame.bonus), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
    else
        GameTooltip:AddLine(format(STAT_MASTERY_TOOLTIP, statFrame.rating, statFrame.bonus), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine(STAT_MASTERY_TOOLTIP_NO_TALENT_SPEC, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, true);
    end
    GameTooltip:Show();
end

function ArmoryPaperDollFrame_SetMastery(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
    if ( Armory:UnitLevel("player") < SHOW_MASTERY_LEVEL ) then
        statFrame:Hide();
        return;
    end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_MASTERY));
    local text = _G[statFrame:GetName().."StatText"];
    local mastery, bonusCoef = Armory:GetMasteryEffect();
    local primaryTalentTree = Armory:GetSpecialization();
    statFrame.mastery = mastery;
    statFrame.rating = Armory:GetCombatRating(CR_MASTERY);
    statFrame.bonus = Armory:GetCombatRatingBonus(CR_MASTERY) * bonusCoef;
    statFrame.primaryTalentTree = primaryTalentTree;
    if ( masteryKnown and primaryTalentTree ) then
        statFrame.masterySpell, statFrame.masterySpell2 = Armory:GetSpecializationMasterySpells();
    end
    statFrame:SetScript("OnEnter", ArmoryMastery_OnEnter);
    mastery = format("%.2F%%", mastery);
    text:SetText(mastery);
    statFrame:Show();
end

function ArmoryPaperDollFrame_SetItemLevel(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_AVERAGE_ITEM_LEVEL));
    local text = _G[statFrame:GetName().."StatText"];
    local avgItemLevel, avgItemLevelEquipped = Armory:GetAverageItemLevel();
    if ( avgItemLevel ) then
        avgItemLevel = floor(avgItemLevel);
        statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_AVERAGE_ITEM_LEVEL).." "..avgItemLevel;
        if ( avgItemLevelEquipped ) then
            avgItemLevelEquipped = floor(avgItemLevelEquipped);
            text:SetText(avgItemLevelEquipped .. " / " .. avgItemLevel);
            if ( avgItemLevelEquipped ~= avgItemLevel ) then
                statFrame.tooltip = statFrame.tooltip .. "  " .. format(STAT_AVERAGE_ITEM_LEVEL_EQUIPPED, avgItemLevelEquipped);
            end
        else
            text:SetText(avgItemLevel);
        end
        statFrame.tooltip = statFrame.tooltip .. FONT_COLOR_CODE_CLOSE;
        statFrame.tooltip2 = STAT_AVERAGE_ITEM_LEVEL_TOOLTIP;
    else
        statFrame:Hide();
    end
end

function ArmoryMovementSpeed_OnEnter(statFrame)
    GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
    GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_MOVEMENT_SPEED).." "..format("%d%%", statFrame.speed+0.5)..FONT_COLOR_CODE_CLOSE);

    GameTooltip:AddLine(format(STAT_MOVEMENT_GROUND_TOOLTIP, statFrame.runSpeed + 0.5));
    if (statFrame.unit ~= "pet") then
        GameTooltip:AddLine(format(STAT_MOVEMENT_FLIGHT_TOOLTIP, statFrame.flightSpeed + 0.5));
    end
    GameTooltip:AddLine(format(STAT_MOVEMENT_SWIM_TOOLTIP, statFrame.swimSpeed + 0.5));
    GameTooltip:Show();

    statFrame.UpdateTooltip = ArmoryMovementSpeed_OnEnter;
end

function ArmoryMovementSpeed_OnUpdate(statFrame, elapsedTime)
    local unit = statFrame.unit;
    local _, runSpeed, flightSpeed, swimSpeed = Armory:GetUnitSpeed(unit);
    local swimming = Armory:IsSwimming(unit);
    local flying = Armory:IsFlying(unit);
    local falling = Armory:IsFalling(unit);
    if ( not runSpeed ) then
        statFrame:Hide();
        return;
    end
    
    runSpeed = runSpeed / BASE_MOVEMENT_SPEED * 100;
    flightSpeed = flightSpeed / BASE_MOVEMENT_SPEED * 100;

    -- Pets seem to always actually use run speed
    if ( unit == "pet" ) then
        swimSpeed = runSpeed;
    else
        swimSpeed = swimSpeed / BASE_MOVEMENT_SPEED * 100;
    end

    -- Determine whether to display running, flying, or swimming speed
    local speed = runSpeed;
    if ( swimming ) then
        speed = swimSpeed;
    elseif ( flying ) then
        speed = flightSpeed;
    end

    -- Hack so that your speed doesn't appear to change when jumping out of the water
    if ( falling ) then
        if ( statFrame.wasSwimming ) then
            speed = swimSpeed;
        end
    else
        statFrame.wasSwimming = swimming;
    end

    statFrame.Value:SetFormattedText("%d%%", speed + 0.5);
    statFrame.speed = speed;
    statFrame.runSpeed = runSpeed;
    statFrame.flightSpeed = flightSpeed;
    statFrame.swimSpeed = swimSpeed;
end

function ArmoryPaperDollFrame_SetMovementSpeed(statFrame, unit)
    statFrame.Label:SetText(format(STAT_FORMAT, STAT_MOVEMENT_SPEED));

    statFrame.wasSwimming = nil;
    statFrame.unit = unit;
    ArmoryMovementSpeed_OnUpdate(statFrame);

    statFrame:SetScript("OnEnter", ArmoryMovementSpeed_OnEnter);
    statFrame:SetScript("OnUpdate", ArmoryMovementSpeed_OnUpdate);
end

function ArmoryCharacterSpellBonusDamage_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, self.tooltip).." "..BreakUpLargeNumbers(self.minModifier)..FONT_COLOR_CODE_CLOSE);

    for i = 2, MAX_SPELL_SCHOOLS do
        if ( self.bonusDamage and self.bonusDamage[i] ~= self.minModifier ) then
            GameTooltip:AddLine(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G["DAMAGE_SCHOOL"..i]).." "..self.bonusDamage[i]..FONT_COLOR_CODE_CLOSE);
            GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..i);
        end
    end

    GameTooltip:AddLine(self.tooltip2);

    if (self.bonusDamage and self.unit == "player") then
        local petStr, damage;
        if ( self.bonusDamage[6] == self.minModifier and self.bonusDamage[3] == self.minModifier ) then
            petStr = PET_BONUS_TOOLTIP_WARLOCK_SPELLDMG;
            damage = self.minModifier;
        elseif ( self.bonusDamage[6] > self.bonusDamage[3] ) then
            petStr = PET_BONUS_TOOLTIP_WARLOCK_SPELLDMG_SHADOW;
            damage = self.bonusDamage[6];
        else
            petStr = PET_BONUS_TOOLTIP_WARLOCK_SPELLDMG_FIRE;
            damage = self.bonusDamage[3];
        end

        local petBonusAP = Armory:ComputePetBonus("PET_BONUS_SPELLDMG_TO_AP", damage);
        local petBonusDmg = Armory:ComputePetBonus("PET_BONUS_SPELLDMG_TO_SPELLDMG", damage);
        if ( petBonusAP > 0 or petBonusDmg > 0 ) then
            GameTooltip:AddLine(format(petStr, petBonusAP, petBonusDmg), nil, nil, nil, 1 );
        end
    end
    GameTooltip:Show();
end

function ArmoryCharacterSpellCritChance_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, SPELL_CRIT_CHANCE).." "..self.minCrit..FONT_COLOR_CODE_CLOSE);
    local spellCrit;
    for i = 2, MAX_SPELL_SCHOOLS do
        spellCrit = format("%.2F%%", self.spellCrit[i]);
        if ( spellCrit ~= self.minCrit ) then
            GameTooltip:AddDoubleLine(_G["DAMAGE_SCHOOL"..i], spellCrit, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
            GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..i);
        end
    end
    GameTooltip:AddLine(format(CR_CRIT_SPELL_TOOLTIP, BreakUpLargeNumbers(self.rating), self.bonus));
    GameTooltip:Show();
end

function ArmoryPaperDollFrame_UpdateStatCategory(category, suffix)
    local overlay = suffix ~= nil;
    if ( not suffix ) then
        suffix = "";
    end
    
    local categoryInfo = PAPERDOLL_STATCATEGORIES[category];
    if ( not categoryInfo ) then
        return;
    end
    
    local parentFrame = _G["ArmoryAttributes"..suffix.."Frame"];
    parentFrame.Category = category;
     
    local numVisible = 0;
    for index, stat in next, categoryInfo.stats do
        local statFrame = _G["ArmoryAttributes"..suffix.."FramePlayerStat"..numVisible+1];
        local statInfo;
        if ( overlay ) then
            statInfo = PAPERDOLL_STATINFO[stat];
        else
            statInfo = ARMORY_PAPERDOLL_STATINFO[stat];
        end
        statFrame:Show();
        -- Reset tooltip script in case it's been changed
        statFrame:SetScript("OnEnter", PaperDollStatTooltip);
        statFrame.tooltip = nil;
        statFrame.tooltip2 = nil;
        statFrame.UpdateTooltip = nil;
        statFrame:SetScript("OnUpdate", nil);
        if ( statInfo ) then
            statInfo.updateFunc(statFrame, "player");
        end
        if ( statFrame:IsShown() ) then
            numVisible = numVisible + 1;
            -- Update Tooltip
            if ( GameTooltip:GetOwner() == statFrame ) then
                statFrame:GetScript("OnEnter")(statFrame);
            end
        end
    end
    
    if ( category == "GENERAL" and overlay and PersonalGearScore ) then
        local text = PersonalGearScore:GetText();
        if ( text ) then
            local r, g, b = PersonalGearScore:GetTextColor()
            local score = Armory:HexColor(r, g, b)..text:match("(%d+)");
            local statFrame = _G["ArmoryAttributes"..suffix.."FramePlayerStat"..numVisible+1];
            
            _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, "GearScore"));
            _G[statFrame:GetName().."StatText"]:SetText(score);
            
            statFrame:Show();
            statFrame:SetScript("OnEnter", PaperDollStatTooltip);
            statFrame.tooltip = nil;
            statFrame.tooltip2 = nil;

            numVisible = numVisible + 1;
        end
    end
    
    local index = 1;
    while ( _G["ArmoryAttributes"..suffix.."FramePlayerStat"..index] ) do
        local statFrame = _G["ArmoryAttributes"..suffix.."FramePlayerStat"..index];
        if ( index <= numVisible ) then
            if ( not statFrame.Bg ) then
                statFrame.Bg = statFrame:CreateTexture(statFrame:GetName().."Bg", "BACKGROUND");
                statFrame.Bg:SetPoint("LEFT", "ArmoryAttributes"..suffix.."Frame", "LEFT", 2, 0);
                statFrame.Bg:SetPoint("RIGHT", "ArmoryAttributes"..suffix.."Frame", "RIGHT", -2, 0);
                statFrame.Bg:SetPoint("TOP");
                statFrame.Bg:SetPoint("BOTTOM");
                statFrame.Bg:SetTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b);
                statFrame.Bg:SetAlpha(0.1);
            end
            if ( index % 2 == 0 ) then
                statFrame.Bg:Show();
            else
                statFrame.Bg:Hide();
            end
        else
            statFrame:Hide();
        end
        index = index + 1;
    end
end

function ArmoryInitializePaperDollStats()
    for index, statInfo in next, ARMORY_PAPERDOLL_STATINFO do
        statInfo.updateFunc(ArmoryAttributesFrameDummyStat, "player");
    end
end

function ArmoryPaperDollFrame_SetStatDropDown()
    local _, classFileName = Armory:UnitClass("player");
    classFileName = strupper(classFileName);
    ARMORY_PLAYERSTAT_DROPDOWN_SELECTION = "ATTRIBUTES";
    if ( classFileName == "MAGE" or classFileName == "PRIEST" or classFileName == "WARLOCK" or classFileName == "DRUID" ) then
        ARMORY_PLAYERSTAT_DROPDOWN_SELECTION = "SPELL";
    elseif ( classFileName == "HUNTER" ) then
        ARMORY_PLAYERSTAT_DROPDOWN_SELECTION = "RANGED";
    else
        ARMORY_PLAYERSTAT_DROPDOWN_SELECTION = "MELEE";
    end
end

function ArmoryPaperDollFrame_OnLoad(self)
    self:RegisterEvent("VARIABLES_LOADED");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("UNIT_LEVEL");
    self:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
    self:RegisterEvent("UNIT_ATTACK_POWER");
    self:RegisterEvent("UNIT_RANGEDDAMAGE");
    self:RegisterEvent("UNIT_ATTACK");
    self:RegisterEvent("UNIT_SPELL_HASTE");
    self:RegisterEvent("UNIT_RESISTANCES");
    self:RegisterEvent("UNIT_STATS");
    self:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
    self:RegisterEvent("PLAYER_GUILD_UPDATE");
    self:RegisterEvent("COMBAT_RATING_UPDATE");
    self:RegisterEvent("MASTERY_UPDATE");
    self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
    self:RegisterEvent("SOCKET_INFO_UPDATE");
    self:RegisterEvent("ZONE_CHANGED");
    self:RegisterEvent("ZONE_CHANGED_INDOORS");
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    self:RegisterEvent("PLAYER_CONTROL_LOST");
    self:RegisterEvent("PLAYER_CONTROL_GAINED");
    self:RegisterEvent("PLAYER_XP_UPDATE");
    self:RegisterEvent("UPDATE_EXHAUSTION");
    self:RegisterEvent("SKILL_LINES_CHANGED");
    self:RegisterEvent("UPDATE_FACTION");
    self:RegisterEvent("EQUIPMENT_SETS_CHANGED");
    self:RegisterEvent("PLAYER_AVG_ITEM_LEVEL_READY");
	self:RegisterUnitEvent("UNIT_DAMAGE", "player");
	self:RegisterUnitEvent("UNIT_ATTACK_SPEED", "player");
	self:RegisterUnitEvent("UNIT_MAXHEALTH", "player");
	self:RegisterUnitEvent("UNIT_AURA", "player");
	self:RegisterEvent("SPELL_POWER_CHANGED");

    ARMORY_PLAYERSTAT_DROPDOWN_SELECTION = nil;

    ArmoryPaperDollFrame_UpdateVersion();
end

function ArmoryPaperDollFrame_OnEvent(self, event, unit)
    if ( event == "VARIABLES_LOADED" ) then
        -- Set defaults if no settings for the dropdowns
        if ( not ARMORY_PLAYERSTAT_DROPDOWN_SELECTION ) then
            ArmoryPaperDollFrame_SetStatDropDown();
        end
    elseif ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        -- Wait for data...
        Armory:ExecuteConditional(ArmoryPaperDollFrame_HasData, ArmoryPaperDollFrame_Update);
    end

    if ( unit == "player" ) then
        if ( event == "UNIT_LEVEL" or event == "PLAYER_XP_UPDATE" or event == "UPDATE_EXHAUSTION" ) then
            Armory:Execute(ArmoryPaperDollFrame_SetLevel);
        elseif ( event == "UNIT_DAMAGE" or 
                 event == "UNIT_ATTACK_SPEED" or 
                 event == "UNIT_RANGEDDAMAGE" or 
                 event == "UNIT_ATTACK" or 
                 event == "UNIT_STATS" or 
                 event == "UNIT_RANGED_ATTACK_POWER" or 
                 event == "UNIT_SPELL_HASTE" or 
                 event == "UNIT_MAXHEALTH" or
                 event == "UNIT_AURA" ) then
            Armory:Execute(ArmoryPaperDollFrame_UpdateStats);
        elseif ( event == "UNIT_RESISTANCES" ) then
            Armory:Execute(ArmoryPaperDollFrame_UpdateStats);
        elseif ( event == "PLAYER_GUILD_UPDATE" ) then
            Armory:Execute(ArmoryPaperDollFrame_SetGuild);
        end
    end

    if ( event == "COMBAT_RATING_UPDATE" or event == "MASTERY_UPDATE" or event == "PLAYER_AVG_ITEM_LEVEL_READY" or event == "PLAYER_DAMAGE_DONE_MODS" or event == "SPELL_POWER_CHANGED" ) then
        Armory:Execute(ArmoryPaperDollFrame_UpdateStats);
    elseif ( event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA" ) then
        Armory:Execute(ArmoryPaperDollFrame_SetZone);
    elseif ( event == "PLAYER_CONTROL_LOST" ) then
        self:UnregisterEvent("ZONE_CHANGED");
        self:UnregisterEvent("ZONE_CHANGED_INDOORS");
    elseif ( event == "PLAYER_CONTROL_GAINED" ) then
        self:RegisterEvent("ZONE_CHANGED");
        self:RegisterEvent("ZONE_CHANGED_INDOORS");
        Armory:Execute(ArmoryPaperDollFrame_SetZone);
    elseif ( (event == "UNIT_LEVEL" and unit == "player") or event == "SKILL_LINES_CHANGED" or event == "UPDATE_FACTION" ) then
        Armory:Execute(ArmoryPaperDollFrame_UpdateEquippable);
    elseif ( event == "EQUIPMENT_SETS_CHANGED" ) then
        Armory:Execute(ArmoryGearSets_Update);
    elseif ( event == "PLAYER_EQUIPMENT_CHANGED" or event == "SOCKET_INFO_UPDATE" ) then
        Armory:Execute(ArmoryPaperDollFrame_UpdateInventory);
    end
end

function ArmoryPaperDollFrame_HasData()
    local unit = "player"; 
    return UnitLevel(unit) and UnitRace(unit) and UnitClass(unit);
end

function ArmoryPaperDollFrame_OnShow(self)
    ArmoryPaperDollFrame_Update();
    if ( Armory:GetNumEquipmentSets() > 0 ) then
        ArmoryGearSetToggleButton:Show();
    else
        ArmoryGearSetToggleButton:Hide();
    end
    ArmoryGearSetFrame:Hide();
end

function ArmoryPaperDollFrame_UpdateStats()
    ArmoryInitializePaperDollStats();
    ArmoryPaperDollFrame_SetStatDropDown();
    ArmoryDropDownMenu_SetSelectedValue(ArmoryAttributesFramePlayerStatDropDown, ARMORY_PLAYERSTAT_DROPDOWN_SELECTION);
    ArmoryPaperDollFrame_UpdateStatCategory(ARMORY_PLAYERSTAT_DROPDOWN_SELECTION);    
end

function ArmoryPaperDollFrame_UpdateSlot(frame)
    Armory:SetInventoryItemInfo(frame:GetID());
    ArmoryPaperDollItemSlotButton_Update(frame);
end

function ArmoryPaperDollFrame_UpdateInventory()
    ArmoryPaperDollFrame_UpdateSlot(ArmoryHeadSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryNeckSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryShoulderSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryBackSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryChestSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryShirtSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryTabardSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryWristSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryHandsSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryWaistSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryLegsSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryFeetSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryFinger0Slot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryFinger1Slot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryTrinket0Slot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryTrinket1Slot);
    ArmoryPaperDollFrame_UpdateSlot(ArmoryMainHandSlot);
    ArmoryPaperDollFrame_UpdateSlot(ArmorySecondaryHandSlot);
    
    ArmoryPaperDoll_UpdateSockets();
    if ( Armory:GetConfigUseOverlay() ) then
        ArmoryPaperDoll_UpdateSockets(1);
    end
    
    Armory.hasEquipment = true;
    Armory_EQC_Refresh();
end

function ArmoryPaperDollFrame_UpdateTalent(overlay)
	local specialism, role, parent, currentSpec;
	
	if ( overlay ) then
        parent = "ArmoryPaperDollTalentOverlay";
		currentSpec = GetSpecialization();
		if ( currentSpec ) then
			_, specialism, _, _, _, role = GetSpecializationInfo(currentSpec);
		end
	else
		parent = "ArmoryPaperDollTalent";
		currentSpec = Armory:GetSpecialization();
		if ( currentSpec ) then
			_, specialism, _, _, _, role = Armory:GetSpecializationInfo(currentSpec);
		end
	end

	if ( role ) then
		_G[parent.."ButtonIcon"]:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES");
		_G[parent.."ButtonIcon"]:SetTexCoord(GetTexCoordsForRole(role));
	else
		SetPortraitToTexture(_G[parent.."ButtonIcon"], "Interface\\Icons\\Ability_Marksmanship");
	end
	_G[parent.."Text"]:SetText(strupper(specialism or NONE));
end

local function UpdateSkillFrame(skillFrame, values)
    local label = _G[skillFrame:GetName().."Label"];
    local statusbar = _G[skillFrame:GetName().."Bar"];
    local bartext = _G[skillFrame:GetName().."BarText"];
    local icon = _G[skillFrame:GetName().."ButtonIcon"];

    if ( not values ) then
        skillFrame:Hide();
    else
        local skillName, skillRank, skillMaxRank, texture = unpack(values);

        SetPortraitToTexture(icon, texture or Armory:GetProfessionTexture(skillName));
        label:SetText(strupper(skillName));
        statusbar:SetMinMaxValues(0, skillMaxRank);
        statusbar:SetValue(skillRank);
        bartext:SetText(skillRank.." / "..skillMaxRank);
        skillFrame:Show();
    end
end

function ArmoryPaperDollFrame_UpdateSkills(overlay)
    if ( overlay ) then
        local prof1, prof2 = GetProfessions();
        local name, texture, rank, maxRank;
        if ( not (prof1 and prof2) ) then
            UpdateSkillFrame(ArmoryPaperDollTradeSkillOverlayFrame1, nil);
            UpdateSkillFrame(ArmoryPaperDollTradeSkillOverlayFrame2, nil);
        elseif ( prof1 and prof2 ) then
            name, texture, rank, maxRank = GetProfessionInfo(prof1);
            UpdateSkillFrame(ArmoryPaperDollTradeSkillOverlayFrame1, {name, rank, maxRank, texture});
            name, texture, rank, maxRank = GetProfessionInfo(prof2);
            UpdateSkillFrame(ArmoryPaperDollTradeSkillOverlayFrame2, {name, rank, maxRank, texture});
        else
            name, texture, rank, maxRank = GetProfessionInfo(prof1 or prof2);
            UpdateSkillFrame(ArmoryPaperDollTradeSkillOverlayFrame1, {name, rank, maxRank, texture});
            UpdateSkillFrame(ArmoryPaperDollTradeSkillOverlayFrame2, nil);
        end
    else
        local skills = Armory:GetPrimaryTradeSkills();
        if ( #skills == 0 ) then
            UpdateSkillFrame(ArmoryPaperDollTradeSkillFrame1, nil);
            UpdateSkillFrame(ArmoryPaperDollTradeSkillFrame2, nil);
        elseif ( #skills == 1 ) then
            UpdateSkillFrame(ArmoryPaperDollTradeSkillFrame1, skills[1]);
            UpdateSkillFrame(ArmoryPaperDollTradeSkillFrame2, nil);
        else
            UpdateSkillFrame(ArmoryPaperDollTradeSkillFrame1, skills[1]);
            UpdateSkillFrame(ArmoryPaperDollTradeSkillFrame2, skills[2]);
        end
    end
end

function ArmoryPaperDollFrame_Update()
    ArmoryBuffFrame_Update("player");
    ArmoryPaperDollFrame_SetGuild();
    ArmoryPaperDollFrame_SetZone();
    ArmoryPaperDollFrame_SetLevel();
    ArmoryPaperDollFrame_UpdateStats();
    ArmoryPaperDollFrame_UpdateTalent();
    ArmoryPaperDollFrame_UpdateSkills();
    ArmoryPaperDollFrame_UpdateInventory();
    ArmoryGearSets_Update();
end

local alternatives = {};
function ArmoryAlternateSlotFrame_Show(parent, orientation, direction)
    if ( not Armory:GetConfigShowAltEquipment() ) then
        return;
    end

    local frame = ArmoryAlternateSlotFrame;
    local slotName = strsub(parent:GetName(), 7);
    local parentId = Armory:GetItemId(parent.link)
    local id, link, equipLoc, texture, itemId;
    local numItems = 0;
    
    table.wipe(alternatives);

    for i = 1, #ArmoryInventoryContainers do
        id = ArmoryInventoryContainers[i];
        if ( id > ARMORY_MAIL_CONTAINER ) then
            for index = 1, Armory:GetContainerNumSlots(id) do
                link = Armory:GetContainerItemLink(id, index);
                if ( link and IsEquippableItem(link) and (Armory:GetContainerItemCanEquip(id, index) or Armory:GetConfigShowUnequippable()) ) then
                    _, _, _, _, _, _, _, _, equipLoc, texture = GetItemInfo(link);
                    if ( ARMORY_SLOTINFO[equipLoc] and ARMORY_SLOTINFO[equipLoc] == slotName ) then
                        itemId = Armory:GetItemId(link);
                        if ( not alternatives[itemId] and itemId ~= parentId ) then
                            alternatives[itemId] = {link=link, texture=texture};
                            numItems = numItems + 1;
                        end
                    end
                end
            end
        end
    end

    if ( numItems == 0 ) then
        frame:Hide();
        return;
    end

    local length = min(numItems, ARMORY_MAX_ALTERNATE_SLOTS) * ARMORY_ALTERNATE_SLOT_SIZE;
    local xOffset = 12;
    local yOffset = 14;
    if ( direction == "LEFT" and parent:GetLeft() - length + xOffset < 0 ) then
        direction = "RIGHT";
    elseif ( direction == "RIGHT" and parent:GetRight() + length - xOffset > GetScreenWidth() ) then
        direction = "LEFT";
    elseif ( parent:GetBottom() - length + yOffset < 0 ) then
        direction = "UP";
    end
    local anchor = ARMORY_ANCHOR_SLOTINFO[direction];
    local row, column, x, y, button;
    local i = 0;
    for _, item in pairs(alternatives) do
        row = floor(i / ARMORY_MAX_ALTERNATE_SLOTS);
        column = i % ARMORY_MAX_ALTERNATE_SLOTS;
        if ( orientation == "VERTICAL" ) then
            x = row;
            y = column;
        else
            x = column;
            y = row;
        end
        i = i + 1;
        x = (8 + x * ARMORY_ALTERNATE_SLOT_SIZE) * anchor.xFactor;
        y = (8 + y * ARMORY_ALTERNATE_SLOT_SIZE) * anchor.yFactor;

        -- "^Armory.*Slot" pattern used by EQC
        button = _G["ArmoryAlternate"..i.."Slot"];
        if ( not button ) then
            button = CreateFrame("CheckButton", "ArmoryAlternate"..i.."Slot", frame, "ItemButtonTemplate");
            button:SetScript("OnClick", ArmoryAlternateSlotButton_OnClick);
            button:SetScript("OnEnter", ArmoryAlternateSlotButton_OnEnter);
            button:SetScript("OnLeave", ArmoryAlternateSlotButton_OnLeave);
        end
        SetItemButtonTexture(button, item.texture);
        Armory:SetItemLink(button, item.link);
        button.anchor = parent.anchor;
        button:SetID(parent:GetID());
        button:ClearAllPoints();
        button:SetPoint(anchor.point, frame, anchor.point, x, y);
        button:SetFrameLevel(frame:GetFrameLevel() + 1);
        button:Show();
    end
    table.wipe(alternatives);

    ArmoryAlternateSlotFrame_HideSlots(numItems + 1);

    frame:ClearAllPoints();
    frame:SetParent(parent);
    frame:SetFrameLevel(parent:GetFrameLevel() + 4);
    frame:SetScale(.85);
    frame:SetPoint(anchor.point, parent, anchor.relativeTo, anchor.x, anchor.y);
    if ( orientation == "VERTICAL" ) then
        frame:SetWidth((row + 1) * ARMORY_ALTERNATE_SLOT_SIZE + xOffset);
        frame:SetHeight(length + yOffset);
    else
        frame:SetWidth(length + xOffset);
        frame:SetHeight((row + 1) * ARMORY_ALTERNATE_SLOT_SIZE + yOffset);
    end
    frame.delay = 0;
    frame:Show();
end

function ArmoryAlternateSlotButton_OnClick(self)
    if ( IsModifiedClick("CHATLINK") and self.link ) then
        HandleModifiedItemClick(self.link);
    end
end

function ArmoryAlternateSlotButton_OnEnter(self)
    GameTooltip:SetOwner(self, self.anchor);
    Armory:SetInventoryItem("player", self:GetID(), false, false, self.link);
end

function ArmoryAlternateSlotButton_OnLeave(self)
    GameTooltip:Hide();
end

function ArmoryAlternateSlotFrame_OnUpdate(self, elapsed)
    local now = time();
    if ( self:IsVisible() and now >= self.delay ) then
        if ( self:IsMouseOver() or self:GetParent():IsMouseOver() ) then
            return;
        end
        self:Hide();
    end
    self.delay = now + 0.5;
end

function ArmoryAlternateSlotFrame_HideSlots(start)
    local i = start or 1;
      while ( _G["ArmoryAlternate"..i.."Slot"] ) do
        _G["ArmoryAlternate"..i.."Slot"]:Hide();
        i = i + 1;
    end
end

function ArmoryPaperDollFrame_UpdateEquippable()
    Armory:PrintDebug("UPDATE Equippable");
    Armory:UpdateInventoryEquippable();
end

function ArmoryGearSets_Update()
    Armory:UpdateGearSets();
end

function ArmoryPaperDollFrame_UpdateVersion(version)
    local major, minor, rel, lastVersion;
    local myVersion = Armory.version:match("^v?([%d%.]+)")

    if ( myVersion ) then
        ArmoryVersionText:SetText("v"..Armory.version:match("^v?(.+)"));

        if ( not ArmoryPaperDollFrame.lastVersion ) then
            major, minor, rel = strsplit(".", myVersion);
            ArmoryPaperDollFrame.lastVersion = major * 100 + (minor or 0) + (rel or 0) / 100;
        end

        if ( version ) then
            major, minor, rel = strsplit(".", version);
            if ( tonumber(major) ) then
                lastVersion = major * 100 + (minor or 0) + (rel or 0) / 100;
                if ( lastVersion > ArmoryPaperDollFrame.lastVersion ) then
                    ArmoryPaperDollFrame.lastVersion = lastVersion;
                    ArmoryNewVersionText:SetFormattedText("|cffff0000new!|r v|cffffffff%s", version);
                    ArmoryNewVersionText:Show();
                end
            end
        end
    else
        ArmoryVersionText:SetText(RED_FONT_COLOR_CODE..Armory.version..FONT_COLOR_CODE_CLOSE);
    end
end

function ArmoryGearSetFrame_OnLoad(self)
    self.title:SetText(EQUIPMENT_MANAGER);
    self.buttons = {};
    local name = self:GetName();
    local button;
    for i = 1, MAX_EQUIPMENT_SETS_PER_PLAYER do
        button = CreateFrame("CheckButton", "ArmoryGearSetButton" .. i, self, "ArmoryGearSetButtonTemplate");
        if ( i == 1 ) then
            button:SetPoint("TOPLEFT", self, "TOPLEFT", 16, -32);
        elseif ( mod(i, ARMORY_NUM_GEARSETS_PER_ROW) == 1 ) then
            button:SetPoint("TOP", "ArmoryGearSetButton"..(i-ARMORY_NUM_GEARSETS_PER_ROW), "BOTTOM", 0, -10);
        else
            button:SetPoint("LEFT", "ArmoryGearSetButton"..(i-1), "RIGHT", 13, 0);
        end
        button.icon = _G["ArmoryGearSetButton" .. i .. "Icon"];
        button.text = _G["ArmoryGearSetButton" .. i .. "Name"];
        table.insert(self.buttons, button);
    end
end

function ArmoryGearSetFrame_OnShow(self)
    ArmoryFrame:SetAttribute("UIPanelLayout-defined", nil);
    ArmoryGearSetToggleButton:SetButtonState("PUSHED", 1);
    ArmoryGearSetFrame_Update();
    PlaySound("igBackPackOpen");
    ArmoryGearSetFrame:Raise();
end

function ArmoryGearSetFrame_OnHide(self)
    ArmoryFrame:SetAttribute("UIPanelLayout-defined", nil);
    ArmoryGearSetToggleButton:SetButtonState("NORMAL");
    ArmoryPaperDollFrame_UpdateStats();
    PlaySound("igBackPackClose");
end

function ArmoryGearSetFrame_Update()
    local numSets = Armory:GetNumEquipmentSets();

    local dialog = ArmoryGearSetFrame;
    local buttons = dialog.buttons;

    local selectedName = dialog.selectedSetName;
    local name, texture, button;
    dialog.selectedSet = nil;
    for i = 1, numSets do
        name, texture = Armory:GetEquipmentSetInfo(i);
        button = buttons[i];
        button:Enable();
        button.name = name;
        button.text:SetText(name);
        button:SetID(i);
        if (texture) then
            button.icon:SetTexture(texture);
        else
            button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
        end
        if ( selectedName and button.name == selectedName ) then
            button:SetChecked(true);
            dialog.selectedSet = button;
        else
            button:SetChecked(false);
        end
    end
    if ( dialog.selectedSet ) then
        ArmoryGearSetFrameEquipSet:Enable();
    else
        ArmoryGearSetFrameEquipSet:Disable();
    end

    for i = numSets + 1, MAX_EQUIPMENT_SETS_PER_PLAYER do
        button = buttons[i];
        button:Disable();
        button:SetChecked(false);
        button.name = nil;
        button.text:SetText("");        
        button.icon:SetTexture("");
    end
end

function ArmoryGearSetFrameEquipSet_OnClick(self)
    local selectedSet = ArmoryGearSetFrame.selectedSet;
    if ( selectedSet ) then
        local name = selectedSet.name;
        if ( name and name ~= "" ) then
            PlaySound("igCharacterInfoTab");
            local items = Armory:GetEquipmentSetItemIDs(selectedSet:GetID(), gearSetItems);
            ArmoryPaperDollItemSlotButton_Update(ArmoryHeadSlot, items[1]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryNeckSlot, items[2]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryShoulderSlot, items[3]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryBackSlot, items[15]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryChestSlot, items[5]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryShirtSlot, items[4]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryTabardSlot, items[19]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryWristSlot, items[9]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryHandsSlot, items[10]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryWaistSlot, items[6]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryLegsSlot, items[7]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryFeetSlot, items[8]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryFinger0Slot, items[11]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryFinger1Slot, items[12]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryTrinket0Slot, items[13]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryTrinket1Slot, items[14]);
            ArmoryPaperDollItemSlotButton_Update(ArmoryMainHandSlot, items[16]);
            ArmoryPaperDollItemSlotButton_Update(ArmorySecondaryHandSlot, items[17]);
                
            ArmoryPaperDoll_UpdateSockets();
        end
    end
end

function ArmoryGearSetButton_OnClick(self, button, down)
    if ( self.name and self.name ~= "" ) then
        PlaySound("igMainMenuOptionCheckBoxOn");
        local dialog = ArmoryGearSetFrame;
        dialog.selectedSetName = self.name;
        ArmoryGearSetFrame_Update();
    else
        self:SetChecked(false);
    end
end

local gearSetLocations = {};
function ArmoryGearSetButton_OnEnter(self)
    if ( self.name and self.name ~= "" ) then
        GameTooltip_SetDefaultAnchor(GameTooltip, self);
        local items = Armory:GetEquipmentSetItemIDs(self:GetID(), gearSetItems);
        local locations = Armory:GetEquipmentSetLocations(self:GetID(), gearSetLocations);
        local locationType;
        local count, equipped, bags, missing = 0, 0, 0, 0;
        for i = EQUIPPED_FIRST, EQUIPPED_LAST do
            if ( items[i] ~= 0 ) then
                locationType = bit.rshift(locations[i], 16);
                if ( locationType == 16 ) then
                    equipped = equipped + 1;
                elseif ( locationType == 48 ) then
                    bags = bags + 1;
                else
                    missing = missing + 1;
                end
                count = count + 1;
            end
        end
        
        GameTooltip:AddDoubleLine(self.name, format("%d "..ITEMS, count), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b); 
        if ( equipped > 0 ) then
            GameTooltip:AddLine(format(ITEMS_EQUIPPED, equipped), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
        end
        if ( bags > 0 ) then
            GameTooltip:AddLine(format(ITEMS_IN_INVENTORY, bags), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
        end
        if ( missing > 0 ) then
            GameTooltip:AddLine(format(ITEMS_NOT_IN_INVENTORY, missing), RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
        end
        GameTooltip:Show();
    end
end

local function AddEmptySockets(frameName, slot, ...)
    local frame, socketType;
    for i = 1, select("#", ...) do
        socketType = select(i, ...);
        if ( socketType == "meta" ) then
            frame = _G[frameName.."Meta"];
        elseif ( socketType == "red" ) then
            frame = _G[frameName.."Red"];
        elseif ( socketType == "blue" ) then
            frame = _G[frameName.."Blue"];
        elseif ( socketType == "yellow" ) then
            frame = _G[frameName.."Yellow"];
        else
            frame = _G[frameName.."Other"];
        end
        frame.Icon:SetVertexColor(0.8, 0.1, 0.1);
        frame.count = frame.count + 1;
        frame.empty = frame.empty + 1;
        table.insert(frame.gems, {slot, RED_FONT_COLOR_CODE..EMPTY..FONT_COLOR_CODE_CLOSE});
    end
end

local socketTypes = { "Red", "Blue", "Yellow", "Meta", "Other" };
local gemColors = {};
function ArmoryPaperDoll_UpdateSockets(overlay)
    local suffix = overlay and "Overlay" or "";
    local frameName = "ArmorySockets"..suffix.."Frame";
    local frame;

    for _, socketType in ipairs(socketTypes) do
        frame = _G[frameName..socketType];
        frame.Icon:SetVertexColor(1.0, 1.0, 1.0);
        frame.count = 0;
        frame.empty = 0;
        frame.tooltip = nil;
        frame.tooltip2 = nil;
        frame.tooltipSubText = nil;
        if ( not frame.gems ) then
            frame.gems = {};
        else
            table.wipe(frame.gems);
        end
    end
    for color in pairs(gemColors) do
        gemColors[color] = 0;
    end

    local unit;
    if ( overlay ) then
        unit = "player";
    end
    
    local isMetaActive = Armory:IsMetaActive(unit);
    local emptySockets, gemInfo, gemName, gemColor, socketType;
    local link, tooltip, text;
    for slot = EQUIPPED_FIRST, EQUIPPED_LAST do
        if ( slot ~= ARMORY_SLOTID.ShirtSlot and slot ~= ARMORY_SLOTID.TabardSlot ) then
             _, _, _, link, _, _, emptySockets = Armory:GetInventoryItemInfo(slot, unit);
            
            if ( not link and slot == ARMORY_SLOTID.HeadSlot ) then
                _G[frameName.."Meta"].count = -1;
            end

            if ( Armory:GetItemGemString(link) ) then
                gemInfo = Armory:GetSocketInfo(link);
                for _, socket in ipairs(gemInfo) do
                    if ( socket.link ) then
                        gemName = Armory:GetColorFromLink(socket.link)..socket.gem..FONT_COLOR_CODE_CLOSE;
                        gemColor = (socket.gemColor or UNKNOWN);
                        _, _, socketType = strsplit("-", socket.texture);
                        if ( not socketType ) then
                            socketType = "Other";
                        end
                        frame = _G[frameName..socketType] or _G[frameName.."Other"];
                        frame.count = frame.count + 1;
                        if ( socketType == "Meta" ) then
                            tooltip = Armory:AllocateTooltip();
                            tooltip:SetHyperlink(socket.link);
                            text = Armory:Tooltip2String(tooltip);
                            Armory:ReleaseTooltip(tooltip);
                            for requirement in text:gmatch("(|c%x%x%x%x%x%x%x%x.-|r)") do 
                                frame.tooltipSubText = (frame.tooltipSubText and frame.tooltipSubText.."\n" or "")..requirement; 
                            end
                        else
                            gemName = gemColor.." : "..gemName;
                            if ( not gemColors[gemColor] ) then
                                gemColors[gemColor] = 1;
                            else
                                gemColors[gemColor] = gemColors[gemColor] + 1;
                            end
                        end
                        table.insert(frame.gems, {ARMORY_SLOT[slot], gemName});
                    end
                end
            end
            
            if ( emptySockets ) then
                AddEmptySockets(frameName, ARMORY_SLOT[slot], strsplit(":", emptySockets));
            end
        end
    end
    
    frame = _G[frameName.."Meta"];
    if ( isMetaActive or frame.count == -1 or frame.count + frame.empty == 0 ) then
        frame.Icon:SetVertexColor(1.0, 1.0, 1.0);
    elseif ( frame.empty == 0 ) then
        frame.Icon:SetVertexColor(0.8, 0.1, 0.1);
    end
    
    for color, count in pairs(gemColors) do
        if ( count > 0 ) then
            frame.tooltip2 = (frame.tooltip2 and frame.tooltip2..", " or "")..format("%s: %d", color, count);
        end
    end

    for _, socketType in ipairs(socketTypes) do
        frame = _G[frameName..socketType];
        if ( frame.count == -1 ) then
            frame.Value:SetText("X");
        else
            frame.Value:SetText(frame.count);
        end
        if ( socketType == "Other" ) then
            frame.tooltip = OTHER;
        else
            frame.tooltip = _G["EMPTY_SOCKET_"..strupper(socketType)];
        end
        if ( frame.count == -1 ) then
            frame.tooltip = frame.tooltip.." "..NOT_APPLICABLE;
        else
            frame.tooltip = frame.tooltip.." "..frame.count;
        end
    end
end

function ArmoryPaperDollSocketTooltip(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:SetText(self.tooltip, 1.0, 1.0, 1.0);
    if ( self.gems ) then
        for _, gemInfo in ipairs(self.gems) do
            GameTooltip:AddDoubleLine(gemInfo[2], gemInfo[1], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
        end
    end
    if ( self.tooltipSubText ) then
        GameTooltip:AddLine(self.tooltipSubText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
    end
    if ( self.tooltip2 ) then
	    GameTooltip:AddLine(self.tooltip2, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
    end
    GameTooltip:Show();
end

----------------------------------------------------------
-- Paper doll overlay
----------------------------------------------------------

local PaperDollFrame_QueuedUpdate_Orig = PaperDollFrame_QueuedUpdate;
function PaperDollFrame_QueuedUpdate(self, ...)
    if ( Armory:GetConfigUseOverlay() ) then
        ArmoryPaperDollOverlayFrame_UpdateStats();
	end
    return PaperDollFrame_QueuedUpdate_Orig(self, ...);
end

local CharacterFrame_Collapse_Orig = CharacterFrame_Collapse;
function CharacterFrame_Collapse(...)
    if ( Armory:GetConfigUseOverlay() ) then
        ArmoryPaperDollOverlayFrame:Show();
	end
    return CharacterFrame_Collapse_Orig(...);
end

local CharacterFrame_Expand_Orig = CharacterFrame_Expand;
function CharacterFrame_Expand(...)
    if ( Armory:GetConfigUseOverlay() ) then
        ArmoryPaperDollOverlayFrame:Hide();
	end
    return CharacterFrame_Expand_Orig(...);
end

function ArmoryPaperDollOverlayFrame_OnLoad(self)
    self:RegisterEvent("VARIABLES_LOADED");
    if ( PlayerTitlePickerFrame ) then -- Removed in Patch 4.1.0
        PlayerTitlePickerFrame:SetFrameLevel(self:GetFrameLevel() + 4);
    end
end

function ArmoryPaperDollOverlayFrame_OnEvent(self, event, ...)
    ArmoryPaperDollOverlayTopFrame_SetStatDropDown();
    ArmoryPaperDollOverlayBottomFrame_SetStatDropDown();
    ArmoryPaperDollCheckButton_Enable(not Armory:GetConfigHideCheckButton());
end
    
function ArmoryPaperDollOverlayFrame_OnShow(self)
    CharacterModelFrame:Hide();
    if ( PawnUI_InventoryPawnButton ) then
        PawnUI_InventoryPawnButton:SetFrameLevel(self:GetFrameLevel() + 1);
    end
    
    if ( Armory:GetConfigUseMaziel() ) then
        ArmoryPaperDollTalentOverlay:Hide();
        ArmoryPaperDollTradeSkillOverlay:Hide();
        ArmoryAttributesOverlayTopFrame:Show();
        ArmoryAttributesOverlayBottomFrame:ClearAllPoints()
        ArmoryAttributesOverlayBottomFrame:SetPoint("TOPLEFT", ArmoryAttributesOverlayTopFrame, "BOTTOMLEFT", 0, -24);
    else
        ArmoryPaperDollTalentOverlay:Show();
        ArmoryPaperDollTradeSkillOverlay:Show();
        ArmoryAttributesOverlayTopFrame:Hide();
        ArmoryAttributesOverlayBottomFrame:ClearAllPoints()
        ArmoryAttributesOverlayBottomFrame:SetPoint("TOPLEFT", ArmoryPaperDollTradeSkillOverlay, "BOTTOMLEFT", 1, -25);
    
        ArmoryPaperDollFrame_UpdateTalent(1);
        ArmoryPaperDollFrame_UpdateSkills(1);
    end
    ArmoryPaperDollOverlayFrame_UpdateStats();
    
    ArmoryPaperDoll_UpdateSockets(1);
end

function ArmoryPaperDollOverlayFrame_OnHide(self)
    CharacterModelFrame:Show();
end

function ArmoryPaperDollOverlayTopFrame_SetStatDropDown()
    if ( not ArmoryLocalSettings.playerStatTopDropdown ) then
        ArmoryLocalSettings.playerStatTopDropdown = "ATTRIBUTES";
    end
    ArmoryDropDownMenu_SetSelectedValue(ArmoryAttributesOverlayTopFramePlayerStatDropDown, ArmoryLocalSettings.playerStatTopDropdown);
end

function ArmoryAttributesOverlayTopFramePlayerStatDropDown_OnLoad(self)
    ArmoryDropDownMenu_SetWidth(self, 182);
    ArmoryDropDownMenu_JustifyText(self, "LEFT");
end

function ArmoryAttributesOverlayTopFramePlayerStatDropDown_OnShow(self)
    ArmoryDropDownMenu_Initialize(self, ArmoryAttributesOverlayTopFramePlayerStatDropDown_Initialize);
    ArmoryDropDownMenu_SetSelectedValue(self, ArmoryLocalSettings.playerStatTopDropdown);
end

function ArmoryAttributesOverlayTopFramePlayerStatDropDown_Initialize()
    -- Setup buttons
    local info = ArmoryDropDownMenu_CreateInfo();
    local checked;
    for i = 1, getn(ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS) do
        if ( ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS[i] == ArmoryLocalSettings.playerStatTopDropdown ) then
            checked = 1;
        else
            checked = nil;
        end
        info.text = _G["STAT_CATEGORY_"..ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS[i]];
        info.func = ArmoryAttributesOverlayTopFramePlayerStatDropDown_OnClick;
        info.value = ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS[i];
        info.checked = checked;
        info.owner = ARMORY_DROPDOWNMENU_OPEN_MENU;
        ArmoryDropDownMenu_AddButton(info);
    end
end

function ArmoryAttributesOverlayTopFramePlayerStatDropDown_OnClick(self)
    ArmoryDropDownMenu_SetSelectedValue(_G[self.owner], self.value);
    ArmoryLocalSettings.playerStatTopDropdown = self.value;
    ArmoryPaperDollFrame_UpdateStatCategory(self.value, "OverlayTop");
end

function ArmoryPaperDollOverlayBottomFrame_SetStatDropDown()
    local _, classFileName = UnitClass("player");
    classFileName = strupper(classFileName);
    if ( not ArmoryLocalSettings.playerStatBottomDropdown ) then
        ArmoryLocalSettings.playerStatBottomDropdown = "ATTRIBUTES";
        if ( classFileName == "MAGE" or classFileName == "PRIEST" or classFileName == "WARLOCK" or classFileName == "DRUID" ) then
            ArmoryLocalSettings.playerStatBottomDropdown = "SPELL";
        elseif ( classFileName == "HUNTER" ) then
            ArmoryLocalSettings.playerStatBottomDropdown = "RANGED";
        else
            ArmoryLocalSettings.playerStatBottomDropdown = "MELEE";
        end
    end
    ArmoryDropDownMenu_SetSelectedValue(ArmoryAttributesOverlayBottomFramePlayerStatDropDown, ArmoryLocalSettings.playerStatBottomDropdown);
end

function ArmoryAttributesOverlayBottomFramePlayerStatDropDown_OnLoad(self)
    ArmoryDropDownMenu_SetWidth(self, 212);
    ArmoryDropDownMenu_JustifyText(self, "LEFT");
end

function ArmoryAttributesOverlayBottomFramePlayerStatDropDown_OnShow(self)
    ArmoryDropDownMenu_Initialize(self, ArmoryAttributesOverlayBottomFramePlayerStatDropDown_Initialize);
    ArmoryDropDownMenu_SetSelectedValue(self, ArmoryLocalSettings.playerStatBottomDropdown);
end

function ArmoryAttributesOverlayBottomFramePlayerStatDropDown_Initialize()
    -- Setup buttons
    local info = ArmoryDropDownMenu_CreateInfo();
    local checked;
    for i = 1, getn(ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS) do
        if ( ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS[i] == ArmoryLocalSettings.playerStatBottomDropdown ) then
            checked = 1;
        else
            checked = nil;
        end
        info.text = _G["STAT_CATEGORY_"..ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS[i]];
        info.func = ArmoryAttributesOverlayBottomFramePlayerStatDropDown_OnClick;
        info.value = ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS[i];
        info.checked = checked;
        info.owner = ARMORY_DROPDOWNMENU_OPEN_MENU;
        ArmoryDropDownMenu_AddButton(info);
    end
end

function ArmoryAttributesOverlayBottomFramePlayerStatDropDown_OnClick(self)
    ArmoryDropDownMenu_SetSelectedValue(_G[self.owner], self.value);
    ArmoryLocalSettings.playerStatBottomDropdown = self.value;
    ArmoryPaperDollFrame_UpdateStatCategory(self.value, "OverlayBottom");
end

function ArmoryPaperDollOverlayFrame_UpdateStats()
    ArmoryPaperDollFrame_UpdateStatCategory(ArmoryLocalSettings.playerStatTopDropdown, "OverlayTop");
    ArmoryPaperDollFrame_UpdateStatCategory(ArmoryLocalSettings.playerStatBottomDropdown, "OverlayBottom");
end

function ArmoryPaperDollCheckButton_Enable(enable)
    if ( enable ) then
        ArmoryPaperDollOverlayFrameCheckButton:Show();
    else
        ArmoryPaperDollOverlayFrameCheckButton:Hide();
    end
end