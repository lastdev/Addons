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

ARMORY_LOOKUP_LINES_DISPLAYED = 19;
ARMORY_LOOKUP_HEIGHT = 16;

ARMORY_LOOKUP_SKILLS = {
    ARMORY_TRADE_ALCHEMY = "AL",
    ARMORY_TRADE_BLACKSMITHING = "BS",
    ARMORY_TRADE_COOKING = "CO",
    ARMORY_TRADE_ENCHANTING = "EC",
    ARMORY_TRADE_ENGINEERING = "EG",
    --ARMORY_TRADE_FIRST_AID = "FA",
    ARMORY_TRADE_JEWELCRAFTING = "JC",
    ARMORY_TRADE_LEATHERWORKING = "LW",
    --ARMORY_TRADE_POISONS = "PO", 
    ARMORY_TRADE_TAILORING = "TA",
    ARMORY_TRADE_INSCRIPTION = "IN",
};

ARMORY_LOOKUP_TYPE = { LOOKUP_RECIPE = "R", LOOKUP_QUEST = "Q", LOOKUP_CHARACTER = "C", LOOKUP_DOWNLOAD = "D", LOOKUP_ITEM = "I" };

function ArmoryLookupFrame_Toggle()
    if ( ArmoryLookupFrame:IsShown() ) then
        HideUIPanel(ArmoryLookupFrame);
    elseif ( Armory:HasDataSharing() ) then
        ShowUIPanel(ArmoryLookupFrame);
    else
        Armory:PrintRed(ARMORY_LOOKUP_DISABLED);
    end
end

function ArmoryLookupFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("PLAYER_TARGET_CHANGED");
    self:RegisterEvent("PLAYER_GUILD_UPDATE");
    self:RegisterEvent("GROUP_ROSTER_UPDATE");
    self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");

    self:SetAttribute("UIPanelLayout-defined", true);
    self:SetAttribute("UIPanelLayout-enabled", true);
    self:SetAttribute("UIPanelLayout-area", "left");
    self:SetAttribute("UIPanelLayout-pushable", 5);
    self:SetAttribute("UIPanelLayout-whileDead", true);

    table.insert(UISpecialFrames, "ArmoryLookupFrame");

    self.data = {};
    self.ownerData = {};
    self.type = ARMORY_LOOKUP_TYPE.LOOKUP_RECIPE;
    self.updateDelay = 0;

    SetPortraitToTexture("ArmoryLookupFramePortrait", "Interface\\Icons\\INV_Misc_QuestionMark");

    ArmoryDropDownMenu_Initialize(ArmoryLookupChannelDropDown, ArmoryLookupChannelDropDown_Initialize);
    ArmoryDropDownMenu_SetWidth(ArmoryLookupChannelDropDown, 75);

    ArmoryDropDownMenu_Initialize(ArmoryLookupTradeSkillDropDown, ArmoryLookupTradeSkillDropDown_Initialize);
    ArmoryDropDownMenu_SetWidth(ArmoryLookupTradeSkillDropDown, 115);
    ArmoryDropDownMenu_SetSelectedValue(ArmoryLookupTradeSkillDropDown, "ARMORY_TRADE_ENCHANTING");

    ArmoryDropDownMenu_Initialize(ArmoryLookupQuestDropDown, ArmoryLookupQuestDropDown_Initialize);
    ArmoryDropDownMenu_SetWidth(ArmoryLookupQuestDropDown, 115);
    ArmoryDropDownMenu_SetSelectedID(ArmoryLookupQuestDropDown, 1);

    ArmoryDropDownMenu_Initialize(ArmoryLookupTypeDropDown, ArmoryLookupTypeDropDown_Initialize);
    ArmoryDropDownMenu_SetWidth(ArmoryLookupTypeDropDown, 90);
    ArmoryDropDownMenu_SetSelectedValue(ArmoryLookupTypeDropDown, ARMORY_LOOKUP_TYPE.LOOKUP_RECIPE);

    FauxScrollFrame_SetOffset(ArmoryLookupScrollFrame, 0);
    ArmoryLookupScrollFrameScrollBar:SetMinMaxValues(0, 0); 
    ArmoryLookupScrollFrameScrollBar:SetValue(0);

    ArmoryLookupFrameEditBox:SetText(SEARCH);

    ArmoryAddonMessageFrame_RegisterHandlers(ArmoryLookupFrame_CheckResponse, ArmoryLookupFrame_ProcessRequest);
end

function ArmoryLookupFrame_OnEvent(self, event, ...)
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self.data = {};
        self.ownerData = {};
        self.type = ARMORY_LOOKUP_TYPE.LOOKUP_RECIPE;
    elseif ( event == "PLAYER_TARGET_CHANGED" ) then
        if ( ArmoryLookupFrame_IsTargetSelected() and self.type == ARMORY_LOOKUP_TYPE.LOOKUP_CHARACTER ) then
            ArmoryLookupFrameEditBox:SetText(UnitName("target"));
        end
    end

    if ( event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_GUILD_UPDATE" or event == "GROUP_ROSTER_UPDATE"
          or (event == "CHAT_MSG_CHANNEL_NOTICE" and not Armory.channel) ) then
        ArmoryCloseDropDownMenus();
        ArmoryDropDownMenu_Initialize(ArmoryLookupChannelDropDown, ArmoryLookupChannelDropDown_Initialize);
        ArmoryLookupFrame_UpdateLookupButton();
    end
end

function ArmoryLookupFrame_OnUpdate(self, elapsed)
    self.updateDelay = self.updateDelay + elapsed;

    if ( self.updateDelay < 0.5 ) then
        return;
    elseif ( self.type == ARMORY_LOOKUP_TYPE.LOOKUP_ITEM ) then
        local update, name, link;
        for _, item in ipairs(self.data) do
            if ( item.name == RETRIEVING_ITEM_INFO ) then
                name, link = Armory:GetInfoFromId("item", item.id);
                if ( (name or "") ~= "" ) then
                    item.name = name;
                    item.link = link;
                    item.display = name.." "..item.count.."x";
                    update = true;
                end
            end
        end
        if ( update ) then
            ArmoryLookupFrame_Update();
        end
    end
    
    ArmoryLookupFrame_UpdateTarget();

    self.updateDelay = 0;
end

