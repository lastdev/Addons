local addonName, dv = ...
local COLLECTED_ICON_TEXTURE = "Interface\\AddOns\\DecorVendor\\Assets\\collected"


local function IsLoaded(addon)
    return C_AddOns and C_AddOns.IsAddOnLoaded and C_AddOns.IsAddOnLoaded(addon)
end

hasTomTom = IsLoaded("TomTom")
hasWaypointUI = IsLoaded("WaypointUI")
-------------------------------------------------
-- 🔹 Saved Variables
-------------------------------------------------
vendorSettings = vendorSettings or {
    useTomTom = true,
    scale = 1.0,
    closeOnEsc = true,
    showMinimapButton = true,
	showVendorCheckmarks = true,
	showMerchantCheckmarks = false,
    visited = {},          -- vendors the player has interacted with
    completedDrop = {},    -- item-level completion cache (safe to keep)
	markCompletedThings = false,
	markFoundVendors = false,
	hideCompletedThings = false,
   -- hideCollectedItems = false, -- 🔥 ADD THIS
}

dbDV = dbDV or {}
dbDV.minimap = dbDV.minimap or { hide = false }

-------------------------------------------------
-- 🔹 Locals
-------------------------------------------------
local dv_optionsCategory = nil
local decorThumbCache = {}
local itemNameCache = {}
local refreshTimer = nil
local MAX_ITEMS_PER_PAGE = 18
local LibDBIcon = LibStub("LibDBIcon-1.0", true)
local minimapButton 
local vendorSessionCache = {}
local BuildSidebarFilters
local verticalTabs = {}
local utilityTabs = {}

dv.decorItem = dv.decorItem or {}
dv.waitingForMarketData = false
dv.catalogReady = false
dv.currentTab = dv.currentTab or "vendors"
dv.currentTab = "vendors" 
vendorFilteredItems = {}
currentVendorPage = 1
dv.activeWowheadBox = nil
dv.collapsedHeaders = dv.collapsedHeaders or {}
dv.activeWidgets = dv.activeWidgets or {}
dv.questTitleCache = dv.questTitleCache or {}
dv.collectionCache = dv.collectionCache or {}
-------------------------------------------------
-- 🔹 Constants
-------------------------------------------------
local CORE_TABS = {
    { id = "vendors",      text = "Vendors",      icon = "Interface\\Icons\\inv_misc_5potionbag_special" },
    { id = "professions",  text = "Professions",  icon = "Interface\\Icons\\Trade_Tailoring" },
    { id = "quests",       text = "Quests",       icon = "Interface\\Icons\\Inv_misc_note_01" },
    { id = "achievements", text = "Achievements", icon = "Interface\\Icons\\achievement_level_100" },
    { id = "bossdrops",    text = "Boss Drops",   icon = "Interface\\Icons\\achievement_boss_blackhand" },
	{ id = "events",       text = "Events",       icon = "Interface\\Icons\\inv_misc_ticket_darkmoon_01",},
}

local UTILITY_TABS = {
	{id = "knownissues",    text = "Known Issues",    icon = "Interface\\Icons\\inv_misc_wrench_01" },
    { id = "tips",    text = "Tips",    icon = "Interface\\Icons\\achievement_quests_completed_twilighthighlands" },
    { id = "support", text = "Support", icon = "Interface\\Icons\\INV_Misc_Gift_01" },
    { id = "about",   text = "About",   icon = "Interface\\Icons\\achievement_character_bloodelf_female" },
}

dv.utilitySidebarImages = {
    knownissues = "Interface\\AddOns\\DecorVendor\\Assets\\knownissues",
    tips        = "Interface\\AddOns\\DecorVendor\\Assets\\tips",
    support     = "Interface\\AddOns\\DecorVendor\\Assets\\support",
    about       = "Interface\\AddOns\\DecorVendor\\Assets\\about",
}

dv.EXPANSION_ORDER = {
    "Classic",
    "The Burning Crusade",
    "Wrath of the Lich King",
    "Cataclysm",
    "Mists of Pandaria",
    "Warlords of Draenor",
    "Legion",
    "Battle for Azeroth",
    "Shadowlands",
    "Dragonflight",
    "The War Within",
	"Midnight",
	"Midnight Launch",	
	"Twilight Ascencision",
	"The Neighborhoods",
	"Race Locked",
}

local TAB_LEFT_PADDING = {
    vendors = 180,  -- room for sidebar
    professions = 10,
}
-------------------------------------------------
-- 🔹 Texture Path
-------------------------------------------------
local function GetFullTexturePath(texturePath)
    if texturePath and not string.match(texturePath, "[\\/]") then
        return "Interface\\AddOns\\DecorVendor\\Assets\\" .. texturePath
    end
    return texturePath
end
-------------------------------------------------
-- 🔹 Helpers
-------------------------------------------------
local function RequestUpdate()
  if refreshTimer then refreshTimer:Cancel() end
  refreshTimer = C_Timer.NewTimer(0.2, function()
    refreshTimer = nil
    if DV_MainFrame and DV_MainFrame:IsShown() then
      BuildVendorUI()
    end
  end)
end

local function IsCatalogUsable()
    -- Try a known-good API call
    local test = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, 1, true)
    return test ~= nil
end

local function GetCachedItemName(itemID)
	if not itemID then return "Unknown Item", false end
	if itemNameCache[itemID] then return itemNameCache[itemID], false end
	local item = Item:CreateFromItemID(itemID)
	if not item:IsItemEmpty() then
		item:ContinueOnItemLoad(function() 
			itemNameCache[itemID] = item:GetItemName() 
			RequestUpdate() 
		end)
	end
end

function dv.ItemPassesRequirements(itemID)
    local data = dv.decorItem and dv.decorItem[itemID]
    if not data then return true end

    -- Expansion filter
    if selectedExpansions and next(selectedExpansions) then
        if data.expansion and not selectedExpansions[data.expansion] then
            return false
        end
    end

    -- Faction filter
    if selectedFactions and next(selectedFactions) then
        if data.faction and not selectedFactions[data.faction] then
            return false
        end
    end

    return true
end

function dv.GetHeaderWidth()
    if dv.currentTab == "professions" then
        -- Full width (minus padding)
        return frame:GetWidth() - 40
    else
        -- Vendors tab (respect sidebar width)
        return frame:GetWidth() - frame.sidebar:GetWidth() - 40
    end
end

 function dv.IsItemCollected(itemID)
	if vendorSettings.completedDrop[itemID] then return true end
	if dv.collectionCache[itemID] ~= nil then return dv.collectionCache[itemID] end
	local decorID = dv.decorItem[itemID] and dv.decorItem[itemID].decorID
	if not decorID then 
		dv.collectionCache[itemID] = false
		return false 
	end
	local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, decorID, true)
	if info and info.firstAcquisitionBonus == 0 then
		vendorSettings.completedDrop[itemID] = true
		return true
	end
	dv.collectionCache[itemID] = false
	return false
end

function dv.IsQuestEffectivelyCompleted(quest)
    -- SAFETY: quest may be nil
if not quest then
    return false
end

    -- 1️⃣ Normal Blizzard quest completion (ONLY if ID is numeric)
    if type(quest.id) == "number" then
        if C_QuestLog.IsQuestFlaggedCompleted(quest.id) then
            return true
        end
    end

    -- 2️⃣ Account-wide decor already owned
    if quest.rewardDecor then
        if type(quest.rewardDecor) == "table" then
            for _, itemID in ipairs(quest.rewardDecor) do
                if dv.IsItemCollected(itemID) then
                    return true
                end
            end
        elseif type(quest.rewardDecor) == "number" then
            if dv.IsItemCollected(quest.rewardDecor) then
                return true
            end
        end
    end

    return false
end

local function BuildProfessionLookup()
    dv.itemToProfession = {}
    for _, profession in ipairs(dv.professions or {}) do
        for _, recipe in ipairs(profession.items or {}) do
            dv.itemToProfession[recipe.id] = profession.name
        end
    end
end

local function GetDecorThumbnail(itemID)
    if decorThumbCache[itemID] then
        return decorThumbCache[itemID]
    end

    local decorData = dv.professionItem and dv.professionItem[itemID]
    if not decorData then return nil end

    local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, decorData.decorID, true)
    if info and info.iconTexture then
        decorThumbCache[itemID] = info.iconTexture
        return info.iconTexture
    end
end

local function CountProfessionItems(profession)
    local total = 0
    local completed = 0

    for _, item in ipairs(profession.items or {}) do
        total = total + 1

        -- Optional: if tracking completion later
        if professionSettings and professionSettings.completed
           and professionSettings.completed[item.id] then
            completed = completed + 1
        end
    end

    return completed, total
end

function UpdateEscBehavior()
    local frameName = "DV_MainFrame"

    -- Remove ALL existing instances first
    for i = #UISpecialFrames, 1, -1 do
        if UISpecialFrames[i] == frameName then
            table.remove(UISpecialFrames, i)
        end
    end

    -- Add only if option is enabled
    if vendorSettings.closeOnEsc then
        table.insert(UISpecialFrames, frameName)
    end
end

local function NormalizeNPCName(name)
    if not name then return nil end

    -- Remove NPC titles like <Reagents and Repairs>
    name = name:gsub("%s*<.-%>", "")

    -- Normalize apostrophes and spacing
    name = name:gsub("’", "'")
    name = name:trim()
    name = name:lower()

    return name
end

function dv.GetDecorIconByItemID(itemID)
    local decorData = dv.professionItem and dv.professionItem[itemID]
    if not decorData or not decorData.decorID then
        return nil
    end

    local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(
        1,                  -- Catalog type (1 = housing)
        decorData.decorID,  -- Decor record ID
        true                -- force cache
    )

    return info and info.iconTexture
end

function dv.IsDecorOwned(itemID)
    if not dv.catalogReady then return false end
    if not itemID then return false end

    local data = dv.decorItem and dv.decorItem[itemID]
    if not data or not data.decorID then
        return false
    end

    -- Authoritative catalog check (Decor record)
    if C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByRecordID then
        local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(
            Enum.HousingCatalogEntryType.Decor,
            data.decorID,
            true
        )

        if type(info) == "table" then
            local owned =
                (tonumber(info.numPlaced) or 0) +
                (tonumber(info.numStored) or 0) +
                (tonumber(info.ownedCount) or 0) +
                (tonumber(info.quantity) or 0)

            return owned > 0
        end
    end

    return false
end

local function GetVendorStatus(vendorID)
    -- 🚫 Prevent stale cache before catalog is ready
    if not dv.catalogReady then
        return false, 0
    end

    if vendorSessionCache[vendorID] then
        return vendorSessionCache[vendorID].isComplete,
               vendorSessionCache[vendorID].missingCount
    end

    local items = dv.vendorGoodies[vendorID]
    local missingCount = 0
    local relevantCount = 0

    for _, itemID in ipairs(items) do
        local decor = dv.decorItem and dv.decorItem[itemID]
        if decor and decor.decorID then
            relevantCount = relevantCount + 1
            if not dv.IsDecorOwned(itemID) then
                missingCount = missingCount + 1
            end
        end
    end

    local isComplete = (relevantCount > 0 and missingCount == 0)

    vendorSessionCache[vendorID] = {
        isComplete   = isComplete,
        missingCount = missingCount,
    }

    return isComplete, missingCount
end

function dv.GetVendorInfo(vendorID)
    if not vendorID or not dv.npcs then return nil end

    for _, group in ipairs(dv.npcs) do
        for _, vendor in ipairs(group.vendors or {}) do
            if vendor.id == vendorID then
                -- Attach useful context (optional but recommended)
                vendor.groupName = group.name
                vendor.expansion = group.expansion
                return vendor
            end
        end
    end

    return nil
end

local function ShowWowheadBox(parent, wowheadBox, id, type)
    local url = dv:GetWowheadLink(id, type)

    if dv.activeWowheadBox and dv.activeWowheadBox ~= wowheadBox then
        dv.activeWowheadBox:Hide()
    end

    wowheadBox:SetText(url)
    wowheadBox:Show()
    wowheadBox:SetFocus()
    wowheadBox:HighlightText()
    dv.activeWowheadBox = wowheadBox
end

-------------------------------------------------
-- 🔹 Main FRAME
-------------------------------------------------
local frame = CreateFrame("Frame", "DV_MainFrame", UIParent, "BackdropTemplate")
--frame:SetSize(860, 580)
frame:SetSize(1200, 800)
local PREVIEW_WIDTH = 420
frame:SetPoint("CENTER")
frame:SetFrameStrata("HIGH")
frame:SetFrameLevel(100)
frame:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8x8",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = false,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
frame:SetBackdropColor(0.02, 0.02, 0.02, 0.95)
frame:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:Hide()

frame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)

frame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        self:StopMovingOrSizing()
    end
end)

local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", -2, -2)
closeBtn:SetSize(28, 28)

local titleBg = frame:CreateTexture(nil, "BACKGROUND")
titleBg:SetTexture("Interface\\Buttons\\WHITE8x8")
titleBg:SetPoint("TOPLEFT", 4, -4)
titleBg:SetPoint("TOPRIGHT", -4, -4)
titleBg:SetHeight(50)
titleBg:SetGradient("VERTICAL", CreateColor(0.15, 0.10, 0.25, 0.9), CreateColor(0.05, 0.05, 0.15, 0.9))
frame.titleBg = titleBg


local title = frame:CreateFontString(nil, "OVERLAY")
title:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
title:SetPoint("TOP", 0, -14)
title:SetText("The Original Decor Vendors")
title:SetTextColor(1, 0.82, 0)

local subtitle = frame:CreateFontString(nil, "OVERLAY")
subtitle:SetFont(STANDARD_TEXT_FONT, 14)
subtitle:SetPoint("TOP", title, "BOTTOM", 0, -2)
subtitle:SetText("So Many Decorations to Collect")
subtitle:SetTextColor(1, 0.82, 0)
-------------------------------------------------
-- 🔹 Information Icon
-------------------------------------------------
local infoIcon = CreateFrame("Button", nil, frame)
infoIcon:SetSize(24, 24)
infoIcon:SetPoint("TOPLEFT", 8, -8)
local iconTexture = infoIcon:CreateTexture(nil, "ARTWORK")
iconTexture:SetTexture("Interface\\BUTTONS\\UI-GuildButton-OfficerNote-Up")
iconTexture:SetAllPoints(infoIcon)
infoIcon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
infoIcon:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
  GameTooltip:AddLine("Decor Vendor Notice", 1, 0.82, 0)
  GameTooltip:AddLine("Current Working Version 1.70", 1, 1, 1, true)
  GameTooltip:Show()
