DFH_RenownMixin = CreateFromMixins(DFH_ReputationItemMixin)

function DFH_RenownMixin:Init()
  DFH_ReputationItemMixin.Init(self)

  self.factionInfo = DFH_FactionInfo:new()
  self.factionInfo:init(self.factionId)

  local color = self.factionInfo:getFactionColor()

  self:SetForegroundColor(color.r, color.g, color.b, 1)
  self:Update()

  self.enterCallback = function()
    self:ShowMajorFactionRenownTooltip()
  end

  self.leaveCallback = function()
    GameTooltip:Hide()
  end
end

-- Copied from ReputationFrame.xml and ReputationFrame.lua (Mixing in was a problem because data)
function DFH_RenownMixin:ShowMajorFactionRenownTooltip()
  if self.initialized == false then
    return
  end

  local function AddRenownRewardsToTooltip(renownRewards)
    GameTooltip_AddHighlightLine(GameTooltip, MAJOR_FACTION_BUTTON_TOOLTIP_NEXT_REWARDS);

    for _, rewardInfo in ipairs(renownRewards) do
      local renownRewardString
      local icon, name = RenownRewardUtil.GetRenownRewardInfo(
        rewardInfo,
        GenerateClosure(self.ShowMajorFactionRenownTooltip, self)
      )

      if icon then
        local file, width, height = icon, 16, 16
        local rewardTexture = CreateSimpleTextureMarkup(file, width, height)
        renownRewardString = rewardTexture .. " " .. name;
      end
      local wrapText = false;
      GameTooltip_AddNormalLine(GameTooltip, renownRewardString, wrapText)
    end
  end

  GameTooltip:SetOwner(self, "ANCHOR_RIGHT");

  GameTooltip_SetTitle(GameTooltip, self.factionInfo.name, NORMAL_FONT_COLOR)
  GameTooltip_AddColoredLine(
    GameTooltip,
    RENOWN_LEVEL_LABEL .. self.factionInfo.majorFactionData.renownLevel,
    BLUE_FONT_COLOR
  )
  GameTooltip_AddBlankLineToTooltip(GameTooltip);

  GameTooltip_AddHighlightLine(
    GameTooltip,
    MAJOR_FACTION_RENOWN_TOOLTIP_PROGRESS:format(self.factionInfo.name)
  )
  GameTooltip_AddBlankLineToTooltip(GameTooltip)

  local nextRenownRewards = C_MajorFactions.GetRenownRewardsForLevel(
    self.factionInfo.factionId,
    C_MajorFactions.GetCurrentRenownLevel(self.factionInfo.factionId) + 1
  )
  if #nextRenownRewards > 0 then
    AddRenownRewardsToTooltip(nextRenownRewards);
  end

  GameTooltip:Show();
end
