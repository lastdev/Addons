--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 504 2012-09-06T20:42:02Z
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

ARMORY_GUILDBANK_LINES_DISPLAYED = 20;

ARMORY_MAX_GUILDBANK_SLOTS_PER_TAB = 98;
ARMORY_NUM_SLOTS_PER_GUILDBANK_GROUP = 14;
ARMORY_NUM_GUILDBANK_COLUMNS = 7;

StaticPopupDialogs["ARMORY_DELETE_GUILDBANK"] = {
    text = ARMORY_DELETE_UNIT,
    button1 = YES,
    button2 = NO,
    OnAccept = function()
        ArmoryGuildBankFrame_Delete();
    end,
    timeout = 0,
    whileDead = 1,
    exclusive = 1,
    showAlert = 1,
    hideOnEscape = 1
};

function ArmoryGuildBankFrame_Toggle()
    if ( ArmoryListGuildBankFrame:IsShown() or ArmoryIconGuildBankFrame:IsShown() ) then
        HideUIPanel(ArmoryListGuildBankFrame);
        HideUIPanel(ArmoryIconGuildBankFrame);
    elseif ( AGB:GetIconViewMode() ) then
        ShowUIPanel(ArmoryIconGuildBankFrame);
    else
        ShowUIPanel(ArmoryListGuildBankFrame);
    end
end

local function InitGuildBankFrame(frame)
    frame:SetAttribute("UIPanelLayout-defined", true);
    frame:SetAttribute("UIPanelLayout-enabled", true);
    frame:SetAttribute("UIPanelLayout-area", "left");
    frame:SetAttribute("UIPanelLayout-pushable", 5);
    frame:SetAttribute("UIPanelLayout-whileDead", true);

    table.insert(UISpecialFrames, frame:GetName());
        
    -- Tab Handling code
    PanelTemplates_SetNumTabs(frame, 2);
    PanelTemplates_SetTab(frame, 1);
end

function ArmoryGuildBankFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("PLAYER_GUILD_UPDATE");
    self:RegisterEvent("GUILDTABARD_UPDATE");
    self:RegisterEvent("GUILDBANKFRAME_OPENED");
    self:RegisterEvent("GUILDBANKFRAME_CLOSED");
    self:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED");

    AGB:SelectDb(self);

    ArmoryGuildBankFrame_Register();
    ArmoryGuildBankFrameEditBox:SetText(SEARCH);
end

function ArmoryGuildBankFrame_CheckResponse()
    AGB:CheckResponse();
end

function ArmoryGuildBankFrame_ProcessRequest(...)
    AGB:ProcessRequest(...);
end

