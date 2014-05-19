--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 553 2012-11-11T14:01:51Z
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

ARMORY_SOCIAL_TABS = 3;

ARMORY_SOCIALFRAME_SUBFRAMES = { "ArmoryFriendsListFrame", "ArmoryIgnoreListFrame", "ArmoryEventsListFrame" };

ARMORY_FRIENDS_TO_DISPLAY = 11;
ARMORY_SOCIALFRAME_FRIEND_HEIGHT = 34;

ARMORY_IGNORES_TO_DISPLAY = 21;
ARMORY_SOCIALFRAME_IGNORE_HEIGHT = 16;

ARMORY_EVENTS_TO_DISPLAY = 11;
ARMORY_SOCIALFRAME_EVENT_HEIGHT = 34;

local tabWidthCache = {};

function ArmorySocialFrame_ShowSubFrame(frameName)
    for index, value in pairs(ARMORY_SOCIALFRAME_SUBFRAMES) do
        _G[value]:Hide();    
        if ( value == ARMORY_SOCIALFRAME_SUBFRAMES[PanelTemplates_GetSelectedTab(ArmorySocialFrame)] ) then
            _G[value]:Show();
        end    
    end
end

function ArmorySocialFrame_Toggle()
    if ( ArmorySocialFrame:IsShown() or not Armory:HasSocial() ) then
        HideUIPanel(ArmorySocialFrame);
    else
        ArmoryCloseChildWindows();
        ShowUIPanel(ArmorySocialFrame);
    end
end

function ArmorySocialFrameTab_OnClick(self)
    PanelTemplates_SetTab(ArmorySocialFrame, self:GetID());
    ArmorySocialFrame_ShowSubFrame();
    PlaySound("igCharacterInfoTab");
end

function ArmorySocialFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("FRIENDLIST_UPDATE");
    self:RegisterEvent("IGNORELIST_UPDATE");
    self:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST");
    self:RegisterEvent("CALENDAR_CLOSE_EVENT");

    PanelTemplates_SetNumTabs(self, ARMORY_SOCIAL_TABS);
    PanelTemplates_SetTab(self, 1);
end

function ArmorySocialFrame_OnShow(self)
    PlaySound("igCharacterInfoTab");
    PanelTemplates_SetTab(self, PanelTemplates_GetSelectedTab(self));
    
    local tab;
    local totalTabWidth = 0;
    for i = 1, ARMORY_SOCIAL_TABS do
        tabWidthCache[i] = 0;
        tab = _G["ArmorySocialFrameTab"..i];
        PanelTemplates_TabResize(tab, 0);
        tab.textWidth = tab:GetTextWidth();
        tabWidthCache[i] = PanelTemplates_GetTabWidth(tab);
        totalTabWidth = totalTabWidth + tabWidthCache[i];
        tab:Show();
    end
    ArmoryFrame_CheckTabBounds("ArmorySocialFrameTab", totalTabWidth, 270, tabWidthCache);

    ArmorySocialFrame_ShowSubFrame();
end

function ArmorySocialFrame_OnEvent(self, event, ...)
    if ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        Armory:ExecuteDelayed(2, ArmorySocialFrame_InitializeEvents);
    elseif ( event == "FRIENDLIST_UPDATE" or event == "IGNORELIST_UPDATE" ) then
        Armory:Execute(ArmorySocialFrame_UpdateFriends);
    elseif ( event == "CALENDAR_UPDATE_EVENT_LIST" ) then
        Armory:Execute(ArmorySocialFrame_UpdateEvents);
    else
        -- CALENDAR_CLOSE_EVENT doesn't fire, maybe one day...
        local _, presentMonth, _, presentYear = CalendarGetDate();
        CalendarSetAbsMonth(presentMonth, presentYear);
    end
end

function ArmorySocialFrame_UpdateFriends()
    Armory:UpdateFriends();
    if ( ArmoryFriendsListFrame:IsShown() ) then
        ArmoryFriendsList_Update();
    elseif ( ArmoryIgnoreListFrame:IsShown() ) then
        ArmoryIgnoreList_Update();
    end
end

function ArmorySocialFrame_InitializeEvents()
    OpenCalendar();
    if ( Armory:GetConfigCheckCooldowns() ) then
        Armory:CheckAvailableCooldowns();
    end
    ArmorySocialFrame_UpdateEvents();
end

