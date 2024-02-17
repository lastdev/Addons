-- By: Viicksmille-Thrall - Horde 4ever
-- Special thanks for: omsheal, KNARK1337, CommandoCat64 for reports and in special for omsheal
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local function LUSTDETECTORMSG(msg)
    local LUSTDETECTORType = LUSTDETECTORMode

    if LUSTDETECTORMode == "SELF" then
        print(msg)
        return
    elseif LUSTDETECTORMode == "TEST" then
        LUSTDETECTORType = "TEST"
    elseif LUSTDETECTORMode == "RAID_WARNING" or LUSTDETECTORMode == "GROUP" then
        if IsInRaid() and LUSTDETECTORMode == "RAID_WARNING" and (IsEveryoneAssistant() or UnitIsGroupAssistant("player") or UnitIsGroupLeader("player") or UnitIsRaidOfficer("player")) then
            LUSTDETECTORType = "RAID_WARNING"
        elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
            LUSTDETECTORType = "INSTANCE_CHAT"
        elseif IsInRaid() then
            LUSTDETECTORType = "RAID"
        elseif IsInGroup() then
            LUSTDETECTORType = "PARTY"
        end
    end

    SendChatMessage(msg, LUSTDETECTORType)
end

local function handler(msg)
    msg = string.upper(msg)

    if msg == 'ON' or msg == 'OFF' then
        LUSTDETECTOR = (msg == 'ON')

        if LUSTDETECTOR then
            frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        else
            frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        end

        print("Lust Detector is now |cff0042ff" .. (LUSTDETECTOR and "On" or "Off") .. "|r.")

    elseif msg == 'SAY' or msg == 'GROUP' or msg == 'SELF' or msg == 'YELL' then
        LUSTDETECTORMode = msg
        print("Lust Detector is now set for announcing to |cffff0000" .. LUSTDETECTORMode .. "|r.")

    elseif msg == "RW" or msg == "RAIDWARNING" then
        LUSTDETECTORMode = "RAID_WARNING"
        print("Lust Detector is now set for announcing to |cffff0000" .. LUSTDETECTORMode .. "|r.")

    elseif msg == 'TEST' then
        LUSTDETECTORMSG("[LD Test] {rt8} ADDON: Lust Detector is working correctly!")

    else
        print("Lust Detector Status: is |cff1cb619" .. (LUSTDETECTOR and "On" or "Off") .. "|r and announcing to: |cff1cb619" .. LUSTDETECTORMode .. "|r.")
        print("Commands: \n/ld on, /ld off, /ld test, /ld group, /ld self")
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
}

local WarpSpells = {
    [2825] = true, -- Bloodlust
    [32182] = true, -- Heroism
    [80353] = true, -- Time Warp
    [264667] = true, -- Primal Rage 1
    [390386] = true, -- Fury of the Aspects (Dracthyr Evoker DF)
    [1626] = true, -- Primal Rage 2
    [275200] = true, -- Primal Rage 3
    [204276] = true, -- Primal Rage 4
    [357650] = true, -- Primal Rage | Raiva Primeva (PTBR) 4.5
    [272678] = true, -- Primal Rage 6
    [293076] = true, -- Mallet of Thunderous Skins
}

local ClassSpells = {
    [29893] = false, -- Create soulwell
	["WARLOCK"] = false, --
}

frame:SetScript("OnEvent", function(self, event, ...)
    local _, event, _, _, sourceName, _, _, _, _, _, _, spellID, _ = CombatLogGetCurrentEventInfo()
    local pNum = GetNumGroupMembers()

    if LUSTDETECTOR and event == "SPELL_CAST_SUCCESS" and pNum > 0 and (HasteItem[spellID] or WarpSpells[spellID]) and UnitInParty(sourceName) then
        local chatType = "PARTY"
        local isInstance, instanceType = IsInInstance()

        if isInstance and (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or instanceType == "pvp") then
            chatType = "INSTANCE_CHAT"
        elseif IsInRaid() then
            chatType = "RAID"
        end

        local spellName = GetSpellInfo(spellID)
        local spellLink = GetSpellLink(spellID)
        local className = select(2, UnitClass(sourceName))

        if HasteItem[spellID] then
            LUSTDETECTORMSG("{rt1} Lust Detector: [" .. className .. "] " .. UnitName(sourceName) .. " used: " .. spellLink .. " and increased +15% haste on the party! {rt1}", chatType)
        elseif WarpSpells[spellID] then
            LUSTDETECTORMSG("{rt2} Lust Detector: [" .. className .. "] " .. UnitName(sourceName) .. " cast: " .. spellLink .. " and increased +30% haste on the party! {rt2}", chatType)
        end

        elseif event == "SPELL_CAST_SUCCESS" and pNum > 0 and ClassSpells[spellID] and UnitInParty(sourceName) then
        local chatType = "PARTY"
        local isInstance, instanceType = IsInInstance()

        if isInstance and (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or instanceType == "pvp") then
            chatType = "INSTANCE_CHAT"
        elseif IsInRaid() then
            chatType = "RAID"
        end

        LUSTDETECTORMSG("{rt7} LD: " .. UnitName(sourceName) .. " created a Soulwell! Grab your healthstones :D :D ! {rt7}", chatType)
    end
end)
