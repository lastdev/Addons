ROW_HEIGHT = 30

SettingsFrame = {}
SettingsFrame.__index = SettingsFrame

function SettingsFrame:new(parent)
    local obj = setmetatable({}, SettingsFrame)

    obj.frame = CreateFrame("Frame", nil, parent)
    obj.frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
    obj.frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)
    obj.frame:SetWidth(parent:GetWidth() - 50)

    obj.checkBoxes = {}

    obj:draw()

    return obj
end

function SettingsFrame:getName()
    return "Settings"
end

local function clearTreeView(parent)
    for _, child in ipairs({ parent:GetChildren() }) do
        child:SetParent(nil)
        child:Hide()
        child = nil
    end
end

function SettingsFrame:draw()
    clearTreeView(self.frame)
    self.checkBoxes = {}
    self:registerOptions()

    self.frame:SetHeight(#self.checkBoxes * ROW_HEIGHT)
end

function SettingsFrame:registerOptions()
    self:addOption("Hide completed", "hideCompleted", "If checked, completed achievements will be hidden, unless they have uncompleted sub-achievements")
    self:addOption("Coloured highlight", "colouredHightlight", "If checked, hovering on achievement will be green/red, depending on wheter achievement is completed")

    -- Only display waypoint options, if map integration is active
    if MetaAchievementDB.mapIntegration:HasActiveIntegration() then
        self:addOption("Remove waypoints for completed achievements", "removeCompletedWaypoints", "")
        self:addOption("Add waypoints only to unfinished parts of achievement", "addWpsOnlyForUncompletedAchis", "")
    end
end

function SettingsFrame:addOption(title, storageIndex, hint)
    hint = hint or title

    local row = CreateFrame("Frame", nil, self.frame, "BackdropTemplate")
    row:SetHeight(ROW_HEIGHT)
    row:SetPoint("RIGHT", self.frame, "RIGHT", 0, 0)

    if #self.checkBoxes > 0 then
        row:SetPoint("TOPLEFT", self.checkBoxes[#self.checkBoxes], "BOTTOMLEFT", 0, 0)
    else
        row:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
    end

    local checkBox = CreateFrame("CheckButton", nil, row, "InterfaceOptionsCheckButtonTemplate")
    checkBox:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
    checkBox:SetChecked(MetaAchievementConfigurationDB[storageIndex])

    checkBox:SetScript("OnClick", function(element)
        MetaAchievementConfigurationDB[storageIndex] = element:GetChecked()
    end)

    local label = checkBox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", checkBox, "RIGHT", 5, 0)
    label:SetText(title)

    self.checkBoxes[#self.checkBoxes+1] = row
end

function SettingsFrame:getFrame()
    return self.frame
end