function ArmorySocialFrame_UpdateEvents()
    Armory:UpdateEvents();
    ArmoryEventsList_Update();
    ArmoryEventWarning_Update();
end

function ArmorySocialFrame_OnHide(self)
	for index, value in pairs(ARMORY_SOCIALFRAME_SUBFRAMES) do
		_G[value]:Hide();
	end
end

function ArmoryFriendsListFrame_OnShow(self)
    ArmorySocialFrameTitleText:SetText(FRIENDS_LIST);
    ArmoryFriendsList_Update();
end

function ArmoryFriendsList_Update()
    local numFriends = Armory:GetNumFriends();
    local showScrollBar = (numFriends > ARMORY_FRIENDS_TO_DISPLAY);
    local nameText, infoText, noteText, noteHiddenText;
    local name, class, note;
    local friendButton;

    local friendOffset = FauxScrollFrame_GetOffset(ArmoryFriendsListScrollFrame);
    local friendIndex;

    for i = 1, ARMORY_FRIENDS_TO_DISPLAY, 1 do
        friendIndex = friendOffset + i;
        name, class, note = Armory:GetFriendInfo(friendIndex);
        nameText = _G["ArmoryFriendsListButton"..i.."ButtonTextName"];
        infoText = _G["ArmoryFriendsListButton"..i.."ButtonTextInfo"];
        noteText = _G["ArmoryFriendsListButton"..i.."ButtonTextNoteText"];
        noteHiddenText = _G["ArmoryFriendsListButton"..i.."ButtonTextNoteHiddenText"];
        friendButton = _G["ArmoryFriendsListButton"..i];
        nameText:ClearAllPoints();
        nameText:SetPoint("TOPLEFT", 10, -3);
        friendButton:SetID(friendIndex);

        friendButton.candidate = nil;
        if ( not name ) then
            name = UNKNOWN;
        elseif ( Armory.characterRealm == Armory.playerRealm and Armory.player ~= Armory.character and Armory:UnitFactionGroup() == _G.UnitFactionGroup("player") ) then
            friendButton.candidate = name;
        end
        nameText:SetText(name);
        infoText:SetText(class);

        if ( note ) then
            noteText:SetFormattedText(FRIENDS_LIST_NOTE_TEMPLATE, note);
            noteHiddenText:SetText(note);
            local width = noteHiddenText:GetWidth() + infoText:GetWidth();
            local friendButtonWidth = friendButton:GetWidth();
            if ( showScrollBar ) then
                friendButtonWidth = friendButtonWidth - ArmoryFriendsListScrollFrameScrollBarTop:GetWidth();
            end
            if ( width > friendButtonWidth ) then
                width = friendButtonWidth - infoText:GetWidth();
            end
            noteText:SetWidth(width);
            noteText:SetHeight(14);
        else
            noteText:SetText("");
        end

        if ( friendIndex > numFriends ) then
            friendButton:Hide();
        else
            friendButton:Show();
        end
    end

    -- ScrollFrame stuff
    FauxScrollFrame_Update(ArmoryFriendsListScrollFrame, numFriends, ARMORY_FRIENDS_TO_DISPLAY, ARMORY_SOCIALFRAME_FRIEND_HEIGHT);
end

function ArmoryIgnoreListFrame_OnShow(self)
    ArmorySocialFrameTitleText:SetText(IGNORE_LIST);
    ArmoryIgnoreList_Update();
end

function ArmoryIgnoreList_Update()
    local numIgnores = Armory:GetNumIgnores();
    local nameText;
    local name;
    local ignoreButton;

    local ignoreOffset = FauxScrollFrame_GetOffset(ArmoryIgnoreListScrollFrame);
    local ignoreIndex;
    for i = 1, ARMORY_IGNORES_TO_DISPLAY do
        ignoreIndex = i + ignoreOffset;
        name = Armory:GetIgnoreName(ignoreIndex);
        nameText = _G["ArmoryIgnoreListButton"..i.."ButtonTextName"];
        ignoreButton = _G["ArmoryIgnoreListButton"..i];
        ignoreButton:SetID(ignoreIndex);

        ignoreButton.candidate = nil;
        if ( name ~= "" and Armory.characterRealm == Armory.playerRealm and Armory.player ~= Armory.character ) then
            ignoreButton.candidate = name;
        end
        nameText:SetText(name);

        if ( ignoreIndex > numIgnores ) then
            ignoreButton:Hide();
        else
            ignoreButton:Show();
        end
    end

    -- ScrollFrame stuff
    FauxScrollFrame_Update(ArmoryIgnoreListScrollFrame, numIgnores, ARMORY_IGNORES_TO_DISPLAY, ARMORY_SOCIALFRAME_IGNORE_HEIGHT);