function ArmoryGuildBankFrame_OnEvent(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        AGB.realm = GetRealmName();
        if ( IsInGuild() ) then
            Armory:ExecuteConditional(function() AGB.guild = GetGuildInfo("player"); return AGB.guild; end, ArmoryGuildBankFrame_Initialize);
        end
    elseif ( event == "PLAYER_GUILD_UPDATE" ) then
        if ( not IsInGuild() and AGB.realm and AGB.guild and AgbDB[AGB.realm][AGB.guild] ) then
            AgbDB[AGB.realm][AGB.guild] = nil;
        end
    elseif ( event == "GUILDTABARD_UPDATE" or event == "GUILDBANKFRAME_OPENED" ) then
        AGB:UpdateGuildInfo();
    elseif ( event == "GUILDBANKFRAME_CLOSED" ) then
        AGB.tabs = nil;
    elseif ( event == "GUILDBANKBAGSLOTS_CHANGED" ) then
        if ( not AGB.tabs ) then
            AGB.tabs = {};
        end
        AGB.tabs[GetCurrentGuildBankTab()] = 1;
    end
end

function ArmoryGuildBankFrame_Initialize()
    ArmoryGuildBankFrame_SelectGuild();
    ArmoryGuildBankNameDropDown_Initialize();
    AGB:PushInfo(); 
end

function ArmoryGuildBankFrame_OnShow(self)
    local frame = ArmoryGuildBankFrame;
    
    if ( ArmoryGuildBankFrame_SelectGuild() ) then
        if ( (frame.filter or "") == "" ) then
            ArmoryGuildBankFrameEditBox:SetText(SEARCH);
        else
            ArmoryGuildBankFrameEditBox:SetText(frame.filter);
        end
        ArmoryGuildBankFrame_Update();
    else
        ArmoryListGuildBankFrame:Hide();
        ArmoryIconGuildBankFrame:Hide();
        Armory:PrintTitle(ARMORY_GUILDBANK_NO_DATA.." "..ARMORY_GUILDBANK_ABORTING);
    end    
end

function ArmoryGuildBankFrame_OnTextChanged(self)
    local frame = ArmoryGuildBankFrame;
    local text = self:GetText();
    local refresh;

    if ( text == SEARCH ) then
        refresh = AGB:SetFilter(frame, "");
    elseif ( text ~= "=" ) then
        refresh = AGB:SetFilter(frame, text);
    end
    if ( refresh ) then
        ArmoryListGuildBankFrame_ResetScrollBar();
        ArmoryGuildBankFrame_Update();
    end
end

function ArmoryGuildBankFilterDropDown_OnLoad(self)
    ArmoryDropDownMenu_SetWidth(self, 116);
    ArmoryItemFilter_InitializeDropDown(self);
end

function ArmoryGuildBankFilterDropDown_OnShow(self)
    ArmoryItemFilter_SelectDropDown(self, ArmoryGuildBankFrame_Update);
end

function ArmoryGuildBankNameDropDown_OnLoad(self)
    ArmoryDropDownMenu_Initialize(self, ArmoryGuildBankNameDropDown_Initialize);
    ArmoryDropDownMenu_SetWidth(self, 112);
    ArmoryDropDownMenu_JustifyText(self, "LEFT");
end

function ArmoryGuildBankNameDropDown_Initialize()
    -- Setup buttons
    local currentRealm = ArmoryGuildBankFrame.selectedRealm or AGB.realm;
    local currentGuild = ArmoryGuildBankFrame.selectedGuild or AGB.guild;
    local info, checked;
    for _, realm in ipairs(AGB:RealmList()) do
        info = ArmoryDropDownMenu_CreateInfo();
        info.text = realm;
        info.notClickable = 1;
        info.notCheckable = 1;
        info.isTitle = 1;
        ArmoryDropDownMenu_AddButton(info);
        for _, guild in ipairs(AGB:GuildList(realm)) do
            local profile = {realm=realm, guild=guild};
            if ( realm == currentRealm and guild == currentGuild ) then
                checked = 1;
                ArmoryDropDownMenu_SetSelectedValue(ArmoryGuildBankNameDropDown, profile);
            else
                checked = nil;
            end
            info = ArmoryDropDownMenu_CreateInfo();
            info.text = guild;
            info.func = ArmoryGuildBankNameDropDown_OnClick;
            info.value = profile;
            info.checked = checked;
            ArmoryDropDownMenu_AddButton(info);
        end
    end
end

function ArmoryGuildBankNameDropDown_OnClick(self)
    local profile = self.value;
    ArmoryDropDownMenu_SetSelectedValue(ArmoryGuildBankNameDropDown, profile);
    ArmoryGuildBankFrame_SelectGuild(profile.realm, profile.guild);
end

function ArmoryGuildBankFrameButton_OnEnter(self)
    if ( self.link ) then
        Armory:SetHyperlink(GameTooltip, self.link);
    end
end

function ArmoryGuildBankFrame_SelectGuild(realm, guild)
    local frame = ArmoryGuildBankFrame;
    local dbEntry, refresh = AGB:SelectDb(frame, realm, guild);

    ArmoryDropDownMenu_SetText(ArmoryGuildBankNameDropDown, frame.selectedGuild);

    if ( not frame.initialized or refresh ) then
        ArmoryGuildBankFrame.initialized = true;
        ArmoryListGuildBankFrame_ResetScrollBar();

        if ( dbEntry ) then
            ArmoryGuildBankFrame_UpdateGuildInfo(dbEntry);
            ArmoryGuildBankFrame_Update();
        end
    end
    
    return dbEntry;
end

function ArmoryGuildBankFrameTab_OnClick(self, id)
    ArmoryCloseDropDownMenus();
    ArmoryGuildBankFrameEnableIconView(id == 2);
end

function ArmoryGuildBankFrameEnableIconView(checked)
    AGB:SetIconViewMode(checked);
    if ( checked ) then
        HideUIPanel(ArmoryListGuildBankFrame);
        ShowUIPanel(ArmoryIconGuildBankFrame);
    else
        HideUIPanel(ArmoryIconGuildBankFrame);
        ShowUIPanel(ArmoryListGuildBankFrame);
    end
end

local function UpdateGuildInfo(dbEntry, frame)
    local tabardBackgroundUpper, tabardBackgroundLower, tabardEmblemUpper, tabardEmblemLower, tabardBorderUpper, tabardBorderLower = AGB:GetTabardFiles(dbEntry);
    local name = frame:GetName();

    if ( not tabardEmblemUpper ) then
        tabardBackgroundUpper = "Textures\\GuildEmblems\\Background_49_TU_U";
        tabardBackgroundLower = "Textures\\GuildEmblems\\Background_49_TL_U";
    end

    _G[name.."EmblemBackgroundUL"]:SetTexture(tabardBackgroundUpper);
    _G[name.."EmblemBackgroundUR"]:SetTexture(tabardBackgroundUpper);
    _G[name.."EmblemBackgroundBL"]:SetTexture(tabardBackgroundLower);
    _G[name.."EmblemBackgroundBR"]:SetTexture(tabardBackgroundLower);

    _G[name.."EmblemUL"]:SetTexture(tabardEmblemUpper);
    _G[name.."EmblemUR"]:SetTexture(tabardEmblemUpper);
    _G[name.."EmblemBL"]:SetTexture(tabardEmblemLower);
    _G[name.."EmblemBR"]:SetTexture(tabardEmblemLower);
    
    if ( _G[name.."EmblemBorderUL"] ) then
        _G[name.."EmblemBorderUL"]:SetTexture(tabardBorderUpper);
        _G[name.."EmblemBorderUR"]:SetTexture(tabardBorderUpper);
        _G[name.."EmblemBorderBL"]:SetTexture(tabardBorderLower);
        _G[name.."EmblemBorderBR"]:SetTexture(tabardBorderLower);
    end
end

function ArmoryGuildBankFrame_UpdateGuildInfo(dbEntry)
    if ( dbEntry ) then
        local factionGroup = AGB:GetFaction(dbEntry);
        if ( factionGroup ) then
            ArmoryGuildBankFactionFrameIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
        else
            ArmoryGuildBankFactionFrameIcon:SetTexture("");
        end

        UpdateGuildInfo(dbEntry, ArmoryListGuildBankFrame);
        UpdateGuildInfo(dbEntry, ArmoryIconGuildBankFrame);
    else
        AGB:UpdateGuildInfo();
    end
end

local function GetNoDataMessage(frame)
    local msg = ARMORY_GUILDBANK_NO_DATA;
    if ( frame.selectedRealm == AGB.realm and frame.selectedGuild == AGB.guild ) then
        msg = msg.."\n\n"..ARMORY_GUILDBANK_NO_TABS;
    end
    return msg;
end

function ArmoryGuildBankFrame_Update()
    local frame = ArmoryGuildBankFrame;
    local dbEntry = frame.selectedDbEntry;
    
    if ( AGB:GetIconViewMode() ) then
        ArmoryIconGuildBankFrame_UpdateTabs();
        MoneyFrame_Update("ArmoryIconGuildBankFrameMoneyFrame", AGB:GetMoney(dbEntry) or 0);

        if ( dbEntry and AGB:GetTabIcon(dbEntry, AGB.currentTab) ) then
            ArmoryIconGuildBankFrame_ShowColumns();
            ArmoryIconGuildBankErrorMessage:Hide();

            -- Update the tab items		
            local button, index, column;
            local name, link, texture, itemCount;
            for i = 1, ARMORY_MAX_GUILDBANK_SLOTS_PER_TAB do
                index = mod(i, ARMORY_NUM_SLOTS_PER_GUILDBANK_GROUP);
                if ( index == 0 ) then
                    index = ARMORY_NUM_SLOTS_PER_GUILDBANK_GROUP;
                end
                column = ceil((i - 0.5) / ARMORY_NUM_SLOTS_PER_GUILDBANK_GROUP);
                button = _G["ArmoryIconGuildBankColumn"..column.."Button"..index];
                button:SetID(i);
                
                name, link, texture, itemCount = AGB:GetTabSlotInfo(dbEntry, AGB.currentTab, i);
                
                SetItemButtonTexture(button, texture);
                SetItemButtonCount(button, itemCount);
                Armory:SetItemLink(button, nil);

                if ( name and Armory:MatchInventoryItem(frame.filter or "", name, link) ) then
                    button.searchOverlay:Hide();
                elseif ( frame.filter ~= "" or ArmoryItemFilter_IsEnabled() ) then
                    button.searchOverlay:Show();
                else
                    button.searchOverlay:Hide();
                end

                Armory:SetItemLink(button, link);
            end
        else
            ArmoryIconGuildBankFrame_HideColumns();
            ArmoryIconGuildBankErrorMessage:SetText(GetNoDataMessage(frame));
            ArmoryIconGuildBankErrorMessage:Show();
        end
    else
        AGB:UpdateItemLines(frame);
        MoneyFrame_Update("ArmoryListGuildBankFrameMoneyFrame", AGB:GetMoney(dbEntry) or 0);

        local numLines = #frame.itemLines;
        local offset = FauxScrollFrame_GetOffset(ArmoryListGuildBankScrollFrame);

        if ( numLines == 0 ) then
            ArmoryListGuildBankFrameMessage:SetText(GetNoDataMessage(frame));
            ArmoryListGuildBankFrameMessage:Show();
        else
            ArmoryListGuildBankFrameMessage:Hide();
        end

        if ( offset > numLines ) then
            offset = 0;
            FauxScrollFrame_SetOffset(ArmoryListGuildBankScrollFrame, offset);
        end

        -- ScrollFrame update
        FauxScrollFrame_Update(ArmoryListGuildBankScrollFrame, numLines, ARMORY_GUILDBANK_LINES_DISPLAYED, ARMORY_LOOKUP_HEIGHT);

        for i = 1, ARMORY_GUILDBANK_LINES_DISPLAYED do
            local lineIndex = i + offset;
            local lineButton = _G["ArmoryGuildBankLine"..i];
            local lineButtonText = _G["ArmoryGuildBankLine"..i.."Text"];
            local lineButtonDisabled = _G["ArmoryGuildBankLine"..i.."Disabled"];

            if ( lineIndex <= numLines ) then
                -- Set button widths if scrollbar is shown or hidden
                if ( ArmoryListGuildBankScrollFrame:IsShown() ) then
                    lineButtonText:SetWidth(265);
                    lineButtonDisabled:SetWidth(295);
                else
                    lineButtonText:SetWidth(285);
                    lineButtonDisabled:SetWidth(315);
                end

                local name, isHeader, count, texture, link = unpack(frame.itemLines[lineIndex]);
                local color;

                lineButton.link = link;
                if ( texture ) then
                    lineButton:SetNormalTexture(texture);
                else
                    lineButton:SetNormalTexture("");
                end

                if ( isHeader ) then
                    lineButton:Disable();
                else
                    if ( link ) then
                        color = link:match("^(|c%x+)|H");
                    end
                    name = (color or HIGHLIGHT_FONT_COLOR_CODE)..name..FONT_COLOR_CODE_CLOSE.." x "..count;
                    lineButton:Enable();
                end
                lineButton:SetText(name);
                lineButton:Show();
            else
                lineButton:Hide();
            end
        end
    end    

    if ( table.getn(AGB:RealmList()) > 1 or table.getn(AGB:GuildList(frame.selectedRealm or AGB.realm)) > 1 ) then
        ArmoryGuildBankNameDropDownButton:Enable();
    else
        ArmoryGuildBankNameDropDownButton:Disable();
    end
end

function ArmoryGuildBankFrame_Refresh()
    local frame = ArmoryGuildBankFrame;
    if ( frame.selectedRealm == AGB.realm and frame.selectedGuild == (AGB.guild or frame.selectedGuild) ) then
        if ( ArmoryListGuildBankFrame:IsShown() or ArmoryIconGuildBankFrame:IsShown() ) then
            ArmoryGuildBankFrame_Update();
        end
    end
end

function ArmoryGuildBankFrame_Delete()
    local frame = ArmoryGuildBankFrame;

    if ( frame.selectedRealm and frame.selectedGuild ) then
        AGB:DeleteDb(frame.selectedRealm, frame.selectedGuild);
        frame.initialized = nil;
        
        if ( ArmoryGuildBankFrame_SelectGuild() ) then
            ArmoryGuildBankNameDropDown_Initialize();
        else
            ArmoryListGuildBankFrame:Hide();
            ArmoryIconGuildBankFrame:Hide();
        end
    end
end

function ArmoryListGuildBankFrame_OnLoad(self)
    InitGuildBankFrame(self);

    SetPortraitToTexture("ArmoryListGuildBankFramePortrait", "Interface\\LFGFrame\\BattlenetWorking4");
    
    ArmoryListGuildBankFrame_ResetScrollBar();
end

function ArmoryListGuildBankFrame_ResetScrollBar()
    FauxScrollFrame_SetOffset(ArmoryListGuildBankScrollFrame, 0);
    ArmoryListGuildBankScrollFrameScrollBar:SetMinMaxValues(0, 0); 
    ArmoryListGuildBankScrollFrameScrollBar:SetValue(0);
end

function ArmoryListGuildBankFrame_AllignCommonControls(self)
    ArmoryGuildBankFrameDeleteButton:SetParent(self);
    ArmoryGuildBankFrameDeleteButton:SetWidth(60);
    ArmoryGuildBankFrameDeleteButton:ClearAllPoints();
    ArmoryGuildBankFrameDeleteButton:SetPoint("TOPLEFT", self, "TOPLEFT", 7, -6);

    ArmoryGuildBankFactionFrame:SetParent(self);
    ArmoryGuildBankFactionFrame:ClearAllPoints();
    ArmoryGuildBankFactionFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 28, -74);
    
    ArmoryGuildBankFrameEditBox:SetParent(self);
    ArmoryGuildBankFrameEditBox:ClearAllPoints();
    ArmoryGuildBankFrameEditBox:SetPoint("TOPRIGHT", self, "TOPRIGHT", -45, -45);

    ArmoryGuildBankFilterDropDown:SetParent(self);
    ArmoryGuildBankFilterDropDown:ClearAllPoints();
    ArmoryGuildBankFilterDropDown:SetPoint("TOPRIGHT", "ArmoryGuildBankFrameEditBox", "BOTTOMRIGHT", 16, 0);

    ArmoryGuildBankNameDropDown:SetParent(self);
    ArmoryGuildBankNameDropDown:ClearAllPoints();
    ArmoryGuildBankNameDropDown:SetPoint("RIGHT", "ArmoryGuildBankFilterDropDown", "LEFT", 30, 0);
