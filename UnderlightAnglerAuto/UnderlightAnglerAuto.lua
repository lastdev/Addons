local f = CreateFrame("Frame")
f:RegisterEvent("BAG_UPDATE")
f:RegisterEvent("MOUNT_JOURNAL_USABILITY_CHANGED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("CHAT_MSG_LOOT")
f:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")

-- Check Blizzard_Professions\Blizzard_ProfessionsCrafting.xml for changes to this
-- FishingToolSlot
-- <KeyValue key="slotID" value="28" type="number"/>
-- As of 10.2 I will no longer load in Blizzard_Professions and get this KeyValue due to lua errors from not fully loading in Blizzard_Professions
local FISHINGTOOLSLOT = 28

local FISHINGTOOLITEMIDS = {
    [133755] = true, -- Underlight Angler
    [44050] = true, -- Mastercraft Kalu'ak Fishing Pole
}

local bagID, slotID

local attentionBuffSetByAddon
local function cancelAttentionBuff()
    local info = C_UnitAuras.GetPlayerAuraBySpellID(394009)
    if not info then return end
    if InCombatLockdown() then return end
    CancelSpellByName(info.name)
    attentionBuffSetByAddon = nil
end

local function unequipUA()
    if InCombatLockdown() or C_ChallengeMode.IsChallengeModeActive() then return end
    
    bagID, slotID = nil
    
    -- find the first empty bag slot
    for b = 0, 4 do
        if C_Container.GetContainerNumFreeSlots(b) > 0 then
            for s = 1, C_Container.GetContainerNumSlots(b) do
                if not C_Container.GetContainerItemID(b, s) then
                    bagID, slotID = b, s
                    break
                end
            end
            break
        end
    end

    -- player does not have space in their bags
    if not bagID then return end

    -- put the fishing tool onto the cursor
    PickupInventoryItem(FISHINGTOOLSLOT)
    
    -- put the fishing tool into the bags
    C_Container.PickupContainerItem(bagID, slotID)
end

local function reequipUA()
    -- put the fishing tool back onto the cursor
    C_Container.PickupContainerItem(bagID, slotID)
    
    -- put the cursor item (underlight angler) into the fishing tool slot
    PickupInventoryItem(FISHINGTOOLSLOT)
    
    bagID, slotID = nil
    attentionBuffSetByAddon = true
end

local throttle = GetTime()

f:SetScript("OnEvent", function(self, event, ...)
    if (event == "PLAYER_MOUNT_DISPLAY_CHANGED") and InCombatLockdown() then
        attentionBuffSetByAddon = nil
    end
    if InCombatLockdown() or C_ChallengeMode.IsChallengeModeActive() then return end
    
    if event == "BAG_UPDATE" then
        if bagID and slotID then
            reequipUA()
        end
    elseif (event == "MOUNT_JOURNAL_USABILITY_CHANGED") then
        -- IsSwimming returns false during the MOUNT_JOURNAL_USABILITY_CHANGED event, so add a small delay
        C_Timer.After(0.1, function()
            -- the MOUNT_JOURNAL_USABILITY_CHANGED event fires twice when entering water; only trigger on the first one
            if (throttle + 1) > GetTime() then return end
            
            -- only do something if the player has Underlight Angler equipped
            if not FISHINGTOOLITEMIDS[GetInventoryItemID("player", FISHINGTOOLSLOT)] then return end
            
            -- if the player already has the Fishing for Attention buff, do nothing
            if C_UnitAuras.GetPlayerAuraBySpellID(394009) then return end
            
            if IsSwimming() then
                unequipUA()
                throttle = GetTime()
            end
        end)
    elseif (event == "PLAYER_REGEN_ENABLED") and bagID and slotID then
        reequipUA()
    elseif (event == "PLAYER_REGEN_ENABLED") or (event == "CHAT_MSG_LOOT") then
        if not FISHINGTOOLITEMIDS[GetInventoryItemID("player", FISHINGTOOLSLOT)] then return end
        if C_UnitAuras.GetPlayerAuraBySpellID(394009) then return end
        if IsSwimming() then
            unequipUA()
        end
    elseif event == "PLAYER_MOUNT_DISPLAY_CHANGED" then
        if attentionBuffSetByAddon then
            cancelAttentionBuff()
        end
    end
end)
