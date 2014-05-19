--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 596 2013-09-26T19:39:50Z
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

ARMORY_CONQUEST_SIZE_STRINGS = { ARENA_2V2, ARENA_3V3, ARENA_5V5, BATTLEGROUND_10V10 };
ARMORY_CONQUEST_BUTTONS = {};
local RATED_BG_ID = 4;

function ArmoryPVPFrame_OnLoad(self)
	ARMORY_CONQUEST_BUTTONS = {ArmoryConquestFrame.Arena2v2, ArmoryConquestFrame.Arena3v3, ArmoryConquestFrame.Arena5v5, ArmoryConquestFrame.RatedBG};

    ArmoryPVPFrameLine1:SetAlpha(0.3);
    ArmoryPVPHonorKillsLabel:SetVertexColor(0.6, 0.6, 0.6);
    ArmoryPVPHonorHonorLabel:SetVertexColor(0.6, 0.6, 0.6);
    ArmoryPVPHonorTodayLabel:SetVertexColor(0.6, 0.6, 0.6);
    ArmoryPVPHonorYesterdayLabel:SetVertexColor(0.6, 0.6, 0.6);
    ArmoryPVPHonorLifetimeLabel:SetVertexColor(0.6, 0.6, 0.6);
    ArmoryConquestFrameLabel:SetText(strupper(PVP_CONQUEST)..":");

    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("PLAYER_PVP_KILLS_CHANGED");
    self:RegisterEvent("PLAYER_PVP_RANK_CHANGED");
    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE");
    self:RegisterEvent("GROUP_ROSTER_UPDATE");
    self:RegisterEvent("PVP_RATED_STATS_UPDATE");
    self:RegisterEvent("PVP_REWARDS_UPDATE");

    RequestRatedInfo();
    RequestPVPRewards();
end

function ArmoryPVPFrame_OnEvent(self, event, ...)
    local arg1 = ...;
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        ArmoryPVPFrame_SetFaction();
        ArmoryPVPHonor_Update(1);
    else
        ArmoryPVPHonor_Update();
    end

    ArmoryConquestFrame_Update();
end

function ArmoryPVPFrame_OnShow(self)
	RequestRatedInfo();
	RequestPVPRewards();
    ArmoryPVPFrame_Update();
end

function ArmoryPVPFrame_SetFaction()
    local factionGroup = Armory:UnitFactionGroup("player");
    if ( factionGroup and factionGroup ~= "Neutral" ) then
        ArmoryPVPFrameHonorIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
        ArmoryPVPFrameHonorIcon:Show();
    end
end

function ArmoryPVPFrame_Update()
    ArmoryPVPFrame_SetFaction();
    ArmoryPVPHonor_Update();
    ArmoryConquestFrame_Update();
end

-- PVP Honor Data
function ArmoryPVPHonor_Update(updateAll)
    local hk, cp, contribution;
    
    -- Yesterday's values (this only gets set on player entering the world)
    hk, contribution = Armory:GetPVPYesterdayStats(updateAll);
    ArmoryPVPHonorYesterdayKills:SetText(hk);
    ArmoryPVPHonorYesterdayHonor:SetText(contribution);

    -- Lifetime values
    hk, contribution = Armory:GetPVPLifetimeStats();
    ArmoryPVPHonorLifetimeKills:SetText(hk);

    -- Today's values
    hk, cp = Armory:GetPVPSessionStats();
    ArmoryPVPHonorTodayKills:SetText(hk);
    ArmoryPVPHonorTodayHonor:SetText(cp);
    ArmoryPVPHonorTodayHonor:SetHeight(14);

    local quantity, earnedThisWeek, earnablePerWeek;

    _, quantity = Armory:GetCurrencyInfo(HONOR_CURRENCY);
    ArmoryPVPFrameHonorPoints:SetText(quantity);
end

