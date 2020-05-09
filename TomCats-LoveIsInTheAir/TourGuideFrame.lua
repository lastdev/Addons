local _, addon = ...
local TCL = addon.TomCatsLibs
local TourGuideFrame
local P, AP
local pages = TCL.Data["Pages"]
local chapters = TCL.Data["Chapters"]
local links = TCL.Data["Links"]
local currentChapter = 1
local currentPage = 1
local CHAPTER_NUMBER = "Chapter %d"
local ticketListener;
local pendingTicketIds = {};
local ticketListener;
--local clickframe
--local function QueueAuto()
--    clickframe:Hide()
--    local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
--    if ( mode == "queued" or mode == "listed" or mode == "rolecheck" or mode == "suspended" ) then
--    else
--        local leader, tank, healer, dps = GetLFGRoles()
--        SetLFGRoles(
--            false,
--            true,true,true
--        ) -- where lead, tank, healer, dps are booleans, may set with role check button clicks
--        ClearAllLFGDungeons(LE_LFG_CATEGORY_LFD)
--        SetLFGDungeon(LE_LFG_CATEGORY_LFD, 288)
--        JoinLFG(LE_LFG_CATEGORY_LFD)
--        SetLFGRoles(leader,tank,healer,dps)
--    end
--end
local function OnClickLink(ticketId)
    if not ticketListener then
        ticketListener = CreateFrame("FRAME");
        ticketListener:SetScript("OnEvent", CommunitiesHyperlink_OnEvent);
    end
    if not pendingTicketIds[ticketId] then
        ticketListener:RegisterEvent("CLUB_TICKET_RECEIVED");
        pendingTicketIds[ticketId] = true;
        C_Club.RequestTicket(ticketId);
    end
end
local function UpdateLFDButton()
    TourGuideFrame.dungeon.findGroupButton:SetText(LFDQueueFrameFindGroupButton:GetText())
    if (TourGuideFrame.dungeon.roles.tank.checkButton:GetChecked() or
            TourGuideFrame.dungeon.roles.healer.checkButton:GetChecked() or
            TourGuideFrame.dungeon.roles.dps.checkButton:GetChecked()) then
        if (LFDQueueFrameFindGroupButton:IsEnabled()) then
            TourGuideFrame.dungeon.findGroupButton:Enable()
        else
            if (LFDQueueFrameFindGroupButton.tooltip == INSTANCE_ROLE_WARNING_TITLE) then
                TourGuideFrame.dungeon.findGroupButton:Enable()
            else
                TourGuideFrame.dungeon.findGroupButton.tooltip = LFDQueueFrameFindGroupButton.tooltip
                TourGuideFrame.dungeon.findGroupButton:Disable()
            end
        end
        TourGuideFrame.dungeon.findGroupButton.tooltip = nil
    else
        TourGuideFrame.dungeon.findGroupButton.tooltip = INSTANCE_ROLE_WARNING_TITLE
        TourGuideFrame.dungeon.findGroupButton:Disable()
    end
