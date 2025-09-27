Legolando_CheckboxMixin_AngleurUnderlight = {};

function Legolando_CheckboxMixin_AngleurUnderlight:greyOut()
    self:SetChecked(false)
    self:Disable()
    self.text:SetTextColor(0.9, 0.9, 0.9)
    self.disabledText:Show()
    if self.dropDown then
        self.dropDown:Hide()
    end
end

function Legolando_CheckboxMixin_AngleurUnderlight:reposition()
    local width, height = self.text:GetSize()
    self.text:ClearAllPoints()
    self.text:SetPoint("RIGHT", self, "LEFT")
    self.disabledText:SetPoint("LEFT", self, "RIGHT")
    local _, _, _, offsetX, offsetY = self:GetPoint()
    self:AdjustPointsOffset(width, 0)
end

function Legolando_CheckboxMixin_AngleurUnderlight:OnClick()
    local grandParent = self:GetParent()
    local teeburu = grandParent.savedVarTable
    if not self.reference then 
        print("no checkbox reference string")
        return
    end
    if not teeburu then 
        print("no saved variable table attached")
        return 
    end
    if teeburu[self.reference] == nil then
        print("checkbox reference not found in saved variable table")
        return
    end
    if self:GetChecked() then
        teeburu[self.reference] = true
    elseif self:GetChecked() == false then
        teeburu[self.reference] = false
    end
end

Legolando_CheckboxesMixin_AngleurUnderlight = {}

function Legolando_CheckboxesMixin_AngleurUnderlight:Update()
    local teeburu = self.savedVarTable
    if not teeburu then
        print("checkbox parent doesn't have a saved variable table attached")
        return
    end
    local children = {self:GetChildren()}
    for i, child in pairs(children) do
        if child:GetObjectType() == "CheckButton" and child.reference then
            local savedVar = teeburu[child.reference]
            if savedVar then
                if savedVar == true then
                    child:SetChecked(true)
                elseif savedVar == false then
                    child:SetChecked(false)
                end
            end
        end
    end
end