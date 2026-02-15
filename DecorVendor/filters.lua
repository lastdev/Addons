local addonName, dv = ...


function dv.BuildVendorFilters()
    local parent = dv.sidebarFilters

    -- wipe old
    for _, child in ipairs({ parent:GetChildren() }) do
        child:Hide()
        child:SetParent(nil)
    end

    local y = -6
    local HEADER_X = 12
    local CHECKBOX_X = 20
    local SPACING = 20

    local function Header(text)
        local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("TOPLEFT", HEADER_X, y)
        fs:SetTextColor(1, 0.82, 0)
        fs:SetText(text)
        y = y - 20
    end

    local function Checkbox(label, tbl, key)
        tbl[key] = tbl[key] or false
        local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
        cb:SetPoint("TOPLEFT", CHECKBOX_X, y)
        cb.Text:SetText(label)
        cb:SetChecked(tbl[key])
        cb:SetScript("OnClick", function(self)
            tbl[key] = self:GetChecked()
			dv.filtersJustChanged = true
            BuildVendorUI()
        end)
        y = y - SPACING
    end

-- EXPANSIONS
Header("Expansions")
selectedExpansions = selectedExpansions or {}

local seen = {}

-- discover which expansions are actually used
for _, vendor in ipairs(dv.npcs or {}) do
    local exp = vendor.expansion
    if exp then
        seen[exp] = true
    end
end

-- render in defined expansion order
for _, exp in ipairs(dv.EXPANSION_ORDER) do
    if seen[exp] then
        Checkbox(exp, selectedExpansions, exp)
    end
end


    y = y - 10

    -- FACTION
    Header("Faction")
    selectedFactions = selectedFactions or {}

    for _, f in ipairs({ "alliance", "horde", "neutral" }) do
        Checkbox(f, selectedFactions, f)
    end
end

function dv.BuildQuestFilters()
    local parent = dv.sidebarFilters

    for _, child in ipairs({ parent:GetChildren() }) do
        child:Hide()
        child:SetParent(nil)
    end

    local y = -6
    local HEADER_X = 12
    local CHECKBOX_X = 20
    local SPACING = 20

    local function Header(text)
        local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("TOPLEFT", HEADER_X, y)
        fs:SetTextColor(1, 0.82, 0)
        fs:SetText(text)
        y = y - 20
    end

    local function Checkbox(label, tbl, key)
        tbl[key] = tbl[key] or false
        local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
        cb:SetPoint("TOPLEFT", CHECKBOX_X, y)
        cb.Text:SetText(label)
        cb:SetChecked(tbl[key])
        cb:SetScript("OnClick", function(self)
            tbl[key] = self:GetChecked()
			dv.filtersJustChanged = true
            BuildVendorUI()
        end)
        y = y - SPACING
    end

    -- CATEGORIES
    Header("Categories")
    selectedQuests = selectedQuests or {}

    for _, group in ipairs(dv.quests or {}) do
        Checkbox(group.name, selectedQuests, group.name)
    end

    y = y - 10

    -- FACTIONS USED IN QUESTS
    Header("Faction")
    selectedFactionz = selectedFactionz or {}
    local found = {}

for _, group in ipairs(dv.quests or {}) do
    for _, quest in ipairs(group.quests or {}) do
        if quest.faction then
            found[string.lower(quest.faction)] = true
        end
    end
end


    for f,_ in pairs(found) do
        Checkbox(f, selectedFactionz, f)
    end
end

function dv.BuildProfessionFilters()
    local parent = dv.sidebarFilters

    for _, child in ipairs({ parent:GetChildren() }) do
        child:Hide()
        child:SetParent(nil)
    end

    local y = -6
    local HEADER_X = 12
    local CHECKBOX_X = 20
    local SPACING = 20

    local function Header(text)
        local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("TOPLEFT", HEADER_X, y)
        fs:SetTextColor(1, 0.82, 0)
        fs:SetText(text)
        y = y - 20
    end

    local function Checkbox(label, tbl, key)
        tbl[key] = tbl[key] or false
        local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
        cb:SetPoint("TOPLEFT", CHECKBOX_X, y)
        cb.Text:SetText(label)
        cb:SetChecked(tbl[key])
        cb:SetScript("OnClick", function(self)
            tbl[key] = self:GetChecked()
			dv.filtersJustChanged = true
            BuildVendorUI()
        end)
        y = y - SPACING
    end

    -- CATEGORIES
    Header("Categories")
    selectedProfessions = selectedProfessions or {}

    for _, group in ipairs(dv.professions or {}) do
        Checkbox(group.name, selectedProfessions, group.name)
    end

    y = y - 10
