local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

---@class DelveOBotWidget : DelveOBotWidgetXml
DelveCompanion_DelveOBotWidgetMixin = {}

local widgetEvents = {
    "NEW_TOY_ADDED",
    "SPELL_UPDATE_COOLDOWN"
}

function DelveCompanion_DelveOBotWidgetMixin:UpdateState()
    if PlayerHasToy(self.frameCode) then
        self.CollectedBorder:Show()
        self.Icon:SetDesaturated(false)
    else
        self.CollectedBorder:Hide()
        self.Icon:SetDesaturated(true)

        self:RegisterEvent("NEW_TOY_ADDED")
    end

    self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
end

function DelveCompanion_DelveOBotWidgetMixin:OnEvent(event, ...)
    if event == "NEW_TOY_ADDED" then
        self:UpdateState()
    elseif event == "SPELL_UPDATE_COOLDOWN" then
        self:UpdateCooldown()
    end
end

function DelveCompanion_DelveOBotWidgetMixin:OnLoad()
    -- Logger.Log("DelveOBotWidget OnLoad start")

    DelveCompanion_CustomActionWidgetMixin.OnLoad(self)

    self:SetFrameInfo(DelveCompanion.Definitions.CodeType.Toy, DelveCompanion.Config.DELVE_O_BOT_ITEM_CODE)
    local macroText = string.format("/use item:%s", self.frameCode)
    self:SetInsecureAction({ type1 = "macro", macrotext = macroText })
end

function DelveCompanion_DelveOBotWidgetMixin:OnShow()
    -- Logger.Log("DelveOBotWidget OnShow start")

    DelveCompanion_CustomActionWidgetMixin.OnShow(self)
    self.InteractionBlockedOverlay:SetShown(IsIndoors())
    self:UpdateState()
end

function DelveCompanion_DelveOBotWidgetMixin:OnHide()
    -- Logger.Log("DelveOBotWidget OnShow start")

    FrameUtil.UnregisterFrameForEvents(self, widgetEvents)
    DelveCompanion_CustomActionWidgetMixin.OnHide(self)
end

--#region Xml annotations

--- `DelvelCompanionDelveOBotWidgetTemplate`
---@class DelveOBotWidgetXml : CustomActionWidget
---@field CollectedBorder Texture
--#endregion
