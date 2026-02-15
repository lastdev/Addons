-- Endeavors UI Module
-- Embedded Housing Endeavors tracker (C_NeighborhoodInitiative)

local ADDON_NAME, ns = ...
local L = ns.L

local EndeavorsUI = {}
EndeavorsUI.__index = EndeavorsUI

EndeavorsUI._parentFrame = EndeavorsUI._parentFrame or nil
EndeavorsUI._container = EndeavorsUI._container or nil
EndeavorsUI._scrollFrame = EndeavorsUI._scrollFrame or nil
EndeavorsUI._scrollChild = EndeavorsUI._scrollChild or nil
EndeavorsUI._rows = EndeavorsUI._rows or {}
EndeavorsUI._milestoneTicks = EndeavorsUI._milestoneTicks or {}

EndeavorsUI._endeavorInfo = EndeavorsUI._endeavorInfo or {
    seasonName = "",
    daysRemaining = 0,
    currentProgress = 0,
    maxProgress = 0,
    milestones = {},
}
EndeavorsUI._tasks = EndeavorsUI._tasks or {}

EndeavorsUI._viewCharacterKey = EndeavorsUI._viewCharacterKey or nil -- nil/"CURRENT" for live, or "<Name>-<Realm>"

-- TEMP: Blizzard API for activity log / house level is unreliable across builds.
-- Hide these panels for now and let the tasks list fill the full width.
local DISABLE_ACTIVITY_AND_HOUSE_PANELS = true

local function Now()
    return (_G.time and _G.time()) or 0
end

local function GetCharacterKey()
    local name = _G.UnitName and _G.UnitName("player") or nil
    local realm = _G.GetRealmName and _G.GetRealmName() or nil
    if not name or not realm then
        return nil
    end
    return tostring(name) .. "-" .. tostring(realm)
end

local function GetEndeavorsDB()
    if type(HousingDB) ~= "table" then
        return nil
    end
    HousingDB.endeavors = HousingDB.endeavors or {}
    local db = HousingDB.endeavors
    db.schemaVersion = db.schemaVersion or 1
    db.characters = db.characters or {}
    db.ui = db.ui or {}
    if db.ui.selectedCharacter == nil then
        db.ui.selectedCharacter = "CURRENT"
    end
    return db
end

local function SetNavButtonsVisible(visible)
    local buttons = _G["HousingNavButtons"]
    if type(buttons) ~= "table" then
        return
    end
    for _, btn in ipairs(buttons) do
        if btn and btn.SetShown then
            btn:SetShown(visible)
        end
    end
end

local modelViewerWasVisible = false

local function SetMainUIVisible(visible)
    if _G["HousingFilterFrame"] then
        _G["HousingFilterFrame"]:SetShown(visible)
    end
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:SetShown(visible)
    end
    if _G["HousingItemListContainer"] then
        _G["HousingItemListContainer"]:SetShown(visible)
    end
    if _G["HousingItemListHeader"] then
        _G["HousingItemListHeader"]:SetShown(visible)
    end
    if _G["HousingPreviewFrame"] then
        _G["HousingPreviewFrame"]:SetShown(visible)
    end

    local modelFrame = _G["HousingModelViewerFrame"]
    if not visible then
        modelViewerWasVisible = modelFrame and modelFrame:IsShown() or false
        if modelFrame then
            modelFrame:Hide()
        elseif _G["HousingModelViewer"] and _G["HousingModelViewer"].Hide then
            _G["HousingModelViewer"]:Hide()
        end
    elseif modelViewerWasVisible and modelFrame then
        modelFrame:Show()
    end

    SetNavButtonsVisible(visible)
end

local function ThemeColors()
    local theme = HousingTheme or {}
    local c = theme.Colors or {}
    return {
        bgTertiary = c.bgTertiary or { 0.1, 0.1, 0.1, 1 },
        bgSecondary = c.bgSecondary or { 0.08, 0.08, 0.08, 1 },
        bgHover = c.bgHover or { 0.2, 0.2, 0.2, 1 },
        borderPrimary = c.borderPrimary or { 0.3, 0.3, 0.3, 1 },
        accentPrimary = c.accentPrimary or { 0.2, 0.7, 0.7, 1 },
        textPrimary = c.textPrimary or { 1, 1, 1, 1 },
        textMuted = c.textMuted or { 0.7, 0.7, 0.7, 1 },
        textHighlight = c.textHighlight or { 1, 0.82, 0, 1 },
        statusSuccess = c.statusSuccess or { 0.2, 0.9, 0.2, 1 },
        accentGold = c.accentGold or { 1, 0.84, 0, 1 },
    }
end

local function ParseProgressFromRequirementText(requirementText)
    if type(requirementText) ~= "string" then
        return nil, nil
    end
    local cur, max = requirementText:match("(%d+)%s*/%s*(%d+)")
    if cur and max then
        return tonumber(cur) or 0, tonumber(max) or 0
    end
    return nil, nil
end

local function FindArrayField(info, firstElementKey)
    if type(info) ~= "table" then
        return nil
    end
    for _, v in pairs(info) do
        if type(v) == "table" and #v > 0 and type(v[1]) == "table" and v[1][firstElementKey] ~= nil then
            return v
        end
    end
    return nil
end

local function FindArrayFieldAny(info, keys)
    if type(info) ~= "table" or type(keys) ~= "table" then
        return nil
    end
    for _, v in pairs(info) do
        if type(v) == "table" and #v > 0 and type(v[1]) == "table" then
            for i = 1, #keys do
                local k = keys[i]
                if v[1][k] ~= nil then
                    return v
                end
            end
        end
    end
    return nil
end

