local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

--#region Constants

--#endregion

--- Compose a text with the amount of collected currency
---@param collected integer
---@param max integer
---@return string
local function GetCollectedText(collected, max)
    local wrapColor = collected ~= max
        and _G["GREEN_FONT_COLOR"]
        or _G["WHITE_FONT_COLOR"]

    local text = wrapColor:WrapTextInColorCode(
        format(_G["GENERIC_FRACTION_STRING"], collected, max))

    return text
end

--- Compose consumable info text for a tooltip
---@param quality Enum.ItemQuality
---@param name string
---@param text string
---@param textureId integer
---@return string weekText Consumable this week text
---@return string info Collected amount text
local function GetCollectedInfo(quality, name, text, textureId)
    local weekText = strtrim(format(_G["CURRENCY_THIS_WEEK"],
        string.join("", ITEM_QUALITY_COLORS[quality].hex, name, "|r")
    ))

    local info = string.join("", text, " |T", textureId, ":20|t")

    return weekText, info
end

--- Compose a locale for [Delver's Bounty](https://www.wowhead.com/item=233071/delvers-bounty) looted this week.
---@return string # Composed locale.
local function GetMapInfoText()
    local collectedCount = 0
    if C_QuestLog.IsQuestFlaggedCompleted(Config.BOUNTY_MAP_QUEST) then
        collectedCount = 1
    end

    local weekText = strtrim(format(_G["CURRENCY_THIS_WEEK"], ""))
    local mapAmountText = GetCollectedText(collectedCount, Config.BOUNTY_MAP_MAX_PER_WEEK)

    local mapInfoText = format("%s%s", _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(weekText .. ": "), mapAmountText)

    return mapInfoText
end

--- Helper function to parse a toltip and find a matching line by the pattern.
---@param tooltip GameTooltip
---@param matchPattern string
---@return FontString|nil # The matching line, or `nil` if no matching line is found.
local function FindLineInTooltip(tooltip, matchPattern)
    for i = 1, tooltip:NumLines(), 1 do
        ---@type FontString
        local line = _G["GameTooltipTextLeft" .. i]
        if line and line:GetText() and strmatch(line:GetText(), matchPattern) then
            return line
        end
    end

    return nil
end

--- Post Call for a `GameTooltip` of type `Enum.TooltipDataType.Currency`. Used to add additional lines into the tooltip.
---@param tooltipDataHandler any [TooltipDataHandlerMixin](https://www.townlong-yak.com/framexml/live/Blizzard_SharedXMLGame/TooltipDataHandler.lua#189).
---@param ... any
local function TooltipPostCallCurrency(tooltipDataHandler, ...)
    if not DelveCompanionCharacterData.keysCapTooltipEnabled then
        return
    end

    local tooltipId = tooltipDataHandler:GetPrimaryTooltipData().id
    if tooltipId == Config.BOUNTIFUL_KEY_CURRENCY_CODE then
        local lineToMatch = format(_G["CURRENCY_TOTAL"], "", "%s*(.+)")
        local line = FindLineInTooltip(tooltipDataHandler, lineToMatch)

        if line then
            local weekText = strtrim(format(_G["CURRENCY_THIS_WEEK"], Lockit.UI_BOUNTIFUL_KEYS_COUNT_CACHES_PREFIX))
            local keysInfoText = format("%s%s", _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(weekText .. ": "),
                GetCollectedText(DelveCompanion.Variables.keysCollected, #Config.BOUNTIFUL_KEY_QUESTS_DATA))

            local text = format(line:GetText() .. "\n" .. "%s", keysInfoText)
            line:SetText(text)
        end
    end
end

--- Post Call for a `GameTooltip` of type `Enum.TooltipDataType.Item`. Used to add additional lines into the tooltip.
---@param tooltipDataHandler any [TooltipDataHandlerMixin](https://www.townlong-yak.com/framexml/live/Blizzard_SharedXMLGame/TooltipDataHandler.lua#189).
---@param ... any
local function TooltipPostCallItem(tooltipDataHandler, ...)
    if not DelveCompanionCharacterData.keysCapTooltipEnabled then
        return
    end

    local tooltipId = tooltipDataHandler:GetPrimaryTooltipData().id
    if tContains(Config.BOUNTY_MAPS, tooltipId) then
        local lineToMatch = _G["ITEM_UNIQUE"]
        local line = FindLineInTooltip(tooltipDataHandler, lineToMatch)

        if line then
            local text = format(line:GetText() .. "\n%s", GetMapInfoText())
            line:SetText(text)
        end
    elseif tContains(Config.BOUNTIFUL_KEY_SOURCE_CACHES_DATA, tooltipId) then
        local keyCurrInfo = C_CurrencyInfo.GetCurrencyInfo(Config.BOUNTIFUL_KEY_CURRENCY_CODE)

        local weekText, collectedInfo = GetCollectedInfo(Enum.ItemQuality.Epic, keyCurrInfo.name,
            GetCollectedText(DelveCompanion.Variables.keysCollected, #Config.BOUNTIFUL_KEY_QUESTS_DATA),
            keyCurrInfo.iconFileID)

        GameTooltip_AddBlankLineToTooltip(tooltipDataHandler)
        GameTooltip_AddColoredDoubleLine(tooltipDataHandler,
            weekText, collectedInfo,
            _G["NORMAL_FONT_COLOR"], _G["NORMAL_FONT_COLOR"],
            true)
    elseif tContains(Config.KEY_SHARD_SOURCE_CACHES_DATA, tooltipId) then
        local keyShardInfo = Item:CreateFromItemID(Config.KEY_SHARD_ITEM_CODE)

        keyShardInfo:ContinueOnItemLoad(function()
            local weekText, collectedInfo = GetCollectedInfo(Enum.ItemQuality.Rare, keyShardInfo:GetItemName(),
                GetCollectedText(DelveCompanion.Variables.shardsCollected,
                    #Config.BOUNTIFUL_KEY_QUESTS_DATA * DelveCompanion.Config.KEY_SHARDS_PER_CACHE),
                keyShardInfo:GetItemIcon())

            GameTooltip_AddBlankLineToTooltip(tooltipDataHandler)
            GameTooltip_AddColoredDoubleLine(tooltipDataHandler,
                weekText, collectedInfo,
                _G["NORMAL_FONT_COLOR"], _G["NORMAL_FONT_COLOR"],
                true)
        end)
    end
end

function DelveCompanion_TooltipExtension_Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Currency, TooltipPostCallCurrency)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, TooltipPostCallItem)

    EventRegistry:RegisterFrameEventAndCallback("QUEST_LOG_UPDATE", function()
        DelveCompanion:CacheCollectedConsumables()
    end)
end
