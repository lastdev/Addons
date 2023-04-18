DFH_FriendMixin = CreateFromMixins(DFH_ReputationItemMixin)

function DFH_FriendMixin:Init()
  DFH_ReputationItemMixin.Init(self)

  self.factionInfo = DFH_FactionInfo:new()
  self.factionInfo:init(self.factionId)

  local color = self.factionInfo:getFactionColor()
  self:SetForegroundColor(color.r, color.g, color.b, 1)
  self:Update()

  self.enterCallback = function()
    self:ShowFriendshipReputationTooltip()
  end

  self.leaveCallback = function()
    GameTooltip:Hide()
  end
end

function DFH_FriendMixin:ShowFriendshipReputationTooltip()
  if not self.factionInfo then
    return
  end

  if (
      self.factionInfo.friendshipFactionData and
      self.factionInfo.friendshipFactionData.friendshipFactionID and
      self.factionInfo.friendshipFactionData.friendshipFactionID > 0) then
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");

    local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(
      self.factionInfo.friendshipFactionData.friendshipFactionID
    )
    if (rankInfo.maxLevel > 0) then
      GameTooltip:SetText(
        self.factionInfo.friendshipFactionData.name .. " (" .. rankInfo.currentLevel .. " / " ..
        rankInfo.maxLevel .. ")", 1, 1, 1
      )
    else
      GameTooltip:SetText(self.factionInfo.friendshipFactionData.name, 1, 1, 1)
    end

    GameTooltip:AddLine(self.factionInfo.friendshipFactionData.text, nil, nil, nil, true)

    if (self.factionInfo.friendshipFactionData.nextThreshold) then
      local current = self.factionInfo.friendshipFactionData.standing -
          self.factionInfo.friendshipFactionData.reactionThreshold
      local max = self.factionInfo.friendshipFactionData.nextThreshold -
          self.factionInfo.friendshipFactionData.reactionThreshold

      GameTooltip:AddLine(
        self.factionInfo.friendshipFactionData.reaction .. " (" .. current .. " / " ..
        max .. ")", 1, 1, 1, true
      )
    else
      GameTooltip:AddLine(self.factionInfo.friendshipFactionData.reaction, 1, 1, 1, true)
    end
    GameTooltip:Show();
  end
end
