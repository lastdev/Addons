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

local L = LibStub("AceLocale-3.0"):GetLocale("ArmoryGuildBank");

ARMORY_GUILDBANK_TITLE                      = L["ARMORY_GUILDBANK_TITLE"];
ARMORY_GUILDBANK_SUBTEXT                    = L["ARMORY_GUILDBANK_SUBTEXT"];

-- Key binding localization text
BINDING_HEADER_ARMORYGUILDBANK              = ARMORY_TITLE;
BINDING_NAME_ARMORYGUILDBANK_TOGGLE         = L["BINDING_NAME_ARMORYGUILDBANK_TOGGLE"];

ARMORY_GUILDBANK_NO_DATA                    = L["ARMORY_GUILDBANK_NO_DATA"];
ARMORY_GUILDBANK_ABORTING                   = L["ARMORY_GUILDBANK_ABORTING"];
ARMORY_GUILDBANK_NO_TABS                    = L["ARMORY_GUILDBANK_NO_TABS"];

ARMORY_CMD_GUILDBANK                        = L["ARMORY_CMD_GUILDBANK"];
ARMORY_CMD_GUILDBANK_TEXT                   = L["ARMORY_CMD_GUILDBANK_TEXT"];
ARMORY_CMD_GUILDBANK_MENUTEXT               = L["ARMORY_CMD_GUILDBANK_MENUTEXT"];
ARMORY_CMD_DELETE_GUILD                     = L["ARMORY_CMD_DELETE_GUILD"];
ARMORY_CMD_DELETE_GUILD_PARAMS_TEXT         = L["ARMORY_CMD_DELETE_GUILD_PARAMS_TEXT"];
ARMORY_CMD_DELETE_GUILD_TEXT                = L["ARMORY_CMD_DELETE_GUILD_TEXT"];
ARMORY_CMD_DELETE_GUILD_MSG                 = L["ARMORY_CMD_DELETE_GUILD_MSG"];
ARMORY_CMD_DELETE_GUILD_NOT_FOUND           = L["ARMORY_CMD_DELETE_GUILD_NOT_FOUND"];
ARMORY_CMD_SET_AGBITEMCOUNT                 = "agbsict";
ARMORY_CMD_SET_AGBITEMCOUNT_TEXT            = L["ARMORY_CMD_SET_AGBITEMCOUNT_TEXT"];
ARMORY_CMD_SET_AGBITEMCOUNT_MENUTEXT        = L["ARMORY_CMD_SET_AGBITEMCOUNT_MENUTEXT"];
ARMORY_CMD_SET_AGBITEMCOUNT_TOOLTIP         = L["ARMORY_CMD_SET_AGBITEMCOUNT_TOOLTIP"];
ARMORY_CMD_SET_AGBCOUNTMYGUILD              = "agbcmine";
ARMORY_CMD_SET_AGBCOUNTMYGUILD_TEXT         = L["ARMORY_CMD_SET_AGBCOUNTMYGUILD_TEXT"];
ARMORY_CMD_SET_AGBCOUNTMYGUILD_MENUTEXT     = L["ARMORY_CMD_SET_AGBCOUNTMYGUILD_MENUTEXT"];
ARMORY_CMD_SET_AGBCOUNTMYGUILD_TOOLTIP      = L["ARMORY_CMD_SET_AGBCOUNTMYGUILD_TOOLTIP"];
ARMORY_CMD_SET_AGBCOUNTALL                  = "agbcall";
ARMORY_CMD_SET_AGBCOUNTALL_TEXT             = L["ARMORY_CMD_SET_AGBCOUNTALL_TEXT"];
ARMORY_CMD_SET_AGBCOUNTALL_MENUTEXT         = L["ARMORY_CMD_SET_AGBCOUNTALL_MENUTEXT"];
ARMORY_CMD_SET_AGBCOUNTALL_TOOLTIP          = L["ARMORY_CMD_SET_AGBCOUNTALL_TOOLTIP"];
ARMORY_CMD_SET_AGBCOUNTXFACTION             = "agbcxf";
ARMORY_CMD_SET_AGBCOUNTXFACTION_TEXT        = L["ARMORY_CMD_SET_AGBCOUNTXFACTION_TEXT"];
ARMORY_CMD_SET_AGBCOUNTXFACTION_MENUTEXT    = L["ARMORY_CMD_SET_AGBCOUNTXFACTION_MENUTEXT"];
ARMORY_CMD_SET_AGBCOUNTXFACTION_TOOLTIP     = L["ARMORY_CMD_SET_AGBCOUNTXFACTION_TOOLTIP"];
ARMORY_CMD_SET_AGBUNICOLOR                  = "agbsuic";
ARMORY_CMD_SET_AGBUNICOLOR_TEXT             = L["ARMORY_CMD_SET_AGBUNICOLOR_TEXT"];
ARMORY_CMD_SET_AGBUNICOLOR_MENUTEXT         = L["ARMORY_CMD_SET_AGBUNICOLOR_MENUTEXT"];
ARMORY_CMD_SET_AGBUNICOLOR_TOOLTIP          = L["ARMORY_CMD_SET_AGBUNICOLOR_TOOLTIP"];
ARMORY_CMD_SET_AGBFIND                      = "agbfind";
ARMORY_CMD_SET_AGBFIND_TEXT                 = L["ARMORY_CMD_SET_AGBFIND_TEXT"];
ARMORY_CMD_SET_AGBFIND_MENUTEXT             = L["ARMORY_CMD_SET_AGBFIND_MENUTEXT"];
ARMORY_CMD_SET_AGBFIND_TOOLTIP              = L["ARMORY_CMD_SET_AGBFIND_TOOLTIP"];
ARMORY_CMD_SET_AGBINTEGRATE                 = "agbinteg";
ARMORY_CMD_SET_AGBINTEGRATE_TEXT            = L["ARMORY_CMD_SET_AGBINTEGRATE_TEXT"];
ARMORY_CMD_SET_AGBINTEGRATE_MENUTEXT        = L["ARMORY_CMD_SET_AGBINTEGRATE_MENUTEXT"];
ARMORY_CMD_SET_AGBINTEGRATE_TOOLTIP         = L["ARMORY_CMD_SET_AGBINTEGRATE_TOOLTIP"];
