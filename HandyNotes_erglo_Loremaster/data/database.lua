--------------------------------------------------------------------------------
--[[ Database - Utility functions for saving and loading save game data. ]]--
-- 
-- by erglo <erglo.coder+HNLM@gmail.com>
--
-- Copyright (C) 2024  Erwin D. Glockner (aka erglo, ergloCoder)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see http://www.gnu.org/licenses.
--
--------------------------------------------------------------------------------

local AddonID, ns = ...;

-- Upvalues
local FACTION_GREEN_COLOR = FACTION_GREEN_COLOR;

----- Database Utilities -------------------------------------------------------

local DBUtil = { debug = false, debug_prefix = FACTION_GREEN_COLOR:WrapTextInColorCode("DB:") };
ns.DatabaseUtil = DBUtil;

function DBUtil:GetInitDbCategory(categoryName, database)
    local db = database or ns.charDB
    if not db[categoryName] then
        db[categoryName] = {}
        -- debug:print(self, "Initialized DB:", categoryName)
    end
    return db[categoryName]
end

function DBUtil:HasCategoryTableAnyEntries(categoryName, database)
    local db = database or ns.charDB
    local value = db[categoryName] and TableHasAnyEntries(db[categoryName])
    -- debug:print(self, "Has", categoryName, "table any entries:", value)
    return value
end

function DBUtil:DeleteDbCategory(categoryName, database)
    local db = database or ns.charDB
    if not db[categoryName] then
        -- debug:print(self, format("DB category '%s' not found.", categoryName))
        return
    end
    db[categoryName] = nil
    -- debug:print(self, format("DB category '%s' has been removed.", categoryName))
end

-- Save active lore quest to database.
function DBUtil:AddActiveLoreQuest(questID, questLineID, campaignID)
    if not questID then return false end
    if not questLineID then return false end

    local questIDstring = tostring(questID)
    local activeQuests = self:GetInitDbCategory("activeLoreQuests")
    if not activeQuests[questIDstring] then
        activeQuests[questIDstring] = {questLineID, campaignID}
        -- debug:print(self, "Added active lore quest", questID, questLineID, campaignID)
        return true
    end

    return false
end

-- Check whether given quest is an active lore quest.
function DBUtil:IsQuestActiveLoreQuest(questID)
    if not questID then return false end
    if not self:HasCategoryTableAnyEntries("activeLoreQuests") then return false end

    local questIDstring = tostring(questID)
    local activeQuests = self:GetInitDbCategory("activeLoreQuests")
    return activeQuests[questIDstring] ~= nil
end

-- Remove an active lore quest from database.
function DBUtil:RemoveActiveLoreQuest(questID)
    if not questID then return end

    local questIDstring = tostring(questID)
    local activeQuests = self:GetInitDbCategory("activeLoreQuests")
    local questLineID, campaignID = SafeUnpack(activeQuests[questIDstring])
    -- Remove from DB
    activeQuests[questIDstring] = nil
    -- debug:print(self, "Removed active lore quest", questID)
    -- Remove DB itself if empty
    if not self:HasCategoryTableAnyEntries("activeLoreQuests") then
        self:DeleteDbCategory("activeLoreQuests")
    end

    return questLineID, campaignID
end

-- Count the currently saved active questlines.
function DBUtil:CountActiveQuestlineQuests(questLineID)
    if not self:HasCategoryTableAnyEntries("activeLoreQuests") then return 0 end

    local activeQuests = self:GetInitDbCategory("activeLoreQuests")
    local count = 0
    for questIDstring, data in pairs(activeQuests) do
        local activeQuestLineID = data[1]
        if (questLineID == activeQuestLineID) then
            count = count + 1
        end
    end
    -- debug:print(DBUtil, format("Found %d active |4questline:questlines;.", count))
    return count
end

----- Recurring Quests -----

function DBUtil:SetRecurringQuestCompleted(recurringTypeName, questID)
    local catName_recurringQuest = "completed"..recurringTypeName.."Quests"
    self:GetInitDbCategory(catName_recurringQuest, ns.charDB)

    if not tContains(ns.charDB[catName_recurringQuest], questID) then
        tinsert(ns.charDB[catName_recurringQuest], questID)
    --     debug:print(self, questID, recurringTypeName, "quest has been saved.")
    -- else
    --     debug:print(self, questID, "Already saved.")
    end
end

function DBUtil:IsCompletedRecurringQuest(recurringTypeName, questID)
    local catName_recurringQuest = "completed"..recurringTypeName.."Quests"
    return ns.charDB[catName_recurringQuest] and tContains(ns.charDB[catName_recurringQuest], questID)
end

--------------------------------------------------------------------------------