local ADDON_NAME, RH = ...;

local ADDON_COMM_PREFIX = 'RUNEHELPER';
local ADDON_COMM_MODE   = 'NORMAL';
C_ChatInfo.RegisterAddonMessagePrefix(ADDON_COMM_PREFIX);

local PLAYER_NAME_WITH_REALM;

local data = {
    [1] = { 1323038, '{rt1}', 'YELLOW', 348447 },
    [2] = { 1323039, '{rt7}', 'RED',    348437 },
    [3] = { 1323037, '{rt3}', 'PURPLE', 348451 },
    [4] = { 1323035, '{rt6}', 'BLUE',   348450 },
};

local auras = {
    [data[1][4]] = 1,
    [data[2][4]] = 2,
    [data[3][4]] = 3,
    [data[4][4]] = 4,
};

local MAX_BLOCKS  = 4;
local MAX_BUTTONS = 4;
local NUM_CLICKED = 0;

local buttons = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
};

local blocks = {};

local SHOW_COMMAND = 'SHOW';
local RESET_COMMAND = 'RESET';
local SEND_FORMAT = 'SEND|%s|%s|%s|%s';
local SOLUTION_FORMAT = '%s %s        %s %s';

local TAZAVESH_INSTANCE_ID   = 2441;
local HYLBRANDE_ENCOUNTER_ID = 2426;

local SHOW_AURA_ID  = 346427;
local HIDE_SPELL_ID = 347097;

local function GetPartyChatType()
    if IsInRaid() then
        return false;
    end

    return IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and 'INSTANCE_CHAT' or (IsInGroup(LE_PARTY_CATEGORY_HOME) and 'PARTY' or false);
end

local function BetterOnDragStop(frame)
    local point, _, relativePoint, xOfs, yOfs = frame:GetPoint();

    frame:StopMovingOrSizing();

    frame:ClearAllPoints();
    frame:SetPoint(point, UIParent, relativePoint, xOfs, yOfs);
    frame:SetUserPlaced(true);
end

local MainFrame = CreateFrame('Frame', 'RuneHelperMainFrame', UIParent);
MainFrame:SetPoint('CENTER', 180, 0);
MainFrame:SetSize(148, 180);
MainFrame:EnableMouse(true);
MainFrame:SetMovable(true);
MainFrame:SetClampedToScreen(true);
MainFrame:RegisterForDrag('LeftButton');
MainFrame:SetScript('OnDragStart', function(self)
    if self:IsMovable()  then
        self:StartMoving();
    end
end);
MainFrame:SetScript('OnDragStop', BetterOnDragStop);
MainFrame:Hide();

MainFrame.background = MainFrame:CreateTexture(nil, 'BACKGROUND');
MainFrame.background:SetPoint('TOPLEFT', MainFrame, 'TOPLEFT', -22, 32);
MainFrame.background:SetPoint('BOTTOMRIGHT', MainFrame, 'BOTTOMRIGHT', 15, -100);
MainFrame.background:SetTexture('Interface\\AddOns\\' .. ADDON_NAME .. '\\background-white.blp');
MainFrame.background:SetVertexColor(0.05, 0.05, 0.05, 0.75);

local HorLine = MainFrame:CreateLine();
HorLine:SetColorTexture(0.3, 0.3, 0.3, 1);
HorLine:SetThickness(2);
HorLine:SetStartPoint('LEFT', -7, 15);
HorLine:SetEndPoint('RIGHT', 0, 15);

local VertLine = MainFrame:CreateLine();
VertLine:SetColorTexture(0.3, 0.3, 0.3, 1);
VertLine:SetThickness(2);
VertLine:SetStartPoint('TOP', -3, 0);
VertLine:SetEndPoint('BOTTOM', -3, 28);

local CloseButton = CreateFrame('Button', nil, MainFrame, 'UIPanelCloseButton');
CloseButton:SetPoint('BOTTOMLEFT', MainFrame, 'TOPRIGHT', -18, -8);
CloseButton:SetScript('OnClick', function()
    MainFrame:Hide();
end);