end

function ArmoryIconGuildBankFrame_OnLoad(self)
    InitGuildBankFrame(self);
    
    -- Set the button id's
    local index, column, button;
    for i = 1, ARMORY_MAX_GUILDBANK_SLOTS_PER_TAB do
        index = mod(i, ARMORY_NUM_SLOTS_PER_GUILDBANK_GROUP);
        if ( index == 0 ) then
            index = ARMORY_NUM_SLOTS_PER_GUILDBANK_GROUP;
        end
        column = ceil((i - 0.5) / ARMORY_NUM_SLOTS_PER_GUILDBANK_GROUP);
        button = _G["ArmoryIconGuildBankColumn"..column.."Button"..index];
        button:SetID(i);
    end

    AGB.currentTab = 1;
end

function ArmoryIconGuildBankFrame_AllignCommonControls(self)
    ArmoryGuildBankFrameDeleteButton:SetParent(self);
    ArmoryGuildBankFrameDeleteButton:SetWidth(90);
    ArmoryGuildBankFrameDeleteButton:ClearAllPoints();
    ArmoryGuildBankFrameDeleteButton:SetPoint("TOP", "ArmoryIconGuildBankFrameEmblemFrame", "TOP", 75, -10);

    ArmoryGuildBankFactionFrame:SetParent(self);
    ArmoryGuildBankFactionFrame:ClearAllPoints();
    ArmoryGuildBankFactionFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 15, -15);

    ArmoryGuildBankFrameEditBox:SetParent(self);
    ArmoryGuildBankFrameEditBox:ClearAllPoints();
    ArmoryGuildBankFrameEditBox:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -20, 37);

    ArmoryGuildBankFilterDropDown:SetParent(self);
    ArmoryGuildBankFilterDropDown:ClearAllPoints();
    ArmoryGuildBankFilterDropDown:SetPoint("TOPRIGHT", self, "TOPRIGHT", 16, -38);

    ArmoryGuildBankNameDropDown:SetParent(self);
    ArmoryGuildBankNameDropDown:ClearAllPoints();
    ArmoryGuildBankNameDropDown:SetPoint("TOPLEFT", self, "TOPLEFT", 7, -38);
