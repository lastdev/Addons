local Katy = CreateFrame("Frame");

function Katy:OnEvent(_, type)
  if type ~= Enum.PlayerInteractionType.Gossip then return end
  local guid = UnitGUID('target');
  if guid then
    local unitType, _, _, _, _, unitID = strsplit("-", guid);
    if unitID and (unitID == "132969") and (unitType == "Creature") then
      local options = C_GossipInfo.GetOptions();
      if options and options[1] then
        C_GossipInfo.SelectOption(options[1].gossipOptionID);
      end
    end
  end
end

Katy:SetScript("OnEvent", Katy.OnEvent);
Katy:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW");