--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 572 2013-01-04T15:34:54Z
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

local AGB = AGB;
local Armory = Armory;

function ArmoryGuildBankFrame_Register()
    ArmoryAddonMessageFrame_RegisterHandlers(ArmoryGuildBankFrame_CheckResponse, ArmoryGuildBankFrame_ProcessRequest);

    Armory.options["ARMORY_CMD_GUILDBANK"] = {
        type = "execute",
        run = function() ArmoryGuildBankFrame_Toggle() end
    };
    Armory.options["ARMORY_CMD_SET_AGBITEMCOUNT"] = {
        type = "toggle",
        set = function(value) AGB:SetConfigShowItemCount(value and value ~= "0"); end,
        get = function() return AGB:GetConfigShowItemCount(); end,
        default = true
    };
    Armory.options["ARMORY_CMD_SET_AGBCOUNTMYGUILD"] = {
        type = "toggle",
        set = function(value) AGB:SetConfigMyGuildItemCount(value and value ~= "0"); end,
        get = function() return AGB:GetConfigMyGuildItemCount(); end,
        default = false
    };
    Armory.options["ARMORY_CMD_SET_AGBCOUNTALL"] = {
        type = "toggle",
        set = function(value) AGB:SetConfigGlobalItemCount(value and value ~= "0"); end,
        get = function() return AGB:GetConfigGlobalItemCount(); end,
        default = false
    };
    Armory.options["ARMORY_CMD_SET_AGBCOUNTXFACTION"] = {
        type = "toggle",
        set = function(value) AGB:SetConfigCrossFactionItemCount(value and value ~= "0"); end,
        get = function() return AGB:GetConfigCrossFactionItemCount(); end,
        default = false
    };
    Armory.options["ARMORY_CMD_SET_AGBUNICOLOR"] = {
        type = "toggle",
        set = function(value) AGB:SetConfigUniItemCountColor(value and value ~= "0"); end,
        get = function() return AGB:GetConfigUniItemCountColor(); end,
        default = true
    };
    Armory.options["ARMORY_CMD_SET_AGBFIND"] = {
        type = "toggle",
        set = function(value) AGB:SetConfigIncludeInFind(value and value ~= "0"); end,
        get = function() return AGB:GetConfigIncludeInFind(); end,
        default = true
    };
    Armory.options["ARMORY_CMD_SET_AGBINTEGRATE"] = {
        type = "toggle",
        set = function(value) AGB:SetConfigIntegrate(value and value ~= "0"); end,
        get = function() return AGB:GetConfigIntegrate(); end,
        disabled = function() return not Armory:HasInventory() end,
        default = true
    };

    Armory:SetCommand("ARMORY_CMD_GUILDBANK", function(...) ArmoryGuildBankFrame_Toggle(...) end);
    Armory:SetCommand("ARMORY_CMD_DELETE_GUILD", function(...) Armory:ClearDb(...) end, "ARMORY_CMD_DELETE_CHAR");
    
    if ( ARMORYFRAME_MAINFRAMES ) then
        table.insert(ARMORYFRAME_MAINFRAMES, "ArmoryListGuildBankFrame");
        table.insert(ARMORYFRAME_MAINFRAMES, "ArmoryIconGuildBankFrame");
    end
end

function AGB:SetConfigShowItemCount(on)
    Armory:Setting("General", "HideAgbItemCount", not on);
end

function AGB:GetConfigShowItemCount()
    return not Armory:Setting("General", "HideAgbItemCount");
end

function AGB:SetConfigMyGuildItemCount(on)
    Armory:Setting("General", "AgbMyGuildItemCount", on);
end

function AGB:GetConfigMyGuildItemCount()
    return Armory:Setting("General", "AgbMyGuildItemCount");
end

function AGB:SetConfigGlobalItemCount(on)
    Armory:Setting("General", "AgbGlobalItemCount", on);
end

function AGB:GetConfigGlobalItemCount()
    return Armory:Setting("General", "AgbGlobalItemCount");
end

function AGB:SetConfigCrossFactionItemCount(on)
    Armory:Setting("General", "AgbCrossFactionItemCount", on);
end

function AGB:GetConfigCrossFactionItemCount()
    return Armory:Setting("General", "AgbCrossFactionItemCount");
end

function AGB:SetConfigIncludeInFind(on)
    Armory:Setting("General", "ExcludeAgbFind", not on);
end

function AGB:GetConfigIncludeInFind()
    return not Armory:Setting("General", "ExcludeAgbFind");
end

function AGB:SetConfigItemCountColor(r, g, b)
    Armory:Setting("General", "AgbItemCountColor", r, g, b);
end

function AGB:GetConfigItemCountColor(default)
    local r, g, b = Armory:Setting("General", "AgbItemCountColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(NORMAL_FONT_COLOR);
    end
    return r, g, b;
end

function AGB:SetConfigUniItemCountColor(on)
    Armory:Setting("General", "AgbOwnItemCountColor", not on);
end

function AGB:GetConfigUniItemCountColor()
    return not Armory:Setting("General", "AgbOwnItemCountColor");
end

function AGB:SetConfigIntegrate(on)
    Armory:Setting("General", "DetachAgb", not on);
end

function AGB:GetConfigIntegrate()
    return not Armory:Setting("General", "DetachAgb");
end

function AGB:SetIconViewMode(checked)
    Armory:Setting("General", "AgbIconView", checked);
end

function AGB:GetIconViewMode()
    return Armory:Setting("General", "AgbIconView") or nil;
end