end)
 infoIcon:SetScript("OnLeave", function(self)
  GameTooltip:Hide()
end)
------------------------------------------------
-- Reset Buttons
------------------------------------------------
local resetBtn = CreateFrame("Button", "DV_ResetProgressBtn", frame, "UIPanelButtonTemplate")
resetBtn:SetSize(120, 22)
-- Position it LEFT of the support icon
resetBtn:SetPoint("LEFT", infoIcon, "RIGHT", 6, 0)
resetBtn:SetText("Reset Vendors")
resetBtn:SetScript("OnClick", function()
    StaticPopupDialogs["DV_RESET_VENDORS"] = {
        text = "Reset all vendor progress?\nThis cannot be undone.",
        button1 = "Reset",
        button2 = "Cancel",

        OnAccept = function()
            ResetAllVendors()
            BuildVendorUI()
        end,

        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

    StaticPopup_Show("DV_RESET_VENDORS")
end)

local resetCacheBtn = CreateFrame("Button", "DV_ResetCollectionCacheBtn", frame, "UIPanelButtonTemplate")
resetCacheBtn:SetSize(170, 22)
resetCacheBtn:SetPoint("TOPLEFT", resetBtn, "BOTTOMLEFT", 0, -2)
resetCacheBtn:SetText("Reset Collection Cache")
resetCacheBtn:GetFontString():SetTextColor(0.9, 0.9, 0.9)
resetCacheBtn:SetScript("OnClick", function()
    StaticPopup_Show("DECORVENDOR_RESET_CACHE")
end)

resetCacheBtn:SetEnabled(dv.catalogReady)
StaticPopupDialogs["DECORVENDOR_RESET_CACHE"] = {
    text = "Reset Decor Vendor's collection cache?\n\nThis does NOT delete your actual progress.\n\nUse this only if vendor completion appears incorrect due to Housing API caching.",
    button1 = "Reset",
    button2 = "Cancel",
    OnAccept = function()
        dv.ResetCollectionCache()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

frame:HookScript("OnShow", function()
    if resetCacheBtn then
        resetCacheBtn:SetEnabled(dv.catalogReady)
    end
end)

function ResetAllVendors()
    vendorSettings.visited = {}   -- wipe ALL progress
    print("|cff88ff88DecorVendor:|r Vendor progress reset.")
end

function dv.ResetCollectionCache()
    vendorSettings.completedDrop = {}
    wipe(vendorSessionCache)

    print("|cff00ff00Decor Vendor:|r Collection cache reset.")
    print("|cffaaaaaaNote:|r Vendor progress will recalculate using live Housing data.")

    BuildVendorUI()
end

function dv.ClearWidgets()
    for _, w in ipairs(dv.activeWidgets) do
        w:Hide()
    end
    wipe(dv.activeWidgets)
end

local function StandardizeLineScripts(line, onEnter, onClick, onLeave)
  line:SetScript("OnEnter", onEnter)
  line:SetScript("OnClick", onClick)
  line:SetScript("OnLeave", function(self)
    ResetCursor()
    GameTooltip:Hide()
    smallPreviewFrame:Hide()
    if previewFrame then
      previewFrame:Hide(); previewFrame.model:Hide(); previewFrame.texture:Hide(); previewFrame.currentReward = nil; 
      if line.nextButton then line.nextButton:Hide() end
    end
    if onLeave then onLeave(self) end
  end)
end
------------------------------------------------
-- Event Handler Fir Found Vendors
------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("MERCHANT_SHOW")
eventFrame:SetScript("OnEvent", function()
    if not dv.npcs then return end

    local targetName = NormalizeNPCName(UnitName("target"))
    if not targetName then return end

    local currentMapID = C_Map.GetBestMapForUnit("player")
    vendorSettings.visited = vendorSettings.visited or {}

    for _, group in ipairs(dv.npcs) do
        for _, vendor in ipairs(group.vendors or {}) do

            local vendorName = NormalizeNPCName(vendor.title)

            if vendorName == targetName then

                -- ✅ If vendor has mapID → require match
                if vendor.mapID then
                    if vendor.mapID ~= currentMapID then
                        -- wrong map, skip
                    else
                        if not vendorSettings.visited[vendor.id] then
                            vendorSettings.visited[vendor.id] = true
                            if vendorSettings.hideCompletedThings or vendorSettings.markFoundVendors then
                                BuildVendorUI()
                            end
                        end
                        return
                    end

                -- ✅ If vendor has NO mapID → allow match anywhere (Endeavors)
                else
                    if not vendorSettings.visited[vendor.id] then
                        vendorSettings.visited[vendor.id] = true
                        if vendorSettings.hideCompletedThings or vendorSettings.markFoundVendors then
                            BuildVendorUI()
                        end
                    end
                    return
                end
            end
        end
    end
end)
------------------------------------------------
-- Tab Bar Stuff
------------------------------------------------
function dv.UpdatePreviewSize()

    local panel = frame.previewPanel
    if not panel then return end

    if dv.currentTab == "achievements" then
        panel.modelContainer:SetHeight(280)

    elseif dv.currentTab == "quests" then
        panel.modelContainer:SetHeight(280)

    else
        -- vendors / professions / default
        panel.modelContainer:SetHeight(360)
    end

end

local rightTabBar = CreateFrame("Frame", "DV_RightTabBar", frame)
rightTabBar:SetPoint("TOPLEFT", frame, "TOPRIGHT", 2, 0)
rightTabBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0)
rightTabBar:SetWidth(90)

function UpdateSidebarForTab()

    -------------------------------------------------
    -- 1️⃣ Hide contextual popups
    -------------------------------------------------
    if dv.reagentsPopup then
        dv.reagentsPopup:Hide()
    end

    if dv.vendorPopup then
        dv.vendorPopup:Hide()
    end

if dv.achievementWowheadWrapper then
    dv.achievementWowheadWrapper:Hide()
end

if DV_AchievementTooltip then
    DV_AchievementTooltip:Hide()
end
	
	if dv.questWowheadWrapper then
    dv.questWowheadWrapper:Hide()
end

    -------------------------------------------------
    -- 2️⃣ Reset preview panel completely
    -------------------------------------------------
    if frame and frame.previewPanel then
        local panel = frame.previewPanel

        panel._isVendorPreview = false

        if panel.model then
            panel.model:ClearModel()
            panel.model:SetDisplayInfo(0)
            panel.model:SetPosition(0, 0, 0)
            panel.model:SetFacing(0)
            panel.model:Hide()
        end

        if panel.texture then
            panel.texture:SetTexture(nil)
            panel.texture:Hide()
        end

        if panel.title then
            panel.title:SetText("Select an item")
        end
    end

    -------------------------------------------------
    -- 3️⃣ Frame width logic (Achievements wider)
    -------------------------------------------------
    if dv.currentTab == "achievements" then
        frame:SetWidth(1320)
        frame.previewPanel:SetWidth(540)
    else
        frame:SetWidth(1200)
        frame.previewPanel:SetWidth(420)
    end

    dv.sidebar:Show()
    dv.ResetSidebarFilters()
    dv.sidebarFilters:Hide()

    if dv.sidebarImage then
        dv.sidebarImage:Hide()
    end

    -------------------------------------------------
    -- 4️⃣ Utility Tabs (Bottom Buttons)
    -------------------------------------------------
    if dv.currentTab == "about"
    or dv.currentTab == "knownissues"
    or dv.currentTab == "tips"
    or dv.currentTab == "support" then

        -- Hide preview panel completely
        if frame.previewPanel then
            frame.previewPanel:Hide()
        end

        -- Expand scroll frame full width
        if scrollFrame then
            scrollFrame:ClearAllPoints()
            scrollFrame:SetPoint("TOPLEFT", dv.sidebar, "TOPRIGHT", 6, -6)
            scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 6)
        end

        -- 🔥 Hide scrollbar fully
        if scrollFrame and scrollFrame.ScrollBar then
            scrollFrame.ScrollBar:Hide()
        end

        if scrollFrame then
            scrollFrame:EnableMouseWheel(false)
        end

        -- Optional sidebar image for utility tabs
        local tex = dv.utilitySidebarImages and dv.utilitySidebarImages[dv.currentTab]
        if tex and dv.sidebarImage then
            dv.sidebarImage:SetTexture(tex)
            dv.sidebarImage:Show()
        end

        return
    end

    -------------------------------------------------
    -- 5️⃣ Normal Tabs
    -------------------------------------------------
    if frame.previewPanel then
        frame.previewPanel:Show()
    end

    -- Restore scroll positioning next to preview panel
    if scrollFrame then
        scrollFrame:ClearAllPoints()
        scrollFrame:SetPoint("TOPLEFT", dv.sidebar, "TOPRIGHT", 6, -6)
        scrollFrame:SetPoint("BOTTOMRIGHT", frame.previewPanel, "BOTTOMLEFT", -6, 6)
    end

    -- 🔥 Restore scrollbar
    if scrollFrame and scrollFrame.ScrollBar then
        scrollFrame.ScrollBar:Show()
    end

    if scrollFrame then
        scrollFrame:EnableMouseWheel(true)
    end

    dv.sidebarFilters:Show()

    if dv.currentTab == "vendors" then
        dv.BuildVendorFilters()

    elseif dv.currentTab == "quests" then
        dv.BuildQuestFilters()

    elseif dv.currentTab == "achievements" then
        dv.BuildAchievementFilters()

    elseif dv.currentTab == "professions" then
        dv.BuildProfessionFilters()

    elseif dv.currentTab == "bossdrops" then
        dv.BuildBossDropFilters()
    end

    -------------------------------------------------
    -- 6️⃣ Scroll width adjustment
    -------------------------------------------------
    if scrollChild then
        scrollChild:SetWidth(frame:GetWidth() - dv.sidebar:GetWidth() - 40)
    end
end


local function CreateCoreVerticalTab(data, order)
    local tab = CreateFrame("Button", nil, rightTabBar, "BackdropTemplate")
    tab:SetSize(90, 44)
    tab:SetPoint("TOPLEFT", rightTabBar, "TOPLEFT", 0, -((order - 1) * 48))

   tab:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 10,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    tab:SetBackdropColor(0.15, 0.15, 0.15, 0.95)

    local icon = tab:CreateTexture(nil, "ARTWORK")
    icon:SetSize(20, 20)
    icon:SetPoint("TOP", 0, -5)
    icon:SetTexture(data.icon)

    local label = tab:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("TOP", icon, "BOTTOM", 0, -2)
    label:SetText(data.text)

    tab.id = data.id
    table.insert(verticalTabs, tab)

    tab:SetScript("OnClick", function()
        dv.currentTab = data.id
        dv.UpdatePreviewSize()
       UpdateVerticalTabStyles()
        UpdateSidebarForTab()
        BuildVendorUI()
    end)

    return tab
end

for i, tabData in ipairs(CORE_TABS) do
    CreateCoreVerticalTab(tabData, i)
end

local utilityBar = CreateFrame("Frame", "DV_UtilityBar", frame)
utilityBar:SetPoint("BOTTOM", frame, "BOTTOM", 0, -36)
utilityBar:SetSize(300, 36)

local function CreateUtilityTab(parent, data, index, total)
    local tab = CreateFrame("Button", nil, parent, "BackdropTemplate")
    tab:SetSize(110, 32)


    local TAB_WIDTH = 110
local TAB_HEIGHT = 32
local spacing = 8

tab:SetSize(TAB_WIDTH, TAB_HEIGHT)

local totalWidth = (total * TAB_WIDTH) + ((total - 1) * spacing)
local startX = -totalWidth / 2

tab:SetPoint(
    "LEFT",
    parent,
    "CENTER",
    startX + ((index - 1) * (TAB_WIDTH + spacing)),
    0
)


    tab:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    tab:SetBackdropColor(0.12, 0.12, 0.12, 0.9)

    local icon = tab:CreateTexture(nil, "ARTWORK")
    icon:SetSize(16, 16)
    icon:SetPoint("LEFT", 6, 0)
    icon:SetTexture(data.icon)

    local label = tab:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("LEFT", icon, "RIGHT", 6, 0)
    label:SetText(data.text)

    tab:SetScript("OnEnter", function()
        tab:SetBackdropColor(0.25, 0.25, 0.25, 1)
    end)

    tab:SetScript("OnLeave", function()
        tab:SetBackdropColor(0.12, 0.12, 0.12, 0.9)
    end)

    tab:SetScript("OnClick", function()
        dv.currentTab = data.id
		dv.UpdatePreviewSize()
        UpdateVerticalTabStyles()
        UpdateSidebarForTab()
        BuildVendorUI()
    end)

    table.insert(utilityTabs, tab)
end

for i, tabData in ipairs(UTILITY_TABS) do
    CreateUtilityTab(utilityBar, tabData, i, #UTILITY_TABS)
end

function UpdateVerticalTabStyles()
    for _, tab in ipairs(verticalTabs) do
        if dv.currentTab == tab.id then
            tab:SetBackdropColor(0.25, 0.1, 0.35, 1) -- selected
        else
            tab:SetBackdropColor(0.1, 0.1, 0.1, 0.9) -- normal
        end
    end
end
UpdateVerticalTabStyles()
-------------------------------------------------
-- 🔹 Side Bar Stuff
-------------------------------------------------
frame.sidebar = CreateFrame("Frame", "DV_Sidebar", frame, "BackdropTemplate")
frame.sidebar:SetWidth(220)
frame.sidebar:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -72)
frame.sidebar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 10)
frame.sidebar:SetBackdrop(nil)

local sbg = frame.sidebar:CreateTexture(nil, "BACKGROUND")
sbg:SetAllPoints()
sbg:SetTexture("Interface\\Buttons\\WHITE8x8")
sbg:SetGradient("VERTICAL",
    CreateColor(0.15, 0.10, 0.25, 0.95),
    CreateColor(0.05, 0.05, 0.15, 0.95)
)
dv.sidebar = frame.sidebar

frame.sidebarFilters = CreateFrame("Frame", nil, frame.sidebar)
frame.sidebarFilters:SetAllPoints()
dv.sidebarFilters = frame.sidebarFilters

-- Utility sidebar image (used for Known Issues / Tips / etc)
frame.sidebarImage = frame.sidebar:CreateTexture(nil, "ARTWORK")
frame.sidebarImage:SetSize(140, 220)
frame.sidebarImage:SetPoint("CENTER", dv.sidebar, "CENTER", 0, 0)
frame.sidebarImage:SetAlpha(0.85)
frame.sidebarImage:Hide()
dv.sidebarImage = frame.sidebarImage
-- ======================================
-- Preview Panel (Always Visible)
-- ======================================
local previewPanel = CreateFrame("Frame", nil, frame, "BackdropTemplate")
previewPanel:ClearAllPoints()
previewPanel:SetPoint("TOPRIGHT", frame.titleBg, "BOTTOMRIGHT", -6, -6)
previewPanel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 6)
previewPanel:SetWidth(PREVIEW_WIDTH)
previewPanel:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8x8",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 12,
    insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
previewPanel:SetBackdropColor(0.02, 0.02, 0.02, 0.25)
previewPanel:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
frame.previewPanel = previewPanel

local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
scrollFrame:ClearAllPoints()
scrollFrame:SetPoint("TOPLEFT", frame.sidebar, "TOPRIGHT", 6, -6)
scrollFrame:SetPoint("BOTTOMRIGHT", frame.previewPanel, "BOTTOMLEFT", -6, 14)

scrollFrame.ScrollBar:ClearAllPoints()
scrollFrame.ScrollBar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", -4, -8)
scrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", -4, 8)

local scrollChild = CreateFrame("Frame", nil, scrollFrame)
scrollChild:SetSize(520, 1)
scrollFrame:SetScrollChild(scrollChild)
-- ======================================
-- Preview Panel Title and Stuff
-- ======================================
previewPanel.title = previewPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
previewPanel.title:SetPoint("TOP", 0, -12)
previewPanel.title:SetText("Select a Vendor")
previewPanel.title:SetTextColor(1, 0.82, 0)

previewPanel.texture = previewPanel:CreateTexture(nil, "ARTWORK")
previewPanel.texture:SetPoint("TOPLEFT", previewPanel.model, "TOPLEFT")
previewPanel.texture:SetPoint("BOTTOMRIGHT", previewPanel.model, "BOTTOMRIGHT")
previewPanel.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
previewPanel.texture:Hide()

function dv.ShowPreviewTexture(texture, title)

    local panel = frame.previewPanel
    if not panel then return end

    panel.model:Hide()
    panel.texture:SetTexture(texture)
    panel.texture:Show()

    panel.title:SetText(title or "Preview")
end

function dv.ShowPreviewModel(modelFileID, title)

    local panel = frame.previewPanel
    if not panel then return end

    panel.texture:Hide()
    panel.model:ClearModel()
    panel.model:SetModel(modelFileID)
    panel.model:SetFacing(0)
    panel.model:Show()

    panel.title:SetText(title or "Preview")
end

function dv.HidePreview()

    local panel = frame.previewPanel
    if not panel then return end

    panel.model:Hide()
    panel.texture:Hide()
end
------------------------------------------------
-- Preview Model
------------------------------------------------
frame.previewPanel.modelContainer = CreateFrame("Frame", nil, frame.previewPanel)
local modelContainer = frame.previewPanel.modelContainer
modelContainer:SetPoint("TOPLEFT", frame.previewPanel, "TOPLEFT", 0, -40)
modelContainer:SetPoint("TOPRIGHT", frame.previewPanel, "TOPRIGHT", 0, -40)
modelContainer:SetHeight(380)

frame.previewPanel.model = CreateFrame("PlayerModel", nil, modelContainer)
local model = frame.previewPanel.model
model:ClearAllPoints()
model:SetPoint("TOPLEFT", 10, -10)
model:SetPoint("TOPRIGHT", -10, -10)
model:SetPoint("BOTTOMLEFT", 10, 10)
model:SetPoint("BOTTOMRIGHT", -10, 10)
model:EnableMouse(false)
model:SetScript("OnMouseDown", nil)
model:SetScript("OnMouseUp", nil)
model:SetScript("OnMouseWheel", nil)
model:SetScript("OnModelLoaded", function(self)
    if dv.currentTab == "vendors" or frame.previewPanel._isVendorPreview then
        -- 🧙 Vendor / NPC portrait mode
        self:SetPosition(0, 0, 0)
        self:SetRotation(0)

        -- 🔥 THIS is the zoom that fixes tiny NPCs
        self:SetPortraitZoom(0)

        self:SetFacing(0)
        self:EnableMouse(false)

        -- Idle animation (safe)
        self:SetAnimation(2)

        return
    end

    -- Everything else (quests, achievements, professions)
    self:MakeCurrentCameraCustom()

    local modelID = self:GetModelFileID()
    local posData = dv.modelPositions[modelID]

    if posData then
        self:SetPosition(posData.model_x, 0, posData.model_z)
        self:SetCameraPosition(0, 0, posData.camera_y)
        self:SetCameraDistance(posData.zoom)
    else
        model:SetPosition(0, 0, 0)
model:SetCameraPosition(0, 0, 6)
model:SetCameraDistance(20)

    end
end)
model:Hide()

local rotation = 0
frame.previewPanel:SetScript("OnUpdate", function(self, elapsed)
    if self:IsShown()
    and self.model:IsShown()
	and dv.currentTab ~= "vendors"
    and not frame.previewPanel._isVendorPreview then
        rotation = rotation + elapsed * 0.4
        self.model:SetFacing(rotation)
    end
end)

local divider = frame.previewPanel:CreateTexture(nil, "ARTWORK")
divider:SetHeight(1)
divider:SetPoint("TOPLEFT", frame.previewPanel.model, "BOTTOMLEFT", 0, -4)
divider:SetPoint("TOPRIGHT", frame.previewPanel.model, "BOTTOMRIGHT", 0, -4)
divider:SetColorTexture(0.3, 0.3, 0.3, 0.6)

