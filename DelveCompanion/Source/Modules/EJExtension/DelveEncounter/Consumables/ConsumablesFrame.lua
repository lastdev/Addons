local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

---@class (exact) DelveEncounterConsumablesFrame : DelveEncounterConsumablesFrameXml
DelveCompanion_DelveEncounterConsumablesFrameMixin = {}

--- Update consumables with the actual player's state.
---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:UpdateConsumables()
    -- Restored Coffer Keys
    do
        local keysCount = C_CurrencyInfo.GetCurrencyInfo(Config.BOUNTIFUL_KEY_CURRENCY_CODE).quantity
        self.Keys:SetLabelText(keysCount)
        self.Keys.Icon:SetDesaturated(keysCount == 0)
    end

    ---@type EJTierData
    local expansion = GetEJTierData(EJ_GetCurrentTier()).expansionLevel

    -- Coffer Key Shards
    -- TODO: Review it after TWW S3 end.
    do
        ---@type string, number, CurrencyInfo
        local shardsLine, shardsCount, shardsInfo

        if expansion == LE_EXPANSION_WAR_WITHIN then
            self.Shards:SetFrameInfo(DelveCompanion.Definitions.CodeType.Item, Config.KEY_SHARD_ITEM_CODE)
            local macroText = string.format("/use item:%s", Config.KEY_SHARD_ITEM_CODE)
            self.Shards:SetInsecureAction({ type1 = "macro", macrotext = macroText })

            shardsCount = C_Item.GetItemCount(Config.KEY_SHARD_ITEM_CODE)
        elseif expansion == LE_EXPANSION_MIDNIGHT then
            self.Shards:SetFrameInfo(DelveCompanion.Definitions.CodeType.Currency, Config.KEY_SHARDS_CURRENCY_CODE)

            shardsInfo = C_CurrencyInfo.GetCurrencyInfo(Config.KEY_SHARDS_CURRENCY_CODE)
            shardsCount = shardsInfo.quantity
        end

        shardsLine = tostring(shardsCount)
        if shardsCount >= Config.SHARDS_FOR_KEY then
            shardsLine = _G["GREEN_FONT_COLOR"]:WrapTextInColorCode(shardsLine)
            self.Shards.Icon:SetDesaturated(false)
        else
            shardsLine = _G["HIGHLIGHT_FONT_COLOR"]:WrapTextInColorCode(shardsLine)
            self.Shards.Icon:SetDesaturated(self.Shards.frameType == DelveCompanion.Definitions.CodeType.Item and true
                or shardsInfo.quantityEarnedThisWeek >= shardsInfo.maxWeeklyQuantity
            )
        end
        self.Shards:SetLabelText(shardsLine)
    end

    -- Bounty Map
    do
        local mapCode = Config.BOUNTY_MAPS[expansion]

        self.BountyMap:SetFrameInfo(DelveCompanion.Definitions.CodeType.Item, mapCode)
        local macroText = string.format("/use item:%s", mapCode)
        self.BountyMap:SetInsecureAction({ type1 = "macro", macrotext = macroText })

        local mapsCount = C_Item.GetItemCount(mapCode)
        local mapsLine = tostring(mapsCount)

        if mapsCount >= Config.BOUNTY_MAP_MAX_PER_WEEK then
            mapsLine = _G["GREEN_FONT_COLOR"]:WrapTextInColorCode(mapsLine)
            self.BountyMap.Icon:SetDesaturated(false)
        elseif C_QuestLog.IsQuestFlaggedCompleted(Config.BOUNTY_MAP_QUEST) then
            mapsLine = _G["DISABLED_FONT_COLOR"]:WrapTextInColorCode(mapsLine)
            self.BountyMap.Icon:SetDesaturated(true)
        else
            mapsLine = _G["HIGHLIGHT_FONT_COLOR"]:WrapTextInColorCode(mapsLine)
            self.BountyMap.Icon:SetDesaturated(false)
        end
        self.BountyMap:SetLabelText(mapsLine)
    end

    -- Untainted Mana-Crystals
    do
        local crystalsInfo = C_CurrencyInfo.GetCurrencyInfo(Config.MANA_CRYSTALS_CURRENCY_CODE)
        local crystalsCount = crystalsInfo.discovered and crystalsInfo.quantity or 0
        self.ManaCrystals:SetLabelText(crystalsCount)
        self.ManaCrystals.Icon:SetDesaturated(crystalsCount == 0
            and crystalsInfo.quantityEarnedThisWeek >= crystalsInfo.maxWeeklyQuantity)
    end
end

---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:OnLoad()
    -- Logger.Log("DelveEncounterConsumablesFrame OnLoad start")

    local defs = DelveCompanion.Definitions
    self.Keys:SetFrameInfo(defs.CodeType.Currency, Config.BOUNTIFUL_KEY_CURRENCY_CODE)
    self.ManaCrystals:SetFrameInfo(defs.CodeType.Currency, Config.MANA_CRYSTALS_CURRENCY_CODE)
end

---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:OnEvent(event, ...)
    -- Logger.Log("DelveEncounterConsumablesFrame OnEvent start")

    C_Timer.After(0.5, function()
        self:UpdateConsumables()
    end)
end

---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:OnShow()
    -- Logger.Log("DelveEncounterConsumablesFrame OnShow start")

    self:UpdateConsumables()

    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
    self:RegisterEvent("BAG_UPDATE")
end

---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:OnHide()
    -- Logger.Log("DelveEncounterConsumablesFrame OnHide start")

    self:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")
    self:UnregisterEvent("BAG_UPDATE")
end

--#region XML Annotations

--- `DelveCompanionDelveEncounterConsumablesFrameTemplate`
---@class (exact) DelveEncounterConsumablesFrameXml : Frame
---@field Keys CustomActionWidget
---@field Shards CustomActionWidget
---@field BountyMap CustomActionWidget
---@field ManaCrystals CustomActionWidget

--#endregion
