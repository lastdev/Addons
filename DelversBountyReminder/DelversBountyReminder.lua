local addonName, DelversBountyReminder = ...

-- Ensure required libraries are loaded
local LDB = LibStub:GetLibrary("LibDataBroker-1.1", true)
local LDBIcon = LibStub:GetLibrary("LibDBIcon-1.0", true)

-- Constants and Configuration
local DELVERS_BOUNTY_MAP_ID = 233071 -- Delver's Bounty Map item ID

-- Saved Variables
DelversBountyReminderDB = DelversBountyReminderDB or {
    lootedCharacters = {},
    minimap = { hide = false, minimapPos = 180 },
    reminderVisible = true,
    soundEnabled = true,
    reminderPosition = nil,
}

local function GetTimeSinceLooted(timestamp)
    if not timestamp then return "Unknown" end

    local secondsElapsed = GetServerTime() - timestamp

    if secondsElapsed < 60 then
        return secondsElapsed .. " seconds ago"
    elseif secondsElapsed < 3600 then
        return math.floor(secondsElapsed / 60) .. " minutes ago"
    elseif secondsElapsed < 86400 then
        return math.floor(secondsElapsed / 3600) .. " hours ago"
    else
        return math.floor(secondsElapsed / 86400) .. " days ago"
    end
end

-- Table to track notified characters within the session
local notifiedCharacters = {}

-- Function to check if the player has Delver's Bounty Map
local function HasDelversBounty()
    for bag = 0, NUM_BAG_SLOTS do
        local bagSlots = C_Container.GetContainerNumSlots(bag)
        if bagSlots then
            for slot = 1, bagSlots do
                local itemID = C_Container.GetContainerItemID(bag, slot)
                if itemID and itemID == DELVERS_BOUNTY_MAP_ID then
                    return true
                end
            end
        end
    end
    return false
end

-- Function to track looted characters when they obtain the map
local function TrackLootedCharacter()
    local characterName = UnitName("player")

    -- Only update if the character is not already tracked
    if not DelversBountyReminderDB.lootedCharacters[characterName] then
        local _, class = UnitClass("player")
        local specID = GetSpecialization()
        local specName = specID and select(2, GetSpecializationInfo(specID)) or "Unknown"

        DelversBountyReminderDB.lootedCharacters[characterName] = {
            class = class,
            spec = specName,
            lastLooted = GetServerTime() -- Store the timestamp
        }
    end
end

-- Function to check if a weekly reset has occurred
local function HasWeeklyResetOccurred()
    local lastReset = DelversBountyReminderDB.lastResetTime or 0
    local currentTime = GetServerTime()
    local nextResetTime = currentTime + C_DateAndTime.GetSecondsUntilWeeklyReset()

    -- If our last reset time is before the last reset event, we need to reset tracking
    if lastReset < (nextResetTime - (7 * 24 * 60 * 60)) then
        DelversBountyReminderDB.lastResetTime = nextResetTime - (7 * 24 * 60 * 60) -- Store last reset time
        return true
    end
    return false
end

-- Reminder Frame
local reminderFrame = CreateFrame("Frame", "DelversBountyReminderFrame", UIParent, "BackdropTemplate")
reminderFrame:SetSize(250, 80)
reminderFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
reminderFrame:Hide()

-- Make the reminder frame draggable
reminderFrame:SetMovable(true)
reminderFrame:EnableMouse(true)
reminderFrame:RegisterForDrag("LeftButton")
reminderFrame:SetScript("OnDragStart", reminderFrame.StartMoving)
reminderFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, relPoint, x, y = self:GetPoint()
    DelversBountyReminderDB.reminderPosition = { point, relPoint, x, y }
end)

-- Restore position of the reminder frame
local function RestoreReminderPosition()
    if DelversBountyReminderDB.reminderPosition then
        reminderFrame:ClearAllPoints()
        reminderFrame:SetPoint(DelversBountyReminderDB.reminderPosition[1], UIParent, DelversBountyReminderDB.reminderPosition[2], DelversBountyReminderDB.reminderPosition[3], DelversBountyReminderDB.reminderPosition[4])
    else
        reminderFrame:SetPoint("CENTER", UIParent, "CENTER")
    end
end

C_Timer.After(1, RestoreReminderPosition) -- Delay execution to ensure UI loads first

-- Reminder Icon
local reminderIcon = reminderFrame:CreateTexture(nil, "ARTWORK")
reminderIcon:SetSize(40, 40)
reminderIcon:SetPoint("LEFT", reminderFrame, "LEFT", 10, 0)
reminderIcon:SetTexture("Interface\\Icons\\Icon_treasuremap")

-- Reminder Text
local reminderText = reminderFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
reminderText:SetPoint("LEFT", reminderIcon, "RIGHT", 10, 0)
reminderText:SetText("|cffffcc00Use Delver's Bounty!|r")

-- Function to trigger reminders when item is obtained
local function TriggerReminder()
    if DelversBountyReminderDB.soundEnabled then
        PlaySound(259371, "Master") -- Play reminder sound
    end

    if DelversBountyReminderDB.reminderVisible then
        reminderFrame:Show() -- Show banner
    end

    print("|cffffcc00[Delver's Bounty Reminder]: You have received a Delver's Bounty Map!|r")
