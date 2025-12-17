-- Completion Tracker Module
-- Automatically tracks visited vendors, earned achievements, and completed quests

local CompletionTracker = {}
CompletionTracker.__index = CompletionTracker

-- Event frame
local eventFrame = CreateFrame("Frame")

-- Initialize saved variables structure
function CompletionTracker:Initialize()
    if not HousingDB then
        HousingDB = {}
    end
    
    -- Initialize completion tracking tables
    if not HousingDB.completedVendors then
        HousingDB.completedVendors = {}
    end
    
    if not HousingDB.completedAchievements then
        HousingDB.completedAchievements = {}
    end
    
    if not HousingDB.completedQuests then
        HousingDB.completedQuests = {}
    end
    
    -- Register events
    eventFrame:RegisterEvent("MERCHANT_SHOW")
    eventFrame:RegisterEvent("ACHIEVEMENT_EARNED")
    eventFrame:RegisterEvent("QUEST_TURNED_IN")
    eventFrame:RegisterEvent("QUEST_COMPLETE")
    
    -- Set up event handler
    eventFrame:SetScript("OnEvent", function(self, event, ...)
        CompletionTracker:OnEvent(event, ...)
    end)
    
    print("|cFF8A7FD4HousingVendor:|r Completion Tracker initialized")
end

-- Main event handler
function CompletionTracker:OnEvent(event, ...)
    if event == "MERCHANT_SHOW" then
        self:OnMerchantShow()
    elseif event == "ACHIEVEMENT_EARNED" then
        local achievementID = ...
        self:OnAchievementEarned(achievementID)
    elseif event == "QUEST_TURNED_IN" or event == "QUEST_COMPLETE" then
        local questID = ...
        self:OnQuestCompleted(questID)
    end
end

-- Handle vendor interaction
function CompletionTracker:OnMerchantShow()
    -- Get NPC GUID
    local guid = UnitGUID("target")
    if not guid then
        guid = UnitGUID("npc")
    end
    
    if not guid then return end
    
    -- Extract NPC ID from GUID
    local npcID = select(6, strsplit("-", guid))
    npcID = tonumber(npcID)
    
    if not npcID then return end
    
    -- Check if this NPC is in our vendor data
    local vendorFound = false
    local vendorName = UnitName("target") or UnitName("npc") or "Unknown Vendor"
    
    -- Search through all vendor data
    if HousingData and HousingData.vendorData then
        for expansionName, zones in pairs(HousingData.vendorData) do
            for zoneName, vendors in pairs(zones) do
                for _, vendor in ipairs(vendors) do
                    -- Check if this vendor has items with this NPC ID
                    if vendor.items then
                        for _, item in ipairs(vendor.items) do
                            -- Check if item has this vendor's NPC ID
                            if item.npcID == npcID or vendor.npcID == npcID then
                                vendorFound = true
                                break
                            end
                        end
                    end
                    if vendorFound then break end
                end
                if vendorFound then break end
            end
            if vendorFound then break end
        end
    end
    
    if vendorFound then
        -- Mark vendor as visited
        if not HousingDB.completedVendors[npcID] then
            HousingDB.completedVendors[npcID] = {
                timestamp = time(),
                name = vendorName
            }
            
            print("|cFF8A7FD4HousingVendor:|r Marked vendor |cFFFFD100" .. vendorName .. "|r as visited!")
            
            -- Refresh UI if it's open
            if HousingUINew and HousingUINew.RefreshItemList then
                C_Timer.After(0.1, function()
                    HousingUINew:RefreshItemList()
                end)
            end
        end
    end
end

-- Handle achievement earned
function CompletionTracker:OnAchievementEarned(achievementID)
    if not achievementID then return end
    
    -- Check if this achievement grants housing items
    local achievementFound = false
    
    if HousingData and HousingData.vendorData then
        -- Check Achievement Rewards category
        if HousingData.vendorData["Achievement Items"] then
            for _, zone in pairs(HousingData.vendorData["Achievement Items"]) do
                for _, vendor in ipairs(zone) do
                    if vendor.items then
                        for _, item in ipairs(vendor.items) do
                            if item.achievementRequired then
                                -- Parse achievement ID from requirement string
                                -- achievementRequired might be achievement name or ID
                                if tostring(item.achievementID) == tostring(achievementID) then
                                    achievementFound = true
                                    break
                                end
                            end
                        end
                    end
                    if achievementFound then break end
                end
                if achievementFound then break end
            end
        end
    end
    
    if achievementFound or C_AchievementInfo.GetAchievementInfo(achievementID) then
        -- Mark achievement as completed
        if not HousingDB.completedAchievements[achievementID] then
            HousingDB.completedAchievements[achievementID] = {
                timestamp = time()
            }
            
            local _, achievementName = GetAchievementInfo(achievementID)
            if achievementName then
                print("|cFF8A7FD4HousingVendor:|r Achievement |cFFFFD100" .. achievementName .. "|r may unlock housing items!")
            end
            
            -- Refresh UI if it's open
            if HousingUINew and HousingUINew.RefreshItemList then
                C_Timer.After(0.1, function()
                    HousingUINew:RefreshItemList()
                end)
            end
        end
    end