frame.previewPanel.itemContainer = CreateFrame("Frame", nil, frame.previewPanel)
local itemContainer = frame.previewPanel.itemContainer
itemContainer:SetPoint("TOPLEFT", modelContainer, "BOTTOMLEFT", 10, -10)
itemContainer:SetPoint("TOPRIGHT", modelContainer, "BOTTOMRIGHT", -10, -10)
itemContainer:SetPoint("BOTTOMLEFT", frame.previewPanel, "BOTTOMLEFT", 10, 10)
itemContainer:SetPoint("BOTTOMRIGHT", frame.previewPanel, "BOTTOMRIGHT", -10, 10)

function dv:GetWowheadLink(id, rewardType)
    if rewardType == "quest" then
        return "https://www.wowhead.com/quest=" .. tostring(id)
    elseif rewardType == "item" then
        return "https://www.wowhead.com/item=" .. tostring(id)
    else
        return "https://www.wowhead.com/achievement=" .. tostring(id)
    end
end

if not tContains(UISpecialFrames, "DV_VendorPopup") then
    tinsert(UISpecialFrames, "DV_VendorPopup")
end

dv.vendorPopup = CreateFrame("Frame", "DV_VendorPopup", frame.previewPanel, "BackdropTemplate")
local vendorPopup = dv.vendorPopup
local modelWidth = frame.previewPanel.model:GetWidth()
vendorPopup:SetWidth(modelWidth - 20)
vendorPopup:ClearAllPoints()
vendorPopup:SetPoint("TOP", frame.previewPanel.model, "BOTTOM", 0, -12)
vendorPopup:SetFrameStrata(frame.previewPanel:GetFrameStrata())
vendorPopup:SetFrameLevel(frame.previewPanel:GetFrameLevel() + 5)
vendorPopup:SetClampedToScreen(true)
vendorPopup:Hide()

local popupIconCache = {} 

vendorPopupTitle = vendorPopup:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
vendorPopupTitle:ClearAllPoints()
vendorPopupTitle:SetPoint("TOP", vendorPopup, "TOP", 0, -12)
vendorPopupTitle:SetText("Vendor Goodies")
vendorPopupTitle:SetTextColor(1, 0.82, 0)

local titleSeparator = vendorPopup:CreateTexture(nil, "ARTWORK")
titleSeparator:SetHeight(2)
titleSeparator:SetColorTexture(0.4, 0.4, 0.4, 0.8)
titleSeparator:ClearAllPoints()
titleSeparator:SetPoint("TOPLEFT", vendorPopup, "TOPLEFT", 20, -36)
titleSeparator:SetPoint("TOPRIGHT", vendorPopup, "TOPRIGHT", -20, -36)

local vendorCheckmarkToggle = CreateFrame("CheckButton", nil, vendorPopup, "UICheckButtonTemplate")
vendorCheckmarkToggle:SetSize(28, 28)
vendorCheckmarkToggle:SetPoint("RIGHT", vendorPopupTitle, "LEFT", -6, 0) 
vendorCheckmarkToggle.text:Hide()
vendorCheckmarkToggle:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:SetText("Include Checkmarks")
	GameTooltip:Show()
end)
vendorCheckmarkToggle:SetScript("OnLeave", function() GameTooltip:Hide() end)
vendorCheckmarkToggle:SetScript("OnClick", function(self)
	local isChecked = self:GetChecked()
	vendorSettings.showVendorCheckmarks = isChecked
	for _, container in pairs(popupIconCache) do
		if container:IsShown() and container.btn and container.btn.isCollected then
			container.checkFrame:SetShown(isChecked)
		end
	end
end)

local vendorPopupHiddenText = vendorPopup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
vendorPopupHiddenText:SetFont(STANDARD_TEXT_FONT, 12)
vendorPopupHiddenText:SetTextColor(0.9, 0.9, 0.9, 1)
vendorPopupHiddenText:SetPoint("TOP", vendorPopupTitle, "BOTTOM", 0, -2)
vendorPopupHiddenText:Hide()
vendorPopup.hiddenText = vendorPopupHiddenText

vendorPopup.content = CreateFrame("Frame", nil, vendorPopup)
vendorPopup.content:SetPoint("TOPLEFT", 12, -44) 
vendorPopup.content:SetPoint("BOTTOMRIGHT", -12, 12)

local vendorPrevBtn = CreateFrame("Button", nil, frame.previewPanel)
vendorPrevBtn:SetSize(32, 32)
vendorPrevBtn:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
vendorPrevBtn:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
vendorPrevBtn:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")
vendorPrevBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
vendorPrevBtn:SetPoint("BOTTOMLEFT", frame.previewPanel, "BOTTOMLEFT", 20, 20)
vendorPrevBtn:Hide()

local vendorNextBtn = CreateFrame("Button", nil, frame.previewPanel)
vendorNextBtn:SetSize(32, 32)
vendorNextBtn:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
vendorNextBtn:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
vendorNextBtn:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
vendorNextBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
vendorNextBtn:SetPoint("BOTTOMRIGHT", frame.previewPanel, "BOTTOMRIGHT", -20, 20)
vendorNextBtn:Hide()

local vendorPageText = vendorPopup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
vendorPageText:SetFont(STANDARD_TEXT_FONT, 12)
vendorPageText:SetTextColor(0.9, 0.9, 0.9, 1)
vendorPageText:SetPoint("BOTTOM", frame.previewPanel, "BOTTOM", 0, 24)
vendorPageText:Hide()

local UpdateVendorPopup

vendorPrevBtn:SetScript("OnClick", function()
	if currentVendorPage > 1 then
		currentVendorPage = currentVendorPage - 1
		UpdateVendorPopup()
	end
end)

vendorNextBtn:SetScript("OnClick", function()
	local totalPages = math.ceil(#vendorFilteredItems / MAX_ITEMS_PER_PAGE)
	if currentVendorPage < totalPages then
		currentVendorPage = currentVendorPage + 1
		UpdateVendorPopup()
	end
end)

local recipeTitle = vendorPopup:CreateFontString(nil, "OVERLAY")
recipeTitle:SetFont(STANDARD_TEXT_FONT, 14); recipeTitle:SetText("Recipe:"); recipeTitle:Hide()


local function GetPopupIconFrame(index)
	local container = popupIconCache[index]
	if not container then
		container = CreateFrame("Frame", nil, vendorPopup.content)
		container:SetSize(50, 50) 
		
		local borderFrame = CreateFrame("Frame", nil, container, "BackdropTemplate")
		borderFrame:SetSize(50, 50)
		borderFrame:SetPoint("TOP")
		borderFrame:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2 })
		borderFrame:SetClipsChildren(true)
		container.borderFrame = borderFrame
		
		local btn = CreateFrame("Button", nil, borderFrame)
		btn:SetAllPoints(borderFrame)
		btn:RegisterForClicks("AnyUp")
		container.btn = btn
		
		local glow = btn:CreateTexture(nil, "BACKGROUND")
		glow:SetPoint("TOPLEFT", -2, 2); glow:SetPoint("BOTTOMRIGHT", 2, -2)
		glow:SetColorTexture(0, 0, 0, 0.5)
		container.glow = glow
		
		local icon = btn:CreateTexture(nil, "ARTWORK")
		icon:SetPoint("TOPLEFT", 2, -2); icon:SetPoint("BOTTOMRIGHT", -2, 2)
		icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		container.icon = icon
		
		local checkFrame = CreateFrame("Frame", nil, container)
		checkFrame:SetSize(18, 18)
		checkFrame:SetPoint("BOTTOM", 0, -10)
		checkFrame:SetFrameLevel(borderFrame:GetFrameLevel() + 10)
		checkFrame:Hide()
		
		local checkTex = checkFrame:CreateTexture(nil, "ARTWORK")
		checkTex:SetAllPoints()
		checkTex:SetTexture(COLLECTED_ICON_TEXTURE)
		checkFrame.texture = checkTex
		container.checkFrame = checkFrame

		local countBar = CreateFrame("Frame", nil, container)
		countBar:SetSize(50, 16)
		countBar:SetPoint("TOP", borderFrame, "BOTTOM", 0, 0)
		container.countBar = countBar
		
		local countBg = countBar:CreateTexture(nil, "BACKGROUND")
		countBg:SetAllPoints()
		countBg:SetColorTexture(0, 0, 0, 1) 
		
		local countText = countBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		countText:SetFont(STANDARD_TEXT_FONT, 14, nil) 
		countText:SetTextColor(1, 1, 1, 1)
		countText:SetPoint("CENTER", countBar, "CENTER", 0, 0)
		container.countText = countText
		btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
		btn:GetHighlightTexture():SetBlendMode("ADD"); btn:GetHighlightTexture():SetAllPoints(icon)
		table.insert(popupIconCache, container)
	end
	return container
end

function PopupButton_OnEnter(self)
    local container = self:GetParent():GetParent()
    local borderFrame = container.borderFrame
    local glow = container.glow

    if self.isReagent or self.isRecipe then
        SetCursor("CAST_CURSOR")
        borderFrame:SetBackdropBorderColor(1, 0.82, 0, 1)
        glow:SetColorTexture(1, 0.82, 0, 0.2)
    else
        SetCursor("INSPECT_CURSOR")
        if self.isCollected then
            borderFrame:SetBackdropBorderColor(1, 1, 1, 1)
            glow:SetColorTexture(1, 1, 1, 0.1)
        else
            borderFrame:SetBackdropBorderColor(1, 0.82, 0, 1)
            glow:SetColorTexture(1, 0.82, 0, 0.2)
        end
    end

    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetHyperlink("item:" .. self.itemID)
    GameTooltip:Show()
end

function PopupButton_OnLeave(self)
    local container = self:GetParent():GetParent()
    local borderFrame = container.borderFrame
    local glow = container.glow

    ResetCursor()

    if self.isReagent or self.isRecipe or not self.isCollected then
        borderFrame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
    else
        borderFrame:SetBackdropBorderColor(1, 1, 1, 1)
    end

    glow:SetColorTexture(0, 0, 0, 0.5)
    GameTooltip:Hide()
end

function PopupButton_OnClick(self, button)
    if IsModifiedClick("CHATLINK") then
        local _, link = GetItemInfo(self.itemID)
        if link then
            ChatEdit_InsertLink(link)
        end
    elseif (self.isReagent or self.isRecipe) and (button == "LeftButton" or button == "RightButton") then
        if dv.ShowWowheadLinkPopup then
            dv.ShowWowheadLinkPopup(self.itemID, "item")
        end
    elseif button == "LeftButton" then
        DressUpItemLink("item:" .. self.itemID)
    end
end

local function SetupPopupButton(container, decor, typeStr)
	local btn = container.btn
	local borderFrame = container.borderFrame
	local itemID = decor.id
	container.itemID = itemID
	btn.itemID = itemID
	btn.isReagent = (typeStr == "reagent")
	btn.isRecipe = (typeStr == "recipe")
	btn.isCollected = false
if dv.catalogReady then
    btn.isCollected = dv.IsItemCollected(itemID)
end

	if typeStr == "vendor" then
		btn.isCollected = dv.catalogReady and dv.IsItemCollected(itemID)
		borderFrame:SetBackdropBorderColor(btn.isCollected and 1 or 0.4, btn.isCollected and 1 or 0.4, btn.isCollected and 1 or 0.4, 1)
		
		if btn.isCollected and vendorSettings.showVendorCheckmarks then 
			container.checkFrame:Show() 
		else 
			container.checkFrame:Hide() 
		end
		
		container:SetSize(50, 50)
		container.countBar:Hide()
	elseif typeStr == "reagent" then
		borderFrame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
		container.checkFrame:Hide()
		container:SetSize(50, 66)
		container.countText:SetText(data.amount or 1)
		container.countBar:Show()
	else
		borderFrame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
		container.checkFrame:Hide()
		container:SetSize(50, 50)
		container.countBar:Hide()
	end
	local texture = GetItemIcon(itemID)
	container.icon:SetTexture(texture or (typeStr == "recipe" and "Interface\\Icons\\INV_Scroll_03" or "Interface\\Icons\\INV_Misc_QuestionMark"))
	btn:SetScript("OnEnter", PopupButton_OnEnter)
	btn:SetScript("OnLeave", PopupButton_OnLeave)
	btn:SetScript("OnClick", PopupButton_OnClick)
	container:Show()
end

local function LayoutPopupItems(items, typeStr, startY, verticalStep)
    local tileSize = 50
    local margin   = 12
    local columns  = 6

    local totalItems = #items
    local rows = math.ceil(totalItems / columns)

    for i, item in ipairs(items) do
        local container = GetPopupIconFrame(i)
        container:ClearAllPoints()

        local col = (i - 1) % columns
        local row = math.floor((i - 1) / columns)

        -- Calculate total width of one row
        local itemsInThisRow = math.min(columns, totalItems - (row * columns))
        local rowWidth = (itemsInThisRow * tileSize) + ((itemsInThisRow - 1) * margin)

        local xOffset = (col * (tileSize + margin)) - (rowWidth / 2) + (tileSize / 2)

        container:SetPoint(
            "TOP",
            vendorPopup.content,
            "TOP",
            xOffset,
            startY - (row * verticalStep)
        )

        SetupPopupButton(
            container,
            typeStr == "vendor" and { id = item } or item,
            typeStr
        )
    end

    local totalHeight = math.abs(startY) + (rows * verticalStep)
    return totalHeight
end

UpdateVendorPopup = function()
	for _, frame in pairs(popupIconCache) do frame:Hide() end
	
	local itemsToShow = {}
	local totalItems = #vendorFilteredItems
	local totalPages = math.ceil(totalItems / MAX_ITEMS_PER_PAGE)
	
	if totalPages > 1 then
		local startIndex = (currentVendorPage - 1) * MAX_ITEMS_PER_PAGE + 1
		local endIndex = math.min(startIndex + MAX_ITEMS_PER_PAGE - 1, totalItems)
		for i = startIndex, endIndex do
			table.insert(itemsToShow, vendorFilteredItems[i])
		end
		
		vendorPrevBtn:Show()
		vendorNextBtn:Show()
		vendorPageText:Show()
		vendorPageText:SetText(string.format("%d / %d", currentVendorPage, totalPages))
		
		if currentVendorPage <= 1 then vendorPrevBtn:Disable() else vendorPrevBtn:Enable() end
		if currentVendorPage >= totalPages then vendorNextBtn:Disable() else vendorNextBtn:Enable() end
	else
		itemsToShow = vendorFilteredItems
		vendorPrevBtn:Hide()
		vendorNextBtn:Hide()
		vendorPageText:Hide()
	end
	
	local topOffset = -48
	if vendorPopup.hiddenText:IsShown() then
		topOffset = -62
	end

	local tileSize, margin = 50, 12
	local columns = 6
	local height = LayoutPopupItems(itemsToShow, "vendor", topOffset, tileSize + margin)
	local totalWidth = (25 * 2) + (columns * (tileSize + margin)) - margin
	
	if totalPages > 1 then
		height = math.abs(topOffset) + (6 * (tileSize + margin)) + 40
	end
	
dv.vendorPopup:SetHeight(height + 4)
end

function dv.ShowVendorPopup(vendorID, vendorName)
    if not vendorID or not dv.vendorGoodies or not dv.vendorGoodies[vendorID] then return end

    currentPopupVendorID = vendorID
    currentPopupNpcName = vendorName or currentPopupNpcName

    local allItems = dv.vendorGoodies[vendorID]

    local addedItems = {}
    local hiddenCount = 0

for _, itemID in ipairs(allItems) do
    table.insert(addedItems, itemID)
end

    vendorPopupTitle:SetText((currentPopupNpcName or "Vendor") .. " has these items:")
	vendorCheckmarkToggle:Show()
	vendorCheckmarkToggle:SetChecked(vendorSettings.showVendorCheckmarks)
    recipeTitle:Hide()
    for _, frame in pairs(popupIconCache) do frame:Hide() end

if hiddenCount > 0 then
    vendorPopup.hiddenText:SetText("(" .. hiddenCount .. " hidden)")
    vendorPopup.hiddenText:Show()
    titleSeparator:SetPoint("TOPLEFT", 10, -50)
    titleSeparator:SetPoint("TOPRIGHT", -10, -50)
else
    vendorPopup.hiddenText:Hide()
    titleSeparator:SetPoint("TOPLEFT", 10, -36)
    titleSeparator:SetPoint("TOPRIGHT", -10, -36)
end


    vendorFilteredItems = addedItems
    currentVendorPage = 1
    UpdateVendorPopup()
dv.vendorPopup:Show()
	if C_HousingCatalog and C_HousingCatalog.RequestHousingMarketInfoRefresh then
    C_HousingCatalog.RequestHousingMarketInfoRefresh()
end

C_Timer.After(0.1, function()
    if dv.vendorPopup:IsShown() then
        UpdateVendorPopup()
    end
end)

end

if not tContains(UISpecialFrames, "DV_ReagentsPopup") then
    tinsert(UISpecialFrames, "DV_ReagentsPopup")
end
-- ======================================
-- Reagents Popup (Docked Inside Preview)
-- ======================================
dv.reagentsPopup = CreateFrame("Frame", "DV_ReagentsPopup", frame.previewPanel, "BackdropTemplate")
local rpopup = dv.reagentsPopup
local modelWidth = frame.previewPanel.model:GetWidth()
rpopup:SetWidth(modelWidth - 20)
rpopup:ClearAllPoints()
rpopup:SetPoint("TOP", frame.previewPanel.model, "BOTTOM", 0, -12)
rpopup:SetFrameStrata(frame.previewPanel:GetFrameStrata())
rpopup:SetFrameLevel(frame.previewPanel:GetFrameLevel() + 5)
rpopup:SetClampedToScreen(true)
rpopup:Hide()

