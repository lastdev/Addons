--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 508 2012-09-09T17:24:16Z
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

ARMORY_BUFFS_PER_ROW = 11;
ARMORY_BUFF_MAX_DISPLAY = 32;
ARMORY_DEBUFF_MAX_DISPLAY = 16;
ARMORY_BUFF_ROW_SPACING = 0;
ARMORY_BUFF_COL_SPACING = 2;

ARMORY_BUFF_ACTUAL_DISPLAY = 0;
ARMORY_DEBUFF_ACTUAL_DISPLAY = 0;

function  ArmoryBuffFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("UNIT_AURA");
end

function ArmoryBuffFrame_OnEvent(self, event, ...)
    local unit = ...;
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        ArmoryBuffFrame_UpdateAllBuffs();
    elseif ( unit == "player" or unit == "pet" ) then
        Armory:Execute(ArmoryBuffFrame_UpdateBuffs, unit);
    end
end

function ArmoryBuffFrame_UpdateAllBuffs()
    Armory:Execute(ArmoryBuffFrame_UpdateBuffs, "player");
    if ( HasPetUI() ) then
        Armory:Execute(ArmoryBuffFrame_UpdateBuffs, "pet");
    end
end

function ArmoryBuffFrame_UpdateBuffs(unit)
    Armory:SetBuffs(unit);
    ArmoryBuffFrame_Update(unit);
end

function ArmoryBuffFrame_Update(unit)
    if ( strlower(unit) == "pet" ) then
        if ( not ArmoryPetFrame:IsVisible() ) then
            return;
        end
    elseif ( not ArmoryPaperDollFrame:IsVisible() ) then
        return;
    end

    -- Handle Buffs
    ARMORY_BUFF_ACTUAL_DISPLAY = 0;
    for i = 1, ARMORY_BUFF_MAX_DISPLAY do
        if ( ArmoryAuraButton_Update("ArmoryBuffButton", i, "HELPFUL", unit) ) then
            ARMORY_BUFF_ACTUAL_DISPLAY = ARMORY_BUFF_ACTUAL_DISPLAY + 1;
        end
    end

    -- Handle debuffs
    ARMORY_DEBUFF_ACTUAL_DISPLAY = 0;
    for i = 1, ARMORY_DEBUFF_MAX_DISPLAY do
        if ( ArmoryAuraButton_Update("ArmoryDebuffButton", i, "HARMFUL", unit) ) then
            ARMORY_DEBUFF_ACTUAL_DISPLAY = ARMORY_DEBUFF_ACTUAL_DISPLAY + 1;
        end
    end
end

function ArmoryAuraButton_Update(buttonName, index, filter, unit)
    local name, rank, texture, count, debuffType, duration, expirationTime = Armory:UnitAura(unit, index, filter);

    local buffName = buttonName..index;
    local buff = _G[buffName];

    if ( not name ) then
        -- No buff so hide it if it exists
        if ( buff ) then
            buff:Hide();
        end
        return false;
    end
    
    local helpful = (filter == "HELPFUL");

    -- If button doesn't exist make it
    if ( not buff ) then
        if ( helpful ) then
            buff = CreateFrame("Button", buffName, ArmoryBuffFrame, "ArmoryBuffButtonTemplate");
        else
            buff = CreateFrame("Button", buffName, ArmoryBuffFrame, "ArmoryDebuffButtonTemplate");
        end
    end
    -- Setup Buff
    buff.namePrefix = buttonName;
    buff:SetID(index);
    buff.unit = unit;
    buff.filter = filter;
    buff:Show();

    -- Set filter-specific attributes
    if ( helpful ) then
        -- Anchor Buffs
        ArmoryBuffButton_UpdateAnchors(buttonName, index);
    else
        -- Anchor Debuffs
        ArmoryDebuffButton_UpdateAnchors(buttonName, index);
   
        -- Set color of debuff border based on dispel class.
        local debuffSlot = _G[buffName.."Border"];
        if ( debuffSlot ) then
            local color;
            if ( debuffType ) then
                color = DebuffTypeColor[debuffType];
            else
                color = DebuffTypeColor["none"];
            end
            debuffSlot:SetVertexColor(color.r, color.g, color.b);
        end
    end
    
    -- Set Texture
    local icon = _G[buffName.."Icon"];
    icon:SetTexture(texture);

    -- Set the number of applications of an aura
    local buffCount = _G[buffName.."Count"];
    if ( count > 1 ) then
        buffCount:SetText(count);
        buffCount:Show();
    else
        buffCount:Hide();
    end
    
    return true;
end

function ArmoryBuffButton_UpdateAnchors(buttonName, index)
    local buff = _G[buttonName..index];

    if ( (index > 1) and (mod(index, ARMORY_BUFFS_PER_ROW) == 1) ) then
        -- New row
        buff:SetPoint("BOTTOM", _G[buttonName..(index - ARMORY_BUFFS_PER_ROW)], "TOP", 0, -ARMORY_BUFF_ROW_SPACING);
    elseif ( index == 1 ) then
        buff:SetPoint("TOPRIGHT", ArmoryBuffFrame, "TOPRIGHT", 0, 0);
    else
        buff:SetPoint("RIGHT", _G[buttonName..(index - 1)], "LEFT", -ARMORY_BUFF_COL_SPACING, 0);
    end
end

function ArmoryDebuffButton_UpdateAnchors(buttonName, index)
    local rows = ceil(ARMORY_BUFF_ACTUAL_DISPLAY / ARMORY_BUFFS_PER_ROW);
    local buff = _G[buttonName..index];
    local buffHeight = ArmoryBuffFrame:GetHeight();

    -- Position debuffs
    if ( (index > 1) and (mod(index, ARMORY_BUFFS_PER_ROW) == 1) ) then
        -- New row
        buff:SetPoint("BOTTOM", _G[buttonName..(index - ARMORY_BUFFS_PER_ROW)], "TOP", 0, -ARMORY_BUFF_ROW_SPACING);
    elseif ( index == 1 ) then
        buff:SetPoint("TOPRIGHT", ArmoryBuffFrame, "TOPRIGHT", 0, rows * (ARMORY_BUFF_ROW_SPACING + buffHeight));
    else
        buff:SetPoint("RIGHT", _G[buttonName..(index - 1)], "LEFT", -ARMORY_BUFF_COL_SPACING, 0);
   end
end

function ArmoryBuffFrame_RemoveBuffs(unit)
    -- Remove Buffs
    for i=1, ARMORY_BUFF_MAX_DISPLAY do
        ArmoryBuffFrame_RemoveButton("ArmoryBuffButton", i, unit);
    end

    -- Remove debuffs
    for i=1, ARMORY_DEBUFF_MAX_DISPLAY do
        ArmoryBuffFrame_RemoveButton("ArmoryDebuffButton", i, unit);
    end
end

function ArmoryBuffFrame_RemoveButton(buttonName, index, unit)
    local buffName = buttonName..index;
    local buff = _G[buffName];

    if ( buff and buff.unit == unit ) then
        buff:Hide();
    end
end