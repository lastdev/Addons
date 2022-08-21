local Katy = CreateFrame("Frame")

function Katy:OnEvent()
    local unit = UnitGUID('target')
    if unit then
        local id = select(6,strsplit("-", unit))
        if id == "132969" then
            C_GossipInfo.SelectOption(1)
        end
    end
end

Katy:SetScript("OnEvent", Katy.OnEvent)
Katy:RegisterEvent("GOSSIP_SHOW")