end

function ArmoryIconGuildBankFrame_HideColumns()
    if ( not ArmoryIconGuildBankColumn1:IsShown() ) then
        return;
    end
    for i = 1, ARMORY_NUM_GUILDBANK_COLUMNS do
        _G["ArmoryIconGuildBankColumn"..i]:Hide();
    end
end

function ArmoryIconGuildBankFrame_ShowColumns()
    if ( ArmoryIconGuildBankColumn1:IsShown() ) then
        return;
    end
    for i = 1, ARMORY_NUM_GUILDBANK_COLUMNS do
        _G["ArmoryIconGuildBankColumn"..i]:Show();
    end
end

function ArmoryIconGuildBankFrame_UpdateTabs()
    local dbEntry = ArmoryGuildBankFrame.selectedDbEntry;
    
    if ( dbEntry ) then
        local tab, tabButton, iconTexture;
        local name, count, link, texture, timestamp;
        for i = 1, MAX_GUILDBANK_TABS do
            tab = _G["ArmoryIconGuildBankTab"..i];
            tabButton = _G["ArmoryIconGuildBankTab"..i.."Button"];
            iconTexture = _G["ArmoryIconGuildBankTab"..i.."ButtonIconTexture"];

            if ( AGB:TabExists(dbEntry, i) ) then
                name = AGB:GetTabName(dbEntry, i);
                if ( (name or "") == "" ) then
                    name = string.format(GUILDBANK_TAB_NUMBER, i);
                end
                tabButton.tooltip = name;

                iconTexture:SetTexture(AGB:GetTabIcon(dbEntry, i) or "Interface\\Icons\\Temp");
                if ( i == AGB.currentTab ) then
                    tabButton:SetChecked(1);
                    
                    timestamp = AGB:GetTabTimestamp(dbEntry, i);
                    if ( timestamp > 0 ) then
                        ArmoryIconGuildBankUpdateLabel:SetText(date("%x %H:%M", timestamp));
                    else
                        ArmoryIconGuildBankUpdateLabel:SetText(UNKNOWN);
                    end

                    ArmoryIconGuildBankTabTitle:SetText(name);
                    ArmoryIconGuildBankTabTitleBackground:SetWidth(ArmoryIconGuildBankTabTitle:GetWidth()+20);

                    ArmoryIconGuildBankTabTitle:Show();
                    ArmoryIconGuildBankTabTitleBackground:Show();
                    ArmoryIconGuildBankTabTitleBackgroundLeft:Show();
                    ArmoryIconGuildBankTabTitleBackgroundRight:Show();
                else
                    tabButton:SetChecked(nil);
                end
                tab:Show();
            else
                tab:Hide();
            end
        end
    end