local function FindArrayDeep(root, predicate, maxDepth)
    if type(root) ~= "table" or type(predicate) ~= "function" then
        return nil
    end
    maxDepth = tonumber(maxDepth) or 4
    if maxDepth < 0 then
        return nil
    end

    local visited = {}
    local queue = { { t = root, d = 0 } }
    visited[root] = true

    while #queue > 0 do
        local node = table.remove(queue, 1)
        local t = node.t
        local d = node.d

        if type(t) == "table" then
            if predicate(t) then
                return t
            end
            if d < maxDepth then
                for _, v in pairs(t) do
                    if type(v) == "table" and not visited[v] then
                        visited[v] = true
                        queue[#queue + 1] = { t = v, d = d + 1 }
                    end
                end
            end
        end
    end

    return nil
end

local function IsTaskArray(tbl)
    if type(tbl) ~= "table" or #tbl == 0 or type(tbl[1]) ~= "table" then
        return false
    end
    local e = tbl[1]
    return (e.taskName ~= nil or e.name ~= nil or e.taskType ~= nil) and (e.ID ~= nil or e.id ~= nil or e.rewardQuestID ~= nil)
end

local function IsMilestoneArray(tbl)
    if type(tbl) ~= "table" or #tbl == 0 or type(tbl[1]) ~= "table" then
        return false
    end
    local e = tbl[1]
    return (e.requiredContributionAmount ~= nil) or (e.threshold ~= nil)
end

local function IsActivityArray(tbl)
    if type(tbl) ~= "table" or #tbl == 0 or type(tbl[1]) ~= "table" then
        return false
    end
    local e = tbl[1]
    return (e.entryText ~= nil) or (e.characterName ~= nil and e.taskName ~= nil) or (e.timestamp ~= nil and (e.text ~= nil or e.entryText ~= nil))
end

local function RequestActivityLog()
    if DISABLE_ACTIVITY_AND_HOUSE_PANELS then
        return
    end

    if not (C_NeighborhoodInitiative and C_NeighborhoodInitiative.RequestInitiativeActivityLog) then
        return
    end
    local ok = pcall(C_NeighborhoodInitiative.RequestInitiativeActivityLog)
    if ok then
        return
    end
    -- Some builds may require a neighborhood identifier; try to derive one.
    if C_NeighborhoodInitiative.GetActiveNeighborhood then
        local ok2, neighborhood = pcall(C_NeighborhoodInitiative.GetActiveNeighborhood)
        if ok2 and type(neighborhood) == "table" then
            local id = neighborhood.neighborhoodID or neighborhood.id or neighborhood.neighborhoodId
            if id then
                pcall(C_NeighborhoodInitiative.RequestInitiativeActivityLog, id)
            end
        end
    end
end

local function SafeSetTooltipOwner(frame)
    if not (GameTooltip and GameTooltip.SetOwner) then
        return false
    end
    GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
    return true
end

local function AddTooltipLine(text, r, g, b, wrap)
    if not (GameTooltip and GameTooltip.AddLine) then
        return
    end
    GameTooltip:AddLine(tostring(text or ""), r or 1, g or 1, b or 1, wrap == true)
end

function EndeavorsUI:Initialize(parent)
    self._parentFrame = parent

    if not self._eventFrame then
        self._eventFrame = CreateFrame("Frame")
        self._eventFrame:SetScript("OnEvent", function(_, event, ...)
            self:OnEvent(event, ...)
        end)
    end

    local db = GetEndeavorsDB()
    if db and db.ui and db.ui.selectedCharacter then
        self._viewCharacterKey = db.ui.selectedCharacter
    end
end

function EndeavorsUI:_StartEventHandlers()
    if not self._eventFrame then
        return
    end
    if self._eventHandlersActive then
        return
    end
    self._eventHandlersActive = true
    self._eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self._eventFrame:RegisterEvent("NEIGHBORHOOD_INITIATIVE_UPDATED")
    self._eventFrame:RegisterEvent("INITIATIVE_TASKS_TRACKED_UPDATED")
    self._eventFrame:RegisterEvent("INITIATIVE_TASKS_TRACKED_LIST_CHANGED")
    self._eventFrame:RegisterEvent("INITIATIVE_ACTIVITY_LOG_UPDATED")
    self._eventFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")

    -- House level/favor updates (C_Housing) - guard for cross-version safety
    if not C_EventUtils or not C_EventUtils.IsEventValid
       or C_EventUtils.IsEventValid("HOUSE_LEVEL_FAVOR_UPDATED") then
        self._eventFrame:RegisterEvent("HOUSE_LEVEL_FAVOR_UPDATED")
    end
    if not C_EventUtils or not C_EventUtils.IsEventValid
       or C_EventUtils.IsEventValid("HOUSE_LEVEL_CHANGED") then
        self._eventFrame:RegisterEvent("HOUSE_LEVEL_CHANGED")
    end
end

function EndeavorsUI:_StopEventHandlers()
    if not self._eventFrame then
        return
    end
    if not self._eventHandlersActive then
        return
    end
    self._eventHandlersActive = false
    self._eventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    self._eventFrame:UnregisterEvent("NEIGHBORHOOD_INITIATIVE_UPDATED")
    self._eventFrame:UnregisterEvent("INITIATIVE_TASKS_TRACKED_UPDATED")
    self._eventFrame:UnregisterEvent("INITIATIVE_TASKS_TRACKED_LIST_CHANGED")
    self._eventFrame:UnregisterEvent("INITIATIVE_ACTIVITY_LOG_UPDATED")
    self._eventFrame:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")

    self._eventFrame:UnregisterEvent("HOUSE_LEVEL_FAVOR_UPDATED")
    self._eventFrame:UnregisterEvent("HOUSE_LEVEL_CHANGED")
end

function EndeavorsUI:_IsViewingCurrent()
    return (self._viewCharacterKey == nil) or (self._viewCharacterKey == "CURRENT") or (self._viewCharacterKey == GetCharacterKey())
end

function EndeavorsUI:_SetSelectedCharacter(key)
    local db = GetEndeavorsDB()
    if db and db.ui then
        db.ui.selectedCharacter = key
    end
    self._viewCharacterKey = key
end

function EndeavorsUI:_GetSnapshotForCharacter(charKey)
    local db = GetEndeavorsDB()
    if not (db and db.characters and charKey) then
        return nil
    end
    return db.characters[charKey]
end

function EndeavorsUI:_SaveCurrentCharacterSnapshot()
    local db = GetEndeavorsDB()
    local charKey = GetCharacterKey()
    if not (db and db.characters and charKey) then
        return
    end

    local info = self._endeavorInfo or {}
    local tasks = self._tasks or {}

    local taskCopy = {}
    for i = 1, #tasks do
        local t = tasks[i]
        taskCopy[i] = {
            id = t.id,
            name = t.name,
            description = t.description,
            points = t.points,
            completed = t.completed,
            current = t.current,
            max = t.max,
            tracked = t.tracked,
            sortOrder = t.sortOrder,
            timesCompleted = t.timesCompleted,
            isRepeatable = t.isRepeatable,
            rewardQuestID = t.rewardQuestID,
            couponReward = t.couponReward,
        }
    end

    db.characters[charKey] = {
        key = charKey,
        name = (_G.UnitName and _G.UnitName("player")) or "",
        realm = (_G.GetRealmName and _G.GetRealmName()) or "",
        class = select(2, _G.UnitClass and _G.UnitClass("player") or "") or "",
        lastUpdated = Now(),
        endeavor = {
            seasonName = info.seasonName,
            description = info.description,
            daysRemaining = info.daysRemaining,
            currentProgress = info.currentProgress,
            maxProgress = info.maxProgress,
            milestones = info.milestones,
        },
        tasks = taskCopy,
        activity = nil,
    }
end

function EndeavorsUI:CreateContainer()
    if self._container then
        return self._container
    end

    local parentFrame = self._parentFrame
    if not parentFrame then
        return nil
    end

    local colors = ThemeColors()

    local container = CreateFrame("Frame", "HousingVendorEndeavorsContainer", parentFrame)
    container:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -70)
    container:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -20, 52)
    container:Hide()

    local backBtn = CreateFrame("Button", nil, container, "BackdropTemplate")
    backBtn:SetSize(100, 30)
    backBtn:SetPoint("TOPLEFT", 10, -10)
    backBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    backBtn:SetBackdropColor(colors.bgTertiary[1], colors.bgTertiary[2], colors.bgTertiary[3], colors.bgTertiary[4])
    backBtn:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], colors.borderPrimary[4])

    local backText = backBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    backText:SetPoint("CENTER")
    backText:SetText(L["BUTTON_BACK"] or "Back")
    backText:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
    backBtn.label = backText

    backBtn:SetScript("OnEnter", function(selfBtn)
        selfBtn:SetBackdropColor(colors.bgHover[1], colors.bgHover[2], colors.bgHover[3], colors.bgHover[4])
        selfBtn:SetBackdropBorderColor(colors.accentPrimary[1], colors.accentPrimary[2], colors.accentPrimary[3], 1)
        selfBtn.label:SetTextColor(colors.textHighlight[1], colors.textHighlight[2], colors.textHighlight[3], 1)
    end)
    backBtn:SetScript("OnLeave", function(selfBtn)
        selfBtn:SetBackdropColor(colors.bgTertiary[1], colors.bgTertiary[2], colors.bgTertiary[3], colors.bgTertiary[4])
        selfBtn:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], colors.borderPrimary[4])
        selfBtn.label:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
    end)
    backBtn:SetScript("OnClick", function()
        EndeavorsUI:Hide()
        if _G.HousingUINew and _G.HousingUINew.ReturnToCaller then
            _G.HousingUINew:ReturnToCaller()
        end
    end)

    local refreshBtn = CreateFrame("Button", nil, container, "BackdropTemplate")
    refreshBtn:SetSize(90, 30)
    refreshBtn:SetPoint("TOPRIGHT", -10, -10)
    refreshBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    refreshBtn:SetBackdropColor(colors.bgTertiary[1], colors.bgTertiary[2], colors.bgTertiary[3], colors.bgTertiary[4])
    refreshBtn:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], colors.borderPrimary[4])

    local refreshText = refreshBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    refreshText:SetPoint("CENTER")
    refreshText:SetText(L["ENDEAVORS_REFRESH"] or "Refresh")
    refreshText:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
    refreshBtn.label = refreshText

    refreshBtn:SetScript("OnEnter", function(selfBtn)
        selfBtn:SetBackdropColor(colors.bgHover[1], colors.bgHover[2], colors.bgHover[3], colors.bgHover[4])
        selfBtn:SetBackdropBorderColor(colors.accentPrimary[1], colors.accentPrimary[2], colors.accentPrimary[3], 1)
        selfBtn.label:SetTextColor(colors.textHighlight[1], colors.textHighlight[2], colors.textHighlight[3], 1)
    end)
    refreshBtn:SetScript("OnLeave", function(selfBtn)
        selfBtn:SetBackdropColor(colors.bgTertiary[1], colors.bgTertiary[2], colors.bgTertiary[3], colors.bgTertiary[4])
        selfBtn:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], colors.borderPrimary[4])
        selfBtn.label:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
    end)
    refreshBtn:SetScript("OnClick", function()
        EndeavorsUI:FetchEndeavorData(false)
        RequestActivityLog()
        EndeavorsUI:_SaveCurrentCharacterSnapshot()
        EndeavorsUI:Refresh()
    end)

    local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("|cFFFFD700" .. (L["ENDEAVORS_TITLE"] or "Housing Endeavors") .. "|r")

    local charBtn = CreateFrame("Button", nil, container, "BackdropTemplate")
    charBtn:SetSize(220, 30)
    charBtn:SetPoint("TOPLEFT", backBtn, "TOPRIGHT", 8, 0)
    charBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    charBtn:SetBackdropColor(colors.bgTertiary[1], colors.bgTertiary[2], colors.bgTertiary[3], colors.bgTertiary[4])
    charBtn:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], colors.borderPrimary[4])

    local charBtnText = charBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    charBtnText:SetPoint("LEFT", 8, 0)
    charBtnText:SetPoint("RIGHT", -18, 0)
    charBtnText:SetJustifyH("LEFT")
    charBtnText:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
    charBtn.label = charBtnText

    local charArrow = charBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    charArrow:SetPoint("RIGHT", -8, 0)
    charArrow:SetText("v")
    charArrow:SetTextColor(colors.textMuted[1], colors.textMuted[2], colors.textMuted[3], 1)

    charBtn:SetScript("OnEnter", function(selfBtn)
        selfBtn:SetBackdropColor(colors.bgHover[1], colors.bgHover[2], colors.bgHover[3], colors.bgHover[4])
        selfBtn:SetBackdropBorderColor(colors.accentPrimary[1], colors.accentPrimary[2], colors.accentPrimary[3], 1)
    end)
    charBtn:SetScript("OnLeave", function(selfBtn)
        selfBtn:SetBackdropColor(colors.bgTertiary[1], colors.bgTertiary[2], colors.bgTertiary[3], colors.bgTertiary[4])
        selfBtn:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], colors.borderPrimary[4])
    end)
    charBtn:SetScript("OnClick", function()
        EndeavorsUI:ShowCharacterMenu(charBtn)
    end)
    container.charBtn = charBtn

    local header = CreateFrame("Frame", nil, container)
    header:SetPoint("TOPLEFT", 10, -50)
    header:SetPoint("TOPRIGHT", -10, -50)
    header:SetHeight(86)

    local seasonText = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    seasonText:SetPoint("TOPLEFT", 0, 0)
    seasonText:SetJustifyH("LEFT")
    seasonText:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
    container.seasonText = seasonText

    local daysText = header:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    daysText:SetPoint("TOPRIGHT", 0, -2)
    daysText:SetJustifyH("RIGHT")
    daysText:SetTextColor(colors.textMuted[1], colors.textMuted[2], colors.textMuted[3], 1)
    container.daysText = daysText

    local couponsText = header:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    couponsText:SetPoint("TOPRIGHT", daysText, "BOTTOMRIGHT", 0, -2)
    couponsText:SetJustifyH("RIGHT")
    couponsText:SetTextColor(colors.accentGold[1], colors.accentGold[2], colors.accentGold[3], 1)
    container.couponsText = couponsText

    local descText = header:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    descText:SetPoint("TOPLEFT", seasonText, "BOTTOMLEFT", 0, -4)
    descText:SetPoint("RIGHT", -10, 0)
    descText:SetJustifyH("LEFT")
    descText:SetWordWrap(true)
    descText:SetTextColor(colors.textMuted[1], colors.textMuted[2], colors.textMuted[3], 1)
    container.descriptionText = descText

    local progressBg = CreateFrame("Frame", nil, header, "BackdropTemplate")
    progressBg:SetPoint("TOPLEFT", descText, "BOTTOMLEFT", 0, -8)
    progressBg:SetPoint("TOPRIGHT", 0, 0)
    progressBg:SetHeight(16)
    progressBg:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    progressBg:SetBackdropColor(colors.bgSecondary[1], colors.bgSecondary[2], colors.bgSecondary[3], 0.9)
    progressBg:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], 0.7)

    local progressBar = CreateFrame("StatusBar", nil, progressBg)
    progressBar:SetAllPoints()
    progressBar:SetStatusBarTexture("Interface\\Buttons\\WHITE8x8")
    progressBar:SetStatusBarColor(colors.accentPrimary[1], colors.accentPrimary[2], colors.accentPrimary[3], 0.8)
    progressBar:SetMinMaxValues(0, 1)
    progressBar:SetValue(0)
    container.progressBar = progressBar

    local progressText = progressBg:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    progressText:SetPoint("CENTER", 0, 0)
    progressText:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
    container.progressText = progressText

    local taskHeader = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    taskHeader:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -8)
    taskHeader:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
    taskHeader:SetText(L["ENDEAVORS_TASKS"] or "Endeavor Tasks")

    local contentArea = CreateFrame("Frame", nil, container)
    contentArea:SetPoint("TOPLEFT", taskHeader, "BOTTOMLEFT", 0, -6)
    contentArea:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 0)

    local rightWidth = DISABLE_ACTIVITY_AND_HOUSE_PANELS and 0 or 320
    local rightGap = rightWidth > 0 and (rightWidth + 10) or 0

    local rightColumn = nil
    if rightWidth > 0 then
        rightColumn = CreateFrame("Frame", nil, contentArea)
        rightColumn:SetPoint("TOPRIGHT", 0, 0)
        rightColumn:SetPoint("BOTTOMRIGHT", 0, 0)
        rightColumn:SetWidth(rightWidth)
    end
    container.rightColumn = rightColumn

    local tasksPanel = CreateFrame("Frame", nil, contentArea, "BackdropTemplate")
    tasksPanel:SetPoint("TOPLEFT", 0, 0)
    tasksPanel:SetPoint("BOTTOMLEFT", 0, 0)
    tasksPanel:SetPoint("RIGHT", contentArea, "RIGHT", -rightGap, 0)
    tasksPanel:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    tasksPanel:SetBackdropColor(colors.bgSecondary[1], colors.bgSecondary[2], colors.bgSecondary[3], 0.25)
    tasksPanel:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], 0.5)
    container.contentArea = contentArea
    container.tasksPanel = tasksPanel

    if rightColumn then
        local activityPanel = CreateFrame("Frame", nil, rightColumn, "BackdropTemplate")
        activityPanel:SetPoint("TOPLEFT", 0, 0)
        activityPanel:SetPoint("TOPRIGHT", 0, 0)
        activityPanel:SetHeight(230)
        activityPanel:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false,
            edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 },
        })
        activityPanel:SetBackdropColor(colors.bgSecondary[1], colors.bgSecondary[2], colors.bgSecondary[3], 0.25)
        activityPanel:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], 0.5)
        container.activityPanel = activityPanel

        local housePanel = CreateFrame("Frame", nil, rightColumn, "BackdropTemplate")
        housePanel:SetPoint("BOTTOMLEFT", 0, 0)
        housePanel:SetPoint("BOTTOMRIGHT", 0, 0)
        housePanel:SetHeight(210)
        housePanel:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false,
            edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 },
        })
        housePanel:SetBackdropColor(colors.bgSecondary[1], colors.bgSecondary[2], colors.bgSecondary[3], 0.25)
        housePanel:SetBackdropBorderColor(colors.borderPrimary[1], colors.borderPrimary[2], colors.borderPrimary[3], 0.5)
        container.housePanel = housePanel

        -- Layout is managed dynamically in RefreshActivity/RefreshHouseLevel.
        activityPanel:ClearAllPoints()
        activityPanel:SetPoint("TOPLEFT", 0, 0)
        activityPanel:SetPoint("TOPRIGHT", 0, 0)
        activityPanel:SetPoint("BOTTOMLEFT", housePanel, "TOPLEFT", 0, 10)
        activityPanel:SetPoint("BOTTOMRIGHT", housePanel, "TOPRIGHT", 0, 10)

        local activityHeader = activityPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        activityHeader:SetPoint("TOPLEFT", 10, -8)
        activityHeader:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
        activityHeader:SetText(L["ENDEAVORS_ACTIVITY"] or "Activity")
        container.activityHeader = activityHeader

        local activityScrollFrame = CreateFrame("ScrollFrame", nil, activityPanel, "UIPanelScrollFrameTemplate")
        activityScrollFrame:SetPoint("TOPLEFT", activityHeader, "BOTTOMLEFT", 0, -6)
        activityScrollFrame:SetPoint("BOTTOMRIGHT", activityPanel, "BOTTOMRIGHT", -30, 8)
        container.activityScrollFrame = activityScrollFrame

        local activityChild = CreateFrame("Frame", nil, activityScrollFrame)
        activityChild:SetPoint("TOPLEFT", 0, 0)
        activityChild:SetPoint("TOPRIGHT", 0, 0)
        activityChild:SetWidth(activityScrollFrame:GetWidth())
        activityChild:SetHeight(1)
        activityScrollFrame:SetScrollChild(activityChild)
        self._activityScrollChild = activityChild
        self._activityRows = self._activityRows or {}
        activityScrollFrame:HookScript("OnSizeChanged", function(selfFrame)
            if activityChild and activityChild.SetWidth then
                activityChild:SetWidth(selfFrame:GetWidth())
            end
        end)

        local houseHeader = housePanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        houseHeader:SetPoint("TOPLEFT", 10, -8)
        houseHeader:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
        houseHeader:SetText(L["HOUSE_LEVEL_TITLE"] or "House Level")
        container.houseHeader = houseHeader

        local houseLevelText = housePanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        houseLevelText:SetPoint("TOPLEFT", houseHeader, "BOTTOMLEFT", 0, -8)
        houseLevelText:SetPoint("RIGHT", -10, 0)
        houseLevelText:SetJustifyH("LEFT")
        houseLevelText:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
        container.houseLevelText = houseLevelText

        local favorText = housePanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        favorText:SetPoint("TOPLEFT", houseLevelText, "BOTTOMLEFT", 0, -4)
        favorText:SetPoint("RIGHT", -10, 0)
        favorText:SetJustifyH("LEFT")
        favorText:SetTextColor(colors.textMuted[1], colors.textMuted[2], colors.textMuted[3], 1)
        container.houseFavorText = favorText

        local rewardsTitle = housePanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        rewardsTitle:SetPoint("TOPLEFT", favorText, "BOTTOMLEFT", 0, -8)
        rewardsTitle:SetPoint("RIGHT", -10, 0)
        rewardsTitle:SetJustifyH("LEFT")
        rewardsTitle:SetTextColor(colors.textPrimary[1], colors.textPrimary[2], colors.textPrimary[3], 1)
        rewardsTitle:SetText(L["HOUSE_LEVEL_REWARDS"] or "Next Level Rewards")
        container.houseRewardsTitle = rewardsTitle

        local rewardsText = housePanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        rewardsText:SetPoint("TOPLEFT", rewardsTitle, "BOTTOMLEFT", 0, -4)
        rewardsText:SetPoint("RIGHT", -10, 0)
        rewardsText:SetJustifyH("LEFT")
        rewardsText:SetWordWrap(true)
        rewardsText:SetTextColor(colors.textMuted[1], colors.textMuted[2], colors.textMuted[3], 1)
        container.houseRewardsText = rewardsText
    end

    local scrollFrame = CreateFrame("ScrollFrame", nil, tasksPanel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", tasksPanel, "BOTTOMRIGHT", -30, 8)
    self._scrollFrame = scrollFrame

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetPoint("TOPLEFT", 0, 0)
    scrollChild:SetPoint("TOPRIGHT", 0, 0)
    scrollChild:SetWidth(scrollFrame:GetWidth())
    scrollChild:SetHeight(1)
    scrollFrame:SetScrollChild(scrollChild)
    self._scrollChild = scrollChild
    scrollFrame:HookScript("OnSizeChanged", function(selfFrame)
        if scrollChild and scrollChild.SetWidth then
            scrollChild:SetWidth(selfFrame:GetWidth())
        end
    end)

    self._container = container
    return container
end

local function AcquireTaskRow(scrollChild, index)
    scrollChild._hvEndeavorRowPool = scrollChild._hvEndeavorRowPool or {}
    local pool = scrollChild._hvEndeavorRowPool
    if pool[index] then
        return pool[index]
    end

    local colors = ThemeColors()

    local row = CreateFrame("Button", nil, scrollChild, "BackdropTemplate")
    row:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    row:SetBackdropColor(0.08, 0.08, 0.08, 0.9)
    row:SetBackdropBorderColor(0.25, 0.25, 0.25, 1)

    row.check = row:CreateTexture(nil, "OVERLAY")
    row.check:SetSize(18, 18)
    row.check:SetPoint("LEFT", 8, 0)
    row.check:Hide()

    row.track = row:CreateTexture(nil, "OVERLAY")
    row.track:SetSize(16, 16)
    row.track:SetPoint("LEFT", row.check, "RIGHT", 6, 0)
    row.track:SetTexture("Interface\\MINIMAP\\TRACKING\\None")
    row.track:Hide()

    row.nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    row.nameText:SetPoint("TOPLEFT", row.track, "TOPRIGHT", 8, -4)
    row.nameText:SetPoint("RIGHT", -130, 0)
    row.nameText:SetJustifyH("LEFT")
    row.nameText:SetWordWrap(false)

    row.descText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.descText:SetPoint("TOPLEFT", row.nameText, "BOTTOMLEFT", 0, -2)
    row.descText:SetPoint("RIGHT", row.nameText, "RIGHT", 0, 0)
    row.descText:SetJustifyH("LEFT")
    row.descText:SetWordWrap(true)

    row.progressText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.progressText:SetPoint("BOTTOMLEFT", row.nameText, "BOTTOMLEFT", 0, -2)
    row.progressText:SetJustifyH("LEFT")
    row.progressText:SetTextColor(colors.textMuted[1], colors.textMuted[2], colors.textMuted[3], 1)

    row.pointsText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.pointsText:SetPoint("TOPRIGHT", -10, -4)
    row.pointsText:SetJustifyH("RIGHT")
    row.pointsText:SetTextColor(colors.accentGold[1], colors.accentGold[2], colors.accentGold[3], 1)

    row.rewardText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.rewardText:SetPoint("TOPRIGHT", row.pointsText, "BOTTOMRIGHT", 0, -2)
    row.rewardText:SetJustifyH("RIGHT")
    row.rewardText:SetTextColor(colors.textMuted[1], colors.textMuted[2], colors.textMuted[3], 1)

    row:SetScript("OnEnter", function(selfBtn)
        selfBtn:SetBackdropColor(colors.bgHover[1], colors.bgHover[2], colors.bgHover[3], 0.8)
        selfBtn:SetBackdropBorderColor(colors.accentPrimary[1], colors.accentPrimary[2], colors.accentPrimary[3], 0.8)

        local task = selfBtn._hvTask
        if not task then
            return
        end
        if not SafeSetTooltipOwner(selfBtn) then
            return
        end

        AddTooltipLine(task.name or "Endeavor Task", 1, 0.82, 0, true)
        if task.description and task.description ~= "" then
            AddTooltipLine(task.description, 0.85, 0.85, 0.85, true)
        end
        AddTooltipLine(" ", 1, 1, 1, false)

        local pts = tonumber(task.points) or 0
        if pts > 0 then
            AddTooltipLine(string.format("Progress: +%d", pts), 0.25, 0.9, 0.9, false)
        end

        if task.max and tonumber(task.max) and tonumber(task.max) > 1 then
            AddTooltipLine(string.format("Progress: %d / %d", tonumber(task.current) or 0, tonumber(task.max) or 0), 0.9, 0.9, 0.9, false)
        else
            AddTooltipLine("Completed: " .. tostring(task.completed == true), 0.9, 0.9, 0.9, false)
        end

        if task.isRepeatable ~= nil then
            AddTooltipLine("Repeatable: " .. tostring(task.isRepeatable == true), 0.7, 0.7, 0.7, false)
        end

        if task.rewardQuestID and tonumber(task.rewardQuestID) and tonumber(task.rewardQuestID) > 0 then
            AddTooltipLine("Reward Quest ID: " .. tostring(task.rewardQuestID), 0.7, 0.7, 0.7, false)
        end

        local couponReward = tonumber(task.couponReward) or 0
        if couponReward > 0 then
            AddTooltipLine(string.format("Estimated Coupons: %d", couponReward), 1, 0.84, 0, false)
        end

        if type(task.requirementsList) == "table" and #task.requirementsList > 0 then
            AddTooltipLine(" ", 1, 1, 1, false)
            AddTooltipLine("Requirements:", 0.8, 0.8, 0.8, false)
            for i = 1, math.min(6, #task.requirementsList) do
                local req = task.requirementsList[i]
                if type(req) == "table" then
                    local rt = req.requirementText or req.text
                    if rt and rt ~= "" then
                        AddTooltipLine("- " .. tostring(rt), 0.85, 0.85, 0.85, true)
                    end
                elseif type(req) == "string" then
                    AddTooltipLine("- " .. req, 0.85, 0.85, 0.85, true)
                end
            end
        end

        AddTooltipLine(" ", 1, 1, 1, false)
        if EndeavorsUI._IsViewingCurrent and EndeavorsUI:_IsViewingCurrent() and C_NeighborhoodInitiative then
            AddTooltipLine("Left-click: Track/Untrack", 0.7, 0.7, 0.7, false)
        else
            AddTooltipLine("Viewing snapshot (read-only)", 0.7, 0.7, 0.7, false)
        end
        AddTooltipLine("Right-click: Link in chat", 0.7, 0.7, 0.7, false)
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", function(selfBtn)
        selfBtn:SetBackdropColor(0.08, 0.08, 0.08, 0.9)
        selfBtn:SetBackdropBorderColor(0.25, 0.25, 0.25, 1)
        GameTooltip:Hide()
    end)
    row:SetScript("OnClick", function(selfBtn)
        if not EndeavorsUI:_IsViewingCurrent() then
            return
        end
        if not selfBtn._hvTask or not C_NeighborhoodInitiative then
            return
        end
        local task = selfBtn._hvTask
        if task.id and C_NeighborhoodInitiative.AddTrackedInitiativeTask and C_NeighborhoodInitiative.RemoveTrackedInitiativeTask then
            if task.tracked then
                C_NeighborhoodInitiative.RemoveTrackedInitiativeTask(task.id)
                task.tracked = false
            else
                C_NeighborhoodInitiative.AddTrackedInitiativeTask(task.id)
                task.tracked = true
            end
            EndeavorsUI:_SaveCurrentCharacterSnapshot()
            if EndeavorsUI._container and EndeavorsUI._container.IsShown and EndeavorsUI._container:IsShown() then
                EndeavorsUI:Refresh()
            end
        end
    end)

    row:SetScript("OnMouseUp", function(selfBtn, button)
        if button ~= "RightButton" then
            return
        end
        local task = selfBtn._hvTask
        if not (task and task.id and C_NeighborhoodInitiative and C_NeighborhoodInitiative.GetInitiativeTaskChatLink) then
            return
        end
        local link = C_NeighborhoodInitiative.GetInitiativeTaskChatLink(task.id)
        if link then
            ChatEdit_InsertLink(link)
        end
    end)
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    pool[index] = row
    return row
end

function EndeavorsUI:UpdateMilestones(container, milestones, maxProgress)
    maxProgress = tonumber(maxProgress) or 0
    if not (container and container.progressBar) then
        return
    end

    container.progressBar:ClearAllPoints()
    container.progressBar:SetAllPoints()

    for _, tick in ipairs(self._milestoneTicks) do
        if tick and tick.Hide then
            tick:Hide()
        end
    end

    if type(milestones) ~= "table" or maxProgress <= 0 then
        return
    end

    local i = 0
    for _, m in ipairs(milestones) do
        local threshold = tonumber(m.threshold) or 0
        if threshold > 0 and threshold < maxProgress then
            i = i + 1
            local tick = self._milestoneTicks[i]
            if not tick then
                tick = container.progressBar:CreateTexture(nil, "OVERLAY")
                tick:SetTexture("Interface\\Buttons\\WHITE8x8")
                tick:SetWidth(1)
                tick:SetPoint("TOP", 0, 0)
                tick:SetPoint("BOTTOM", 0, 0)
                self._milestoneTicks[i] = tick
            end
            local pct = threshold / maxProgress
            tick:ClearAllPoints()
            tick:SetPoint("TOP", container.progressBar, "TOPLEFT", math.floor(container.progressBar:GetWidth() * pct + 0.5), 0)
            tick:SetPoint("BOTTOM", container.progressBar, "BOTTOMLEFT", math.floor(container.progressBar:GetWidth() * pct + 0.5), 0)
            if m.reached then
                tick:SetVertexColor(0.2, 1, 0.2, 0.9)
            else
                tick:SetVertexColor(1, 1, 1, 0.35)
            end
            tick:Show()
        end
    end
end

function EndeavorsUI:Refresh()
    local container = self._container or self:CreateContainer()
    if not (container and container:IsShown()) then
        return
    end

    local viewKey = self._viewCharacterKey or "CURRENT"
    local snapshot = nil
    local viewingAlt = (viewKey ~= "CURRENT" and viewKey ~= GetCharacterKey())
    if viewingAlt then
        snapshot = self:_GetSnapshotForCharacter(viewKey)
    end

    local info
    if viewingAlt and not snapshot then
        info = {
            seasonName = L["ENDEAVORS_NO_SNAPSHOT"] or "No saved snapshot for this character",
            daysRemaining = 0,
            currentProgress = 0,
            maxProgress = 0,
            milestones = {},
        }
    else
        info = (snapshot and snapshot.endeavor) or (self._endeavorInfo or {})
    end
    local seasonName = info.seasonName or (L["ENDEAVORS_TITLE"] or "Housing Endeavors")
    container.seasonText:SetText(seasonName)

    if container.descriptionText then
        container.descriptionText:SetText(info.description or "")
        container.descriptionText:SetShown((info.description or "") ~= "")
    end

    local daysRemaining = tonumber(info.daysRemaining) or 0
    if daysRemaining > 0 then
        container.daysText:SetText(string.format(L["ENDEAVORS_DAYS_REMAINING_FMT"] or "%d Days Remaining", daysRemaining))
    else
        container.daysText:SetText("")
    end

    local couponInfo = C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo and C_CurrencyInfo.GetCurrencyInfo(3363) or nil
    if couponInfo and couponInfo.quantity then
        container.couponsText:SetText(string.format(L["ENDEAVORS_COUPONS_FMT"] or "Coupons: %d", couponInfo.quantity))
    else
        container.couponsText:SetText("")
    end

    local cur = tonumber(info.currentProgress) or 0
    local max = tonumber(info.maxProgress) or 0
    if max <= 0 then max = 1 end
    container.progressBar:SetMinMaxValues(0, max)
    container.progressBar:SetValue(cur)
    container.progressText:SetText(string.format(L["ENDEAVORS_PROGRESS_FMT"] or "%d / %d", cur, max))

    self:UpdateMilestones(container, info.milestones, max)

    if container.charBtn and container.charBtn.label then
        local label = "Character: "
        if viewKey == "CURRENT" or viewKey == GetCharacterKey() then
            label = label .. (L["ENDEAVORS_CURRENT_CHARACTER"] or "Current")
        elseif snapshot and snapshot.name and snapshot.realm and snapshot.name ~= "" and snapshot.realm ~= "" then
            label = label .. tostring(snapshot.name) .. "-" .. tostring(snapshot.realm)
        else
            label = label .. tostring(viewKey)
        end
        container.charBtn.label:SetText(label)
    end

    local tasks
    if viewingAlt and not snapshot then
        tasks = {}
    else
        tasks = (snapshot and snapshot.tasks) or (self._tasks or {})
    end
    local scrollChild = self._scrollChild
    if not scrollChild then
        return
    end

    if scrollChild.emptyText then
        scrollChild.emptyText:Hide()
    end

    local rowHeight = 54
    local y = -2
    local used = 0

    for i = 1, #tasks do
        local task = tasks[i]
        used = used + 1
        local row = AcquireTaskRow(scrollChild, used)
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 2, y)
        row:SetPoint("TOPRIGHT", -2, y)
        row:SetHeight(rowHeight)

        row._hvTask = task

        row.nameText:SetText(task.name or "Unknown Task")
        row.descText:SetText(task.description or "")

        local progressStr = ""
        if task.max and task.max > 1 then
            progressStr = string.format("%d/%d", task.current or 0, task.max or 0)
        elseif task.completed then
            progressStr = L["ENDEAVORS_COMPLETED"] or "Completed"
        end
        row.progressText:SetText(progressStr)

        if task.completed then
            row.check:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
            row.check:Show()
        else
            row.check:Hide()
        end

        if task.tracked then
            row.track:SetTexture("Interface\\Minimap\\Tracking\\None")
            row.track:SetVertexColor(1, 0.82, 0, 0.9)
            row.track:Show()
        else
            row.track:Hide()
        end

        local points = tonumber(task.points) or 0
        if points > 0 then
            row.pointsText:SetText(string.format("+%d", points))
        else
            row.pointsText:SetText("")
        end

        local couponReward = tonumber(task.couponReward) or 0
        if couponReward > 0 then
            row.rewardText:SetText(string.format(L["ENDEAVORS_TASK_REWARD_FMT"] or "Reward: %d coupon(s)", couponReward))
        else
            row.rewardText:SetText("")
        end

        row:Show()
        y = y - (rowHeight + 6)
    end

    if used == 0 then
        if not scrollChild.emptyText then
            scrollChild.emptyText = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontDisable")
            scrollChild.emptyText:SetPoint("TOPLEFT", 10, -10)
            scrollChild.emptyText:SetPoint("RIGHT", -10, 0)
            scrollChild.emptyText:SetJustifyH("LEFT")
            scrollChild.emptyText:SetWordWrap(true)
        end
        local msg = L["ENDEAVORS_NO_TASKS"] or "No endeavor tasks found yet.\nTry opening the Housing Dashboard or press Refresh."
        if viewingAlt and not snapshot then
            msg = L["ENDEAVORS_NO_SNAPSHOT"] or "No saved snapshot for this character."
        end
        scrollChild.emptyText:SetText(msg)
        scrollChild.emptyText:Show()
        y = y - 50
    end

    if scrollChild._hvEndeavorRowPool then
        for i = used + 1, #scrollChild._hvEndeavorRowPool do
            local row = scrollChild._hvEndeavorRowPool[i]
            if row then
                row:Hide()
                row._hvTask = nil
            end
        end
    end

    scrollChild:SetHeight(math.abs(y) + 10)

    if DISABLE_ACTIVITY_AND_HOUSE_PANELS then
        self:_UpdateRightColumnLayout(false, false)
    else
        self:RefreshActivity(viewingAlt and snapshot or nil)
        self:RefreshHouseLevel()
    end
end

function EndeavorsUI:_UpdateRightColumnLayout(showActivity, showHouse)
    local container = self._container
    if not container then
        return
    end

    local rightColumn = container.rightColumn
    local tasksPanel = container.tasksPanel
    local contentArea = container.contentArea
    if not (tasksPanel and contentArea) then
        return
    end

    local needsRight = (showActivity == true) or (showHouse == true)

    if rightColumn and rightColumn.SetShown then
        rightColumn:SetShown(needsRight)
    end

    tasksPanel:ClearAllPoints()
    tasksPanel:SetPoint("TOPLEFT", contentArea, "TOPLEFT", 0, 0)
    tasksPanel:SetPoint("BOTTOMLEFT", contentArea, "BOTTOMLEFT", 0, 0)
    if needsRight then
        tasksPanel:SetPoint("RIGHT", contentArea, "RIGHT", -(320 + 10), 0)
    else
        tasksPanel:SetPoint("RIGHT", contentArea, "RIGHT", 0, 0)
    end

    local activityPanel = container.activityPanel
    local housePanel = container.housePanel
    if not (rightColumn and activityPanel and housePanel) then
        return
    end

    if showActivity and showHouse then
        housePanel:ClearAllPoints()
        housePanel:SetPoint("BOTTOMLEFT", rightColumn, "BOTTOMLEFT", 0, 0)
        housePanel:SetPoint("BOTTOMRIGHT", rightColumn, "BOTTOMRIGHT", 0, 0)
        housePanel:SetHeight(210)

        activityPanel:ClearAllPoints()
        activityPanel:SetPoint("TOPLEFT", rightColumn, "TOPLEFT", 0, 0)
        activityPanel:SetPoint("TOPRIGHT", rightColumn, "TOPRIGHT", 0, 0)
        activityPanel:SetPoint("BOTTOMLEFT", housePanel, "TOPLEFT", 0, 10)
        activityPanel:SetPoint("BOTTOMRIGHT", housePanel, "TOPRIGHT", 0, 10)
        return
    end

    if showActivity and not showHouse then
        activityPanel:ClearAllPoints()
        activityPanel:SetAllPoints(rightColumn)
        return
    end

    if showHouse and not showActivity then
        housePanel:ClearAllPoints()
        housePanel:SetAllPoints(rightColumn)
        return
    end
end

function EndeavorsUI:RefreshActivity(snapshotOrNil)
    local container = self._container
    if not (container and container.activityPanel and self._activityScrollChild) then
        return
    end

    local function DebugPrint(msg)
        if self.IsDebugEnabled and self:IsDebugEnabled() then
            if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                _G.HousingVendorLog:Info("Endeavors: " .. tostring(msg))
            end
        end
    end

    local activity = nil
    if snapshotOrNil and snapshotOrNil.activity then
        activity = snapshotOrNil.activity
    else
        -- Try API first (different builds expose different getters).
        if C_NeighborhoodInitiative then
            if C_NeighborhoodInitiative.GetInitiativeActivityLogInfo then
                local ok, v = pcall(C_NeighborhoodInitiative.GetInitiativeActivityLogInfo)
                if ok then activity = v end
            elseif C_NeighborhoodInitiative.GetInitiativeActivityLog then
                local ok, v = pcall(C_NeighborhoodInitiative.GetInitiativeActivityLog)
                if ok then activity = v end
            end
        end
        -- Fallback: attempt to find activity list on the initiative info.
        if type(activity) ~= "table" then
            local info = C_NeighborhoodInitiative and C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo and C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo() or nil
            activity = FindArrayFieldAny(info, { "entryText", "timestamp", "characterName", "taskName" }) or FindArrayDeep(info, IsActivityArray, 5)
        end
    end

    local list = {}
    if type(activity) == "table" then
        if type(activity.entries) == "table" then
            list = activity.entries
        elseif type(activity.activityLog) == "table" then
            list = activity.activityLog
        elseif type(activity.log) == "table" then
            list = activity.log
        else
            list = activity
        end
    end

    local haveEntries = type(list) == "table" and #list > 0
    local showHouse = container.housePanel and container.housePanel.IsShown and container.housePanel:IsShown() or false
    local showActivityPanel = true -- show panel with empty-state if API provides nothing

    if container.activityPanel and container.activityPanel.SetShown then
        container.activityPanel:SetShown(showActivityPanel)
    end

    self:_UpdateRightColumnLayout(showActivityPanel, showHouse)

    local scrollChild = self._activityScrollChild
    if scrollChild.emptyText then
        scrollChild.emptyText:Hide()
    end

    if not haveEntries then
        if not scrollChild.emptyText then
            scrollChild.emptyText = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontDisable")
            scrollChild.emptyText:SetPoint("TOPLEFT", 10, -10)
            scrollChild.emptyText:SetPoint("RIGHT", -10, 0)
            scrollChild.emptyText:SetJustifyH("LEFT")
            scrollChild.emptyText:SetWordWrap(true)
        end
        local msg = L["ENDEAVORS_NO_ACTIVITY"] or "No activity data available."
        if snapshotOrNil then
            msg = L["ENDEAVORS_NO_ACTIVITY_SNAPSHOT"] or "No saved activity for this character."
        end
        scrollChild.emptyText:SetText(msg)
        scrollChild.emptyText:Show()
        scrollChild:SetHeight(60)
        return
    end

    -- Persist latest activity to current character snapshot (best-effort)
    if not snapshotOrNil and self:_IsViewingCurrent() then
        local db = GetEndeavorsDB()
        local key = GetCharacterKey()
        if db and key and db.characters and db.characters[key] then
            db.characters[key].activity = list
        end
    end

    local taskNameByID = {}
    local sourceTasks = (snapshotOrNil and snapshotOrNil.tasks) or self._tasks or {}
    if type(sourceTasks) == "table" then
        for i = 1, #sourceTasks do
            local t = sourceTasks[i]
            if t and t.id and t.name then
                taskNameByID[tonumber(t.id) or t.id] = t.name
            end
        end
    end

    local function FirstUsefulString(tbl)
        if type(tbl) ~= "table" then
            return nil
        end
        for k, v in pairs(tbl) do
            if type(v) == "string" and v ~= "" then
                local lk = tostring(k):lower()
                if lk:find("text", 1, true) or lk:find("message", 1, true) or lk:find("desc", 1, true) then
                    return v
                end
            end
        end
        for _, v in pairs(tbl) do
            if type(v) == "string" and v ~= "" then
                return v
            end
        end
        return nil
    end

    local function ExtractActivityText(entry)
        if type(entry) == "string" then
            return entry
        end
        if type(entry) ~= "table" then
            return nil
        end

        local text =
            entry.entryText or
            entry.text or
            entry.message or
            entry.activityText or
            entry.displayText or
            entry.description
        if text and text ~= "" then
            return text
        end

        local who =
            entry.characterName or
            entry.playerName or
            entry.name or
            entry.sourceName or
            entry.completedByName

        local taskName =
            entry.taskName or
            entry.title or
            entry.objectiveName or
            entry.initiativeTaskName

        local taskID =
            entry.taskID or
            entry.initiativeTaskID or
            entry.taskId or
            entry.initiativeTaskId
        if (not taskName or taskName == "") and taskID then
            taskName = taskNameByID[tonumber(taskID) or taskID]
        end

        if who and taskName then
            return tostring(who) .. " " .. (L["ENDEAVORS_ACTIVITY_COMPLETED"] or "completed") .. " \"" .. tostring(taskName) .. "\""
        end

        return FirstUsefulString(entry)
    end

    local rows = self._activityRows or {}
    self._activityRows = rows

    local rowH = 26
    local y = -2

    for i = 1, #list do
        local entry = list[i]
        local row = rows[i]
        if not row then
            row = CreateFrame("Frame", nil, scrollChild)
            row:SetHeight(rowH)
            row.icon = row:CreateTexture(nil, "OVERLAY")
            row.icon:SetSize(16, 16)
            row.icon:SetPoint("LEFT", 6, 0)
            row.icon:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")

            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
            row.text:SetPoint("RIGHT", -6, 0)
            row.text:SetJustifyH("LEFT")
            row.text:SetWordWrap(false)
            row:EnableMouse(true)
            row:SetScript("OnEnter", function(selfRow)
                local t = selfRow._hvActivityText
                if not t or t == "" then
                    return
                end
                if not SafeSetTooltipOwner(selfRow) then
                    return
                end
                AddTooltipLine("Activity", 1, 0.82, 0, false)
                AddTooltipLine(t, 0.85, 0.85, 0.85, true)
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function()
                if GameTooltip and GameTooltip.Hide then
                    GameTooltip:Hide()
                end
            end)
            rows[i] = row
        end

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 0, y)
        row:SetPoint("TOPRIGHT", 0, y)

        local text = ExtractActivityText(entry) or ""
        row._hvActivityText = text
        row.text:SetText(text)
        if i == 1 then
            DebugPrint("activity[1] text=" .. tostring(text))
        end

        row:Show()
        y = y - rowH
    end

    for i = #list + 1, #rows do
        rows[i]:Hide()
    end

    scrollChild:SetHeight(math.abs(y) + 10)