end

-- Handle quest completion
function CompletionTracker:OnQuestCompleted(questID)
    if not questID then return end
    
    -- Check if this quest grants housing items
    local questFound = false
    
    if HousingData and HousingData.vendorData then
        -- Check Quest Items category
        if HousingData.vendorData["Quest Items"] then
            for _, zone in pairs(HousingData.vendorData["Quest Items"]) do
                for _, vendor in ipairs(zone) do
                    if vendor.items then
                        for _, item in ipairs(vendor.items) do
                            if item.questRequired then
                                -- Check if this is the quest
                                if tostring(item.questID) == tostring(questID) then
                                    questFound = true
                                    break
                                end
                            end
                        end
                    end
                    if questFound then break end
                end
                if questFound then break end
            end
        end
    end
    
    if questFound then
        -- Mark quest as completed
        if not HousingDB.completedQuests[questID] then
            HousingDB.completedQuests[questID] = {
                timestamp = time()
            }
            
            print("|cFF8A7FD4HousingVendor:|r Quest completed - housing items may now be available!")
            
            -- Refresh UI if it's open
            if HousingUINew and HousingUINew.RefreshItemList then
                C_Timer.After(0.1, function()
                    HousingUINew:RefreshItemList()
                end)
            end
        end
    end
end

-- Check if a vendor has been visited
function CompletionTracker:IsVendorVisited(npcID)
    if not npcID then return false end
    return HousingDB.completedVendors[tonumber(npcID)] ~= nil
end

-- Check if an achievement has been earned
function CompletionTracker:IsAchievementCompleted(achievementID)
    if not achievementID then return false end
    
    -- First check our tracking
    if HousingDB.completedAchievements[tonumber(achievementID)] then
        return true
    end
    
    -- Also check Blizzard API
    if C_AchievementInfo and C_AchievementInfo.GetAchievementInfo then
        local info = C_AchievementInfo.GetAchievementInfo(achievementID)
        if info and info.completed then
            -- Add to our tracking
            HousingDB.completedAchievements[tonumber(achievementID)] = {
                timestamp = time()
            }
            return true
        end
    end
    
    return false
end

-- Check if a quest has been completed
function CompletionTracker:IsQuestCompleted(questID)
    if not questID then return false end
    
    -- First check our tracking
    if HousingDB.completedQuests[tonumber(questID)] then
        return true
    end
    
    -- Also check Blizzard API
    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
        if C_QuestLog.IsQuestFlaggedCompleted(questID) then
            -- Add to our tracking
            HousingDB.completedQuests[tonumber(questID)] = {
                timestamp = time()
            }
            return true
        end
    end
    
    return false
end

-- Get completion statistics
function CompletionTracker:GetStatistics()
    local stats = {
        vendorsVisited = 0,
        achievementsEarned = 0,
        questsCompleted = 0
    }
    
    for _ in pairs(HousingDB.completedVendors or {}) do
        stats.vendorsVisited = stats.vendorsVisited + 1
    end
    
    for _ in pairs(HousingDB.completedAchievements or {}) do
        stats.achievementsEarned = stats.achievementsEarned + 1
    end
    
    for _ in pairs(HousingDB.completedQuests or {}) do
        stats.questsCompleted = stats.questsCompleted + 1
    end
    
    return stats
end

-- Clear all completion data (for testing/reset)
function CompletionTracker:ClearAll()
    HousingDB.completedVendors = {}
    HousingDB.completedAchievements = {}
    HousingDB.completedQuests = {}
    print("|cFF8A7FD4HousingVendor:|r All completion data cleared")
    
    -- Refresh UI
    if HousingUINew and HousingUINew.RefreshItemList then
        HousingUINew:RefreshItemList()
    end
end

-- Make globally accessible
_G["HousingCompletionTracker"] = CompletionTracker

return CompletionTracker
