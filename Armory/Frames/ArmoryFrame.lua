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

ARMORY_MAX_LINE_TABS = 10;

ARMORYFRAME_MAINFRAMES = { "ArmoryFrame", "ArmoryLookupFrame", "ArmoryFindFrame" };
ARMORYFRAME_SUBFRAMES = { "ArmoryPaperDollFrame", "ArmoryPetFrame", "ArmoryTalentFrame", "ArmoryPVPFrame", "ArmoryOtherFrame" };
ARMORYFRAME_CHILDFRAMES = { "ArmoryTradeSkillFrame", "ArmoryInventoryFrame", "ArmoryQuestFrame", "ArmorySpellBookFrame", "ArmoryAchievementFrame", "ArmorySocialFrame" };

ARMORY_ID = "Armory";
ARMORYFRAME_SUBFRAME = "ArmoryPaperDollFrame";

local tabWidthCache = {};

function ArmoryFrame_ToggleArmory(tab)
    local subFrame = _G[tab];
    if ( subFrame ) then
        PanelTemplates_SetTab(ArmoryFrame, subFrame:GetID());
        if ( ArmoryFrame:IsVisible() ) then
            if ( subFrame:IsVisible() ) then
                HideUIPanel(ArmoryFrame);
            else
                PlaySound("igCharacterInfoTab");
                ArmoryFrame_ShowSubFrame(tab);
            end
        else
            ShowUIPanel(ArmoryFrame);
            ArmoryFrame_ShowSubFrame(tab);
        end
    end
end

function ArmoryFrame_ShowSubFrame(frameName)
    for index, value in pairs(ARMORYFRAME_SUBFRAMES) do
        if ( value == frameName ) then
            _G[value]:Show();
            ARMORYFRAME_SUBFRAME = value;
        else
            _G[value]:Hide();
        end
    end
end