-- Title
rpopup.title = rpopup:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
rpopup.title:SetPoint("TOPLEFT", 14, -14)
rpopup.title:SetPoint("TOPRIGHT", -36, -14) -- leave room for close button
rpopup.title:SetJustifyH("CENTER")
rpopup.title:SetTextColor(1, 0.82, 0)
rpopup.title:SetText("Reagents Needed")

dv.reagentIconCache = dv.reagentIconCache or {}

local function GetReagentIconFrame(i)
    local f = dv.reagentIconCache[i]
    if f then
        f:Show()
        return f
    end

    f = CreateFrame("Frame", nil, rpopup.content, "BackdropTemplate")
    f:SetSize(50, 66)
    f:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2 })
    f:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
    f:SetClipsChildren(true)

    local btn = CreateFrame("Button", nil, f)
    btn:SetAllPoints()
    btn:RegisterForClicks("AnyUp")
    f.btn = btn

    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("TOPLEFT", 2, -2)
    icon:SetPoint("BOTTOMRIGHT", -2, 18)
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    f.icon = icon

    local countBg = f:CreateTexture(nil, "BACKGROUND")
    countBg:SetPoint("BOTTOMLEFT", 0, 0)
    countBg:SetPoint("BOTTOMRIGHT", 0, 0)
    countBg:SetHeight(16)
    countBg:SetColorTexture(0, 0, 0, 1)

    local countText = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    countText:SetPoint("BOTTOM", 0, 2)
    countText:SetTextColor(1, 1, 1, 1)
    f.countText = countText

    btn:SetScript("OnEnter", function(self)
        SetCursor("CAST_CURSOR")
        f:SetBackdropBorderColor(1, 0.82, 0, 1)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink("item:" .. self.itemID)
        GameTooltip:Show()
    end)

    btn:SetScript("OnLeave", function()
        ResetCursor()
        f:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
        GameTooltip:Hide()
    end)

    btn:SetScript("OnClick", function(self)
        if dv.ShowWowheadLinkPopup then
            dv.ShowWowheadLinkPopup(self.itemID, "item")
        end
    end)

    dv.reagentIconCache[i] = f
    return f
end

function dv.ShowReagentsPopup(itemData)

    if not dv.reagentsPopup then return end
    local rpopup = dv.reagentsPopup

    if not itemData or not itemData.reagents or #itemData.reagents == 0 then
        rpopup:Hide()
        return
    end

    -- Reset previous state
    for _, f in pairs(dv.reagentIconCache or {}) do
        f:Hide()
    end

    rpopup.recipeFrame:Hide()
    rpopup.recipeFrame.recipeID = nil

    -------------------------------------------------
    -- RECIPE HEADER
    -------------------------------------------------
    local yOffset = 0

    if itemData.recipe and itemData.recipe > 0 then

        rpopup.recipeFrame.recipeID = itemData.recipe

        rpopup.recipeIcon:SetTexture(
            GetItemIcon(itemData.recipe) or
            "Interface\\Icons\\INV_Scroll_03"
        )

        local itemObj = Item:CreateFromItemID(itemData.recipe)
        itemObj:ContinueOnItemLoad(function()
            if rpopup.recipeText then
                rpopup.recipeText:SetText(itemObj:GetItemName() or "Recipe")
            end
        end)

        rpopup.recipeFrame:Show()

        yOffset = -48  -- push reagents down under recipe
    end

    -------------------------------------------------
    -- REAGENT GRID
    -------------------------------------------------
    local tileSize   = 50
    local spacing    = 12
    local iconsPerRow = 4

    for i, reagent in ipairs(itemData.reagents) do
        local f = GetReagentIconFrame(i)
        f:ClearAllPoints()

        local row = math.floor((i - 1) / iconsPerRow)
        local col = (i - 1) % iconsPerRow

        f:SetPoint(
            "TOPLEFT",
            rpopup.content,
            "TOPLEFT",
            col * (tileSize + spacing),
            yOffset - (row * (tileSize + spacing))
        )

        f.btn.itemID = reagent.id
        f.icon:SetTexture(
            GetItemIcon(reagent.id) or
            "Interface\\Icons\\INV_Misc_QuestionMark"
        )
        f.countText:SetText(reagent.amount or 1)
        f:Show()
    end

    -------------------------------------------------
    -- RESIZE POPUP
    -------------------------------------------------
    local rows = math.ceil(#itemData.reagents / iconsPerRow)

    local popupHeight =
        (rows * (tileSize + spacing))
        + (itemData.recipe and 110 or 60)

    rpopup:SetHeight(popupHeight)
    rpopup:SetScale(vendorSettings and vendorSettings.scale or 1.0)
    rpopup:Show()
end

-- Content region
rpopup.content = CreateFrame("Frame", nil, rpopup)
rpopup.content:SetPoint("TOPLEFT", 12, -40)
rpopup.content:SetPoint("BOTTOMRIGHT", -12, 12)

rpopup.recipeFrame = CreateFrame("Button", nil, rpopup.content)
rpopup.recipeFrame:SetSize(300, 40)
rpopup.recipeFrame:SetPoint("TOPLEFT", rpopup.content, "TOPLEFT", 0, 0)
rpopup.recipeFrame:Hide()

rpopup.recipeIcon = rpopup.recipeFrame:CreateTexture(nil, "ARTWORK")
rpopup.recipeIcon:SetSize(40, 40)
rpopup.recipeIcon:SetPoint("LEFT", 0, 0)
rpopup.recipeIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

rpopup.recipeText = rpopup.recipeFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
rpopup.recipeText:SetPoint("LEFT", rpopup.recipeIcon, "RIGHT", 8, 0)
rpopup.recipeText:SetJustifyH("LEFT")
rpopup.recipeText:SetWidth(200)
rpopup.recipeText:SetWordWrap(false)
rpopup.recipeText:SetMaxLines(1)
rpopup.recipeFrame:SetScript("OnEnter", function(self)
    if not self.recipeID then return end

    GameTooltip:SetOwner(self, "ANCHOR_NONE")
    GameTooltip:ClearAllPoints()

    -- Anchor tooltip BELOW the reagents popup
    GameTooltip:SetPoint(
        "TOP",
        rpopup,
        "BOTTOM",
        0,
        -6
    )

    GameTooltip:SetHyperlink("item:" .. self.recipeID)
    GameTooltip:Show()
end)

rpopup.recipeFrame:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

rpopup.recipeFrame:SetScript("OnClick", function(self)
    if dv.ShowWowheadLinkPopup then
        dv.ShowWowheadLinkPopup(self.recipeID, "item")
    end
end)

local function UpdateGoodiePreview(goodie)

    if not goodie then return end

    local panel = frame.previewPanel
    if not panel or not panel.model then return end

    local model   = panel.model
    local texture = panel.texture

    panel._isVendorPreview = false

    -- Title
    if type(goodie.title) == "string" then
        panel.title:SetText(goodie.title)
    else
        panel.title:SetText("Preview")
    end

    -- Vendor display ID (NPC portrait mode)
    if goodie.vendorDisplayID then
        panel._isVendorPreview = true

        texture:Hide()
        model:ClearModel()
        model:SetDisplayInfo(goodie.vendorDisplayID)
        model:Show()
        return
    end

    -- 3D Model preview
    if goodie.model3D then
        texture:Hide()
        model:ClearModel()
        model:SetModel(goodie.model3D)
        model:Show()

        model:MakeCurrentCameraCustom()

        local pos = dv.modelPositions[goodie.model3D]
        if pos then
            model:SetPosition(pos.model_x, 0, pos.model_z)
            model:SetCameraPosition(0, 0, pos.camera_y)
            model:SetCameraDistance(pos.zoom)
        else
            model:SetPosition(0, 0, 0)
            model:SetCameraPosition(0, 0, 4)
            model:SetCameraDistance(10)
        end

        return
    end

    -- Texture preview
    if goodie.texture then
        model:Hide()
        texture:SetTexture(goodie.texture)
        texture:Show()
        return
    end

    -- Nothing
    model:Hide()
    if texture then texture:Hide() end
end
-------------------------------------------------
-- 🔹 The headers and Lines
-------------------------------------------------
function dv.CreateVendorHeader(parent, group, y, completed, total)

    completed = tonumber(completed) or 0
    total     = tonumber(total) or 0

    -- Collapse state per group
    if dv.collapsedHeaders[group.name] == nil then
        dv.collapsedHeaders[group.name] = true
    end

-- 🔥 FILTER-AWARE AUTO COLLAPSE / EXPAND (EXPANSIONS)
if dv.filtersJustChanged then
    if selectedExpansions and selectedExpansions[group.name] then
        dv.collapsedHeaders[group.name] = false
    else
        dv.collapsedHeaders[group.name] = true
    end
end

local header = CreateFrame("Button", nil, parent)
header:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, y)
header:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
header:SetHeight(32)

    -- Background
    local bg = header:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8x8")
    bg:SetGradient("HORIZONTAL",
        CreateColor(0.15, 0.10, 0.25, 0.9),
        CreateColor(0.05, 0.05, 0.15, 0.9)
    )

    -- Collapse icon
    header.icon = header:CreateFontString(nil, "OVERLAY")
    header.icon:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    header.icon:SetPoint("LEFT", 8, 0)
    header.icon:SetText(dv.collapsedHeaders[group.name] and ">>" or "<<")
    header.icon:SetTextColor(0.8, 0.8, 0.8, 1)

    -- Header title
    header.text = header:CreateFontString(nil, "OVERLAY")
    header.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    header.text:SetPoint("LEFT", 28, 0)
    header.text:SetText(
        string.format("%s (%d/%d found)", group.name or "Unknown", completed, total)
    )

    -- Progress (right)
    header.progress = header:CreateFontString(nil, "OVERLAY")
    header.progress:SetFont(STANDARD_TEXT_FONT, 11)
    header.progress:SetPoint("RIGHT", -8, 0)
    header.progress:SetText(string.format("%d/%d found", completed, total))

    -- Progress color
    local color
    if total > 0 and completed == total then
        color = CreateColor(0.2, 1, 0.2, 1)
    elseif completed >= total / 2 then
        color = CreateColor(1, 0.82, 0, 1)
    else
        color = CreateColor(0.9, 0.9, 0.9, 1)
    end
    header.progress:SetTextColor(color:GetRGBA())

    -- Click behavior
    header:SetScript("OnClick", function()
        dv.collapsedHeaders[group.name] = not dv.collapsedHeaders[group.name]
        BuildVendorUI()
    end)

    table.insert(dv.activeWidgets, header)
    return header, dv.collapsedHeaders[group.name], y - 36
end

function dv.CreateVendorLine(parent, vendor, y)
local line = CreateFrame("Button", nil, parent)
line:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, y)
line:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
line:SetHeight(22)
line:RegisterForClicks("AnyUp")

    -- Vendor name
    local text = line:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    text:SetPoint("LEFT", 0, 0)
    text:SetFont(STANDARD_TEXT_FONT, 12)
    text:SetText(vendor.title or "Unknown Vendor")

    local isFound =
        vendorSettings.visited
        and vendorSettings.visited[vendor.id]

    local function SetFactionColor()
        if vendor.faction == "alliance" then
            text:SetTextColor(0.3, 0.6, 1)
        elseif vendor.faction == "horde" then
            text:SetTextColor(1, 0.2, 0.2)
        else
            text:SetTextColor(0.2, 0.8, 0.3)
        end
    end
    SetFactionColor()

    if isFound and vendorSettings.markFoundVendors then
        text:SetTextColor(0.6, 0.6, 0.6)
        text:SetAlpha(0.7)
    end

    if vendor.zone then
        local zoneText = line:CreateFontString(nil, "OVERLAY")
        zoneText:SetFont(STANDARD_TEXT_FONT, 11)
        zoneText:SetPoint("RIGHT", -10, 0)
        zoneText:SetText(vendor.zone)
        zoneText:SetTextColor(1, 0.82, 0)
    end

local function UpdatePreview(vendor)
    if not vendor then return end

    local panel = frame.previewPanel
    local model = panel.model

    panel._isVendorPreview = true

    -- Title
    if panel.title then
        panel.title:SetText(vendor.title or "Vendor")
    end

    -- Model
    if vendor.model3D then
        model:ClearModel()
        model:SetDisplayInfo(vendor.model3D)
        model:Show()
    else
        model:Hide()
    end
end

line:SetScript("OnClick", function(_, button)
    if button == "LeftButton" then
        UpdatePreview(vendor)  -- model
        dv.ShowVendorPopup(vendor.id, vendor.title)  -- grid
    end
end)

line:SetScript("OnEnter", function()
    text:SetTextColor(1, 0.82, 0)

    GameTooltip:SetOwner(line, "ANCHOR_RIGHT")
    GameTooltip:AddLine(vendor.title, 1, 1, 1)

    if vendor.zone then
        GameTooltip:AddLine("Zone: " .. vendor.zone, 0.8, 0.8, 0.8)
    end

    if vendor.mapID then
        local mapInfo = C_Map.GetMapInfo(vendor.mapID)
        if mapInfo then
            GameTooltip:AddLine(mapInfo.name, 1, 0.82, 0)
        end
    end

    GameTooltip:AddLine("\n|cff00ff00<Left Click>|r Open Vendor Items", 1, 1, 1)
    GameTooltip:Show()
end)

line:SetScript("OnLeave", function()
    GameTooltip:Hide()

    if isFound and vendorSettings.markFoundVendors then
        text:SetTextColor(0.6, 0.6, 0.6)
        text:SetAlpha(0.7)
    else
        SetFactionColor()
        text:SetAlpha(1)
    end
end)

if vendor.mapID and vendor.x and vendor.y then
        local waypointBtn = CreateFrame("Button", nil, line, "UIPanelButtonTemplate")
        waypointBtn:SetSize(80, 18)
        waypointBtn:SetPoint("RIGHT", -240, 0)
        waypointBtn:SetText("Waypoint")

        waypointBtn:SetScript("OnClick", function()
            if hasTomTom then
                TomTom:AddWaypoint(
                    vendor.mapID,
                    vendor.x / 100,
                    vendor.y / 100,
                    {
                        title = vendor.title.. " - " .. (vendor.zone or ""),
                        persistent = false,
                        minimap = true,
                        world = true,
                    }
                )
            end

            local vec = CreateVector2D(vendor.x / 100, vendor.y / 100)
            local mapPoint = UiMapPoint.CreateFromVector2D(vendor.mapID, vec)
            C_Map.SetUserWaypoint(mapPoint)
            C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        end)
    end
    table.insert(dv.activeWidgets, line)
    return y - 24
end

function dv.CreateProfessionHeader(parent, profession, y, completed, total)
    completed = tonumber(completed) or 0
    total     = tonumber(total) or 0
	
dv.collapsedHeaders = dv.collapsedHeaders or {}

local key = "prof_" .. profession.name

-- Default collapsed
if dv.collapsedHeaders[key] == nil then
    dv.collapsedHeaders[key] = true
end

local collapsed = dv.collapsedHeaders[key]

-- If filters changed and this profession is no longer selected → collapse it
if dv.filtersJustChanged then
    if selectedProfessions and not selectedProfessions[profession.name] then
        dv.collapsedHeaders[key] = true
        collapsed = true
    end
end

	local header = CreateFrame("Button", nil, parent)
header:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, y)
header:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
header:SetHeight(32)

    -- Background
    local bg = header:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8x8")
    bg:SetGradient("HORIZONTAL",
        CreateColor(0.15, 0.10, 0.25, 0.9),
        CreateColor(0.05, 0.05, 0.15, 0.9)
    )

    -- Collapse icon
    header.icon = header:CreateFontString(nil, "OVERLAY")
    header.icon:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    header.icon:SetPoint("LEFT", 8, 0)
    header.icon:SetText(collapsed and ">>" or "<<")

    -- Title (LEFT)
    header.text = header:CreateFontString(nil, "OVERLAY")
    header.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    header.text:SetPoint("LEFT", 28, 0)
    header.text:SetText(string.format("%s (%d/%d learned)", profession.name or "Unknown", completed, total))

	    -- Right-side placeholder (optional)
    header.progress = header:CreateFontString(nil, "OVERLAY")
    header.progress:SetFont(STANDARD_TEXT_FONT, 11)
    header.progress:SetPoint("RIGHT", -8, 0)
    header.progress:SetText(string.format("%d/%d learned", completed, total))
	
	-- Progress color
    local color
    if total > 0 and completed == total then
        color = CreateColor(0.2, 1, 0.2, 1)
    elseif completed >= total / 2 then
        color = CreateColor(1, 0.82, 0, 1)
    else
        color = CreateColor(0.9, 0.9, 0.9, 1)
    end
    header.progress:SetTextColor(color:GetRGBA())

    -- Click to collapse
    header:SetScript("OnClick", function()
        dv.collapsedHeaders["prof_" .. profession.name] = not collapsed
        BuildVendorUI()
    end)

    table.insert(dv.activeWidgets, header)
    return collapsed, y - 36
end

function dv.CreateProfessionLine(parent, profItem, y)
local isCompleted = false
if profItem.spell then
    isCompleted = IsSpellKnown(profItem.spell) or IsPlayerSpell(profItem.spell)
