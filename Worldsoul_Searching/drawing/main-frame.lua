MainFrame = {}
MainFrame.__index = MainFrame

DEFAULT_FRAME_HEIGHT = 200
DEFAULT_FRAME_WIDTH = 300
DEFAULT_POSITION_X = 0
DEFAULT_POSITION_Y = 0
DEFAULT_FRAME_ANCHOR = "CENTER"

local LDB = LibStub:GetLibrary("LibDataBroker-1.1")
local DBIcon = LibStub("LibDBIcon-1.0")

local function refrestAchievementsLists()
    for _, achilist in pairs(MetaAchievementDB.achievementLists) do
        if type(achilist.data.rescanData) == "function" and type(achilist.treeView.draw) == "function" then
            achilist.data:rescanData()
            achilist.treeView:draw() -- most likely not needed
        end
    end
end

function MainFrame:new()
    local obj = setmetatable({}, MainFrame)

    obj.mainFrame = {}
    obj.resizeButton = {}
    obj.settingsButton = {}
    obj.scrollBar = {}
    obj.scrollBarChildren = {}
    obj.drawnScrollElement = nil
    obj.tabAnchor = {}
    obj.achievementTabs = {}

    obj.previousDrawnElement = nil
    obj.onEventHandlers = {}

    obj:createMainFrame()
    obj:createMinimapButton()
    obj:createResizeButton()
    obj:createSettingsButton()
    obj:registerEvents()
    obj:createScrollBar()
    obj:createTabAnchor()

    return obj
end

function MainFrame:createMainFrame()
    self.mainFrame = CreateFrame("Frame", "MetaAchievementsTracker", UIParent, "BasicFrameTemplateWithInset")
    self.mainFrame:SetSize(DEFAULT_FRAME_WIDTH, DEFAULT_FRAME_HEIGHT)
    self.mainFrame:SetResizeBounds(DEFAULT_FRAME_WIDTH, DEFAULT_FRAME_HEIGHT)
    self.mainFrame:SetPoint(DEFAULT_FRAME_ANCHOR, DEFAULT_POSITION_X, DEFAULT_POSITION_Y)
    self.mainFrame:SetMovable(true)
    self.mainFrame:SetResizable(true)
    self.mainFrame:EnableMouse(true)
    self.mainFrame:EnableMouseWheel(true)
    self.mainFrame:RegisterForDrag("LeftButton")
    self.mainFrame:SetScript("OnDragStart", self.mainFrame.StartMoving)
    self.mainFrame:SetScript("OnDragStop", self.mainFrame.StopMovingOrSizing)
    self.mainFrame:SetFrameStrata("TOOLTIP")

    self.mainFrame.title = self.mainFrame:CreateFontString(nil, "OVERLAY")
    self.mainFrame.title:SetFontObject("GameFontHighlight")
    self.mainFrame.title:SetPoint("LEFT", self.mainFrame.TitleBg, "LEFT", 5, 0)
end

function MainFrame:resetFrame()
    MetaAchievementConfigurationDB.mainFrame.closed = false
    MetaAchievementConfigurationDB.mainFrame.height = DEFAULT_FRAME_HEIGHT
    MetaAchievementConfigurationDB.mainFrame.width = DEFAULT_FRAME_WIDTH
    MetaAchievementConfigurationDB.mainFrame.anchor = DEFAULT_FRAME_ANCHOR
    MetaAchievementConfigurationDB.mainFrame.x = DEFAULT_POSITION_X
    MetaAchievementConfigurationDB.mainFrame.y = DEFAULT_POSITION_Y

    self:onFrameLoaded()
end

function MainFrame:createTabAnchor()
    self.tabAnchor = CreateFrame("Button", nil, self.mainFrame, "BackdropTemplate")
    self.tabAnchor:SetPoint("TOPRIGHT", self.mainFrame, "TOPLEFT", 0, 0)
    self.tabAnchor:SetSize(38, 22)
end