function ArmoryFrame_OnLoad(self)
    Armory:Init();

    -- Sliding frame
    --this:SetAttribute("UIPanelLayout-defined", true);
    --this:SetAttribute("UIPanelLayout-enabled", true);
    --this:SetAttribute("UIPanelLayout-area", "left");
    --this:SetAttribute("UIPanelLayout-pushable", 5);
    --this:SetAttribute("UIPanelLayout-whileDead", true);

    self:RegisterEvent("VARIABLES_LOADED");
    self:RegisterEvent("UNIT_NAME_UPDATE");
    self:RegisterEvent("PLAYER_PVP_RANK_CHANGED");
    self:RegisterEvent("PLAYER_UPDATE_RESTING");
    self:RegisterEvent("PLAYER_LOGIN");
    self:RegisterEvent("PLAYER_LOGOUT");
    self:RegisterEvent("TIME_PLAYED_MSG");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("PLAYER_ENTER_COMBAT");
    self:RegisterEvent("PLAYER_LEAVE_COMBAT");
    self:RegisterEvent("PLAYER_REGEN_DISABLED");
    self:RegisterEvent("PLAYER_REGEN_ENABLED");
    
	ButtonFrameTemplate_HideButtonBar(self);

	self.Inset:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", PANEL_DEFAULT_WIDTH + PANEL_INSET_RIGHT_OFFSET, PANEL_INSET_BOTTOM_OFFSET);

	self.TitleText:SetPoint("LEFT", self, "LEFT", 84, 0);
	self.TitleText:SetPoint("RIGHT", self, "RIGHT", -40, 0);
	self.TitleText:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

    -- Tab Handling code
    PanelTemplates_SetNumTabs(self, #ARMORYFRAME_SUBFRAMES);
    PanelTemplates_SetTab(self, 1);

    -- Allows Armory to be closed with the Escape key
    table.insert(UISpecialFrames, "ArmoryFrame");
end

function ArmoryFrame_OnEvent(self, event, ...)
    local arg1 = ...;
	
    if ( event == "VARIABLES_LOADED" ) then
        Armory:InitDb();
        Armory:SetProfile(Armory:CurrentProfile());

        ArmoryMinimapButton_Init();
        Armory:PrepareMenu();

        Armory:RegisterTooltipHooks(GameTooltip);
        Armory:RegisterTooltipHooks(ItemRefTooltip);
        --Armory:RegisterTooltipHooks(ArmoryComparisonTooltip1);
        --Armory:RegisterTooltipHooks(ArmoryComparisonTooltip2);

        Armory:ExecuteDelayed(5, ArmoryFrame_Initialize);

        if ( IsAddOnLoaded("oGlow") ) then
            Armory_oGlow_OnLoad();
        end
        if ( IsAddOnLoaded("EnhTooltip") ) then
            Armory_EnhTooltip_OnLoad();
        end
        if ( IsAddOnLoaded("ManyItemTooltips") ) then
            Armory_MIT_OnLoad();
        end
        if ( IsAddOnLoaded("LinkWrangler") ) then
            Armory_LW_OnLoad();
        end
        if ( IsAddOnLoaded("GearScore") ) then
            -- PlayerScore
            Armory_PS_OnLoad();
        end
    elseif ( not Armory:CanHandleEvents() ) then
        return;
    elseif ( (event == "UNIT_NAME_UPDATE" and arg1 == "player") or event == "PLAYER_PVP_RANK_CHANGED" ) then
        Armory:Execute(ArmoryFrame_UpdateName);
    elseif ( event == "PLAYER_UPDATE_RESTING" ) then
        Armory:Execute(ArmoryFrame_UpdateResting);
    elseif ( event == "PLAYER_LOGIN" ) then
        if ( Armory:GetConfigScanOnEnter() ) then
            Armory.forceScan = true;
            Armory:SetConfigScanOnEnter(false);
        end
    elseif ( event == "PLAYER_LOGOUT" ) then
        Armory:SetTimePlayed(Armory:GetTimePlayed("player"));
    elseif ( event == "TIME_PLAYED_MSG" ) then
        Armory.hasTimePlayed = true;
        Armory:SetTimePlayed(arg1);
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        Armory.inCombat = false;
        Armory.onHateList = false;
    elseif ( event == "PLAYER_ENTER_COMBAT" ) then
        Armory.inCombat = true;
    elseif ( event == "PLAYER_LEAVE_COMBAT" ) then
        Armory.inCombat = false;
    elseif ( event == "PLAYER_REGEN_DISABLED" ) then
        Armory.onHateList = true;
    elseif ( event == "PLAYER_REGEN_ENABLED" ) then
        Armory.onHateList = false;
    end

    if ( (Armory.inCombat or Armory.onHateList) and Armory:GetConfigPauseWhileInCombat() ) then
        Armory.commandHandler:Pause();
    elseif ( not (IsInInstance() and Armory:GetConfigRemainPausedInInstance()) ) then
        Armory.commandHandler:Resume();
        Armory:ResetTooltipHook();
    end
end

function ArmoryFrame_UpdateName()
    ArmoryFrame.TitleText:SetText(Armory:UnitPVPName("player"));
end

function ArmoryFrame_UpdateResting()
    if ( Armory:IsResting() ) then
        ArmoryRestIcon:Show();
    else
        ArmoryRestIcon:Hide();
    end
end

local ChatFrame_DisplayTimePlayed_Orig = ChatFrame_DisplayTimePlayed;
function ChatFrame_DisplayTimePlayed(...)
    if ( not Armory.requestedTimePlayed ) then
        return ChatFrame_DisplayTimePlayed_Orig(...);
    end
    Armory.requestedTimePlayed = nil;
end

function ArmoryFrame_Initialize()
    if ( not Armory.hasTimePlayed ) then
        Armory.requestedTimePlayed = true;
        RequestTimePlayed();
    end
    
    Armory:RemoveOldAuctions();

    local expire = Armory:CheckMailItems(1);
    if ( expire > 0 ) then
        ArmoryStaticPopup_Show("ARMORY_CHECK_MAIL_POPUP", expire);
    end
end

function ArmoryFrame_UpdateMail()
    if ( Armory:HasNewMail() ) then
        ArmoryMailFrame:Show();
        if( GameTooltip:IsOwned(ArmoryMailFrame) ) then
            ArmoryMailFrameUpdate();
        end
    else
        ArmoryMailFrame:Hide();
    end
end

function ArmoryMailFrameUpdate()
    local sender1, sender2, sender3 = Armory:GetLatestThreeSenders();
    local toolText;

    if( sender1 or sender2 or sender3 ) then
        toolText = HAVE_MAIL_FROM;
    else
        toolText = HAVE_MAIL;
    end

    if( sender1 ) then
        toolText = toolText.."\n"..sender1;
    end
    if( sender2 ) then
        toolText = toolText.."\n"..sender2;
    end
    if( sender3 ) then
        toolText = toolText.."\n"..sender3;
    end
    GameTooltip:SetText(toolText);
end

function ArmoryFrame_OnShow(self)
    PlaySound("igCharacterInfoOpen");
    ArmoryFrame_Update(Armory:CurrentProfile());
end

function ArmoryFrame_OnHide(self)
    PlaySound("igCharacterInfoClose");
end

function ArmoryFrameTab_OnClick(self)
    local id = self:GetID();

    if ( id == 1 ) then
        ArmoryFrame_ToggleArmory("ArmoryPaperDollFrame");
    elseif ( id == 2 ) then
        ArmoryFrame_ToggleArmory("ArmoryPetFrame");
    elseif ( id == 3 ) then
        ArmoryFrame_ToggleArmory("ArmoryTalentFrame");
    elseif ( id == 4 ) then
        ArmoryFrame_ToggleArmory("ArmoryPVPFrame");
    elseif ( id == 5 ) then
        ArmoryFrame_ToggleArmory("ArmoryOtherFrame");
    end
    PlaySound("igCharacterInfoTab");
end

function ArmoryFrame_CheckTabBounds(tabName, totalTabWidth, maxTotalTabWidth, tabWidthCache)
    -- readjust tab sizes to fit
    local change, largestTab, tab;
	while ( totalTabWidth >= maxTotalTabWidth ) do
	    if ( not change ) then
	        change = 10;
	        totalTabWidth = totalTabWidth - change;
	    end
        -- progressively shave 10 pixels off of the largest tab until they all fit within the max width
        largestTab = 1;
        for i = 2, #tabWidthCache do
            if ( tabWidthCache[largestTab] < tabWidthCache[i] ) then
                largestTab = i;
            end
        end
        -- shave the width
        tabWidthCache[largestTab] = tabWidthCache[largestTab] - change;
        -- apply the shaved width
        tab = _G[tabName..largestTab];
        PanelTemplates_TabResize(tab, 0, tabWidthCache[largestTab]);
        -- now update the total width
        totalTabWidth = totalTabWidth - change;
    end
end

function ArmoryFrame_Update(profile, refresh)
    Armory:SetProfile(profile);
    Armory:SetPortraitTexture(ArmoryFramePortrait, "player");
    ArmoryFrame_UpdateName();
    ArmoryFrame_UpdateResting();
    ArmoryFrame_UpdateMail();
    ArmoryFrame_UpdateLineTabs();
    ArmoryAlternateSlotFrame_HideSlots();
    ArmoryFrameTab_Update();

    if ( table.getn(Armory:SelectableProfiles()) > 1 ) then
        ArmorySelectCharacter:Enable();
        ArmoryFrameLeftButton:Enable();
        ArmoryFrameRightButton:Enable();
    else
        ArmorySelectCharacter:Disable();
        ArmoryFrameLeftButton:Disable();
        ArmoryFrameRightButton:Disable();
    end

    if ( refresh ) then
        ArmoryPetFrame.page = 1;
        local subFrameUpdate = _G[ARMORYFRAME_SUBFRAME.."_OnShow"];
        if ( subFrameUpdate ) then
            subFrameUpdate(_G[ARMORYFRAME_SUBFRAME]);
        end
        ArmoryCloseChildWindows(true);
    end
end

local function TabAdjust(id, enable)
    local tab = _G["ArmoryFrameTab"..id];
    local nextTab = _G["ArmoryFrameTab"..(id+1)];
    local frame = _G[ARMORYFRAME_SUBFRAMES[id]];
    if ( not enable ) then
        if ( frame:IsVisible() ) then
             ArmoryFrame_ToggleArmory("ArmoryPaperDollFrame");
        end
        tab:Hide();
        if ( nextTab ) then
            nextTab:SetPoint("LEFT", tab, "LEFT", 0, 0);
        end
    else
        tab:Show();
        if ( nextTab ) then
            nextTab:SetPoint("LEFT", tab, "RIGHT", -16, 0);
        end
    end    
end

function ArmoryFrameTab_Update()
    local firstTab, numOtherTabs = ArmoryOtherFrameTab_Update();
    if ( numOtherTabs == 1 ) then
        ArmoryFrameTab5:SetText(ARMORY_OTHER_TABS[firstTab]);
    else
        ArmoryFrameTab5:SetText(FACTION_OTHER);
    end
    
    TabAdjust(2, Armory:HasPetUI());
    TabAdjust(3, Armory:HasTalents());
    TabAdjust(4, Armory:PVPEnabled());
    TabAdjust(5, numOtherTabs > 0);

    local tab;
    local totalTabWidth = 0;
    for i = 1, #ARMORYFRAME_SUBFRAMES do
        tabWidthCache[i] = 0;
        tab = _G["ArmoryFrameTab"..i];
        if ( tab:IsShown() ) then
            _G[tab:GetName().."Text"]:SetWidth(0);
            PanelTemplates_TabResize(tab, 0);
            tabWidthCache[i] = PanelTemplates_GetTabWidth(tab);
            totalTabWidth = totalTabWidth + tabWidthCache[i];
        end
    end
    ArmoryFrame_CheckTabBounds("ArmoryFrameTab", totalTabWidth, ArmoryFrame:GetWidth(), tabWidthCache);
end

function ArmorySelectCharacter_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:SetText(CHARACTER);
end

function ArmorySelectCharacter_OnLeave(self)
    if ( GameTooltip:IsOwned(self) ) then
      GameTooltip:Hide();
    end
end

function ArmorySelectCharacter_OnClick(self)
    if ( self.characterList and self.characterList:IsVisible() ) then
        ArmorySelectCharacter_OnHide(self);
        return;
    end

    self.characterList = Armory.qtip:Acquire("ArmoryCharacterList", 2);
    self.characterList:SetScale(Armory:GetConfigFrameScale());
    self.characterList:SetToplevel(1);
    self.characterList:ClearAllPoints();
    self.characterList:SetClampedToScreen(1);
    self.characterList:SetPoint("TOPLEFT", self, "BOTTOMLEFT");
    self.characterList:SetAutoHideDelay(1, self);

    ArmorySelectCharacter_OnLeave(self);
    ArmorySelectCharacter_Update(self.characterList);
end

function ArmorySelectCharacter_OnHide(self)
    if ( self.characterList ) then
        Armory.qtip:Release(self.characterList);
        self.characterList = nil;
    end
end

function ArmorySelectCharacter_Update(characterList)
    local unit = "player";
    local iconProvider = Armory.qtipIconProvider;
    local realms = Armory:RealmList();
    local collapsed = Armory:RealmState();

    local currentProfile = Armory:CurrentProfile();
    if ( not Armory:ProfileExists(currentProfile) ) then
        currentProfile = {realm=Armory.playerRealm, character=Armory.player};
    end

    characterList:Clear();
    
    if ( #realms == 1 ) then
        table.wipe(collapsed);
    end
    
    local index, column, myColumn;

    for _, realm in ipairs(realms) do
        index, column = characterList:AddLine();

        if ( #realms > 1 ) then
            myColumn = column; index, column = characterList:SetCell(index, myColumn, format("Interface\\Buttons\\UI-%sButton-Up", collapsed[realm] and "Plus" or "Minus"), iconProvider); 
            characterList:SetCellScript(index, myColumn, "OnMouseDown",
                function(self, realm)
                    if ( collapsed[realm] ) then
                        collapsed[realm] = nil;
                    else
                        collapsed[realm] = 1;
                    end
                    ArmorySelectCharacter_Update(characterList);
                end,
                realm
            );
            myColumn = column; index, column = characterList:SetCell(index, myColumn, realm, GameFontNormalSmallLeft);  
        else
            myColumn = column; index, column = characterList:SetCell(index, myColumn, realm, GameFontNormalSmallLeft, "LEFT", 2);  
        end

        for _, character in ipairs(Armory:CharacterList(realm)) do
            if ( not collapsed[realm] ) then
                index, column = characterList:AddLine();

                local profile = {realm=realm, character=character};
                Armory:SelectProfile(profile);

                if ( realm == currentProfile.realm and character == currentProfile.character ) then
                    myColumn = column; index, column = characterList:SetCell(index, myColumn, "Interface\\Buttons\\UI-CheckBox-Check", iconProvider);
                else
                    myColumn = column; index, column = characterList:SetCell(index, myColumn, "");
                end

                myColumn = column; index, column = characterList:SetCell(index, myColumn, character, GameFontHighlightSmallLeft);
                if ( Armory:GetConfigShowEnhancedTips() and Armory:UnitLevel(unit) and Armory:UnitClass(unit) ) then
                    local class, classEn = Armory:UnitClass(unit);
                    characterList:SetCellScript(index, myColumn, "OnEnter", 
                        function(self, tooltipInfo)
                            Armory:AddEnhancedTip(self, tooltipInfo[1], 1.0, 1.0, 1.0, tooltipInfo[2], 1);
                        end,
                        {Armory:UnitPVPName(unit), format(PLAYER_LEVEL_NO_SPEC, Armory:UnitLevel(unit), Armory:ClassColor(classEn, true), class)}
                    ); 
                    characterList:SetCellScript(index, myColumn, "OnLeave", 
                        function(self)
                            GameTooltip:Hide();
                        end
                    ); 
                end
                characterList:SetCellScript(index, myColumn, "OnMouseDown", 
                    function(self, profile)
                        characterList:Hide();
                        ArmoryFrameSelectCharacter(profile);
                    end,
                    profile
                );
            end
        end
    end
    Armory:SelectProfile(currentProfile);

    characterList:UpdateScrolling(398);
    characterList:Show();
end

function ArmoryFrame_DeleteCharacter(data)
    local profile = Armory:CurrentProfile();
    if ( data.realm == profile.realm and data.character == profile.character ) then
        profile = ArmoryFrameCharacterCycle(false, true);
    end
    Armory:DeleteProfile(data.realm, data.character, true);
    ArmoryFrame_Update(profile, true);
    if ( Armory.summary ) then 
        Armory:UpdateSummary(); 
    end
end

function ArmoryFrame_UpdateLineTabs()
    local tabId = 1;
    local frame;
    
    for i = 1, #ARMORYFRAME_CHILDFRAMES do
        frame = _G[ARMORYFRAME_CHILDFRAMES[i]];
        frame.enabled = nil;
    end

    if ( Armory:HasInventory() ) then
        ArmoryFrame_SetLineTab(tabId, "Inventory", INVENTORY_TOOLTIP, "Interface\\Icons\\INV_Misc_Bag_08");
        ArmoryInventoryFrame.enabled = true;
        tabId = tabId + 1;
    end

    if ( Armory:HasQuestLog() ) then
        ArmoryFrame_SetLineTab(tabId, "Quests", QUESTLOG_BUTTON, "Interface\\Icons\\INV_Misc_Book_08");
        ArmoryQuestFrame.enabled = true;
        tabId = tabId + 1;
    end

    if ( Armory:HasSpellBook() and Armory:GetNumSpellTabs() > 0 ) then
        ArmoryFrame_SetLineTab(tabId, "SpellBook", SPELLBOOK_BUTTON, "Interface\\Icons\\INV_Misc_Book_09");
        ArmorySpellBookFrame.enabled = true;
        tabId = tabId + 1;
    end

    if ( Armory:HasAchievements() and _G.GetTotalAchievementPoints() > 0 ) then
        ArmoryFrame_SetLineTab(tabId, "Achievements", ACHIEVEMENT_BUTTON, "Interface\\Icons\\Achievement_Level_10");
        ArmoryAchievementFrame.enabled = true;
        tabId = tabId + 1;
    end

    if ( Armory:HasSocial() ) then
        ArmoryFrame_SetLineTab(tabId, "Social", SOCIAL_BUTTON, "Interface\\Icons\\INV_Scroll_03");
        ArmorySocialFrame.enabled = true;
        tabId = tabId + 1;
    end

    if ( Armory:HasTradeSkills() ) then
        for _, name in ipairs(Armory:GetProfessionNames()) do
            if ( Armory:HasTradeSkillLines(name) ) then
                local lineTab = ArmoryFrame_SetLineTab(tabId, "TradeSkill", name, Armory:GetProfessionTexture(name));
                if ( lineTab ) then
                    lineTab.skillName = name;
                    tabId = tabId + 1;
                end
            end
        end
    end

    -- Hide unused tabs
    for i = tabId, ARMORY_MAX_LINE_TABS do
        _G["ArmoryFrameLineTab"..i]:Hide();
    end
end

function ArmoryFrame_SetLineTab(id, tabType, tooltip, texture)
    if ( id and id > 0 and id <= ARMORY_MAX_LINE_TABS ) then
        local lineTab = _G["ArmoryFrameLineTab"..id];
        if ( lineTab ) then
            lineTab:SetNormalTexture(texture);
            lineTab.tooltip = tooltip;
            lineTab.tabType = tabType;
            lineTab:Show();
        end
        return lineTab;
    end
end

function ArmoryFrameLineTabTooltip(self)
    if ( self.tooltip ) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetText(self.tooltip);
    end
end

function ArmoryFrameLineTab_OnClick(self)
    for i = 1, ARMORY_MAX_LINE_TABS do
        local lineTab = _G["ArmoryFrameLineTab"..i];
        if ( lineTab:GetID() ~= self:GetID() ) then
            lineTab:SetChecked(nil);
        end
    end

    if ( self.tabType == "Inventory" ) then
        ArmoryInventoryFrame_Toggle();
    elseif ( self.tabType == "Quests" ) then
        ArmoryQuestFrame_Toggle();
    elseif ( self.tabType == "SpellBook" ) then
        ArmoryToggleSpellBook(BOOKTYPE_SPELL);
    elseif ( self.tabType == "Social" ) then
        ArmorySocialFrame_Toggle();
    elseif ( self.tabType == "Achievements" ) then
        ArmoryAchievementFrame_Toggle()
    elseif ( self.tabType == "TradeSkill" ) then
        if ( ArmoryTradeSkillFrame:IsShown() and self.skillName == Armory:GetSelectedProfession() ) then
            ArmoryTradeSkillFrame_Hide();
            return;
        end
        Armory:SetSelectedProfession(self.skillName);
        ArmoryTradeSkillFrame_Show();
    end
end

function ArmoryFrameLeft_Click(self)
    ArmoryFrameCharacterCycle(false);
end

function ArmoryFrameLeft_OnEnter(self)
    local profile = ArmoryFrameCharacterCycle(false, true);
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
    if ( profile ) then
        GameTooltip:SetText(profile.character, 1.0, 1.0, 1.0);
        GameTooltip:AddLine(profile.realm);
        GameTooltip:SetScale(0.85);
        GameTooltip:Show();
        self.UpdateTooltip = ArmoryFrameLeft_OnEnter;
    else
        self.UpdateTooltip = nil;
    end
end

function ArmoryFrameRight_Click(self)
    ArmoryFrameCharacterCycle(true);
end

function ArmoryFrameRight_OnEnter(self)
    local profile = ArmoryFrameCharacterCycle(true, true);
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
    if ( profile ) then
        GameTooltip:SetText(profile.character, 1.0, 1.0, 1.0);
        GameTooltip:AddLine(profile.realm);
        GameTooltip:SetScale(0.85);
        GameTooltip:Show();
        self.UpdateTooltip = ArmoryFrameRight_OnEnter;
    else
        self.UpdateTooltip = nil;
    end
end

function ArmoryFrameCharacterCycle(next, peek)
    local currentRealm, currentCharacter = Armory:GetPaperDollLastViewed();
    local profiles = Armory:SelectableProfiles();
    local selected = 0;

    for index, profile in ipairs(profiles) do
        if ( profile.realm == currentRealm and profile.character == currentCharacter ) then
            selected = index;
            break;
        end
    end

    if ( next ) then
        selected = selected + 1;
    else
        selected = selected - 1;
    end
    if ( selected > #profiles ) then
        selected = 1;
    elseif ( selected < 1 ) then
        selected = #profiles;
    end

    if ( peek ) then
        return profiles[selected];
    end

    ArmoryFrameSelectCharacter(profiles[selected])
end

function ArmoryFrameSelectCharacter(profile)
    ArmoryFrame_Update(profile, true);
    ArmoryCloseDropDownMenus();
    Armory_EQC_Refresh();
    if ( not ArmoryFrame:IsShown() ) then
        local text = profile.character;
        if ( table.getn(Armory:RealmList()) > 1 ) then
            if ( profile.realm == GetRealmName() ) then
                text = text..RED_FONT_COLOR_CODE;
            end
            text = text.." ("..profile.realm..")";
        end
        ArmoryMessageFrame:AddMessage(text);
        ArmoryMessageFrame:Show();
    end
    if ( Armory.summary and Armory.summary:IsShown() ) then
        Armory:DisplaySummary();
    end
end

function ArmoryCloseChildWindows(reopen)
    local childWindow, currentChild;
    for index, value in pairs(ARMORYFRAME_CHILDFRAMES) do
        childWindow = _G[value];
        if ( childWindow ) then
            if ( childWindow:IsVisible() ) then
                currentChild = childWindow;
            end
            childWindow:Hide();
        end
    end
    if ( reopen and currentChild ) then
        if ( currentChild:GetName() == "ArmoryTradeSkillFrame" ) then
            for _, name in ipairs(Armory:GetProfessionNames()) do
                if ( name == Armory:GetSelectedProfession() ) then
                    if ( Armory:HasTradeSkillLines(name) ) then
                        Armory:SetSelectedProfession(name);
                        ArmoryTradeSkillFrame_Show();
                    end
                    break;
                end
            end
        elseif ( currentChild.enabled ) then
            currentChild:Show();
        end
    end
end

function ArmoryFrame_OnMouseUp(self, button)
    if ( ArmoryFrame.isMoving ) then
        ArmoryFrame:StopMovingOrSizing();
        ArmoryFrame.isMoving = false;
    end
end

function ArmoryFrame_OnMouseDown(self, button)
    if ( ( ( not ArmoryFrame.isLocked ) or ( ArmoryFrame.isLocked == 0 ) ) and ( button == "LeftButton" ) ) then
        ArmoryFrame:StartMoving();
        ArmoryFrame.isMoving = true;
    end
end

function ArmoryMinimapButton_Init()
    if ( Armory:GetConfigShowMinimap() ) then
        if ( Armory:GetConfigHideMinimapIfToolbar() and (IsAddOnLoaded("FuBar") or IsAddOnLoaded("Titan")) ) then
            ArmoryMinimapButton:Hide();
        else
            ArmoryMinimapButton_Move();
            ArmoryMinimapButton:Show();
        end
    else
        ArmoryMinimapButton:Hide();
    end
end

function ArmoryMinimapButton_OnLoad(self)
    self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    self:RegisterForDrag("LeftButton");
    self.updateDelay = 0;
end

function ArmoryMinimapButton_OnEnter(self)
    if ( not self.isMoving ) then
        Armory.LDB.OnEnter(self);
    end
end

function ArmoryMinimapButton_OnLeave(self)
    Armory.LDB.OnLeave();
end

function ArmoryMiniMapButton_OnClick(self, button)
    if ( not self.isMoving ) then
        Armory.LDB.OnClick(self, button);
    end
end

function ArmoryMinimapButton_OnUpdate(self, elapsed)
    self.updateDelay = self.updateDelay + elapsed;

    if ( self.isMoving ) then
        local xpos, ypos = GetCursorPosition();
        local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom();
        local angle;

        xpos = xmin - xpos / Minimap:GetEffectiveScale() + 70;
        ypos = ypos / Minimap:GetEffectiveScale() - ymin - 70;

        angle = math.deg(math.atan2(ypos, xpos));
        if ( angle < 0 ) then
            angle = angle + 360;
        end

        Armory:SetConfigMinimapAngle(angle);
        ArmoryOptionsMinimapPanelAngleSlider:SetValue(angle);

    elseif ( self.updateDelay > 0.5 ) then
        self.updateDelay = 0;

        if ( Armory.dbLoaded ) then
            ArmoryMinimapButtonIcon:SetTexture(Armory:GetPortraitTexture("player"));
        end
    end
end

function ArmoryMinimapButton_Move()
    local angle = Armory:GetConfigMinimapAngle();
    local radius = Armory:GetConfigMinimapRadius();
    local xpos = radius * cos(angle);
    local ypos = radius * sin(angle);

    ArmoryMinimapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 54 - xpos, ypos - 55);
end

local Orig_GameTooltip_ShowCompareItem = GameTooltip_ShowCompareItem;
function GameTooltip_ShowCompareItem(...)
    if ( ArmoryComparisonTooltip1:IsVisible() or ArmoryComparisonTooltip2:IsVisible() ) then
        return;
    end
    return Orig_GameTooltip_ShowCompareItem(...);
end

local function TooltipGetEquipmentSlot(tooltip)
    local text;
    for i = 1, tooltip:NumLines() do
        text = Armory:GetTooltipText(tooltip, i);
        if ( text == INVTYPE_HEAD ) then
            return "INVTYPE_HEAD";
        elseif ( text == INVTYPE_NECK ) then
            return "INVTYPE_NECK";
        elseif ( text == INVTYPE_SHOULDER ) then
            return "INVTYPE_SHOULDER";
        elseif ( text == INVTYPE_CLOAK ) then
            return "INVTYPE_CLOAK";
        elseif ( text == INVTYPE_CHEST ) then
            return "INVTYPE_CHEST";
        elseif ( text == INVTYPE_ROBE ) then
            return "INVTYPE_ROBE";
        elseif ( text == INVTYPE_BODY ) then
            return "INVTYPE_BODY";
        elseif ( text == INVTYPE_TABARD ) then
            return "INVTYPE_TABARD";
        elseif ( text == INVTYPE_WRIST ) then
            return "INVTYPE_WRIST";
        elseif ( text == INVTYPE_HAND ) then
            return "INVTYPE_HAND";
        elseif ( text == INVTYPE_WAIST ) then
            return "INVTYPE_WAIST";
        elseif ( text == INVTYPE_LEGS ) then
            return "INVTYPE_LEGS";
        elseif ( text == INVTYPE_FEET ) then
            return "INVTYPE_FEET";
        elseif ( text == INVTYPE_FINGER ) then
            return "INVTYPE_FINGER";
        elseif ( text == INVTYPE_TRINKET ) then
            return "INVTYPE_TRINKET";
        elseif ( text == INVTYPE_WEAPONMAINHAND ) then
            return "INVTYPE_WEAPONMAINHAND";
        elseif ( text == INVTYPE_2HWEAPON ) then
            return "INVTYPE_2HWEAPON";
        elseif ( text == INVTYPE_WEAPON ) then
            return "INVTYPE_WEAPON";
        elseif ( text == INVTYPE_WEAPONOFFHAND ) then
            return "INVTYPE_WEAPONOFFHAND";
        elseif ( text == INVTYPE_HOLDABLE ) then
            return "INVTYPE_HOLDABLE";
        elseif ( text == INVTYPE_RANGED ) then
            return "INVTYPE_RANGED";
        elseif ( text == INVTYPE_SHIELD ) then
            return "INVTYPE_SHIELD";
        elseif ( text == INVTYPE_RANGEDRIGHT ) then
            return "INVTYPE_RANGEDRIGHT";
        elseif ( text == INVTYPE_THROWN ) then
            return "INVTYPE_THROWN";
        elseif ( text == INVTYPE_RELIC ) then
            return "INVTYPE_RELIC";
        end
    end
end

function ArmoryComparisonFrame_OnUpdate(self, elapsed)
    local link, tooltip;

    self.updateTime = self.updateTime - elapsed;
    if ( self.updateTime > 0 ) then
        return;
    end
    self.updateTime = TOOLTIP_UPDATE_TIME;

    if ( not Armory:GetConfigShowEqcTooltips() ) then
        return;
    elseif ( GameTooltip:IsVisible() ) then
        tooltip = GameTooltip;
    elseif ( ItemRefTooltip:IsVisible() ) then
        tooltip = ItemRefTooltip;
    elseif ( AtlasLootTooltip and AtlasLootTooltip:IsVisible() ) then
        tooltip = AtlasLootTooltip;
    end
    self.tooltip = tooltip;
    if ( IsAltKeyDown() and tooltip ) then
        local buyable = MerchantFrame and MerchantFrame:IsVisible();
        local learnable = ClassTrainerFrame and ClassTrainerFrame:IsVisible();
        _, link = tooltip:GetItem();
        if ( not link or buyable or learnable ) then
            link = TooltipGetEquipmentSlot(tooltip);
        end
        if ( self.link ~= link ) then
            self.link = link;
            self.hasShoppingTooltips = ShoppingTooltip1:IsVisible() or ShoppingTooltip2:IsVisible() or ShoppingTooltip3:IsVisible();
            if ( link ) then
                self.hasComparison = true;

                ShoppingTooltip1:Hide();
                ShoppingTooltip2:Hide();
                ShoppingTooltip3:Hide();

                ArmoryShowCompareItem(tooltip, link);
            else
                ArmoryComparisonTooltip1:Hide();
                ArmoryComparisonTooltip2:Hide();
            end
        end

    elseif ( self.hasComparison ) then
        self.hasComparison = false;
        self.link = nil;

        ArmoryComparisonTooltip1:Hide();
        ArmoryComparisonTooltip2:Hide();

        if ( self.hasShoppingTooltips ) then
            if ( GameTooltip:IsVisible() ) then
                GameTooltip_ShowCompareItem();
            elseif ( AtlasLootTooltip and AtlasLootTooltip:IsVisible() ) then
                if ( AtlasLootItem_ShowCompareItem ) then
                    AtlasLootItem_ShowCompareItem();
                elseif ( AtlasLoot.ItemShowCompareItem ) then
                    AtlasLoot:ItemShowCompareItem();
                end
            end
        end

    end
end

local compareSlots = {};
function ArmoryShowCompareItem(tooltip, link)
    ArmoryComparisonTooltip1:Hide();
    ArmoryComparisonTooltip2:Hide();

    if ( (link or "") == ""  ) then
        return;
    end
    
    local equipLoc;
    if ( link:find("|H") ) then
        if ( not IsEquippableItem(link) ) then
            return;
        end
        _, _, _, _, _, _, _, _, equipLoc = GetItemInfo(link);
    else
        equipLoc = link;
    end
    local slot = ARMORY_SLOTINFO[equipLoc];

    if ( not slot ) then
        return;
    elseif ( slot:match("Finger.Slot") ) then
        compareSlots[1] = "Finger0Slot";
        compareSlots[2] = "Finger1Slot";
    elseif ( slot:match("Trinket.Slot") ) then
        compareSlots[1] = "Trinket0Slot";
        compareSlots[2] = "Trinket1Slot";
    elseif ( slot == "MainHandSlot" or slot == "SecondaryHandSlot" ) then
        compareSlots[1] = "SecondaryHandSlot";
        compareSlots[2] = "MainHandSlot";
    else
        compareSlots[1] = slot;
        compareSlots[2] = nil;
    end

    local slotId = GetInventorySlotInfo(compareSlots[1]);
    local itemLink = Armory:GetInventoryItemLink("player", slotId);
    if ( not itemLink ) then
        compareSlots[1] = compareSlots[2];
        compareSlots[2] = nil;
    end
    if ( not compareSlots[1] ) then
        return;
    end

    -- find correct side
    local side = "left";
    local rightDist = 0;
    local leftPos = tooltip:GetLeft();
    local rightPos = tooltip:GetRight();
    if ( not rightPos ) then
        rightPos = 0;
    end
    if ( not leftPos ) then
        leftPos = 0;
    end

    rightDist = GetScreenWidth() - rightPos;

    if (leftPos and (rightDist < leftPos)) then
        side = "left";
    else
        side = "right";
    end

    -- see if we should slide the tooltip
    if ( tooltip:GetAnchorType() ) then
        local totalWidth = 0;
        if ( compareSlots[1]  ) then
            Armory:SetInventoryItem("player", GetInventorySlotInfo(compareSlots[1]), nil, ArmoryComparisonTooltip1);
            totalWidth = totalWidth + ArmoryComparisonTooltip1:GetWidth();
        end
        if ( compareSlots[2]  ) then
            Armory:SetInventoryItem("player", GetInventorySlotInfo(compareSlots[2]), nil, ArmoryComparisonTooltip2);
            totalWidth = totalWidth + ArmoryComparisonTooltip2:GetWidth();
        end

        if ( (side == "left") and (totalWidth > leftPos) ) then
            tooltip:SetAnchorType(tooltip:GetAnchorType(), (totalWidth - leftPos), 0);
        elseif ( (side == "right") and (rightPos + totalWidth) >  GetScreenWidth() ) then
            tooltip:SetAnchorType(tooltip:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0);
        end
    end

    -- anchor the compare tooltips
    if ( compareSlots[1] ) then
        ArmoryComparisonTooltip1:SetOwner(tooltip, "ANCHOR_NONE");
        ArmoryComparisonTooltip1:SetScale(GameTooltip:GetScale());
        ArmoryComparisonTooltip1:ClearAllPoints();
        if ( side and side == "left" ) then
            ArmoryComparisonTooltip1:SetPoint("TOPRIGHT", tooltip:GetName(), "TOPLEFT", 0, -10);
        else
            ArmoryComparisonTooltip1:SetPoint("TOPLEFT", tooltip:GetName(), "TOPRIGHT", 0, -10);
        end
        Armory:SetInventoryItem("player", GetInventorySlotInfo(compareSlots[1]), nil, ArmoryComparisonTooltip1);

        if ( compareSlots[2] ) then
            ArmoryComparisonTooltip2:SetOwner(ArmoryComparisonTooltip1, "ANCHOR_NONE");
            ArmoryComparisonTooltip2:SetScale(GameTooltip:GetScale());
            ArmoryComparisonTooltip2:ClearAllPoints();
            if ( side and side == "left" ) then
                ArmoryComparisonTooltip2:SetPoint("TOPRIGHT", "ArmoryComparisonTooltip1", "TOPLEFT", 0, 0);
            else
                ArmoryComparisonTooltip2:SetPoint("TOPLEFT", "ArmoryComparisonTooltip1", "TOPRIGHT", 0, 0);
            end
            Armory:SetInventoryItem("player", GetInventorySlotInfo(compareSlots[2]), nil, ArmoryComparisonTooltip2);
        end
    end
end

function Armory_EQC_Refresh()
    local frame = ArmoryComparisonFrame;
    if ( frame.hasComparison ) then
        ArmoryShowCompareItem(frame.tooltip, frame.link);
    end

    if ( EquipCompare_PostClearTooltip ) then
        EquipCompare_PostClearTooltip();
    end
end

----------------------------------------------------------
-- EnhTooltip support
----------------------------------------------------------

function Armory_EnhTooltip_OnLoad()
    Stubby.RegisterFunctionHook("Armory.SetQuestLogItem", 200, Armory_EnhTooltip_HookSetQuestLogItem);
    Stubby.RegisterFunctionHook("Armory.SetInventoryItem", 200, Armory_EnhTooltip_HookSetInventoryItem);
    Stubby.RegisterFunctionHook("Armory.SetBagItem", 200, Armory_EnhTooltip_HookSetBagItem);
    Stubby.RegisterFunctionHook("Armory.SetTradeSkillItem", 200, Armory_EnhTooltip_HookSetTradeSkillItem);
end

function Armory_EnhTooltip_HookSetQuestLogItem(funcArgs, retVal, frame, qtype, slot)
    local link = Armory:GetQuestLogItemLink(qtype, slot);
    if ( link ) then
        local name, texture, quantity, quality, usable = Armory:GetQuestLogRewardInfo(slot);
        name = name or Armory:GetNameFromLink(link);
        quality = Armory:GetQualityFromLink(link);
        return EnhTooltip.TooltipCall(GameTooltip, name, link, quality, quantity);
    end
end

function Armory_EnhTooltip_HookSetInventoryItem(funcArgs, retVal, frame, unit, slot, dontShow, tooltip, link)
    if ( (link or Armory:GetInventoryItem(slot)) and not dontShow and not tooltip ) then
        link = link or Armory:GetInventoryItemLink(unit, slot);
        if ( link ) then
            local name = Armory:GetNameFromLink(link);
            local quantity = 1;
            local quality = Armory:GetQualityFromLink(link);
            return EnhTooltip.TooltipCall(GameTooltip, name, link, quality, quantity);
        end
    end
end

function Armory_EnhTooltip_HookSetBagItem(funcArgs, retVal, frame, frameID, buttonID)
    local link = Armory:GetContainerItemLink(frameID, buttonID);
    local name = Armory:GetNameFromLink(link);
    if ( name ) then
        local texture, itemCount, locked, quality, readable = Armory:GetContainerItemInfo(frameID, buttonID);
        if ( not (quality and quality ~= -1) ) then
            quality = Armory:GetQualityFromLink(link);
        end
        return EnhTooltip.TooltipCall(GameTooltip, name, link, quality, itemCount);
    end
end

function Armory_EnhTooltip_HookSetTradeSkillItem(funcArgs, retVal, frame, skill, slot)
    local link;
    if ( slot ) then
        link = Armory:GetTradeSkillReagentItemLink(skill, slot);
        if ( link ) then
            local name, texture, quantity = Armory:GetTradeSkillReagentInfo(skill, slot);
            local quality = Armory:GetQualityFromLink(link);
            return EnhTooltip.TooltipCall(GameTooltip, name, link, quality, quantity);
        end
    else
        link = Armory:GetTradeSkillItemLink(skill);
        if ( link ) then
            local name = Armory:GetNameFromLink(link);
            local quality = Armory:GetQualityFromLink(link);
            return EnhTooltip.TooltipCall(GameTooltip, name, link, quality);
        end
    end
end

----------------------------------------------------------
-- oGlow support
----------------------------------------------------------

local alertSlots = {
    "ArmoryHeadSlot",
    "ArmoryShoulderSlot",
    "ArmoryChestSlot",
    "ArmoryWaistSlot",
    "ArmoryLegsSlot",
    "ArmoryFeetSlot",
    "ArmoryWristSlot",
    "ArmoryHandsSlot",
    "ArmoryMainHandSlot",
    "ArmorySecondaryHandSlot"
};

local function GetAlertStatus(buttonName)
    for index, value in pairs(alertSlots) do
        if ( value == buttonName ) then
            return Armory:GetInventoryAlertStatus(index) or 2;
        end
    end
    return 2;
end

function Armory_oGlow_OnLoad()
    hooksecurefunc("ArmoryPaperDollItemSlotButton_Update", Armory_oGlow_PaperDollItemSlotButton_Update);
    hooksecurefunc(Armory, "SetItemLink", Armory_oGlow_SetItemLink);
end

function Armory_oGlow_PaperDollItemSlotButton_Update(button)
    if ( oGlow.CallFilters ) then
        oGlow:CallFilters("char", button, button.link);
    else
        local slotId = button:GetID();
        local quality = -1;
        local status = 2;
        local isBroken;
    
        if ( button.itemId ~= nil ) then
            if ( button.itemId ~= 0 ) then
                _, _, quality = _G.GetItemInfo(button.itemId);
            end
        else
            quality = Armory:GetInventoryItemQuality("player", slotId) or Armory:GetQualityFromLink(button.link);
            isBroken = Armory:GetInventoryItemBroken("player", slotId);
            status = GetAlertStatus(button:GetName());

            if ( isBroken ) then
                quality = 100;
            elseif ( status == 3 ) then
                quality = 99;
            end
        end

        oGlow(button, quality);
    end
end

function Armory_oGlow_SetItemLink(self, button, link)
    local icon = _G[button:GetName().."IconTexture"] or button;
    if ( icon and icon.IsDesaturated and icon:IsDesaturated() ) then
        return;
    elseif ( oGlow.CallFilters ) then
        oGlow:CallFilters("bags", icon, link);
    elseif ( link ) then
        local _, _, quality = GetItemInfo(link);
        oGlow(button, quality or Armory:GetQualityFromLink(link), icon);
    elseif ( button.bc ) then
        button.bc:Hide();
    end
end

----------------------------------------------------------
-- ManyItemTooltips (MIT) support
----------------------------------------------------------

function Armory_MIT_OnLoad()
    Armory.MIT_tooltips = {};
    MIT:AddHook("Armory", "OnCreate", function (tooltip) 
        table.insert(Armory.MIT_tooltips, tooltip); 
        Armory:RegisterTooltipHooks(tooltip);
    end);
end

----------------------------------------------------------
-- LinkWrangler support
----------------------------------------------------------

function Armory_LW_OnLoad()
    Armory.LW_tooltips = {};
    LinkWrangler.RegisterCallback("Armory", 
        function (tooltip)
            table.insert(Armory.LW_tooltips, tooltip); 
            Armory:RegisterTooltipHooks(tooltip); 
        end, 
        "allocate"); 
end

----------------------------------------------------------
-- GearScore support
----------------------------------------------------------

function Armory_GS_OnLoad()
    ArmoryGS = {};
    setmetatable(ArmoryGS, {__index = _G});

    ArmoryGS.UnitIsPlayer = function(unit) return true;	end;
    ArmoryGS.UnitClass = function(unit) return Armory:UnitClass(unit); end;
    ArmoryGS.UnitName = function(unit) return Armory:UnitName(unit); end;
    ArmoryGS.GetInventoryItemLink = function(unit, index) return (Armory:GetInventoryItemLink(unit, index)) or false; end;

    ArmoryGS.UnitRace = function(unit) return Armory:UnitRace(unit); end;
    ArmoryGS.UnitLevel = function(unit) return Armory:UnitLevel(unit); end;
    ArmoryGS.UnitFactionGroup = function(unit) return Armory:UnitFactionGroup(unit); end;
    ArmoryGS.UnitSex = function(unit) return Armory:UnitSex(unit); end;
    ArmoryGS.GetZoneText = function() return Armory:GetZoneText(); end;
    ArmoryGS.GetGuildInfo = function(unit) return Armory:GetGuildInfo(unit); end;
    ArmoryGS.GetRealmName = function() return Armory.characterRealm; end;

    ArmoryGS.GetItemInfo = function(link)
        local text = Armory:GetTextFromLink(link);
        if ( text == "" or text:find(RETRIEVING_ITEM_INFO) or not _G.GetItemInfo(link) ) then
            ArmoryGS.noData = true;
            return "", link, 0, 0, 0, "", "", 0, "", "", 0;
        else
            return _G.GetItemInfo(link);
        end
    end
    
    ArmoryGS.ArmoryFrame_Update = ArmoryFrame_Update;
    ArmoryGS.GearScore_HookItem = GearScore_HookItem;
    ArmoryGS.GearScore_EquipCompare = function() end;
    ArmoryGS.GearScore_HookCompareItem = function(tooltip)
        local name, link = tooltip:GetItem();
        local Orig_CalculateClasicItemScore = CalculateClasicItemScore;
        CalculateClasicItemScore = function() end;
        GearScore_HookItem(name, link, tooltip);
        CalculateClasicItemScore = Orig_CalculateClasicItemScore;
    end

    ArmoryFrame_Update = function(...)
        ArmoryGS.ArmoryFrame_Update(...);
        setfenv(GearScore_GetScore, ArmoryGS);
        setfenv(GearScore_GetItemScore, ArmoryGS);
        ArmoryGS.noData = false;
        local success, score, avg = pcall(GearScore_GetScore, Armory:UnitName("player"), "player");
        if ( not success ) then
            Armory:PrintDebug(score);
            score = 0;
        end
        local r, g, b = GearScore_GetQuality(score);
        if ( ArmoryGS.noData ) then
            score = "?";
            r, g, b = GetTableColor(RED_FONT_COLOR);
        end
        ArmoryGearScore:SetText("GS:"..score);
        ArmoryGearScore:SetTextColor(r, g, b);
        setfenv(GearScore_GetScore, _G);
        setfenv(GearScore_GetItemScore, _G);
    end

    GearScore_HookItem = function(...)
        local frame = GetMouseFocus();
        if ( IsAltKeyDown() or (frame and frame:GetName() and frame:GetName():sub(1, 6) == "Armory") ) then
            setfenv(ArmoryGS.GearScore_HookItem, ArmoryGS);
            if ( CalculateClasicItemScore ) then
                setfenv(CalculateClasicItemScore, ArmoryGS);
            end
        end
        ArmoryGS.GearScore_HookItem(...);
        setfenv(ArmoryGS.GearScore_HookItem, _G);
        if ( CalculateClasicItemScore ) then
            setfenv(CalculateClasicItemScore, _G);
        end
    end

    ArmoryPaperDollFrame:CreateFontString("ArmoryGearScore");
    ArmoryGearScore:SetFontObject("ArmoryFontHighlightExtraSmall");
    ArmoryGearScore:SetText("GS:0");
    ArmoryGearScore:SetPoint("BOTTOMRIGHT", ArmoryPaperDollFrame, "BOTTOMRIGHT", -45, 85);
    ArmoryGearScore:Show();

    ArmoryComparisonTooltip1:HookScript("OnTooltipSetItem", ArmoryGS.GearScore_HookCompareItem);
    ArmoryComparisonTooltip2:HookScript("OnTooltipSetItem", ArmoryGS.GearScore_HookCompareItem);
end

function Armory_PS_OnLoad()
    ArmoryPS = {};
    setmetatable(ArmoryPS, {__index = _G});

    ArmoryPS.UnitClass = function(unit) return Armory:UnitClass(unit); end;
    ArmoryPS.UnitLevel = function(unit) return Armory:UnitLevel(unit); end;
    ArmoryPS.UnitName = function(unit) return Armory:UnitName(unit); end;
    ArmoryPS.GetActiveSpecGroup = function(inspect) return Armory:GetActiveSpecGroup(); end;
    ArmoryPS.GetSpecialization = function(inspect, pet, talentGroup) return Armory:GetSpecialization(inspect, pet, talentGroup); end;
    ArmoryPS.GetSpecializationInfo = function(index, inspect, pet) return Armory:GetSpecializationInfo(index, inspect, pet); end;
    ArmoryPS.GetInventoryItemLink = function(unit, index) return (Armory:GetInventoryItemLink(unit, index)) or nil; end;

    local categoryInfo = PAPERDOLL_STATCATEGORIES["PLAYERSCORE"];
    if ( categoryInfo and not ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS["PLAYERSCORE"] ) then
        table.insert(ARMORY_PLAYERSTAT_DROPDOWN_OPTIONS, "PLAYERSCORE");
        for index, stat in next, categoryInfo.stats do
            local updateFunc = PAPERDOLL_STATINFO[stat].updateFunc;
            ARMORY_PAPERDOLL_STATINFO[stat] = {
                updateFunc = function(statFrame, unit)
                    if ( Armory:IsPlayerSelected() ) then
                       return updateFunc(statFrame, unit);
                    end
                    local Orig_Realm = TenTonHammer.Realm;
                    TenTonHammer.Realm = Armory.characterRealm;
                    if not ( TenTonHammer_Database[TenTonHammer.Realm] ) then
                        TenTonHammer_Database[TenTonHammer.Realm] = {};
                    end;
                    local Orig_GetComparisonStatistic = GetComparisonStatistic;
                    GetComparisonStatistic = function(id) return tonumber(Armory:GetStatistic(id)); end;
                    setfenv(TenTonHammer.GetPlayerInfo, ArmoryPS);
                    pcall(TenTonHammer.GetPlayerInfo, TenTonHammer);
                    pcall(updateFunc, statFrame, unit);
                    setfenv(TenTonHammer.GetPlayerInfo, _G);
                    GetComparisonStatistic = Orig_GetComparisonStatistic;
                    TenTonHammer.Realm = Orig_Realm;
                    TenTonHammer.PlayerInfo = nil;
                end 
            };
        end
    end
end
