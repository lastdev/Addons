local waitTable = {};
local waitFrame = nil;

-- local variables
local BIG_BUTTON_SIZE = 45;
local SMALL_BUTTON_SIZE = 38;

local MAX_UNITFRAMES = 40;
local CLEANUI_HOOKED = nil;
local init = false;
local active = true;
local actStatusBarTexture = nil;
local actionButtonFrames = {};
local buttons = {};

local inCombat = nil;

-- spells
local SURGING_MIST, CHI_DETONATION, ENVELOPING_MIST, SOOTHING_MIST, RENEWING_MIST, UPLIFT, REVIVAL, LIFE_COCOON, EXPEL_HARM, MANATEA, MANATEA_BUFF, THUNDERFOCUSTEA, CHIBREW, DETOX, TIGERS_LUST, VITAL_MISTS_BUFF, RESUSCITATE;
local SURGING_MIST_ID, CHI_DETONATION_ID, ENVELOPING_MIST_ID, SOOTHING_MIST_ID, RENEWING_MIST_ID, UPLIFT_ID, REVIVAL_ID, LIFE_COCOON_ID, EXPEL_HARM_ID, MANATEA_ID, MANATEA_BUFF_ID, THUNDERFOCUSTEA_ID, CHIBREW_ID, DETOX_ID, TIGERS_LUST_ID, VITAL_MISTS_BUFF_ID, RESUSCITATE_ID;
local LEVEL_30, LEVEL_60, LEVEL_100;
local LEVEL_30_ID, LEVEL_60_ID, LEVEL_100_ID;

-- unit names
local PARTY_UNITS = {"player", "party1", "party2", "party3", "party4"};

-- frame layer
local BUTTON_FRAMESTRATA = "MEDIUM";

--The default setup function
local texCoords = {
    ["Raid-AggroFrame"] =  { 0.00781250, 0.55468750, 0.00781250, 0.27343750 },
    ["Raid-TargetFrame"] = { 0.00781250, 0.55468750, 0.28906250, 0.55468750 },
}

-- die Farben sind etwas heller, damit sie besser erkennbar sind. Es wird ja nur das Icon eingefärbt.
local MWDebuffTypeColor = { };
MWDebuffTypeColor["none"]	= { r = 0.80, g = 0, b = 0 };
MWDebuffTypeColor["Magic"]	= { r = 0.40, g = 0.70, b = 1.00 };
MWDebuffTypeColor["Curse"]	= { r = 0.60, g = 0.00, b = 1.00 };
MWDebuffTypeColor["Disease"]	= { r = 1.00, g = 0.60, b = 0.00 };
MWDebuffTypeColor["Poison"]	= { r = 0.40, g = 1.00, b = 0.40 };
MWDebuffTypeColor[""]	= MWDebuffTypeColor["none"];

-- Stern, Kreis, ...
local raidicons = {};
raidicons[0] = {left=0, right=0, top=0, bottom=0};
raidicons[1] = {left=0, right=0.25, top=0, bottom=0.25};
raidicons[2] = {left=0.25, right=0.5, top=0, bottom=0.25};
raidicons[3] = {left=0.5, right=0.75, top=0, bottom=0.25};
raidicons[4] = {left=0.75, right=1, top=0, bottom=0.25};
raidicons[5] = {left=0, right=0.25, top=0.25, bottom=0.5};
raidicons[6] = {left=0.25, right=0.5, top=0.25, bottom=0.5};
raidicons[7] = {left=0.5, right=0.75, top=0.25, bottom=0.5};
raidicons[8] = {left=0.75, right=1, top=0.25, bottom=0.5};

-- functions
function MistWeaver_OnLoad(self)
    mw_debug("MistWeaver_OnLoad");
    local _, unitClass = UnitClass("player");
    mw_debug(unitClass, "unitClass");
    if (unitClass ~= "MONK") then
        return;
    end

    self:RegisterEvent("ADDON_LOADED");

    self:RegisterEvent("PLAYER_ENTERING_WORLD");

    self:RegisterEvent("PLAYER_REGEN_DISABLED");
    self:RegisterEvent("PLAYER_REGEN_ENABLED");

    self:RegisterEvent("PLAYER_ROLES_ASSIGNED");

    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
    self:RegisterEvent("UPDATE_SHAPESHIFT_FORM");

    self:RegisterEvent("GROUP_ROSTER_UPDATE");

    self:RegisterEvent("UNIT_HEALTH");
    self:RegisterEvent("UNIT_MAXHEALTH");
    self:RegisterEvent("UNIT_HEAL_PREDICTION");

    self:RegisterEvent("CVAR_UPDATE");

    SLASH_MISTWEAVER1 = "/mw";
    SLASH_MISTWEAVER2 = "/mistweaver";
    SlashCmdList["MISTWEAVER"] = function(msg)
        MistWeaver_SlashCommandHandler(msg);
    end
end

function MistWeaver_OnEvent(self, event, ...)
    if (event == "ADDON_LOADED") then
        local addonName = ...;
        if (addonName == "MistWeaver") then
            MistWeaver_StartDelay(3, MistWeaver_Init);
        end
    end

    if (event == "PLAYER_ENTERING_WORLD") then
        MistWeaver_HookCleanUI();
    end

    if (event == "CVAR_UPDATE") then
        local name, value = ...;
        MistWeaver_CvarUpdate(name, value);
    end

    if (not init) then
        return;
    end

    if (event == "PLAYER_REGEN_DISABLED") then
    --MistWeaver_EnterCombat();
    end

    if (event == "PLAYER_REGEN_ENABLED" or event == "GROUP_ROSTER_UPDATE") then
        MistWeaver_RebindUnitFrames();
    --MistWeaver_LeaveCombat();
    end
    if (event == "PARTY_MEMBERS_CHANGED") then
        MistWeaver_PartyMembersChanged();
    end
    if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
        MistWeaver_StartDelay(2, MistWeaver_TalentGroupChanged);
    end
    if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "UPDATE_SHAPESHIFT_FORM") then
        MistWeaver_UpdateActiveState();
    end
    if (event == "PLAYER_ROLES_ASSIGNED") then
        MistWeaver_PlayerRolesAssigned();
    end
    if (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" or event == "UNIT_HEAL_PREDICTION") then
        MistWeaver_UpdateHealPrediction(self);
    end
end

function MistWeaver_CvarUpdate(name, value)
    if (name == "ACTION_BUTTON_USE_KEY_DOWN") then
        MistWeaver_RegisterForClicks();
    end
end

function MistWeaver_StartDelay(delay, func, ...)
    if(type(delay)~="number" or type(func)~="function") then
        return false;
    end

    if(waitFrame == nil) then
        waitFrame = MistWeaver_CreateFrame("Frame","MW_WaitFrame", UIParent);
        waitFrame:SetScript("onUpdate",function (self,elapse)
            local count = #waitTable;
            local i = 1;

            while(i<=count) do
                local waitRecord = tremove(waitTable,i);
                local d = tremove(waitRecord,1);
                local f = tremove(waitRecord,1);
                local p = tremove(waitRecord,1);

                if(d>elapse) then
                    tinsert(waitTable,i,{d-elapse,f,p});
                    i = i + 1;
                else
                    count = count - 1;
                    f(unpack(p));
                end
            end
        end);
    end

    tinsert(waitTable,{delay,func,{...}});

    return true;
end

function MistWeaver_HookCleanUI()
    if (CLEANUI_HOOKED or not IsAddOnLoaded("CleanUI")) then
        return;
    end

    hooksecurefunc("CleanUI_HookChangeStatusBar", MistWeaver_ChangeStatusBar);

    CLEANUI_HOOKED = 1;
end

function MistWeaver_Init()
    mw_debug("MistWeaver_Init");
    MistWeaver_UpdateActiveState();

    MistWeaver_TargetFrameOnLoad(MwTargetFrame);
    MistWeaver_FocusFrameOnLoad(MwFocusFrame);

    MistWeaver_CreateUnitFrames();
    MistWeaver_LoadSpells();

    local powerFrame = _G["MwPowerFrame"];
    MistWeaver_SetBackdrop(powerFrame);
    powerFrame:SetFrameStrata("LOW");

    -- chi bar
    local chiBar = MistWeaver_CreateFrame("StatusBar", "MwPowerFrameChi", powerFrame, "MwTextStatusBarTemplate");
    chiBar:SetSize(10, 10);
    chiBar:ClearAllPoints();
    chiBar:SetPoint("TOPLEFT", powerFrame, "TOPLEFT", 4, -4);
    chiBar:SetPoint("BOTTOMRIGHT", powerFrame, "TOPRIGHT", -4, -28);
    chiBar:SetStatusBarColor(0.85, 0.85, 0.85);
    chiBar:SetFrameStrata("LOW");

    local chiBrewBarButton = MistWeaver_CreateFrame("Button", "MwChiBrewBarButton", chiBar, "SecureActionButtonTemplate");
    chiBrewBarButton:SetFrameStrata("MEDIUM");
    chiBrewBarButton:ClearAllPoints();
    chiBrewBarButton:SetPoint("TOPLEFT", chiBar, "TOPLEFT", 0, 0);
    chiBrewBarButton:SetPoint("BOTTOMRIGHT", chiBar, "BOTTOMRIGHT", 0, 0);
    MistWeaver_RegisterButton(chiBrewBarButton);
    chiBrewBarButton:SetAttribute("type", "spell");
    chiBrewBarButton:SetAttribute("spell", CHIBREW);
    chiBrewBarButton:SetAttribute("spellId", CHIBREW_ID);
    chiBrewBarButton:SetAttribute("type2", "spell");
    chiBrewBarButton:SetAttribute("spell2", CHI_DETONATION);
    chiBrewBarButton:SetAttribute("spellId2", CHI_DETONATION_ID);

    -- mana bar
    local manaBar = MistWeaver_CreateFrame("StatusBar", "MwPowerFrameMana", powerFrame, "MwTextStatusBarTemplate");
    manaBar:ClearAllPoints();
    manaBar:SetPoint("TOPLEFT", chiBar, "BOTTOMLEFT", 0, 0);
    manaBar:SetPoint("BOTTOMRIGHT", powerFrame, "BOTTOMRIGHT", -4, 4);
    local manacolor = PowerBarColor["MANA"];
    manaBar:SetStatusBarColor(manacolor.r, manacolor.g, manacolor.b);
    manaBar:SetFrameStrata("LOW");

    local manaTeaBarButton = MistWeaver_CreateFrame("Button", "MwManaTeaBarButton", manaBar, "SecureActionButtonTemplate");
    manaTeaBarButton:SetFrameStrata("MEDIUM");
    manaTeaBarButton:ClearAllPoints();
    manaTeaBarButton:SetPoint("TOPLEFT", manaBar, "TOPLEFT", 0, 0);
    manaTeaBarButton:SetPoint("BOTTOMRIGHT", manaBar, "BOTTOMRIGHT", 0, 0);
    MistWeaver_RegisterButton(manaTeaBarButton);
    manaTeaBarButton:SetAttribute("type", "spell");
    manaTeaBarButton:SetAttribute("spell", MANATEA);
    manaTeaBarButton:SetAttribute("spellId", MANATEA_ID);


    -- AE
    local detonateChi = MistWeaver_CreateActionButton("MwDetonateChiCastFrame", BIG_BUTTON_SIZE);
    detonateChi:SetPoint("TOPRIGHT", powerFrame, "TOPLEFT", 0, 0);

    local revivalCast = MistWeaver_CreateActionButton("MwRevivalCastFrame", BIG_BUTTON_SIZE);
    revivalCast:SetPoint("RIGHT", detonateChi, "LEFT", 2, 0);
    

    -- health bar

    -- left/right
    local envelopingMistCast = MistWeaver_CreateActionButton("MwEnvelopingMistCastFrame", SMALL_BUTTON_SIZE, KEY_BUTTON1);
    envelopingMistCast:SetPoint("TOPRIGHT", revivalCast, "BOTTOMRIGHT", 0, -2);

    local soothingMistCast = MistWeaver_CreateActionButton("MwSoothingMistCastFrame", SMALL_BUTTON_SIZE, KEY_BUTTON2);
    soothingMistCast:SetPoint("TOPLEFT", detonateChi, "BOTTOMLEFT", 0, -2);

    -- shift left/right
    local surgingMistCast = MistWeaver_CreateActionButton("MwSurgingMistCastFrame", SMALL_BUTTON_SIZE, "["..SHIFT_KEY.."] + "..KEY_BUTTON1);
    surgingMistCast:SetPoint("TOP", envelopingMistCast, "BOTTOM", 0, 2);

    local level30Cast = MistWeaver_CreateActionButton("MwLevel30CastFrame", SMALL_BUTTON_SIZE, "["..SHIFT_KEY.."] + "..KEY_BUTTON2);
    level30Cast:SetPoint("TOP", soothingMistCast, "BOTTOM", 0, 2);

    -- alt left/right
    local expelHarmCast = MistWeaver_CreateActionButton("MwExpelHarmCastFrame", SMALL_BUTTON_SIZE, "["..ALT_KEY.."] + "..KEY_BUTTON1);
    expelHarmCast:SetPoint("TOP", surgingMistCast, "BOTTOM", 0, 2);

    local level100Cast = MistWeaver_CreateActionButton("MwLevel100CastFrame", SMALL_BUTTON_SIZE, "["..ALT_KEY.."] + "..KEY_BUTTON2);
    level100Cast:SetPoint("TOP", level30Cast, "BOTTOM", 0, 2);

    -- middle
    local lifeCocoonCast = MistWeaver_CreateActionButton("MwLifeCocoonCastFrame", BIG_BUTTON_SIZE, KEY_BUTTON3);
    lifeCocoonCast:SetPoint("TOPRIGHT", expelHarmCast, "BOTTOMRIGHT", 0, -2);

    local level60Cast = MistWeaver_CreateActionButton("MwLevel60CastFrame", BIG_BUTTON_SIZE, "["..SHIFT_KEY.."] + "..KEY_BUTTON3);
    level60Cast:SetPoint("TOPLEFT", level100Cast, "BOTTOMLEFT", 0, -2);


    -- enveloping mist bar

    -- left/right
    local upliftCast = MistWeaver_CreateActionButton("MwUpliftCastFrame", SMALL_BUTTON_SIZE, KEY_BUTTON1);
    upliftCast:SetPoint("TOPRIGHT", lifeCocoonCast, "BOTTOMRIGHT", 0, -2);

    local renewingMistCast = MistWeaver_CreateActionButton("MwRenewingMistCastFrame", SMALL_BUTTON_SIZE, KEY_BUTTON2);
    renewingMistCast:SetPoint("TOPLEFT", level60Cast, "BOTTOMLEFT", 0, -2);



    -- chi brew button
    local chiBrew = MistWeaver_CreateActionButton("MwChiBrewFrame", 27);
    chiBrew:SetPoint("LEFT", chiBar, "LEFT", -1, 0); 
    chiBrew:SetFrameStrata("MEDIUM");
    chiBrew:SetAlpha(0.85);
    MistWeaver_RemoveTextures(chiBrew);

    chiBrew:HookScript("OnUpdate", MistWeaver_ChiBrewOnUpdate);
    chiBrew:HookScript("OnEnter", MistWeaver_OnButtonEnter);
    chiBrew:HookScript("OnLeave", MistWeaver_OnButtonLeave);

    -- mana tea button
    local manaTea = MistWeaver_CreateActionButton("MwManaTeaFrame", 27);
    manaTea:SetPoint("LEFT", manaBar, "LEFT", -1, 0);
    manaTea:SetFrameStrata("MEDIUM");
    manaTea:SetAlpha(0.85);
    MistWeaver_RemoveTextures(manaTea);

    manaTea:HookScript("OnUpdate", MistWeaver_ManaTeaOnUpdate);
    manaTea:HookScript("OnEnter", MistWeaver_OnButtonEnter);
    manaTea:HookScript("OnLeave", MistWeaver_OnButtonLeave);


    -- thunder focus tea
    local thunderFocusTea = MistWeaver_CreateActionButton("MwThunderFocusTeaFrame", 56);
    thunderFocusTea:SetPoint("LEFT", powerFrame, "RIGHT", 2, 0);

    local label = MistWeaver_CreateFontString(thunderFocusTea, "MwThunderFocusTeaFrameLabel", "ARTWORK");
    label:SetFontObject(GameFontWhiteSmall);
    label:ClearAllPoints();
    label:SetPoint("BOTTOM", thunderFocusTea, "TOP", 0, 0);


    -- info button
    local infoButton = MistWeaver_CreateFrame("Button", "MwInfoButton", MistWeaverFrame);
    infoButton:SetWidth(12);
    infoButton:SetHeight(12);
    infoButton:ClearAllPoints();
    infoButton:SetPoint("TOPLEFT", thunderFocusTea, "TOPRIGHT", 2, 0);
    infoButton:EnableMouseWheel(1);

    infoButton:SetNormalTexture("Interface\\FriendsFrame\\InformationIcon");
    infoButton:SetPushedTexture("Interface\\Addons\\CleanUI\\skins\\empty");
    infoButton:SetHighlightTexture("Interface\\Addons\\CleanUI\\skins\\empty");

    infoButton.menu = MistWeaver_CreateFrame("Frame", "MwInfoMenu", MistWeaverFrame, "UIMenuTemplate");
    MistWeaver_SetBackdrop(infoButton.menu);

    infoButton:HookScript("OnClick", MistWeaver_OpenInfoMenu);
    infoButton:HookScript("OnEnter", MistWeaver_InfoButtonOnEnter);
    infoButton:HookScript("OnLeave", MistWeaver_InfoButtonOnLeave);
    infoButton:HookScript("OnMouseDown", MistWeaver_MwPowerFrameOnMouseDown);
    infoButton:HookScript("OnMouseUp", MistWeaver_MwPowerFrameOnMouseUp);
    infoButton:HookScript("OnMouseWheel", MistWeaver_MwPowerFrameOnMouseWheel);

    infoButton:SetAlpha(0.1);

    -- update ui
    MistWeaver_UpdateUnitFrameSize();

    init = true;

    -- events
    MistWeaver_RebindButtonSpells();
    MistWeaver_RebindUnitFrames();
    MistWeaver_PartyMembersChanged();
    MistWeaver_PlayerRolesAssigned();

    MistWeaver_RegisterForClicks();

    if (InCombatLockdown()) then
        MistWeaver_EnterCombat();
    else
        MistWeaver_LeaveCombat();
    end
end

function MistWeaver_CreateActionButton(name, size, tooltip)
    local frame = MistWeaver_CreateFrame("Frame", name, MistWeaverFrame, "MistWeaverButtonFrameTemplate");
    frame:SetParent(MistWeaverFrame);
    frame:SetSize(size, size);
    frame:SetFrameStrata("LOW");

    MistWeaver_RegisterButton(frame.button);

    -- Cooldown
    frame.button.cooldown:ClearAllPoints();
    frame.button.cooldown:SetPoint("TOPLEFT", frame.button, "TOPLEFT", 4, -4);
    frame.button.cooldown:SetPoint("BOTTOMRIGHT", frame.button, "BOTTOMRIGHT", -4, 4);
    
    frame.button.cooldown:SetEdgeTexture("Interface\\Cooldown\\edge");
    frame.button.cooldown:SetSwipeColor(0, 0, 0);
    frame.button.cooldown:SetHideCountdownNumbers(false);
    frame.button.cooldown.currentCooldownType = COOLDOWN_TYPE_NORMAL;
            
    frame.button:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");

    -- Tooltip
    if (tooltip) then
        frame.button.tooltip = "|c333399ff"..tooltip.."|r";
    end

    -- Actions
    frame.button:HookScript("OnUpdate", MistWeaver_OnButtonUpdate);
    frame.button:HookScript("OnEnter", MistWeaver_OnButtonEnter);
    frame.button:HookScript("OnLeave", MistWeaver_OnButtonLeave);

    frame.button:GetPushedTexture():ClearAllPoints();
    frame.button:GetPushedTexture():SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2);
    frame.button:GetPushedTexture():SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2);
    frame.button:GetPushedTexture():SetDrawLayer("OVERLAY");

    frame.button:GetHighlightTexture():ClearAllPoints();
    frame.button:GetHighlightTexture():SetPoint("CENTER", frame, "CENTER", 0, 0);
    frame.button:GetHighlightTexture():SetSize(size * 1.1, size * 1.1);

    tinsert(actionButtonFrames, name);

    return frame;
