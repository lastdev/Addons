--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 494 2012-09-04T21:04:44Z
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

ARMORY_MAX_RAID_INFOS = 20;
ARMORY_MAX_RAID_INFOS_DISPLAYED = 9;

local VALOR_TIER1_LFG_ID = 301;

function ArmoryRaidInfoFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("UPDATE_INSTANCE_INFO");
    self:RegisterEvent("RAID_INSTANCE_WELCOME");
end

function ArmoryRaidInfoFrame_OnEvent(self, event, ...)
    local arg1, arg2, arg3, arg4 = ...;
    
    if ( not Armory:CanHandleEvents() ) then
        return;
    
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        RequestRaidInfo();
        Armory:Execute(
            function() 
                Armory:UpdateRaidFinderInfo(); 
            end
        );
        
    elseif ( event == "UPDATE_INSTANCE_INFO" ) then
        Armory:Execute(ArmoryRaidInfoFrame_UpdateInfo);
    
    elseif ( event == "RAID_INSTANCE_WELCOME" ) then
        local lockExpireTime = arg2;
        Armory:ExecuteDelayed(5,
            function()
                if ( IsInLFGDungeon() and GetPartyLFGID() ) then
                    for index = 1, GetNumRFDungeons() do
                        local dungeonID = GetRFDungeonInfo(index);
                        if ( dungeonID == GetPartyLFGID() ) then
                            local _, _, difficultyIndex, difficultyName, maxPlayers = GetInstanceInfo();
                            local dungeonName = GetLFGDungeonInfo(dungeonID);
                            Armory:SaveRaidFinderInfo(dungeonName, dungeonID, lockExpireTime, difficultyIndex, maxPlayers, difficultyName);
                            break;
                        end
                    end
                end
                self:RegisterEvent("PLAYER_ENTERING_WORLD");
            end
        );
    end
end

function ArmoryRaidInfoScrollFrame_OnLoad(self)
	HybridScrollFrame_OnLoad(self);
	self.update = ArmoryRaidInfoFrame_Update;
	HybridScrollFrame_CreateButtons(self, "ArmoryRaidInfoInstanceTemplate");
end

function ArmoryRaidInfoFrame_OnShow(self)
    ArmoryRaidInfoFrame_Update();
    ArmoryRaidInfoFrame_UpdateCapBar();
end