end

	local line = CreateFrame("Button", nil, parent)
line:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, y)
line:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
line:SetHeight(22)
line:RegisterForClicks("AnyUp")

    local nameText = line:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	nameText:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    nameText:SetPoint("TOPLEFT", 0, -2)
    nameText:SetJustifyH("LEFT")
    nameText:SetText("• Loading item...")
	if isCompleted then
    nameText:SetTextColor(0.5, 1, 0.5)
else
    nameText:SetTextColor(0.95, 0.95, 0.95)
end

    -- Async-safe item name
    local itemObj = Item:CreateFromItemID(profItem.id)
    itemObj:ContinueOnItemLoad(function()
        if nameText then
            nameText:SetText(itemObj:GetItemName())
        end
    end)

    local skillText = line:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	skillText:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
	skillText:SetPoint("RIGHT", line, "RIGHT", -12, 0)
	skillText:SetJustifyH("RIGHT")

	local skillString = (profItem.skill or "Skill") .. " (" .. (profItem.skillNeeded or 0) .. ")"
	skillText:SetText(skillString)
    skillText:SetTextColor(0.95, 0.95, 0.95)

local function UpdatePreview(profItem)

    local panel = frame.previewPanel
    if not panel or not panel.model then return end

    local model = panel.model
    local modelID = profItem and profItem.model3D

    -- Reset vendor flag
    panel._isVendorPreview = false

    -- Set Title
    if profItem and profItem.id then
        local itemObj = Item:CreateFromItemID(profItem.id)
        itemObj:ContinueOnItemLoad(function()
            if panel.title then
                panel.title:SetText(itemObj:GetItemName() or "Preview")
            end
        end)
    else
        if panel.title then
            panel.title:SetText("Preview")
        end
    end

    -- Set Model
    if modelID then
        model:ClearModel()
        model:SetModel(modelID)
        model:Show()

        if panel.texture then
            panel.texture:Hide()
        end
    else
        model:Hide()
    end
end

line:HookScript("OnClick", function(_, button)

    if button == "LeftButton" then
        UpdatePreview(profItem)
        dv.ShowReagentsPopup(profItem)
    end

end)

line:SetScript("OnEnter", function(self)

    SetCursor("INSPECT_CURSOR")

    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetItemByID(profItem.id)
    GameTooltip:AddLine("\n|cff00ff00<Left Click>|r View Decor", 1, 1, 1)
    GameTooltip:AddLine("|cff00ff00<Left Click>|r View Reagents", 1, 1, 1)
    GameTooltip:Show()
end)

line:SetScript("OnLeave", function()
    ResetCursor()
    GameTooltip:Hide()
end)

    table.insert(dv.activeWidgets, line)
    return y - 22
end

function dv.CreateAchievementHeader(parent, achievement, y, completed, total)
	completed = tonumber(completed) or 0
    total     = tonumber(total) or 0
	
    -- Accept both string category headers AND table objects
    local headerName
    if type(achievement) == "string" then
        headerName = achievement
    elseif type(achievement) == "table" and achievement.name then
        headerName = achievement.name
    else
        headerName = "Unknown Category"
    end

    -- Build collapse identifier safely
    local collapseKey = "ach_" .. headerName

    if dv.collapsedHeaders[collapseKey] == nil then
        dv.collapsedHeaders[collapseKey] = true
    end

-- 🔥 FILTER-AWARE AUTO COLLAPSE / EXPAND
if dv.filtersJustChanged then
    if selectedCategories and selectedCategories[headerName] then
        dv.collapsedHeaders[collapseKey] = false
    else
        dv.collapsedHeaders[collapseKey] = true
    end
end


    local collapsed = dv.collapsedHeaders[collapseKey]

local header = CreateFrame("Button", nil, parent)
header:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, y)
header:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
header:SetHeight(32)

    -- Background gradient
    local bg = header:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8x8")
    bg:SetGradient("HORIZONTAL",
        CreateColor(0.15, 0.10, 0.25, 0.9),
        CreateColor(0.05, 0.05, 0.15, 0.9)
    )

    -- Collapse icon
    header.icon = header:CreateFontString(nil, "OVERLAY")
    header.icon:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    header.icon:SetPoint("LEFT", 8, 0)
    header.icon:SetText(collapsed and ">>" or "<<")

    -- Header title
    header.text = header:CreateFontString(nil, "OVERLAY")
    header.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    header.text:SetPoint("LEFT", 28, 0)
    header.text:SetText(string.format("%s (%d/%d completed)", headerName or "Unknown", completed, total))
	
	    -- Right-side placeholder (optional)
    header.progress = header:CreateFontString(nil, "OVERLAY")
    header.progress:SetFont(STANDARD_TEXT_FONT, 11)
    header.progress:SetPoint("RIGHT", -8, 0)
    header.progress:SetText(string.format("%d/%d completed", completed, total))
	
	-- Progress color
    local color
    if total > 0 and completed == total then
        color = CreateColor(0.2, 1, 0.2, 1)
    elseif completed >= total / 2 then
        color = CreateColor(1, 0.82, 0, 1)
    else
        color = CreateColor(0.9, 0.9, 0.9, 1)
    end
    header.progress:SetTextColor(color:GetRGBA())

    -- Click to collapse
    header:SetScript("OnClick", function()
        dv.collapsedHeaders[collapseKey] = not dv.collapsedHeaders[collapseKey]
        BuildVendorUI()
    end)

    table.insert(dv.activeWidgets, header)
    return collapsed, y - 36
end

if not dv.achievementPanel then
    dv.achievementPanel = CreateFrame("Frame", nil, frame.previewPanel, "BackdropTemplate")
    local panel = dv.achievementPanel

    panel:SetPoint("TOP", frame.previewPanel.model, "BOTTOM", 0, -10)
    panel:SetWidth(frame.previewPanel:GetWidth() - 20)

    panel:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })

    panel:SetBackdropColor(0, 0, 0, 0.95)
    panel:SetBackdropBorderColor(0.4, 0.4, 0.4)

    panel.text = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    panel.text:SetPoint("TOPLEFT", 10, -10)
    panel.text:SetPoint("TOPRIGHT", -10, -10)
    panel.text:SetJustifyH("LEFT")
    panel.text:SetWordWrap(true)

    panel:Hide()
end

function dv.CreateAchievementLine(parent, goodie, y)
    local id = goodie.id
    local _, _, _, isCompleted = GetAchievementInfo(id)

    if isCompleted and vendorSettings.hideCompletedThings and not vendorSettings.markCompletedThings then
        return y
    end

    local name = select(2, GetAchievementInfo(id)) or "Unknown Achievement"

	local line = CreateFrame("Button", nil, parent)
line:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, y)
line:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
line:SetHeight(22)
line:RegisterForClicks("AnyUp")

    line.text = line:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    line.text:SetPoint("LEFT", 0, 0)
    line.text:SetFont(STANDARD_TEXT_FONT, 12)
    line.text:SetText(name)

    if isCompleted then
        line.text:SetTextColor(0.2, 1, 0.2)
    end

-- Achievement Wowhead Wrapper
if not dv.achievementWowheadWrapper then

    dv.achievementWowheadWrapper = CreateFrame("Frame", nil, frame.previewPanel, "BackdropTemplate")
    local wrapper = dv.achievementWowheadWrapper

    wrapper:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })

    wrapper:SetBackdropColor(0.08, 0.08, 0.12, 0.95)
    wrapper:SetBackdropBorderColor(1, 0.82, 0, 1)

    wrapper:SetHeight(26)
    wrapper:SetWidth(frame.previewPanel:GetWidth() - 40)

    wrapper:SetPoint("TOP", frame.previewPanel.model, "BOTTOM", 0, -6)
    wrapper:Hide()

    -- Wowhead Icon
    wrapper.icon = wrapper:CreateTexture(nil, "ARTWORK")
    wrapper.icon:SetSize(16, 16)
    wrapper.icon:SetPoint("LEFT", 6, 0)
    wrapper.icon:SetTexture("Interface\\ICONS\\INV_Misc_Spyglass_03")

    -- Edit Box
    dv.achievementWowheadBox = CreateFrame("EditBox", nil, wrapper, "InputBoxTemplate")
    local box = dv.achievementWowheadBox

    box:SetAutoFocus(false)
    box:SetPoint("LEFT", wrapper.icon, "RIGHT", 6, 0)
    box:SetPoint("RIGHT", wrapper, "RIGHT", -6, 0)
    box:SetHeight(22)

    box:SetScript("OnMouseUp", function(self)
        self:HighlightText()
    end)

    box:SetScript("OnEditFocusLost", function(self)
        wrapper:Hide()
    end)
end

    local function SetBaseColor()
        if isCompleted and vendorSettings.markCompletedThings then
            line.text:SetTextColor(0.62, 0.62, 0.62)
            line.text:SetAlpha(0.7)
            return
        end

        line.text:SetAlpha(1)

        if goodie.faction then
            local f = string.lower(goodie.faction)
            if f == "alliance" then
                line.text:SetTextColor(0.3, 0.6, 1)
            elseif f == "horde" then
                line.text:SetTextColor(1, 0.2, 0.2)
            elseif f == "neutral" then
                line.text:SetTextColor(0.2, 0.8, 0.3)
            end
        else
            line.text:SetTextColor(0.9, 0.9, 0.9)
        end
    end
    SetBaseColor()

line:SetScript("OnEnter", function()

    line.text:SetTextColor(1, 0.82, 0)

    GameTooltip:SetOwner(line, "ANCHOR_RIGHT")
    --GameTooltip:SetHyperlink(GetAchievementLink(id))
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("|cff00ff00<Left Click>|r Open Achievement")
	GameTooltip:AddLine("|cff00ff00<Left Click>|r View Decor Item")
    GameTooltip:AddLine("|cffff5500<Left Click>|r Copy Wowhead Link")
    GameTooltip:Show()

end)

line:SetScript("OnClick", function(_, button)

    if button == "LeftButton" then

        local achievementID = goodie.id
        if not achievementID then return end

        -- 1️⃣ Update Decor Preview
        UpdateGoodiePreview(goodie)

        -- 2️⃣ Load & Open Achievement Frame
        if not AchievementFrame then
            AchievementFrame_LoadUI()
        end

        if not AchievementFrame:IsShown() then
            AchievementFrame_ToggleAchievementFrame()
        end

        AchievementFrame_SelectAchievement(achievementID)

        -------------------------------------------------
        -- 3️⃣ Show Wowhead Box ABOVE tooltip
        -------------------------------------------------
        if dv.achievementWowheadWrapper and dv.achievementWowheadBox then
            dv.achievementWowheadBox:SetText("https://www.wowhead.com/achievement=" .. achievementID)
            dv.achievementWowheadBox:HighlightText()
            dv.achievementWowheadWrapper:Show()
        end

        -------------------------------------------------
        -- 4️⃣ Create Tooltip (Permanent Under Wowhead)
        -------------------------------------------------
        if not DV_AchievementTooltip then
            DV_AchievementTooltip = CreateFrame(
                "GameTooltip",
                "DV_AchievementTooltip",
                frame.previewPanel,
                "GameTooltipTemplate"
            )
        end

        local tooltip = DV_AchievementTooltip

        tooltip:SetOwner(frame.previewPanel, "ANCHOR_NONE")
        tooltip:ClearAllPoints()

        -- Anchor under wowhead wrapper
        if dv.achievementWowheadWrapper then
            tooltip:SetPoint("TOP", dv.achievementWowheadWrapper, "BOTTOM", 0, -6)
        else
            tooltip:SetPoint("TOP", frame.previewPanel.model, "BOTTOM", 0, -10)
        end

        -- Width BEFORE hyperlink
        local maxWidth = frame.previewPanel:GetWidth() - 30
        tooltip:SetWidth(maxWidth)

        tooltip:ClearLines()
        tooltip:SetHyperlink(GetAchievementLink(achievementID))
        tooltip:Show()
    end
end)

line:SetScript("OnLeave", function()
    GameTooltip:Hide()
    SetBaseColor()
end)

    table.insert(dv.activeWidgets, line)
    return y - 22
end

function dv.CreateQuestHeader(parent, questGroup, y, completed, total)
    -- Normalize group name (string OR table)
	completed = tonumber(completed) or 0
    total     = tonumber(total) or 0
	
    local groupName = questGroup.name or tostring(questGroup)

    -- Create unique collapse key
    local collapseKey = "quest_" .. groupName

    -- Initialize collapse state
    if dv.collapsedHeaders[collapseKey] == nil then
        dv.collapsedHeaders[collapseKey] = true
    end

-- 🔥 FILTER-AWARE AUTO COLLAPSE / EXPAND
if dv.filtersJustChanged then
    if selectedCategories and selectedCategories[groupName] then
        dv.collapsedHeaders[collapseKey] = false
    else
        dv.collapsedHeaders[collapseKey] = true
    end
end

    local collapsed = dv.collapsedHeaders[collapseKey]

local header = CreateFrame("Button", nil, parent)
header:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, y)
header:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
header:SetHeight(32)
    -- Background
    local bg = header:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8x8")
    bg:SetGradient("HORIZONTAL",
        CreateColor(0.15, 0.10, 0.25, 0.9),
        CreateColor(0.05, 0.05, 0.15, 0.9)
    )

    -- Collapse icon
    header.icon = header:CreateFontString(nil, "OVERLAY")
    header.icon:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    header.icon:SetPoint("LEFT", 8, 0)
    header.icon:SetText(collapsed and ">>" or "<<")

    -- Title label
    header.text = header:CreateFontString(nil, "OVERLAY")
    header.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    header.text:SetPoint("LEFT", 28, 0)
    header.text:SetText(string.format("%s (%d/%d completed)", groupName or "Unknown", completed, total))

    -- Right-side placeholder (optional)
    header.progress = header:CreateFontString(nil, "OVERLAY")
    header.progress:SetFont(STANDARD_TEXT_FONT, 11)
    header.progress:SetPoint("RIGHT", -8, 0)
    header.progress:SetText(string.format("%d/%d completed", completed, total))
	
	-- Progress color
    local color
    if total > 0 and completed == total then
        color = CreateColor(0.2, 1, 0.2, 1)
    elseif completed >= total / 2 then
        color = CreateColor(1, 0.82, 0, 1)
    else
        color = CreateColor(0.9, 0.9, 0.9, 1)
    end
    header.progress:SetTextColor(color:GetRGBA())

    -- Collapse behavior
header:SetScript("OnClick", function()
    dv.collapsedHeaders[collapseKey] = not dv.collapsedHeaders[collapseKey]
    BuildVendorUI()
end)

    table.insert(dv.activeWidgets, header)
    return collapsed, y - 36
end

function dv.CreateQuestLine(parent, goodie, y)

    local id = goodie.id
    local isCompleted = dv.IsQuestEffectivelyCompleted(goodie)

    if isCompleted and vendorSettings.hideCompletedThings and not vendorSettings.markCompletedThings then
        return y
    end

    local name = dv.questTitleCache[id] or C_QuestLog.GetTitleForQuestID(id)
    local loading = false

    if name then
        dv.questTitleCache[id] = name
    else
        name = "|cff888888Quest title unavailable|r"
        loading = true
    end

    local line = CreateFrame("Button", nil, parent)
    line:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, y)
    line:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
    line:SetHeight(22)
    line:RegisterForClicks("AnyUp")

    line.text = line:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    line.text:SetPoint("LEFT", 0, 0)
    line.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    line.text:SetText(name)

    if goodie.note then
        line.note = line:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        line.note:SetPoint("RIGHT", -8, 0)
        line.note:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        line.note:SetJustifyH("RIGHT")
        line.note:SetText("|cffaaaaaa" .. goodie.note .. "|r")
    end

if not dv.questWowheadWrapper then

    dv.questWowheadWrapper = CreateFrame("Frame", nil, frame.previewPanel, "BackdropTemplate")
    local wrapper = dv.questWowheadWrapper

    wrapper:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })

    wrapper:SetBackdropColor(0.08, 0.08, 0.12, 0.95)
    wrapper:SetBackdropBorderColor(1, 0.82, 0, 1)

    wrapper:SetHeight(28)
    wrapper:SetPoint("TOP", frame.previewPanel.model, "BOTTOM", 0, -6)
    wrapper:SetWidth(frame.previewPanel:GetWidth() - 40)
    wrapper:Hide()

    -- ===============================
    -- ICON
    -- ===============================

    wrapper.icon = wrapper:CreateTexture(nil, "ARTWORK")
    wrapper.icon:SetSize(18, 18)
    wrapper.icon:SetPoint("LEFT", wrapper, "LEFT", 6, 0)
    wrapper.icon:SetTexture("Interface\\Icons\\INV_Misc_Spyglass_03")

    -- ===============================
    -- EDIT BOX
    -- ===============================

    dv.questWowheadBox = CreateFrame("EditBox", nil, wrapper, "InputBoxTemplate")
    local box = dv.questWowheadBox

    box:SetAutoFocus(false)
    box:SetHeight(22)

    box:SetPoint("LEFT", wrapper.icon, "RIGHT", 6, 0)
    box:SetPoint("RIGHT", wrapper, "RIGHT", -8, 0)

    box:SetScript("OnChar", function(self)
        self:SetText(self:GetText())
        self:HighlightText()
    end)

    box:SetScript("OnMouseUp", function(self)
        self:HighlightText()
    end)

    box:SetScript("OnEditFocusLost", function(self)
        wrapper:Hide()
    end)

    -- ===============================
    -- HOVER GLOW EFFECT
    -- ===============================

    wrapper:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(1, 0.9, 0.2, 1)
    end)

    wrapper:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(1, 0.82, 0, 1)
    end)

