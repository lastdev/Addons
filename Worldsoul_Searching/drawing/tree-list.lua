local ROW_HEIGHT = 20
local DEPTH_OFFSET = 15;

TreeView = {}
TreeView.__index = TreeView

DrawType = {
    congratulations = 1,
    list = 2
}

function TreeView:new(parent, data, name)
    local obj = setmetatable({}, TreeView)
    obj.frame = CreateFrame("Frame", nil, parent)
    obj.frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
    obj.frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)
    obj.frame:SetWidth(parent:GetWidth() - 50)
    obj.frame:SetHeight(0)

    parent:HookScript("OnSizeChanged", function()
        obj.frame:SetWidth(parent:GetWidth() - 50)
    end)

    obj.dataList = data
    obj.name = name

    return obj
end

function TreeView:getFrame()
    return self.frame
end

function TreeView:getName()
    return self.name
end

local function clearTreeView(parent)
    for _, child in ipairs({ parent:GetChildren() }) do
        child:SetParent(nil)
        child:Hide()
        child = nil
    end
end

function TreeView:onToggleClick(node, button)
    self.dataList:toggleColapsed(node.id)
    self:draw()
end

function TreeView:draw()
    local prevRow = nil
    self.dataList:rescanData()
    local dataList = self.dataList:getFlatData()

    clearTreeView(self.frame)

    local drawScene = DrawType.list

    if MetaAchievementConfigurationDB.hideCompleted then
        if #dataList == 0 then
            drawScene = DrawType.congratulations
        end

        local topAchiInfo = { completed = true}
        if dataList[1] then
            topAchiInfo = Achievement:createFromId(dataList[1].id)
        end

        if topAchiInfo.completed then
            drawScene = DrawType.congratulations
        end
    end


    if drawScene == DrawType.congratulations then
        self.frame:SetHeight(150)
        -- actual mount model to come here in future update
        local tmp = CreateFrame("DressUpModel", nil, self.frame)
        tmp:SetPoint("CENTER", self.frame, "CENTER")
        tmp:SetSize(250, 120)
        local text = tmp:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 5, -2)
        text:SetText("Congratulations!!!")
        text:SetScale(3)
    else
        self.frame:SetHeight(#dataList * ROW_HEIGHT)

        -- draw nodes
        for _, node in ipairs(dataList) do
            local row = CreateFrame("Frame", nil, self.frame, "BackdropTemplate")
            row:SetHeight(ROW_HEIGHT)
            row:SetPoint("RIGHT", self.frame, "RIGHT", 0, 0)

            -- Highlight

            local highlight = row:CreateTexture(nil, "HIGHLIGHT")
            highlight:SetAllPoints()
            if MetaAchievementConfigurationDB.colouredHightlight then
                if node.data.completed then
                    highlight:SetColorTexture(0, 1, 0, 0.1) -- semi-transparent gren
                else
                    highlight:SetColorTexture(1, 0, 0, 0.1) -- semi-transparent red
                end

            else
                highlight:SetColorTexture(1, 1, 1, 0.1) -- translucent
            end
            highlight:Hide()

            row:SetScript("OnEnter", function()
                highlight:Show()
            end)

            row:SetScript("OnLeave", function()
                highlight:Hide()
            end)

            -- Prev row shit

            if prevRow then
                row:SetPoint("TOPLEFT", prevRow, "BOTTOMLEFT", 0, 0)
            else
                row:SetPoint("TOPLEFT", self.frame, "TOPLEFT", -5, -5)
            end

            local depthOffset = node.depth * DEPTH_OFFSET

            -- Toggle icon
            if #node.data.children > 0 then
                local toggle = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
                toggle:SetPoint("TOPLEFT", row, "TOPLEFT", depthOffset + 15, 0)
                toggle:SetSize(15, 15)
                local toggleText = node.colapsed and "+" or "-"
                --toggle:SetText(node.data.hasChildren and toggleText)
                toggle:SetText(toggleText)
                toggle.id = node.id

                toggle:SetScript("OnClick", function(frame, button)
                    self:onToggleClick(frame, button)
                end)
            end

            -- Achievement icon
            local achievementButton = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
            achievementButton:SetSize(16, 16)
            achievementButton:SetPoint("TOPLEFT", row, "TOPLEFT", depthOffset + 35, 0)
            achievementButton:SetScript("OnClick", function ()
                OpenAchievementFrameToAchievement(node.id)
            end)

            local achievementIcon = achievementButton:CreateTexture(nil, "ARTWORK")
            achievementIcon:SetAllPoints()
            achievementIcon:SetTexture(node.data.icon)

            -- Text
            local text = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            text:SetPoint("TOPLEFT", achievementIcon, "TOPRIGHT", 5, -2)
            text:SetText(node.data.name)

            -- Completion icon
            local completionIcon = row:CreateTexture(nil, "ARTWORK")
            completionIcon:SetSize(16, 16)
            completionIcon:SetPoint("TOPRIGHT", row, "TOPRIGHT", 0, 0)
            completionIcon:SetTexture(node.completedIcon)
            if not node.data.completed then
                completionIcon:SetVertexColor(1, 0, 0)
            end

            -- Map integration
            if MetaAchievementDB.mapIntegration:HasActiveIntegration() and #node.data:GetFilteredWaypoints() > 0 then
                local mapIntegrationButton = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
                mapIntegrationButton:SetSize(16, 16)
                mapIntegrationButton:SetPoint("TOPRIGHT", completionIcon, "TOPLEFT", 0, 0)

                local mapIntegrationIcon = mapIntegrationButton:CreateTexture(nil, "ARTWORK")
                mapIntegrationIcon:SetAllPoints()
                mapIntegrationIcon:SetTexture("Interface\\Icons\\INV_Misc_Map09")

                mapIntegrationButton:SetScript("OnClick", function()
                    MetaAchievementDB.mapIntegration:ToggleWaypointsForAchievement(node.id, node.data:GetFilteredWaypoints())
                end)
            end

            prevRow = row
        end
    end
end