end

function ArmoryIconGuildBankTab_OnClick(self, button, currentTab)
    if ( not currentTab ) then
        currentTab = self:GetParent():GetID();
    end
    AGB.currentTab = currentTab;
    ArmoryGuildBankFrame_Update();
end

----------------------------------------------------------
-- Hooks
----------------------------------------------------------

hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", 
    function(self, button)
        local bag = self:GetParent():GetID();
        local slot = self:GetID();
        ArmoryGuildBankFramePasteItem(button, GetContainerItemLink(bag, slot));
    end
);

hooksecurefunc("ChatFrame_OnHyperlinkShow", 
    function(self, link, text, button)
        ArmoryGuildBankFramePasteItem(button, link);
    end
);

local function IsTabViewable(tab)
    local view = false;
    for i = 1, MAX_GUILDBANK_TABS do
    local _, _, isViewable = GetGuildBankTabInfo(i);
        if ( isViewable ) then
            if ( i == tab ) then
                view = true;
            end
        end
    end
    return view;
end

local Orig_CloseGuildBankFrame = CloseGuildBankFrame;
function CloseGuildBankFrame(...)
    if ( AGB.tabs ) then
        for tab in pairs(AGB.tabs) do
            AGB:RemoveFromQueue(tab);
        
            local name, icon = GetGuildBankTabInfo(tab);
            local items = {};
            local slots = {};
            local itemString, link, count;
            for i = 1, ARMORY_MAX_GUILDBANK_SLOTS_PER_TAB do
                link = GetGuildBankItemLink(tab, i);
                if ( link ) then
                    _, count = GetGuildBankItemInfo(tab, i);
                    itemString = Armory:GetItemString(link);
                    items[itemString] = (items[itemString] or 0) + count;
                    slots[tostring(i)] = itemString..";"..count;
                end
            end

            local ids = {};
            for itemString, count in pairs(items) do
                table.insert(ids, itemString..count);
            end
            table.sort(ids);

            AGB:UpdateTabName(tab, name);
            AGB:UpdateTabIcon(tab, icon);
            AGB:UpdateTabItems(tab, items, slots, AGB:Checksum(table.concat(ids)));
        end
    end

    for tab = 1, GetNumGuildBankTabs() do
        if ( not IsTabViewable(tab) ) then
            AGB:DeleteTab(tab);
        end
    end

    AGB:UpdateMoney();
    AGB:UpdateTimestamp();

    ArmoryGuildBankFrame_Refresh();
    ArmoryInventoryGuildBankFrame_Refresh();
    
    AGB:Push();

    return Orig_CloseGuildBankFrame(...);