end

function MistWeaver_EnterCombat()
    inCombat = 1;
    MistWeaver_ShowMainFrame();
end

function MistWeaver_ShowMainFrame()
    MistWeaverFrame:SetAlpha(1.0);
end

function MistWeaver_LeaveCombat()
    inCombat = nil;
    MistWeaver_StartDelay(3, MistWeaver_HideMainFrame);
end

function MistWeaver_HideMainFrame()
    if (InCombatLockdown()) then
        MistWeaver_EnterCombat();
    else
        MistWeaverFrame:SetAlpha(MistWeaverData.OOC_ALPHA);
    end
end

function MistWeaver_ChangeStatusBar(texture)
    actStatusBarTexture = texture;
    MistWeaver_ReloadStatusBarTexture();
end

function MistWeaver_GetStatusBarTexture()
    return actStatusBarTexture;
end

function MistWeaver_ReloadStatusBarTexture()

    local healthBar;

    for i=1, MAX_UNITFRAMES, 1 do
        healthBar = _G["MwUnitFrame"..i.."Health"];
        if (not healthBar) then
            MistWeaver_StartDelay(3, MistWeaver_ReloadStatusBarTexture);
            return;
        end
    end

    local texture = actStatusBarTexture;

    for i=1, MAX_UNITFRAMES, 1 do
        _G["MwUnitFrame"..i.."Health"]:SetStatusBarTexture(texture);
        _G["MwUnitFrame"..i.."HealthPrediction"]:SetStatusBarTexture(texture);
        _G["MwUnitFrame"..i.."Aggro"]:SetStatusBarTexture(texture);
        _G["MwUnitFrame"..i.."RenewingMist"]:SetStatusBarTexture(texture);
        _G["MwUnitFrame"..i.."SoothingMist"]:SetStatusBarTexture(texture);
        _G["MwUnitFrame"..i.."EnvelopingMist"]:SetStatusBarTexture(texture);
    end

    MwPowerFrameChi:SetStatusBarTexture(texture);
    MwPowerFrameMana:SetStatusBarTexture(texture);

    MistWeaver_ReloadTargetStatusBarTexture();
    MistWeaver_ReloadFocusStatusBarTexture();
end

function MistWeaver_SlashCommandHandler(msg)
    if (msg == "reload") then
        ReloadUI();
    elseif (string.find(msg, "help") == 1) then
        MistWeaver_Help();
    elseif (string.find(msg, "on") == 1) then
        MistWeaverData.ACTIVE = true;
        MistWeaver_UpdateActiveState();
    elseif (string.find(msg, "off") == 1) then
        MistWeaverData.ACTIVE = false;
        MistWeaver_UpdateActiveState();
    elseif (string.find(msg, "width") == 1) then
        local str_width = string.sub(msg, 7);
        local width = tonumber(str_width);

        if (width and width >= 50 and width <= 200) then
            MistWeaverData.UNITWIDTH = width;
            MistWeaver_UpdateUnitFrameSize();
        else
            mw_info("|c333399ffwidth|r: 50 - 200");
        end
    elseif (string.find(msg, "height") == 1) then
        local str_height = string.sub(msg, 8);
        local height = tonumber(str_height);

        if (height and height >= 40 and height <= 100) then
            MistWeaverData.UNITHEIGHT = height;
            MistWeaver_UpdateUnitFrameSize();
        else
            mw_info("|c333399ffheight|r: 40 - 100");
        end
    elseif (string.find(msg, "colortype") == 1) then
        local colortype = string.sub(msg, 11);

        if (colortype == "health") then
            MistWeaverData.COLORTYPE = 1;
        elseif (colortype == "class") then
            MistWeaverData.COLORTYPE = 2;
        else
            mw_info("|c333399ffcolortype|r health "..MW_OR_INSET.." class");
        end
    elseif (string.find(msg, "sorttype") == 1) then
        local sorttype = string.sub(msg, 10);

        if (sorttype == "id") then
            MistWeaverData.SORTTYPE = 1;
        elseif (sorttype == "group") then
            MistWeaverData.SORTTYPE = 2;
        elseif (sorttype == "name") then
            MistWeaverData.SORTTYPE = 3;
        elseif (sorttype == "role") then
            MistWeaverData.SORTTYPE = 4;
        else
            mw_info("|c333399ffsorttype|r id, group "..MW_OR_INSET.." name");
        end

        MistWeaver_RebindUnitFrames();
    elseif (string.find(msg, "spellid") == 1) then
        local name = string.sub(msg, 9);
        local link = GetSpellLink(name);
        printable = gsub(link, "\124", "\124\124");
        ChatFrame1:AddMessage("Here's what it really looks like: \"" .. printable .. "\"");
    end

    MwConfig_RefreshUI();
end

function MistWeaver_Help()
    mw_info("|c333399ffNirriti's|r MistWeaver "..MW_HELP..":");

    mw_info(MW_HELP_MOVE_FRAME);

    mw_info("|c333399ff  - ["..CTRL_KEY.."] + "..KEY_BUTTON2.."|r "..MW_MOVE_FRAME);

    mw_info("|c333399ff  - "..MW_CLICK_CHIBAR.."|r "..MW_USE_CHIBREW);

    mw_info("|c333399ff  - "..MW_CHATCOMMAND.."|r /mw "..MW_OR_INSET.." /mistweaver");
    mw_info("|c333399ff      /mw width #|r "..MW_UNIT_FRAME_WIDTH.." (50 - 200)");
    mw_info("|c333399ff      /mw height #|r "..MW_UNIT_FRAME_HEIGHT.." (40 - 100)");
    mw_info("|c333399ff      /mw colortype health|r "..MW_UNIT_SELECT_HEALTH);
    mw_info("|c333399ff      /mw colortype class|r "..MW_UNIT_SELECT_CLASS);
    mw_info("|c333399ff      /mw sorttype id|r "..MW_SORT_TYPE_ID);
    mw_info("|c333399ff      /mw sorttype group|r "..MW_SORT_TYPE_GROUP);
    mw_info("|c333399ff      /mw sorttype name|r "..MW_SORT_TYPE_NAME);
    mw_info("|c333399ff      /mw sorttype role|r "..MW_SORT_TYPE_ROLE);
    mw_info("|c333399ff      /mw on|r "..MW_ON);
    mw_info("|c333399ff      /mw off|r "..MW_OFF);

    mw_info("|c333399ff  - "..MW_UNIT_FRAMES);
    mw_info("|c333399ff      ["..ALT_KEY.."]+mouse over:|r "..MW_SHOW_TOOLTIP);
    mw_info("|c333399ff      ["..CTRL_KEY.."]+"..KEY_BUTTON1..":|r "..MW_SHOW_OOR);
    mw_info("|c333399ff      ["..CTRL_KEY.."]+"..KEY_BUTTON2..":|r "..MW_SHOW_HIGHLIGHT);

    mw_info("|c333399ff  - "..MW_HEALTH_BAR_SPELLS);
    MistWeaver_ShowButtonInfo(_G["MwUnitFrame1Button1"]);
    mw_info("|c333399ff  - "..MW_RENEWING_MIST_SPELLS);
    MistWeaver_ShowButtonInfo(_G["MwUnitFrame1Button2"]);