function ArmoryLookupFrame_OnShow(self)
    if ( self.type == ARMORY_LOOKUP_TYPE.LOOKUP_RECIPE ) then
        ArmoryLookupTradeSkillDropDown:Show();
        ArmoryLookupQuestDropDown:Hide();
        ArmoryLookupFrameSearchExactCheckButton:Show();
        ArmoryLookupFrameTitleText:SetText(ARMORY_LOOKUP_SKILL);
    elseif ( self.type == ARMORY_LOOKUP_TYPE.LOOKUP_QUEST ) then
        ArmoryLookupTradeSkillDropDown:Hide();
        ArmoryLookupQuestDropDown:Show();
        ArmoryLookupFrameSearchExactCheckButton:Show();
        ArmoryLookupFrameTitleText:SetText(ARMORY_LOOKUP_QUEST);
    elseif ( self.type == ARMORY_LOOKUP_TYPE.LOOKUP_CHARACTER ) then
        ArmoryLookupTradeSkillDropDown:Hide();
        ArmoryLookupQuestDropDown:Hide();
        ArmoryLookupFrameSearchExactCheckButton:Hide();
        ArmoryLookupFrameTitleText:SetText(ARMORY_LOOKUP_CHARACTER);
    elseif ( self.type == ARMORY_LOOKUP_TYPE.LOOKUP_ITEM ) then
        ArmoryLookupTradeSkillDropDown:Hide();
        ArmoryLookupQuestDropDown:Hide();
        ArmoryLookupFrameSearchExactCheckButton:Show();
        ArmoryLookupFrameTitleText:SetText(ARMORY_LOOKUP_ITEM);
    end
    ArmoryDropDownMenu_Initialize(ArmoryLookupChannelDropDown, ArmoryLookupChannelDropDown_Initialize);
    ArmoryLookupFrame_UpdateLookupButton();
    ArmoryLookupFrame_Update();
end

function ArmoryLookupFrameButton_OnClick(self, button)
    local id = self:GetID();

    if ( IsModifiedClick("CHATLINK") and self.link ) then
        HandleModifiedItemClick(self.link);

    elseif ( id > 0 ) then
        local item = ArmoryLookupFrame.data[id];
        if ( self.func ) then
            item.isExpanded = nil;
            self.func(item);
        else
            item.isExpanded = not item.isExpanded;
            ArmoryLookupFrame_Update();
        end

    elseif ( self.player and button == "RightButton" ) then
        ChatFrame_SendTell(self.player);

    elseif ( self.player and IsShiftKeyDown() ) then
        SendWho(WHO_TAG_NAME..self.player);

    elseif ( self.owner and ArmoryLookupFrame.ownerData[self.owner] ) then
        local link = ArmoryLookupFrame.ownerData[self.owner].recipeList;
        if ( link ) then
            SetItemRef(link);
        end

    end
end

function ArmoryLookupExpandAllButton_OnClick(self)
    if ( self.collapsed ) then
        self.collapsed = nil;
    else
        self.collapsed = 1;
        ArmoryLookupScrollFrameScrollBar:SetValue(0);
    end
    for _, item in ipairs(ArmoryLookupFrame.data) do
        if ( not item.func ) then
            item.isExpanded = not self.collapsed;
        end
    end
    ArmoryLookupFrame_Update();
end