function ArmoryConquestFrame_Update()
    _, quantity = Armory:GetCurrencyInfo(CONQUEST_CURRENCY);
    ArmoryConquestFramePoints:SetText(quantity);    

    local pointsThisWeek, maxPointsThisWeek, tier2Quantity, tier2Limit, tier1Quantity, tier1Limit, randomPointsThisWeek, maxRandomPointsThisWeek, arenaReward, ratedBGReward = Armory:GetPVPRewards();

    ArmoryPVPFrameConquestBar:SetMinMaxValues(0, maxPointsThisWeek);
    ArmoryPVPFrameConquestBar:SetValue(pointsThisWeek);
    ArmoryPVPFrameConquestBar.pointText:SetText(pointsThisWeek.."/"..maxPointsThisWeek);
    
    if ( GetMaxPlayerLevel() ~= Armory:UnitLevel("player") ) then
        ArmoryPVPFrameConquestBar:Hide();
        ArmoryConquestFrameLabel:SetPoint("LEFT", -20, 0);
    else
        ArmoryPVPFrameConquestBar:Show();
        ArmoryConquestFrameLabel:SetPoint("LEFT", -55, 0);
    end

	for i = 1, RATED_BG_ID do
		local button = ARMORY_CONQUEST_BUTTONS[i];
		local rating, seasonBest, weeklyBest, seasonPlayed, seasonWon, weeklyPlayed, weeklyWon = Armory:GetPersonalRatedInfo(i);
		button.Wins:SetText(seasonWon);
		button.BestRating:SetText(weeklyBest);
		button.CurrentRating:SetText(rating);
	end
end


--------- Conquest Tooltips ----------

function ArmoryConquestFrame_ShowMaximumRewardsTooltip(self)
	local currencyName = GetCurrencyInfo(CONQUEST_CURRENCY);

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(MAXIMUM_REWARD);
	GameTooltip:AddLine(format(CURRENCY_RECEIVED_THIS_WEEK, currencyName), 1, 1, 1, true);
	GameTooltip:AddLine(" ");

	local pointsThisWeek, maxPointsThisWeek, tier2Quantity, tier2Limit, tier1Quantity, tier1Limit, randomPointsThisWeek, maxRandomPointsThisWeek, arenaReward, ratedBGReward = Armory:GetPVPRewards();

	local r, g, b = 1, 1, 1;
	local capped;
	if ( pointsThisWeek >= maxPointsThisWeek ) then
		r, g, b = 0.5, 0.5, 0.5;
		capped = true;
	end
	GameTooltip:AddDoubleLine(FROM_ALL_SOURCES, format(CURRENCY_WEEKLY_CAP_FRACTION, pointsThisWeek, maxPointsThisWeek), r, g, b, r, g, b);

	if ( capped or tier2Quantity >= tier2Limit ) then
		r, g, b = 0.5, 0.5, 0.5;
	else
		r, g, b = 1, 1, 1;
	end
	GameTooltip:AddDoubleLine(" -"..FROM_RATEDBG, format(CURRENCY_WEEKLY_CAP_FRACTION, tier2Quantity, tier2Limit), r, g, b, r, g, b);

	if ( capped or tier1Quantity >= tier1Limit ) then
		r, g, b = 0.5, 0.5, 0.5;
	else
		r, g, b = 1, 1, 1;
	end
	GameTooltip:AddDoubleLine(" -"..FROM_ARENA, format(CURRENCY_WEEKLY_CAP_FRACTION, tier1Quantity, tier1Limit), r, g, b, r, g, b);

	if ( capped or randomPointsThisWeek >= maxRandomPointsThisWeek ) then
		r, g, b = 0.5, 0.5, 0.5;
	else
		r, g, b = 1, 1, 1;
	end
	GameTooltip:AddDoubleLine(" -"..FROM_RANDOMBG, format(CURRENCY_WEEKLY_CAP_FRACTION, randomPointsThisWeek, maxRandomPointsThisWeek), r, g, b, r, g, b);

	GameTooltip:Show();
end

local CONQUEST_TOOLTIP_PADDING = 30 --counts both sides

function ArmoryConquestFrameButton_OnEnter(self)
	local tooltip = ArmoryConquestTooltip;
	
	local rating, seasonBest, weeklyBest, seasonPlayed, _, weeklyPlayed, _, cap = Armory:GetPersonalRatedInfo(self.id);

    tooltip.WeeklyBest:SetText(PVP_BEST_RATING..weeklyBest);
    tooltip.WeeklyGamesPlayed:SetText(PVP_GAMES_PLAYED..weeklyPlayed);

    tooltip.SeasonBest:SetText(PVP_BEST_RATING..seasonBest);
    tooltip.SeasonGamesPlayed:SetText(PVP_GAMES_PLAYED..seasonPlayed);

    tooltip.ProjectedCap:SetText(cap);

    local maxWidth = max(tooltip.WeeklyBest:GetStringWidth(), tooltip.WeeklyGamesPlayed:GetStringWidth(),
                         tooltip.SeasonBest:GetStringWidth(), tooltip.SeasonGamesPlayed:GetStringWidth(),
                         tooltip.ProjectedCapLabel:GetStringWidth());

    tooltip:SetWidth(maxWidth + CONQUEST_TOOLTIP_PADDING);
    tooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 0, 0);
    tooltip:Show();
end