end

function MistWeaver_ShowButtonInfo(button)
    local spell1 = button:GetAttribute("spell1");
    local spell2 = button:GetAttribute("spell2");
    local spell3 = button:GetAttribute("spell3");
    local shift_spell1 = button:GetAttribute("shift-spell1");
    local shift_spell2 = button:GetAttribute("shift-spell2");
    local shift_spell3 = button:GetAttribute("shift-spell3");
    local alt_spell1 = button:GetAttribute("alt-spell1");
    local alt_spell2 = button:GetAttribute("alt-spell2");
    local ctrl_shift_spell1 = button:GetAttribute("ctrl-shift-spell1");
    local ctrl_shift_spell2 = button:GetAttribute("ctrl-shift-spell2");

    if (shift_spell1 == spell1) then
        shift_spell1 = nil;
    end
    if (shift_spell2 == spell2) then
        shift_spell2 = nil;
    end
    if (shift_spell3 == spell3) then
        shift_spell3 = nil;
    end

    if (spell1) then
        mw_info("|c333399ff      "..KEY_BUTTON1..":|r "..spell1);
    end
    if (spell2) then
        mw_info("|c333399ff      "..KEY_BUTTON2..":|r "..spell2);
    end
    if (spell3) then
        mw_info("|c333399ff      "..KEY_BUTTON3..":|r "..spell3);
    end
    if (shift_spell1) then
        mw_info("|c333399ff      ".."["..SHIFT_KEY.."] + "..KEY_BUTTON1..":|r "..shift_spell1);
    end
    if (shift_spell2) then
        mw_info("|c333399ff      ".."["..SHIFT_KEY.."] + "..KEY_BUTTON2..":|r "..shift_spell2);
    end
    if (shift_spell3) then
        mw_info("|c333399ff      ".."["..SHIFT_KEY.."] + "..KEY_BUTTON3..":|r "..shift_spell3);
    end
    if (alt_spell1) then
        mw_info("|c333399ff      ".."["..ALT_KEY.."] + "..KEY_BUTTON1..":|r "..alt_spell1);
    end
    if (alt_spell2) then
        mw_info("|c333399ff      ".."["..ALT_KEY.."] + "..KEY_BUTTON2..":|r "..alt_spell2);
    end
    if (ctrl_shift_spell1) then
        mw_info("|c333399ff      ".."["..CTRL_KEY.."] + ["..SHIFT_KEY.."] + "..KEY_BUTTON1..":|r "..ctrl_shift_spell1);
    end
    if (ctrl_shift_spell2) then
        mw_info("|c333399ff      ".."["..CTRL_KEY.."] + ["..SHIFT_KEY.."] + "..KEY_BUTTON2..":|r "..ctrl_shift_spell2);
    end
end