end

-- Function to check item status and trigger reminder
local function CheckAndTriggerReminder()
    local characterName = UnitName("player")
    
    if HasDelversBounty() then
        if not notifiedCharacters[characterName] then
            notifiedCharacters[characterName] = true -- Mark as notified
            TrackLootedCharacter()
            TriggerReminder()
        end
    else
        notifiedCharacters[characterName] = nil -- Reset notification when item is lost
        reminderFrame:Hide() -- Hide banner automatically when item is gone
    end
end

-- Create event frame
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("BAG_UPDATE_DELAYED") -- More efficient for bag updates
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD") -- Triggers on UI reload/login

eventFrame:SetScript("OnEvent", function(_, event)
    if event == "BAG_UPDATE_DELAYED" then
        CheckAndTriggerReminder()
    elseif event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(1, function()
            -- Perform weekly reset check before triggering reminders
            if HasWeeklyResetOccurred() then
                DelversBountyReminderDB.lootedCharacters = {} -- Clear tracked characters
                print("|cffffcc00[Delver's Bounty Reminder]: Weekly reset detected. Loot tracking has been reset.|r")
            end

            -- Keep all other existing functionalities
            CheckAndTriggerReminder()
        end)
    end
end)

-- Minimap Button Configuration
local minimapButton = LDB:NewDataObject("DelversBountyReminder", {
    type = "data source",
    text = "Delver's Bounty Reminder",
    icon = "Interface\\Icons\\Icon_treasuremap",
    OnClick = function(_, button)
        if button == "RightButton" then
            -- Toggle Sound Setting
            DelversBountyReminderDB.soundEnabled = not DelversBountyReminderDB.soundEnabled
            print("|cffffcc00[Delver's Bounty Reminder]: Sound " .. (DelversBountyReminderDB.soundEnabled and "Enabled" or "Disabled") .. "|r")
        elseif button == "LeftButton" then
            -- Toggle Reminder Banner if the item is still in bags
            if HasDelversBounty() then
                DelversBountyReminderDB.reminderVisible = not DelversBountyReminderDB.reminderVisible
                if DelversBountyReminderDB.reminderVisible then
                    reminderFrame:Show()
                else
                    reminderFrame:Hide()
                end
            else
                print("|cffff0000[Delver's Bounty Reminder]: You do not have a Delver's Bounty Map!|r")
            end
        end
    end,
    OnTooltipShow = function(tooltip)
    tooltip:AddLine("Delver's Bounty Looted By:")

    local lootedCount = 0
    local characterName = UnitName("player")
    local class = select(2, UnitClass("player"))
    local specID = GetSpecialization()
    local specName = specID and select(2, GetSpecializationInfo(specID)) or "Unknown"

    -- Check if quest 86371 is completed (weekly loot check)
    local hasLootedThisWeek = C_QuestLog.IsQuestFlaggedCompleted(86371)

    -- If the character has looted but isn't in the database, add them
    if hasLootedThisWeek and not DelversBountyReminderDB.lootedCharacters[characterName] then
        DelversBountyReminderDB.lootedCharacters[characterName] = {
            class = class,
            spec = specName,
            lastLooted = GetServerTime()
        }
    end

    -- Sort characters by last looted time (oldest first)
    local sortedLooters = {}
    for charName, data in pairs(DelversBountyReminderDB.lootedCharacters) do
        table.insert(sortedLooters, { name = charName, data = data })
    end
    table.sort(sortedLooters, function(a, b)
        return (a.data.lastLooted or 0) < (b.data.lastLooted or 0)
    end)

    -- Display sorted loot info
    for _, entry in ipairs(sortedLooters) do
        local charName = entry.name
        local data = entry.data
        local classColor = RAID_CLASS_COLORS[data.class] and RAID_CLASS_COLORS[data.class].colorStr or "ffffffff"
        local timeSinceLooted = GetTimeSinceLooted(data.lastLooted)

        tooltip:AddLine("|c" .. classColor .. charName .. " - " .. data.spec .. " (" .. timeSinceLooted .. ")|r")
        lootedCount = lootedCount + 1
    end

    if lootedCount == 0 then
        tooltip:AddLine("No characters have looted the map this week.", 1, 0, 0)
    end

    -- Tooltip instructions
    tooltip:AddLine("\n|cffffcc00Left-Click:|r Toggle Reminder Banner")
    tooltip:AddLine("|cffffcc00Right-Click:|r Toggle Sound")
end,


})

-- Register Minimap Button
LDBIcon:Register("DelversBountyReminder", minimapButton, DelversBountyReminderDB.minimap)

-- Slash Command for Resetting Character Tracking and Weekly Data
SLASH_DBRRESET1 = "/dbrreset"
SlashCmdList["DBRRESET"] = function()
    -- Clear all looted character data
    DelversBountyReminderDB.lootedCharacters = {}
    -- Reset weekly reset timestamp
    DelversBountyReminderDB.lastResetTime = 0 

    print("|cffffcc00[Delver's Bounty Reminder]: All tracking data has been reset.|r")
end