end

    local function SetBaseColor()
        if isCompleted and vendorSettings.markCompletedThings then
            line.text:SetTextColor(0.62, 0.62, 0.62)
            line.text:SetAlpha(0.7)
            return
        end

        line.text:SetAlpha(1)

        if goodie.faction then
            local f = string.lower(goodie.faction)
            if f == "alliance" then
                line.text:SetTextColor(0.3, 0.6, 1)
            elseif f == "horde" then
                line.text:SetTextColor(1, 0.2, 0.2)
            elseif f == "neutral" then
                line.text:SetTextColor(0.2, 0.8, 0.3)
            end
        else
            line.text:SetTextColor(0.9, 0.9, 0.9)
        end
    end
    SetBaseColor()

    if loading then
        QuestEventListener:AddCallback(id, function()
            local newName = C_QuestLog.GetTitleForQuestID(id)
            if newName and line.text:IsVisible() then
                line.text:SetText(newName)
                dv.questTitleCache[id] = newName
            end
        end)
    end

line:SetScript("OnClick", function(_, button)

    if button == "LeftButton" then
        UpdateGoodiePreview(goodie)

        if dv.questWowheadWrapper and dv.questWowheadBox then
            dv.questWowheadBox:SetText("https://www.wowhead.com/quest=" .. id)
            dv.questWowheadBox:HighlightText()
            dv.questWowheadWrapper:Show()
        end
    end
end)

    line:SetScript("OnEnter", function()
        line.text:SetTextColor(1, 0.82, 0)

        GameTooltip:SetOwner(line, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink("quest:" .. id)
        GameTooltip:AddLine("|cffff5500<Left Click>|r View Decor Item")
        GameTooltip:AddLine("|cffff5500<Left Click>|r Copy Wowhead Link")
        GameTooltip:Show()
    end)

    line:SetScript("OnLeave", function()
        GameTooltip:Hide()
        SetBaseColor()
    end)

    table.insert(dv.activeWidgets, line)

    return y - 22
end

function dv.CreateBossDropHeader(parent, group, collected, total, y)
    local pad = TAB_LEFT_PADDING[dv.currentTab] or 10
dv.collapsedHeaders = dv.collapsedHeaders or {}

local key = "boss_" .. group.name

-- Default: collapsed
if dv.collapsedHeaders[key] == nil then
    dv.collapsedHeaders[key] = true
end

local collapsed = dv.collapsedHeaders[key]
-- If filters changed and this header no longer matches filter → collapse it
if dv.filtersJustChanged then
    if selectedBossExpansions and not selectedBossExpansions[group.expansion] then
        dv.collapsedHeaders[key] = true
        collapsed = true
    end
end

local collected = 0
local total = 0

for _, boss in ipairs(group.items or {}) do
    total = total + 1

    if dv.IsItemCollected(boss.id) then
        collected = collected + 1
    end
end
local header = CreateFrame("Button", nil, parent)
header:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, y)
header:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
header:SetHeight(32)
	
    -- background
    local bg = header:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8x8")
    bg:SetGradient("HORIZONTAL",
        CreateColor(.15, .10, .25, .9),
        CreateColor(.05, .05, .15, .9)
    )

    -- collapse icon
    header.icon = header:CreateFontString(nil, "OVERLAY")
    header.icon:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    header.icon:SetPoint("LEFT", 8, 0)
    header.icon:SetText(dv.collapsedHeaders[key] and ">>" or "<<")

    -- TITLE
    header.text = header:CreateFontString(nil, "OVERLAY")
    header.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    header.text:SetPoint("LEFT", 28, 0)
    header.text:SetText(group.name)

    -- PROGRESS
    header.progress = header:CreateFontString(nil, "OVERLAY")
    header.progress:SetFont(STANDARD_TEXT_FONT, 11)
    header.progress:SetPoint("RIGHT", -10, 0)
    header.progress:SetText(("%d/%d collected"):format(collected, total))

    -- color code progress
    if total > 0 and collected == total then
        header.progress:SetTextColor(0.2,1,0.2)
    elseif collected >= total/2 then
        header.progress:SetTextColor(1,.82,0)
    else
        header.progress:SetTextColor(1,1,1)
    end

    -- click to collapse
    header:SetScript("OnClick", function()
        dv.collapsedHeaders[key] = not dv.collapsedHeaders[key]
        BuildVendorUI()
    end)

    table.insert(dv.activeWidgets, header)

    return dv.collapsedHeaders[key], y - 36
end

function dv.CreateBossDropLine(parent, boss, y)
    local pad = TAB_LEFT_PADDING[dv.currentTab] or 10

	local line = CreateFrame("Button", nil, parent)
	line:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, y)
	line:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
	line:SetHeight(22)
	line:RegisterForClicks("AnyUp")

    local nameFS = line:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameFS:SetPoint("LEFT", 0, 0)
	nameFS:SetText("Loading...")

	local item = Item:CreateFromItemID(boss.id)
	item:ContinueOnItemLoad(function()
    local itemName = item:GetItemName()
    if itemName and nameFS then
        nameFS:SetText(itemName)
    end
end)

    local isCollected = dv.IsItemCollected(boss.id)
    if isCollected then
        nameFS:SetTextColor(0.2, 1, 0.2) -- green
    else
        nameFS:SetTextColor(1, 1, 1)
    end

    local sourceFS = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    sourceFS:SetPoint("RIGHT", -8, 0)

    if boss.bossencounter then
        local encounterName = EJ_GetEncounterInfo(boss.bossencounter)
        sourceFS:SetText(encounterName or "Unknown Boss")
    elseif boss.bossevent then
        sourceFS:SetText(boss.bossevent)
    else
        sourceFS:SetText("Unknown Source")
    end
   	
local function UpdateBossPreview(boss)

    if not boss then return end

    local panel = frame.previewPanel
    if not panel or not panel.model then return end

    local model   = panel.model
    local texture = panel.texture

    panel._isVendorPreview = false

    -- Title
    if boss.id then
        local itemObj = Item:CreateFromItemID(boss.id)
        itemObj:ContinueOnItemLoad(function()
            if panel.title then
                panel.title:SetText(itemObj:GetItemName() or "Preview")
            end
        end)
    else
        panel.title:SetText("Preview")
    end

    -- 3D Model preview
    if boss.model3D then
        texture:Hide()
        model:ClearModel()
        model:SetModel(boss.model3D)
        model:Show()

        model:MakeCurrentCameraCustom()

        local pos = dv.modelPositions[boss.model3D]
        if pos then
            model:SetPosition(pos.model_x, 0, pos.model_z)
            model:SetCameraPosition(0, 0, pos.camera_y)
            model:SetCameraDistance(pos.zoom)
        else
            model:SetPosition(0, 0, 0)
            model:SetCameraPosition(0, 0, 4)
            model:SetCameraDistance(10)
        end

        return
    end

    -- Texture preview
    if boss.texture then
        model:Hide()
        texture:SetTexture(boss.texture)
        texture:Show()
        return
    end

    -- Nothing
    model:Hide()
    if texture then texture:Hide() end
end

line:SetScript("OnClick", function(_, button)

if button == "LeftButton" then
    UpdateBossPreview(boss)        -- decor model (top)
    elseif button == "RightButton" then
        if InCombatLockdown() then return end
        if boss.mapID then
            C_Map.OpenWorldMap(boss.mapID)
        end
    end
end)

line:SetScript("OnEnter", function()
    SetCursor("INSPECT_CURSOR")

    GameTooltip:SetOwner(line, "ANCHOR_RIGHT")
    GameTooltip:SetItemByID(boss.id)

    if boss.bossencounter then
        GameTooltip:AddLine("\nDrops from:", 1, 0.82, 0)

        local name = EJ_GetEncounterInfo(boss.bossencounter)
        GameTooltip:AddLine(name or "Unknown Boss", 1, 1, 1)

        GameTooltip:AddLine("\n|cff00ff00Left-Click|r View Decor", 1, 1, 1)
        GameTooltip:AddLine("|cff00ff00Right-Click|r View Dungeon Map", 1, 1, 1)

    elseif boss.bossevent then
        GameTooltip:AddLine("\nSource:", 1, 0.82, 0)
        GameTooltip:AddLine(boss.bossevent, 1, 1, 1)

        GameTooltip:AddLine("\n|cff00ff00Left-Click|r View Decor", 1, 1, 1)
        GameTooltip:AddLine("|cff00ff00Right-Click|r View Map", 1, 1, 1)
    end

    if isCollected then
        GameTooltip:AddLine("\n|cff00ff00Collected|r", 0.2, 1, 0.2)
    end

    GameTooltip:Show()
end)

line:SetScript("OnLeave", function()
    ResetCursor()
    GameTooltip:Hide()
end)
table.insert(dv.activeWidgets, line)
    return y - 24
end



function dv.CreateEventItemLine(parent, event, y)
    if not event then return y end

	local line = CreateFrame("Button", nil, parent)
line:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, y)
line:SetPoint("RIGHT", parent, "RIGHT", -6, 0)
line:SetHeight(100)

    -- Title
    local title = line:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 0, 0)
    title:SetText(event.title or "Event")

    -- Status
    local status = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    status:SetPoint("TOPRIGHT", -10, 0)

    local now = GetServerTime()
    if event.endTime and event.endTime > now then
        local days = math.ceil((event.endTime - now) / 86400)
        status:SetText("ACTIVE • " .. days .. " days remaining")
        status:SetTextColor(0.2, 1, 0.2)
    else
        status:SetText("ENDED")
        status:SetTextColor(0.6, 0.6, 0.6)
    end

    -- Description
    local desc = line:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    desc:SetWidth(560)
    desc:SetJustifyH("LEFT")
    desc:SetText(event.description or "")

    -- Note
    if event.note then
        local note = line:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        note:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -4)
        note:SetWidth(560)
        note:SetJustifyH("LEFT")
        note:SetText(event.note)
    end

    -- Reward previews
    if event.rewards then
        local previewY = -60
        local spacing = 72
        local x = 0

        for _, reward in ipairs(event.rewards) do
            local iconFrame = CreateFrame("Frame", nil, line)
            iconFrame:SetSize(80, 80)
            iconFrame:SetPoint("TOPLEFT", x, previewY)

            local tex = iconFrame:CreateTexture(nil, "ARTWORK")
            tex:SetAllPoints()

            if reward.decorID then
                local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, reward.decorID, true)
                if info and info.iconTexture then
                    tex:SetTexture(info.iconTexture)
                else
                    tex:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                end
            end

            x = x + spacing
        end
    end

    table.insert(dv.activeWidgets, line)
    return y - 150
end
-------------------------------------------------
-- 🔹 The Lists
-------------------------------------------------
local function HasAnySelection(tbl)
    if not tbl then return false end
    for _, v in pairs(tbl) do
        if v then return true end
    end
    return false
end

function BuildProfessionList()
    dv.ClearWidgets()

    -- Prepare filters
    selectedProfessions = selectedProfessions or {}
    local catSel = selectedProfessions
    local hasCategoryFilter = HasAnySelection(catSel)

    local y = -6
    local hasContent = false

    local professions = dv.professions or {}
    table.sort(professions, function(a, b)
        return (a.name or "") < (b.name or "")
    end)

    --------------------------------------------------------
    -- Loop through profession categories
    --------------------------------------------------------
    for _, profession in ipairs(professions) do

        ----------------------------------------------------
        -- CATEGORY FILTER
        ----------------------------------------------------
        if hasCategoryFilter and not catSel[profession.name] then
            -- skip profession
        else
            ------------------------------------------------
            -- Build visible items
            ------------------------------------------------
local visible = {}
local completedCount = 0
local totalCount = 0

for _, item in ipairs(profession.items or {}) do
    totalCount = totalCount + 1

local learned = false
if item.spell then
    learned = IsSpellKnown(item.spell) or IsPlayerSpell(item.spell)
end

if learned then
    completedCount = completedCount + 1
end

table.insert(visible, item)

end


            ------------------------------------------------
            -- Skip if empty
            ------------------------------------------------
            if #visible > 0 then
                hasContent = true

                ------------------------------------------------
                -- Get progress values
                ------------------------------------------------
                local completed, total = CountProfessionItems(profession)

                ------------------------------------------------
                -- Create header WITH progress
                ------------------------------------------------
                local collapsed, newY =
                    dv.CreateProfessionHeader(scrollChild, profession, y, completedCount, total)
                y = newY

                ------------------------------------------------
                -- Draw profession items
                ------------------------------------------------
                if not collapsed then
                    for _, item in ipairs(visible) do
                        y = dv.CreateProfessionLine(scrollChild, item, y)
                    end
                    y = y - 10
                end
            end
        end
    end

    --------------------------------------------------------
    -- Empty state
    --------------------------------------------------------
    if not hasContent then
        local msg = scrollChild:CreateFontString(nil, "OVERLAY")
        msg:SetFont(STANDARD_TEXT_FONT, 14)
        msg:SetPoint("TOP", 0, -50)
        msg:SetText("No profession data available.")
        msg:SetTextColor(0.7, 0.7, 0.7)
        table.insert(dv.activeWidgets, msg)
    end

    scrollChild:SetHeight(math.abs(y) + 40)
end

function BuildQuestList()
    dv.ClearWidgets()

    selectedQuests   = selectedQuests   or {}
	selectedExpansions = selectedExpansions or {}
    selectedFactionz = selectedFactionz or {}

    local catSel = selectedQuests
    local facSel = selectedFactionz
	local expSel = selectedExpansions

    local hasCategoryFilter = HasAnySelection(catSel)
    local hasFactionFilter  = HasAnySelection(facSel)
	local hasExpansionFilter = HasAnySelection(expSel)

    local y = -6

    --------------------------------------------------------
    -- Copy & sort quest groups
    --------------------------------------------------------
    local questGroups = {}
    for _, g in ipairs(dv.quests or {}) do
        table.insert(questGroups, g)
    end

    table.sort(questGroups, function(a, b)
        return (a.name or ""):lower() < (b.name or ""):lower()
    end)

    --------------------------------------------------------
    -- Loop groups
    --------------------------------------------------------
    for _, group in ipairs(questGroups) do

        -- CATEGORY FILTER
        if not hasExpansionFilter or expSel[group.expansion] then

            ------------------------------------------------
            -- Build visible list
            ------------------------------------------------
            local visible = {}

            for _, quest in ipairs(group.quests or {}) do
                if quest then
                    local include = true
                    local isCompleted = dv.IsQuestEffectivelyCompleted(quest)

                    -- Hide completed
                    if isCompleted and vendorSettings.hideCompletedThings and not vendorSettings.markCompletedThings then
                        include = false
                    end

                    -- Faction filter
                    if include and hasFactionFilter then
                        local f = quest.faction and string.lower(quest.faction)
                        if f and not facSel[f] then
                            include = false
                        end
                    end

                    if include then
                        table.insert(visible, quest)
                    end
                end
            end

            ------------------------------------------------
            -- Skip empty groups
            ------------------------------------------------
            if #visible > 0 then

                ------------------------------------------------
                -- Header counts (MATCH line logic)
                ------------------------------------------------
                local total, completed = 0, 0
                for _, quest in ipairs(visible) do
                    total = total + 1
                    if dv.IsQuestEffectivelyCompleted(quest) then
                        completed = completed + 1
                    end
                end

                ------------------------------------------------
                -- Header
                ------------------------------------------------
                local collapsed, newY = dv.CreateQuestHeader(
                    scrollChild,
                    group,
                    y,
                    completed,
                    total
                )
                y = newY

                ------------------------------------------------
                -- Lines
                ------------------------------------------------
                if not collapsed then
                    for _, quest in ipairs(visible) do
                        y = dv.CreateQuestLine(scrollChild, quest, y)
                    end
                    y = y - 10
                end
            end
        end
    end

    scrollChild:SetHeight(math.abs(y) + 20)
end

function BuildAchievementList()
    dv.ClearWidgets()

    -- Prepare filters
    selectedAchievements = selectedAchievements or {}
    selectedFactionz   = selectedFactionz   or {}

    local catSel = selectedAchievements
    local facSel = selectedFactionz

    local hasCategoryFilter = HasAnySelection(catSel)
    local hasFactionFilter  = HasAnySelection(facSel)
	



    local y = -6

    --------------------------------------------------------
    -- 1) Copy and sort achievement groups
    --------------------------------------------------------
    local achieveGroups = {}
    for _, g in ipairs(dv.achievements or {}) do
        achieveGroups[#achieveGroups + 1] = g
    end

    table.sort(achieveGroups, function(a, b)
        return (a.name or ""):lower() < (b.name or ""):lower()
    end)

    --------------------------------------------------------
    -- 2) Loop through category groups
    --------------------------------------------------------
    for _, group in ipairs(achieveGroups) do

        ----------------------------------------------------
        -- CATEGORY FILTER: skip group if not selected
        ----------------------------------------------------
        if hasCategoryFilter and not catSel[group.name] then
            -- skip entire category group
        else

            ------------------------------------------------
            -- Build list of visible achievements
            ------------------------------------------------
            local visible = {}

            for _, achieve in ipairs(group.achievements or {}) do
                local include = true
				local _, _, _, completed = GetAchievementInfo(achieve.id)