end

local EVENTCOLOR_MODERATOR = {r=0.54, g=0.75, b=1.0};

local INVITESTATUS_INFO = {
    ["UNKNOWN"] = { name=UNKNOWN, color=NORMAL_FONT_COLOR },
    [CALENDAR_INVITESTATUS_CONFIRMED] = { name=CALENDAR_STATUS_CONFIRMED, color=GREEN_FONT_COLOR },
    [CALENDAR_INVITESTATUS_ACCEPTED] = { name=CALENDAR_STATUS_ACCEPTED, color=GREEN_FONT_COLOR },
    [CALENDAR_INVITESTATUS_DECLINED] = { name=CALENDAR_STATUS_DECLINED, color=RED_FONT_COLOR },
    [CALENDAR_INVITESTATUS_OUT] = { name=CALENDAR_STATUS_OUT, color=RED_FONT_COLOR },
    [CALENDAR_INVITESTATUS_STANDBY] = { name=CALENDAR_STATUS_STANDBY, color=ORANGE_FONT_COLOR },
    [CALENDAR_INVITESTATUS_INVITED] = { name=CALENDAR_STATUS_INVITED, color=NORMAL_FONT_COLOR },
    [CALENDAR_INVITESTATUS_SIGNEDUP] = { name=CALENDAR_STATUS_SIGNEDUP, color=GREEN_FONT_COLOR },
    [CALENDAR_INVITESTATUS_NOT_SIGNEDUP] = { name=CALENDAR_STATUS_NOT_SIGNEDUP, color=NORMAL_FONT_COLOR },
    [CALENDAR_INVITESTATUS_TENTATIVE] = { name=CALENDAR_STATUS_TENTATIVE, color=ORANGE_FONT_COLOR },
};

local function GetEventColor(calendarType, modStatus, inviteStatus)
    if ( calendarType == "PLAYER" or calendarType == "GUILD_ANNOUNCEMENT" or calendarType == "GUILD_EVENT" ) then
        if ( modStatus == "MODERATOR" or modStatus == "CREATOR" ) then
            return EVENTCOLOR_MODERATOR;
        elseif ( inviteStatus and INVITESTATUS_INFO[inviteStatus] ) then
            return INVITESTATUS_INFO[inviteStatus].color;
        end
    else
	    return HIGHLIGHT_FONT_COLOR;
    end
    -- default to normal color
    return NORMAL_FONT_COLOR;
end

local eventTextures = {};
local function GetEventTextures(...)
    local numTextures = select("#", ...) / 4;
    local param = 1;
    local title, texture, expansionLevel, difficultyName;
    table.wipe(eventTextures);
    for index = 1, numTextures do
        title = select(param, ...);
        param = param + 1;
        texture = select(param, ...);
        param = param + 1;
        expansionLevel = select(param, ...);
        param = param + 1;
        difficultyName = select(param, ...);
        param = param + 1;
        --eventTextures[texture] = format("%s (%s)", title, _G["EXPANSION_NAME"..expansionLevel]);
        eventTextures[texture] = title;
    end
    return eventTextures;
end

function ArmoryEventsListFrame_OnShow(self)
    ArmorySocialFrameTitleText:SetText(EVENTS_LABEL);
    ArmoryEventsList_Update();
end

