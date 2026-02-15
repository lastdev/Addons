-- QuestTitleResolver.lua
-- Lightweight, on-demand quest title resolution with caching + async callbacks.

local _G = _G

local QuestTitleResolver = {}

QuestTitleResolver._cache = QuestTitleResolver._cache or {}
QuestTitleResolver._pending = QuestTitleResolver._pending or {}

local function NormalizeQuestID(questID)
    local id = tonumber(questID)
    if not id or id <= 0 then
        return nil
    end
    return id
end

local function GetQuestTitleNow(questID)
    if not (C_QuestLog and C_QuestLog.GetTitleForQuestID) then
        return nil
    end
    local ok, title = pcall(C_QuestLog.GetTitleForQuestID, questID)
    if ok and title and title ~= "" then
        return title
    end
    return nil
end

local function RequestQuestLoad(questID)
    if C_QuestLog and C_QuestLog.RequestLoadQuestByID then
        pcall(C_QuestLog.RequestLoadQuestByID, questID)
    end
end

function QuestTitleResolver:GetTitle(questID, callback)
    local id = NormalizeQuestID(questID)
    if not id then
        return nil
    end

    local cached = self._cache[id]
    if cached then
        if type(callback) == "function" then
            callback(cached, id)
        end
        return cached
    end

    -- Try immediate lookup (may succeed if quest is already cached by the client).
    local title = GetQuestTitleNow(id)
    if title then
        self._cache[id] = title
        if type(callback) == "function" then
            callback(title, id)
        end
        return title
    end

    -- Queue callback and request async load.
    if type(callback) == "function" then
        local list = self._pending[id]
        if not list then
            list = {}
            self._pending[id] = list
        end
        list[#list + 1] = callback
    end

    RequestQuestLoad(id)
    return nil
end

function QuestTitleResolver:Prime(questID)
    local id = NormalizeQuestID(questID)
    if not id then return end
    if self._cache[id] then return end
    RequestQuestLoad(id)
end

local function EnsureEventFrame()
    if QuestTitleResolver._eventFrame then
        return
    end

    local f = CreateFrame("Frame")
    QuestTitleResolver._eventFrame = f
    f:RegisterEvent("QUEST_DATA_LOAD_RESULT")
    f:SetScript("OnEvent", function(_, event, questID, success)
        if event ~= "QUEST_DATA_LOAD_RESULT" then
            return
        end
        local id = NormalizeQuestID(questID)
        if not id then
            return
        end

        if success ~= true and success ~= 1 then
            return
        end

        if QuestTitleResolver._cache[id] then
            return
        end

        local title = GetQuestTitleNow(id)
        if not title then
            return
        end

        QuestTitleResolver._cache[id] = title

        local callbacks = QuestTitleResolver._pending[id]
        QuestTitleResolver._pending[id] = nil
        if callbacks then
            for _, cb in ipairs(callbacks) do
                if type(cb) == "function" then
                    pcall(cb, title, id)
                end
            end
        end
    end)
end

EnsureEventFrame()

_G.HousingQuestTitleResolver = QuestTitleResolver
return QuestTitleResolver