function ArmoryLookupFrameButton_OnEnter(self)
    if ( self.link ) then
        Armory:SetHyperlink(GameTooltip, self.link);
    elseif ( self.owner and not self.func ) then
        if ( ArmoryLookupFrame.ownerData[self.owner] ) then
            GameTooltip:AddLine(ARMORY_LOOKUP_DETAIL);
        else
            GameTooltip:AddLine(ARMORY_LOOKUP_NODETAIL);
        end
    end
    if ( self.player ) then
        GameTooltip:AddLine(ARMORY_LOOKUP_PLAYER_HINT, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
    end
    GameTooltip:Show();
end

function ArmoryLookupFrameEditBox_OnTextChanged(self)
    ArmoryLookupFrame_UpdateLookupButton();
end

function ArmoryLookupFrame_OnChar(self, text)
    local pattern = "(["..strjoin("%", ARMORY_MESSAGE_SEPARATOR, ARMORY_LOOKUP_SEPARATOR, ARMORY_LOOKUP_FIELD_SEPARATOR, ARMORY_LOOKUP_CONTENT_SEPARATOR).."])";
    if ( text:match(pattern) ) then
        self:SetText(self:GetText():gsub(pattern, "", 1));
    end
end

function ArmoryLookupFrameEditBox_OnEnterPressed(self)
    if ( ArmoryLookupButton:IsEnabled() == 1 ) then
        ArmoryLookupButton_OnClick(ArmoryLookupButton);
    end
end

function ArmoryLookupChannelDropDown_Initialize()
    local info = ArmoryDropDownMenu_CreateInfo();
    local value = ArmoryDropDownMenu_GetSelectedValue(ArmoryLookupChannelDropDown) or "NONE";
    local numChannels = 0;
    local checked;

    local channels = {
        CHANNEL = function() return Armory.channel end,
        TARGET = ArmoryLookupFrame_IsTargetSelected,
        GUILD = function() return IsInGuild() end,
        RAID = function() return IsInRaid() end,
        PARTY = function() return IsInGroup() and not IsInRaid() end
    };

    info.func = ArmoryLookupChannelDropDown_OnClick;
    info.owner = ARMORY_DROPDOWNMENU_OPEN_MENU;

    for channel, enable in pairs(channels) do
        if ( enable() ) then
            info.text = _G[channel];
            info.value = channel;
            if ( channel == value ) then
                info.checked = 1;
                checked = value;
            else
                info.checked = nil;
            end
            ArmoryDropDownMenu_AddButton(info);
            numChannels = numChannels + 1;
        end
    end

    if ( numChannels == 0 ) then
        info.text = NONE;
        info.value = "NONE";
        info.checked = 1;
        ArmoryDropDownMenu_AddButton(info);
    end

    if ( checked ) then
        ArmoryDropDownMenu_SetSelectedValue(ArmoryLookupChannelDropDown, checked);
    else
        ArmoryDropDownMenu_SetSelectedValue(ArmoryLookupChannelDropDown, ArmoryDropDownMenu_GetValue(1));
    end

    ArmoryLookupChannelDropDown.numChannels = numChannels;
end

function ArmoryLookupChannelDropDown_OnClick(self)
    ArmoryDropDownMenu_SetSelectedValue(ArmoryLookupChannelDropDown, self.value);
    ArmoryLookupFrame_UpdateTarget();
    ArmoryLookupFrame_UpdateAutoComplete();
end

local skills = {};
function ArmoryLookupTradeSkillDropDown_Initialize()
    local info = ArmoryDropDownMenu_CreateInfo();

    info.func = ArmoryLookupTradeSkillDropDown_OnClick;
    info.owner = ARMORY_DROPDOWNMENU_OPEN_MENU;

    table.wipe(skills);
    for skill in pairs(ARMORY_LOOKUP_SKILLS) do
        table.insert(skills, skill);
    end
    table.sort(skills, function(a, b) return _G[a] < _G[b] end);

    for _, skill in ipairs(skills) do
        info.text = _G[skill];
        info.value = skill;
        info.checked = nil;
        ArmoryDropDownMenu_AddButton(info);
    end
    table.wipe(skills);
end

function ArmoryLookupTradeSkillDropDown_OnClick(self)
    ArmoryDropDownMenu_SetSelectedValue(ArmoryLookupTradeSkillDropDown, self.value);
end

function ArmoryLookupQuestDropDown_Initialize()
    local info = ArmoryDropDownMenu_CreateInfo();

    info.func = ArmoryLookupQuestDropDown_OnClick;
    info.owner = ARMORY_DROPDOWNMENU_OPEN_MENU;

    info.text = ARMORY_LOOKUP_QUEST_NAME;
    info.checked = nil;
    ArmoryDropDownMenu_AddButton(info);

    info.text = ARMORY_LOOKUP_QUEST_AREA;
    info.checked = nil;
    ArmoryDropDownMenu_AddButton(info);
end

function ArmoryLookupQuestDropDown_OnClick(self)
    ArmoryDropDownMenu_SetSelectedID(ArmoryLookupQuestDropDown, self:GetID());
end

function ArmoryLookupTypeDropDown_Initialize()
    local info = ArmoryDropDownMenu_CreateInfo();

    info.func = ArmoryLookupTypeDropDown_OnClick;
    info.owner = ARMORY_DROPDOWNMENU_OPEN_MENU;

    info.text = SKILLS;
    info.value = ARMORY_LOOKUP_TYPE.LOOKUP_RECIPE;
    info.checked = nil;
    ArmoryDropDownMenu_AddButton(info);

    info.text = QUESTS_LABEL;
    info.value = ARMORY_LOOKUP_TYPE.LOOKUP_QUEST; 
    info.checked = nil;
    ArmoryDropDownMenu_AddButton(info);

    info.text = CHARACTER;
    info.value = ARMORY_LOOKUP_TYPE.LOOKUP_CHARACTER;
    info.checked = nil;
    ArmoryDropDownMenu_AddButton(info);

    info.text = ITEMS;
    info.value = ARMORY_LOOKUP_TYPE.LOOKUP_ITEM;
    info.checked = nil;
    info.disabled = ArmoryDropDownMenu_GetSelectedValue(ArmoryLookupChannelDropDown) ~= "CHANNEL";
    ArmoryDropDownMenu_AddButton(info);
end

function ArmoryLookupTypeDropDown_OnClick(self)
    local text = ArmoryLookupFrameEditBox:GetText();

    ArmoryLookupFrameEditBox:ClearFocus();
    ArmoryDropDownMenu_SetSelectedValue(ArmoryLookupTypeDropDown, self.value);
    if ( self.value ~= ArmoryLookupFrame.type ) then
        table.wipe(ArmoryLookupFrame.data);
        table.wipe(ArmoryLookupFrame.ownerData);
        ArmoryLookupFrame.type = self.value;
        if ( self.value == ARMORY_LOOKUP_TYPE.LOOKUP_CHARACTER and text == SEARCH ) then
            if ( ArmoryLookupFrame_IsTargetSelected() ) then
                text = UnitName("target");
            else
                text = NAME;
            end
        elseif ( text == NAME ) then
            text = SEARCH;
        end
        ArmoryLookupFrame_UpdateAutoComplete();
        ArmoryLookupFrameEditBox:SetText(text);
        ArmoryLookupFrame_OnShow(ArmoryLookupFrame);
    end
end

function ArmoryLookupButton_OnClick(self)
    ArmoryLookupFrame_SendRequest();
end

function ArmoryLookupFrame_UpdateTarget()
    local channel = ArmoryDropDownMenu_GetSelectedValue(ArmoryLookupChannelDropDown) or "NONE";
    local onlinecount = 0;
    local online;
    if ( channel == "TARGET" and UnitExists("target") ) then
        ArmoryLookupFrameTargetText:SetText(UnitName("target"));
    elseif ( channel == "GUILD" ) then
        if ( GetNumGuildMembers() == 0 ) then
            GuildRoster();
        end
        for i = 1, GetNumGuildMembers() do
            _, _, _, _, _, _, _, _, online = GetGuildRosterInfo(i);
            if ( online ) then
                onlinecount = onlinecount + 1;
            end
        end
        ArmoryLookupFrameTargetText:SetFormattedText(GUILD_TOTAL, onlinecount);
    elseif ( channel == "RAID" ) then
        ArmoryLookupFrameTargetText:SetFormattedText(NUM_RAID_MEMBERS, GetNumGroupMembers());
    elseif ( channel == "PARTY" or channel == "CHANNEL" ) then
        ArmoryLookupFrameTargetText:SetText("");
    else
        ArmoryLookupFrameTargetText:SetText(ERR_GENERIC_NO_TARGET);
    end
    
    if ( channel ~= "CHANNEL" and ArmoryDropDownMenu_GetSelectedValue(ArmoryLookupTypeDropDown) == ARMORY_LOOKUP_TYPE.LOOKUP_ITEM ) then
        ArmoryLookupFrame.type = ARMORY_LOOKUP_TYPE.LOOKUP_RECIPE;
        ArmoryDropDownMenu_Initialize(ArmoryLookupTypeDropDown, ArmoryLookupTypeDropDown_Initialize);
        ArmoryDropDownMenu_SetSelectedValue(ArmoryLookupTypeDropDown, ArmoryLookupFrame.type);
        ArmoryLookupFrame_OnShow(ArmoryLookupFrame);
    end
end

function ArmoryLookupFrame_UpdateLookupButton()
    local text = ArmoryLookupFrameEditBox:GetText();

    if ( text ~= SEARCH and text ~= NAME and strlen(text) > 0 and ArmoryLookupChannelDropDown.numChannels > 0 ) then
        ArmoryLookupButton:Enable();    
    else
        ArmoryLookupButton:Disable();
    end
end

function ArmoryLookupFrame_UpdateAutoComplete()
    local id = ArmoryLookupFrame.type;
   
    ArmoryLookupFrameEditBox.autoCompleteParams = nil;
    if ( id == ARMORY_LOOKUP_TYPE.LOOKUP_CHARACTER ) then
        local channel = ArmoryDropDownMenu_GetSelectedValue(ArmoryLookupChannelDropDown) or "NONE";
        if ( channel == "GUILD" ) then
            ArmoryLookupFrameEditBox.autoCompleteParams = AUTOCOMPLETE_LIST_TEMPLATES.IN_GUILD;
        elseif ( channel == "RAID" or channel == "PARTY" ) then
            ArmoryLookupFrameEditBox.autoCompleteParams = AUTOCOMPLETE_LIST_TEMPLATES.IN_GROUP;
        end
    end
end

local lines = {};
function ArmoryLookupFrame_Update()
    table.wipe(lines);
    for i, item in ipairs(ArmoryLookupFrame.data) do
        table.insert(lines, {mainIndex=i});
        if ( item.isExpanded ) then
            for j = 1, table.getn(item.values) do
                table.insert(lines, {mainIndex=i, valueIndex=j});
            end
        end
    end

    local numLines = #lines;
    local offset = FauxScrollFrame_GetOffset(ArmoryLookupScrollFrame);

    if ( offset > numLines ) then
        offset = 0;
        FauxScrollFrame_SetOffset(ArmoryLookupScrollFrame, offset);
    end

    -- ScrollFrame update
    FauxScrollFrame_Update(ArmoryLookupScrollFrame, numLines, ARMORY_LOOKUP_LINES_DISPLAYED, ARMORY_LOOKUP_HEIGHT);

    for i = 1, ARMORY_LOOKUP_LINES_DISPLAYED do
        local lineIndex = i + offset;
        local lineButton = _G["ArmoryLookupLine"..i];
        local lineButtonText = _G["ArmoryLookupLine"..i.."Text"];
        local lineButtonHighlight = _G["ArmoryLookupLine"..i.."Highlight"];

        if ( lineIndex <= numLines ) then
            local indices = lines[lineIndex];
            local item = ArmoryLookupFrame.data[indices.mainIndex];
            local isHeader = (not indices.valueIndex);
            local color, text;
            if ( isHeader ) then
                lineButton:SetID(indices.mainIndex);
            else
                item = item.values[indices.valueIndex];
                lineButton:SetID(0);
            end
            lineButton.player = item.source;
            lineButton.owner = item.owner;
            lineButton.link = item.link;
            lineButton.func = item.func;
            if ( item.name == RETRIEVING_ITEM_INFO ) then
                color = RED_FONT_COLOR_CODE;
            elseif ( item.link ) then
                color = item.link:match("^(|c%x+)|H");
            end
            if ( item.icon ) then
                lineButton:SetNormalTexture(item.icon);
            else
                lineButton:SetNormalTexture("");
            end

            text = (color or HIGHLIGHT_FONT_COLOR_CODE)..(item.display or item.name)..FONT_COLOR_CODE_CLOSE;
            if ( item.isMine ) then
                text = text..GREEN_FONT_COLOR_CODE.."*"..FONT_COLOR_CODE_CLOSE;
            end
            lineButton:SetText(text);

            -- Set button widths if scrollbar is shown or hidden
            if ( ArmoryLookupScrollFrame:IsShown() ) then
                lineButtonText:SetWidth(265);
            else
                lineButtonText:SetWidth(285);
            end
            lineButton:Show();

            if ( isHeader ) then
                if ( item.func ) then
                    lineButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
                elseif ( item.isExpanded ) then
                    lineButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
                else
                    lineButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
                end
                lineButtonHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
                lineButton:UnlockHighlight();
            else
                lineButtonHighlight:SetTexture("");
            end
        else
            lineButton:Hide();
        end
    end

    -- Set the expand/collapse all button texture
    local numHeaders = 0;
    local notExpanded = 0;
    -- Somewhat redundant loop, but cleaner than the alternatives
    for i = 1, numLines do
        local item = ArmoryLookupFrame.data[lines[i].mainIndex];
        local isHeader = (not lines[i].valueIndex);
        if ( isHeader and not item.func ) then
            numHeaders = numHeaders + 1;
            if ( not item.isExpanded ) then
                notExpanded = notExpanded + 1;
            end
        end
    end
    -- If all headers are not expanded then show collapse button, otherwise show the expand button
    if ( notExpanded ~= numHeaders ) then
        ArmoryLookupExpandAllButton.collapsed = nil;
        ArmoryLookupExpandAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
    else
        ArmoryLookupExpandAllButton.collapsed = 1;
        ArmoryLookupExpandAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
    end
    
    table.wipe(lines);
end

function ArmoryLookupFrame_IsTargetSelected()
    return UnitExists("target") and UnitIsFriend("player", "target") and UnitIsPlayer("target");
end

function ArmoryLookupFrame_SendRequest()
    local channel = ArmoryDropDownMenu_GetSelectedValue(ArmoryLookupChannelDropDown);
    local search = ArmoryLookupFrameEditBox:GetText();
    local exact = 0;
    local id = ArmoryLookupFrame.type;
    local version, message;

    if ( ArmoryLookupFrameSearchExactCheckButton:GetChecked() ) then
        exact = 1;
    end

    table.wipe(ArmoryLookupFrame.data);
    table.wipe(ArmoryLookupFrame.ownerData);
    ArmoryLookupFrame_Update();

    ArmoryLookupMessageFrame:Clear();
    
    if ( id == ARMORY_LOOKUP_TYPE.LOOKUP_RECIPE ) then
        local skill = ArmoryDropDownMenu_GetSelectedValue(ArmoryLookupTradeSkillDropDown);
        version = "2";
        message = strjoin(ARMORY_LOOKUP_SEPARATOR, ARMORY_LOOKUP_SKILLS[skill], exact, search);
    elseif ( id == ARMORY_LOOKUP_TYPE.LOOKUP_QUEST ) then
        version = "2";
        message = strjoin(ARMORY_LOOKUP_SEPARATOR, exact, search, ArmoryDropDownMenu_GetSelectedID(ArmoryLookupQuestDropDown));
    elseif ( id == ARMORY_LOOKUP_TYPE.LOOKUP_CHARACTER ) then
        version = "5";
        message = search;
    elseif ( id == ARMORY_LOOKUP_TYPE.LOOKUP_ITEM ) then
        version = "1";
        message = strjoin(ARMORY_LOOKUP_SEPARATOR, exact, search);
    else
        return;
    end
    
    ArmoryLookupMessageFrame:AddMessage(format(ARMORY_LOOKUP_REQUEST_SENT, _G[channel]));
    ArmoryLookupMessageFrame:Show();

    ArmoryAddonMessageFrame_CreateRequest(id, version, message, channel);
end

function ArmoryLookupFrame_SendDownloadRequest(guild)
    local id = ARMORY_LOOKUP_TYPE.LOOKUP_DOWNLOAD;
    local version = AgrInfo.dbVersion;
    local message = guild;
    local channel = "GUILD";

    ArmoryAddonMessageFrame_CreateRequest(id, version, message, channel);
end

function ArmoryLookupFrame_ProcessRequest(id, version, message, msgNumber, sender, channel)
    local findFunc, arg1, arg2;
    local exact, search 

    if ( id == ARMORY_LOOKUP_TYPE.LOOKUP_RECIPE ) then
        Armory:PrintCommunication(ARMORY_LOOKUP_SKILL);
        if ( version ~= "2" ) then
            Armory:PrintCommunication(string.format(ARMORY_LOOKUP_IGNORED, ARMORY_IGNORE_REASON_VERSION));
            return;
        end

        findFunc = ArmoryLookupFrame_FindRecipe;

        local skill;
        skill, exact, search = strsplit(ARMORY_LOOKUP_SEPARATOR, message);
        arg1 = ArmoryLookupFrame_GetSkillName(skill);
       
    elseif ( id == ARMORY_LOOKUP_TYPE.LOOKUP_QUEST ) then
        Armory:PrintCommunication(ARMORY_LOOKUP_QUEST);
        if ( version ~= "2" ) then
            Armory:PrintCommunication(string.format(ARMORY_LOOKUP_IGNORED, ARMORY_IGNORE_REASON_VERSION));
            return;
        end

        findFunc = ArmoryLookupFrame_FindQuest;
        exact, search, arg1 = strsplit(ARMORY_LOOKUP_SEPARATOR, message);

    elseif ( id == ARMORY_LOOKUP_TYPE.LOOKUP_CHARACTER ) then
        Armory:PrintCommunication(ARMORY_LOOKUP_CHARACTER);
        if ( version ~= "5" ) then
            Armory:PrintCommunication(string.format(ARMORY_LOOKUP_IGNORED, ARMORY_IGNORE_REASON_VERSION));
            return;
        end

        findFunc = ArmoryLookupFrame_InspectCharacter;
        search = message; --character name

    elseif ( id == ARMORY_LOOKUP_TYPE.LOOKUP_DOWNLOAD ) then
        Armory:PrintCommunication(ARMORY_LOOKUP_SKILL);
        if ( version == "4" ) then
            arg2 = 1;
        elseif ( version ~= "3" ) then
            Armory:PrintCommunication(string.format(ARMORY_LOOKUP_IGNORED, ARMORY_IGNORE_REASON_VERSION));
            return;
        end

        findFunc = ArmoryLookupFrame_DownloadRecipes;
        search = message; --guild

    elseif ( id == ARMORY_LOOKUP_TYPE.LOOKUP_ITEM ) then
        Armory:PrintCommunication(ARMORY_LOOKUP_ITEM);
        if ( version ~= "1" ) then
            Armory:PrintCommunication(string.format(ARMORY_LOOKUP_IGNORED, ARMORY_IGNORE_REASON_VERSION));
            return;
        end
    
        findFunc = ArmoryLookupFrame_FindItem;
        exact, search = strsplit(ARMORY_LOOKUP_SEPARATOR, message);
        
    else
        return;

    end

    local lookup = search;
    if ( exact == "1" ) then
        lookup = "'"..lookup.."'";
    end
    if ( arg1 ) then
        lookup = arg1..":"..lookup;
    end
    Armory:PrintCommunication(string.format(ARMORY_LOOKUP_REQUEST_DETAIL, lookup));

    local currentProfile = Armory:CurrentProfile();
    local values;

    message = "";

    for _, profile in ipairs(Armory:Profiles()) do
        Armory:SelectProfile(profile);
        if ( ArmoryLookupFrame_CanShare(profile, channel) ) then
            values = findFunc(exact, search, arg1, arg2);
            if ( #values > 0 ) then
                if ( message ~= "" ) then
                    message = message..ARMORY_LOOKUP_SEPARATOR;
                end
                message = message..(profile.character..ARMORY_LOOKUP_FIELD_SEPARATOR..table.concat(values, ARMORY_LOOKUP_FIELD_SEPARATOR));
            end
        end
    end
    Armory:SelectProfile(currentProfile);

    if ( message ~= "" ) then
        ArmoryAddonMessageFrame_Send(id, version, ArmoryAddonMessageFrame_Compress(message), "TARGET:"..sender, msgNumber);
        Armory:PrintCommunication(string.format(ARMORY_LOOKUP_RESPONSE_SENT, sender));
    end
end

function ArmoryLookupFrame_GetSkillName(skill)
    if ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_ALCHEMY ) then
        return ARMORY_TRADE_ALCHEMY;
    elseif ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_BLACKSMITHING ) then
        return ARMORY_TRADE_BLACKSMITHING;
    elseif ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_COOKING ) then
        return ARMORY_TRADE_COOKING;
    elseif ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_ENCHANTING ) then
        return ARMORY_TRADE_ENCHANTING;
    elseif ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_ENGINEERING ) then
        return ARMORY_TRADE_ENGINEERING;
    elseif ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_JEWELCRAFTING ) then
        return ARMORY_TRADE_JEWELCRAFTING;
    elseif ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_LEATHERWORKING ) then
        return ARMORY_TRADE_LEATHERWORKING;
    elseif ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_POISONS ) then
        return ARMORY_TRADE_POISONS;
    elseif ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_TAILORING ) then
        return ARMORY_TRADE_TAILORING;
    elseif ( skill == ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_INSCRIPTION ) then
        return ARMORY_TRADE_INSCRIPTION;
    end