local function CreateBigBoy(blockFrame)
    local f = CreateFrame('Frame', nil, blockFrame);
    f:SetFrameStrata('HIGH');
    f:SetPoint('CENTER', -2, -2);
    f:SetSize(66, 66);

    f.texture = f:CreateTexture(nil, 'ARTWORK');
    f.texture:SetAllPoints();
    f.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9);

    f.circleTextureMask = f:CreateMaskTexture();
    f.circleTextureMask:SetAllPoints(f.texture);
    f.circleTextureMask:SetTexture('Interface/CHARACTERFRAME/TempPortraitAlphaMask', 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE');
    f.texture:AddMaskTexture(f.circleTextureMask);

    f.border = f:CreateTexture(nil, 'BORDER', nil, -1);
    f.border:SetPoint('TOPLEFT', -1, 1);
    f.border:SetPoint('BOTTOMRIGHT', 1, -1);
    f.border:SetColorTexture(0.1, 0.1, 0.1, 1);

    f.circleBorderMask = f:CreateMaskTexture();
    f.circleBorderMask:SetAllPoints(f.border);
    f.circleBorderMask:SetTexture('Interface/CHARACTERFRAME/TempPortraitAlphaMask', 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE');
    f.border:AddMaskTexture(f.circleBorderMask);

    f.glowFrame = CreateFrame('Frame', nil, f);
    f.glowFrame:SetFrameStrata('MEDIUM');
    f.glowFrame:SetPoint('TOPLEFT', -3, 3);
    f.glowFrame:SetPoint('BOTTOMRIGHT', 3, -3);
    f.glowFrame:Hide();

    f.glowTexture = f.glowFrame:CreateTexture(nil, 'BORDER', nil, 1);
    f.glowTexture:SetAllPoints();
    f.glowTexture:SetColorTexture(0.2,  0.8,  0.4, 1);

    f.circleGlowMask = f.glowFrame:CreateMaskTexture();
    f.circleGlowMask:SetAllPoints(f.glowTexture);
    f.circleGlowMask:SetTexture('Interface/CHARACTERFRAME/TempPortraitAlphaMask', 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE');

    f.glowTexture:AddMaskTexture(f.circleGlowMask);

    f.glowFrame.AnimGroup = f.glowFrame:CreateAnimationGroup();

    local alpha = f.glowFrame.AnimGroup:CreateAnimation('Alpha');
    alpha:SetOrder(1);
    alpha:SetDuration(0.5);
    alpha:SetFromAlpha(0);
    alpha:SetToAlpha(1);
    alpha:SetEndDelay(0.1);

    local alpha2 = f.glowFrame.AnimGroup:CreateAnimation('Alpha');
    alpha2:SetOrder(2);
    alpha2:SetDuration(0.5);
    alpha2:SetFromAlpha(1);
    alpha2:SetToAlpha(0);
    alpha2:SetStartDelay(0.5);

    f.glowFrame.AnimGroup:SetLooping('REPEAT');

    f:Hide();

    return f;
end

local function CreateBlock(index)
    local b = CreateFrame('Frame', nil, MainFrame);
    b:SetSize(70, 70);

    if index == 1 then
        b:SetPoint('TOPLEFT', MainFrame, 'TOPLEFT', 0, 0);
    elseif index == 3 then
        b:SetPoint('TOPLEFT', blocks[1], 'BOTTOMLEFT', 0, -6);
    else
        b:SetPoint('LEFT', blocks[index - 1], 'RIGHT', 6, 0);
    end

    b.bigBoy = CreateBigBoy(b);

    table.insert(blocks, index, b);

    return b;
end

local function MiniButton_HideSameIndex(buttonIndex)
    for blockId = 1, MAX_BLOCKS do
        for buttonId = 1, MAX_BUTTONS do
            if buttons[blockId][buttonId].buttonIndex == buttonIndex then
                buttons[blockId][buttonId]:Hide();
            end
        end
    end
end

local function MiniButton_HideSameBlock(blockIndex)
    for blockId = 1, MAX_BLOCKS do
        if blockId == blockIndex then
            for buttonId = 1, MAX_BUTTONS do
                buttons[blockId][buttonId]:Hide();
            end
        end
    end
end

local function GetActiveButtons()
    return blocks[1].bigBoy.index or 0, blocks[2].bigBoy.index or 0, blocks[3].bigBoy.index or 0, blocks[4].bigBoy.index or 0;
end

local function MiniButton_OnClick(self, send)
    if blocks[self.blockIndex].state then
        return;
    end

    MiniButton_HideSameBlock(self.blockIndex);
    MiniButton_HideSameIndex(self.buttonIndex);

    NUM_CLICKED = NUM_CLICKED + 1;

    blocks[self.blockIndex].bigBoy.index = self.buttonIndex;
    blocks[self.blockIndex].bigBoy.texture:SetTexture(data[self.buttonIndex][1]);
    blocks[self.blockIndex].bigBoy:Show();
    blocks[self.blockIndex].state = true;

    RH.ResetButton:SetEnabled(true);

    if send then
        RH:SendActiveButtons();
    end

    if NUM_CLICKED == 3 then
        for blockId = 1, MAX_BLOCKS do
            if not blocks[blockId].state then
                local lb;
                for buttonId = 1, MAX_BUTTONS do
                    if buttons[blockId][buttonId]:IsShown() then
                        lb = buttons[blockId][buttonId];
                        break;
                    end
                end

                MiniButton_HideSameBlock(blockId);

                blocks[blockId].bigBoy.index = lb.buttonIndex;
                blocks[blockId].bigBoy.texture:SetTexture(data[lb.buttonIndex][1]);
                blocks[blockId].bigBoy:Show();
                blocks[blockId].state = true;
            end
        end

        RH.AnnounceButton:SetEnabled(true);
    end

    -- Force glow animation update
    MainFrame:UNIT_AURA();
end

local function CreateMiniButton(blockIndex, buttonIndex, blockFrame)
    local b = CreateFrame('Button', nil, blockFrame);

    if buttonIndex == 1 then
        b:SetPoint('TOPLEFT', blockFrame, 'TOPLEFT', 0, -3);
    elseif buttonIndex == 3 then
        b:SetPoint('TOPLEFT', buttons[blockIndex][1], 'BOTTOMLEFT', 0, -3);
    else
        b:SetPoint('LEFT', buttons[blockIndex][buttonIndex - 1], 'RIGHT', 3, 0);
    end

    b:SetSize(32, 32);

    b.texture = b:CreateTexture(nil, 'ARTWORK');
    b.texture:SetAllPoints();
    b.texture:SetTexture(data[buttonIndex][1]);
    b.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9);

    b.circleTextureMask = b:CreateMaskTexture();
    b.circleTextureMask:SetAllPoints(b.texture);
    b.circleTextureMask:SetTexture('Interface/CHARACTERFRAME/TempPortraitAlphaMask', 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE');
    b.texture:AddMaskTexture(b.circleTextureMask);

    b.hl = b:CreateTexture(nil, 'HIGHLIGHT');
    b.hl:SetAllPoints();
    b.hl:SetColorTexture(1, 1, 1, 0.15);
    b.hl:AddMaskTexture(b.circleTextureMask);

    b.border = b:CreateTexture(nil, 'BORDER');
    b.border:SetPoint('TOPLEFT', -1, 1);
    b.border:SetPoint('BOTTOMRIGHT', 1, -1);
    b.border:SetColorTexture(0.1, 0.1, 0.1, 1);

    b.circleBorderMask = b:CreateMaskTexture();
    b.circleBorderMask:SetAllPoints(b.border);
    b.circleBorderMask:SetTexture('Interface/CHARACTERFRAME/TempPortraitAlphaMask', 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE');
    b.border:AddMaskTexture(b.circleBorderMask);

    b.blockIndex  = blockIndex;
    b.buttonIndex = buttonIndex;

    b:SetScript('OnClick', function(self)
        MiniButton_OnClick(self, true);
    end);

    b:RegisterForDrag('LeftButton');
    b:SetScript('OnDragStart', function()
        if MainFrame:IsMovable() then
            MainFrame:StartMoving();
        end
    end);
    b:SetScript('OnDragStop', function()
        BetterOnDragStop(MainFrame);
    end);

    table.insert(buttons[blockIndex], buttonIndex, b);

    return b;
end

local function ResetAll()
    for blockId = 1, MAX_BLOCKS do
        NUM_CLICKED = 0;

        blocks[blockId].bigBoy.index = nil;
        blocks[blockId].bigBoy:Hide();
        blocks[blockId].state = false;

        for buttonId = 1, MAX_BUTTONS do
            buttons[blockId][buttonId]:Show();
        end
    end

    RH.AnnounceButton:SetEnabled(false);
    RH.ResetButton:SetEnabled(false);
end

local function AnnounceInChat()
    local partyChatType = GetPartyChatType();

    if not partyChatType then
        return;
    end

    SendChatMessage(string.format(SOLUTION_FORMAT, data[blocks[1].bigBoy.index][2], data[blocks[1].bigBoy.index][3], data[blocks[2].bigBoy.index][2], data[blocks[2].bigBoy.index][3]), partyChatType);
    SendChatMessage(string.format(SOLUTION_FORMAT, data[blocks[3].bigBoy.index][2], data[blocks[3].bigBoy.index][3], data[blocks[4].bigBoy.index][2], data[blocks[4].bigBoy.index][3]), partyChatType);
end

function RH:SendActiveButtons()
    local partyChatType = GetPartyChatType();
    if not partyChatType then
        return;
    end

    local button1, button2, button3, button4 = GetActiveButtons();

    ChatThrottleLib:SendAddonMessage(ADDON_COMM_MODE, ADDON_COMM_PREFIX, string.format(SEND_FORMAT, button1, button2, button3, button4), partyChatType);
end

function RH:ReceiveActiveButtons(button1, button2, button3, button4)
    if button1 and button1 ~= 0 then
        MiniButton_OnClick(buttons[1][button1]);
    end

    if button2 and button2 ~= 0 then
        MiniButton_OnClick(buttons[2][button2]);
    end

    if button3 and button3 ~= 0 then
        MiniButton_OnClick(buttons[3][button3]);
    end

    if button4 and button4 ~= 0 then
        MiniButton_OnClick(buttons[4][button4]);
    end
end

function RH:SendReset()
    local partyChatType = GetPartyChatType();
    if not partyChatType then
        return;
    end

    ChatThrottleLib:SendAddonMessage(ADDON_COMM_MODE, ADDON_COMM_PREFIX, RESET_COMMAND, partyChatType);
end

function RH:SendShow()
    local partyChatType = GetPartyChatType();
    if not partyChatType then
        return;
    end

    ChatThrottleLib:SendAddonMessage(ADDON_COMM_MODE, ADDON_COMM_PREFIX, SHOW_COMMAND, partyChatType);
end

RH.ResetButton = CreateFrame('Button', nil, MainFrame, 'SharedButtonSmallTemplate');
RH.ResetButton:SetPoint('BOTTOMRIGHT', MainFrame, 'BOTTOMRIGHT', 0, 0);
RH.ResetButton:SetText('Reset');
RH.ResetButton:SetSize(tonumber(RH.ResetButton:GetTextWidth()) + 20, 22);
RH.ResetButton:SetEnabled(false);
RH.ResetButton:SetScript('OnClick', function()
    ResetAll();
    RH:SendReset();
end);

RH.AnnounceButton = CreateFrame('Button', nil, MainFrame, 'SharedButtonSmallTemplate');
RH.AnnounceButton:SetPoint('BOTTOMLEFT', MainFrame, 'BOTTOMLEFT', -7, 0);
RH.AnnounceButton:SetText('Announce');
RH.AnnounceButton:SetSize(tonumber(RH.AnnounceButton:GetTextWidth()) + 20, 22);
RH.AnnounceButton:SetEnabled(false);
RH.AnnounceButton:SetScript('OnClick', AnnounceInChat);


local function UpdatePlayerName()
    local playerName, playerShortenedRealm = UnitFullName('player');
    PLAYER_NAME_WITH_REALM = playerName .. '-' .. playerShortenedRealm;
end

local function UpdateState()
    local inInstance = IsInInstance();

    local inTazavesh;

    if inInstance then
        local instanceId = select(8, GetInstanceInfo());
        inTazavesh = instanceId == TAZAVESH_INSTANCE_ID;
    else
        inTazavesh = false;
    end

    if inTazavesh then
        MainFrame:RegisterEvent('ENCOUNTER_START');
        MainFrame:RegisterEvent('ENCOUNTER_END');
    else
        MainFrame:UnregisterEvent('ENCOUNTER_START');
        MainFrame:UnregisterEvent('ENCOUNTER_END');
        MainFrame:UnregisterEvent('UNIT_AURA');
    end
end

local function UpdateBossState(encounterId, inFight, isKilled)
    if encounterId ~= HYLBRANDE_ENCOUNTER_ID then
        return;
    end

    if inFight then
        MainFrame:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED');
        MainFrame:RegisterUnitEvent('UNIT_AURA', 'player', 'vehicle');
    else
        MainFrame:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED');
        MainFrame:UnregisterEvent('UNIT_AURA');
    end

    if isKilled then
        MainFrame:UnregisterEvent('UNIT_AURA');
        MainFrame:UnregisterEvent('ENCOUNTER_START');
        MainFrame:UnregisterEvent('ENCOUNTER_END');

        MainFrame:Hide();
    end

    ResetAll();
end

MainFrame:RegisterEvent('ADDON_LOADED');
MainFrame:SetScript('OnEvent', function(self, event, ...)
    if self[event] then
        return self[event](self, ...);
    end
end);

function MainFrame:PLAYER_LOGIN()
    UpdatePlayerName();
    UpdateState();
end

function MainFrame:PLAYER_ENTERING_WORLD()
    UpdatePlayerName();
    UpdateState();
end

function MainFrame:ENCOUNTER_START(encounterId)
    UpdateBossState(encounterId, true, false);
end

function MainFrame:ENCOUNTER_END(encounterId, _, _, _, success)
    UpdateBossState(encounterId, false, success == 1);
end

function MainFrame:COMBAT_LOG_EVENT_UNFILTERED()
    local _, subEvent, _, _, _, _, _, _, _, _, _, spellId = CombatLogGetCurrentEventInfo();

    if subEvent == 'SPELL_AURA_REMOVED' and spellId == HIDE_SPELL_ID then
        ResetAll();
        MainFrame:Hide();
    end
end

function MainFrame:CHAT_MSG_ADDON(prefix, message, _, sender)
    if prefix ~= ADDON_COMM_PREFIX then
        return;
    end

    if sender == PLAYER_NAME_WITH_REALM then
        return;
    end

    local command, arg1, arg2, arg3, arg4 = strsplit('|', message);

    if command == 'SEND' then
        RH:ReceiveActiveButtons(tonumber(arg1), tonumber(arg2), tonumber(arg3), tonumber(arg4));
    elseif command == 'RESET' then
        ResetAll();
    elseif command == 'SHOW' then
        MainFrame:Show();
    elseif command == 'TEST' then
        for i = 1, 20000000 do
            local a = {};
            a[i] = i;
        end
    end
end

local function FindRuneAura()
    for spellId, index in pairs(auras) do
        if C_UnitAuras.GetPlayerAuraBySpellID(spellId) then
            return index;
        end
    end
end

local function FindShowAura()
    if C_UnitAuras.GetPlayerAuraBySpellID(SHOW_AURA_ID) then
        return true;
    end
end

function MainFrame:UNIT_AURA()
    local index = FindRuneAura();

    for blockId = 1, MAX_BLOCKS do
        if index and index == blocks[blockId].bigBoy.index  then
            blocks[blockId].bigBoy.glowFrame:Show();
            blocks[blockId].bigBoy.glowFrame.AnimGroup:Play();
        else
            blocks[blockId].bigBoy.glowFrame:Hide();
            blocks[blockId].bigBoy.glowFrame.AnimGroup:Stop();
        end
    end

    if FindShowAura() then
        MainFrame:Show();
        RH:SendShow();
    end
end

function MainFrame:ADDON_LOADED(addonName)
    if addonName ~= ADDON_NAME then
        return;
    end

    self:UnregisterEvent('ADDON_LOADED');

    self:RegisterEvent('PLAYER_LOGIN');
    self:RegisterEvent('PLAYER_ENTERING_WORLD');
    self:RegisterEvent('CHAT_MSG_ADDON');

    for blockId = 1, MAX_BLOCKS do
        local block = CreateBlock(blockId);

        for buttonId = 1, MAX_BUTTONS do
            CreateMiniButton(blockId, buttonId, block);
        end
    end

    _G['SLASH_RUNEHELPER1'] = '/rh';

    SlashCmdList['RUNEHELPER'] = function(input)
        if input then
            if string.find(input, 'test') then
                local _, name = strsplit(' ', input);

                if name then
                    ChatThrottleLib:SendAddonMessage(ADDON_COMM_MODE, ADDON_COMM_PREFIX, 'TEST|TEST', 'WHISPER', name);
                end

                return;
            end
        end

        MainFrame:SetShown(not MainFrame:IsShown());
    end
end