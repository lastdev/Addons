--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 575 2013-01-09T23:30:53Z
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

Armory.sounds = {
    "AlarmClockWarning1",
    "AlarmClockWarning2",
    "AlarmClockWarning3",
    "GM_ChatWarning",
    "igCharacterInfoTab",
    "LFG_Denied",
    "ITEM_REPAIR",
    "RaidWarning"
};

Armory.options = {
    ARMORY_CMD_SET_ENABLED = {
        type = "toggle",
        set = function(value) Armory:SetConfigCharacterEnabled(value and value ~= "0"); end,
        get = function() return Armory:GetConfigCharacterEnabled(); end,
        default = true
    },
    ARMORY_CMD_SET_SCANONENTER = {
        type = "toggle",
        set = function(value) Armory:SetConfigScanOnEnter(value and value ~= "0", true); end,
        get = function() return Armory:GetConfigScanOnEnter(); end,
        default = false
    },
    ARMORY_CMD_SET_PAUSEINCOMBAT = {
        type = "toggle",
        set = function(value) Armory:SetConfigPauseWhileInCombat(value and value ~= "0"); end,
        get = function() return Armory:GetConfigPauseWhileInCombat(); end,
        default = true
    },
    ARMORY_CMD_SET_PAUSEININSTANCE = {
        type = "toggle",
        set = function(value) Armory:SetConfigRemainPausedInInstance(value and value ~= "0"); end,
        get = function() return Armory:GetConfigRemainPausedInInstance(); end,
        disabled = function() return not Armory:GetConfigPauseWhileInCombat(); end,
        default = false
    },
    ARMORY_CMD_SET_SEARCHALL = {
        type = "toggle",
        set = function(value) Armory:SetConfigSaveSearchAll(value and value ~= "0"); end,
        get = function() return Armory:GetConfigSaveSearchAll(); end,
        disabled = function() return not Armory:HasInventory(); end,
        default = false
    },
    ARMORY_CMD_SET_LASTVIEWED = {
        type = "toggle",
        set = function(value) Armory:SetConfigLastViewed(value and value ~= "0"); end,
        get = function() return Armory:GetConfigLastViewed(); end,
        default = false
    },
    ARMORY_CMD_SET_PERCHARACTER = {
        type = "toggle",
        set = function(value) Armory:SetConfigPerCharacter(value and value ~= "0"); end,
        get = function() return Armory:GetConfigPerCharacter(); end,
        default = false
    },
    ARMORY_CMD_SET_SHOWALTEQUIP = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowAltEquipment(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowAltEquipment(); end,
        disabled = function() return not Armory:HasInventory(); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWUNEQUIP = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowUnequippable(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowUnequippable(); end,
        disabled = function() return not (Armory:GetConfigShowAltEquipment() and Armory:HasInventory()); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWEQCTOOLTIPS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowEqcTooltips(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowEqcTooltips(); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWITEMCOUNT = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowItemCount(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowItemCount(); end,
        disabled = function() return not Armory:HasInventory(); end,
        default = true
    },
    ARMORY_CMD_SET_COUNTPERSLOT = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowItemCountPerSlot(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowItemCountPerSlot(); end,
        disabled = function() return not Armory:GetConfigShowItemCount(); end,
        default = false
    },
    ARMORY_CMD_SET_COUNTALL = {
        type = "toggle",
        set = function(value) Armory:SetConfigGlobalItemCount(value and value ~= "0"); end,
        get = function() return Armory:GetConfigGlobalItemCount(); end,
        disabled = function() return not Armory:GetConfigShowItemCount(); end,
        default = false
    };
    ARMORY_CMD_SET_COUNTXFACTION = {
        type = "toggle",
        set = function(value) Armory:SetConfigCrossFactionItemCount(value and value ~= "0"); end,
        get = function() return Armory:GetConfigCrossFactionItemCount(); end,
        disabled = function() return not Armory:GetConfigShowItemCount(); end,
        default = false
    };
    ARMORY_CMD_SET_SHOWCOUNTTOTAL = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowItemCountTotals(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowItemCountTotals(); end,
        disabled = function() return not Armory:GetConfigShowItemCount(); end,
        default = true
    };
    ARMORY_CMD_SET_SHOWKNOWNBY = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowKnownBy(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowKnownBy(); end,
        disabled = function() return not (Armory:HasTradeSkills() or Armory:HasGlyphs()); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWHASSKILL = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowHasSkill(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowHasSkill(); end,
        disabled = function() return not (Armory:HasTradeSkills() or Armory:HasGlyphs()); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWCANLEARN = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowCanLearn(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowCanLearn(); end,
        disabled = function() return not (Armory:HasTradeSkills() or Armory:HasGlyphs()); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWCRAFTERS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowCrafters(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowCrafters(); end,
        disabled = function() return not Armory:HasTradeSkills(); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWSKILLRANK = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowTradeSkillRanks(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowTradeSkillRanks(); end,
        disabled = function() return not Armory:HasTradeSkills(); end,
        default = true
    },
    ARMORY_CMD_SET_SHOW2NDSKILLRANK = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowSecondaryTradeSkillRanks(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowSecondaryTradeSkillRanks(); end,
        disabled = function() return not Armory:HasTradeSkills(); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWQUESTALTS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowQuestAlts(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowQuestAlts(); end,
        disabled = function() return not Armory:HasQuestLog(); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWACHIEVEMENTS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowAchievements(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowAchievements(); end,
        disabled = function() return not Armory:HasAchievements(); end,
        default = true
    },
    ARMORY_CMD_SET_USEINPROGRESSCOLOR = {
        type = "toggle",
        set = function(value) Armory:SetConfigUseInProgressColor(value and value ~= "0"); end,
        get = function() return Armory:GetConfigUseInProgressColor(); end,
        disabled = function() return not Armory:GetConfigShowAchievements(); end,
        default = false
    },
    ARMORY_CMD_SET_SHOWGEARSETS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowGearSets(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowGearSets(); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWGEMS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowGems(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowGems(); end,
        default = true
    },
    ARMORY_CMD_SET_EXPDAYS = {
        type = "range",
        set = function(value) Armory:SetConfigExpirationDays(value); end,
        get = function() return Armory:GetConfigExpirationDays(); end,
        disabled = function() return not Armory:HasInventory(); end,
        default = 3,
        minValue = 0,
        maxValue = 29,
        valueStep = 1
    },
    ARMORY_CMD_SET_IGNOREALTS = {
        type = "toggle",
        set = function(value) Armory:SetConfigMailIgnoreAlts(value and value ~= "0"); end,
        get = function() return Armory:GetConfigMailIgnoreAlts(); end,
        disabled = function() return not Armory:HasInventory(); end,
        default = false
    },
    ARMORY_CMD_SET_MAILCHECKVISIT = {
        type = "toggle",
        set = function(value) Armory:SetConfigMailCheckVisit(value and value ~= "0"); end,
        get = function() return Armory:GetConfigMailCheckVisit(); end,
        disabled = function() return not Armory:HasInventory(); end,
        default = true
    },
    ARMORY_CMD_SET_MAILEXCLUDEVISIT = {
        type = "toggle",
        set = function(value) Armory:SetConfigMailExcludeVisit(value and value ~= "0"); end,
        get = function() return Armory:GetConfigMailExcludeVisit("player"); end,
        disabled = function() return not (Armory:GetConfigMailCheckVisit() and Armory:HasInventory()); end,
        default = false
    },
    ARMORY_CMD_SET_MAILHIDELOGONVISIT = {
        type = "toggle",
        set = function(value) Armory:SetConfigMailHideLogonVisit(value and value ~= "0"); end,
        get = function() return Armory:GetConfigMailHideLogonVisit(); end,
        disabled = function() return not (Armory:GetConfigMailCheckVisit() and Armory:HasInventory()); end,
        default = false
    },
    ARMORY_CMD_SET_MAILCHECKCOUNT = {
        type = "toggle",
        set = function(value) Armory:SetConfigMailCheckCount(value and value ~= "0"); end,
        get = function() return Armory:GetConfigMailCheckCount(); end,
        disabled = function() return not (Armory:GetConfigExpirationDays() > 0 and Armory:HasInventory()); end,
        default = true
    },
    ARMORY_CMD_SET_MAILHIDECOUNT = {
        type = "toggle",
        set = function(value) Armory:SetConfigMailHideCount(value and value ~= "0"); end,
        get = function() return Armory:GetConfigMailHideCount(); end,
        disabled = function() return not (Armory:GetConfigMailCheckCount() and Armory:GetConfigExpirationDays() > 0 and Armory:HasInventory()); end,
        default = false
    },
    ARMORY_CMD_SET_MAILHIDELOGONCOUNT = {
        type = "toggle",
        set = function(value) Armory:SetConfigMailHideLogonCount(value and value ~= "0"); end,
        get = function() return Armory:GetConfigMailHideLogonCount(); end,
        disabled = function() return not (Armory:GetConfigMailCheckCount() and Armory:GetConfigExpirationDays() > 0 and Armory:HasInventory()); end,
        default = false
    },
    ARMORY_CMD_SET_SHOWSHAREMSG = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowShareMessages(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowShareMessages(); end,
        disabled = function() return not Armory:HasDataSharing(); end,
        default = false
    },
    ARMORY_CMD_SET_SHARESKILLS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareProfessions(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareProfessions("player"); end,
        disabled = function() return not (Armory:HasDataSharing() and Armory:HasTradeSkills()); end,
        default = true
    },
    ARMORY_CMD_SET_SHAREQUESTS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareQuests(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareQuests("player"); end,
        disabled = function() return not (Armory:HasDataSharing() and Armory:HasQuestLog()); end,
        default = true
    },
    ARMORY_CMD_SET_SHARECHARACTER = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareCharacter(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareCharacter("player"); end,
        disabled = function() return not Armory:HasDataSharing(); end,
        default = true
    },
    ARMORY_CMD_SET_SHAREITEMS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareItems(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareItems("player"); end,
        disabled = function() return not (Armory:HasDataSharing() and Armory:GetConfigShareChannel()); end,
        default = true
    },
    ARMORY_CMD_SET_SHAREALT = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareAsAlt(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareAsAlt("player"); end,
        disabled = function() return not Armory:HasDataSharing(); end,
        default = true
    },
    ARMORY_CMD_SET_SHAREININSTANCE = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareInInstance(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareInInstance(); end,
        disabled = function() return not Armory:HasDataSharing(); end,
        default = true
    },
    ARMORY_CMD_SET_SHAREINCOMBAT = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareInCombat(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareInCombat(); end,
        disabled = function() return not Armory:HasDataSharing(); end,
        default = true
    },
    ARMORY_CMD_SET_SHAREALL = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareAll(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareAll(); end,
        disabled = function() return not Armory:HasDataSharing(); end,
        default = false
    },
    ARMORY_CMD_SET_SHAREGUILD = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareGuild(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareGuild(); end,
        disabled = function() return not Armory:HasDataSharing() or Armory:GetConfigShareAll(); end,
        default = true
    },
    ARMORY_CMD_SET_SHARECHANNEL = {
        type = "toggle",
        set = function(value) Armory:SetConfigShareChannel(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShareChannel(); end,
        disabled = function() return not Armory:HasDataSharing(); end,
        default = false
    },
    ARMORY_CMD_SET_WINDOWSEARCH = {
        type = "toggle",
        set = function(value) Armory:SetConfigSearchWindow(value and value ~= "0"); end,
        get = function() return Armory:GetConfigSearchWindow(); end,
        default = true
    },
    ARMORY_CMD_SET_GLOBALSEARCH = {
        type = "toggle",
        set = function(value) Armory:SetConfigGlobalSearch(value and value ~= "0"); end,
        get = function() return Armory:GetConfigGlobalSearch(); end,
        default = true
    },
    ARMORY_CMD_SET_EXTENDEDSEARCH = {
        type = "toggle",
        set = function(value) Armory:SetConfigExtendedSearch(value and value ~= "0"); end,
        get = function() return Armory:GetConfigExtendedSearch(); end,
        default = false
    },
    ARMORY_CMD_SET_RESTRICTIVESEARCH = {
        type = "toggle",
        set = function(value) Armory:SetConfigRestrictiveSearch(value and value ~= "0"); end,
        get = function() return Armory:GetConfigRestrictiveSearch(); end,
        default = false
    },
    ARMORY_CMD_SET_ALTCLICKSEARCH = {
        type = "toggle",
        set = function(value) Armory:SetConfigAltClickSearch(value and value ~= "0"); end,
        get = function() return Armory:GetConfigAltClickSearch(); end,
        default = true
    },
    ARMORY_CMD_SET_LDBLABEL = {
        type = "toggle",
        set = function(value) Armory:SetConfigLDBLabel(value and value ~= "0"); end,
        get = function() return Armory:GetConfigLDBLabel(); end,
        default = false
    },
    ARMORY_CMD_CHECK = {
        type = "execute",
        run = function() Armory:CheckMailItems() end,
        disabled = function () return not Armory:HasInventory() or Armory:GetConfigExpirationDays() == 0; end
    },
    ARMORY_CMD_RESET_FRAME = {
        type = "execute",
        run = function() Armory:Reset(ARMORY_CMD_RESET_FRAME, true); end
    },
    ARMORY_CMD_SET_UISCALE = {
        type = "range",
        set = function(value) Armory:SetConfigFrameScale(value); end,
        get = function() return Armory:GetConfigFrameScale(); end,
        default = 1,
        minValue = 0.5,
        maxValue = 1.5,
        valueStep = 0.05,
    },
    ARMORY_CMD_LOOKUP = {
        type = "execute",
        run = function() ArmoryLookupFrame_Toggle(); end,
        disabled = function () return not Armory:HasDataSharing(); end
    },
    ARMORY_CMD_FIND = {
        type = "execute",
        run = function() ArmoryFindFrame_Toggle(); end
    },
    ARMORY_CMD_CONFIG = {
        type = "execute",
        run = function() Armory:OpenConfigPanel(); end
    },
    ARMORY_CMD_SET_SHOWMINIMAP = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowMinimap(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowMinimap(); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWMMGLOBAL = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowMinimapGlobal(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowMinimapGlobal(); end,
        default = true
    },
    ARMORY_CMD_SET_HIDEMMTOOLBAR = {
        type = "toggle",
        set = function(value) Armory:SetConfigHideMinimapIfToolbar(value and value ~= "0"); end,
        get = function() return Armory:GetConfigHideMinimapIfToolbar(); end,
        disabled = function() return not Armory:GetConfigShowMinimap(); end,
        default = true
    },
    ARMORY_CMD_SET_MMB_ANGLE = {
        type = "range",
        set = function(value) Armory:SetConfigMinimapAngle(value); end,
        get = function() return Armory:GetConfigMinimapAngle(); end,
        disabled = function() return not Armory:GetConfigShowMinimap(); end,
        default = 170,
        minValue = 0,
        maxValue = 360,
        valueStep = 0.01
    },
    ARMORY_CMD_SET_MMB_RADIUS = {
        type = "range",
        set = function(value) Armory:SetConfigMinimapRadius(value); end,
        get = function() return Armory:GetConfigMinimapRadius(); end,
        disabled = function() return not Armory:GetConfigShowMinimap(); end,
        default = 80,
        minValue = 80,
        maxValue = 160,
        valueStep = 1
    },
    ARMORY_CMD_SET_USEENCODING = {
        type = "toggle",
        set = function(value) Armory:SetConfigUseEncoding(value and value ~= "0"); end,
        get = function() return Armory:GetConfigUseEncoding(); end,
        default = false
    },
    ARMORY_CMD_SET_USEOVERLAY = {
        type = "toggle",
        set = function(value) Armory:SetConfigUseOverlay(value and value ~= "0"); end,
        get = function() return Armory:GetConfigUseOverlay(); end,
        default = false
    },
    ARMORY_CMD_SET_USEMAZIEL = {
        type = "toggle",
        set = function(value) Armory:SetConfigUseMaziel(value and value ~= "0"); end,
        get = function() return Armory:GetConfigUseMaziel(); end,
        default = false
    },
    ARMORY_CMD_SET_CHECKBUTTON = {
        type = "toggle",
        set = function(value) Armory:SetConfigHideCheckButton(value and value ~= "0"); end,
        get = function() return Armory:GetConfigHideCheckButton(); end,
        default = false
    },
    ARMORY_CMD_SET_SHOWENHANCEDTIPS = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowEnhancedTips(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowEnhancedTips(); end,
        default = true
    },
    ARMORY_CMD_SET_EXTENDEDTRADE = {
        type = "toggle",
        set = function(value) Armory:SetConfigExtendedTradeSkills(value and value ~= "0"); end,
        get = function() return Armory:GetConfigExtendedTradeSkills(); end,
        disabled = function() return not Armory:HasTradeSkills(); end,
        default = true
    },
    ARMORY_CMD_SET_SHOWSUMMARY = {
        type = "toggle",
        set = function(value) Armory:SetConfigShowSummary(value and value ~= "0"); end,
        get = function() return Armory:GetConfigShowSummary(); end,
        default = true
    },
    ARMORY_CMD_SET_SUMMARYDELAY = {
        type = "range",
        set = function(value) Armory:SetConfigSummaryDelay(value); end,
        get = function() return Armory:GetConfigSummaryDelay(); end,
        disabled = function() return not Armory:GetConfigShowSummary(); end,
        default = 2,
        minValue = 0,
        maxValue = 5,
        valueStep = 1
    },
    ARMORY_CMD_SET_COOLDOWNEVENTS = {
        type = "toggle",
        set = function(value) Armory:SetConfigEnableCooldownEvents(value and value ~= "0"); end,
        get = function() return Armory:GetConfigEnableCooldownEvents(); end,
        disabled = function() return not (Armory:HasSocial() and Armory:HasTradeSkills()); end,
        default = true
    },
    ARMORY_CMD_SET_EVENTWARNINGS = {
        type = "toggle",
        set = function(value) Armory:SetConfigEnableEventWarnings(value and value ~= "0"); end,
        get = function() return Armory:GetConfigEnableEventWarnings(); end,
        disabled = function() return not Armory:HasSocial(); end,
        default = true
    },
    ARMORY_CMD_SET_EVENTLOCALTIME = {
        type = "toggle",
        set = function(value) Armory:SetConfigUseEventLocalTime(value and value ~= "0"); end,
        get = function() return Armory:GetConfigUseEventLocalTime(); end,
        disabled = function() return not Armory:HasSocial(); end,
        default = true
    },
    ARMORY_CMD_SET_CHECKCOOLDOWNS = {
        type = "toggle",
        set = function(value) Armory:SetConfigCheckCooldowns(value and value ~= "0"); end,
        get = function() return Armory:GetConfigCheckCooldowns(); end,
        disabled = function() return not (Armory:HasSocial() and Armory:GetConfigEnableCooldownEvents()); end,
        default = true
    },
    ARMORY_CMD_SET_USEFACTIONFILTER = {
        type = "toggle",
        set = function(value) Armory:SetConfigUseFactionFilter(value and value ~= "0"); end,
        get = function() return Armory:GetConfigUseFactionFilter(); end,
        default = false
    },
};

function Armory:SetConfigShowEnhancedTips(on)
    self:Setting("General", "HideEnhancedTips", not on);
end

function Armory:GetConfigShowEnhancedTips()
    return not self:Setting("General", "HideEnhancedTips");
end

function Armory:SetConfigUseEncoding(on)
    self:Setting("General", "UseEncoding", on);
end

function Armory:GetConfigUseEncoding()
    return self:Setting("General", "UseEncoding") or nil;
end

function Armory:SetConfigUseOverlay(on)
    self:Setting("General", "UseOverlay", on);
end

function Armory:GetConfigUseOverlay()
    return self:Setting("General", "UseOverlay") or nil;
end

function Armory:SetConfigUseMaziel(on)
    self:Setting("General", "UseMaziel", on);
end

function Armory:GetConfigUseMaziel()
    return self:Setting("General", "UseMaziel") or nil;
end

function Armory:SetConfigHideCheckButton(on)
    self:Setting("General", "HideCheckButton", on);
end

function Armory:GetConfigHideCheckButton()
    return self:Setting("General", "HideCheckButton") or nil;
end

function Armory:SetConfigScanOnEnter(on, all)
    if ( all ) then
        self:AllCharacterSetting("ScanOnEnter", on);
    else
        self:CharacterSetting("ScanOnEnter", "player", on);
    end
end

function Armory:GetConfigScanOnEnter()
    return self:CharacterSetting("ScanOnEnter", "player") or nil;
end

function Armory:SetConfigPauseWhileInCombat(on)
    self:Setting("General", "RunWhileInCombat", not on);
end

function Armory:GetConfigPauseWhileInCombat()
    return not self:Setting("General", "RunWhileInCombat");
end

function Armory:SetConfigRemainPausedInInstance(on)
    self:Setting("General", "RemainPausedInInstance", on);
end

function Armory:GetConfigRemainPausedInInstance()
    return self:Setting("General", "RemainPausedInInstance") or nil;
end

function Armory:SetConfigExpirationDays(days)
    local option = self.options.ARMORY_CMD_SET_EXPDAYS;
    self:Setting("General", "ExpirationDays", max(min(days, option.maxValue), option.minValue));
end

function Armory:GetConfigExpirationDays()
    local option = self.options.ARMORY_CMD_SET_EXPDAYS;
    return self:Setting("General", "ExpirationDays") or option.default;
end

function Armory:SetInventoryListViewMode(checked)
    self:Setting("Inventory", "ListView", checked);
end

function Armory:GetInventoryListViewMode()
    return self:Setting("Inventory", "ListView") or nil;
end

function Armory:SetConfigSaveSearchAll(on)
    self:Setting("General", "SearchAll", on);
    if ( on ) then
        self:SetInventorySearchAll(self.inventorySearchAll);
    end
end

function Armory:GetConfigSaveSearchAll()
    return self:Setting("General", "SearchAll") or nil;
end

function Armory:SetInventorySearchAll(checked)
    if ( self:GetConfigSaveSearchAll() ) then
        self:Setting("Inventory", "SearchAll", checked);
    end
end

function Armory:GetInventorySearchAll()
    if ( self:GetConfigSaveSearchAll() ) then
        return self:Setting("Inventory", "SearchAll") or self.inventorySearchAll;
    else
        return self.inventorySearchAll;
    end
end

function Armory:SetInventoryBagLayout(checked)
    self:Setting("Inventory", "BagLayout", checked);
end

function Armory:GetInventoryBagLayout()
    return self:Setting("Inventory", "BagLayout") or nil;
end

function Armory:SetConfigLastViewed(on)
    self:Setting("General", "LastViewed", on);
    if ( on ) then
        self:SetPaperDollLastViewed(self.characterRealm, self.character);
    else
        self.characterRealm, self.character = self:GetPaperDollLastViewed();
    end
end

function Armory:GetConfigLastViewed()
    return self:Setting("General", "LastViewed") or nil;
end

function Armory:SetPaperDollLastViewed(realm, character)
    if ( self:GetConfigLastViewed() ) then
        self:Setting("PaperDoll", "LastViewed", realm, character);
    end
    self.characterRealm = realm;
    self.character = character;
end

function Armory:GetPaperDollLastViewed()
    local realm, character;
    if ( self:GetConfigLastViewed() ) then
        realm, character = self:Setting("PaperDoll", "LastViewed");
    else
        realm = self.characterRealm;
        character = self.character;
    end
    return (realm or self.playerRealm), (character or self.player);
end

function Armory:SetConfigShowAltEquipment(on)
    self:Setting("General", "HideAltEquipment", not on);
end

function Armory:GetConfigShowAltEquipment()
    return not self:Setting("General", "HideAltEquipment");
end

function Armory:SetConfigShowUnequippable(on)
    self:Setting("General", "HideUnequippable", not on);
end

function Armory:GetConfigShowUnequippable()
    return not self:Setting("General", "HideUnequippable");
end

function Armory:SetConfigShowEqcTooltips(on)
    self:Setting("General", "HideEqcTooltips", not on);
end

function Armory:GetConfigShowEqcTooltips()
    return not self:Setting("General", "HideEqcTooltips");
end

function Armory:SetConfigShowItemCount(on)
    self:Setting("General", "HideItemCount", not on);
end

function Armory:GetConfigShowItemCount()
    return not self:Setting("General", "HideItemCount");
end

function Armory:SetConfigShowItemCountPerSlot(on)
    self:Setting("General", "ShowItemCountPerSlot", on);
end

function Armory:GetConfigShowItemCountPerSlot()
    return self:Setting("General", "ShowItemCountPerSlot");
end

function Armory:SetConfigShowItemCountTotals(on)
    self:Setting("General", "HideItemCountTotals", not on);
end

function Armory:GetConfigShowItemCountTotals()
    return not self:Setting("General", "HideItemCountTotals");
end

function Armory:SetConfigGlobalItemCount(on)
    Armory:Setting("General", "GlobalItemCount", on);
end

function Armory:GetConfigGlobalItemCount()
    return Armory:Setting("General", "GlobalItemCount");
end

function Armory:SetConfigCrossFactionItemCount(on)
    Armory:Setting("General", "CrossFactionItemCount", on);
end

function Armory:GetConfigCrossFactionItemCount()
    return Armory:Setting("General", "CrossFactionItemCount");
end

function Armory:SetConfigShowKnownBy(on)
    self:Setting("General", "HideKnownBy", not on);
end

function Armory:GetConfigShowKnownBy()
    return not self:Setting("General", "HideKnownBy");
end

function Armory:SetConfigShowHasSkill(on)
    self:Setting("General", "HideHasSkill", not on);
end

function Armory:GetConfigShowHasSkill()
    return not self:Setting("General", "HideHasSkill");
end

function Armory:SetConfigShowCanLearn(on)
    self:Setting("General", "HideCanLearn", not on);
end

function Armory:GetConfigShowCanLearn()
    return not self:Setting("General", "HideCanLearn");
end

function Armory:SetConfigShowCrafters(on)
    self:Setting("General", "HideCrafters", not on);
end

function Armory:GetConfigShowCrafters()
    return not self:Setting("General", "HideCrafters");
end

function Armory:SetConfigShowTradeSkillRanks(on)
    self:Setting("General", "HideTradeSkillRanks", not on);
end

function Armory:GetConfigShowTradeSkillRanks()
    return not self:Setting("General", "HideTradeSkillRanks");
end

function Armory:SetConfigShowSecondaryTradeSkillRanks(on)
    self:Setting("General", "HideSecondaryTradeSkillRanks", not on);
end

function Armory:GetConfigShowSecondaryTradeSkillRanks()
    return not self:Setting("General", "HideSecondaryTradeSkillRanks");
end

function Armory:SetConfigShowQuestAlts(on)
    self:Setting("General", "HideQuestAlts", not on);
end

function Armory:GetConfigShowQuestAlts()
    return not self:Setting("General", "HideQuestAlts");
end

function Armory:SetConfigShowAchievements(on)
    self:Setting("General", "HideAchievements", not on);
end

function Armory:GetConfigShowAchievements()
    return not self:Setting("General", "HideAchievements");
end

function Armory:SetConfigUseInProgressColor(on)
    self:Setting("General", "UseInProgressColor", on);
end

function Armory:GetConfigUseInProgressColor()
    return self:Setting("General", "UseInProgressColor") or nil;
end

function Armory:SetConfigShowGearSets(on)
    self:Setting("General", "HideGearSets", not on);
end

function Armory:GetConfigShowGearSets()
    return not self:Setting("General", "HideGearSets");
end

function Armory:SetConfigShowGems(on)
    self:Setting("General", "HideGems", not on);
end

function Armory:GetConfigShowGems()
    return not self:Setting("General", "HideGems");
end

function Armory:SetConfigPerCharacter(on)
    self:Setting("General", "PerCharacter", on);
end

function Armory:GetConfigPerCharacter()
    return self:Setting("General", "PerCharacter") or nil;
end

function Armory:SetConfigShowMinimap(on)
    if ( self:GetConfigShowMinimapGlobal() ) then
        self:Setting("General", "HideMinimap", not on);
    else
        self:LocalSetting("Minimap", "Hide", not on);
    end
end

function Armory:GetConfigShowMinimap()
    if ( self:GetConfigShowMinimapGlobal() ) then
        return not self:Setting("General", "HideMinimap");
    end
    return not self:LocalSetting("Minimap", "Hide");
end

function Armory:SetConfigShowMinimapGlobal(on)
    local show = self:GetConfigShowMinimap();
    self:Setting("General", "LocalMinimap", not on);
    self:SetConfigShowMinimap(show);
end

function Armory:GetConfigShowMinimapGlobal()
    return not self:Setting("General", "LocalMinimap");
end

function Armory:SetConfigHideMinimapIfToolbar(on)
    self:Setting("General", "ShowMinimapToolbar", not on);
end

function Armory:GetConfigHideMinimapIfToolbar()
    return not self:Setting("General", "ShowMinimapToolbar");
end

function Armory:SetConfigMinimapAngle(angle)
    local option = self.options.ARMORY_CMD_SET_MMB_ANGLE;
    self:LocalSetting("Minimap", "Angle", max(min(angle, option.maxValue), option.minValue));
end

function Armory:GetConfigMinimapAngle()
    local option = self.options.ARMORY_CMD_SET_MMB_ANGLE;
    return self:LocalSetting("Minimap", "Angle") or option.default;
end

function Armory:SetConfigMinimapRadius(radius)
    local option = self.options.ARMORY_CMD_SET_MMB_RADIUS;
    self:LocalSetting("Minimap", "Radius",  max(min(radius, option.maxValue), option.minValue));
end

function Armory:GetConfigMinimapRadius()
    local option = self.options.ARMORY_CMD_SET_MMB_RADIUS;
    return self:LocalSetting("Minimap", "Radius") or option.default;
end

function Armory:SetConfigShowShareMessages(on)
    self:Setting("General", "SharingMessages", on);
end

function Armory:GetConfigShowShareMessages()
    return self:Setting("General", "SharingMessages") or nil;
end

function Armory:SetConfigShareProfessions(on)
    self:CharacterSetting("ShareSkills", "player", on);
end

function Armory:GetConfigShareProfessions(unit)
    local share = self:CharacterSetting("ShareSkills", unit);
    if ( share == nil ) then
        share = true;
    end
    return share;
end

function Armory:SetConfigShareQuests(on)
    self:CharacterSetting("ShareQuests", "player", on);
end

function Armory:GetConfigShareQuests(unit)
    local share = self:CharacterSetting("ShareQuests", unit);
    if ( share == nil ) then
        share = true;
    end
    return share;
end

function Armory:SetConfigShareCharacter(on)
    self:CharacterSetting("ShareCharacter", "player", on);
end

function Armory:GetConfigShareCharacter(unit)
    local share = self:CharacterSetting("ShareCharacter", unit);
    if ( share == nil ) then
        share = true;
    end
    return share;
end

function Armory:SetConfigShareItems(on)
    self:CharacterSetting("ShareItems", "player", on);
end

function Armory:GetConfigShareItems(unit)
    local share = self:CharacterSetting("ShareItems", unit);
    if ( share == nil ) then
        share = true;
    end
    return share;
end

function Armory:SetConfigShareAsAlt(on)
    self:CharacterSetting("ShareAsAlt", "player", on);
end

function Armory:GetConfigShareAsAlt(unit)
    local share = self:CharacterSetting("ShareAsAlt", unit);
    if ( share == nil ) then
        share = true;
    end
    return share;
end

function Armory:SetConfigShareChannel(on)
    self:Setting("Channel", "Enabled", on);
end

function Armory:GetConfigShareChannel()
    return self:Setting("Channel", "Enabled") or nil;
end

function Armory:SetConfigChannelName(name)
    if ( name ) then
        name = strtrim(name);
        if ( name == "" ) then
            name = nil;
        end
    end
    self:Setting("Channel", "Name", name);
end

function Armory:GetConfigChannelName()
    local name = self:Setting("Channel", "Name");
    local channelName;
    if ( name ) then
        channelName = ARMORY_ID..name;
    end
    return channelName, name;
end

function Armory:SetConfigShareInInstance(on)
    self:Setting("General", "DontShareInInstance", not on);
end

function Armory:GetConfigShareInInstance()
    return not self:Setting("General", "DontShareInInstance");
end

function Armory:SetConfigShareInCombat(on)
    self:Setting("General", "DontShareInCombat", not on);
end

function Armory:GetConfigShareInCombat()
    return not self:Setting("General", "DontShareInCombat");
end

function Armory:SetConfigShareAll(on)
    self:Setting("General", "ShareAll", on);
end

function Armory:GetConfigShareAll()
    return self:Setting("General", "ShareAll") or nil;
end

function Armory:SetConfigShareGuild(on)
    self:Setting("General", "ShareNonGuild", not on);
end

function Armory:GetConfigShareGuild()
    return not self:Setting("General", "ShareNonGuild");
end

function Armory:SetConfigItemCountColor(r, g, b)
    self:Setting("General", "ItemCountColor", r, g, b);
end

function Armory:GetConfigItemCountColor(default)
    local r, g, b = self:Setting("General", "ItemCountColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(NORMAL_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigItemCountTotalsColor(r, g, b)
    self:Setting("General", "ItemCountTotalsColor", r, g, b);
end

function Armory:GetConfigItemCountTotalsColor(default)
    local r, g, b = self:Setting("General", "ItemCountTotalsColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(PASSIVE_SPELL_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigKnownColor(r, g, b)
    self:Setting("General", "KnownColor", r, g, b);
end

function Armory:GetConfigKnownColor(default)
    local r, g, b = self:Setting("General", "KnownColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(RED_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigHasSkillColor(r, g, b)
    self:Setting("General", "HasSkillColor", r, g, b);
end

function Armory:GetConfigHasSkillColor(default)
    local r, g, b = self:Setting("General", "HasSkillColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(ORANGE_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigCanLearnColor(r, g, b)
    self:Setting("General", "CanLearnColor", r, g, b);
end

function Armory:GetConfigCanLearnColor(default)
    local r, g, b = self:Setting("General", "CanLearnColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(GREEN_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigCraftersColor(r, g, b)
    self:Setting("General", "CraftersColor", r, g, b);
end

function Armory:GetConfigCraftersColor(default)
    local r, g, b = self:Setting("General", "CraftersColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(NORMAL_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigTradeSkillRankColor(r, g, b)
    self:Setting("General", "TradeSkillRankColor", r, g, b);
end

function Armory:GetConfigTradeSkillRankColor(default)
    local r, g, b = self:Setting("General", "TradeSkillRankColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(NORMAL_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigQuestAltsColor(r, g, b)
    self:Setting("General", "QuestAltsColor", r, g, b);
end

function Armory:GetConfigQuestAltsColor(default)
    local r, g, b = self:Setting("General", "QuestAltsColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(GREEN_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigAchievementsColor(r, g, b)
    self:Setting("General", "AchievementsColor", r, g, b);
end

function Armory:GetConfigAchievementsColor(default)
    local r, g, b = self:Setting("General", "AchievementsColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(GREEN_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigAchievementInProgressColor(r, g, b)
    self:Setting("General", "AchievementInProgressColor", r, g, b);
end

function Armory:GetConfigAchievementInProgressColor(default)
    local r, g, b = self:Setting("General", "AchievementInProgressColor");
    if ( default or not r ) then
        r, g, b = GetTableColor(LIGHTYELLOW_FONT_COLOR);
    end
    return r, g, b;
end

function Armory:SetConfigSearchWindow(on)
    self:Setting("General", "SearchResult2Chat", not on);
end

function Armory:GetConfigSearchWindow()
    return not self:Setting("General", "SearchResult2Chat");
end

function Armory:SetConfigGlobalSearch(on)
    self:Setting("General", "SearchRealmOnly", not on);
end

function Armory:GetConfigGlobalSearch()
    return not self:Setting("General", "SearchRealmOnly");
end

function Armory:SetConfigExtendedSearch(on)
    self:Setting("General", "SearchExtended", on);
end

function Armory:GetConfigExtendedSearch()
    return self:Setting("General", "SearchExtended") or nil;
end

function Armory:SetConfigRestrictiveSearch(on)
    self:Setting("General", "SearchRestrictive", on);
end

function Armory:GetConfigRestrictiveSearch()
    return self:Setting("General", "SearchRestrictive") or nil;
end

function Armory:SetConfigAltClickSearch(on)
    self:Setting("General", "NoSearchAltClick", not on);
end

function Armory:GetConfigAltClickSearch()
    return not self:Setting("General", "NoSearchAltClick");
end

function Armory:SetConfigDefaultSearch(searchType)
    self:Setting("General", "SearchDefault", self:FindSearchType(searchType));
end

function Armory:GetConfigDefaultSearch()
    return self:FindSearchType(self:Setting("General", "SearchDefault") or 1);
end

function Armory:SetConfigLDBLabel(on)
    self:Setting("General", "ShowLDBLabel", on);
    self:SetProfile(self:CurrentProfile());
end

function Armory:GetConfigLDBLabel()
    return self:Setting("General", "ShowLDBLabel") or nil;
end

function Armory:SetConfigMailIgnoreAlts(on)
    self:Setting("General", "MailIgnoreAlts", on);
end

function Armory:GetConfigMailIgnoreAlts()
    return self:Setting("General", "MailIgnoreAlts") or nil;
end

function Armory:SetConfigMailCheckVisit(on)
    self:Setting("General", "MailIgnoreVisit", not on);
end

function Armory:GetConfigMailCheckVisit()
    return not self:Setting("General", "MailIgnoreVisit");
end

function Armory:SetConfigMailExcludeVisit(on)
    self:CharacterSetting("MailIgnoreVisit", "player", on);
end

function Armory:GetConfigMailExcludeVisit(unit)
    return self:CharacterSetting("MailIgnoreVisit", unit) or nil;
end

function Armory:SetConfigMailHideLogonVisit(on)
    self:Setting("General", "MailHideLogonVisit", on);
end

function Armory:GetConfigMailHideLogonVisit()
    return self:Setting("General", "MailHideLogonVisit") or nil;
end

function Armory:SetConfigMailCheckCount(on)
    self:Setting("General", "MailIgnoreCount", not on);
end

function Armory:GetConfigMailCheckCount()
    return not self:Setting("General", "MailIgnoreCount");
end

function Armory:SetConfigMailHideCount(on)
    self:Setting("General", "MailHideCount", on);
end

function Armory:GetConfigMailHideCount()
    return self:Setting("General", "MailHideCount") or nil;
end

function Armory:SetConfigMailHideLogonCount(on)
    self:Setting("General", "MailHideLogonCount", on);
end

function Armory:GetConfigMailHideLogonCount()
    return self:Setting("General", "MailHideLogonCount") or nil;
end

function Armory:SetConfigExtendedTradeSkills(on)
    self:Setting("General", "SimpleTrade", not on);
end

function Armory:GetConfigExtendedTradeSkills()
    return not self:Setting("General", "SimpleTrade");
end

function Armory:SetConfigShowSummary(on)
    self:Setting("General", "HideSummary", not on);
end

function Armory:GetConfigShowSummary()
    return not self:Setting("General", "HideSummary");
end

function Armory:SetConfigSummaryDelay(delay)
    local option = self.options.ARMORY_CMD_SET_SUMMARYDELAY;
    self:Setting("General", "SummaryDelay", max(min(delay, option.maxValue), option.minValue));
end

function Armory:GetConfigSummaryDelay()
    local option = self.options.ARMORY_CMD_SET_SUMMARYDELAY;
    return self:Setting("General", "SummaryDelay") or option.default;
end

function Armory:SetConfigSummaryClass(on)
    self:Setting("General", "HideSummaryClass", not on);
end

function Armory:GetConfigSummaryClass()
    return not self:Setting("General", "HideSummaryClass");
end

function Armory:SetConfigSummaryLevel(on)
    self:Setting("General", "HideSummaryLevel", not on);
end

function Armory:GetConfigSummaryLevel()
    return not self:Setting("General", "HideSummaryLevel");
end

function Armory:SetConfigSummaryItemLevel(on)
    self:Setting("General", "HideSummaryItemLevel", not on);
end

function Armory:GetConfigSummaryItemLevel()
    return not self:Setting("General", "HideSummaryItemLevel");
end

function Armory:SetConfigSummaryZone(on)
    self:Setting("General", "HideSummaryZone", not on);
end

function Armory:GetConfigSummaryZone()
    return not self:Setting("General", "HideSummaryZone");
end

function Armory:SetConfigSummaryXP(on)
    self:Setting("General", "HideSummaryXP", not on);
end

function Armory:GetConfigSummaryXP()
    return not self:Setting("General", "HideSummaryXP");
end

function Armory:SetConfigSummaryPlayed(on)
    self:Setting("General", "HideSummaryPlayed", not on);
end

function Armory:GetConfigSummaryPlayed()
    return not self:Setting("General", "HideSummaryPlayed");
end

function Armory:SetConfigSummaryOnline(on)
    self:Setting("General", "HideSummaryOnline", not on);
end

function Armory:GetConfigSummaryOnline()
    return not self:Setting("General", "HideSummaryOnline");
end

function Armory:SetConfigSummaryMoney(on)
    self:Setting("General", "HideSummaryMoney", not on);
end

function Armory:GetConfigSummaryMoney()
    return not self:Setting("General", "HideSummaryMoney");
end

function Armory:SetConfigSummaryCurrency(on)
    self:Setting("General", "HideSummaryCurrency", not on);
end

function Armory:GetConfigSummaryCurrency()
    return not self:Setting("General", "HideSummaryCurrency");
end

function Armory:SetConfigSummaryQuest(on)
    self:Setting("General", "HideSummaryQuest", not on);
end

function Armory:GetConfigSummaryQuest()
    return not self:Setting("General", "HideSummaryQuest");
end

function Armory:SetConfigSummaryExpiration(on)
    self:Setting("General", "HideSummaryExpiration", not on);
end

function Armory:GetConfigSummaryExpiration()
    return not self:Setting("General", "HideSummaryExpiration");
end

function Armory:SetConfigSummaryEvents(on)
    self:Setting("General", "HideSummaryEvents", not on);
end

function Armory:GetConfigSummaryEvents()
    return not self:Setting("General", "HideSummaryEvents");
end

function Armory:SetConfigSummaryTradeSkills(on)
    self:Setting("General", "HideSummaryTradeSkills", not on);
end

function Armory:GetConfigSummaryTradeSkills()
    return not self:Setting("General", "HideSummaryTradeSkills");
end

function Armory:SetConfigEnableCooldownEvents(on)
    local current = self:GetConfigEnableCooldownEvents();
    self:Setting("General", "DisableCooldownEvents", not on);
    if ( current ~= on ) then
        Armory:SetEventsDirty();
        Armory:Execute(ArmorySocialFrame_UpdateEvents);
    end
end

function Armory:GetConfigEnableCooldownEvents()
    return not self:Setting("General", "DisableCooldownEvents");
end

function Armory:SetConfigEnableEventWarnings(on)
    self:Setting("General", "DisableEventWarnings", not on);
end

function Armory:GetConfigEnableEventWarnings()
    return not self:Setting("General", "DisableEventWarnings");
end

function Armory:SetConfigCheckCooldowns(on)
    self:Setting("General", "DisableCooldownCheck", not on);
end

function Armory:GetConfigCheckCooldowns()
    return not self:Setting("General", "DisableCooldownCheck");
end

function Armory:SetConfigUseEventLocalTime(on)
    local current = self:GetConfigUseEventLocalTime();
    self:Setting("General", "UseEventRealmTime", not on);
    if ( current ~= on ) then
        ArmoryEventsList_Update();
    end
end

function Armory:GetConfigUseEventLocalTime()
    return not self:Setting("General", "UseEventRealmTime");
end

function Armory:SetConfigFrameScale(scale)
    self:Setting("General", "Scale", scale);
    
    for _, frameName in ipairs(ARMORYFRAME_MAINFRAMES) do
        if ( _G[frameName]:IsShown() ) then
            _G[frameName]:SetScale(scale);
        end
    end
end

function Armory:GetConfigFrameScale(scale)
    return self:Setting("General", "Scale") or 1;
end

function Armory:SetConfigUseFactionFilter(on)
    local current = self:GetConfigUseFactionFilter();
    self:Setting("General", "UseFactionFilter", on);
    if ( current ~= on ) then
        self:ResetSelectableCharacters();
        self:ResetProfile();
        self:SetPaperDollLastViewed(self.playerRealm, self.player);
        self:SelectDefaultProfile();
    end
end

function Armory:GetConfigUseFactionFilter()
    return self:Setting("General", "UseFactionFilter");
end

function Armory:SetConfigCharacterEnabled(on)
    self:LocalSetting("PaperDoll", "Disabled", not on);
end

function Armory:GetConfigCharacterEnabled()
    return not self:LocalSetting("PaperDoll", "Disabled");
end

function Armory:SetConfigWarningSound(soundName)
    self:Setting("General", "WarningSound", soundName);
end

function Armory:GetConfigWarningSound()
    local soundName = self:Setting("General", "WarningSound") or "";
    if ( soundName ~= "" ) then
        return soundName;
    end
end