end

function ArmoryLookupFrame_CanShare(profile, channel)
    if ( not Armory.messaging ) then
        return true; 
    elseif ( profile.realm ~= Armory.playerRealm ) then
        return false;
    elseif ( profile.character ~= Armory.player and not (Armory:GetConfigShareAsAlt("player") and Armory:GetConfigShareAsAlt()) ) then
        return false;
    elseif ( Armory:GetConfigShareAll() ) then
        return true;
    elseif ( channel == "GUILD" and Armory:GetConfigShareGuild() and Armory:GetGuildInfo("player") == GetGuildInfo("player") ) then
        return true;
    else
        return (profile.character == Armory.player);
    end
end

function ArmoryLookupFrame_FindRecipe(exact, search, arg1, arg2)
    local dbEntry = Armory.selectedDbBaseEntry;
    local dbShared;
    local skillName, skillType, ref, link, listLink, id, itemId, texture, numMade; 
    local refType = "enchant";
    local result = {};

    if ( Armory:GetConfigShareProfessions() and dbEntry and dbEntry:Contains("Professions", arg1) ) then
        listLink = dbEntry:GetValue("Professions", arg1, "ListLink");
        if ( search == "*" ) then
            table.insert(result, "*");
        else
            dbEntry = ArmoryDbEntry:new(dbEntry:GetValue("Professions", arg1));

            local container = "SkillLines";
            local numEntries = dbEntry:GetNumValues(container);
            for i = 1, numEntries do
                skillName, skillType = dbEntry:GetValue(container, i, "Info");
                if ( skillType ~= "header" and ArmoryLookupFrame_IsMatch(skillName, search, exact) ) then
                    dbShared = ArmoryDbEntry:new(Armory:GetSharedValue("Professions", "Recipes", dbEntry:GetValue(container, i, "Data")));
                    if ( dbShared ) then
                        link = dbShared:GetValue("RecipeLink");
                        if ( link ) then
                            ref = link:match("|H"..refType..":(%d+)|h");
                            if ( ref ) then
                                if ( arg2 ) then
                                    itemId = Armory:GetItemId(dbShared:GetValue("ItemLink"));
                                    texture = dbShared:GetValue("Icon");
                                    if ( texture ) then
                                        texture = table.remove({strsplit("\\", texture)});
                                    end
                                    numMade = dbShared:GetValue("NumMade");
                                    if ( numMade == 1 ) then
                                        numMade = nil;
                                    end
                                    ref = strjoin(";", ref, itemId or "", texture or "", numMade or "");
                                    
                                end
                                table.insert(result, ref);
                            end
                        end
                    end
                elseif ( arg2 and skillType == "header" ) then
                    table.insert(result, skillName);
                end
            end
        end
    end

    if ( #result > 0 ) then
        if ( listLink and search ~= "" ) then
            table.insert(result, 1, refType..ARMORY_LOOKUP_CONTENT_SEPARATOR..listLink:match("|H(.-)|h"));
        else
            table.insert(result, 1, refType);
        end
    end

    return result;
end

local function AddRef(result, link, refType)
    if ( link ) then
        local ref = link:match("|H"..refType..":([-%d:]+)|h");
        if ( ref ) then
            table.insert(result, ref);
        end
    end
end

function ArmoryLookupFrame_FindQuest(exact, search, arg1)
    local dbEntry = Armory.selectedDbBaseEntry;
    local container = "Quests";

    local name, isHeader, id;
    local refType = "quest";
    local result = {};

    arg1 = arg1 or "1";

    if ( Armory:GetConfigShareQuests() and dbEntry and dbEntry:Contains(container) ) then
        local numEntries = table.getn(dbEntry:GetValue(container));
        local questIndex = 1;
        while ( questIndex <= numEntries ) do
            name, _, _, _, isHeader = dbEntry:GetValue(container, questIndex, "Info");
            if ( arg1 == "2" ) then
                -- area (header)
                if ( isHeader and ArmoryLookupFrame_IsMatch(name, search, exact) ) then
                    repeat
                        questIndex = questIndex + 1;
                        name, _, _, _, isHeader = dbEntry:GetValue(container, questIndex, "Info");
                        if ( not isHeader ) then
                            id = dbEntry:GetValue(container, questIndex, "Data");
                            AddRef(result, dbEntry:GetValue(container, id, "Link"), refType);
                        end
                    until ( isHeader or questIndex > numEntries )
                    questIndex = questIndex - 1;
                end
            elseif ( not isHeader and ArmoryLookupFrame_IsMatch(name, search, exact) ) then
                -- name
                id = dbEntry:GetValue(container, questIndex, "Data");
                AddRef(result, dbEntry:GetValue(container, id, "Link"), refType);
            end
            questIndex = questIndex + 1;
        end
    end

    if ( #result > 0 ) then
        table.insert(result, 1, refType);
    end

    return result;
end

local info = {};
local specs = {};
function ArmoryLookupFrame_InspectCharacter(exact, search, arg1)
    local result = {};
    local link, ref;

    if ( Armory:GetConfigShareCharacter() and strlower(Armory.character) == strlower(search) ) then
        table.wipe(info);
        
        local avgItemLevel, avgItemLevelEquipped = Armory:GetAverageItemLevel();
        local itemLevel = "";
        if ( avgItemLevel ) then
            avgItemLevel = floor(avgItemLevel);
            itemLevel = avgItemLevel;
            if ( avgItemLevelEquipped ) then
                avgItemLevelEquipped = floor(avgItemLevelEquipped);
                if ( avgItemLevel ~= avgItemLevelEquipped ) then
                    itemLevel = avgItemLevelEquipped .. "/" .. avgItemLevel;
                end
            end
        end
        info[1] = itemLevel;
        
        for i = EQUIPPED_FIRST, EQUIPPED_LAST do
            link = Armory:GetInventoryItemLink("player", i);
            if ( link ) then
                ref = link:match("|Hitem:([-%d:]+)|h");
            end
            if ( link and ref ) then
                info[i + 1] = ref;
            else
                info[i + 1] = "";
            end
        end
        table.insert(result, table.concat(info, ARMORY_LOOKUP_CONTENT_SEPARATOR));

        table.wipe(specs);

	    local numTalentGroups = Armory:GetNumSpecGroups();
	    local numTalents = Armory:GetNumTalents();
        for talentGroup = 1, numTalentGroups do
            local primaryTree = Armory:GetSpecialization(false, false, talentGroup);
            local role = Armory:GetSpecializationRole(primaryTree);
            local active;
            if ( talentGroup == Armory:GetActiveSpecGroup() ) then
                active = 1;
            end

            table.wipe(info);
            for i = 1, numTalents do
       			local _, texture, _, _, selected = Armory:GetTalentInfo(i, false, talentGroup);
                if ( selected ) then
               		link = Armory:GetTalentLink(i, false, talentGroup);
                    if ( link ) then
                        ref = link:match("|Htalent:([-%d:]+)|h");
                        texture = table.remove({strsplit("\\", texture)});
                        if ( ref ) then
                            table.insert(info, Armory:Join(";", ref, texture));
                        end
                    end
                end
            end
            if ( #info > 0 ) then
                table.insert(info, 1, Armory:Join(";", role, active));
                table.insert(specs, table.concat(info, "|"));
            end
        end
        
        if ( #specs > 0 ) then
            table.insert(result, table.concat(specs, ARMORY_LOOKUP_CONTENT_SEPARATOR));
        else
            table.insert(result, "");
        end
        
        table.wipe(info);
        table.wipe(specs);
    end
    
    return result;
end

local itemCounts = {};
function ArmoryLookupFrame_FindItem(exact, search)
    local result = {};

    if ( Armory:GetConfigShareItems() and Armory:HasInventory() ) then
        table.wipe(itemCounts);
        local id, numSlots, name, link, itemId;
        for i = 1, #ArmoryInventoryContainers do
            id = ArmoryInventoryContainers[i];
            _, numSlots = Armory:GetInventoryContainerInfoEx(id);
            if ( (numSlots or 0) > 0 ) then
                for index = 1, numSlots do
                    link = Armory:GetContainerItemLink(id, index);
                    name = Armory:GetNameFromLink(link);
                    itemId = Armory:GetItemId(link);
                    if ( itemId and ArmoryLookupFrame_IsMatch(name, search, exact) ) then
                        _, itemCount = Armory:GetContainerItemInfo(id, index);
                        if ( itemCounts[itemId] ) then
                            itemCounts[itemId] = itemCounts[itemId] + itemCount;
                        else
                            itemCounts[itemId] = itemCount;
                        end
                    end
                end
            end
        end

        for itemId, count in pairs(itemCounts) do
            table.insert(result, Armory:Join(ARMORY_LOOKUP_CONTENT_SEPARATOR, itemId, count));
        end
    end

    return result;
end

function ArmoryLookupFrame_DownloadRecipes(exact, search, arg1, arg2)
    local dbEntry = Armory.selectedDbBaseEntry;
    local result = {};

    if ( search == Armory:GetGuildInfo("player") and dbEntry and dbEntry:Contains("Professions") ) then
        for profession in pairs(dbEntry:GetValue("Professions")) do
            local skill, recipes;

            if ( profession == ARMORY_TRADE_ALCHEMY ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_ALCHEMY;
            elseif ( profession == ARMORY_TRADE_BLACKSMITHING ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_BLACKSMITHING;
            elseif ( profession == ARMORY_TRADE_COOKING ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_COOKING;
            elseif ( profession == ARMORY_TRADE_ENCHANTING ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_ENCHANTING;
            elseif ( profession == ARMORY_TRADE_ENGINEERING ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_ENGINEERING;
            elseif ( profession == ARMORY_TRADE_FIRST_AID ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_FIRST_AID;
            elseif ( profession == ARMORY_TRADE_JEWELCRAFTING ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_JEWELCRAFTING;
            elseif ( profession == ARMORY_TRADE_LEATHERWORKING ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_LEATHERWORKING;
            elseif ( profession == ARMORY_TRADE_POISONS ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_POISONS;
            elseif ( profession == ARMORY_TRADE_TAILORING ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_TAILORING;
            elseif ( profession == ARMORY_TRADE_INSCRIPTION ) then
                skill = ARMORY_LOOKUP_SKILLS.ARMORY_TRADE_INSCRIPTION;
            end

            if ( skill ) then
                recipes = ArmoryLookupFrame_FindRecipe(nil, "", profession, arg2);
                if ( #recipes > 0 ) then
                    table.insert(recipes, 1, skill);
                    table.insert(result, table.concat(recipes, ARMORY_LOOKUP_CONTENT_SEPARATOR));
                end
            end
        end
    end

    return result;
end

function ArmoryLookupFrame_CheckResponse()
    for _, id in pairs(ARMORY_LOOKUP_TYPE) do
        ArmoryLookupFrame_ProcessResponse(id);
    end
end

function ArmoryLookupFrame_GetCharacterName(owner, sender)
    local characterName = UNKNOWN;
    local isMine = (owner == UnitName("player"));
    if ( owner ~= sender ) then
        characterName = sender.." ["..owner.."]";
    elseif ( isMine ) then
        characterName = owner..GREEN_FONT_COLOR_CODE.."*"..FONT_COLOR_CODE_CLOSE;
    else
        characterName = owner;
    end
    return characterName, isMine;
end

function ArmoryLookupFrame_ProcessResponse(id)
    local module = ArmoryAddonMessageFrame_GetModule(id);
    local data = ArmoryLookupFrame.data;
    local ownerData = ArmoryLookupFrame.ownerData;
    local sets, version, fields, values, owner, name, ref, index, link, refType;
    local sort, update, isMine, characterName, isExpanded;
    local count;

    for sender, reply in pairs(module.replies) do
        sets = Armory:StringSplit(ARMORY_LOOKUP_SEPARATOR, ArmoryAddonMessageFrame_Decompress(reply.message));
        for _, set in ipairs(sets) do
            fields = Armory:StringSplit(ARMORY_LOOKUP_FIELD_SEPARATOR, set);
            if ( id == ARMORY_LOOKUP_TYPE.LOOKUP_DOWNLOAD ) then
                -- proto3: owner\nAL\fenchant\f1234\f3264\f5353\nEN\fenchant\f8262\f7265
                -- proto4: owner\nAL\fenchant\finvslot\fid;item;icon;count\fid;item;icon;count
                if ( tonumber(reply.version) >= 3 and ArmoryGuildRecipes_ProcessResponse ) then
                    for i = 2, #fields do
                        ArmoryGuildRecipes_ProcessResponse(sender, fields[1], Armory:StringSplit(ARMORY_LOOKUP_CONTENT_SEPARATOR, fields[i]));
                    end
                end

            elseif ( id == ARMORY_LOOKUP_TYPE.LOOKUP_CHARACTER ) then
                if ( reply.version == "5" ) then
                    -- owner\n(1)\n(2)
                    owner = fields[1];

                    local retry;

                    -- (1) (19 items) iLvl\f18821:0:0:0:0:0:0:0\f31333:0:0:0:0:0:0:1443794188
                    name, values = ArmoryLookupFrame_ParseCharacterEquipment(owner, fields[2]);
                    if ( name == nil ) then
                        retry = true;
                    else
                        table.insert(data, {name=name, values=values});

                        -- (2) (talents) role1;active|19354;icon|19364;icon\f;role2;active|19365;icon|19360;icon
                        local specs = Armory:StringSplit(ARMORY_LOOKUP_CONTENT_SEPARATOR, fields[3]);
                        for i = 1, #specs do
                            if ( specs[i] ~= "" ) then
                                name, values = ArmoryLookupFrame_ParseCharacterTalents(owner, i, specs[i]);
                                if ( name == nil ) then
                                    retry = true;
                                    break;
                                elseif ( #values > 0 ) then
                                    table.insert(data, {name=name, values=values});
                                end
                            end
                        end
                    end
                    
                    if ( retry ) then
                        table.insert(data, {name=ARMORY_LOOKUP_NOT_CACHED, func=ArmoryLookupFrame_SendRequest});
                    end
                    
                    update = true;
                end
                
            elseif ( id == ARMORY_LOOKUP_TYPE.LOOKUP_ITEM ) then
                -- owner\nS:24478\fN:3\nS:35624\fN:1 (item, count)
                owner = fields[1];
                characterName, isMine = ArmoryLookupFrame_GetCharacterName(owner, sender);
                for i = 2, #fields do
                    ref, count = Armory:Split(ARMORY_LOOKUP_CONTENT_SEPARATOR, fields[i]);
                    name, link = Armory:GetInfoFromId("item", ref);
                    name = name ~= "" and name or RETRIEVING_ITEM_INFO;
                    index = ArmoryLookupFrame_GetData(ref);
                    if ( not index ) then
                        if ( name ) then
                            table.insert(data, {id=ref, name=name, display=name.." "..count.."x", count=count, link=link, isMine=isMine, values={{name=characterName, display=characterName.." "..count.."x", owner=owner, source=sender}}});
                            sort = true;
                        else
                            Armory:PrintDebug("couldn't determine name", ref, characterName);
                        end
                    else
                        if ( isMine ) then
                            data[index].isMine = true;
                        end
                        data[index].count = data[index].count + count;
                        data[index].display = data[index].name.." "..data[index].count.."x";
                        table.insert(data[index].values, {name=characterName, display=characterName.." "..count.."x", owner=owner, source=sender});
                        table.sort(data[index].values, function(a, b) return a.name < b.name end);
                    end
                    update = true;

                end

            elseif ( reply.version == "2" ) then
                -- owner\nenchant\ftrade:51296:409:450:1F6C481:Bp>PZygS{{iGCy{u=Fj{{?<<\\Da>\n1234\n3264\n5353
                -- owner\nquest\n2323:70\n2432:70
                owner = fields[1];
                characterName, isMine = ArmoryLookupFrame_GetCharacterName(owner, sender);
                refType, link = strsplit(ARMORY_LOOKUP_CONTENT_SEPARATOR, fields[2]);
                if ( link ) then
                    if ( not ownerData[owner] ) then
                        ownerData[owner] = {};
                    end
                    ownerData[owner].recipeList = link;
                end
                for i = 3, #fields do
                    ref = fields[i];
                    if ( ref ) then
                        index = ArmoryLookupFrame_GetData(ref);
                        if ( not index ) then
                            if ( ref == "*" ) then
                                name = _G[ArmoryDropDownMenu_GetSelectedValue(ArmoryLookupTradeSkillDropDown)];
                                link = nil;
                                isExpanded = true;
                            else
                                name, link = Armory:GetInfoFromId(refType, ref);
                                isExpanded = false;
                            end
                            if ( name ) then
                                table.insert(data, {id=ref, name=name, link=link, isMine=isMine, isExpanded=isExpanded, values={{name=characterName, owner=owner, source=sender}}});
                                sort = true;
                            else
                                Armory:PrintDebug("couldn't determine name", ref, characterName);
                            end
                        else
                            if ( isMine ) then
                                data[index].isMine = true;
                            end
                            table.insert(data[index].values, {name=characterName, owner=owner, source=sender});
                            table.sort(data[index].values, function(a, b) return a.name < b.name end);
                        end
                    end
                end
                update = true;

            end
        end
        ArmoryAddonMessageFrame_RemoveReply(module, sender);
    end

    if ( sort ) then        
        table.sort(data, function(a, b) return a.name < b.name end);
    end

    if ( update ) then
        ArmoryLookupMessageFrame:Hide();
        ArmoryLookupFrame_Update();
    end
end

function ArmoryLookupFrame_ParseCharacterEquipment(owner, fields)
    local values = Armory:StringSplit(ARMORY_LOOKUP_CONTENT_SEPARATOR, fields);
    local result = {};
    local itemLevel = values[1];
    local name = ARMORY_EQUIPMENT;
    local missing;
    
    if ( itemLevel ~= "" ) then
        name = name.." ("..ITEM_LEVEL_ABBR.." "..itemLevel..")";
    end

    for i = 2, #values do
        local name, link = Armory:GetInfoFromId("item", values[i]);
        local slot = i - 1;
        local texture;
        if ( (name or "") ~= "" ) then
            if ( link ) then
                -- Get it in the cache
                local tooltip = Armory:AllocateTooltip();
                Armory:SetHyperlink(tooltip, link);
                Armory:ReleaseTooltip(tooltip);

                texture = GetItemIcon(link);
                if ( not texture ) then
                    _, _, _, _, _, _, _, _, _, texture = GetItemInfo(link);
                end
            end
            table.insert(result, {id=values[i], name=name.." "..GRAY_FONT_COLOR_CODE..ARMORY_SLOT[slot], link=link, icon=texture});
        elseif ( (values[i] or "") ~= "" ) then
            missing = true;
        end
    end

    if ( not missing ) then
        return name, result;
    end
end

function ArmoryLookupFrame_ParseCharacterTalents(owner, talentGroup, fields)
    local values = Armory:StringSplit("|", fields);
    local role, active = Armory:Split(";", values[1]);
    local result = {};
    local name;
    local missing;
    
    if ( talentGroup == 1 ) then
        if ( active ) then
            name = TALENT_SPEC_PRIMARY_ACTIVE;
        else
            name = TALENT_SPEC_PRIMARY;
        end
    else
        if ( active ) then
            name = TALENT_SPEC_SECONDARY_ACTIVE;
        else
            name = TALENT_SPEC_SECONDARY;
        end
    end
    name = name.." (".._G[role]..")";

    for i = 2, #values do
        local ref, texture = Armory:Split(";", values[i]);
        local name, link = Armory:GetInfoFromId("talent", ref);
        if ( (name or "") ~= "" ) then
            table.insert(result, {id=ref, name=name, link=link, icon="Interface\\Icons\\"..texture});
        elseif ( (ref or "") ~= "" ) then
            missing = true;
        end
    end

    if ( not missing ) then    
        return name, result;
    end
end

function ArmoryLookupFrame_GetData(id)
    for i, item in ipairs(ArmoryLookupFrame.data) do
        if ( id == item.id ) then
            return i;
        end
    end
end

function ArmoryLookupFrame_IsMatch(name, search, exact)
    if ( exact == "1" ) then
        return Armory:FindTextParts(name, search);
    end
    return Armory:FindTextParts(name, strsplit(" ", search));
end

function ArmoryLookupFrame_StartDownload(...)
    local loaded = IsAddOnLoaded(ARMORY_SHARE_DOWNLOAD_ADDON);
    local reason;

    if ( not loaded ) then
        loaded, reason = LoadAddOn(ARMORY_SHARE_DOWNLOAD_ADDON);
        --if ( not loaded and reason == "DISABLED" ) then
            --EnableAddOn(ARMORY_SHARE_DOWNLOAD_ADDON);
            --loaded, reason = LoadAddOn(ARMORY_SHARE_DOWNLOAD_ADDON);
        --end
    end

    if ( loaded ) then
        ArmoryGuildRecipes_Prepare(ArmoryLookupFrame_SendDownloadRequest);
    elseif ( reason ) then
        Armory:PrintError(string.format(ARMORY_SHARE_DOWNLOAD_LOADERROR, ARMORY_SHARE_DOWNLOAD_ADDON, _G["ADDON_"..reason]));
    end
end