if completed and vendorSettings.hideCompletedThings and not vendorSettings.markCompletedThings then
    include = false
end

achieve.__isCompleted = completed


                -- FACTION FILTER
                if hasFactionFilter then
                    local f = achieve.faction and string.lower(achieve.faction)
                    if not facSel[f] then
                        include = false
                    end
                end

                if include then
                    table.insert(visible, achieve)
                end
            end


------------------------------------------------
-- Skip category if no matching achievements
------------------------------------------------
if #visible > 0 then

    --------------------------------------------
    -- COUNT ACHIEVEMENT COMPLETION (⬅️ NEW)
    --------------------------------------------
    local total, completed = 0, 0

    for _, achieve in ipairs(visible) do
        total = total + 1

        local _, _, _, isCompleted = GetAchievementInfo(achieve.id)
        if isCompleted then
            completed = completed + 1
        end
    end

    --------------------------------------------
    -- Create header WITH COUNTS
    --------------------------------------------
    local collapsed, newY = dv.CreateAchievementHeader(
        scrollChild,
        group.name,
        y,
        completed,
        total
    )
    y = newY

    --------------------------------------------
    -- Draw achievements only if header is expanded
    --------------------------------------------
    if not collapsed then
        for _, achieve in ipairs(visible) do
            y = dv.CreateAchievementLine(scrollChild, achieve, y)
        end
        y = y - 10
    end
end

        end
    end

    scrollChild:SetHeight(math.abs(y) + 20)
end

function BuildBossDropList()
    dv.ClearWidgets()
    local y = -6
    local hasContent = false

    selectedBossExpansions = selectedBossExpansions or {}
    local hasExpFilter = HasAnySelection(selectedBossExpansions)

    -- Copy groups
    local groups = {}
    for _, g in ipairs(dv.bossdrops or {}) do
        groups[#groups+1] = g
    end

    table.sort(groups, function(a,b)
        return (a.name or "") < (b.name or "")
    end)

for _, group in ipairs(groups) do

    -----------------------------------------
    -- EXPANSION FILTER
    -----------------------------------------
    if hasExpFilter and not selectedBossExpansions[group.expansion] then
        -- skip
    else

        -----------------------------------------
        -- UI EXISTENCE CHECK  ✅ RIGHT HERE
        -----------------------------------------
        if group.items and #group.items > 0 then
            hasContent = true
        end

        -----------------------------------------
        -- COUNT COLLECTED (UNCHANGED)
        -----------------------------------------
        local total = 0
        local collected = 0

        for _, boss in ipairs(group.items or {}) do
            local goodies = dv.vendorGoodies[boss.id]
            if goodies then
                for _, itemID in ipairs(goodies) do
                    total = total + 1
                    local _, _, _, _, _, _, _, _, _, _, isCollected =
                        C_TransmogCollection.GetItemInfo(itemID)
                    if isCollected then
                        collected = collected + 1
                    end
                end
            end
        end

        -----------------------------------------
        -- HEADER
        -----------------------------------------
        local collapsed, newY =
            dv.CreateBossDropHeader(scrollChild, group, collected, total, y)

        y = newY

        -----------------------------------------
        -- LINES
        -----------------------------------------
        if not collapsed then
            for _, boss in ipairs(group.items or {}) do
                y = dv.CreateBossDropLine(scrollChild, boss, y)
            end
            y = y - 10
        end
    end
end


    if not hasContent then
        local msg = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        msg:SetPoint("TOP", 0, -40)
        msg:SetText("No boss drop data available.")
        table.insert(dv.activeWidgets, msg)
    end

    scrollChild:SetHeight(math.abs(y) + 40)
end

function BuildVendorList()
    dv.ClearWidgets()

    local y = 0
    local hasContent = false

    -- Ensure filter tables exist
    selectedExpansions = selectedExpansions or {}
    selectedFactions   = selectedFactions   or {}

    local expSel = selectedExpansions
    local facSel = selectedFactions

    local hasExpansionFilter = HasAnySelection(expSel)
    local hasFactionFilter   = HasAnySelection(facSel)
	

    -- Copy & sort groups A–Z
    local groups = {}
    for _, group in ipairs(dv.npcs or {}) do
        groups[#groups + 1] = group
    end

    table.sort(groups, function(a, b)
        return (a.name or ""):lower() < (b.name or ""):lower()
    end)

    for _, group in ipairs(groups) do
        local passesExpansion =
            not hasExpansionFilter or expSel[group.expansion]

        if passesExpansion then
            local visibleVendors = {}

            for _, vendor in ipairs(group.vendors or {}) do
                local includeVendor = true

                if includeVendor then
                    local passesFaction =
                        not hasFactionFilter or facSel[vendor.faction]

                    if not passesFaction then
                        includeVendor = false
                    end
                end



if includeVendor then

local isFound = false
if vendorSettings.visited and vendorSettings.visited[vendor.id] then
    -- extra safety: only treat as found if faction matches player
    local playerFaction = UnitFactionGroup("player")
    playerFaction = playerFaction and playerFaction:lower()

    if vendor.faction == playerFaction or vendor.faction == "neutral" then
        isFound = true
    end
end

--[[local isComplete, missingCount = GetVendorStatus(vendor.id)

vendor.__isComplete = isComplete
vendor.__missing    = missingCount]]
vendor.__isFound    = isFound
    ----------------------------------------------------
    -- HIDE RULES
    ----------------------------------------------------
--[[if vendorSettings.hideCompletedThings and isComplete then
    includeVendor = false
end]]

end
                if includeVendor then
                    table.insert(visibleVendors, vendor)
                end
            end
            if #visibleVendors > 0 then
                hasContent = true

                table.sort(visibleVendors, function(a, b)
                    return (a.title or ""):lower() < (b.title or ""):lower()
                end)

                local total, completed = 0, 0
                for _, vendor in ipairs(group.vendors or {}) do
                    total = total + 1
                    if vendorSettings.visited and vendorSettings.visited[vendor.id] then
                        completed = completed + 1
                    end
                end

                local _, collapsed, newY =
                    dv.CreateVendorHeader(scrollChild, group, y, completed, total)
                y = newY

                if not collapsed then
                    for _, vendor in ipairs(visibleVendors) do
                        y = dv.CreateVendorLine(scrollChild, vendor, y)
                    end
                    y = y - 10
                end
            end
        end
    end

    if not hasContent then
        local msg = scrollChild:CreateFontString(nil, "OVERLAY")
        msg:SetFont(STANDARD_TEXT_FONT, 14)
        msg:SetPoint("TOP", 0, -50)
        msg:SetText("No vendors match these filters.")
        msg:SetTextColor(0.7, 0.7, 0.7)
        table.insert(dv.activeWidgets, msg)
    end

    scrollChild:SetHeight(math.abs(y) + 20)
end

function BuildEventList()
    dv.ClearWidgets()
    local y = -10

    for _, group in ipairs(dv.events or {}) do
        for _, event in ipairs(group.items or {}) do
            y = dv.CreateEventItemLine(scrollChild, event, y)
        end
        y = y - 10
    end

    scrollChild:SetHeight(math.abs(y) + 40)
end
-------------------------------------------------
-- 🔹 Pages
-------------------------------------------------
local function BuildAboutScreen()
    dv.ClearWidgets()

    local parent = scrollChild

    ----------------------------------------
    -- TITLE
    ----------------------------------------
    local title = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -80)
    title:SetTextColor(1, 0.82, 0)
    title:SetText("DecorVendor Addon")
    table.insert(dv.activeWidgets, title)

    ----------------------------------------
    -- DESCRIPTION
    ----------------------------------------
    local desc = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    desc:SetWidth(500)
    desc:SetPoint("TOP", title, "BOTTOM", 0, -20)
    desc:SetJustifyH("CENTER")
    desc:SetText("Created by MidniteDestiny\n\nThank you for using DecorVendor!\nThis addon provides vendors, quests, achievements,\npreviews, tracking tools, and more.")
    table.insert(dv.activeWidgets, desc)

    ----------------------------------------
    -- IMAGE
    ----------------------------------------
    local art = parent:CreateTexture(nil, "OVERLAY")
    art:SetSize(300, 300)
    art:SetPoint("TOP", desc, "BOTTOM", 0, -30)
    art:SetTexture("Interface\\AddOns\\DecorVendor\\Assets\\cutie") 
    -- (Do NOT include .png extension)
    table.insert(dv.activeWidgets, art)

    ----------------------------------------
    -- FOOTER (single centered line)
    ----------------------------------------
    local footer = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    footer:SetPoint("TOP", art, "BOTTOM", 0, -15)
    footer:SetJustifyH("CENTER")
    footer:SetWidth(300)  -- ensures no word wrapping
    footer:SetText("|cffffdd00Decor Vendor|r • developed by |cff00aaffMidniteDestiny|r • First to introduce vendor tracking")
    table.insert(dv.activeWidgets, footer)

    ----------------------------------------
    -- Update scroll area
    ----------------------------------------
    parent:SetHeight( art:GetHeight() + 300 )
end

local function CreateURLBox(parent, anchor, url)
    local box = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    box:SetSize(260, 24)
    box:SetPoint("LEFT", anchor, "RIGHT", 6, 0)
    box:SetAutoFocus(false)
    box:SetText(url)
    box:SetCursorPosition(0)

    -- Read-only behavior
    box:SetScript("OnChar", function(self)
        self:SetText(url)
        self:HighlightText()
    end)

    box:SetScript("OnTextChanged", function(self)
        if self:GetText() ~= url then
            self:SetText(url)
            self:HighlightText()
        end
    end)

    -- Highlight on click/focus
    box:SetScript("OnMouseUp", function(self)
        self:HighlightText()
    end)
    box:SetScript("OnEditFocusGained", function(self)
        self:HighlightText()
    end)

    -- Disabled look, but still selectable
    box:EnableMouse(true)
    box:Disable()
    box:Enable()

    return box
end

local function AddSupportLink(parent, labelText, url, y)
    -- Button
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(180, 26)
    btn:SetPoint("TOPLEFT", 20, y)
    btn:SetText(labelText)
    table.insert(dv.activeWidgets, btn)

    -- URL box (initially visible, but passive)
    local box = CreateURLBox(parent, btn, url)
    table.insert(dv.activeWidgets, box)

    -- Clicking button highlights URL
    btn:SetScript("OnClick", function()
        box:SetFocus()
        box:HighlightText()
    end)

    return y - 40
end

local function BuildSupportPage()
    dv.ClearWidgets()

    local parent = scrollChild
    local y = -6

    -- Title
    local title = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", parent, "TOP", 10, y)
    title:SetText("Support Decor Vendor")
    table.insert(dv.activeWidgets, title)
    y = y - 20

    local function AddText(text, spacing)
        local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        fs:SetPoint("TOPLEFT", 20, y)
        fs:SetWidth(500)
        fs:SetJustifyH("LEFT")
        fs:SetJustifyV("TOP")
        fs:SetText(text)

        table.insert(dv.activeWidgets, fs)
        y = y - (fs:GetStringHeight() + (spacing or 20))
    end

    AddText(
        "If you enjoy using Decor Vendor and want to support its development,\n" ..
        "all support is optional and deeply appreciated",
        20
    )
	AddText("|cff999999Tip: Buttons highlight links for copying. Use Ctrl+C to copy.|r", 15)


    AddText("|cffFFD200Preferred Support|r", 10)
    y = AddSupportLink(
        parent,
        "PayPal (Preferred)",
        "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=lizbella123@gmail.com&currency_code=USD&item_name=Decor+Vendor",
        y
    )
	
	AddText("If the PayPal link above does not work, you can also use:", 5)

	y = AddSupportLink(
		parent,
		"PayPal.me (Fallback)",
		"https://paypal.me/midnitedestiny",
		y
	)


    AddText("|cffFFD200Thank You|r", 10)
	AddText("Thank you to those who have supported me", 15)
	
	AddText("|cffFFD200Contact Me|r", 10)

	AddText(
    "If you truly need to reach me please use curseforge messaging,\n")
	
	AddText("|cffFFD200Curseforge Page|r", 10)
    y = AddSupportLink(parent, "Curseforge", "https://www.curseforge.com/wow/addons/decor-vendor", y)

	
    
	
	

    AddText(
        "Thank you for supporting the addon!\n" ..
        "Your support helps ongoing updates, fixes, and new features.",
        20
    )
end

local function BuildTipsPage()
    dv.ClearWidgets()

 local parent = scrollChild

    local y = -6

    -- Title
local title = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", parent, "TOP", 10, y)
title:SetText("Tips & Helpful Info")
table.insert(dv.activeWidgets, title)
y = y - 30


    -- Helper function for text blocks
local function AddText(text, spacing)
    local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    fs:SetPoint("TOPLEFT", 20, y)
    fs:SetWidth(500)
    fs:SetJustifyH("LEFT")
    fs:SetJustifyV("TOP")
    fs:SetText(text)

    table.insert(dv.activeWidgets, fs) -- 🔥 THIS IS THE FIX

    y = y - (fs:GetStringHeight() + (spacing or 20))
end

    -- Sections
	    AddText("|cffFFD200Notice|r", 10)
    AddText(
        "I believe I got the merchant frame and vendor popups to show items that are corrrectly owned in regards to quests, achievements, or just by buying them. Housing Neighborhood vendors still show incorrectly though")
		
		AddText("|cffFFD200Wowhead Links|r", 10)
    AddText(
        "When left clicking achievements or quests the link is now directly under the decor preview instead of being in line.")	
		
	    AddText("|cffFFD200Quests Related|r", 10)
    AddText(       
        "Some quests are showing up as Quest Title Unavaiable. Please disregard they do exist just right click to get the quest link.")	
 
		AddText("|cffFFD200Achievement Decor|r", 10)
    AddText(
		"Left Click opens the decor item and a tooltip with the achievement information under the decor. Brought back the Achievement Frame!")
		
		AddText("|cffFFD200Profession Decor|r", 10)
    AddText(
		"Left Click opens both Decor Preview and the reagents window underneath it. Once you learn the recipe it gets marked off. Per character!")	
		
		AddText("|cffFFD200Boss Drops|r", 10)
    AddText(
		"Left Click opens  Decor Preview. Righ Click will open the map to the Boss.")

		AddText("|cffFFD200Vendor Decor|r", 10)
    AddText(
		"Left Click opens  vendor Preview with items below the vendor. Left clicking each item will open the catalogue.")		
		
		AddText("|cffFFD200Housing Endeavor Vendors|r", 10)
    AddText(
        "The vendors are based on three possibilities: Public Neighboorhoods is server side chosen, Guild neighborhoods are Guild rank permission picked and finaly priority endeauvers are pushed first based on in game events like expansion related or possibly holiday")
	
		AddText("|cffFFD200Midnight Expansion Related|r", 10)
    AddText(
        "Vendors are loaded under Midnight Launch expansion not all have items loaded in for viewing")
	

	
AddText("|cffFFD200Faction Color Indicators|r  |cffff2020Red|r = Horde • |cff4faaffBlue|r = Alliance • |cff00ff00Green|r = Neutral", 10)
AddText("|cffFFD200Line Color Indicator|r  |cff9d9d9dGrey|r = Found Vendor, Completed Quest, and Achievements", 10)



end

local function BuildKnownIssuesList()
    dv.ClearWidgets()

    local parent = scrollChild
    local y = -6

    -- Title
    local title = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", parent, "TOP", 10, y)
    title:SetText("Known Issues & Limitations")
    table.insert(dv.activeWidgets, title)
    y = y - 30

    -- Helper function for text blocks
    local function AddText(text, spacing)
        local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        fs:SetPoint("TOPLEFT", 20, y)
        fs:SetWidth(500)
        fs:SetJustifyH("LEFT")
        fs:SetJustifyV("TOP")
        fs:SetText(text)

        table.insert(dv.activeWidgets, fs)
        y = y - (fs:GetStringHeight() + (spacing or 20))
    end

    -- Sections
    AddText("|cffFFD200Housing Catalog API Limitations|r", 10)
    AddText(
        "Decor Vendor relies on Blizzard’s Housing Catalog API. This system is still new and does not always provide reliable ownership or collection data for all decor items.\n"
    )

    AddText("|cffFFD200Decor Collection Accuracy|r", 10)
    AddText(
        "Some decor items do not provide a First-Time Collection Bonus (House XP) or ownership signals such as Owned, Placed, or In Storage.\n\n" ..
        "When no reliable signal exists, Decor Vendor will treat the item as missing rather than assuming it is collected."
    )

    AddText("|cffFFD200Why Some Vendors May Look Incorrect|r", 10)
    AddText(
        "Blizzard does not distinguish how decor was obtained. Items can be granted by quests, achievements, professions, starter kits, or events without registering as a vendor purchase.\n\n" ..
        "Because of this, a small number of vendors may appear incomplete even if some items were previously obtained."
    )

    AddText("|cffFFD200Reset Collection Cache|r", 10)
    AddText(
        "If vendor completion looks incorrect, use the |cff00ff00Reset Collection Cache|r button at the top of the window.\n\n" ..
        "This forces Decor Vendor to recalculate progress using live Housing Catalog data and does not delete vendor data."
    )

    AddText("|cffFFD200Important Note|r", 10)
    AddText(
        "Some addons may assume decor is collected when it is not. Decor Vendor prioritizes accuracy over assumptions and will not mark items as collected unless the Housing API confirms it."
    )
end

local function HideMerchantCheckmarks()
	for i = 1, MERCHANT_ITEMS_PER_PAGE do
		local button = _G["MerchantItem"..i.."ItemButton"]
		if button and button.dvCheckmark then
			button.dvCheckmark:Hide()
		end
	end
end

local function CreateOptionsPanel()
    local configFrame = CreateFrame("Frame", "DV_ConfigFrame", UIParent)
    configFrame.name = "Decor Vendor"

    -------------------------------------------------
    -- Title
    -------------------------------------------------
    local title = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("Decor Vendor Settings")
    title:SetTextColor(1, 0.82, 0)

    -------------------------------------------------
    -- Layout Settings
    -------------------------------------------------
    local yOffset = -60
    local spacing = 24

    -------------------------------------------------
    -- Section Header: Display
    -------------------------------------------------
    local displayHeader = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    displayHeader:SetPoint("TOPLEFT", 16, yOffset)
    displayHeader:SetText("Display")
    displayHeader:SetTextColor(1, 0.82, 0)

    yOffset = yOffset - 30

    -------------------------------------------------
    -- Show Minimap Button
    -------------------------------------------------
    local minimapCheck = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
    minimapCheck:SetPoint("TOPLEFT", 16, yOffset)
    minimapCheck.Text:SetFontObject(GameFontNormal)
    minimapCheck.Text:SetText("Show Minimap Button")
    minimapCheck:SetChecked(vendorSettings.showMinimapButton)
    minimapCheck:SetScript("OnClick", function(self)
        local show = self:GetChecked()
        vendorSettings.showMinimapButton = show
        dbDV.minimap.hide = not show

        if LibDBIcon then
            if show then
                LibDBIcon:Show("DecorVendor")
            else
                LibDBIcon:Hide("DecorVendor")
            end
        end
    end)

    yOffset = yOffset - spacing

    -------------------------------------------------
    -- Close on Escape
    -------------------------------------------------
    local escCheck = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
    escCheck:SetPoint("TOPLEFT", 16, yOffset)
    escCheck.Text:SetFontObject(GameFontNormal)
    escCheck.Text:SetText("Close on Escape")
    escCheck:SetChecked(vendorSettings.closeOnEsc)
    escCheck:SetScript("OnClick", function(self)
        vendorSettings.closeOnEsc = self:GetChecked()
        UpdateEscBehavior()
    end)

    yOffset = yOffset - spacing

    -------------------------------------------------
    -- Mark Found Vendors
    -------------------------------------------------
    local markFoundCheck = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
    markFoundCheck:SetPoint("TOPLEFT", 16, yOffset)
    markFoundCheck.Text:SetFontObject(GameFontNormal)
    markFoundCheck.Text:SetText("Mark Found Vendors")
    markFoundCheck:SetChecked(vendorSettings.markFoundVendors)
    markFoundCheck:SetScript("OnClick", function(self)
        vendorSettings.markFoundVendors = self:GetChecked()
        BuildVendorUI()
    end)

    yOffset = yOffset - spacing

    -------------------------------------------------
    -- Hide Completed
    -------------------------------------------------
    local hideCompletedCheck = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
    hideCompletedCheck:SetPoint("TOPLEFT", 16, yOffset)
    hideCompletedCheck.Text:SetFontObject(GameFontNormal)
    hideCompletedCheck.Text:SetText("Hide completed Quests and Achievements")
    hideCompletedCheck:SetChecked(vendorSettings.hideCompletedThings)
    hideCompletedCheck:SetScript("OnClick", function(self)
        vendorSettings.hideCompletedThings = self:GetChecked()
        BuildVendorUI()
    end)

    yOffset = yOffset - spacing

    -------------------------------------------------
    -- Mark Completed
    -------------------------------------------------
    local markCompletedCheck = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
    markCompletedCheck:SetPoint("TOPLEFT", 16, yOffset)
    markCompletedCheck.Text:SetFontObject(GameFontNormal)
    markCompletedCheck.Text:SetText("Mark completed Quests and Achievements")
    markCompletedCheck:SetChecked(vendorSettings.markCompletedThings)
    markCompletedCheck:SetScript("OnClick", function(self)
        vendorSettings.markCompletedThings = self:GetChecked()
        BuildVendorUI()
    end)

    yOffset = yOffset - spacing

    -------------------------------------------------
    -- Merchant Checkmarks
    -------------------------------------------------
    local showMerchantCheckmark = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
    showMerchantCheckmark:SetPoint("TOPLEFT", 16, yOffset)
    showMerchantCheckmark.Text:SetFontObject(GameFontNormal)
    showMerchantCheckmark.Text:SetText("Include Merchant Checkmarks")
    showMerchantCheckmark:SetChecked(vendorSettings.showMerchantCheckmarks)
    showMerchantCheckmark:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        vendorSettings.showMerchantCheckmarks = checked

        if not checked then
            HideMerchantCheckmarks()
        else
            MerchantFrame_Update()
        end
    end)

    yOffset = yOffset - 40

    -------------------------------------------------
    -- Scale Slider
    -------------------------------------------------
    local scaleLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    scaleLabel:SetPoint("TOPLEFT", 16, yOffset)
    scaleLabel:SetText("Scale for UI")
    scaleLabel:SetTextColor(1, 0.82, 0)

    yOffset = yOffset - 20

    local scaleSlider = CreateFrame("Slider", nil, configFrame, "MinimalSliderWithSteppersTemplate")
    scaleSlider:SetWidth(400)
    scaleSlider:SetPoint("TOPLEFT", 16, yOffset)
    scaleSlider:Init(vendorSettings.scale or 1.0, 0.5, 1.5, 20, {
        [MinimalSliderWithSteppersMixin.Label.Right] = function(value)
            return string.format("%.2f", value)
        end
    })

    scaleSlider.Slider:SetValueStep(0.05)
    scaleSlider:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
        local rounded = tonumber(string.format("%.2f", value))
        vendorSettings.scale = rounded
        frame:SetScale(rounded)
        vendorPopup:SetScale(rounded)
    end)

    -------------------------------------------------
    -- Footer
    -------------------------------------------------
    local footerText = configFrame:CreateFontString(nil, "OVERLAY")
    footerText:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
    footerText:SetPoint("BOTTOM", configFrame, "BOTTOM", 0, 28)
    footerText:SetText("|cffffdd00Decor Vendor|r • developed by |cff00aaffMidniteDestiny|r\n|cffffffffFirst to introduce vendor tracking|r")
    footerText:SetJustifyH("CENTER")

    -------------------------------------------------
    -- Register Category
    -------------------------------------------------
    local category = Settings.RegisterCanvasLayoutCategory(configFrame, "Decor Vendor")
    Settings.RegisterAddOnCategory(category)
    dv_optionsCategory = category