function ArmoryRaidInfoFrame_Update(scrollToSelected)
    if ( Armory:UpdateInstancesInProgress() or Armory:UpdateRaidFinderInProgress() ) then
        return;
    end
    ArmoryRaidInfoFrame_UpdateSelectedIndex();

    local scrollFrame = ArmoryRaidInfoScrollFrame;
    local savedDungeons = Armory:GetNumRaidFinderDungeons();
    local savedInstances = Armory:GetNumSavedInstances();
    local instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, killed;
    local frameName, frameNameText, frameID, frameReset, width;
    local offset = HybridScrollFrame_GetOffset(scrollFrame);
    local buttons = scrollFrame.buttons;
    local numButtons = #buttons;
    local buttonHeight = buttons[1]:GetHeight();

    if ( scrollToSelected == true and ArmoryRaidInfoFrame.selectedIndex ) then --Using == true in case the HybridScrollFrame .update is changed to pass in the parent.
        local button = buttons[ArmoryRaidInfoFrame.selectedIndex - offset]
        if ( not button or (button:GetTop() > scrollFrame:GetTop()) or (button:GetBottom() < scrollFrame:GetBottom()) ) then
            local buttonHeight = scrollFrame.buttons[1]:GetHeight();
            local scrollValue = min(((ArmoryRaidInfoFrame.selectedIndex - 1) * buttonHeight), scrollFrame.range)
            if ( scrollValue ~= scrollFrame.scrollBar:GetValue() ) then
                scrollFrame.scrollBar:SetValue(scrollValue);
            end
        end
    end

    offset = HybridScrollFrame_GetOffset(scrollFrame);	--May have changed in the previous section to move selected parts into view.

    local mouseIsOverScrollFrame = scrollFrame:IsVisible() and scrollFrame:IsMouseOver();
    local frame, index, id;
    for i = 1, numButtons do
        frame = buttons[i];
        index = i + offset;
        
        if ( index <= savedDungeons ) then
            id = Armory:GetRaidFinderLineId(index);
            instanceName, instanceID, instanceReset, instanceDifficulty, locked, maxPlayers, difficultyName, killed = Armory:GetRaidFinderInfo(id);
            extended = nil;
            
            frame.longInstanceID = string.format("%x", instanceID);
            frame.killed = killed;
        
        elseif ( index <= savedDungeons + savedInstances ) then
            index = index - savedDungeons;
            id = Armory:GetInstanceLineId(index);
            instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName = Armory:GetSavedInstanceInfo(id);

            frame:SetID(index);
            frame.longInstanceID = string.format("%x%x", instanceIDMostSig, instanceID);
            frame.killed = nil;
        
        else
            instanceID = nil;
        
        end
        
        if ( instanceID ) then
            frame.instanceID = instanceID;

            if ( ArmoryRaidInfoFrame.selectedRaidID == frame.longInstanceID ) then
                frame:LockHighlight();
            else
                frame:UnlockHighlight();
            end

            frame.difficulty:SetText(difficultyName);

            if ( extended or locked ) then
                frame.reset:SetText(SecondsToTime(instanceReset, true, nil, 3));
                frame.name:SetText(instanceName);
            else
                frame.reset:SetFormattedText("|cff808080%s|r", RAID_INSTANCE_EXPIRES_EXPIRED);
                frame.name:SetFormattedText("|cff808080%s|r", instanceName);
            end

            if ( extended ) then
                frame.extended:Show();
            else
                frame.extended:Hide();
            end

            frame:Show();

            if ( mouseIsOverScrollFrame and frame:IsMouseOver() ) then
                ArmoryRaidInfoInstance_OnEnter(frame);
            end
        else
            frame:Hide();
        end	
    end
    HybridScrollFrame_Update(scrollFrame, (savedInstances + savedDungeons) * buttonHeight, scrollFrame:GetHeight());
end

function ArmoryRaidInfoFrame_UpdateInfo()
    Armory:UpdateInstances();
    ArmoryRaidInfoFrame_Update(true);
end

