local addonName, addon = ...
local TCL = addon.TomCatsLibs
local TourGuideFrame = _G["TomCats-HivemindTourGuideFrame"]
DEBUGTOURGUIDE = TourGuideFrame
local invitationShown = false
local pages = TCL.Data["Pages"]
local chapters = TCL.Data["Chapters"]
local links = TCL.Data["Links"]
local currentChapter = 1
local currentPage = 1
local CHAPTER_NUMBER = "Chapter %d"
local arrow

function TourGuideFrame.toggle()
    if (not invitationShown) then
        invitationShown = true
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000=================================================================|r")
        DEFAULT_CHAT_FRAME:AddMessage("Thank you for installing TomCat's Tours: The Hivemind!")
        DEFAULT_CHAT_FRAME:AddMessage("If you would like to join us to chat during this work in progress,")
        DEFAULT_CHAT_FRAME:AddMessage("click one of the links: |cff82c5ff|HclubTicket:ZKYwrakh2RE|h[Americas]|h|r    |cff82c5ff|HclubTicket:vX0rJ5SYY4|h[Europe]|h|r    |cff82c5ff|HclubTicket:4kJRd0sNYm|h[Asia]|h|r")
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000=================================================================|r")
    end
    if (TourGuideFrame:IsShown()) then
        HideUIPanel(TourGuideFrame)
    else
        ShowUIPanel(TourGuideFrame)
        TourGuideFrame.chapterButtons["button" .. currentChapter]:SetChecked(true)
    end
end

local function ADDON_LOADED(_, event, ...)
    local var1 = select(1, ...)
    if (var1 == addon.name) then
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        UIPanelWindows["TomCats-HivemindTourGuideFrame"] = UIPanelWindows["SpellBookFrame"]
        TourGuideFrame.portrait:SetTexture("Interface\\AddOns\\" .. addon.name .. "\\images\\hivemind-icon");
        TourGuideFrame.portrait:SetTexCoord(0, 1, 0, 1);
        TourGuideFrame:SetTitle("TomCat's Tours: The Hivemind");
        ButtonFrameTemplate_HideButtonBar(TourGuideFrame);
        ButtonFrameTemplate_HideAttic(TourGuideFrame);
        TourGuideFrame.pageNavigationFrame.nextPageButton:SetScript("OnClick", TourGuideFrame.nextPage)
        TourGuideFrame.pageNavigationFrame.prevPageButton:SetScript("OnClick", TourGuideFrame.prevPage)
        TourGuideFrame.pageNavigationFrame.pageText:SetFormattedText(CHAPTER_NUMBER .. ", " .. PAGE_NUMBER, currentChapter, currentPage)
        TourGuideFrame.content:SetText(pages[currentChapter][currentPage].content);
        TourGuideFrame.pageNavigationFrame.prevPageButton:Disable()
        TourGuideFrame.pageNavigationFrame.nextPageButton:Disable()
        TourGuideFrame.content:SetScript("OnHyperlinkClick",TourGuideFrame.hyperlink)
        for i = 1, #pages do
            local tab = TourGuideFrame.chapterButtons["button" .. i]
            tab.tooltip = chapters[i].title
            tab:SetNormalTexture(chapters[i].icon)
            if (chapters[i].color) then
    --            local colorTexture = tab:CreateTexture(nil, "OVERLAY")
                local texture = tab:GetNormalTexture();
                texture:SetDesaturated(true);
                texture:SetVertexColor(chapters[i].color.r, chapters[i].color.g, chapters[i].color.b, chapters[i].color.a)
  --              colorTexture:SetAllPoints(tab);
--                colorTexture:SetColorTexture()
            end
            tab:SetScript("OnClick", TourGuideFrame.gotoChapter)
            tab:Show()
            if (i == 1) then
                TourGuideFrame.gotoChapter(tab, true)
            end
        end
        arrow = TCL.Arrows:CreateArrow("ORANGERED")
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

local lastWaypoint;

function TourGuideFrame.hyperlink(self, href)
    local link = links[href]
    if (link.type == "gotoPage") then
        TourGuideFrame.gotoChapter(TourGuideFrame.chapterButtons["button" .. link.chapter])
        TourGuideFrame.gotoPage(link.page)
    elseif (link.type == "coordinates") then
        if (TomTom) then
            if (lastWaypoint) then
                TomTom:RemoveWaypoint(lastWaypoint)
            end
            lastWaypoint = TomTom:AddWaypoint(link.mapID, link.x, link.y, {
                title = href,
                persistent = nil,
                minimap = true,
                world = true,
                cleardistance = 2
            })
        else
            arrow:SetTarget(link, link.mapID)
        end
    end
end

TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)