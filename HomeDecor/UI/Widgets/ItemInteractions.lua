local ADDON, NS = ...

NS.UI = NS.UI or {}
local IA = {}
NS.UI.ItemInteractions = IA

local function GetNav()
    return NS.UI and NS.UI.Navigation or nil
end

local function GetTT()
    return NS.UI and NS.UI.Tooltips or nil
end

local function ViewerReq()
    return (NS.UI and NS.UI.Viewer and NS.UI.Viewer.Requirements) or nil
end

local function GetItemID(it)
    if not it then return nil end
    return it.itemID or (it.source and it.source.itemID) or it.vendorItemID or it.id
end

local function GetAchievementID(it)
    if not it then return nil end
    local s = it.source or {}
    if s.type == "achievement" then
        return tonumber(s.achievementID or s.id)
    end
    return tonumber(it.achievementID or it.achievementId or it.achID or it.achId)
end

local function GetQuestID(it)
    if not it then return nil end
    local s = it.source or {}
    if s.type == "quest" then
        return tonumber(s.questID or s.id)
    end
    return tonumber(it.questID or it.questId or it.qID or it.qid)
end

local function OpenAchievement(id)
    if not id then return false end
    if AchievementFrame_LoadUI then pcall(AchievementFrame_LoadUI) end
    if AchievementFrame_ToggleAchievementFrame then pcall(AchievementFrame_ToggleAchievementFrame) end
    if AchievementFrame_SelectAchievement then pcall(AchievementFrame_SelectAchievement, id) end
    return true
end

local function OpenQuest(id)
    id = tonumber(id)
    if not id then return false end

    if QuestMapFrame_OpenToQuestDetails then
        local ok = pcall(QuestMapFrame_OpenToQuestDetails, id)
        if ok then return true end
    end

    if QuestLog_OpenToQuest then
        local ok = pcall(QuestLog_OpenToQuest, id)
        if ok then
            if ToggleQuestLog then pcall(ToggleQuestLog) end
            return true
        end
    end

    if C_QuestLog and C_QuestLog.GetQuestLogIndexByID and C_QuestLog.SetSelectedQuest then
        local ok, idx = pcall(C_QuestLog.GetQuestLogIndexByID, id)
        if ok and idx and idx > 0 then
            pcall(C_QuestLog.SetSelectedQuest, idx)
            if ToggleQuestLog then pcall(ToggleQuestLog) end
            return true
        end
    end

    return false
end

local function AddUnique(list, seen, label, url)
    if not url or url == "" then return end
    if seen[url] then return end
    seen[url] = true
    list[#list + 1] = { label = label, url = url }
end

function IA:BuildWowheadLinks(it)
    local R = ViewerReq()
    if not R then return nil end
    local itemID = GetItemID(it)
    local src = it and (it.source or {}) or {}

    local links, seen = {}, {}
    if src.type == "achievement" and R.BuildWowheadAchievementURL then
        local aid = src.achievementID or src.id
        AddUnique(links, seen, "Achievement Link", R.BuildWowheadAchievementURL(aid))
    elseif src.type == "quest" and R.BuildWowheadQuestURL then
        local qid = src.questID or src.id
        AddUnique(links, seen, "Quest Link", R.BuildWowheadQuestURL(qid))
    end

    if R.GetRequirementLink then
        local req = R.GetRequirementLink(it)
        if req and req.kind == "quest" and R.BuildWowheadQuestURL then
            AddUnique(links, seen, "Quest Link", R.BuildWowheadQuestURL(req.id))
        elseif req and req.kind == "achievement" and R.BuildWowheadAchievementURL then
            AddUnique(links, seen, "Achievement Link", R.BuildWowheadAchievementURL(req.id))
        end
    end

    if itemID and R.BuildWowheadItemURL then
        AddUnique(links, seen, "Item Link", R.BuildWowheadItemURL(itemID))
    end

    if #links == 0 then return nil end
    return links
end

function IA:ShowWowheadPopup(it)
    local R = ViewerReq()
    if not R or not R.ShowWowheadLinks then return end
    local links = self:BuildWowheadLinks(it)
    if links and #links > 0 then
        R.ShowWowheadLinks(links)
        return true
    end
end

function IA:ViewItem(it)
    local itemID = GetItemID(it)
    if itemID and DressUpItemLink then
        DressUpItemLink("item:" .. tostring(itemID))
        return true
    end
end

function IA:Waypoint(it, context)
    local nav = GetNav(); if not nav or not nav.AddWaypoint then return end
    nav:AddWaypoint(it, context)
end

function IA:HandleMouseUp(it, btn, context)
    if not it then return end

    local st = it.source and it.source.type
    if st == "event" then return end

    if IsControlKeyDown and IsControlKeyDown() then
        local R = ViewerReq()

        local aid = GetAchievementID(it)
        if not aid and R and R.GetRequirementLink then
            local req = R.GetRequirementLink(it)
            if req and req.kind == "achievement" then aid = tonumber(req.id) end
        end
        if aid and OpenAchievement(aid) then return end

        -- Ctrl+Click only works for achievements, do nothing for other types
        return
    end

    if IsAltKeyDown and IsAltKeyDown() then
        if self:ShowWowheadPopup(it) then return end
    end

    if btn == "RightButton" then
        self:Waypoint(it, context)
        return
    end

    self:ViewItem(it)
end

function IA:AttachTooltip(frame, data)
    local tt = GetTT()
    if tt and tt.Attach then
        tt:Attach(frame, data)
    end
end

function IA:Bind(frame, data, context)
    if not frame or not data then return end

    frame._hdIAData = data
    frame._hdIAContext = context

    if frame.RegisterForClicks and not frame._hdIAClicks then
        frame._hdIAClicks = true
        frame:RegisterForClicks("AnyUp")
    end

    self:AttachTooltip(frame, data)

    if frame._hdIABound then return end
    frame._hdIABound = true

    frame:SetScript("OnMouseUp", function(self, btn)
        local d = self._hdIAData
        if not d then return end
        IA:HandleMouseUp(d, btn, self._hdIAContext)
    end)
end

return IA