function MainFrame:AddAchievementTab(tabReference, icon)
    self.achievementTabs[#self.achievementTabs+1] = {
        tabReference = tabReference,
        icon = icon
    }
end

function MainFrame:drawAchievementTabs()
    local prevTab = self.tabAnchor

    for i, tabInfo in pairs(self.achievementTabs) do
        local tab = CreateFrame("Button", nil, self.tabAnchor, "UIPanelButtonTemplate")
        tab:SetPoint("TOPLEFT", prevTab, "BOTTOMLEFT", 0, -2)
        tab:SetSize(36, 36)
        local icon = tab:CreateTexture(nil, "ARTWORK")
        icon:SetAllPoints()
        icon:SetTexture(tabInfo.icon)

        tab:SetScript("OnClick", function()
            self:drawScrollContent(tabInfo.tabReference)
        end)

        prevTab = tab
    end
end

function MainFrame:RegisterOnEventHander(eventName, arg1Check, callback)
    self.onEventHandlers[#self.onEventHandlers+1] = {
        eventName = eventName,
        arg1Check = arg1Check,
        callback = callback
    }
end

function MainFrame:onFrameLoaded()
    if MetaAchievementConfigurationDB.mainFrame.height and MetaAchievementConfigurationDB.mainFrame.width then
        self.mainFrame:SetSize(
            MetaAchievementConfigurationDB.mainFrame.width,
            MetaAchievementConfigurationDB.mainFrame.height
        )
    end

    if MetaAchievementConfigurationDB.mainFrame.x
        and MetaAchievementConfigurationDB.mainFrame.y
        and MetaAchievementConfigurationDB.mainFrame.anchor
    then
        self.mainFrame:ClearAllPoints()
        self.mainFrame:SetPoint(
            MetaAchievementConfigurationDB.mainFrame.anchor,
            MetaAchievementConfigurationDB.mainFrame.x,
            MetaAchievementConfigurationDB.mainFrame.y
        )
    end

    self:drawAchievementTabs()

    if MetaAchievementConfigurationDB.mainFrame.closed then
        self.mainFrame:Hide()
    end
end

function MainFrame:ChangeTitle(name)
    name = name or ""
    self.mainFrame.title:SetText("Meta Achievements Tracker - " .. name)
end

function MainFrame:registerEvents()
    self.mainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.mainFrame:RegisterEvent("ACHIEVEMENT_EARNED")
    self.mainFrame:RegisterEvent("ADDON_LOADED")

    self:RegisterOnEventHander(
        "PLAYER_ENTERING_WORLD",
        nil,
        function ()
            refrestAchievementsLists()
        end
    )

    self:RegisterOnEventHander(
        "ACHIEVEMENT_EARNED",
        nil,
        function ()
            refrestAchievementsLists()
        end
    )

    self:RegisterOnEventHander(
        "ADDON_LOADED",
        "Worldsoul_Searching",
        function()
            UpdateSettings()
            EntryPoint()
            self:onFrameLoaded()
        end
    )

    self.mainFrame:SetScript("OnHide", function () 
        MetaAchievementConfigurationDB.mainFrame.closed = true
    end)

    self.mainFrame:SetScript("OnShow", function () 
        MetaAchievementConfigurationDB.mainFrame.closed = false
    end)

    self.mainFrame:SetScript("OnSizeChanged", function (element, width, height)
        MetaAchievementConfigurationDB.mainFrame.width = width
        MetaAchievementConfigurationDB.mainFrame.height = height
    end)

    self.mainFrame:SetScript("OnDragStop", function (element)
        element:StopMovingOrSizing()
        local point, _, _, x, y = element:GetPoint()

        MetaAchievementConfigurationDB.mainFrame.anchor = point
        MetaAchievementConfigurationDB.mainFrame.x = x
        MetaAchievementConfigurationDB.mainFrame.y = y
    end)

    self.mainFrame:SetScript("OnEvent", function(element, event, arg1)
        for _, registeredEvent in pairs(self.onEventHandlers) do
            if registeredEvent.eventName == event then
                if registeredEvent.arg1Check == arg1
                    or registeredEvent.arg1Check == nil
                then
                    registeredEvent.callback(element, event, arg1)
                end
            end
        end
    end)