function MistWeaver_ShowUnitFrameTooltip(self)
    local spell1 = self:GetAttribute("spell1");
    local spell2 = self:GetAttribute("spell2");
    local spell3 = self:GetAttribute("spell3");
    local shift_spell1 = self:GetAttribute("shift-spell1");
    local shift_spell2 = self:GetAttribute("shift-spell2");
    local shift_spell3 = self:GetAttribute("shift-spell3");
    local alt_spell1 = self:GetAttribute("alt-spell1");
    local alt_spell2 = self:GetAttribute("alt-spell2");
    local ctrl_shift_spell1 = self:GetAttribute("ctrl-shift-spell1");
    local ctrl_shift_spell2 = self:GetAttribute("ctrl-shift-spell2");

    if (shift_spell1 == spell1) then
        shift_spell1 = nil;
    end
    if (shift_spell2 == spell2) then
        shift_spell2 = nil;
    end
    if (shift_spell3 == spell3) then
        shift_spell3 = nil;
    end

    GameTooltip_SetDefaultAnchor(GameTooltip, self);

    GameTooltip:AddLine(MW_SPELLS..":", 1.0, 1.0, 1.0);

    GameTooltip:AddLine(" ", 1.0, 1.0, 1.0);

    if (spell1) then
        GameTooltip:AddDoubleLine("|c333399ff"..KEY_BUTTON1.."|r", spell1, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end
    if (spell2) then
        GameTooltip:AddDoubleLine("|c333399ff"..KEY_BUTTON2.."|r", spell2, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end
    if (spell3) then
        GameTooltip:AddDoubleLine("|c333399ff"..KEY_BUTTON3.."|r", spell3, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end
    if (shift_spell1) then
        GameTooltip:AddDoubleLine("|c333399ff".."["..SHIFT_KEY.."] + "..KEY_BUTTON1.."|r", shift_spell1, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end
    if (shift_spell2) then
        GameTooltip:AddDoubleLine("|c333399ff".."["..SHIFT_KEY.."] + "..KEY_BUTTON2.."|r", shift_spell2, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end
    if (shift_spell3) then
        GameTooltip:AddDoubleLine("|c333399ff".."["..SHIFT_KEY.."] + "..KEY_BUTTON3.."|r", shift_spell3, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end
    if (alt_spell1) then
        GameTooltip:AddDoubleLine("|c333399ff".."["..ALT_KEY.."] + "..KEY_BUTTON1.."|r", alt_spell1, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end
    if (alt_spell2) then
        GameTooltip:AddDoubleLine("|c333399ff".."["..ALT_KEY.."] + "..KEY_BUTTON2.."|r", alt_spell2, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end

    GameTooltip:AddLine(" ", 1.0, 1.0, 1.0);

    if (ctrl_shift_spell1) then
        GameTooltip:AddDoubleLine("|c333399ff".."["..CTRL_KEY.."] + ["..SHIFT_KEY.."] + "..KEY_BUTTON1.."|r", ctrl_shift_spell1, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end
    if (ctrl_shift_spell2) then
        GameTooltip:AddDoubleLine("|c333399ff".."["..CTRL_KEY.."] + ["..SHIFT_KEY.."] + "..KEY_BUTTON2.."|r", ctrl_shift_spell2, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    end

    GameTooltip:AddLine(" ", 1.0, 1.0, 1.0);

    GameTooltip:AddDoubleLine("|c333399ff".."["..CTRL_KEY.."] + "..KEY_BUTTON1.."|r", MW_SHOW_OOR, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
    GameTooltip:AddDoubleLine("|c333399ff".."["..CTRL_KEY.."] + "..KEY_BUTTON2.."|r", MW_SHOW_HIGHLIGHT, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);

    GameTooltip:Show();
end

function MistWeaver_UpdateActiveState()

    if (InCombatLockdown()) then
        return;
    end

    -- monk only
    local _, unitClass = UnitClass("player");

    -- tiger:103985, serpent:115070
    local serpentName = GetSpellInfo(115070);

    -- all or serpent stance only
    local _, name1 = GetShapeshiftFormInfo(1);
    local _, name2 = GetShapeshiftFormInfo(2);

    local serpentStance = -1;
    if (serpentName == name1) then
        serpentStance = 1;
    elseif (serpentName == name2) then
        serpentStance = 2;
    end

    local shapeshiftOk = MistWeaverData.SHOW_IN_ALL_STANCES or GetShapeshiftForm() == serpentStance;
    local specialization = GetSpecialization(false, false, GetActiveSpecGroup());
    local specializationOk = (specialization == 2);
    local groupOk = MistWeaverData.SHOW_SOLO or GetNumGroupMembers() > 0;

    if (unitClass == "MONK" and shapeshiftOk and specializationOk and groupOk and MistWeaverData.ACTIVE) then
        MistWeaverFrame:Show();
        active = true;
        mw_debug("on");
    else
        MistWeaverFrame:Hide();
        active = false;
        mw_debug("off");
    end
end

function MistWeaver_IsActive()
    return active;
end

function MistWeaver_MwPowerFrameOnMouseDown(frame, button)
    if (button == "RightButton") then
        if (IsControlKeyDown()) then
            MistWeaverFrame:StartMoving();
        end
    end
end

function MistWeaver_MwPowerFrameOnMouseUp(frame, button)
    MistWeaverFrame:StopMovingOrSizing();
end

function MistWeaver_MwPowerFrameOnMouseWheel(frame, delta)
    CleanUI_ShowHealingTooltipWithDelta(frame, delta);
end

function MistWeaver_LoadSpells()

    SURGING_MIST_ID = 116694;
    SURGING_MIST = GetSpellInfo(SURGING_MIST_ID);

    --157675

    -- lvl 30 talent
    local chiWave = GetSpellInfo(115098);
    local zenSphere = GetSpellInfo(124081);
    local chiBurst = GetSpellInfo(123986);

    LEVEL_30_ID = nil;
    LEVEL_30 = nil;
    if (GetSpellInfo(chiWave)) then
        LEVEL_30_ID = 115098;
        LEVEL_30 = chiWave;
    elseif (GetSpellInfo(zenSphere)) then
        LEVEL_30_ID = 124081;
        LEVEL_30 = zenSphere;
    elseif (GetSpellInfo(chiBurst)) then
        LEVEL_30_ID = 123986;
        LEVEL_30 = chiBurst;
    end

    -- lvl 60 talent
    local ringOfPeace = GetSpellInfo(116844);
    local chargingOxWave = GetSpellInfo(119392);
    local legSweep = GetSpellInfo(119381);

    LEVEL_60_ID = nil;
    LEVEL_60 = nil;
    if (GetSpellInfo(ringOfPeace)) then
        LEVEL_60_ID = 116844;
        LEVEL_60 = ringOfPeace;
    elseif (GetSpellInfo(chargingOxWave)) then
        LEVEL_60_ID = 119392;
        LEVEL_60 = chargingOxWave;
    elseif (GetSpellInfo(legSweep)) then
        LEVEL_60_ID = 119381;
        LEVEL_60 = legSweep;
    end

    -- lvl 100 talent
    local breathOfTheSerpent = GetSpellInfo(157535);
    local chiExplosion = GetSpellInfo(157675);
    local poolOfMists = GetSpellInfo(101546);

    -- pool of mists = 173841, passiv, deswegen Wirbelnder Krasnichtritt 101546

    LEVEL_100_ID = nil;
    LEVEL_100 = nil;
    if (GetSpellInfo(breathOfTheSerpent)) then
        LEVEL_100_ID = 157535;
        LEVEL_100 = breathOfTheSerpent;
    elseif (GetSpellInfo(chiExplosion)) then
        LEVEL_100_ID = 157675;
        LEVEL_100 = chiExplosion;
    elseif (GetSpellInfo(poolOfMists)) then
        LEVEL_100_ID = 101546;
        LEVEL_100 = poolOfMists;
    end

    ENVELOPING_MIST_ID = 124682;
    ENVELOPING_MIST = GetSpellInfo(ENVELOPING_MIST_ID);
    SOOTHING_MIST_ID = 115175;
    SOOTHING_MIST = GetSpellInfo(SOOTHING_MIST_ID);
    RENEWING_MIST_ID = 115151;
    RENEWING_MIST = GetSpellInfo(RENEWING_MIST_ID);

    UPLIFT_ID = 116670;
    UPLIFT = GetSpellInfo(UPLIFT_ID);

    REVIVAL_ID = 115310;
    REVIVAL = GetSpellInfo(REVIVAL_ID);

    CHI_DETONATION_ID = 115460;
    CHI_DETONATION = GetSpellInfo(CHI_DETONATION_ID);

    LIFE_COCOON_ID = 116849;
    LIFE_COCOON = GetSpellInfo(LIFE_COCOON_ID);

    EXPEL_HARM_ID = 115072;
    EXPEL_HARM = GetSpellInfo(EXPEL_HARM_ID);

    MANATEA_ID = 115294;
    MANATEA = GetSpellInfo(MANATEA_ID);
    THUNDERFOCUSTEA_ID = 116680;
    THUNDERFOCUSTEA = GetSpellInfo(THUNDERFOCUSTEA_ID);
    CHIBREW_ID = 115399;
    CHIBREW = GetSpellInfo(CHIBREW_ID);

    DETOX_ID = 115450;
    DETOX = GetSpellInfo(DETOX_ID);

    TIGERS_LUST_ID = 116841;
    if (GetSpellInfo(TIGERS_LUST_ID)) then
        TIGERS_LUST = GetSpellInfo(TIGERS_LUST_ID);
    end

    MANATEA_BUFF_ID = 115867;
    MANATEA_BUFF = GetSpellInfo(MANATEA_BUFF_ID);

    VITAL_MISTS_BUFF_ID = 118674;
    VITAL_MISTS_BUFF = GetSpellInfo(VITAL_MISTS_BUFF_ID);

    RESUSCITATE_ID = 50662;
    RESUSCITATE = GetSpellInfo(RESUSCITATE_ID);
end

function MistWeaver_OnButtonEvent(self, event, ...)
    if (event == "ACTIONBAR_UPDATE_COOLDOWN") then
        local spell = self:GetAttribute("spell");
        local spellid = self:GetAttribute("spellId");

        if (GetSpellInfo(spell)) then
            local start, duration, enable = GetSpellCooldown(spell);
            local currentCharges, maxCharges, cooldownStart, cooldownDuration = GetSpellCharges(spell);

            CooldownFrame_SetTimer(self.cooldown, start, duration, enable, currentCharges, maxCharges);
        end
    end
end

function MistWeaver_OnButtonUpdate(self, elapsed)
    if (not active) then
        return;
    end
    local spellId = self:GetAttribute("spellId");
    
    if (not spellId) then
        self:SetAlpha(0.0);
        return;
    end

    local isKnown = IsPlayerSpell(spellId);

    if (not isKnown) then
        self:SetAlpha(0.0);
        return;
    end

    self:SetAlpha(1.0);

    local spell = self:GetAttribute("spell");
    local usable, nomana = IsUsableSpell(spell);

    local _, _, texture = GetSpellInfo(spell);

    self.icon:SetTexture(texture);
    self.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
    self.icon:SetDrawLayer("BORDER");

    if (usable) then
        self.icon:SetVertexColor(1.0, 1.0, 1.0);
    elseif (nomana) then
        self.icon:SetVertexColor(0.5, 0.5, 1.0);
    else
        self.icon:SetVertexColor(0.4, 0.4, 0.4);
    end
end

function MistWeaver_OnButtonEnter(self)
    local spell = self:GetAttribute("spell");
    local spellId = self:GetAttribute("spellId");

    if (not spellId) then
        return;
    end

    GameTooltip_SetDefaultAnchor(GameTooltip, self);
    GameTooltip:SetSpellByID(spellId);

    if (self.tooltip) then
        GameTooltip:AddLine(" ", 1.0, 1.0, 1.0);
        GameTooltip:AddLine(self.tooltip, 1.0, 1.0, 1.0);
    end

    GameTooltip:Show();
end

function MistWeaver_OnButtonLeave(self)
    GameTooltip:FadeOut();
end

function MistWeaver_OnUnitFrameEnter(self)
    local unitFrame = self.unitFrame;

    unitFrame.art.hover:Show();

    if (IsAltKeyDown()) then
        MistWeaver_ShowUnitFrameTooltip(self);
    elseif (unitFrame.unit) then
        GameTooltip_SetDefaultAnchor(GameTooltip, self);

        GameTooltip:SetUnit(unitFrame.unit);
        GameTooltip:Show();
    end
end

function MistWeaver_ChiBrewOnUpdate(self, elapsed)
    if (not active) then
        return;
    end
    
    local hasCharges = false;

    local currentCharges, maxCharges = GetSpellCharges(CHIBREW);

    if (currentCharges and currentCharges > 0 and maxCharges and maxCharges > 1) then
        MwChiBrewFrame.button.count:SetText(currentCharges);
        hasCharges = true;
    else
        MwChiBrewFrame.button.count:SetText("");
    end
    
    if (hasCharges or MwChiBrewFrame.button.cooldown:IsShown()) then
        MwChiBrewFrame:SetAlpha(1.0);
    else
        MwChiBrewFrame:SetAlpha(0.3);
    end
end

function MistWeaver_ManaTeaOnUpdate(self, elapsed)
    if (not active) then
        return;
    end
    
    local hasCharges = false;

    local name, rank, icon, count = UnitBuff("player", MANATEA_BUFF);
    count = count or 0;

    if (count > 0) then
        MwManaTeaFrame.button.count:SetText(count);
        hasCharges = true;
    else
        MwManaTeaFrame.button.count:SetText("");
    end
    
    if (hasCharges or MwManaTeaFrame.button.cooldown:IsShown()) then
        MwManaTeaFrame:SetAlpha(1.0);
    else
        MwManaTeaFrame:SetAlpha(0.3);
    end
end

function MistWeaver_OnUnitFrameLeave(self)
    local unitFrame = self.unitFrame;

    unitFrame.art.hover:Hide();

    GameTooltip:FadeOut();
end

function MistWeaver_RegisterButton(button)
    tinsert(buttons, button);
end

function MistWeaver_RegisterForClicks()
    for i, button in ipairs(buttons) do
        if ( GetCVarBool("ActionButtonUseKeydown") ) then
            button:RegisterForClicks("AnyDown");
        else
            button:RegisterForClicks("AnyUp");
        end
    end
end

function MistWeaver_TalentGroupChanged()
    MistWeaver_UpdateActiveState();
    MistWeaver_LoadSpells();

    -- events
    MistWeaver_RebindButtonSpells();
    MistWeaver_RebindUnitFrames();
    MistWeaver_PartyMembersChanged();
    MistWeaver_PlayerRolesAssigned();
end

function MistWeaver_RebindButtonSpells()
    MistWeaver_RebindButtonSpell("MwRevivalCastFrame", REVIVAL, REVIVAL_ID);
    MistWeaver_RebindButtonSpell("MwDetonateChiCastFrame", CHI_DETONATION, CHI_DETONATION_ID);
    MistWeaver_RebindButtonSpell("MwEnvelopingMistCastFrame", ENVELOPING_MIST, ENVELOPING_MIST_ID);
    MistWeaver_RebindButtonSpell("MwSoothingMistCastFrame", SOOTHING_MIST, SOOTHING_MIST_ID);
    MistWeaver_RebindButtonSpell("MwSurgingMistCastFrame", SURGING_MIST, SURGING_MIST_ID);
    MistWeaver_RebindButtonSpell("MwLevel30CastFrame", LEVEL_30, LEVEL_30_ID);
    MistWeaver_RebindButtonSpell("MwLifeCocoonCastFrame", LIFE_COCOON, LIFE_COCOON_ID);
    MistWeaver_RebindButtonSpell("MwLevel60CastFrame", LEVEL_60, LEVEL_60_ID);
    MistWeaver_RebindButtonSpell("MwUpliftCastFrame", UPLIFT, UPLIFT_ID);
    MistWeaver_RebindButtonSpell("MwRenewingMistCastFrame", RENEWING_MIST, RENEWING_MIST_ID);
    MistWeaver_RebindButtonSpell("MwChiBrewFrame", CHIBREW, CHIBREW_ID);
    MistWeaver_RebindButtonSpell("MwManaTeaFrame", MANATEA, MANATEA_ID);
    MistWeaver_RebindButtonSpell("MwThunderFocusTeaFrame", THUNDERFOCUSTEA, THUNDERFOCUSTEA_ID);
    MistWeaver_RebindButtonSpell("MwExpelHarmCastFrame", EXPEL_HARM, EXPEL_HARM_ID);
    MistWeaver_RebindButtonSpell("MwLevel100CastFrame", LEVEL_100, LEVEL_100_ID);
end

function MistWeaver_RebindButtonSpell(name, spell, spellId)
    local frame = _G[name];

    frame.button:SetAttribute("type", "spell");
    frame.button:SetAttribute("spell", spell);
    frame.button:SetAttribute("spellId", spellId);

    local _, _, texture = GetSpellInfo(spell);

    frame.button.icon:SetTexture(texture);
    frame.button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
    frame.button.icon:SetDrawLayer("BORDER");

    if (not texture) then
        frame:SetAlpha(0.5);
    else
        frame:SetAlpha(1.0);
    end
end

function MistWeaver_CreateUnitFrames()
    local unitFrame;
    for i=1, MAX_UNITFRAMES, 1 do
        unitFrame = _G["MwUnitFrame"..i];
        if (not unitFrame) then
            unitFrame = MistWeaver_CreateFrame("Frame", "MwUnitFrame"..i, MistWeaverFrame, MwUnitFrameTemplate);
            MistWeaver_InitUnitFrame(unitFrame);
        end
    end

    MistWeaver_SetupUnitFramePositions();

    MistWeaver_InitTargetFrame();
    MistWeaver_InitFocusFrame();
end

function MistWeaver_InitUnitFrame(unitFrame)
    unitFrame:Hide();

    local framename = unitFrame:GetName();
    unitFrame:SetFrameStrata("BACKGROUND");
    unitFrame:EnableMouse(false);

    local offsetStats = MistWeaverData.RAID_EXTENSION_WIDTH;

    -- raid frame
    local raidFrame = MistWeaver_CreateFrame("Frame", framename.."Raid", unitFrame);
    raidFrame:ClearAllPoints();
    raidFrame:SetPoint("TOPLEFT", 0, 0);
    raidFrame:SetPoint("BOTTOMRIGHT", unitFrame, "BOTTOMLEFT", offsetStats + 4, 0);

    local raidBackdrop = MistWeaver_CreateFrame("Frame", framename.."RaidBackdrop", raidFrame);
    raidBackdrop:ClearAllPoints();
    raidBackdrop:SetPoint("TOPLEFT", raidFrame, "TOPLEFT", 0, 0);
    raidBackdrop:SetPoint("BOTTOMRIGHT", raidFrame, "BOTTOMRIGHT", 0, offsetStats);
    MistWeaver_SetBackdrop(raidBackdrop);

    local classIcon = raidBackdrop:CreateTexture(raidFrame:GetName().."ClassIcon", "ARTWORK");
    classIcon:SetSize(20, 20);
    classIcon:ClearAllPoints();
    classIcon:SetPoint("TOP", 0, -4);
    classIcon:SetTexture(nil);

    -- detox
    local detoxFrame = MistWeaver_CreateFrame("Frame", framename.."RaidDetoxFrame", raidFrame);
    detoxFrame:ClearAllPoints();
    detoxFrame:SetPoint("TOPLEFT", raidBackdrop, "BOTTOMLEFT", 0, 4);
    detoxFrame:SetPoint("BOTTOMRIGHT", raidFrame, "BOTTOMRIGHT", 0, 0);
    detoxFrame:SetAlpha(0);

    local detoxBackdrop = MistWeaver_CreateFrame("Frame", framename.."RaidDetoxBackdrop", raidFrame);
    detoxBackdrop:ClearAllPoints();
    detoxBackdrop:SetAllPoints(detoxFrame);
    MistWeaver_SetBackdrop(detoxBackdrop);

    local detoxBorder = detoxFrame:CreateTexture(framename.."RaidDetoxBorder", "OVERLAY");
    detoxBorder:SetTexture("Interface\\Addons\\MistWeaver\\images\\highlight");
    detoxBorder:SetSize(10, 10);
    detoxBorder:ClearAllPoints();
    detoxBorder:SetPoint("TOPLEFT", detoxFrame, "TOPLEFT", 0, 0);
    detoxBorder:SetPoint("BOTTOMRIGHT", detoxFrame, "BOTTOMRIGHT", 0, 0);
    detoxBorder:SetDrawLayer("OVERLAY");

    local detoxItem = detoxFrame:CreateTexture(framename.."RaidDetoxItem", "OVERLAY");
    detoxItem:SetTexture("Interface\\Addons\\MistWeaver\\images\\detox");
    detoxItem:SetSize(10, 10);
    detoxItem:ClearAllPoints();
    detoxItem:SetPoint("TOPLEFT", detoxFrame, "TOPLEFT", 4, -4);
    detoxItem:SetPoint("BOTTOMRIGHT", detoxFrame, "BOTTOMRIGHT", -4, 4);
    detoxItem:SetDrawLayer("OVERLAY");

    local detoxCooldown = MistWeaver_CreateFrame("Cooldown", framename.."DetoxCooldown", detoxFrame, "CooldownFrameTemplate");
    detoxCooldown:SetSize(10, 10);
    detoxCooldown:ClearAllPoints();
    detoxCooldown:SetAllPoints(detoxItem);
    detoxCooldown:SetFrameStrata("HIGH");
    
    detoxCooldown:SetEdgeTexture("Interface\\Cooldown\\edge");
    detoxCooldown:SetSwipeColor(0, 0, 0);
    detoxCooldown:SetHideCountdownNumbers(false);
    detoxCooldown.currentCooldownType = COOLDOWN_TYPE_NORMAL;

    local detoxExpirationTime = MistWeaver_CreateFontString(detoxFrame, framename.."DetoxExpirationTime", "OVERLAY");
    detoxExpirationTime:SetFontObject(GameFontWhiteSmall);
    detoxExpirationTime:ClearAllPoints();
    detoxExpirationTime:SetPoint("BOTTOM", detoxFrame, "BOTTOM", 0, 3);

    -- action buttons
    local raidbutton1 = MistWeaver_CreateFrame("Button", framename.."RaidButton1", raidBackdrop, "SecureActionButtonTemplate");
    raidbutton1:SetFrameStrata(BUTTON_FRAMESTRATA);
    raidbutton1:ClearAllPoints();
    raidbutton1:SetPoint("TOPLEFT", 4, -4);
    raidbutton1:SetPoint("BOTTOMRIGHT", -4, 4);
    MistWeaver_RegisterButton(raidbutton1);
    raidbutton1.unitFrame = unitFrame;

    local raidbutton2 = MistWeaver_CreateFrame("Button", framename.."RaidButton2", detoxBackdrop, "SecureActionButtonTemplate");
    raidbutton2:SetFrameStrata(BUTTON_FRAMESTRATA);
    raidbutton2:ClearAllPoints();
    raidbutton2:SetPoint("TOPLEFT", 4, -4);
    raidbutton2:SetPoint("BOTTOMRIGHT", -4, 4);
    MistWeaver_RegisterButton(raidbutton2);
    raidbutton2.unitFrame = unitFrame;

    -- unit drowdown
    local dropdown1 = MistWeaver_CreateFrame("Frame", framename.."RaidButton1Dropdown", raidbutton1, "UIDropDownMenuTemplate");
    dropdown1:SetSize(10, 10);
    dropdown1:ClearAllPoints();
    dropdown1:SetPoint("TOPLEFT", 10, 10);
    dropdown1:Hide();
    dropdown1.unitFrame = unitFrame;
    tinsert(UnitPopupFrames, dropdown1:GetName());

    -- stats frame
    local statsFrame = MistWeaver_CreateFrame("Frame", framename.."Stats", unitFrame);
    statsFrame:ClearAllPoints();
    statsFrame:SetPoint("TOPLEFT", offsetStats, 0);
    statsFrame:SetPoint("BOTTOMRIGHT", 0, 0);

    local statsBackdrop = MistWeaver_CreateFrame("Frame", framename.."StatsBackdrop", statsFrame);
    statsBackdrop:ClearAllPoints();
    statsBackdrop:SetAllPoints(statsFrame);
    MistWeaver_SetBackdrop(statsBackdrop);

    -- bars
    local renewingMistBar = MistWeaver_CreateFrame("StatusBar", framename.."RenewingMist", statsFrame, "MwTextStatusBarTemplate");
    renewingMistBar:ClearAllPoints();
    renewingMistBar:SetPoint("TOPLEFT", statsFrame, "BOTTOMLEFT", 4, 20);
    renewingMistBar:SetPoint("BOTTOMRIGHT", statsFrame, "BOTTOMRIGHT", -4, 4);
    renewingMistBar:SetStatusBarColor(MistWeaverData.RENEWING_MIST_COLOR.r, MistWeaverData.RENEWING_MIST_COLOR.g, MistWeaverData.RENEWING_MIST_COLOR.b);
    renewingMistBar:SetFrameStrata("LOW");

    local healthBar = MistWeaver_CreateFrame("StatusBar", framename.."Health", statsFrame, "MwTextStatusBarTemplate");
    healthBar:ClearAllPoints();
    healthBar:SetPoint("TOPLEFT", statsFrame, "TOPLEFT", 4, -4);
    healthBar:SetPoint("BOTTOMRIGHT", renewingMistBar, "TOPRIGHT", 0, 6);
    healthBar:SetStatusBarColor(0.0, 1.0, 0.0);
    healthBar:SetFrameStrata("LOW");

    local healthPredictionBar = MistWeaver_CreateFrame("StatusBar", framename.."HealthPrediction", statsFrame, "MwTextStatusBarTemplate");
    healthPredictionBar:ClearAllPoints();
    healthPredictionBar:SetAllPoints(healthBar);
    healthPredictionBar:SetAlpha(0.3);
    healthPredictionBar:SetStatusBarColor(0.3, 1.0, 0.7);
    healthPredictionBar:SetFrameStrata("BACKGROUND");
    healthPredictionBar:SetMinMaxValues(0, 100);
    healthPredictionBar:SetValue(0);

    local overAbsorbGlow = healthBar:CreateTexture(healthBar:GetName().."OverAbsorbGlow", "OVERLAY", "OverAbsorbGlowTemplate");
    overAbsorbGlow:SetPoint("TOPLEFT", healthBar, "TOPRIGHT", -2, 0);
    overAbsorbGlow:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", 3, 0);
    overAbsorbGlow:SetDrawLayer("OVERLAY");
    overAbsorbGlow:Hide();

    local absorbBar = healthBar:CreateTexture(healthBar:GetName().."AbsorbBar", "BACKGROUND", "TotalAbsorbBarTemplate");
    absorbBar:SetPoint("TOPLEFT", healthBar, "TOPLEFT", 0, 0);
    absorbBar:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMLEFT", 0, 0);
    absorbBar:SetDrawLayer("BACKGROUND");

    local aggroBar = MistWeaver_CreateFrame("StatusBar", framename.."Aggro", statsFrame, "MwTextStatusBarTemplate");
    aggroBar:ClearAllPoints();
    aggroBar:SetPoint("TOPLEFT", healthBar, "TOPLEFT", 0, 0);
    aggroBar:SetPoint("BOTTOMRIGHT", healthBar, "TOPRIGHT", 0, -3);
    aggroBar:SetStatusBarColor(1.0, 0.0, 0.0);
    aggroBar:SetFrameStrata("HIGH");

    local soothingMistBar = MistWeaver_CreateFrame("StatusBar", framename.."SoothingMist", statsFrame, "MwTextStatusBarTemplate");
    soothingMistBar:ClearAllPoints();
    soothingMistBar:SetPoint("TOPLEFT", renewingMistBar, "TOPLEFT", 0, 6);
    soothingMistBar:SetPoint("BOTTOMRIGHT", renewingMistBar, "TOPRIGHT", 0, 2);
    soothingMistBar:SetStatusBarColor(MistWeaverData.SOOTHING_MIST_COLOR.r, MistWeaverData.SOOTHING_MIST_COLOR.g, MistWeaverData.SOOTHING_MIST_COLOR.b);
    soothingMistBar:SetFrameStrata("BACKGROUND");

    local envelopingMistBar = MistWeaver_CreateFrame("StatusBar", framename.."EnvelopingMist", statsFrame, "MwTextStatusBarTemplate");
    envelopingMistBar:ClearAllPoints();
    envelopingMistBar:SetPoint("TOPLEFT", renewingMistBar, "TOPLEFT", 0, 2);
    envelopingMistBar:SetPoint("BOTTOMRIGHT", renewingMistBar, "TOPRIGHT", 0, 0);
    envelopingMistBar:SetStatusBarColor(MistWeaverData.ENVELOPING_MIST_COLOR.r, MistWeaverData.ENVELOPING_MIST_COLOR.g, MistWeaverData.ENVELOPING_MIST_COLOR.b);
    envelopingMistBar:SetFrameStrata("BACKGROUND");

    -- images
    local art = MistWeaver_CreateFrame("Frame", framename.."Art", statsFrame, "MwUnitArtFrameTemplate");
    art:ClearAllPoints();
    art:SetPoint("TOPLEFT", statsFrame, "TOPLEFT", 2, -2);
    art:SetPoint("BOTTOMRIGHT", statsFrame, "BOTTOMRIGHT", -2, 2);
    art.aggro:SetTexCoord(unpack(texCoords["Raid-AggroFrame"]));
    art.info:SetTextColor(1.0, 0.0, 0.0);
    art.highlight:SetVertexColor(MistWeaverData.HIGHLIGHT_COLOR.r, MistWeaverData.HIGHLIGHT_COLOR.g, MistWeaverData.HIGHLIGHT_COLOR.b);
    unitFrame.art = art;

    -- action buttons
    local button1 = MistWeaver_CreateFrame("Button", framename.."Button1", statsFrame, "SecureActionButtonTemplate");
    button1:SetFrameStrata(BUTTON_FRAMESTRATA);
    button1:ClearAllPoints();
    button1:SetPoint("TOPLEFT", healthBar, "TOPLEFT", 0, 0);
    button1:SetPoint("BOTTOMRIGHT", soothingMistBar, "BOTTOMRIGHT", 0, 0);
    MistWeaver_RegisterButton(button1);
    button1:HookScript("OnEnter", MistWeaver_OnUnitFrameEnter);
    button1:HookScript("OnLeave", MistWeaver_OnUnitFrameLeave);
    button1.unitFrame = unitFrame;

    local button2 = MistWeaver_CreateFrame("Button", framename.."Button2", statsFrame, "SecureActionButtonTemplate");
    button2:SetFrameStrata(BUTTON_FRAMESTRATA);
    button2:ClearAllPoints();
    button2:SetPoint("TOPLEFT", renewingMistBar, "TOPLEFT", 0, 0);
    button2:SetPoint("BOTTOMRIGHT", renewingMistBar, "BOTTOMRIGHT", 0, 0);
    MistWeaver_RegisterButton(button2);
    button2:HookScript("OnEnter", MistWeaver_OnUnitFrameEnter);
    button2:HookScript("OnLeave", MistWeaver_OnUnitFrameLeave);
    button2.unitFrame = unitFrame;
end

function MistWeaver_ResizeRaidExtension()
    if (InCombatLockdown()) then
        return;
    end

    for i=1, MAX_UNITFRAMES, 1 do
        MistWeaver_ResizeRaidExtensionForFrame(_G["MwUnitFrame"..i]);
    end

    MistWeaver_ResizeRaidExtensionForFrame(_G["MwTargetUnitFrame"]);
    MistWeaver_ResizeRaidExtensionForFrame(_G["MwFocusUnitFrame"]);
end

function MistWeaver_ResizeRaidExtensionForFrame(unitFrame)
    local offsetStats = MistWeaverData.RAID_EXTENSION_WIDTH;

    local framename, raidFrame, statsFrame;

    if (unitFrame) then
        framename = unitFrame:GetName();

        raidFrame = _G[framename.."Raid"];
        raidFrame:Show();
        raidFrame:SetPoint("BOTTOMRIGHT", unitFrame, "BOTTOMLEFT", offsetStats + 4, 0);

        statsFrame = _G[framename.."Stats"];
        statsFrame:SetPoint("TOPLEFT", offsetStats, 0);
    end
end

function MistWeaver_InfoButtonOnEnter(frame)
    MwInfoButton:SetAlpha(1.0);
end

function MistWeaver_InfoButtonOnLeave(frame)
    MwInfoButton:SetAlpha(0.1);
end

function MistWeaver_OpenInfoMenu(self, button, down)
    MistWeaver_InitInfoMenu(self.menu);
    self.menu:ClearAllPoints();
    self.menu:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -6, -11);
    self.menu:Show();
end

function MistWeaver_InitInfoMenu(self)
    UIMenu_Initialize(self);

    local countProfiles = 0;

    for name, data in pairs(MistWeaverProfiles) do
        UIMenu_AddButton(self, name, nil, function(frame) MwConfig_LoadProfileWidthName(name); end);
        countProfiles = countProfiles + 1;
    end

    if (countProfiles > 0) then
        UIMenu_AddButton(self, "");
    end

    local textDebuffs = GREEN_FONT_COLOR_CODE..MW_SHOW_DEBUFFS..FONT_COLOR_CODE_CLOSE;
    if ( not MistWeaverData.SHOW_DEBUFFS ) then
        textDebuffs = RED_FONT_COLOR_CODE..MW_SHOW_DEBUFFS..FONT_COLOR_CODE_CLOSE;
    end

    UIMenu_AddButton(self, textDebuffs, nil, MwConfig_ToggleShowDebuffs);

    UIMenu_AddButton(self, MW_CONFIG, nil, MistWeaver_OpenConfig);
    UIMenu_AddButton(self, "");
    UIMenu_AddButton(self, CANCEL, nil, function(frame) self:Hide(); end);
    UIMenu_AutoSize(self);
end

function MistWeaver_OpenConfig()
    PlaySound("igMainMenuOption");
    ShowUIPanel(InterfaceOptionsFrame);
    InterfaceOptionsFrame_OpenToCategory(MwConfig);
    InterfaceOptionsFrame.lastFrame = GameMenuFrame;
end

function MistWeaver_SetupUnitFramePositions()
    if (InCombatLockdown()) then
        return;
    end

    if (MistWeaverData.ORIENTATION == 1) then
        MistWeaver_SetupUnitFramesVertical();
    elseif (MistWeaverData.ORIENTATION == 2) then
        MistWeaver_SetupUnitFramesHorizontal();
    end
end

function MistWeaver_SetupUnitFramesVertical()
    local unitFrame, relativeTo, realtivePoint, x, y, pos, firstInGroup;

    relativeTo = MistWeaverFrame;
    realtivePoint = "TOPLEFT";
    x = 0;
    y = 0;

    for i=1, MAX_UNITFRAMES, 1 do
        pos = mod(i, MistWeaverData.UNITFRAME_GROUPSIZE);
        unitFrame = _G["MwUnitFrame"..i];

        if (relativeTo == MistWeaverFrame) then
            realtivePoint = "TOPLEFT";
            x = 0;
            y = 0;
        elseif (pos == 1) then
            relativeTo = firstInGroup;
            realtivePoint = "TOPRIGHT";
            x = -1;
            y = 0;
        else
            realtivePoint = "BOTTOMLEFT";
            x = 0;
            y = 2;
        end

        if (pos == 1) then
            firstInGroup = unitFrame;
        end

        unitFrame:ClearAllPoints();
        unitFrame:SetPoint("TOPLEFT", relativeTo, realtivePoint, x, y);

        relativeTo = unitFrame;
    end
end

function MistWeaver_SetupUnitFramesHorizontal()
    local unitFrame, relativeTo, realtivePoint, x, y, pos, firstInGroup;

    relativeTo = MistWeaverFrame;
    realtivePoint = "TOPLEFT";
    x = 0;
    y = 0;

    for i=1, MAX_UNITFRAMES, 1 do
        pos = mod(i, MistWeaverData.UNITFRAME_GROUPSIZE);
        unitFrame = _G["MwUnitFrame"..i];

        if (relativeTo == MistWeaverFrame) then
            realtivePoint = "TOPLEFT";
            x = 0;
            y = 0;
        elseif (pos == 1) then
            relativeTo = firstInGroup;
            realtivePoint = "BOTTOMLEFT";
            x = 0;
            y = 2;
        else
            realtivePoint = "TOPRIGHT";
            x = -1;
            y = 0;
        end

        if (pos == 1) then
            firstInGroup = unitFrame;
        end

        unitFrame:ClearAllPoints();
        unitFrame:SetPoint("TOPLEFT", relativeTo, realtivePoint, x, y);

        relativeTo = unitFrame;
    end
end

function MistWeaver_UpdateTextures()
    for index, name in ipairs(actionButtonFrames) do
        MistWeaver_UpdateTexture(_G[name]);
    end
end

function MistWeaver_CreateFrame(type, name, parent, template)
    local frame = _G[name];
    if (frame) then
        return frame;
    end

    frame = CreateFrame(type, name, parent, template);
    return frame;
end

function MistWeaver_CreateFontString(frame, name, layer)
    local fontString = _G[name];
    if (fontString) then
        return fontString;
    end

    fontString = frame:CreateFontString(name, layer);
    return fontString;
end

function MistWeaver_UpdateTexture(frame)
    local spell = frame.button:GetAttribute("spell");
    local _, _, texture = GetSpellInfo(spell);
    frame.button.icon:SetTexture(texture);
end

function MistWeaver_UpdateUnitFrameSize()

    if (InCombatLockdown()) then
        return;
    end

    MistWeaver_RebindUnitFrames();

    local unitFrame, statsFrame, healthBarText, renewingMistBar;
    for i=1, MAX_UNITFRAMES, 1 do
        unitFrame = _G["MwUnitFrame"..i];
        unitFrame:SetSize(MistWeaverData.UNITWIDTH, MistWeaverData.UNITHEIGHT);

        statsFrame = _G["MwUnitFrame"..i.."Stats"];

        renewingMistBar = _G["MwUnitFrame"..i.."RenewingMist"];
        renewingMistBar:SetPoint("TOPLEFT", statsFrame, "BOTTOMLEFT", 4, 4 + MistWeaverData.RENEWINGMISTBAR_HEIGHT);
    end

    MwTargetUnitFrame:SetSize(MistWeaverData.UNITWIDTH, MistWeaverData.UNITHEIGHT);
    MwFocusUnitFrame:SetSize(MistWeaverData.UNITWIDTH, MistWeaverData.UNITHEIGHT);

    MwTargetUnitFrameRenewingMist:SetPoint("TOPLEFT", MwTargetUnitFrameStats, "BOTTOMLEFT", 4, 4 + MistWeaverData.RENEWINGMISTBAR_HEIGHT);
    MwFocusUnitFrameRenewingMist:SetPoint("TOPLEFT", MwFocusUnitFrameStats, "BOTTOMLEFT", 4, 4 + MistWeaverData.RENEWINGMISTBAR_HEIGHT);
end

function MistWeaver_PartyMembersChanged()
    MistWeaver_RebindUnitFrames();
    MistWeaver_UpdateTextures();
end

function MistWeaver_RebindUnitFrames()
    if (InCombatLockdown()) then
        return;
    end

    if (not active) then
        return;
    end

    MistWeaver_UpdateActiveState();

    local unitFrame, subgroup, role;
    if (IsInRaid()) then
        if (MistWeaverData.SORTTYPE == 4) then
            MistWeaver_RebindUnitFramesForRaidByRole();
        elseif (MistWeaverData.SORTTYPE == 3) then
            MistWeaver_RebindUnitFramesForRaidByName();
        elseif (MistWeaverData.SORTTYPE == 2) then
            MistWeaver_RebindUnitFramesForRaidByGroup();
        else
            MistWeaver_RebindUnitFramesForRaidById();
        end
    elseif (IsInGroup()) then
        MistWeaver_RebindUnitFramesForGroup();
    else
        MistWeaver_RebindUnitFramesForSolo();
    end

    MistWeaver_InitTargetSpells();
    MistWeaver_InitFocusSpells();
end

function MistWeaver_ResetRebindUnitFrames()
    local unitFrame;
    for i=1, MAX_UNITFRAMES, 1 do
        unitFrame = _G["MwUnitFrame"..i];
        MistWeaver_SetUnit(unitFrame, nil, nil);
    end
end

function MistWeaver_RebindUnitFramesForSolo()
    MistWeaver_ResetRebindUnitFrames();
    MistWeaver_SetUnit(_G["MwUnitFrame1"], "player", nil);
end

function MistWeaver_RebindUnitFramesForGroup()

    MistWeaver_ResetRebindUnitFrames();

    local name, unitFrame, role;
    local index = 1;

    if (MistWeaverData.SORTTYPE == 4) then -- sort by role
        -- find tanks
        for _, id in pairs(PARTY_UNITS) do
            role = UnitGroupRolesAssigned(id);
            if (UnitExists(id) and role == "TANK") then
                unitFrame = _G["MwUnitFrame"..index];
                MistWeaver_SetUnit(unitFrame, id, role);
                index = index + 1;
            end
    end

    -- find healers
    for _, id in pairs(PARTY_UNITS) do
        role = UnitGroupRolesAssigned(id);
        if (UnitExists(id) and role == "HEALER") then
            unitFrame = _G["MwUnitFrame"..index];
            MistWeaver_SetUnit(unitFrame, id, role);
            index = index + 1;
        end
    end

    -- find damage dealers
    for _, id in pairs(PARTY_UNITS) do
        role = UnitGroupRolesAssigned(id);
        if (UnitExists(id) and role == "DAMAGER") then
            unitFrame = _G["MwUnitFrame"..index];
            MistWeaver_SetUnit(unitFrame, id, role);
            index = index + 1;
        end
    end

    -- without role
    for _, id in pairs(PARTY_UNITS) do
        role = UnitGroupRolesAssigned(id);
        if (UnitExists(id) and role == "NONE") then
            unitFrame = _G["MwUnitFrame"..index];
            MistWeaver_SetUnit(unitFrame, id, role);
            index = index + 1;
        end
    end
    elseif (MistWeaverData.SORTTYPE == 3) then -- sort by name

        local membersByName = {};

        for _, id in pairs(PARTY_UNITS) do
            name = UnitName(id);
            if (name) then
                membersByName[name] = {id = id, role = role};
            end
        end

        index = 1;
        for name,data in mw_pairsByKeys(membersByName) do
            unitFrame = _G["MwUnitFrame"..index];
            MistWeaver_SetUnit(unitFrame, data.id, data.role);
            index = index + 1;
        end
    else
        role = UnitGroupRolesAssigned("player");
        MistWeaver_SetUnit(_G["MwUnitFrame1"], "player", role);

        for i = 1, 4 do
            unitFrame = _G["MwUnitFrame"..(i+1)];
            role = UnitGroupRolesAssigned("party"..i);
            MistWeaver_SetUnit(unitFrame, "party"..i, role);
        end
    end
end

function MistWeaver_RebindUnitFramesForRaidByRole()
    MistWeaver_ResetRebindUnitFrames();

    local unitFrame, role;
    local index = 1;

    -- find tanks
    for i=1, MAX_UNITFRAMES, 1 do
        role = UnitGroupRolesAssigned("raid"..i);
        if (UnitExists("raid"..i) and role == "TANK") then
            unitFrame = _G["MwUnitFrame"..index];
            MistWeaver_SetUnit(unitFrame, "raid"..i, role);
            index = index + 1;
        end
    end

    -- find healers
    for i=1, MAX_UNITFRAMES, 1 do
        role = UnitGroupRolesAssigned("raid"..i);
        if (UnitExists("raid"..i) and role == "HEALER") then
            unitFrame = _G["MwUnitFrame"..index];
            MistWeaver_SetUnit(unitFrame, "raid"..i, role);
            index = index + 1;
        end
    end

    -- find damage dealers
    for i=1, MAX_UNITFRAMES, 1 do
        role = UnitGroupRolesAssigned("raid"..i);
        if (UnitExists("raid"..i) and role == "DAMAGER") then
            unitFrame = _G["MwUnitFrame"..index];
            MistWeaver_SetUnit(unitFrame, "raid"..i, role);
            index = index + 1;
        end
    end

    -- without role
    for i=1, MAX_UNITFRAMES, 1 do
        role = UnitGroupRolesAssigned("raid"..i);
        if (UnitExists("raid"..i) and role == "NONE") then
            unitFrame = _G["MwUnitFrame"..index];
            MistWeaver_SetUnit(unitFrame, "raid"..i, role);
            index = index + 1;
        end
    end
end

function MistWeaver_RebindUnitFramesForRaidByName()
    MistWeaver_ResetRebindUnitFrames();

    local name, unitFrame, role, index, position;

    -- create temp table
    local membersByName = {};
    for i=1, MAX_UNITFRAMES, 1 do
        _, _, _, _, _, _, _, _, _, role, _ = GetRaidRosterInfo(i);
        name = UnitName("raid"..i);
        if (name) then
            membersByName[name] = {index = i, role = role};
        end
    end

    index = 1;
    for name,data in mw_pairsByKeys(membersByName) do
        unitFrame = _G["MwUnitFrame"..index];
        MistWeaver_SetUnit(unitFrame, "raid"..data.index, data.role);
        index = index + 1;
    end
end

function MistWeaver_RebindUnitFramesForRaidByGroup()
    MistWeaver_ResetRebindUnitFrames();

    local unitFrame, subgroup, role, index, position;

    for i=1, MAX_UNITFRAMES, 1 do
        _, _, subgroup, _, _, _, _, _, _, role, _ = GetRaidRosterInfo(i);

        index = (subgroup - 1) * 5;
        for g=1, 5, 1 do
            position = index + g;
            unitFrame = _G["MwUnitFrame"..position];
            if (not unitFrame.unit) then
                MistWeaver_SetUnit(unitFrame, "raid"..i, role);
                break;
            end
        end
    end
end

function MistWeaver_RebindUnitFramesForRaidById()

    local unitFrame, role;

    for i=1, MAX_UNITFRAMES, 1 do
        _, _, _, _, _, _, _, _, _, role, _ = GetRaidRosterInfo(i);

        unitFrame = _G["MwUnitFrame"..i];
        MistWeaver_SetUnit(unitFrame, "raid"..i, role);
    end
end

function MistWeaver_SetUnit(frame, unit, role)
    if ((not UnitExists(unit)) or unit == nil) then
        frame:Hide();
        frame.unit = nil;
        frame.role = nil;

        return;
    end

    frame:Show();
    frame.unit = unit;
    frame.role = role;

    MistWeaver_RebindSpells(frame);
    MistWeaver_UpdateRole(frame);
    MistWeaver_RebindRaidData(frame, unit);
end

function MistWeaver_RebindSpells(frame)
    local unit = frame.unit;

    local button1 = _G[frame:GetName().."Button1"];
    local button2 = _G[frame:GetName().."Button2"];

    -- set unit
    button1:SetAttribute("unit", unit);
    button2:SetAttribute("unit", unit);

    -- no self cast and no focus cast
    button1:SetAttribute("checkselfcast", false);
    button1:SetAttribute("checkfocuscast", false);
    button2:SetAttribute("checkselfcast", false);
    button2:SetAttribute("checkfocuscast", false);

    -- set spells for button 1
    button1:SetAttribute("type1", "spell");
    button1:SetAttribute("spell1", ENVELOPING_MIST);

    button1:SetAttribute("type2", "spell");
    button1:SetAttribute("spell2", SOOTHING_MIST);

    button1:SetAttribute("type3", "spell");
    button1:SetAttribute("spell3", LIFE_COCOON);

    button1:SetAttribute("shift-type1", "spell");
    button1:SetAttribute("shift-spell1", SURGING_MIST);

    button1:SetAttribute("shift-type2", "spell");
    button1:SetAttribute("shift-spell2", LEVEL_30);

    button1:SetAttribute("shift-type3", "spell");
    button1:SetAttribute("shift-spell3", LEVEL_60);

    button1:SetAttribute("alt-type1", "spell");
    button1:SetAttribute("alt-spell1", EXPEL_HARM);

    button1:SetAttribute("alt-type2", "spell");
    button1:SetAttribute("alt-spell2", LEVEL_100);

    button1:SetAttribute("ctrl-shift-type1", "spell");
    button1:SetAttribute("ctrl-shift-spell1", RESUSCITATE);

    button1:SetAttribute("ctrl-shift-type2", "target");

    -- set spells for button 2
    button2:SetAttribute("type1", "spell");
    button2:SetAttribute("spell1", UPLIFT);
    button2:SetAttribute("shift-type1", "spell");
    button2:SetAttribute("shift-spell1", UPLIFT);

    button2:SetAttribute("type2", "spell");
    button2:SetAttribute("spell2", RENEWING_MIST);
    button2:SetAttribute("shift-type2", "spell");
    button2:SetAttribute("shift-spell2", RENEWING_MIST);

    button2:SetAttribute("type3", "spell");
    button2:SetAttribute("spell3", LIFE_COCOON);

    button2:SetAttribute("shift-type3", "spell");
    button2:SetAttribute("shift-spell3", LEVEL_60);

    -- out of range warning und unit markieren
    button1:SetAttribute("ctrl-type1", "macro");
    button1:SetAttribute("ctrl-macrotext1", "/run MistWeaver_WhisperOutOfRange(\""..frame:GetName().."\")");

    button1:SetAttribute("ctrl-type2", "macro");
    button1:SetAttribute("ctrl-macrotext2", "/run MistWeaver_HighlightFrame(\""..frame:GetName().."\")");

    button2:SetAttribute("ctrl-type1", "macro");
    button2:SetAttribute("ctrl-macrotext1", "/run MistWeaver_WhisperOutOfRange(\""..frame:GetName().."\")");

    button2:SetAttribute("ctrl-type2", "macro");
    button2:SetAttribute("ctrl-macrotext2", "/run MistWeaver_HighlightFrame(\""..frame:GetName().."\")");
end

function MistWeaver_WhisperOutOfRange(framename)
    local frame = _G[framename];
    local unit = frame.unit;

    if (unit) then
        local name, realm = UnitName(unit);

        if (realm and realm ~= "") then
            name = name.."-"..realm:gsub("%s","");
        end

        SendChatMessage(MistWeaverData.OUT_OF_RANGE, "WHISPER", nil, name);
    end
end

function MistWeaver_HighlightFrame(framename)
    local frame = _G[framename];

    if (frame.highlight) then
        frame.highlight = nil;
    else
        frame.highlight = 1;
    end
end

function MistWeaver_PlayerRolesAssigned()
    for i=1, MAX_UNITFRAMES, 1 do
        unitFrame = _G["MwUnitFrame"..i];
        MistWeaver_UpdateRole(unitFrame);
    end
end

function MistWeaver_UpdateRole(frame)
    if (not frame.unit) then
        return;
    end

    local role = UnitGroupRolesAssigned(frame.unit);
    local roleIcon = frame.art.roleIcon;

    local size = 12;

    if (roleIcon) then
        if (frame.role == "MAINTANK") then
            roleIcon:SetTexture("Interface\\GroupFrame\\UI-Group-MainTankIcon");
            roleIcon:Show();
        elseif (frame.role == "MAINASSIST") then
            roleIcon:SetTexture("Interface\\GroupFrame\\UI-Group-MainAssistIcon");
            roleIcon:Show();
        elseif (role == "TANK" or role == "HEALER" or role == "DAMAGER") then
            roleIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES");
            roleIcon:SetTexCoord(GetTexCoordsForRoleSmallCircle(role));
            roleIcon:Show();
        else
            roleIcon:Hide();
            size = 1;
        end

        roleIcon:SetSize(size, size);
    end
end

local UPDATE_WAIT = 0.05;
local wait = 0;
function MistWeaver_OnUpdate(self, elapsed)
    wait = wait + elapsed;

    if (wait > UPDATE_WAIT) then
        wait = 0;
        MistWeaver_DoUpdate(self);
    end
end

function MistWeaver_DoUpdate(self)
    if (not init) then
        return;
    end

    if (not active) then
        return;
    end

    local unit, unitFrame, dropdown;
    for i=1, MAX_UNITFRAMES, 1 do
        unitFrame = _G["MwUnitFrame"..i];
        unit = unitFrame.unit;

        if (unit and UnitExists(unit)) then
            MistWeaver_UpdateUnit(unitFrame, unit);
        else
            unitFrame.art.dc:Hide();
        end
    end

    MistWeaver_CheckInCombat();

    MistWeaver_DoTargetUpdate();
    MistWeaver_DoFocusUpdate();

    MistWeaver_UpdateRaidIcons();
    MistWeaver_UpdatePower();
    MistWeaver_UpdatePlayerBuffs();
    MistWeaver_UpdateThunderFocusTea();
end

function MistWeaver_CheckInCombat()
    local unitFrame;
    local unitInCombat = nil;

    for i=1, MAX_UNITFRAMES, 1 do
        unitFrame = _G["MwUnitFrame"..i];
        if (unitFrame and unitFrame.unit and UnitAffectingCombat(unitFrame.unit)) then
            unitInCombat = 1;
        end
    end

    if (unitInCombat) then
        MistWeaver_EnterCombat();
        return;
    end

    if (inCombat) then
        MistWeaver_LeaveCombat();
    end
end

function MistWeaver_UpdateRaidIcons()
    local unitFrame;
    for i=1, MAX_UNITFRAMES, 1 do
        unitFrame = _G["MwUnitFrame"..i];
        if (unitFrame) then
            MistWeaver_UpdateRaidIcon(unitFrame);
        end
    end
end

function MistWeaver_UpdateRaidIcon(frame)
    local raidIcon = frame.art.raidIcon;

    if (not frame.unit or not MistWeaverData.SHOW_RAID_ICON ) then
        raidIcon:Hide();
        return;
    end

    local index = GetRaidTargetIndex(frame.unit);

    if (raidIcon) then
        if (index and index > 0) then
            if (index > 8) then
                index = 0;
            end

            raidIcon:SetTexCoord(raidicons[index].left, raidicons[index].right, raidicons[index].top, raidicons[index].bottom);
            raidIcon:Show();
        else
            raidIcon:Hide();
        end
    end
end

function MistWeaver_UpdatePower()
    local chiBar = _G["MwPowerFrameChi"];
    local manaBar = _G["MwPowerFrameMana"];

    local chi = UnitPower("player", SPELL_POWER_CHI);
    local chiMax = UnitPowerMax("player", SPELL_POWER_CHI);

    chiBar:SetMinMaxValues(0, chiMax);
    chiBar:SetValue(chi);
    chiBar.text:SetText(chi.."/"..chiMax);

    -- mana
    local mana = UnitPower("player", SPELL_POWER_MANA);
    local manaMax = UnitPowerMax("player", SPELL_POWER_MANA);

    manaBar:SetMinMaxValues(0, manaMax);
    manaBar:SetValue(mana);
    manaBar.text:SetText(format("%.0f", (100 * mana / manaMax)).." %");
end

function MistWeaver_UpdatePlayerBuffs()
    local index = 1;

    -- vital mists buff
    local name, rank, icon, count = UnitBuff("player", VITAL_MISTS_BUFF);
    if (count and count > 0) then
        if (count == 5) then
            MwSurgingMistCastFrame.button.count:SetText(SPELL_CAST_TIME_INSTANT_NO_MANA);
        else
            local percent = count * 20;
            MwSurgingMistCastFrame.button.count:SetText(format("%d", percent).." %");
        end
    else
        MwSurgingMistCastFrame.button.count:SetText("");
    end
end

function MistWeaver_UpdateThunderFocusTea()
    local name, rank, icon, count, debuffType, duration, expirationTime, caster = UnitBuff("player", THUNDERFOCUSTEA);

    if (expirationTime) then
        local countdown = expirationTime - GetTime();
        MwThunderFocusTeaFrameLabel:SetFormattedText(SecondsToTimeAbbrev(countdown));
    else
        MwThunderFocusTeaFrameLabel:SetText("");
    end

    if (name) then
        MistWeaver_ShowThunderFocusTeaOverlayGlow();
    else
        MistWeaver_HideThunderFocusTeaOverlayGlow();
    end
end

function MistWeaver_ShowThunderFocusTeaOverlayGlow()
    MistWeaver_ShowOverlayGlow(_G["MwSurgingMistCastFrame"]);
    MistWeaver_ShowOverlayGlow(_G["MwRenewingMistCastFrame"]);
end

function MistWeaver_ShowOverlayGlow(parent)

    if ( parent.overlay ) then
        if ( parent.overlay.animOut:IsPlaying() ) then
            parent.overlay.animOut:Stop();
            parent.overlay.animIn:Play();
        end
    else
        parent.overlay = ActionButton_GetOverlayGlow();
        parent.overlay:SetParent(parent);
        parent.overlay:ClearAllPoints();
        parent.overlay:SetPoint("TOPLEFT", parent, "TOPLEFT", -6, 6);
        parent.overlay:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 6, -6);
        parent.overlay.animIn:Play();
    end
end

function MistWeaver_HideThunderFocusTeaOverlayGlow()
    MistWeaver_HideOverlayGlow(_G["MwSurgingMistCastFrame"]);
    MistWeaver_HideOverlayGlow(_G["MwRenewingMistCastFrame"]);
end

function MistWeaver_HideOverlayGlow(parent)
    if ( parent.overlay ) then
        if ( parent.overlay.animIn:IsPlaying() ) then
            parent.overlay.animIn:Stop();
        end
        if ( parent:IsVisible() ) then
            parent.overlay.animOut:Play();
        else
            ActionButton_OverlayGlowAnimOutFinished(parent.overlay.animOut);
        end
    end
end

function MistWeaver_GetUnitFrameForUnit(unit)
    local unitFrame;
    for i=1, MAX_UNITFRAMES, 1 do
        unitFrame = _G["MwUnitFrame"..i];

        if (unitFrame and unitFrame:IsVisible() and unitFrame.unit == unit) then
            return unitFrame;
        end
    end

    return nil;
end

function MistWeaver_UpdateHealPrediction()
    local unitFrame, unit;
    for i=1, MAX_UNITFRAMES, 1 do
        unitFrame = _G["MwUnitFrame"..i];
        unit = unitFrame.unit;

        if (unit) then
            MistWeaver_UpdateHealPredictionForUnit(frame, unit);
        end
    end
end

local MAX_INCOMING_HEAL_OVERFLOW = 1.05;
function MistWeaver_UpdateHealPredictionForUnit(frame, unit)
    local unitFrame = MistWeaver_GetUnitFrameForUnit(unit);

    if (not unitFrame) then
        return;
    end

    local healthBar = _G[unitFrame:GetName().."Health"];
    local healthPredictionBar = _G[unitFrame:GetName().."HealthPrediction"];

    local allIncomingHeal = UnitGetIncomingHeals(unit) or 0;

    --Make sure we don't go too far out of the frame.
    local health = healthBar:GetValue();
    local _, maxHealth = healthBar:GetMinMaxValues();

    --See how far we're going over.
    if (health + allIncomingHeal > maxHealth * MAX_INCOMING_HEAL_OVERFLOW) then
        allIncomingHeal = maxHealth * MAX_INCOMING_HEAL_OVERFLOW - health;
    end

    healthPredictionBar:SetMinMaxValues(0, maxHealth);
    healthPredictionBar:SetValue(health + allIncomingHeal);
end

function MistWeaver_UpdateUnit(frame, unit)
    MistWeaver_UpdateUnitHighlight(frame);
    MistWeaver_UpdateUnitHealth(frame, unit);
    MistWeaver_UpdateRenewingMist(frame, unit);
    MistWeaver_UpdateSoothingMist(frame, unit);
    MistWeaver_UpdateEnvelopingMist(frame, unit);
    MistWeaver_UpdateUnitThreatSituation(frame, unit);
    MistWeaver_UpdateUnitState(frame, unit);
    MistWeaver_UpdateUnitDebuffs(frame, unit);

    MistWeaver_UpdateRaidData(frame, unit);
end

function MistWeaver_UpdateUnitHighlight(frame)

    local art = _G[frame:GetName().."Art"];

    if (frame.highlight) then
        art.highlight:Show();
        art.highlight:SetVertexColor(MistWeaverData.HIGHLIGHT_COLOR.r, MistWeaverData.HIGHLIGHT_COLOR.g, MistWeaverData.HIGHLIGHT_COLOR.b);
    else
        art.highlight:Hide();
    end
end

function MistWeaver_UpdateUnitHealth(frame, unit)
    local healthBar = _G[frame:GetName().."Health"];

    local health = UnitHealth(unit);
    local healthMax = UnitHealthMax(unit);
    local totalAbsorbs = UnitGetTotalAbsorbs(unit);

    healthBar:SetMinMaxValues(0, healthMax);
    healthBar:SetValue(health);

    local localizedClass, englishClass = UnitClass(unit);
    local classColor = RAID_CLASS_COLORS[englishClass];

    if (not classColor) then
        classColor = { r = 1.0, g = 1.0, b = 1.0, colorStr = "ffffffff" };
    end

    local unitName = GetUnitName(unit);

    if (MistWeaverData.SHOW_PVP_ICON and UnitIsPVP(unit)) then
        local englishFaction, localizedFaction = UnitFactionGroup(unit);

        if (englishFaction == "Horde") then
            unitName = "|TInterface/WorldStateFrame/HordeIcon:20|t"..unitName;
        elseif (englishFaction == "Alliance") then
            unitName = "|TInterface/WorldStateFrame/AllianceIcon:20|t"..unitName;
        end
    end

    local textColor = {r=1.0, g=1.0, b=1.0};
    local statusBarColor = GREEN_FONT_COLOR;

    if (MistWeaverData.COLORTYPE == 1) then
        local color = YELLOW_FONT_COLOR;

        if (UnitIsFriend(unit, "player")) then
            color = GREEN_FONT_COLOR;

            local percent = 0;

            if (healthMax > 0) then
                percent = 100 * health / healthMax;
            end

            if (percent < 20) then
                color = RED_FONT_COLOR;
            elseif (percent < 40) then
                color = ORANGE_FONT_COLOR;
            elseif (percent < 70) then
                color = YELLOW_FONT_COLOR;
            end
        elseif (UnitIsEnemy(unit, "player")) then
            color = RED_FONT_COLOR;
        end

        statusBarColor = color;
        textColor = classColor;
    else
        statusBarColor = classColor;
        textColor = {r=1.0, g=1.0, b=1.0};
    end

    healthBar:SetStatusBarColor(statusBarColor.r, statusBarColor.g, statusBarColor.b);
    local hexColor = mw_rgb2hex(textColor.r, textColor.g, textColor.b);
    healthBar.text:SetText("|cff"..hexColor..unitName.."|r");

    healthBar.text:SetDrawLayer("OVERLAY");

    -- absorbs
    local overAbsorbGlow = _G[frame:GetName().."HealthOverAbsorbGlow"];
    local absorbBar = _G[frame:GetName().."HealthAbsorbBar"];

    local maxAbsorbs = min(healthMax, totalAbsorbs + health);

    if (totalAbsorbs + health > healthMax) then
        overAbsorbGlow:Show();
    else
        overAbsorbGlow:Hide();
    end

    local healthPercent = min(1, health/healthMax);
    local left = healthBar:GetWidth() * healthPercent;

    local absorbPercent = min(1, maxAbsorbs/healthMax);
    local right = healthBar:GetWidth() * absorbPercent;

    absorbBar:SetPoint("TOPLEFT", healthBar, "TOPLEFT", left, 0);
    absorbBar:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMLEFT", right, 0);
end

function MistWeaver_UpdateRenewingMist(frame, unit)
    local renewingMistBar = _G[frame:GetName().."RenewingMist"];

    local name, rank, icon, count, debuffType, duration, expirationTime, caster = UnitBuff(unit, RENEWING_MIST);

    renewingMistBar.caster = caster;

    if (name and name == RENEWING_MIST) then
        local startTime = expirationTime - duration;
        renewingMistBar:SetMinMaxValues(0, expirationTime-startTime);
        renewingMistBar:SetValue(expirationTime-GetTime());
        renewingMistBar:SetStatusBarColor(MistWeaverData.RENEWING_MIST_COLOR.r, MistWeaverData.RENEWING_MIST_COLOR.g, MistWeaverData.RENEWING_MIST_COLOR.b);
    else
        renewingMistBar:SetValue(0);
    end

    local currentCharges, maxCharges = GetSpellCharges(RENEWING_MIST);

    if (currentCharges and currentCharges > 0 and maxCharges and maxCharges > 1) then
        MwRenewingMistCastFrame.button.count:SetText(currentCharges);
    else
        MwRenewingMistCastFrame.button.count:SetText("");
    end
end

function MistWeaver_UpdateSoothingMist(frame, unit)
    local soothingMistBar = _G[frame:GetName().."SoothingMist"];

    local name, rank, icon, count, debuffType, duration, expirationTime, caster = UnitBuff(unit, SOOTHING_MIST);

    soothingMistBar.caster = caster;

    if (name and name == SOOTHING_MIST) then
        local startTime = expirationTime - duration;
        soothingMistBar:SetMinMaxValues(0, expirationTime-startTime);
        soothingMistBar:SetValue(expirationTime-GetTime());
        soothingMistBar:SetStatusBarColor(MistWeaverData.SOOTHING_MIST_COLOR.r, MistWeaverData.SOOTHING_MIST_COLOR.g, MistWeaverData.SOOTHING_MIST_COLOR.b);
    else
        soothingMistBar:SetValue(0);
    end
end

function MistWeaver_UpdateEnvelopingMist(frame, unit)
    local envelopingMistBar = _G[frame:GetName().."EnvelopingMist"];

    local name, rank, icon, count, debuffType, duration, expirationTime, caster = UnitBuff(unit, ENVELOPING_MIST);

    envelopingMistBar.caster = caster;

    if (name and name == ENVELOPING_MIST) then
        local startTime = expirationTime - duration;
        envelopingMistBar:SetMinMaxValues(0, expirationTime-startTime);
        envelopingMistBar:SetValue(expirationTime-GetTime());
        envelopingMistBar:SetStatusBarColor(MistWeaverData.ENVELOPING_MIST_COLOR.r, MistWeaverData.ENVELOPING_MIST_COLOR.g, MistWeaverData.ENVELOPING_MIST_COLOR.b);
    else
        envelopingMistBar:SetValue(0);
    end
end

function MistWeaver_UpdateUnitThreatSituation(frame, unit)

    -- threatpct
    -- the unit's threat on the mob as a percentage of the amount required to pull aggro, scaled according to the unit's range from the mob.
    -- At 100 the unit will pull aggro. Returns 100 if the unit is tanking and nil if the unit is not on the mob's threat list.
    -- rawthreatpct
    -- the unit's threat as a percentage of the tank's current threat. Returns nil if the unit is not on the mob's threat list.

    local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation(unit, unit.."target");
    local r, g, b = GetThreatStatusColor(status);

    local aggroTexture = frame.art.aggro;
    if (status and status > 0) then
        aggroTexture:SetVertexColor(GetThreatStatusColor(status));
        aggroTexture:Show();
    else
        aggroTexture:Hide();
    end

    if (not threatpct) then
        threatpct = 0;
    end

    if (threatpct > 100) then
        threatpct = 100;
    end

    local aggroBar = _G[frame:GetName().."Aggro"];
    aggroBar:SetValue(threatpct);
end

function MistWeaver_UpdateUnitState(frame, unit)
    local info = frame.art.info;
    local dc = frame.art.dc;

    local isAFK = UnitIsAFK(unit);
    local isDead = UnitIsDeadOrGhost(unit);
    local isInRange = UnitInRange(unit);
    local isConnected = UnitIsConnected(unit);

    if (unit == "player" or unit == "target" or unit == "focus") then
        isInRange = 1;
    end

    if (isAFK or isDead or (not isInRange) or (not isConnected)) then
        MistWeaver_SetUnitFrameAlpha(frame, MistWeaverData.UNITALPHA_DC, 0.0);
        if (not isConnected) then
            info:SetText("");
            dc:Show();
        elseif (isAFK) then
            info:SetText(AFK);
            dc:Hide();
        elseif (isDead) then
            info:SetText(DEAD);
            dc:Hide();
        elseif (not isInRange) then
            info:SetText("");
            dc:Hide();
        end
    else
        MistWeaver_SetUnitFrameAlpha(frame, 1.0, 0.5);
        info:SetText("");
        dc:Hide();
    end
end

function MistWeaver_UpdateUnitDebuffs(frame, unit)
    frame.art.debuff1:Hide();
    frame.art.debuff2:Hide();
    frame.art.debuff3:Hide();
    frame.art.debuff1border:Hide();
    frame.art.debuff2border:Hide();
    frame.art.debuff3border:Hide();

    local pos = 0;

    local debuffName, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId, canApplyAura, isBossDebuff, isCastByPlayer;
    local icon;

    local debuffColor, ignoreDebuff;
    local raidDebuffColor, raidExpirationTime; -- used for raid frame
    for index=1, 40 do
        debuffName, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId, canApplyAura, isBossDebuff, isCastByPlayer = UnitDebuff(unit, index);

        if (not debuffName) then
            break;
        end

        if (debuffType == "Magic" or debuffType == "Poison" or debuffType == "Disease") then
            debuffColor = MWDebuffTypeColor[debuffType];
            raidDebuffColor = debuffColor;
            raidExpirationTime = expirationTime - GetTime();
        else
            debuffColor = nil;
        end

        if (MistWeaverData.SHOW_DEBUFFS) then
            ignoreDebuff = MistWeaver_FindIgnoredDebuff(debuffName);

            -- filtern und 3 St�ck anzeigen
            if (not ignoreDebuff) then
                pos = pos + 1;
                _, _, icon = GetSpellInfo(spellId);

                if (pos == 1) then
                    frame.art.debuff1:SetTexture(icon);
                    frame.art.debuff1:Show();

                    if (debuffColor) then
                        frame.art.debuff1border:Show();
                        frame.art.debuff1border:SetVertexColor(debuffColor.r, debuffColor.g, debuffColor.b);
                    end
                elseif (pos == 2) then
                    frame.art.debuff2:SetTexture(icon);
                    frame.art.debuff2:Show();

                    if (debuffColor) then
                        frame.art.debuff2border:Show();
                        frame.art.debuff2border:SetVertexColor(debuffColor.r, debuffColor.g, debuffColor.b);
                    end
                elseif (pos == 3) then
                    frame.art.debuff3:SetTexture(icon);
                    frame.art.debuff3:Show();

                    if (debuffColor) then
                        frame.art.debuff3border:Show();
                        frame.art.debuff3border:SetVertexColor(debuffColor.r, debuffColor.g, debuffColor.b);
                    end
                else
                    break;
                end
            end
        end
    end

    MistWeaver_UpdateRaidDebuffColor(frame, unit, raidDebuffColor, raidExpirationTime);
end

function MistWeaver_UpdateRaidDebuffColor(frame, unit, debuffColor, expirationTime)
    if (not MistWeaverData.RAID_SHOW_DEBUFFS ) then
        return;
    end

    local detoxFrame = _G[frame:GetName().."RaidDetoxFrame"];
    local detoxItem = _G[frame:GetName().."RaidDetoxItem"];
    local detoxBorder = _G[frame:GetName().."RaidDetoxBorder"];
    local detoxExpirationTime = _G[frame:GetName().."DetoxExpirationTime"];

    local usable, nomana = IsUsableSpell(DETOX_ID);
    local start, duration, enabled = GetSpellCooldown(DETOX_ID);
    local currentCharges, maxCharges, cooldownStart, cooldownDuration = GetSpellCharges(DETOX_ID);

    if (UnitExists(unit) and (not UnitIsEnemy(unit, "player")) and debuffColor and usable) then   --  and duration == 0
        detoxFrame:SetAlpha(1);
        detoxItem:SetVertexColor(debuffColor.r, debuffColor.g, debuffColor.b);
        detoxBorder:SetVertexColor(debuffColor.r, debuffColor.g, debuffColor.b);

        if (expirationTime > 0 and expirationTime < 60) then
            detoxExpirationTime:SetText(ceil(expirationTime));
        else
            detoxExpirationTime:SetText("");
        end

        CooldownFrame_SetTimer(_G[frame:GetName().."DetoxCooldown"], start, duration, enabled, currentCharges, maxCharges);
    else
        detoxFrame:SetAlpha(0);
        detoxExpirationTime:SetText("");
    end
end

function MistWeaver_RebindRaidData(frame, unit)
    MistWeaver_UpdateRaidClassIcon(frame, unit);

    -- rebind raid buttons
    local button1 = _G[frame:GetName().."RaidButton1"];
    if (button1) then
        button1:SetAttribute("unit", unit);
        button1:SetAttribute("checkselfcast", false);
        button1:SetAttribute("checkfocuscast", false);

        button1:SetAttribute("type1", "target");
        button1:SetAttribute("shift-type1", "focus");

        button1:SetAttribute("type3", "spell");
        button1:SetAttribute("spell3", DETOX);

        button1:SetAttribute("type2", "menu");
        button1.menu = MistWeaver_ShowUnitContextMenu;
    end

    local button2 = _G[frame:GetName().."RaidButton2"];
    if (button2) then
        button2:SetAttribute("unit", unit);

        button2:SetAttribute("type1", "spell");
        button2:SetAttribute("spell1", DETOX);

        button2:SetAttribute("type2", "spell");
        button2:SetAttribute("spell2", DETOX);

        button2:SetAttribute("type3", "spell");
        button2:SetAttribute("spell3", DETOX);
    end

    -- move the role and raid icons
    local raidFrame = _G[frame:GetName().."Raid"];
    frame.art.raidIcon:ClearAllPoints();
    frame.art.raidIcon:SetPoint("TOP", raidFrame, "TOP", 0, -5);
    frame.art.raidIcon:SetSize(20, 20);
end

function MistWeaver_RaidDropDown_Initialize(self)
    local unit = self.unitFrame.unit;

    local menu;
    local name;
    local id = nil;

    if ( UnitIsUnit(unit, "player") ) then
        menu = "SELF";
    elseif ( UnitIsUnit(unit, "vehicle") ) then
        -- NOTE: vehicle check must come before pet check for accuracy's sake because
        -- a vehicle may also be considered your pet
        menu = "VEHICLE";
    elseif ( UnitIsUnit(unit, "pet") ) then
        menu = "PET";
    elseif ( UnitIsPlayer(unit) ) then
        id = UnitInRaid(unit);
        if ( id ) then
            menu = "RAID_PLAYER";
            name = GetRaidRosterInfo(id);
        elseif ( UnitInParty("target") ) then
            menu = "PARTY";
        else
            menu = "PLAYER";
        end
    else
        menu = "TARGET";
        name = RAID_TARGET_ICON;
    end

    if ( menu ) then
        UnitPopup_ShowMenu(self, menu, unit, name, id);
    end
end

function MistWeaver_ShowUnitContextMenu(self)
    if (InCombatLockdown()) then
        return;
    end

    local dropdown = _G[self:GetName().."Dropdown"];
    UIDropDownMenu_Initialize(dropdown, MistWeaver_RaidDropDown_Initialize, "MENU");

    if (dropdown) then
        ToggleDropDownMenu(1, nil, dropdown);
    end
end

function MistWeaver_UpdateRaidClassIcon(frame, unit)
    local icon = _G[frame:GetName().."RaidClassIcon"];

    if (icon) then
        local _, classToken = UnitClass(unit);

        if (classToken) then
            local coords = CLASS_BUTTONS[classToken];
            icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes");
            icon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
        else
            icon:SetTexture(nil);
        end
    end
end

function MistWeaver_UpdateRaidData(frame, unit)
    MistWeaver_UpdateRaidClassIcon(frame, unit);
end

function MistWeaver_SetUnitFrameAlpha(frame, alpha, alpha2)
    _G[frame:GetName().."Health"]:SetAlpha(alpha);
    _G[frame:GetName().."StatsBackdrop"]:SetAlpha(alpha);
    _G[frame:GetName().."HealthPrediction"]:SetAlpha(alpha2);

    local renewingMistBar = _G[frame:GetName().."RenewingMist"];

    if (renewingMistBar.caster and renewingMistBar.caster == "player") then
        renewingMistBar:SetAlpha(alpha);
    else
        renewingMistBar:SetAlpha(MistWeaverData.SPELL_ALPHA);
    end

    -- soothing mist transparency
    local soothingMistBar = _G[frame:GetName().."SoothingMist"];

    if (soothingMistBar.caster and soothingMistBar.caster == "player") then
        soothingMistBar:SetAlpha(alpha);
    else
        soothingMistBar:SetAlpha(MistWeaverData.SPELL_ALPHA);
    end

    -- enveloping mist transparency
    local envelopingMistBar = _G[frame:GetName().."EnvelopingMist"];

    if (envelopingMistBar.caster and envelopingMistBar.caster == "player") then
        envelopingMistBar:SetAlpha(alpha);
    else
        envelopingMistBar:SetAlpha(MistWeaverData.SPELL_ALPHA);
    end
end

