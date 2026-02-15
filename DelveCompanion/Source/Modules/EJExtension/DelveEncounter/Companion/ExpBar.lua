local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--- Companion experience bar to display the current level progress.
---@class (exact) JourneyEncounterExpBar : JourneyEncounterExpBarXml
---@field factionID number Faction ID of a Companion to show Exp for.
---@field rankInfo FriendshipReputationRankInfo
---@field repInfo FriendshipReputationInfo
DelveCompanion_JourneyEncounterExpBarMixin = {}

--- Convert total experience gained into the current level progress.
---@param self JourneyEncounterExpBar
---@return number current Exp obtained on this level
---@return number needed Exp required to reach the next level
function DelveCompanion_JourneyEncounterExpBarMixin:GetLevelProgress()
    local repInfo = self.repInfo

    local current = repInfo.standing - repInfo.reactionThreshold
    local needed = repInfo.nextThreshold - repInfo.reactionThreshold

    return current, needed
end

--- Cache experience data.
---@param self JourneyEncounterExpBar
function DelveCompanion_JourneyEncounterExpBarMixin:RefreshExpProgress()
    self.rankInfo = C_GossipInfo.GetFriendshipReputationRanks(self.factionID)
    self.repInfo = C_GossipInfo.GetFriendshipReputation(self.factionID)
end

---@param self JourneyEncounterExpBar
function DelveCompanion_JourneyEncounterExpBarMixin:OnLoad()
    -- Logger.Log("[JourneyEncounterExpBar] OnLoad start")

    self:SetStatusBarColor(_G["FACTION_GREEN_COLOR"]:GetRGB())
    self:SetFrameStrata("HIGH")
end

---@param self JourneyEncounterExpBar
function DelveCompanion_JourneyEncounterExpBarMixin:OnShow()
    -- Logger.Log("[JourneyEncounterExpBar] OnShow start")

    self:RefreshExpProgress()
    local companionRankInfo = self.rankInfo

    ---@type number
    local barValue = 1
    local barText = format(_G["LEVEL_GAINED"], companionRankInfo.currentLevel)

    if companionRankInfo.currentLevel < companionRankInfo.maxLevel then
        local current, needed = self:GetLevelProgress()
        barValue = current / needed
    else
        barText = format("%s (%s)", barText, _G["GUILD_RECRUITMENT_MAXLEVEL"])
    end

    self:SetValue(barValue)
    self.BarText:SetText(barText)
end

---@param self JourneyEncounterExpBar
function DelveCompanion_JourneyEncounterExpBarMixin:OnEnter()
    -- Logger.Log("[JourneyEncounterExpBar] OnEnter start")

    local tooltip = GameTooltip
    tooltip:SetOwner(self, "ANCHOR_TOP")

    -- GameTooltip_AddWidgetSet(GameTooltip, Constants.DelvesConsts.DELVES_COMPANION_TOOLTIP_WIDGET_SET_ID)

    local rankInfo = self.rankInfo
    local repInfo = self.repInfo
    local wrapText = true

    if rankInfo.maxLevel > 0 then
        GameTooltip_SetTitle(tooltip,
            format("%s (%d / %d)", repInfo.name, rankInfo.currentLevel, rankInfo.maxLevel),
            HIGHLIGHT_FONT_COLOR)
    else
        GameTooltip_SetTitle(tooltip, repInfo.name, HIGHLIGHT_FONT_COLOR)
    end

    ReputationUtil.TryAppendAccountReputationLineToTooltip(tooltip, self.factionID)

    GameTooltip_AddBlankLineToTooltip(tooltip)
    GameTooltip_AddNormalLine(tooltip, repInfo.text, wrapText)
    if repInfo.nextThreshold then
        local current, needed = self:GetLevelProgress()
        GameTooltip_AddHighlightLine(tooltip,
            format("%s (%d / %d)", repInfo.reaction, current, needed),
            wrapText)
    else
        GameTooltip_AddHighlightLine(tooltip, repInfo.reaction, wrapText)
    end

    tooltip:Show()
end

---@param self JourneyEncounterExpBar
function DelveCompanion_JourneyEncounterExpBarMixin:OnLeave()
    -- Logger.Log("[JourneyEncounterExpBar] OnLeave start")

    GameTooltip:Hide()
end

--#region XML Annotations

--- `DelveCompanionJourneyEncounterExpBarTemplate`
---@class (exact) JourneyEncounterExpBarXml : StatusBar
---@field Background Texture
---@field BarText FontString

--#endregion