function ArmoryEventsList_GetEventDetail(eventIndex)
    local eventTime, title, calendarType, eventType, texture, modStatus, inviteStatus, invitedBy, difficulty, inviteType, difficultyName = Armory:GetEventInfo(eventIndex);
    local isOldEvent = eventTime < time();
    local eventColor = GetEventColor(calendarType, modStatus, inviteStatus);
    local status, typeName, text;

    if ( (invitedBy or "") == "" ) then
        invitedBy = UNKNOWN;
    end

    if ( calendarType == "COOLDOWN" ) then
        title = title.." "..AVAILABLE;
        eventColor = NORMAL_FONT_COLOR;
    elseif ( calendarType == "RAID_RESET" ) then
        title = format(CALENDAR_EVENTNAME_FORMAT_RAID_RESET, GetDungeonNameWithDifficulty(title, difficultyName));
        eventColor = NORMAL_FONT_COLOR;
    elseif ( calendarType == "RAID_LOCKOUT" ) then
        title = format(CALENDAR_EVENTNAME_FORMAT_RAID_LOCKOUT, GetDungeonNameWithDifficulty(title, difficultyName));
        eventColor = NORMAL_FONT_COLOR;
    else
        inviteStatusInfo = INVITESTATUS_INFO[inviteStatus] or INVITESTATUS_INFO["UNKNOWN"];
        eventColor = GetEventColor(calendarType, modStatus, inviteStatus);
        status = Armory:HexColor(inviteStatusInfo.color)..inviteStatusInfo.name..FONT_COLOR_CODE_CLOSE;
        if ( texture ) then
            typeName = GetEventTextures(CalendarEventGetTextures(eventType))[texture];
        end
        if ( typeName ) then
            typeName = format(CALENDAR_VIEW_EVENTTYPE, select(eventType, CalendarEventGetTypes()), typeName);
        else
            typeName = select(eventType, CalendarEventGetTypes());
        end
        if ( Armory:UnitName("player") == invitedBy ) then
            if ( calendarType == "GUILD_ANNOUNCEMENT" ) then
                text = CALENDAR_ANNOUNCEMENT_CREATEDBY_YOURSELF;
            elseif ( calendarType == "GUILD_EVENT" ) then
                text = CALENDAR_GUILDEVENT_INVITEDBY_YOURSELF;
            else
                text = CALENDAR_EVENT_INVITEDBY_YOURSELF;
            end
        elseif ( calendarType == "GUILD_EVENT" and inviteType == CALENDAR_INVITETYPE_SIGNUP ) then
            local inviteStatusInfo = INVITESTATUS_INFO[inviteStatus] or INVITESTATUS_INFO["UNKNOWN"];
            if ( inviteStatus == CALENDAR_INVITESTATUS_NOT_SIGNEDUP or inviteStatus == CALENDAR_INVITESTATUS_SIGNEDUP ) then
                text = inviteStatusInfo.name;
            else
                text = format(CALENDAR_SIGNEDUP_FOR_GUILDEVENT_WITH_STATUS, inviteStatusInfo.name);
            end
        elseif ( calendarType == "GUILD_ANNOUNCEMENT" ) then
            text = format(CALENDAR_ANNOUNCEMENT_CREATEDBY_PLAYER, invitedBy);
        else
            text = format(CALENDAR_EVENT_INVITEDBY_PLAYER, invitedBy);
        end
    end
    title = Armory:HexColor(eventColor)..title..FONT_COLOR_CODE_CLOSE;

    return eventTime, isOldEvent, title, status, calendarType, typeName, text;       
end

function ArmoryEventsList_Update()
    local numEvents = Armory:GetNumEvents();
    local showScrollBar = (numEvents > ARMORY_EVENTS_TO_DISPLAY);
    local eventTime, isOldEvent, title, status;
    local dateTimeText, titleText, statusText;
    local eventButton;
    local fullDate;

    local eventOffset = FauxScrollFrame_GetOffset(ArmoryEventsListScrollFrame);
    local eventIndex;
    local width;
    for i = 1, ARMORY_EVENTS_TO_DISPLAY do
        eventIndex = i + eventOffset;

        dateTimeText = _G["ArmoryEventsListButton"..i.."ButtonTextDateTime"];
        titleText = _G["ArmoryEventsListButton"..i.."ButtonTextTitle"];
        titleHiddenText = _G["ArmoryEventsListButton"..i.."ButtonTextTitleHiddenText"];
        statusText = _G["ArmoryEventsListButton"..i.."ButtonTextStatus"];
        eventButton = _G["ArmoryEventsListButton"..i];

        if ( eventIndex <= numEvents ) then
            eventTime, isOldEvent, title, status = ArmoryEventsList_GetEventDetail(eventIndex);

            if ( not Armory:GetConfigUseEventLocalTime() ) then
                eventTime = Armory:GetLocalTimeAsServerTime(eventTime);
            end   
            eventTime = date("*t", eventTime);
            fullDate = format(FULLDATE, Armory:GetFullDate(eventTime));

            eventButton:SetID(eventIndex);
            titleText:ClearAllPoints();
            titleText:SetPoint("TOPLEFT", 10, -3);
            titleText:SetText(title);
            titleHiddenText:SetText(title);
            statusText:SetText(status or "");
            
            width = eventButton:GetWidth();
            if ( showScrollBar ) then
                width = width - ArmoryEventsListScrollFrameScrollBarTop:GetWidth();
            end
            width = width - statusText:GetWidth();

            titleText:SetWidth(width);
            titleText:SetHeight(14);

            dateTimeText:SetFormattedText(FULLDATE_AND_TIME, fullDate, GameTime_GetFormattedTime(eventTime.hour, eventTime.min, true));
            if ( isOldEvent ) then
                dateTimeText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
            else
                dateTimeText:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
            end

            eventButton:Show();
        else
            eventButton:Hide();
        end
    end

    -- ScrollFrame stuff
    FauxScrollFrame_Update(ArmoryEventsListScrollFrame, numEvents, ARMORY_EVENTS_TO_DISPLAY, ARMORY_SOCIALFRAME_EVENT_HEIGHT);