end

function EndeavorsUI:RefreshHouseLevel()
    local container = self._container
    if not (container and container.housePanel) then
        return
    end

    -- Only show house level for the current character (live data).
    local show = true
    if not self:_IsViewingCurrent() then
        show = false
    end
    if not (C_Housing and (C_Housing.GetCurrentHouseLevelFavor or C_Housing.GetHouseLevelFavorForLevel)) then
        show = false
    end
    container.housePanel:SetShown(show)
    local showActivity = container.activityPanel and container.activityPanel.IsShown and container.activityPanel:IsShown() or false
    self:_UpdateRightColumnLayout(showActivity, show)
    if not show then
        return
    end

    local function TryCall(name)
        local fn = C_Housing and C_Housing[name]
        if type(fn) ~= "function" then
            return nil
        end
        local ok, v = pcall(fn)
        if not ok then
            return nil
        end
        return v
    end

    local currentLevel = nil
    local info = TryCall("GetCurrentHouseLevelInfo") or TryCall("GetHouseLevelInfo") or TryCall("GetHouseInfo") or TryCall("GetPlayerHouseInfo")
    if type(info) == "table" then
        currentLevel = info.houseLevel or info.level or info.currentLevel
    end
    if type(currentLevel) ~= "number" then
        local v = TryCall("GetCurrentHouseLevel") or TryCall("GetHouseLevel")
        if type(v) == "number" then
            currentLevel = v
        end
    end

    local currentFavor = 0
    if C_Housing.GetCurrentHouseLevelFavor then
        local ok, v = pcall(C_Housing.GetCurrentHouseLevelFavor)
        if ok and type(v) == "number" then
            currentFavor = v
        end
    end

    local nextLevel = (type(currentLevel) == "number" and currentLevel + 1) or nil
    local nextFavorReq = nil
    if nextLevel and C_Housing.GetHouseLevelFavorForLevel then
        local ok, v = pcall(C_Housing.GetHouseLevelFavorForLevel, nextLevel)
        if ok and type(v) == "number" then
            nextFavorReq = v
        end
    end

    if container.houseLevelText then
        if type(currentLevel) == "number" then
            container.houseLevelText:SetText(string.format(L["HOUSE_LEVEL_FMT"] or "House Level: %d", currentLevel))
        else
            container.houseLevelText:SetText(L["HOUSE_LEVEL_FMT_UNKNOWN"] or "House Level: ?")
        end
    end

    if container.houseFavorText then
        if nextFavorReq and nextFavorReq > 0 then
            container.houseFavorText:SetText(string.format(L["HOUSE_FAVOR_FMT"] or "Favor: %d / %d", currentFavor, nextFavorReq))
        else
            container.houseFavorText:SetText(string.format(L["HOUSE_FAVOR_ONLY_FMT"] or "Favor: %d", currentFavor))
        end
    end

    local rewardsLines = {}
    if nextLevel and C_Housing.GetHouseLevelRewardsForLevel then
        local ok, rewards = pcall(C_Housing.GetHouseLevelRewardsForLevel, nextLevel)
        if ok and type(rewards) == "table" then
            for i = 1, math.min(6, #rewards) do
                local r = rewards[i]
                if type(r) == "string" then
                    rewardsLines[#rewardsLines + 1] = "- " .. r
                elseif type(r) == "table" then
                    local name = r.name
                    if not name and r.itemID and _G.GetItemInfo then
                        name = _G.GetItemInfo(r.itemID)
                    end
                    if not name and r.currencyID and _G.C_CurrencyInfo and _G.C_CurrencyInfo.GetCurrencyInfo then
                        local info = _G.C_CurrencyInfo.GetCurrencyInfo(r.currencyID)
                        name = info and info.name
                    end
                    name = name or (r.itemID and ("Item " .. tostring(r.itemID))) or (r.currencyID and ("Currency " .. tostring(r.currencyID))) or (r.rewardType and tostring(r.rewardType)) or "Reward"
                    rewardsLines[#rewardsLines + 1] = "- " .. tostring(name)
                end
            end
        end
    end
    if #rewardsLines == 0 then
        rewardsLines[1] = L["HOUSE_LEVEL_REWARDS_NONE"] or "- (No data)"
    end
    if container.houseRewardsText then
        container.houseRewardsText:SetText(table.concat(rewardsLines, "\n"))
    end

    container.housePanel:SetShown(true)

    if not container.housePanel._hvTooltipBound then
        container.housePanel._hvTooltipBound = true
        container.housePanel:EnableMouse(true)
        container.housePanel:SetScript("OnEnter", function(panel)
            if not SafeSetTooltipOwner(panel) then
                return
            end
            AddTooltipLine("House Level", 1, 0.82, 0, false)
            AddTooltipLine(container.houseLevelText and container.houseLevelText:GetText() or "", 0.9, 0.9, 0.9, false)
            AddTooltipLine(container.houseFavorText and container.houseFavorText:GetText() or "", 0.85, 0.85, 0.85, false)
            AddTooltipLine(" ", 1, 1, 1, false)
            AddTooltipLine(container.houseRewardsTitle and container.houseRewardsTitle:GetText() or "Rewards", 0.8, 0.8, 0.8, false)
            local rewards = container.houseRewardsText and container.houseRewardsText:GetText() or ""
            if rewards ~= "" then
                AddTooltipLine(rewards, 0.85, 0.85, 0.85, true)
            end
            GameTooltip:Show()
        end)
        container.housePanel:SetScript("OnLeave", function()
            if GameTooltip and GameTooltip.Hide then
                GameTooltip:Hide()
            end
        end)
    end
end

function EndeavorsUI:Show()
    local container = self._container or self:CreateContainer()
    if not container then
        return
    end

    if HousingAchievementsUI and HousingAchievementsUI.Hide then
        HousingAchievementsUI:Hide()
    end
    if HousingReputationUI and HousingReputationUI.Hide then
        HousingReputationUI:Hide()
    end
    if HousingStatisticsUI and HousingStatisticsUI.Hide then
        HousingStatisticsUI:Hide()
    end
    if HousingAuctionHouseUI and HousingAuctionHouseUI.Hide then
        HousingAuctionHouseUI:Hide()
    end
    if HousingPlanUI and HousingPlanUI.Hide then
        HousingPlanUI:Hide()
    end

    SetMainUIVisible(false)

    container:Show()
    self:_StartEventHandlers()
    self:FetchEndeavorData(false)
    RequestActivityLog()
    self:_SaveCurrentCharacterSnapshot()
    self:Refresh()
end

function EndeavorsUI:Hide()
    if self._container then
        self._container:Hide()
    end
    self:_StopEventHandlers()
    SetMainUIVisible(true)
end

function EndeavorsUI:OnEvent(event)
    if event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(2, function()
            self:FetchEndeavorData(false)
            RequestActivityLog()
            self:_SaveCurrentCharacterSnapshot()
            if self._container and self._container:IsShown() then
                self:Refresh()
            end
        end)
        return
    end

    if event == "NEIGHBORHOOD_INITIATIVE_UPDATED" then
        self:FetchEndeavorData(true)
        RequestActivityLog()
        self:_SaveCurrentCharacterSnapshot()
        if self._container and self._container:IsShown() then
            self:Refresh()
        end
        return
    end

    if event == "INITIATIVE_TASKS_TRACKED_UPDATED" or event == "INITIATIVE_TASKS_TRACKED_LIST_CHANGED" then
        self:RefreshTrackedTasks()
        self:_SaveCurrentCharacterSnapshot()
        if self._container and self._container:IsShown() then
            self:Refresh()
        end
        return
    end

    if event == "INITIATIVE_ACTIVITY_LOG_UPDATED" then
        if self._container and self._container:IsShown() then
            self:Refresh()
        end
        return
    end

    if event == "HOUSE_LEVEL_FAVOR_UPDATED" or event == "HOUSE_LEVEL_CHANGED" then
        if self._container and self._container:IsShown() then
            self:Refresh()
        end
        return
    end

    if event == "CURRENCY_DISPLAY_UPDATE" then
        if self._container and self._container:IsShown() then
            self:FetchEndeavorData(true)
            self:_SaveCurrentCharacterSnapshot()
            self:Refresh()
        end
        return
    end
end

function EndeavorsUI:GetTaskProgress(task)
    if task and task.requirementsList and #task.requirementsList > 0 then
        local req = task.requirementsList[1]
        if req and req.requirementText then
            local cur = ParseProgressFromRequirementText(req.requirementText)
            if cur then
                return cur
            end
        end
    end
    return (task and task.completed) and 1 or 0
end

function EndeavorsUI:GetTaskMax(task)
    if task and task.requirementsList and #task.requirementsList > 0 then
        local req = task.requirementsList[1]
        if req and req.requirementText then
            local _, max = ParseProgressFromRequirementText(req.requirementText)
            if max then
                return max
            end
        end
    end
    return 1
end

function EndeavorsUI:GetTaskCouponReward(task)
    if not (task and task.rewardQuestID and task.rewardQuestID > 0) then
        return 0
    end
    if C_QuestLog and C_QuestLog.GetQuestRewardCurrencies then
        local rewards = C_QuestLog.GetQuestRewardCurrencies(task.rewardQuestID)
        if rewards then
            for _, reward in ipairs(rewards) do
                if reward.currencyID == 3363 then
                    local baseReward = reward.totalRewardAmount or 0
                    local timesCompleted = task.timesCompleted or 0
                    return math.max(1, baseReward - timesCompleted)
                end
            end
        end
    end
    return 0
end

function EndeavorsUI:LoadPlaceholderData()
    self._endeavorInfo = {
        seasonName = "Reaching Beyond the Possible",
        daysRemaining = 40,
        currentProgress = 185,
        maxProgress = 500,
        milestones = {
            { threshold = 100, reached = true },
            { threshold = 200, reached = false },
            { threshold = 350, reached = false },
            { threshold = 500, reached = false },
        },
    }

    self._tasks = {
        {
            id = 1,
            name = "Home: Complete Weekly Neighborhood Quests",
            description = "Complete weekly quests in your neighborhood",
            points = 50,
            completed = false,
            current = 0,
            max = 1,
            isRepeatable = false,
        },
        {
            id = 2,
            name = "Home: Be a Good Neighbor",
            description = "Help your neighbors with various tasks",
            points = 50,
            completed = false,
            current = 0,
            max = 1,
            isRepeatable = false,
        },
        {
            id = 3,
            name = "Daily Quests",
            description = "Complete daily quests",
            points = 50,
            completed = true,
            current = 1,
            max = 1,
            isRepeatable = true,
        },
    }
end

function EndeavorsUI:RefreshTrackedTasks()
    if not (C_NeighborhoodInitiative and C_NeighborhoodInitiative.GetTrackedInitiativeTasks) then
        return
    end
    local trackedInfo = C_NeighborhoodInitiative.GetTrackedInitiativeTasks()
    if not (trackedInfo and trackedInfo.trackedIDs and type(trackedInfo.trackedIDs) == "table") then
        return
    end
    local trackedIDs = trackedInfo.trackedIDs
    local tasks = self._tasks or {}
    for i = 1, #tasks do
        local t = tasks[i]
        if t and t.id then
            t.tracked = tContains(trackedIDs, t.id)
        end
    end
end

function EndeavorsUI:ProcessInitiativeInfo(info)
    local daysRemaining = 0
    if info and info.duration and info.duration > 0 then
        daysRemaining = math.floor(info.duration / 86400)
    end

    local milestones = {}
    local maxProgress = 0
    local rawMilestones = info and info.milestones
    if type(rawMilestones) ~= "table" then
        rawMilestones = FindArrayField(info, "requiredContributionAmount") or FindArrayDeep(info, IsMilestoneArray, 5)
    end
    if type(rawMilestones) == "table" then
        for _, milestone in ipairs(rawMilestones) do
            local threshold = milestone.requiredContributionAmount or 0
            maxProgress = math.max(maxProgress, threshold)
            milestones[#milestones + 1] = {
                threshold = threshold,
                reached = (info.currentProgress or 0) >= threshold,
                rewards = milestone.rewards,
            }
        end
    end
    if maxProgress == 0 then
        maxProgress = (info and info.progressRequired) or 100
    end

    self._endeavorInfo = {
        seasonName = (info and info.title) or (L["ENDEAVORS_TITLE"] or "Housing Endeavors"),
        description = (info and info.description) or "",
        daysRemaining = daysRemaining,
        currentProgress = (info and info.currentProgress) or 0,
        maxProgress = maxProgress,
        milestones = milestones,
    }

    local tasks = {}
    local rawTasks = info and info.tasks
    if type(rawTasks) ~= "table" then
        rawTasks = FindArrayFieldAny(info, { "taskName", "taskType", "rewardQuestID", "supersedes" }) or FindArrayDeep(info, IsTaskArray, 6)
    end

    if type(rawTasks) == "table" then
        for _, task in ipairs(rawTasks) do
            if not task.supersedes or task.supersedes == 0 then
                local isRepeatable = task.taskType and task.taskType > 0
                tasks[#tasks + 1] = {
                    id = task.ID or task.id,
                    name = task.taskName or task.name,
                    description = task.description or task.taskDescription or "",
                    points = task.progressContributionAmount or 0,
                    completed = task.completed or false,
                    current = self:GetTaskProgress(task),
                    max = self:GetTaskMax(task),
                    taskType = task.taskType,
                    tracked = task.tracked or false,
                    sortOrder = task.sortOrder or 999,
                    requirementsList = task.requirementsList,
                    timesCompleted = task.timesCompleted,
                    isRepeatable = isRepeatable,
                    rewardQuestID = task.rewardQuestID,
                    couponReward = self:GetTaskCouponReward(task),
                }
            end
        end

        table.sort(tasks, function(a, b)
            if a.completed ~= b.completed then
                return not a.completed
            end
            return (a.sortOrder or 999) < (b.sortOrder or 999)
        end)
    end

    self._tasks = tasks
    self:RefreshTrackedTasks()
end

function EndeavorsUI:FetchEndeavorData(skipRequest)
    local function DebugPrint(msg)
        if self.IsDebugEnabled and self:IsDebugEnabled() then
            if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                _G.HousingVendorLog:Info("Endeavors: " .. tostring(msg))
            end
        end
    end

    if not C_NeighborhoodInitiative then
        DebugPrint("C_NeighborhoodInitiative missing; showing placeholder")
        self:LoadPlaceholderData()
        return
    end

    if not C_NeighborhoodInitiative.IsInitiativeEnabled or not C_NeighborhoodInitiative.IsInitiativeEnabled() then
        DebugPrint("IsInitiativeEnabled=false; showing placeholder")
        self:LoadPlaceholderData()
        return
    end

    if C_NeighborhoodInitiative.PlayerMeetsRequiredLevel and not C_NeighborhoodInitiative.PlayerMeetsRequiredLevel() then
        DebugPrint("PlayerMeetsRequiredLevel=false; showing placeholder")
        self:LoadPlaceholderData()
        return
    end

    if C_NeighborhoodInitiative.PlayerHasInitiativeAccess and not C_NeighborhoodInitiative.PlayerHasInitiativeAccess() then
        DebugPrint("PlayerHasInitiativeAccess=false; showing placeholder")
        self:LoadPlaceholderData()
        return
    end

    if not skipRequest and C_NeighborhoodInitiative.RequestNeighborhoodInitiativeInfo then
        DebugPrint("RequestNeighborhoodInitiativeInfo()")
        C_NeighborhoodInitiative.RequestNeighborhoodInitiativeInfo()
    end

    if not C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo then
        DebugPrint("GetNeighborhoodInitiativeInfo missing; showing placeholder")
        self:LoadPlaceholderData()
        return
    end

    local info = C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo()
    if not (info and info.isLoaded) then
        DebugPrint("initiativeInfo not loaded yet")
        return
    end

    if info.initiativeID == 0 then
        DebugPrint("initiativeID=0 (no active endeavor)")
        self._endeavorInfo = {
            seasonName = L["ENDEAVORS_NO_ACTIVE"] or "No Active Endeavor",
            description = "",
            daysRemaining = 0,
            currentProgress = 0,
            maxProgress = 0,
            milestones = {},
        }
        self._tasks = {}
        return
    end

    self:ProcessInitiativeInfo(info)
    DebugPrint("tasksAfterProcess=" .. tostring(type(self._tasks) == "table" and #self._tasks or 0))

    -- Some builds populate tasks a tick later even when `isLoaded` is true.
    if (not self._tasks or #self._tasks == 0) and not self._hvRetryScheduled then
        self._hvRetryScheduled = true
        C_Timer.After(0.75, function()
            self._hvRetryScheduled = false
            self:FetchEndeavorData(true)
            self:_SaveCurrentCharacterSnapshot()
            if self._container and self._container:IsShown() then
                self:Refresh()
            end
        end)
    end
end

function EndeavorsUI:ShowCharacterMenu(anchorButton)
    if not anchorButton then
        return
    end

    local db = GetEndeavorsDB()
    local chars = {}
    if db and db.characters then
        for key, c in pairs(db.characters) do
            if type(c) == "table" and key then
                chars[#chars + 1] = {
                    key = key,
                    name = c.name or "",
                    realm = c.realm or "",
                    lastUpdated = c.lastUpdated or 0,
                }
            end
        end
    end

    table.sort(chars, function(a, b)
        local an = (a.name or "") .. "-" .. (a.realm or "")
        local bn = (b.name or "") .. "-" .. (b.realm or "")
        return an:lower() < bn:lower()
    end)

    local menu = CreateFrame("Frame", nil, anchorButton, "BackdropTemplate")
    menu:SetFrameStrata("DIALOG")
    menu:SetFrameLevel(200)
    menu:SetSize(260, math.min(320, 60 + (#chars * 28)))
    menu:SetPoint("TOPLEFT", anchorButton, "BOTTOMLEFT", 0, -2)
    menu:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    menu:SetBackdropColor(0.1, 0.1, 0.1, 0.95)
    menu:SetBackdropBorderColor(0.2, 0.7, 0.7, 1)

    local scrollFrame = CreateFrame("ScrollFrame", nil, menu, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 5, -5)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 5)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetSize(scrollFrame:GetWidth(), 1)
    scrollFrame:SetScrollChild(scrollChild)

    local function AddOption(text, value, yOffset)
        local btn = CreateFrame("Button", nil, scrollChild, "BackdropTemplate")
        btn:SetSize(215, 24)
        btn:SetPoint("TOPLEFT", 5, yOffset)
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            tile = false,
            insets = { left = 0, right = 0, top = 0, bottom = 0 },
        })
        btn:SetBackdropColor(0.15, 0.15, 0.15, 1)

        local fs = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("LEFT", 8, 0)
        fs:SetText(text)

        if value == (EndeavorsUI._viewCharacterKey or "CURRENT") then
            fs:SetTextColor(1, 0.82, 0, 1)
        else
            fs:SetTextColor(1, 1, 1, 1)
        end

        btn:SetScript("OnEnter", function(selfBtn) selfBtn:SetBackdropColor(0.25, 0.25, 0.25, 1) end)
        btn:SetScript("OnLeave", function(selfBtn) selfBtn:SetBackdropColor(0.15, 0.15, 0.15, 1) end)
        btn:SetScript("OnClick", function()
            EndeavorsUI:_SetSelectedCharacter(value)
            EndeavorsUI:Refresh()
            menu:Hide()
        end)
    end

    local yOffset = -5
    AddOption(L["ENDEAVORS_CURRENT_CHARACTER"] or "Current", "CURRENT", yOffset)
    yOffset = yOffset - 28

    for _, c in ipairs(chars) do
        local label = (c.name ~= "" and c.realm ~= "") and (c.name .. "-" .. c.realm) or c.key
        AddOption(label, c.key, yOffset)
        yOffset = yOffset - 28
    end

    scrollChild:SetHeight(math.abs(yOffset) + 10)

    local clickCatcher = CreateFrame("Frame", nil, UIParent)
    clickCatcher:SetAllPoints(UIParent)
    clickCatcher:SetFrameStrata("DIALOG")
    clickCatcher:SetFrameLevel(199)
    clickCatcher:EnableMouse(true)
    clickCatcher:SetScript("OnMouseDown", function()
        if menu and menu.Hide then
            menu:Hide()
        end
    end)

    menu:SetScript("OnShow", function()
        if clickCatcher and clickCatcher.Show then
            clickCatcher:Show()
        end
    end)
    menu:SetScript("OnHide", function(selfMenu)
        if clickCatcher and clickCatcher.Hide then
            clickCatcher:Hide()
            clickCatcher:SetParent(nil)
        end
        selfMenu:SetParent(nil)
    end)

    menu:Show()
end

function EndeavorsUI:SetDebug(enabled)
    local db = GetEndeavorsDB()
    if db then
        db.debug = enabled == true
    end
end

function EndeavorsUI:IsDebugEnabled()
    local db = GetEndeavorsDB()
    return db and db.debug == true
end

function EndeavorsUI:DebugDump()
    if not (C_NeighborhoodInitiative and C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo) then
        print("|cFFFF4040HousingVendor:|r Endeavors debug: C_NeighborhoodInitiative unavailable")
        return
    end
    local ok, info = pcall(C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo)
    if not ok then
        print("|cFFFF4040HousingVendor:|r Endeavors debug: GetNeighborhoodInitiativeInfo() errored")
        return
    end
    if type(info) ~= "table" then
        print("|cFFFF4040HousingVendor:|r Endeavors debug: initiativeInfo is not a table")
        return
    end

    local rawTasks = info.tasks
    local scanTasks = FindArrayFieldAny(info, { "taskName", "taskType", "rewardQuestID", "supersedes" }) or FindArrayDeep(info, IsTaskArray, 6)
    local rawMilestones = info.milestones
    local scanMilestones = FindArrayField(info, "requiredContributionAmount") or FindArrayDeep(info, IsMilestoneArray, 5)
    local scanActivity = FindArrayDeep(info, IsActivityArray, 5)

    local function Len(t)
        return type(t) == "table" and #t or 0
    end
    local function Keys(t)
        if type(t) ~= "table" then return "" end
        local out = {}
        for k in pairs(t) do
            if type(k) == "string" then
                out[#out + 1] = k
            end
        end
        table.sort(out)
        return table.concat(out, ",")
    end

    print("|cFF8A7FD4HousingVendor:|r Endeavors debug dump")
    print("  isLoaded=" .. tostring(info.isLoaded) .. " initiativeID=" .. tostring(info.initiativeID) .. " title=" .. tostring(info.title))
    print("  currentProgress=" .. tostring(info.currentProgress) .. " progressRequired=" .. tostring(info.progressRequired) .. " duration=" .. tostring(info.duration))
    print("  tasks: raw=" .. tostring(type(rawTasks)) .. " #" .. tostring(Len(rawTasks)) .. " scanned=#" .. tostring(Len(scanTasks)))
    if type(rawTasks) == "table" and rawTasks[1] then
        print("  tasks[1] keys(raw)=" .. Keys(rawTasks[1]))
    end
    if type(scanTasks) == "table" and scanTasks[1] then
        print("  tasks[1] keys(scan)=" .. Keys(scanTasks[1]))
    end
    print("  milestones: raw=" .. tostring(type(rawMilestones)) .. " #" .. tostring(Len(rawMilestones)) .. " scanned=#" .. tostring(Len(scanMilestones)))
    if type(scanMilestones) == "table" and scanMilestones[1] then
        print("  milestones[1] keys(scan)=" .. Keys(scanMilestones[1]))
    end
    print("  activity scanned=#" .. tostring(Len(scanActivity)))
    if type(scanActivity) == "table" and scanActivity[1] then
        print("  activity[1] keys(scan)=" .. Keys(scanActivity[1]))
    end
end

local function Trim(s)
    if type(s) ~= "string" then return "" end
    return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

function EndeavorsUI:DebugTasks(filter)
    if not (C_NeighborhoodInitiative and C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo) then
        print("|cFFFF4040HousingVendor:|r Endeavors tasks: C_NeighborhoodInitiative unavailable")
        return
    end

    local rawFilter = Trim(tostring(filter or ""))
    local lowerFilter = rawFilter:lower()
    local keywordMode = (lowerFilter == "debug") or (lowerFilter:find("debug", 1, true) ~= nil)

    local keywords = nil
    if keywordMode then
        keywords = { "lumber", "harvest", "rare" }
    end

    local couponQty = nil
    if C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
        local ok, ci = pcall(C_CurrencyInfo.GetCurrencyInfo, 3363)
        if ok and ci and ci.quantity then
            couponQty = ci.quantity
        end
    end

    print("|cFF8A7FD4HousingVendor:|r Endeavors tasks")
    print("  filter=" .. (rawFilter ~= "" and rawFilter or "(none)") .. " coupons=" .. tostring(couponQty))

    local ok, info = pcall(C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo)
    if not ok or type(info) ~= "table" then
        print("|cFFFF4040HousingVendor:|r Endeavors tasks: GetNeighborhoodInitiativeInfo() failed")
        return
    end

    local tasks = FindArrayFieldAny(info, { "taskName", "taskType", "rewardQuestID", "supersedes" }) or FindArrayDeep(info, IsTaskArray, 6) or {}
    if type(tasks) ~= "table" or #tasks == 0 then
        print("  no tasks found (open Housing Dashboard to sync)")
        return
    end

    local function Matches(taskName, taskDesc)
        if rawFilter == "" then
            return true
        end
        local hay = (tostring(taskName or "") .. " " .. tostring(taskDesc or "")):lower()
        if keywords then
            for _, k in ipairs(keywords) do
                if hay:find(k, 1, true) then
                    return true
                end
            end
            return false
        end
        return hay:find(lowerFilter, 1, true) ~= nil
    end

    local shown = 0
    for _, t in ipairs(tasks) do
        local id = t.ID or t.id or t.taskID or t.taskId
        local taskName = t.taskName or t.name or t.title
        local taskDesc = t.taskDescription or t.description or t.desc
        if Matches(taskName, taskDesc) then
            shown = shown + 1

            local rewardQuestID = tonumber(t.rewardQuestID) or 0
            local timesCompleted = tonumber(t.timesCompleted) or 0
            local points = tonumber(t.progressContributionAmount or t.points) or 0
            local isRepeatable = (t.taskType and tonumber(t.taskType) and tonumber(t.taskType) > 0) or (t.isRepeatable == true)

            local couponReward = 0
            if rewardQuestID > 0 then
                couponReward = self:GetTaskCouponReward({ rewardQuestID = rewardQuestID, timesCompleted = timesCompleted })
            end

            local reqText = nil
            if type(t.requirementsList) == "table" and t.requirementsList[1] and t.requirementsList[1].requirementText then
                reqText = t.requirementsList[1].requirementText
            end

            print(string.format("  #%d id=%s points=%d coupons=%d repeatable=%s", shown, tostring(id), points, couponReward, tostring(isRepeatable)))
            print("    " .. tostring(taskName))
            if taskDesc and taskDesc ~= "" then
                print("    " .. tostring(taskDesc))
            end
            if reqText and reqText ~= "" then
                print("    req: " .. tostring(reqText))
            end
            if rewardQuestID > 0 then
                print("    rewardQuestID=" .. tostring(rewardQuestID) .. " timesCompleted=" .. tostring(timesCompleted))
                if C_QuestLog and C_QuestLog.GetQuestRewardCurrencies then
                    local okR, rewards = pcall(C_QuestLog.GetQuestRewardCurrencies, rewardQuestID)
                    if okR and type(rewards) == "table" and #rewards > 0 then
                        for _, r in ipairs(rewards) do
                            local cid = r.currencyID or r.currencyId
                            local amt = r.totalRewardAmount or r.quantity or r.amount
                            if cid and amt then
                                print("    currency: id=" .. tostring(cid) .. " amount=" .. tostring(amt))
                            end
                        end
                    end
                end
            end
        end
    end

    if shown == 0 then
        print("  no tasks matched filter")
    end
end

_G["HousingEndeavorsUI"] = EndeavorsUI
return EndeavorsUI