end
local function ADDON_LOADED(_, event, ...)
    local arg1 = select(1, ...)
    if (arg1 == addon.name) then
        addon.savedVariables.character.preferences = addon.savedVariables.character.preferences or { }
        P = addon.savedVariables.character.preferences
        addon.savedVariables.account.preferences = addon.savedVariables.account.preferences or { }
        AP = addon.savedVariables.account.preferences
        function TourGuideFrame.toggle()
            if (TourGuideFrame:IsShown()) then
                HideUIPanel(TourGuideFrame)
            else
                ShowUIPanel(TourGuideFrame)
                TourGuideFrame.chapterButtons["button" .. currentChapter]:SetChecked(true)
            end
        end
        function TourGuideFrame.nextPage()
            if (currentPage < #pages[currentChapter]) then
                TourGuideFrame.gotoPage(currentPage + 1)
            end
        end
        function TourGuideFrame.prevPage()
            if (currentPage > 1) then
                TourGuideFrame.gotoPage(currentPage - 1)
                TourGuideFrame.pageNavigationFrame.nextPageButton:Enable()
            end
        end
        function TourGuideFrame.gotoPage(pageNum)
            if (pageNum == 1) then
                TourGuideFrame.pageNavigationFrame.prevPageButton:Disable()
            else
                TourGuideFrame.pageNavigationFrame.prevPageButton:Enable()
            end
            if (pageNum == #pages[currentChapter]) then
                TourGuideFrame.pageNavigationFrame.nextPageButton:Disable()
            else
                TourGuideFrame.pageNavigationFrame.nextPageButton:Enable()
            end
            TourGuideFrame.pageNavigationFrame.pageText:SetFormattedText(CHAPTER_NUMBER .. ", " .. PAGE_NUMBER, currentChapter, pageNum)
            TourGuideFrame.content:SetText(pages[currentChapter][pageNum].content);
            currentPage = pageNum
        end
        function TourGuideFrame.gotoChapter(self, init)
            local currentTab = TourGuideFrame.chapterButtons["button" .. currentChapter]
            if (currentTab == self and (not init)) then return end
            self:SetChecked(true);
            currentTab:SetChecked(false);
            currentChapter = self:GetID()
            TourGuideFrame.gotoPage(1)
        end
        function TourGuideFrame.hyperlink(self, href)
            --    TourGuideFrame[links[href].type](TourGuideFrame, links[href].params)
        end
        function TourGuideFrame:joinCommunity()
            local ticketId
            local region = GetCurrentRegionName()
            if (region == "US" or region == "EU") then
                if (region == "US") then
                    ticketId = "nlvbGvmib2a"
                else
                    ticketId = "ABDDPlSLV7"
                end
                if ( CommunitiesFrame_IsEnabled() ) then
                    Communities_LoadUI()
                    OnClickLink(ticketId)
                end
            end
        end
        ButtonFrameTemplate_HideButtonBar(TourGuideFrame);
        ButtonFrameTemplate_HideAttic(TourGuideFrame);
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        hooksecurefunc("LFDQueueFrameFindGroupButton_Update", UpdateLFDButton)
--        clickframe = CreateFrame("Button", nil, UIParent)
--        clickframe:SetScript("OnClick", QueueAuto)
--        clickframe:SetAllPoints(UIParent)
    end
end
TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)
local TourGuideFrameMixin = {}
_G["TomCats-LoveIsInTheAirTourGuideFrameMixin"] = TourGuideFrameMixin
local function RoleButton_OnClick(button)
    if(button.checkButton) then
        button.checkButton:SetChecked(not button.checkButton:GetChecked())
    else
        button = button:GetParent()
    end
    if (button.role == "TANK") then
        P["roles"][1] = button.checkButton:GetChecked()
    elseif (button.role == "HEALER") then
        P["roles"][2] = button.checkButton:GetChecked()
    else
        P["roles"][3] = button.checkButton:GetChecked()
    end
    UpdateLFDButton()
end
function TourGuideFrameMixin:OnLoad()
    _G["TomCats-LoveIsInTheAirTourGuideFrameMixin"] = nil
    TourGuideFrame = self
    UIPanelWindows[self:GetName()] = {
        area = "left",
        height = 545,
        pushable = 1,
        whileDead = 1,
        width = 575
    }
    self.portrait:SetTexture("Interface\\AddOns\\TomCats-LoveIsInTheAir\\images\\liith-icon")
    self.portrait:SetTexCoord(0, 1, 0, 1)
    self:SetTitle("TomCat's Tours: Love is in the Air")
    --PortraitFrameTemplate_SetTitle(self, "TomCat's Tours: Love is in the Air");
    self.dungeon.roles.tank.OnClick = RoleButton_OnClick
    self.dungeon.roles.tank.checkButton.onClick = RoleButton_OnClick
    self.dungeon.roles.healer.OnClick = RoleButton_OnClick
    self.dungeon.roles.healer.checkButton.onClick = RoleButton_OnClick
    self.dungeon.roles.dps.OnClick = RoleButton_OnClick
    self.dungeon.roles.dps.checkButton.onClick = RoleButton_OnClick
end
function TourGuideFrameMixin:OnShow()
    if (not P["roles"]) then
        P["roles"] = { select(2,GetLFGRoles()) }
    end
    local tankRole, healerRole, dpsRole = unpack(P["roles"])
    self.dungeon.roles.tank.checkButton:SetChecked(tankRole)
    self.dungeon.roles.healer.checkButton:SetChecked(healerRole)
    self.dungeon.roles.dps.checkButton:SetChecked(dpsRole)
    UpdateLFDButton()
    local doneToday, moneyAmount, moneyVar, experienceGained, experienceVar, numRewards, spellID = GetLFGDungeonRewards(288)
    local message
    if (doneToday) then
        message = "|cff00ff00This character has completed the dungeon|cffffffff\n(since the last daily reset)"
    else
        message = "|cffff0000This character has NOT completed the dungeon|cffffffff\n(since the last daily reset)"
    end
    message = message .. "\n\nComing next update: A list of your characters with the holiday instance status (done or not since last reset)"
    --_G["TomCats-LoveIsInTheAirTourGuidePageNavigationFrame"].description:SetText(message)
    if ("01.00.18" ~= AP["lastVersionSeen"]) then
        AP["lastVersionSeen"] = "01.00.18"
        if (not addon.showUnopenedBoxesAlert) then
            addon.charm.MinimapLoopPulseAnim:Stop()
        end
    end
end