function ArmoryRaidInfoInstance_OnEnter(self)
    if ( self.killed ) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetText(ERR_LOOT_GONE);
        for i = 1, table.getn(self.killed) do
            GameTooltip:AddLine(self.killed[i], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
        end
        GameTooltip:Show();
    else
        local tooltipLines = Armory:GetInstanceTooltip(self:GetID());
        if ( tooltipLines ) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
            Armory:Table2Tooltip(GameTooltip, tooltipLines);
            GameTooltip:Show();
        end
    end
end

function ArmoryRaidInfoFrame_UpdateSelectedIndex()
    local savedDungeons = Armory:GetNumRaidFinderDungeons();
    for index = 1, savedDungeons do
        local id = Armory:GetRaidFinderLineId(index);
        local _, instanceID = Armory:GetRaidFinderInfo(id);
        if ( format("%x", instanceID) == ArmoryRaidInfoFrame.selectedRaidID ) then
            ArmoryRaidInfoFrame.selectedIndex = index;
            return;
        end
    end
    
    local savedInstances = Armory:GetNumSavedInstances();
    for index = 1, savedInstances do
        local id = Armory:GetInstanceLineId(index);
        local _, instanceID, _, _, _, _, instanceIDMostSig = Armory:GetSavedInstanceInfo(id);
        if ( format("%x%x", instanceIDMostSig, instanceID) == ArmoryRaidInfoFrame.selectedRaidID ) then
            ArmoryRaidInfoFrame.selectedIndex = index + savedDungeons;
            return;
        end
    end
    
    ArmoryRaidInfoFrame.selectedIndex = nil;
end

function ArmoryRaidInfoFrameCapBar_OnLoad(self)
    if ( GetLFGDungeonRewardCapBarInfo ) then -- Patch 4.1.0
        self:RegisterEvent("PLAYER_ENTERING_WORLD");
        ArmoryRaidInfoFrame_SetCapBarNotches(7);
    end
end

function ArmoryRaidInfoFrameCapBar_OnEvent(self, event, ...)
    -- Force update
    Armory:GetLFGDungeonRewardCapBarInfo(VALOR_TIER1_LFG_ID);
end

function ArmoryRaidInfoFrameCapBar_OnEnter(self)
    local currencyID, tier1DungeonID, tier1Quantity, tier1Limit, overallQuantity, overallLimit, periodPurseQuantity, periodPurseLimit = Armory:GetLFGDungeonRewardCapBarInfo(VALOR_TIER1_LFG_ID);
    if ( currencyID ) then
        local currencyName;
        if ( currencyID == 0 ) then
            currencyName = REWARDS;
        else
            currencyName = GetCurrencyInfo(currencyID);
        end
        local tier1Name = GetLFGDungeonInfo(tier1DungeonID);
        local hasNoSharedStats = (periodPurseLimit == 0);

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetText(MAXIMUM_REWARD);
        GameTooltip:AddLine(format(CURRENCY_RECEIVED_THIS_WEEK, currencyName), 1, 1, 1, true);
        GameTooltip:AddDoubleLine(format(FROM_A_DUNGEON, tier1Name), format(CURRENCY_WEEKLY_CAP_FRACTION, tier1Quantity, tier1Limit));
        if ( not hasNoSharedStats ) then
            GameTooltip:AddDoubleLine(FROM_DUNGEON_FINDER_SOURCES, format(CURRENCY_WEEKLY_CAP_FRACTION, overallQuantity, overallLimit));
            GameTooltip:AddDoubleLine(FROM_ALL_SOURCES, format(CURRENCY_WEEKLY_CAP_FRACTION, periodPurseQuantity, periodPurseLimit));
        end
        GameTooltip:Show();
    end
end

function ArmoryRaidInfoFrameCapBarCapMarker_OnEnter(self)
    local isTier1 = self:GetID() == 1;

    local currencyID, tier1DungeonID, tier1Quantity, tier1Limit, overallQuantity, overallLimit, periodPurseQuantity, periodPurseLimit = Armory:GetLFGDungeonRewardCapBarInfo(VALOR_TIER1_LFG_ID);
    if ( currencyID ) then
        local currencyName;
        if ( currencyID == 0 ) then
            currencyName = REWARDS;
        else
            currencyName = GetCurrencyInfo(currencyID);
        end

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        if ( isTier1 ) then
            local tier1Name = GetLFGDungeonInfo(tier1DungeonID);
            GameTooltip:SetText(MAXIMUM_REWARD);
            GameTooltip:AddLine(format(LFD_CURRENCY_CAP_SPECIFIC, currencyName, tier1Name), 1, 1, 1, true);
            GameTooltip:AddLine(format(CURRENCY_THIS_WEEK_WITH_AMOUNT, currencyName, tier1Quantity, tier1Limit));
        else
            GameTooltip:SetText(MAXIMUM_REWARD);
            GameTooltip:AddLine(format(LFD_CURRENCY_CAP_ALL, currencyName), 1, 1, 1, true);
            GameTooltip:AddLine(format(CURRENCY_THIS_WEEK_WITH_AMOUNT, currencyName, overallQuantity, overallLimit));
        end
        GameTooltip:Show();
    end
end

function ArmoryRaidInfoFrame_SetCapBarNotches(count)
    local capBar = ArmoryRaidInfoFrameCapBar;
    local barWidth = capBar:GetWidth();

    if ( capBar.notchCount and capBar.notchCount > count ) then
        for i = count + 1, capBar.notchCount do
            _G["ArmoryRaidInfoFrameCapBarDivider"..i]:Hide();
        end
    end

    local notchWidth = barWidth / count;

    for i = 1, count - 1 do
        local notch = _G["ArmoryRaidInfoFrameCapBarDivider"..i];
        if ( not notch ) then
            notch = capBar:CreateTexture("ArmoryRaidInfoFrameCapBarDivider"..i, "BORDER", "ArmoryCapBarDividerTemplate", -1);
        end
        notch:ClearAllPoints();
        notch:SetPoint("LEFT", capBar, "LEFT", notchWidth * i - 2, 0);
    end
    capBar.notchCount = count;
end

function ArmoryRaidInfoFrame_UpdateCapBar()
    local capBar = ArmoryRaidInfoFrameCapBar;
    local panel = ArmoryRaidInfoFrameTopBg;
    local scrollFrame = ArmoryRaidInfoScrollFrame;

    local currencyID, tier1DungeonID, tier1Quantity, tier1Limit, overallQuantity, overallLimit, periodPurseQuantity, periodPurseLimit = Armory:GetLFGDungeonRewardCapBarInfo(VALOR_TIER1_LFG_ID);
    local currencyName, currencyQuantity, currencyIcon, currencyIsDiscovered;
    if ( currencyID ) then
        currencyName, currencyQuantity, currencyIcon, _, _, _, currencyIsDiscovered = Armory:GetCurrencyInfo(currencyID);
    end
    if ( currencyIsDiscovered ) then
        capBar:Show();
        panel:Show();
        scrollFrame:SetHeight(302);
        scrollFrame:SetPoint("TOPLEFT", 16, -58);
    else
        capBar:Hide();
        panel:Hide();
        scrollFrame:SetHeight(348);
        scrollFrame:SetPoint("TOPLEFT", 16, -12);
        return;
    end
    
    local hasNoSharedStats = false;
    if ( periodPurseQuantity == 0 and periodPurseLimit == 0 ) then
        --This is the case for reward counts not directly associated with currencies (e.g. non-heroics)
        periodPurseQuantity, periodPurseLimit = overallQuantity, overallLimit;
        hasNoSharedStats = true;
    end

    local barWidth = capBar:GetWidth();
    local sizePerPoint = barWidth / periodPurseLimit;
    local progressWidth = periodPurseQuantity * sizePerPoint;
    local tier1Width = (tier1Limit - tier1Quantity) * sizePerPoint;
    local overallWidth = (overallLimit - overallQuantity) * sizePerPoint - tier1Width;

    --Don't let it go past the end.
    progressWidth = min(progressWidth, barWidth);
    tier1Width = min(tier1Width, barWidth - progressWidth);
    overallWidth = min(overallWidth, barWidth - progressWidth - tier1Width);

    capBar.progress:SetWidth(progressWidth);

    capBar.cap1:SetWidth(tier1Width);
    capBar.cap2:SetWidth(overallWidth);

    local lastFrame, lastRelativePoint = capBar, "LEFT";

    if ( progressWidth > 0 ) then
        capBar.progress:Show();
        capBar.progress:SetPoint("LEFT", lastFrame, lastRelativePoint, 0, 0);
        lastFrame, lastRelativePoint = capBar.progress, "RIGHT";
    else
        capBar.progress:Hide();
    end

    if ( tier1Width > 0 and not hasNoSharedStats) then
        capBar.cap1:Show();
        capBar.cap1Marker:Show();
        capBar.cap1:SetPoint("LEFT", lastFrame, lastRelativePoint, 0, 0);
        lastFrame, lastRelativePoint = capBar.cap1, "RIGHT";
    else
        capBar.cap1:Hide();
        capBar.cap1Marker:Hide();
    end

    if ( overallWidth > 0 and not hasNoSharedStats) then
        capBar.cap2:Show();
        capBar.cap2Marker:Show();
        capBar.cap2:SetPoint("LEFT", lastFrame, lastRelativePoint, 0, 0);
        lastFrame, lastRelativePoint = capBar.cap2, "RIGHT";
    else
        capBar.cap2:Hide();
        capBar.cap2Marker:Hide();
    end

    if ( currencyID == 0 ) then
        currencyName = REWARDS;
    end

    capBar.label:SetFormattedText(CURRENCY_THIS_WEEK, currencyName);
end