end

function dv.BuildAchievementFilters()
    local parent = dv.sidebarFilters

    for _, child in ipairs({ parent:GetChildren() }) do
        child:Hide()
        child:SetParent(nil)
    end

    local y = -6
    local HEADER_X = 12
    local CHECKBOX_X = 20
    local SPACING = 20

    local function Header(text)
        local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("TOPLEFT", HEADER_X, y)
        fs:SetTextColor(1, 0.82, 0)
        fs:SetText(text)
        y = y - 20
    end

    local function Checkbox(label, tbl, key)
        tbl[key] = tbl[key] or false
        local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
        cb:SetPoint("TOPLEFT", CHECKBOX_X, y)
        cb.Text:SetText(label)
        cb:SetChecked(tbl[key])
        cb:SetScript("OnClick", function(self)
            tbl[key] = self:GetChecked()
			dv.filtersJustChanged = true
            BuildVendorUI()
        end)
        y = y - SPACING
    end

    -- CATEGORIES
    Header("Categories")
    selectedAchievements = selectedAchievements or {}

    for _, group in ipairs(dv.achievements or {}) do
        Checkbox(group.name, selectedAchievements, group.name)
    end

    y = y - 10

    -- FACTION
    Header("Faction")
    selectedFactionz = selectedFactionz or {}
    local found = {}

for _, group in ipairs(dv.achievements or {}) do
    for _, achieve in ipairs(group.achievements or {}) do
        if achieve.faction then
            found[string.lower(achieve.faction)] = true
        end
    end
end


    for f,_ in pairs(found) do
        Checkbox(f, selectedFactionz, f)
    end
end

function dv.BuildBossDropFilters()
    local parent = dv.sidebarFilters

    -- wipe sidebar
    for _, child in ipairs({ parent:GetChildren() }) do
        child:Hide()
        child:SetParent(nil)
    end

    local y = -6

    -- Header builder
    local function Header(text)
        local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("TOPLEFT", 12, y)
        fs:SetTextColor(1, 0.82, 0)
        fs:SetText(text)
        y = y - 20
    end

    -- Checkbox builder
    local function Checkbox(label, tbl, key)
        tbl[key] = tbl[key] or false
        local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
        cb:SetPoint("TOPLEFT", 20, y)
        cb.Text:SetText(label)
        cb:SetChecked(tbl[key])

        cb:SetScript("OnClick", function(self)
            tbl[key] = self:GetChecked()
            dv.filtersJustChanged = true
            BuildVendorUI() -- refresh
        end)

        y = y - 20
    end

    ---------------------------------------------------------
    -- EXPANSIONS (ONLY FILTER WE USE)
    ---------------------------------------------------------
Header("Expansions")
selectedBossExpansions = selectedBossExpansions or {}

local seenExp = {}

-- discover which expansions are used by boss drops
for _, group in ipairs(dv.bossdrops or {}) do
    if group.expansion then
        seenExp[group.expansion] = true
    end
end

-- render in defined expansion order
for _, exp in ipairs(dv.EXPANSION_ORDER or {}) do
    if seenExp[exp] then
        Checkbox(exp, selectedBossExpansions, exp)
    end
end

end

function dv.ResetSidebarFilters()
    if dv.sidebarFilters then
        dv.sidebarFilters:Hide()
        dv.sidebarFilters:SetParent(nil)
    end

    -- Create a brand-new container
    dv.sidebarFilters = CreateFrame("Frame", nil, dv.sidebar)
    dv.sidebarFilters:SetAllPoints()
end