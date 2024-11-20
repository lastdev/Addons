-- By: Viicksmille-Thrall - Horde 4ever
-- Lust Detector - v3 for The War Within
-- special thanks for: @stormsparkpegasus - https://legacy.curseforge.com/members/stormsparkpegasus
-- special thanks for: @YouToo - https://legacy.curseforge.com/members/youtoo

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD") -- Evento para reiniciar cooldown ao entrar em uma nova instância

-- Per-character saved variables
LustDetectorSettings = LustDetectorSettings or { enabled = false, mode = "SELF", expireNotification = true }

local function sendMessage(msg)
    local chatType = LustDetectorSettings.mode

    if chatType == "SELF" then
        print(msg)
    elseif chatType == "TEST" then
        print("[Test Mode] " .. msg)
    else
        if IsInRaid(LE_PARTY_CATEGORY_HOME) then
            chatType = "RAID"
        elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
            chatType = "INSTANCE_CHAT"
        elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
            chatType = "PARTY"
        end
        SendChatMessage(msg, chatType)
    end
end

local function handler(msg)
    msg = string.upper(msg)

    if msg == 'ON' or msg == 'OFF' then
        LustDetectorSettings.enabled = (msg == 'ON')

        if LustDetectorSettings.enabled then
            frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        else
            frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        end

        print("Lust Detector is now |cff0042ff" .. (LustDetectorSettings.enabled and "On" or "Off") .. "|r.")

    elseif msg == 'SAY' or msg == 'GROUP' or msg == 'SELF' or msg == 'YELL' then
        LustDetectorSettings.mode = msg
        print("Lust Detector is now set for announcing to |cffff0000" .. LustDetectorSettings.mode .. "|r.")

    elseif msg == "RW" or msg == "RAIDWARNING" then
        LustDetectorSettings.mode = "RAID_WARNING"
        print("Lust Detector is now set for announcing to |cffff0000" .. LustDetectorSettings.mode .. "|r.")

    elseif msg == 'TEST' then
        sendMessage("[LD Test] {rt8} ADDON: Lust Detector is working correctly!")

    elseif msg == 'TEXT' then
        LustDetectorSettings.expireNotification = not LustDetectorSettings.expireNotification
        print("Lust Detector expire notification is now " .. (LustDetectorSettings.expireNotification and "Enabled" or "Disabled") .. ".")

    else
        print("Lust Detector Status: is |cff1cb619" .. (LustDetectorSettings.enabled and "On" or "Off") .. "|r and announcing to: |cff1cb619" .. LustDetectorSettings.mode .. "|r.")
        print("Commands: \n/ld on, /ld off, /ld test, /ld group, /ld self, /ld text")
    end
end

SlashCmdList["LUSTDETECTOR"] = handler
SlashCmdList["WL2"] = handler
SLASH_LUSTDETECTOR1 = "/lustdetector"
SLASH_WL21 = "/ld"

local HasteItem = {
    [178207] = true, -- Drums of Fury
    [256740] = true, -- Drums of the Maelstrom
    [230935] = true, -- Drums of the Mountain
    [309658] = true, -- Drums of Deathly Ferocity
    [146613] = true, -- Drums of Rage
    [381301] = true, -- Feral Hide Drums - DF
    [444257] = true, -- Thunderous Drums - TwW
}

local WarpSpells = {
    [2825] = true, -- Bloodlust
    [32182] = true, -- Heroism
    [80353] = true, -- Time Warp
    [264667] = true, -- Primal Rage (Hunter cast from pet spellbook)
    [390386] = true, -- Fury of the Aspects (Dracthyr Evoker DF)
    [272678] = true, -- Primal Rage (Hunter cast by command pet)
    [293076] = true, -- Mallet of Thunderous Skins
}

local cooldowns = {} -- Table to store cooldowns
local expiredSpells = {} -- Table to track when the spell effect has expired

local function startCooldown(spellID, spellName)
    if cooldowns[spellID] or not LustDetectorSettings.expireNotification then return end -- If already on cooldown, do nothing
    cooldowns[spellID] = true
    C_Timer.After(600, function()
        cooldowns[spellID] = nil
        sendMessage("{rt3} Lust Detector: " .. spellName .. " is now off cooldown and can be used again! {rt3}")
    end)
end

local function getHunterPetOwner(sourceGUID)
    local groupType = IsInRaid() and "raid" or "party"
    for i = 1, GetNumGroupMembers() do
        local unit = groupType .. i
        if UnitGUID(unit .. "pet") == sourceGUID then
            return UnitName(unit .. "pet"), UnitName(unit)
        end
    end
    return nil, nil
end

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        -- Load saved settings
        if LustDetectorSettings.enabled then
            frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        end
        print("Lust Detector Loaded. Status: " .. (LustDetectorSettings.enabled and "On" or "Off") .. ". Announcing to: " .. LustDetectorSettings.mode)

    elseif event == "PLAYER_ENTERING_WORLD" then
        -- Reset cooldown tracking when entering a new instance
        cooldowns = {}
        expiredSpells = {}

    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, eventType, _, sourceGUID, sourceName, _, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()
        local pNum = GetNumGroupMembers()

        if pNum > 0 then
            local spellLink = C_Spell.GetSpellLink(spellID)

            if eventType == "SPELL_CAST_SUCCESS" then
                if HasteItem[spellID] and UnitInParty(sourceName) then
                    sendMessage("{rt1} Lust Detector: [" .. UnitClass(sourceName) .. "] " .. UnitName(sourceName) .. " used: " .. spellLink .. " and increased +15% haste on the party! {rt1}")
                    startCooldown(spellID, spellLink)
                elseif WarpSpells[spellID] and UnitInParty(sourceName) then
                    sendMessage("{rt2} Lust Detector: [" .. UnitClass(sourceName) .. "] " .. UnitName(sourceName) .. " cast: " .. spellLink .. " and increased +30% haste on the party! {rt2}")
                    startCooldown(spellID, spellLink)
                end

                if WarpSpells[spellID] and string.match(sourceGUID, "Pet") then
                    local petName, ownerName = getHunterPetOwner(sourceGUID)
                    if petName and ownerName then
                        sendMessage("{rt2} Lust Detector: Pet [" .. petName .. "] from " .. ownerName .. " cast: " .. spellLink .. " and increased +30% haste on the party! {rt2}")
                        startCooldown(spellID, spellLink)
                    end
                end
            elseif eventType == "SPELL_AURA_REMOVED" then
                if WarpSpells[spellID] and LustDetectorSettings.expireNotification and not expiredSpells[spellID] then
                    expiredSpells[spellID] = true
                    sendMessage("{rt7} Lust Detector: " .. spellLink .. " effect has expired. It can be used again in 10 minutes! {rt7}")
                    C_Timer.After(600, function()
                        expiredSpells[spellID] = nil
                    end)
                end
            end
        end
    end
end)