end

local Orig_ArmoryChatCommand = Armory.ChatCommand;
function Armory:ChatCommand(msg)
    local args = self:String2Table(msg);
    local command;
    if ( args and args[1] ) then
        command = strlower(args[1]);
    end
    if ( command == "gb" or command == "guildbank" ) then
        ArmoryGuildBankFrame_Toggle();
    else
        Orig_ArmoryChatCommand(self, msg);
    end
end

local Orig_Armory_InitializeMenu = Armory.InitializeMenu;
function Armory:InitializeMenu()
    Orig_Armory_InitializeMenu();
    if ( ARMORY_DROPDOWNMENU_MENU_LEVEL == 1 ) then 
        Armory:MenuAddButton("ARMORY_CMD_GUILDBANK");
    end
end

local detailCounts = {};
local function AddGuildBankCount(item, itemCounts)
    local frame = ArmoryGuildBankFrame;
    local currentRealm, currentGuild = frame.selectedRealm, frame.selectedGuild;

    if ( item and AGB:GetConfigShowItemCount() ) then
        local itemName, itemString;
        if ( type(item) == "table" ) then
            itemName = unpack(item);
            itemString = Armory:GetCachedItemString(itemName);
        elseif ( item:find("|H") ) then
            itemName = Armory:GetNameFromLink(item);
            itemString = Armory:GetItemString(item);
            Armory:CheckUnknownCacheItems(itemName, itemString);
        else
            itemName = item;
            itemString = Armory:GetCachedItemString(itemName);
        end

        local dbEntry, count, info, items, name, link, itemCount;
        for realm, guilds in pairs(AgbDB) do
            if ( AGB:GetConfigGlobalItemCount() or realm == AGB.realm ) then
                for guild in pairs(guilds) do
                    dbEntry = AGB:SelectDb(frame, realm, guild);
                    if ( AGB:GetConfigCrossFactionItemCount() or _G.UnitFactionGroup("player") == AGB:GetFaction(dbEntry) ) then
                        count = 0;
                        table.wipe(detailCounts);
                        for tab = 1, MAX_GUILDBANK_TABS do
                            local tabCount;
                            if ( itemString ) then
                                tabCount = AGB:GetItemCount(dbEntry, tab, itemString);
                            else
                                items = AGB:GetTabItems(dbEntry, tab);
                                if ( items ) then
                                    for itemId in pairs(items) do
                                        name, link, _, itemCount = AGB:GetTabItemInfo(dbEntry, tab, itemId);
                                        if ( name and strtrim(name) == strtrim(itemName) ) then
                                            itemString = Armory:SetCachedItemString(name, link);
                                            tabCount = itemCount;
                                            break;
                                        end
                                    end
                                end
                            end
                            if ( tabCount ) then
                                count = count + tabCount;
                                table.insert(detailCounts, format(GUILDBANK_TAB_NUMBER, tab).." "..tabCount);
                            end
                        end
                        if ( count > 0 ) then
                            info = { name=guild, count=count, details="("..table.concat(detailCounts, ", ")..")" };
                            if ( AGB:GetConfigCrossFactionItemCount() ) then
                                info.name = info.name .. "@" .. realm;
                            end
                            if ( AGB:GetConfigUniItemCountColor() ) then
                                SetTableColor(info, Armory:GetConfigItemCountColor());
                            else
                                SetTableColor(info, AGB:GetConfigItemCountColor());
                            end
                            table.insert(itemCounts, info);
                        end
                    end
                end
            end
        end
        AGB:SelectDb(frame, currentRealm, currentGuild);
    end
end

local Orig_ArmoryGetItemCount = Armory.GetItemCount;
function Armory:GetItemCount(link)
    local itemCounts = Orig_ArmoryGetItemCount(self, link);

    if ( AGB:GetConfigShowItemCount() ) then
        AddGuildBankCount(link, itemCounts);
    end
    
    return itemCounts;
end

local Orig_ArmoryGetMultipleItemCount = Armory.GetMultipleItemCount;
function Armory:GetMultipleItemCount(items)
    local itemCounts = Orig_ArmoryGetMultipleItemCount(self, items);

    if ( AGB:GetConfigShowItemCount() ) then
        for i = 1, #items do
            AddGuildBankCount(items[i], itemCounts[i]);
        end
    end

    return itemCounts;
end

function ArmoryGuildBankFramePasteItem(button, link)
    if ( not ArmoryGuildBankFrameEditBox:IsVisible() ) then
        return;
    elseif ( button == "LeftButton" and IsAltKeyDown() ) then
        local itemName = GetItemInfo(link);
        if ( itemName ) then
            ArmoryGuildBankFrameEditBox:SetText(itemName);
        end
    end
end
