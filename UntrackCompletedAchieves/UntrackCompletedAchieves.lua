--[[ Untrack Completed Achieves ]]--
--[[   (c) 2024,2025 by Rubio   ]]--

local Name = "Untrack Completed Achieves"
local Version = "11.2.0"

-- Some players have encountered a situation where, when trying to track a new
-- achievement, they are told "You may only track 10 achievements at a time."
-- despite definitely not having 10 achievements listed on their tracker.
--
-- Usually, completing an achievement will untrack it automatically. Sometimes,
-- possibly if the game crashes without a clean save after an achievement is
-- completed, OR if an achievement was tracked on one character but completed
-- on another, the achievement will be left tracked even though it it is
-- completed.
--
-- This leaves it using up one of the 10 tracking slots but not showing up on
-- the achievement tracker.  And since it isn't listed on the tracker, the
-- only way to find an achievement would be to manually search every page of
-- achievements and hope to spot the ones left tracked and complete.
--
-- This addon solves that issue, by automatically scanning for and untracking
-- already-completed achievements when a character logs in.
-- It prints a message for each achievement it clears, if any.
--
-- This addon has no settings or interface; it just does its thing and lets
-- you get on with your game.


local Event = {}
local Color = "ffffff00"
local banner = false

local function UntrackCompletedAchieves()
    local ACHIEVE = Enum.ContentTrackingType.Achievement
    local COLLECTED = Enum.ContentTrackingStopType.Collected

    if not banner then
	    print("|c" .. Color .. Name .. " v" .. Version .. " loaded.|r")
	    banner = true
    end

    local tracked = C_ContentTracking.GetTrackedIDs(ACHIEVE) or {}
    for _, achievementID in ipairs(tracked) do
	local _, _, _, completed = GetAchievementInfo(achievementID)
	if completed then
	    C_ContentTracking.StopTracking(ACHIEVE, achievementID, COLLECTED)
	    print("- Stopped tracking completed achievement: " ..
			GetAchievementLink(achievementID))
	end
    end
end


-- Event handlers

Event["PLAYER_ENTERING_WORLD"] = function(...)
	UntrackCompletedAchieves()
end


-- Connect event handlers

local Frame = CreateFrame("Frame")
local OnEvent = function(self, e, ...) if Event[e] then Event[e](...) end end
for e,_ in pairs(Event) do Frame:RegisterEvent(e) end
Frame:SetScript("OnEvent", OnEvent)