end

function MainFrame:toggleVisibility()
    if self.mainFrame:IsShown() then
        self.mainFrame:Hide()
    else
        self.mainFrame:Show()
    end
end

function MainFrame:hideWindow()
    if self.mainFrame:IsShown() then
        self.mainFrame:Hide()
    end
end

function MainFrame:showWindow()
    if not self.mainFrame:IsShown() then
        self.mainFrame:Show()
    end
end

function MainFrame:createMinimapButton()
    local iconObject = LDB:NewDataObject("MetaAchievementsTracker", {
        type = "launcher",
        icon = "Interface\\Icons\\achievement_zone_isleofdorn",
        OnClick = function(element, button)
            if button == "LeftButton" then
                self:toggleVisibility()
            end
            if button == "RightButton" then
                refrestAchievementsLists()
            end
            if button == "MiddleButton" then
                self:resetFrame()
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("Meta Achievements Tracker")
            tooltip:AddLine("Left-click to toggle visibility.")
            tooltip:AddLine("Right-click to manually refresh achievements.")
        end,
    })
    DBIcon:Register("MetaAchievementsTracker", iconObject, MetaAchievementDB.minimap)
end

function MainFrame:createSettingsButton()
    self.settingsButton = CreateFrame("Button", nil, self.mainFrame, "UIPanelButtonTemplate")
    self.settingsButton:SetSize(24, 24)
    self.settingsButton:SetPoint("TOPRIGHT", self.mainFrame, "TOPRIGHT", -24, 1)

    local icon = self.settingsButton:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("CENTER", self.settingsButton, "CENTER")
    icon:SetTexture("Interface\\Buttons\\UI-OptionsButton")

    self.settingsButton:SetScript("OnClick", function()
        if self.drawnScrollElement == WindowTabs.settings then
            self:drawScrollContent(self.previousDrawnElement)
        else
            self.previousDrawnElement = self.drawnScrollElement
            self:drawScrollContent(WindowTabs.settings)
        end
    end)
end

function MainFrame:createResizeButton()
    self.resizeButton = CreateFrame("Button", nil, self.mainFrame)
    self.resizeButton:SetSize(16, 16)
    self.resizeButton:SetPoint("BOTTOMRIGHT", self.mainFrame, "BOTTOMRIGHT", -4, 4)
    self.resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    self.resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    self.resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

    self.resizeButton:SetScript("OnMouseDown", function(element, button)
        if button == "LeftButton" then
            self.mainFrame:StartSizing("BOTTOMRIGHT")
            self.mainFrame:SetUserPlaced(true)
        end
    end)

    self.resizeButton:SetScript("OnMouseUp", function(element, button)
        self.mainFrame:StopMovingOrSizing()
    end)
end

function MainFrame:createScrollBar()
    self.scrollBar = CreateFrame("ScrollFrame", nil, self.mainFrame, "UIPanelScrollFrameTemplate")
    self.scrollBar:SetPoint("TOPLEFT", self.mainFrame, "TOPLEFT", 10, -30)
    self.scrollBar:SetPoint("BOTTOMRIGHT", self.mainFrame, "BOTTOMRIGHT", -35, 20)
end

function MainFrame:getFrame()
    return self.mainFrame
end

function MainFrame:addScrollChild(name, scrollChild)
    self.scrollBarChildren[name] = scrollChild
    self.scrollBarChildren[name]:getFrame():Hide()
end

function MainFrame:drawScrollContent(name)
    if self.drawnScrollElement then
        self.scrollBarChildren[self.drawnScrollElement]:getFrame():Hide()
    end
    self.drawnScrollElement = name

    self.scrollBar:SetScrollChild(self.scrollBarChildren[name]:getFrame())
    self.scrollBarChildren[name]:draw()
    self.scrollBarChildren[name]:getFrame():Show()
    self:ChangeTitle(self.scrollBarChildren[name]:getName())
end