end
-------------------------------------------------
-- 🔹 Merchant Frame
-------------------------------------------------
local function HookMerchantFrame()
	hooksecurefunc("MerchantFrame_Update", function()
		if not vendorSettings.showMerchantCheckmarks then return end

		local guid = UnitGUID("npc")
		if not guid then return end
		local vendorID = select(6, strsplit("-", guid))
		vendorID = tonumber(vendorID)

		if not vendorID or not dv.vendorGoodies[vendorID] then
			HideMerchantCheckmarks()
			return
		end

		local numMerchantItems = GetMerchantNumItems()
		
		for i = 1, MERCHANT_ITEMS_PER_PAGE do
			local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)
			local button = _G["MerchantItem"..i.."ItemButton"]
			
			if button and button:IsShown() then
				if not button.dvCheckmark then
					local check = button:CreateTexture(nil, "OVERLAY", nil, 7)
					check:SetSize(18, 18)
					check:SetPoint("BOTTOM", 0, -8)
					check:SetTexture(COLLECTED_ICON_TEXTURE)
					button.dvCheckmark = check
				end
				
				local checked = false
				if index <= numMerchantItems then
					local itemLink = GetMerchantItemLink(index)
					if itemLink then
						local itemID = GetItemInfoInstant(itemLink)
						if itemID and dv.IsItemCollected(itemID) then
							checked = true
						end
					end
				end
				
				button.dvCheckmark:SetShown(checked)
			end
		end
	end)
end
-------------------------------------------------
-- 🔹 My UI Builder
-------------------------------------------------
function BuildVendorUI()
if not dv.catalogReady then
    return
end

    if dv.currentTab == "vendors" then
        BuildVendorList()

    elseif dv.currentTab == "professions" then
        BuildProfessionList()

    elseif dv.currentTab == "quests" then
        BuildQuestList()

    elseif dv.currentTab == "achievements" then
        BuildAchievementList()
		
	elseif dv.currentTab == "bossdrops" then
    BuildBossDropList()	
		
	elseif dv.currentTab == "about" then
        BuildAboutScreen()
		
	elseif dv.currentTab == "support" then
        BuildSupportPage()	
	
	elseif dv.currentTab == "tips" then
        BuildTipsPage()
		
	elseif dv.currentTab == "events" then
		BuildEventList()
		
	elseif dv.currentTab == "knownissues" then
		BuildKnownIssuesList()
end

   -- 🔥 RESET FILTER CHANGE FLAG AFTER BUILD
    dv.filtersJustChanged = false
    end

function dv.OpenMainUI()
    if C_HousingCatalog and C_HousingCatalog.RequestHousingMarketInfoRefresh then
        dv.waitingForMarketData = true
        C_HousingCatalog.RequestHousingMarketInfoRefresh()
    end

    BuildVendorUI()
end
-------------------------------------------------
-- 🔹Addon Loaded Init
-------------------------------------------------
local init = CreateFrame("Frame")
init:RegisterEvent("ADDON_LOADED")
init:RegisterEvent("PLAYER_ENTERING_WORLD")
init:RegisterEvent("MERCHANT_SHOW")
init:RegisterEvent("HOUSING_MARKET_AVAILABILITY_UPDATED")
init:RegisterEvent("ACHIEVEMENT_EARNED")
init:RegisterEvent("QUEST_TURNED_IN")
init:RegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")

local function InitDefaults()
    -- Saved settings
    vendorSettings = vendorSettings or {}

    vendorSettings.completedDrop         = vendorSettings.completedDrop or {}
	vendorSettings.visited               = vendorSettings.visited or {}
    if vendorSettings.showMinimapButton  == nil then vendorSettings.showMinimapButton  = true end
    if vendorSettings.closeOnEsc          == nil then vendorSettings.closeOnEsc          = true end
    if vendorSettings.scale               == nil then vendorSettings.scale               = 1.0 end
    if vendorSettings.hideCompletedThings == nil then vendorSettings.hideCompletedThings = false end
    if vendorSettings.markCompletedThings == nil then vendorSettings.markCompletedThings = false end
	if vendorSettings.showMerchantCheckmarks == nil then vendorSettings.showMerchantCheckmarks = false end
	if vendorSettings.showVendorCheckmarks == nil then vendorSettings.showVendorCheckmarks = false end

	


    -- Minimap DB
    dbDV = dbDV or {}
    dbDV.minimap = dbDV.minimap or {}
    dbDV.minimap.hide = not vendorSettings.showMinimapButton

    -- Filters
    selectedExpansions     = selectedExpansions     or {}
    selectedFactions       = selectedFactions       or {}
    selectedFactionz       = selectedFactionz       or {}
    selectedQuests         = selectedQuests         or {}
    selectedAchievements   = selectedAchievements   or {}
    selectedProfessions    = selectedProfessions    or {}
    selectedBossExpansions = selectedBossExpansions or {}
	
        -- Safe defaults for non-filter globals
     --   continentFilter = continentFilter or "All"
      --  zoneFilter      = zoneFilter      or "All"
	  
    -- UI state
     dv.currentTab = dv.currentTab or "vendors"

end

init:SetScript("OnEvent", function(self, event, loadedAddon, ...)

    if event == "ADDON_LOADED" and loadedAddon == addonName then
        InitDefaults()
        UpdateEscBehavior()
        BuildProfessionLookup()

        local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true)
        if ldb then
            local dataobj = ldb:NewDataObject("DecorVendor", {
                type  = "launcher",
                icon  = 7549289,
                label = "DecorVendor",
                text  = "DecorVendor",
                name  = "DecorVendor",

                OnClick = function(_, button)
						if button == "LeftButton" then
						if not frame:IsShown() then
								dv.OpenMainUI()
						end
						frame:SetShown(not frame:IsShown())
						elseif button == "RightButton" then
                        if dv_optionsCategory then
                            Settings.OpenToCategory(dv_optionsCategory:GetID())
                        end
                    end
                end
            })

            function dataobj:OnTooltipShow()
                self:AddLine("|cffffffffDecor Vendor|r")
                self:AddLine("|cff00ff00<Left Click>|r Toggle window")
                self:AddLine("|cff00ff00<Right Click>|r Options")
            end

            LibDBIcon:Register("DecorVendor", dataobj, dbDV.minimap)

            if vendorSettings.showMinimapButton then
                LibDBIcon:Show("DecorVendor")
            else
                LibDBIcon:Hide("DecorVendor")
            end
        end

        frame:SetScale(vendorSettings.scale or 1.0)
        CreateOptionsPanel()          -- keep ONLY here
        UpdateSidebarForTab()		
        --BuildVendorUI()
        return
    end

  if event == "PLAYER_ENTERING_WORLD" then
    local tries = 0

    C_Timer.NewTicker(0.5, function(ticker)
        tries = tries + 1

        -- 🔥 Find ANY decorID from your dataset
        local testDecorID
        if dv.decorItem then
            for _, data in pairs(dv.decorItem) do
                if data.decorID then
                    testDecorID = data.decorID
                    break
                end
            end
        end

        if not testDecorID then
            print("DV: No decorID available to test")
            ticker:Cancel()
            return
        end

        local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, testDecorID, true)

        if info ~= nil then
            --print("DV: Housing catalog ready")

            dv.catalogReady = true

            -- build lookup AFTER catalog is valid
            dv.decorIdToItemId = {}
            for itemID, data in pairs(dv.decorItem or {}) do
                dv.decorIdToItemId[data.decorID] = itemID
            end

            wipe(vendorSessionCache)
            dv.collectionCache = {}
			
            BuildVendorUI()
			HookMerchantFrame()
            ticker:Cancel()
            init:UnregisterEvent("PLAYER_ENTERING_WORLD")
            return
        end

        if tries > 20 then
            print("DV: Housing catalog never became usable (timed out)")
            ticker:Cancel()
        end
    end)

    return
end

if event == "MERCHANT_SHOW" then
    dv.waitingForMarketData = true

    if C_HousingCatalog and C_HousingCatalog.RequestHousingMarketInfoRefresh then
        C_HousingCatalog.RequestHousingMarketInfoRefresh()
    end
    return
end

if event == "HOUSING_MARKET_AVAILABILITY_UPDATED" then
    if dv.waitingForMarketData then
        dv.waitingForMarketData = false
        dv.catalogReady = true

        wipe(vendorSessionCache)
        dv.collectionCache = {}

        BuildVendorUI()
    end
    return
end

    if event == "ACHIEVEMENT_EARNED" or event == "QUEST_TURNED_IN" then
        C_Timer.After(0.5, BuildVendorUI)
        return
    end

if event == "HOUSE_DECOR_ADDED_TO_CHEST" then
    -- Ignore until catalog is ready
    if not dv.catalogReady then return end

    local decorID = ...
    local itemID = dv.decorIdToItemId and dv.decorIdToItemId[decorID]
    if not itemID then return end

    -- Mark as confirmed collected (fast path)
    vendorSettings.completedDrop[itemID] = true

    -- Invalidate vendor completion cache only
    wipe(vendorSessionCache)

    BuildVendorUI()
end

end)

-------------------------------------------------
-- 🔹 Slash Commands
-------------------------------------------------
SLASH_DECORVENDOR1 = "/decor"
SLASH_DECORVENDOR2 = "/dv"
SLASH_DECORVENDOR3 = "/decorvendor"
SlashCmdList["DECORVENDOR"] = function()
    if not frame:IsShown() then
        BuildVendorUI()
        frame:Show()
    else
        frame:Hide()
    end
end
-------------------------------------------------
-- 🔹 Addon Compartment
-------------------------------------------------
function DecorVendor_OnAddonCompartmentClick(addonName, button)
    if button == "LeftButton" then
        if frame:IsShown() then
            frame:Hide()
        else
            frame:Show()
        end
    elseif button == "RightButton" then
        if Settings and dv_optionsCategory then
            Settings.OpenToCategory(dv_optionsCategory:GetID())
        end
    end
end

function DecorVendor_OnAddonCompartmentEnter(addonName, button)
    GameTooltip:SetOwner(button, "ANCHOR_LEFT")
    GameTooltip:SetText("Decor Vendor", 1, 0.82, 0)

    GameTooltip:AddLine("Left-click: Open Decor Vendor", 1, 1, 1)
    GameTooltip:AddLine("Right-click: Open Settings", 1, 1, 1)

    GameTooltip:Show()
end

function DecorVendor_OnAddonCompartmentLeave(addonName, button)
    GameTooltip:Hide()
end

