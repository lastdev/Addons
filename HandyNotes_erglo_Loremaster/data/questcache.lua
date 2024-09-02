--------------------------------------------------------------------------------
--[[ Quest Cache - Utility and wrapper functions for caching quest data. ]]--
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
-- World of Warcraft API reference:
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestConstantsDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_FrameXMLBase/Constants.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_SharedXML/SharedConstants.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestInfoSystemDocumentation.lua>
-- REF.: <https://www.townlong-yak.com/framexml/live/Blizzard_APIDocumentationGenerated/QuestLogDocumentation.lua>
-- (see also the function comments section for more reference)
--
--------------------------------------------------------------------------------

local AddonID, ns = ...;

-- Upvalues
local ORANGE_FONT_COLOR = ORANGE_FONT_COLOR;
local QuestCache = QuestCache;

--------------------------------------------------------------------------------
----- Quest Cache Handler -----------------------------------------------------
--------------------------------------------------------------------------------

local LocalQuestCache = { debug = false, debug_prefix = ORANGE_FONT_COLOR:WrapTextInColorCode("Quest-CACHE:") };
ns.QuestCacheUtil = LocalQuestCache;

----- Wrapper ------------------------------------------------------------------

function LocalQuestCache:Get(questID)
    local questInfo = QuestCache:Get(questID);  --> WoW global

    return questInfo;
end

function LocalQuestCache:IsCached(questID)
    return QuestCache.objects[questID] ~= nil;
end

----- Quest Lines --------------------------------------------------------------

LocalQuestCache.questLineQuests = {}  --> { [questLineID] = {questID1, questID2, ...}, ... }

function LocalQuestCache:GetQuestLineQuests(questLineID, prepareCache)
    local questIDs = self.questLineQuests[questLineID];
    if not questIDs then
        -- questIDs = DBUtil:GetSavedQuestLineQuests(questLineID) or C_QuestLine.GetQuestLineQuests(questLineID)
        questIDs = C_QuestLine.GetQuestLineQuests(questLineID);
        if (#questIDs == 0) then return; end

        self.questLineQuests[questLineID] = questIDs;
        -- debug:print(self, format("%d Added %d |4quest:quests; for QL", questLineID, #questIDs))
    end

    if not prepareCache then
        return questIDs;
    end
end
