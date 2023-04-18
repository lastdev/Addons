DFH_FactionInfo = {
  title = "",
  detail = "",
  name = "",
  description = "",
  standingId = 0,
  barMin = 0,
  barMax = 0,
  barValue = 0,
  atWarWith = false,
  canToggleAtWar = false,
  isHeader = false,
  isCollapsed = false,
  hasRep = false,
  isWatched = false,
  isChild = false,
  factionId = 0,
  hasBonusRepGain = false,
  canSetInactive = false,
  renownLevel = 0
}

function DFH_FactionInfo:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function DFH_FactionInfo:init(factionId)
  local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed,
  hasRep, isWatched, isChild, factionID, hasBonusRepGain, canSetInactive = GetFactionInfoByID(factionId)

  self.name = name
  self.title = name
  self.description = description
  self.standingId = standingID
  self.barMin = barMin
  self.barMax = barMax
  self.barValue = barValue
  self.atWarWith = atWarWith
  self.canToggleAtWar = canToggleAtWar
  self.isHeader = isHeader
  self.isCollapsed = isCollapsed
  self.hasRep = hasRep
  self.isWatched = isWatched
  self.isChild = isChild
  self.factionId = factionID
  self.hasBonusRepGain = hasBonusRepGain
  self.canSetInactive = canSetInactive

  self:update()
end

function DFH_FactionInfo:isMajorFaction()
  return self.factionId and C_Reputation.IsMajorFaction(self.factionId)
end

function DFH_FactionInfo:isFriendFaction()
  self.friendshipFactionData = self.factionId and C_GossipInfo.GetFriendshipReputation(self.factionId)

  return self.friendshipFactionData and self.friendshipFactionData.friendshipFactionID > 0
end

function DFH_FactionInfo:getFriendshipFactionId()
  return self.friendshipFactionData.friendshipFactionID
end

function DFH_FactionInfo:getFactionColor()
  if self:isFriendFaction() then
    return FACTION_BAR_COLORS[self.standingId]
  else
    return BLUE_FONT_COLOR
  end
end

function DFH_FactionInfo:update()
  if self:isFriendFaction() then
    self.detail = self.friendshipFactionData.reaction

    if self.friendshipFactionData.nextThreshold then
      self.barMin = self.friendshipFactionData.reactionThreshold
      self.barMax = self.friendshipFactionData.nextThreshold
      self.barValue = self.friendshipFactionData.standing
    else
      self.barMin = 0
      self.barMax = 1
      self.barValue = 1
    end
  elseif self:isMajorFaction() then
    self.majorFactionData = C_MajorFactions.GetMajorFactionData(self.factionId)

    self.barMin = 0
    self.barMax = self.majorFactionData.renownLevelThreshold

    local isCapped = C_MajorFactions.HasMaximumRenown(self.factionId)

    self.barValue = isCapped and self.majorFactionData.renownLevelThreshold or
        self.majorFactionData.renownReputationEarned or 0

    self.detail = RENOWN_LEVEL_LABEL .. self.majorFactionData.renownLevel
  end
end