end

function ArmoryEventsListButton_OnEnter(self)
    local eventTime, isOldEvent, title, status, _, typeName, text = ArmoryEventsList_GetEventDetail(self:GetID());
    eventTime = date("*t", eventTime);

    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:ClearLines();
    GameTooltip:AddLine(title);
    if ( typeName ) then
        GameTooltip:AddLine(typeName);
    end
    if ( text ) then
        GameTooltip:AddLine(text);
    end
    GameTooltip:AddLine(format(FULLDATE, Armory:GetFullDate(eventTime)), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
    GameTooltip:AddLine(TIMEMANAGER_TOOLTIP_LOCALTIME.." "..GameTime_GetFormattedTime(eventTime.hour, eventTime.min, true), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
    GameTooltip:Show();    
end

function ArmoryEventWarning_OnLoad(self)
    self.events = {};
end

function ArmoryEventWarning_OnUpdate(self, elapsed)
    if ( not self.locked ) then
        self.locked = true;

        if ( table.getn(self.events) > 0 ) then
            local interval = self.events[1][1];
            local reminder = self.events[1][2];
            if ( reminder ) then
                local reminderTime = reminder.time - interval;
                local now = Armory:MinutesTime();
                if ( reminderTime < now ) then
                    table.remove(self.events, 1);
                elseif ( reminderTime == now ) then
                    ArmoryEventWarning_ShowWarning(floor(interval / 60), reminder);
                    table.remove(self.events, 1);
                end
            end
        end

        self.locked = false;
    end
end

local reminderIntervals = {60, 300, 900, 1800, 3600};
function ArmoryEventWarning_Update()
    local frame = ArmoryEventWarning;
    
    frame:Hide();
    
    table.wipe(frame.events);

    if ( Armory:GetConfigEnableEventWarnings() ) then
        local reminders = Armory:GetEventReminders();
        local now = time();
        for _, reminder in ipairs(reminders) do
            for _, interval in ipairs(reminderIntervals) do
                if ( reminder.time - interval > now ) then
                    table.insert(frame.events, {interval, reminder});
                end
            end
        end
        table.sort(frame.events, function(a, b) return (a[2].time - a[1]) < (b[2].time - b[1]) end);

        if ( table.getn(frame.events) > 0 ) then 
            frame:Show();
        end
    end
end

function ArmoryEventWarning_ShowWarning(minutes, reminder)
    local title = reminder.title;
    local profile = reminder.profile;
    local isCooldown = reminder.cooldown;
    local text;
    if ( isCooldown and not Armory:GetConfigEnableCooldownEvents() ) then
        return;
    elseif ( profile ) then
        if ( not Armory:ProfileExists(profile) ) then
            return;
        end
        text = "["..profile.character;
        if ( profile.realm ~= Armory.playerRealm ) then
            text = text.." ("..profile.realm..")";
        end
        text = text.."] ";
    else
        text = "";
    end
    if ( isCooldown ) then
        text = text..format(ARMORY_COOLDOWN_WARNING, title.." "..AVAILABLE, minutes);
    else
        text = text..format(ARMORY_EVENT_WARNING, title, minutes);
        Armory:PlayWarningSound();
    end
    ArmoryEventWarningMessageFrame:AddMessage(text);
    Armory:PrintTitle(text);
end
