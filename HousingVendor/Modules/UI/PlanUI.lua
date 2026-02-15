-- PlanUI.lua
-- Crafting list panel for aggregating reagents/costs.

local ADDON_NAME, ns = ...
local L = ns.L

local PlanUI = {}
PlanUI.__index = PlanUI

PlanUI._planContainer = PlanUI._planContainer or nil
PlanUI._parentFrame = PlanUI._parentFrame or nil

local planFrame = nil
local planListContainer = nil
local matsListContainer = nil
local planScrollFrame = nil
local matsScrollFrame = nil
local MATS_FOOTER_HEIGHT = 132
local MATS_FOOTER_GAP = 10
local planButtons = {}
local matButtons = {}
local PLAN_ROW_HEIGHT = 52
local MATS_ROW_HEIGHT = 52
local ROW_SPACING = 6
local ICON_SIZE = 38
local MATS_PRICE_VALUE_W = 140
local MATS_PRICE_LABEL_W = 56
local MATS_PRICE_RIGHT_PAD = 12
local MATS_PRICE_COL_GAP = 2
local MATS_PRICE_COL_WIDTH = 96
local selectedPlanItemID = nil

local listenerKey = "PlanUI"
local FormatMoneyFromCopper
local itemDataFrame = nil
local itemDataRefreshPending = false

local function GetTheme()
    return _G.HousingTheme or {}
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

local function EnsureColorTable(color, fallback)
    if type(color) ~= "table" then
        return { fallback[1], fallback[2], fallback[3], fallback[4] }
    end
    local r, g, b, a = tonumber(color[1]), tonumber(color[2]), tonumber(color[3]), tonumber(color[4])
    if not r or not g or not b then
        return { fallback[1], fallback[2], fallback[3], fallback[4] }
    end
    if a == nil then
        a = fallback[4]
    end
    return { r, g, b, a }
end

local function GetPlanManager()
    return ns.PlanManager or _G.HousingPlanManager
end

local function GetAuctionHouseAPI()
    return _G.HousingAuctionHouseAPI
end

local function GetVendorPriceAPI()
    return _G.HousingVendorPriceAPI
end

local function RequestItemDataByID(itemID)
    local id = tonumber(itemID)
    if not id then return false end
    if _G.C_Item and _G.C_Item.RequestLoadItemDataByID then
        pcall(_G.C_Item.RequestLoadItemDataByID, id)
    end
    if _G.C_Item and _G.C_Item.IsItemDataCachedByID then
        local ok, cached = pcall(_G.C_Item.IsItemDataCachedByID, id)
        if ok and cached == true then
            return true
        end
    end
    return false
end

local function GetItemRecordName(itemID)
    local dm = _G.HousingDataManager
    if dm and dm.GetItemRecord then
        local rec = dm:GetItemRecord(tonumber(itemID))
        if rec and rec.name and rec.name ~= "" and rec.name ~= "Unknown Item" then
            return rec.name
        end
    end
    if _G.C_Item and _G.C_Item.GetItemNameByID then
        local name = _G.C_Item.GetItemNameByID(tonumber(itemID))
        if name and name ~= "" then
            return name
        end
    end
    if _G.GetItemInfo then
        local name = _G.GetItemInfo(tonumber(itemID))
        if name and name ~= "" then
            return name
        end
    end
    RequestItemDataByID(itemID)
    return L["COMMON_LOADING"] or "Loading..."
end

local function GetItemIcon(itemID)
    local id = tonumber(itemID)
    if not id then return nil end
    if _G.C_Item and _G.C_Item.GetItemIconByID then
        return _G.C_Item.GetItemIconByID(id)
    end
    if _G.GetItemIcon then
        return _G.GetItemIcon(id)
    end
    return nil
end

local function GetItemTooltipLink(itemID)
    local id = tonumber(itemID)
    if not id then return nil end
    if _G.C_Item and _G.C_Item.GetItemLinkByID then
        local link = _G.C_Item.GetItemLinkByID(id)
        if link and link ~= "" then return link end
    end
    if _G.GetItemInfo then
        local link = select(2, _G.GetItemInfo(id))
        if link and link ~= "" then return link end
    end
    return nil
end

local function ShowItemTooltip(owner, itemID)
    if not owner then return end
    local id = tonumber(itemID)
    if not id then return end
    _G.GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
    local link = GetItemTooltipLink(id)
    if link and _G.GameTooltip.SetHyperlink then
        _G.GameTooltip:SetHyperlink(link)
    elseif _G.GameTooltip.SetItemByID then
        _G.GameTooltip:SetItemByID(id)
    end
    _G.GameTooltip:Show()
end

local function AddPlanTooltipLines(row, unitPrice)
    if not (_G.GameTooltip and _G.GameTooltip.AddLine and _G.GameTooltip.AddDoubleLine) then
        return
    end

    local function TitleCaseSource(src)
        src = type(src) == "string" and src or "unknown"
        if src == "vendor" then return L["PLAN_SOURCE_VENDOR"] or "Vendor" end
        if src == "gather" then return L["PLAN_SOURCE_GATHER"] or "Gather" end
        if src == "craft" then return L["PLAN_SOURCE_CRAFT"] or "Craft" end
        return L["PLAN_SOURCE_UNKNOWN"] or "Unknown"
    end

    local required = tonumber(row and row.required) or 0
    local ownedBags = tonumber(row and row.ownedBags) or 0
    local ownedBank = tonumber(row and row.ownedBank) or 0
    local ownedWarband = tonumber(row and row.ownedWarband) or 0
    local ownedAlts = tonumber(row and row.ownedAlts) or 0
    local ownedTotal = tonumber(row and row.ownedTotal) or 0
    local missing = tonumber(row and row.missing) or 0
    local missingWithAlts = tonumber(row and row.missingWithAlts) or 0

    _G.GameTooltip:AddLine(" ")
    _G.GameTooltip:AddLine(L["PLAN_TITLE"] or "Crafting List", 1, 1, 1)
    if row and row.source then
        _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_SOURCE"] or "Source", TitleCaseSource(row.source), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    end
    _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_REQUIRED"] or "Required", tostring(required), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_OWNED_BAGS"] or "Owned (bags)", tostring(ownedBags), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_OWNED_BANK"] or "Owned (bank)", tostring(ownedBank), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_OWNED_WARBAND"] or "Owned (warband)", tostring(ownedWarband), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_OWNED_ALTS"] or "Owned (alts)", tostring(ownedAlts), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_OWNED_TOTAL"] or "Owned (total)", tostring(ownedTotal), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_MISSING"] or "Missing", tostring(missing), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    if missingWithAlts ~= missing then
        _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_MISSING_WITH_ALTS"] or "Missing (with alts)", tostring(missingWithAlts), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    end

    unitPrice = tonumber(unitPrice)
    if unitPrice and unitPrice > 0 then
        _G.GameTooltip:AddLine(" ")
        _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_AH_UNIT"] or "AH unit", FormatMoneyFromCopper(unitPrice), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
        _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_AH_MISSING"] or "AH missing", FormatMoneyFromCopper(missing * unitPrice), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
        _G.GameTooltip:AddDoubleLine(L["PLAN_TOOLTIP_AH_ALL"] or "AH all", FormatMoneyFromCopper(required * unitPrice), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
    end

    local usedBy = row and row.usedBy
    if type(usedBy) == "table" and next(usedBy) ~= nil then
        local entries = {}
        for itemID, amt in pairs(usedBy) do
            entries[#entries + 1] = { itemID = tonumber(itemID), amount = tonumber(amt) or 0 }
        end
        table.sort(entries, function(a, b)
            if (a.amount or 0) ~= (b.amount or 0) then
                return (a.amount or 0) > (b.amount or 0)
            end
            return (a.itemID or 0) < (b.itemID or 0)
        end)

        _G.GameTooltip:AddLine(" ")
        _G.GameTooltip:AddLine(L["PLAN_TOOLTIP_USED_BY"] or "Used by:", 1, 1, 1)
        local maxLines = 8
        for i = 1, math.min(#entries, maxLines) do
            local e = entries[i]
            local name = GetItemRecordName(e.itemID)
            _G.GameTooltip:AddDoubleLine(name, "x" .. tostring(e.amount or 0), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
        end
        if #entries > maxLines then
            _G.GameTooltip:AddLine(string.format(L["PLAN_TOOLTIP_MORE_FMT"] or "...and %d more", #entries - maxLines), 0.7, 0.7, 0.7)
        end
    end

    _G.GameTooltip:Show()
end

local function HideTooltip()
    if _G.GameTooltip and _G.GameTooltip.Hide then
        _G.GameTooltip:Hide()
    end
end

FormatMoneyFromCopper = function(copper)
    local ppd = _G.HousingPreviewPanelData
    if ppd and ppd.Util and ppd.Util.FormatMoneyFromCopper then
        return ppd.Util.FormatMoneyFromCopper(copper)
    end
    if _G.GetCoinTextureString then
        return _G.GetCoinTextureString(tonumber(copper) or 0)
    end
    return tostring(tonumber(copper) or 0)
end

local function GetSelectedItemSummary(itemID)
    local id = tonumber(itemID)
    if not id then return L["PLAN_SELECT_ITEM_PROMPT"] or "Select an item in the list to see details." end

    local pr = ns.ProfessionReagents or (_G.HousingVendor and _G.HousingVendor.ProfessionReagents) or nil
    local data = pr and pr.GetReagents and pr:GetReagents(id) or nil
    local reagents = data and data.reagents
    if type(reagents) ~= "table" or #reagents == 0 then
        return "No reagent data for this item."
    end

    local total = 0
    for i = 1, #reagents do
        total = total + (tonumber(reagents[i] and reagents[i].amount) or 0)
    end

    local profession = (data and data.profession) or "Profession"
    return string.format("%s: %d reagents, %d total materials", profession, #reagents, total)
end

local function GetPlanItemSubText(itemID)
    local id = tonumber(itemID)
    if not id then return "" end
    local pr = ns.ProfessionReagents or (_G.HousingVendor and _G.HousingVendor.ProfessionReagents) or nil
    local data = pr and pr.GetReagents and pr:GetReagents(id) or nil
    local profession = data and data.profession
    if type(profession) ~= "string" or profession == "" then
        profession = "Profession"
    end

    local reagents = data and data.reagents
    if type(reagents) ~= "table" or #reagents == 0 then
        return profession
    end

    local total = 0
    for i = 1, #reagents do
        total = total + (tonumber(reagents[i] and reagents[i].amount) or 0)
    end

    return string.format("%s • %d reagents • %d mats", profession, #reagents, total)
end

local function GetPlanItemRecipeKnown(itemID)
    local id = tonumber(itemID)
    if not id then return nil end

    local pr = ns.ProfessionReagents or (_G.HousingVendor and _G.HousingVendor.ProfessionReagents) or nil
    if not pr then return nil end
    if pr.IsRecipeKnown then
        return pr:IsRecipeKnown(id)
    end
    return nil
end

local function AddRecipeKnownToTooltip(known, itemID)
    if not (_G.GameTooltip and _G.GameTooltip.AddLine) then
        return
    end
    if known == true then
        _G.GameTooltip:AddLine(L["PLAN_TOOLTIP_RECIPE_KNOWN"] or "Recipe: Known", 0.95, 0.85, 0.25)
        _G.GameTooltip:Show()
    elseif known == false then
        -- Check if any alts know this recipe
        local altProfs = _G.HousingAltProfessions
        local altsWithRecipe = altProfs and altProfs.GetCharsWithRecipe and altProfs:GetCharsWithRecipe(itemID) or {}
        
        if #altsWithRecipe > 0 then
            local altText = "Known by: "
            for i = 1, math.min(#altsWithRecipe, 5) do
                if i > 1 then
                    altText = altText .. ", "
                end
                local altInfo = altsWithRecipe[i]
                altText = altText .. altInfo.name
                if altInfo.profession then
                    altText = altText .. " (" .. altInfo.profession .. ")"
                end
            end
            if #altsWithRecipe > 5 then
                altText = altText .. ", ..." .. (#altsWithRecipe - 5) .. " more"
            end
            _G.GameTooltip:AddLine(altText, 0.95, 0.80, 0.40)
        else
            _G.GameTooltip:AddLine(L["PLAN_TOOLTIP_RECIPE_UNKNOWN"] or "Recipe: Unknown", 0.9, 0.5, 0.5)
        end
        _G.GameTooltip:Show()
    end
end

local function CreateThemedButton(parent, text, width)
    local theme = GetTheme()
    local colors = theme.Colors or {}
    local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    btn:SetSize(width or 90, 24)
    btn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    local bg = EnsureColorTable(colors.bgTertiary, { 0.16, 0.12, 0.24, 0.90 })
    local border = EnsureColorTable(colors.borderPrimary, { 0.35, 0.30, 0.50, 0.8 })
    btn:SetBackdropColor(bg[1], bg[2], bg[3], bg[4])
    btn:SetBackdropBorderColor(border[1], border[2], border[3], border[4])

    local label = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("CENTER")
    label:SetText(text)
    local textPrimary = EnsureColorTable(colors.textPrimary, { 0.92, 0.90, 0.96, 1.0 })
    label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    btn.label = label

    local bgHover = EnsureColorTable(colors.bgHover, { 0.22, 0.18, 0.32, 0.95 })
    local accent = EnsureColorTable(colors.accentPrimary, { 0.80, 0.55, 0.95, 1.0 })
    local textHighlight = EnsureColorTable(colors.textHighlight, { 0.98, 0.95, 1.0, 1.0 })
    btn:SetScript("OnEnter", function(selfBtn)
        selfBtn:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
        selfBtn:SetBackdropBorderColor(accent[1], accent[2], accent[3], 1)
        if selfBtn.label then
            selfBtn.label:SetTextColor(textHighlight[1], textHighlight[2], textHighlight[3], 1)
        end
    end)
    btn:SetScript("OnLeave", function(selfBtn)
        selfBtn:SetBackdropColor(bg[1], bg[2], bg[3], bg[4])
        selfBtn:SetBackdropBorderColor(border[1], border[2], border[3], border[4])
        if selfBtn.label then
            selfBtn.label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        end
    end)

    return btn
end

local function EnsureButton(pool, index, parent)
    if pool[index] then
        return pool[index]
    end
    local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    btn:SetHeight(PLAN_ROW_HEIGHT)
    btn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    pool[index] = btn
    return btn
end

local function ApplyRowTheme(btn)
    local theme = GetTheme()
    local colors = theme.Colors or {}
    local bg = EnsureColorTable(colors.bgTertiary, { 0.16, 0.12, 0.24, 0.90 })
    local border = EnsureColorTable(colors.borderPrimary, { 0.35, 0.30, 0.50, 0.8 })
    btn:SetBackdropColor(bg[1], bg[2], bg[3], bg[4])
    btn:SetBackdropBorderColor(border[1], border[2], border[3], 0.5)
end

local function EnsurePlanRowStyle(btn)
    if btn._hvPlanStyled then
        return
    end
    btn._hvPlanStyled = true

    local theme = GetTheme()
    local colors = theme.Colors or {}
    local bgHover = EnsureColorTable(colors.bgHover, { 0.22, 0.18, 0.32, 0.95 })
    local borderPrimary = EnsureColorTable(colors.borderPrimary, { 0.35, 0.30, 0.50, 0.8 })
    local textPrimary = EnsureColorTable(colors.textPrimary, { 0.92, 0.90, 0.96, 1.0 })
    local textSecondary = EnsureColorTable(colors.textSecondary, { 0.70, 0.68, 0.78, 1.0 })
    local statusSuccess = EnsureColorTable(colors.statusSuccess, { 0.30, 0.85, 0.50, 1.0 })

    btn.highlight = btn:CreateTexture(nil, "BACKGROUND")
    btn.highlight:SetAllPoints()
    btn.highlight:SetTexture("Interface\\Buttons\\WHITE8x8")
    btn.highlight:SetVertexColor(bgHover[1], bgHover[2], bgHover[3], 0.22)
    btn.highlight:Hide()

    btn.icon = btn:CreateTexture(nil, "ARTWORK")
    btn.icon:SetSize(ICON_SIZE, ICON_SIZE)
    btn.icon:SetPoint("LEFT", 12, 0)
    btn.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    btn.iconBorder = CreateFrame("Frame", nil, btn, "BackdropTemplate")
    btn.iconBorder:SetSize(ICON_SIZE + 4, ICON_SIZE + 4)
    btn.iconBorder:SetPoint("CENTER", btn.icon, "CENTER", 0, 0)
    btn.iconBorder:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    btn.iconBorder:SetBackdropColor(0.05, 0.05, 0.05, 0.8)
    btn.iconBorder:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)

    btn.name = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    btn.name:SetPoint("LEFT", btn.icon, "RIGHT", 12, 4)
    btn.name:SetPoint("RIGHT", -52, 4)
    btn.name:SetJustifyH("LEFT")
    btn.name:SetTextColor(statusSuccess[1], statusSuccess[2], statusSuccess[3], 1)
    btn.name:SetText("")

    btn.subText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    btn.subText:SetPoint("TOPLEFT", btn.name, "BOTTOMLEFT", 0, -2)
    btn.subText:SetPoint("RIGHT", -52, -2)
    btn.subText:SetJustifyH("LEFT")
    btn.subText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    btn.subText:SetText("")

    btn._hvHover = function(show)
        if show then
            btn.highlight:Show()
            btn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 1)
            btn.name:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        else
            btn.highlight:Hide()
            ApplyRowTheme(btn)
            btn.name:SetTextColor(statusSuccess[1], statusSuccess[2], statusSuccess[3], 1)
        end
    end
end

function PlanUI:CreateFrame()
    if planFrame then
        return planFrame
    end

    local parentFrame = self._parentFrame
    if not parentFrame then
        print("|cFF8A7FD4HousingVendor:|r PlanUI: No parent frame set")
        return nil
    end

    local theme = GetTheme()
    local colors = theme.Colors or {}

    local bg = EnsureColorTable(colors.bgPrimary, { 0.10, 0.07, 0.15, 0.98 })
    local border = EnsureColorTable(colors.borderPrimary, { 0.35, 0.30, 0.50, 0.8 })
    local accent = EnsureColorTable(colors.accentPrimary, { 0.80, 0.55, 0.95, 1.0 })
    local textPrimary = EnsureColorTable(colors.textPrimary, { 0.92, 0.90, 0.96, 1.0 })
    local textMuted = EnsureColorTable(colors.textMuted, { 0.50, 0.48, 0.58, 1.0 })
    local bgT = EnsureColorTable(colors.bgTertiary, { 0.16, 0.12, 0.24, 0.90 })

    if not itemDataFrame then
        itemDataFrame = CreateFrame("Frame")
        itemDataFrame:RegisterEvent("ITEM_DATA_LOAD_RESULT")
        itemDataFrame:SetScript("OnEvent", function()
            if not (planFrame and planFrame:IsShown()) then
                return
            end
            if itemDataRefreshPending then
                return
            end
            itemDataRefreshPending = true
            if _G.C_Timer and _G.C_Timer.After then
                _G.C_Timer.After(0.05, function()
                    itemDataRefreshPending = false
                    if planFrame and planFrame:IsShown() then
                        PlanUI:Refresh()
                    end
                end)
            else
                itemDataRefreshPending = false
                PlanUI:Refresh()
            end
        end)
    end

    -- Create container inside main UI (like ReputationUI)
    planFrame = CreateFrame("Frame", "HousingPlanContainer", parentFrame, "BackdropTemplate")
    planFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -70)
    planFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -20, 52)
    planFrame:Hide()
    self._planContainer = planFrame

    planFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    planFrame:SetBackdropColor(bg[1], bg[2], bg[3], 0.95)
    planFrame:SetBackdropBorderColor(border[1], border[2], border[3], 0.8)

    -- Back button (top-left)
    local backBtn = CreateThemedButton(planFrame, L["BUTTON_BACK"] or "Back", 80)
    backBtn:SetSize(80, 28)
    backBtn:SetPoint("TOPLEFT", 10, -10)
    backBtn:SetScript("OnClick", function()
        PlanUI:Hide()
    end)

    -- Title (next to back button)
    local title = planFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("LEFT", backBtn, "RIGHT", 10, 0)
    title:SetText(L["PLAN_TITLE"] or "Crafting List")
    title:SetTextColor(accent[1], accent[2], accent[3], 1)

    local summary = planFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    summary:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -2)
    summary:SetText(string.format(L["PLAN_SUMMARY_FMT"] or "Targets: %d  |  Mats (req/miss): %d/%d  |  Miss (alts): %d  |  Est. cost (missing): %s", 0, 0, 0, 0, FormatMoneyFromCopper(0)))
    summary:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)

    local helpBtn = CreateFrame("Button", nil, planFrame, "BackdropTemplate")
    helpBtn:SetSize(18, 18)
    helpBtn:SetPoint("LEFT", title, "RIGHT", 10, 0)
    helpBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    helpBtn:SetBackdropColor(bgT[1], bgT[2], bgT[3], bgT[4])
    helpBtn:SetBackdropBorderColor(border[1], border[2], border[3], 0.8)
    local qText = helpBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    qText:SetPoint("CENTER", 0, 0)
    qText:SetText("?")
    qText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    helpBtn:SetScript("OnEnter", function(selfBtn)
        if not (_G.GameTooltip and _G.GameTooltip.SetOwner) then
            return
        end
        _G.GameTooltip:SetOwner(selfBtn, "ANCHOR_RIGHT")
        _G.GameTooltip:AddLine(L["PLAN_TITLE"] or "Crafting List", 1, 1, 1)
        _G.GameTooltip:AddLine(L["PLAN_HELP_LINE1"] or "Add decor you plan to craft to see combined reagents.", 0.85, 0.85, 0.85, true)
        _G.GameTooltip:AddLine(L["PLAN_HELP_LINE2"] or "Left: crafting targets. Click a row, use X to remove.", 0.85, 0.85, 0.85, true)
        _G.GameTooltip:AddLine(L["PLAN_HELP_LINE3"] or "Right: aggregated materials with owned/missing and prices.", 0.85, 0.85, 0.85, true)
        _G.GameTooltip:Show()
    end)
    helpBtn:SetScript("OnLeave", function()
        if _G.GameTooltip and _G.GameTooltip.Hide then
            _G.GameTooltip:Hide()
        end
    end)

    -- Clear button (top-right)
    local clearBtn = CreateThemedButton(planFrame, L["PLAN_CLEAR_BUTTON"] or "Clear Craft List", 120)
    clearBtn:SetPoint("TOPRIGHT", -10, -10)
    clearBtn:SetScript("OnClick", function()
        local pm = GetPlanManager()
        if pm and pm.Clear then
            pm:Clear()
        end
    end)

    local leftPanel = CreateFrame("Frame", nil, planFrame, "BackdropTemplate")
    leftPanel:SetPoint("TOPLEFT", 12, -50)
    leftPanel:SetPoint("BOTTOMLEFT", 12, 12)
    leftPanel:SetWidth(300)
    leftPanel:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    leftPanel:SetBackdropColor(bgT[1], bgT[2], bgT[3], bgT[4])
    leftPanel:SetBackdropBorderColor(border[1], border[2], border[3], 0.5)

	    local leftTitle = leftPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	    leftTitle:SetPoint("TOPLEFT", 10, -10)
	    leftTitle:SetText(L["PLAN_TARGETS_TITLE"] or "Crafting Targets")
	    leftTitle:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

        local selectedInfo = CreateFrame("Frame", nil, leftPanel)
        selectedInfo:SetPoint("TOPLEFT", leftTitle, "BOTTOMLEFT", 0, -6)
        selectedInfo:SetPoint("RIGHT", -10, 0)
        selectedInfo:SetHeight(42)

        local selectedIcon = selectedInfo:CreateTexture(nil, "ARTWORK")
        selectedIcon:SetSize(32, 32)
        selectedIcon:SetPoint("LEFT", 0, 0)
        selectedIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        selectedIcon:SetTexture(nil)

        local selectedName = selectedInfo:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        selectedName:SetPoint("TOPLEFT", selectedIcon, "TOPRIGHT", 10, 2)
        selectedName:SetPoint("RIGHT", 0, 0)
        selectedName:SetJustifyH("LEFT")
        selectedName:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        selectedName:SetText("")

        local selectedDesc = selectedInfo:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        selectedDesc:SetPoint("TOPLEFT", selectedName, "BOTTOMLEFT", 0, -2)
        selectedDesc:SetPoint("RIGHT", 0, 0)
        selectedDesc:SetJustifyH("LEFT")
        selectedDesc:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
        selectedDesc:SetText(L["PLAN_SELECT_ITEM_PROMPT"] or "Select an item in the list to see details.")

	    local planScroll = CreateFrame("ScrollFrame", nil, leftPanel, "UIPanelScrollFrameTemplate")
	    planScroll:SetPoint("TOPLEFT", 6, -54)
	    planScroll:SetPoint("BOTTOMRIGHT", -28, 10)
        planScrollFrame = planScroll

	    planListContainer = CreateFrame("Frame", nil, planScroll)
	    planListContainer:SetSize(1, 1)
	    planScroll:SetScrollChild(planListContainer)
        planListContainer:SetWidth(math.max(1, (planScroll:GetWidth() or 1)))

	    local rightPanel = CreateFrame("Frame", nil, planFrame, "BackdropTemplate")
    rightPanel:SetPoint("TOPLEFT", leftPanel, "TOPRIGHT", 12, 0)
    rightPanel:SetPoint("BOTTOMRIGHT", -12, 12)
    rightPanel:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    rightPanel:SetBackdropColor(bgT[1], bgT[2], bgT[3], bgT[4])
    rightPanel:SetBackdropBorderColor(border[1], border[2], border[3], 0.5)

    local rightTitle = rightPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    rightTitle:SetPoint("TOPLEFT", 10, -10)
    rightTitle:SetText(L["PLAN_MATERIALS_TITLE"] or "Aggregated Materials (Owned vs Missing)")
    rightTitle:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local footer = CreateFrame("Frame", nil, rightPanel, "BackdropTemplate")
    footer:SetPoint("BOTTOMLEFT", 10, 10)
    footer:SetPoint("BOTTOMRIGHT", -10, 10)
    footer:SetHeight(MATS_FOOTER_HEIGHT)
    footer:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    footer:SetBackdropColor(bgT[1], bgT[2], bgT[3], math.min(1, (bgT[4] or 1) * 0.55))

    local footerLine = footer:CreateTexture(nil, "ARTWORK")
    footerLine:SetTexture("Interface\\Buttons\\WHITE8x8")
    footerLine:SetPoint("TOPLEFT", footer, "TOPLEFT", 0, 0)
    footerLine:SetPoint("TOPRIGHT", footer, "TOPRIGHT", 0, 0)
    footerLine:SetHeight(1)
    footerLine:SetVertexColor(border[1], border[2], border[3], 0.35)

    local footerCounts = footer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    footerCounts:SetPoint("TOPLEFT", 6, -10)
    footerCounts:SetPoint("TOPRIGHT", -6, -10)
    footerCounts:SetJustifyH("LEFT")
    footerCounts:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 0.9)
    footerCounts:SetText("")
    footerCounts:SetSpacing(2)

    local footerCosts = footer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    footerCosts:SetPoint("TOPLEFT", footerCounts, "BOTTOMLEFT", 0, -10)
    footerCosts:SetPoint("TOPRIGHT", footerCounts, "BOTTOMRIGHT", 0, -10)
    footerCosts:SetJustifyH("LEFT")
    footerCosts:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    footerCosts:SetText("")
    footerCosts:SetSpacing(2)

 	    local matsScroll = CreateFrame("ScrollFrame", nil, rightPanel, "UIPanelScrollFrameTemplate")
 	    matsScroll:SetPoint("TOPLEFT", 6, -34)
        matsScroll:SetPoint("BOTTOMRIGHT", footer, "TOPRIGHT", -18, MATS_FOOTER_GAP)
        matsScrollFrame = matsScroll

 	    matsListContainer = CreateFrame("Frame", nil, matsScroll)
 	    matsListContainer:SetSize(1, 1)
 	    matsScroll:SetScrollChild(matsListContainer)
        matsListContainer:SetWidth(math.max(1, (matsScroll:GetWidth() or 1)))

 	    planFrame._hv = {
            title = title,
            summary = summary,
            leftTitle = leftTitle,
            rightTitle = rightTitle,
            selectedIcon = selectedIcon,
            selectedName = selectedName,
            selectedDesc = selectedDesc,
	        rightFooter = footer,
            rightFooterCounts = footerCounts,
            rightFooterCosts = footerCosts,
            planScroll = planScroll,
            matsScroll = matsScroll,
 	    }

	        local function AdjustMatsScrollHeight()
	            -- Disabled: previously attempted to "snap" the list to full rows, but this can
	            -- accidentally collapse the scroll frame on some clients/sizes.
	            return
	        end

	        local function SyncScrollChildWidths()
	            if planScrollFrame and planListContainer then
	                planListContainer:SetWidth(math.max(1, (planScrollFrame:GetWidth() or 1)))
	            end
	            if matsScrollFrame and matsListContainer then
	                matsListContainer:SetWidth(math.max(1, (matsScrollFrame:GetWidth() or 1)))
	            end
	            AdjustMatsScrollHeight()
	        end

        planFrame:HookScript("OnShow", SyncScrollChildWidths)
        planScroll:HookScript("OnSizeChanged", SyncScrollChildWidths)
        matsScroll:HookScript("OnSizeChanged", SyncScrollChildWidths)

	    return planFrame
end

function PlanUI:Refresh()
    if not (planFrame and planFrame:IsShown()) then
        return
    end

    local pm = GetPlanManager()
    if not (pm and pm.GetItemIDs) then
        return
    end

    local theme = GetTheme()
    local colors = theme.Colors or {}
    local textPrimary = EnsureColorTable(colors.textPrimary, { 0.92, 0.90, 0.96, 1.0 })
    local textMuted = EnsureColorTable(colors.textMuted, { 0.50, 0.48, 0.58, 1.0 })
    local statusSuccess = EnsureColorTable(colors.statusSuccess, { 0.30, 0.85, 0.50, 1.0 })
    local statusWarning = EnsureColorTable(colors.statusWarning, { 0.95, 0.80, 0.25, 1.0 })
    local statusError = EnsureColorTable(colors.statusError, { 0.95, 0.25, 0.25, 1.0 })

    local itemIDs = pm:GetItemIDs()
    if planFrame and planFrame._hv and planFrame._hv.summary then
        planFrame._hv.summary:SetText(string.format(L["PLAN_SUMMARY_FMT"] or "Targets: %d  |  Mats (req/miss): %d/%d  |  Miss (alts): %d  |  Est. cost (missing): %s", #itemIDs, 0, 0, 0, FormatMoneyFromCopper(0)))
    end
    if planScrollFrame and planListContainer then
        planListContainer:SetWidth(math.max(1, (planScrollFrame:GetWidth() or 1)))
    end
    local y = 0
    for i = 1, math.max(#planButtons, #itemIDs) do
        local btn = planButtons[i]
        if btn then btn:Hide() end
    end

    for i = 1, #itemIDs do
        local itemID = itemIDs[i]
        RequestItemDataByID(itemID)
        local btn = EnsureButton(planButtons, i, planListContainer)
        ApplyRowTheme(btn)
        EnsurePlanRowStyle(btn)
        btn:SetPoint("TOPLEFT", 0, y)
        btn:SetPoint("TOPRIGHT", 0, y)
        btn:SetHeight(PLAN_ROW_HEIGHT)
        btn:Show()

        btn._hvItemID = itemID

        btn.icon:SetTexture(GetItemIcon(itemID) or "Interface\\Icons\\INV_Misc_QuestionMark")
        btn.name:SetText(GetItemRecordName(itemID))
        local profText = GetPlanItemSubText(itemID)
        local known = GetPlanItemRecipeKnown(itemID)
        if known == true then
            btn.subText:SetText(profText .. (L["PLAN_RECIPE_KNOWN_SUFFIX"] or " (Known)"))
        elseif known == false then
            btn.subText:SetText(profText)
        else
            btn.subText:SetText(profText)
        end

        if not btn._hvTooltipSetup then
            btn._hvTooltipSetup = true
            btn:SetScript("OnEnter", function(selfBtn)
                if selfBtn._hvHover then selfBtn._hvHover(true) end
                ShowItemTooltip(selfBtn, selfBtn._hvItemID)
                AddRecipeKnownToTooltip(GetPlanItemRecipeKnown(selfBtn._hvItemID), selfBtn._hvItemID)
            end)
            btn:SetScript("OnLeave", function(selfBtn)
                if selfBtn and selfBtn._hvHover then selfBtn._hvHover(false) end
                HideTooltip()
            end)
            btn:SetScript("OnClick", function(selfBtn)
                selectedPlanItemID = selfBtn._hvItemID
                if planFrame and planFrame._hv and planFrame._hv.selectedText then
                    planFrame._hv.selectedText:SetText(GetSelectedItemSummary(selectedPlanItemID))
                end
            end)
        end

        if not btn.removeBtn then
            btn.removeBtn = CreateThemedButton(btn, "X", 22)
            btn.removeBtn:SetPoint("RIGHT", -8, 0)
            btn.removeBtn:SetScript("OnClick", function()
                local mgr = GetPlanManager()
                if mgr and mgr.RemoveItem then
                    mgr:RemoveItem(itemID)
                end
            end)
        end

        y = y - (PLAN_ROW_HEIGHT + ROW_SPACING)
    end
    planListContainer:SetHeight(math.max(1, (#itemIDs * (PLAN_ROW_HEIGHT + ROW_SPACING))))

    if planFrame and planFrame._hv and planFrame._hv.selectedDesc and planFrame._hv.selectedName and planFrame._hv.selectedIcon then
        if selectedPlanItemID and pm.IsInPlan and not pm:IsInPlan(selectedPlanItemID) then
            selectedPlanItemID = nil
        end
        if selectedPlanItemID then
            planFrame._hv.selectedName:SetText(GetItemRecordName(selectedPlanItemID))
            planFrame._hv.selectedDesc:SetText(GetSelectedItemSummary(selectedPlanItemID))
            planFrame._hv.selectedIcon:SetTexture(GetItemIcon(selectedPlanItemID) or "Interface\\Icons\\INV_Misc_QuestionMark")
        else
            planFrame._hv.selectedName:SetText("")
            planFrame._hv.selectedDesc:SetText(L["PLAN_SELECT_ITEM_PROMPT"] or "Select an item in the list to see details.")
            planFrame._hv.selectedIcon:SetTexture(nil)
        end
    end

    local mats, totals = pm:GetAggregatedMaterials()
    if matsScrollFrame and matsListContainer then
        matsListContainer:SetWidth(math.max(1, (matsScrollFrame:GetWidth() or 1)))
    end
    for i = 1, #matButtons do
        if matButtons[i] then
            matButtons[i]:Hide()
        end
    end

    local headerText = L["PLAN_MATERIALS_TITLE"] or "Aggregated Materials (Owned vs Missing)"
    if totals and (totals.missingTotal or 0) > 0 then
        headerText = string.format(L["PLAN_MATERIALS_MISSING_FMT"] or "Aggregated Materials (Missing %d)", totals.missingTotal or 0)
    end
    if planFrame._hv and planFrame._hv.rightTitle then
        planFrame._hv.rightTitle:SetText(headerText)
    end

    local api = GetAuctionHouseAPI()
    local vapi = GetVendorPriceAPI()
    local totalCostMissing = 0
    local totalCostRequired = 0
    local vendorCostMissing = 0
    local vendorCostRequired = 0
    local pricedMats = 0
    local pricedVendor = 0

    y = 0
    for i = 1, #mats do
        local row = mats[i]
        RequestItemDataByID(row.itemID)
        local btn = EnsureButton(matButtons, i, matsListContainer)
        ApplyRowTheme(btn)
        btn:SetPoint("TOPLEFT", 0, y)
        btn:SetPoint("TOPRIGHT", 0, y)
        btn:SetHeight(MATS_ROW_HEIGHT)
        btn:Show()

        btn._hvItemID = row.itemID
        btn._hvRow = row

        if not btn.icon then
            btn.icon = btn:CreateTexture(nil, "ARTWORK")
            btn.icon:SetSize(ICON_SIZE, ICON_SIZE)
            btn.icon:SetPoint("TOPLEFT", 10, -10)
            btn.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	        end
	        btn.icon:SetTexture(GetItemIcon(row.itemID) or "Interface\\Icons\\INV_Misc_QuestionMark")

		        -- Hide legacy 4-field layout if it exists (older builds)
		        if btn.totalValue then btn.totalValue:Hide() end
		        if btn.totalLabel then btn.totalLabel:Hide() end
		        if btn.unitValue then btn.unitValue:Hide() end
		        if btn.unitLabel then btn.unitLabel:Hide() end

		        if not btn.totalPriceText then
		            btn.totalPriceText = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		            btn.totalPriceText:SetJustifyH("RIGHT")
		            btn.totalPriceText:SetJustifyV("TOP")
		            btn.totalPriceText:SetWordWrap(false)
		            btn.totalPriceText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
		        end
		        btn.totalPriceText:ClearAllPoints()
		        -- Anchor to the right edge so the price columns don't "drift" when the container width changes.
		        btn.totalPriceText:SetPoint("TOPRIGHT", btn, "TOPRIGHT", -MATS_PRICE_RIGHT_PAD, -10)
		        btn.totalPriceText:SetWidth(MATS_PRICE_COL_WIDTH)

		        if not btn.unitPriceText then
		            btn.unitPriceText = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		            btn.unitPriceText:SetJustifyH("RIGHT")
		            btn.unitPriceText:SetJustifyV("TOP")
		            btn.unitPriceText:SetWordWrap(false)
		            btn.unitPriceText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
		        end
		        btn.unitPriceText:ClearAllPoints()
		        btn.unitPriceText:SetPoint("TOPRIGHT", btn.totalPriceText, "TOPLEFT", -MATS_PRICE_COL_GAP, 0)
		        btn.unitPriceText:SetWidth(MATS_PRICE_COL_WIDTH)

		        if not btn.name then
		            btn.name = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		            btn.name:SetJustifyH("LEFT")
		            btn.name:SetJustifyV("TOP")
		            btn.name:SetWordWrap(false)
		            btn.name:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
		        end
		        btn.name:ClearAllPoints()
		        btn.name:SetPoint("TOPLEFT", btn.icon, "TOPRIGHT", 12, 0)
		        btn.name:SetPoint("RIGHT", btn.unitPriceText, "LEFT", -12, 0)
		        btn.name:SetText(GetItemRecordName(row.itemID))

	        if not btn.counts then
	            btn.counts = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	            btn.counts:SetJustifyH("LEFT")
	            btn.counts:SetJustifyV("TOP")
	            btn.counts:SetWordWrap(false)
	        end
	        btn.counts:ClearAllPoints()
	        btn.counts:Hide()

	        if not btn.reqLine then
	            btn.reqLine = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	            btn.reqLine:SetJustifyH("LEFT")
	            btn.reqLine:SetJustifyV("TOP")
	            btn.reqLine:SetWordWrap(false)
	            if btn.reqLine.SetMaxLines then
	                btn.reqLine:SetMaxLines(1)
	            end
	        end
	        btn.reqLine:ClearAllPoints()
	        btn.reqLine:SetPoint("TOPLEFT", btn.name, "BOTTOMLEFT", 0, -4)
	        btn.reqLine:SetPoint("RIGHT", btn.unitPriceText, "LEFT", -12, 0)

	        if btn.invLine then
	            btn.invLine:Hide()
	        end

        local stateColor = statusSuccess
        if row.state == "not_ready" then
            stateColor = statusError
        elseif row.state == "almost" then
            stateColor = statusWarning
        end

        local owned = tonumber(row.ownedTotal) or 0
        local required = tonumber(row.required) or 0
        local missing = tonumber(row.missing) or 0
        local bagCount = tonumber(row.ownedBags) or 0
        local bankCount = tonumber(row.ownedBank) or 0
        local warbandCount = tonumber(row.ownedWarband) or 0
        local altsCount = tonumber(row.ownedAlts) or 0

        local unitPrice, priceLabel = nil, "Unit"
        local isVendor = (row and row.source) == "vendor"
        if isVendor then
            priceLabel = "Vendor"
            if vapi and vapi.GetVendorPrice then
                unitPrice = select(1, vapi:GetVendorPrice(row.itemID))
            end
        else
            priceLabel = "Unit"
            if api and api.GetOrFetchAddonPrice then
                unitPrice = select(1, api:GetOrFetchAddonPrice(row.itemID))
            end
        end
        unitPrice = tonumber(unitPrice)

        if btn.unitPriceText then
            btn.unitPriceText:SetText("")
            btn.unitPriceText:Show()
        end
        if btn.totalPriceText then
            btn.totalPriceText:SetText("")
            btn.totalPriceText:Show()
        end

        if unitPrice and unitPrice > 0 then
            local missingCost = missing * unitPrice
            local totalCost = required * unitPrice
            if isVendor and priceLabel == "Vendor" then
                pricedVendor = pricedVendor + 1
                vendorCostMissing = vendorCostMissing + missingCost
                vendorCostRequired = vendorCostRequired + totalCost
            else
                pricedMats = pricedMats + 1
                totalCostMissing = totalCostMissing + missingCost
                totalCostRequired = totalCostRequired + totalCost
 	            end
                -- Keep the row compact: show just the prices (source + breakdown is in the tooltip).
                if btn.unitPriceText then btn.unitPriceText:SetText(FormatMoneyFromCopper(unitPrice)) end
                if btn.totalPriceText then btn.totalPriceText:SetText(FormatMoneyFromCopper(totalCost)) end
 		        else
                    if btn.unitPriceText then btn.unitPriceText:SetText(L["PLAN_NO_PRICE"] or "No price") end
                    if btn.totalPriceText then btn.totalPriceText:SetText("") end
 		        end

        if btn.reqLine then
            btn.reqLine:SetTextColor(stateColor[1], stateColor[2], stateColor[3], 1)
            btn.reqLine:SetText(string.format(L["PLAN_REQ_OWN_MISS_FMT"] or "Req %d Own %d Miss %d", required, owned, missing))
        end
	        if btn.invLine then
	            btn.invLine:Hide()
	        end

        if not btn._hvTooltipSetup then
            btn._hvTooltipSetup = true
            btn:SetScript("OnEnter", function(selfBtn)
                local currentRow = selfBtn._hvRow
                local p = nil
                local ah = GetAuctionHouseAPI()
                if ah and ah.GetOrFetchAddonPrice and currentRow and currentRow.itemID then
                    p = select(1, ah:GetOrFetchAddonPrice(currentRow.itemID))
                end
                ShowItemTooltip(selfBtn, selfBtn._hvItemID)
                AddPlanTooltipLines(currentRow, p)
            end)
            btn:SetScript("OnLeave", function()
                HideTooltip()
            end)
        end

        y = y - (MATS_ROW_HEIGHT + ROW_SPACING)
    end
    matsListContainer:SetHeight(math.max(1, (#mats * (MATS_ROW_HEIGHT + ROW_SPACING))))

    if planFrame and planFrame._hv and planFrame._hv.rightFooterCounts and planFrame._hv.rightFooterCosts then
        if #mats == 0 then
            planFrame._hv.rightFooterCounts:SetText("")
            planFrame._hv.rightFooterCosts:SetText("")
        else
            local priced = pricedMats .. "/" .. tostring(#mats)
            local pricedV = pricedVendor .. "/" .. tostring(#mats)
            local reqTotal = totals and tonumber(totals.requiredTotal) or 0
            local missTotal = totals and tonumber(totals.missingTotal) or 0
            local missAlts = totals and tonumber(totals.missingWithAltsTotal) or missTotal
            local bagsTotal = totals and tonumber(totals.bagsTotal) or 0
            local bankTotal = totals and tonumber(totals.bankTotal) or 0
            local warbandTotal = totals and tonumber(totals.warbandTotal) or 0
            local altsTotal = totals and tonumber(totals.altsTotal) or 0

            planFrame._hv.rightFooterCounts:SetText(
                "Mats: req " .. tostring(reqTotal) .. " / miss " .. tostring(missTotal) .. " (alts " .. tostring(missAlts) .. ")\n"
                .. "Owned: Bags " .. tostring(bagsTotal) .. "  Bank " .. tostring(bankTotal) .. "  Warband " .. tostring(warbandTotal) .. "  Alts " .. tostring(altsTotal) .. "\n"
                .. "Prices: AH " .. priced .. "  Vendor " .. pricedV
            )

            planFrame._hv.rightFooterCosts:SetText(
                "Total AH (missing): " .. FormatMoneyFromCopper(totalCostMissing) .. "\n"
                .. "Vendor (missing): " .. FormatMoneyFromCopper(vendorCostMissing) .. "\n"
                .. "Total AH (all): " .. FormatMoneyFromCopper(totalCostRequired) .. "  Vendor (all): " .. FormatMoneyFromCopper(vendorCostRequired)
            )
        end
    end

    if planFrame and planFrame._hv and planFrame._hv.summary then
        local reqTotal = totals and tonumber(totals.requiredTotal) or 0
        local missTotal = totals and tonumber(totals.missingTotal) or 0
        local missAlts = totals and tonumber(totals.missingWithAltsTotal) or missTotal
        local estMissing = (tonumber(totalCostMissing) or 0) + (tonumber(vendorCostMissing) or 0)
        planFrame._hv.summary:SetText(string.format(
            L["PLAN_SUMMARY_FMT"] or "Targets: %d  |  Mats (req/miss): %d/%d  |  Miss (alts): %d  |  Est. cost (missing): %s",
            #itemIDs,
            reqTotal,
            missTotal,
            missAlts,
            FormatMoneyFromCopper(estMissing)
        ))
    end
end

function PlanUI:Initialize(parent)
    self._parentFrame = parent
end

function PlanUI:Show()
    if not self._parentFrame then
        print("|cFF8A7FD4HousingVendor:|r PlanUI: Not initialized")
        return
    end
    
    self:CreateFrame()
    if not planFrame then
        return
    end

    -- Hide other embedded UI panels to avoid overlap
    if HousingAchievementsUI and HousingAchievementsUI.Hide then
        HousingAchievementsUI:Hide()
    end
    if HousingEndeavorsUI and HousingEndeavorsUI.Hide then
        HousingEndeavorsUI:Hide()
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
    
    -- Hide main UI components
    SetMainUIVisible(false)
    
    -- Show plan container
    planFrame:Show()
    self:Refresh()
end

function PlanUI:Hide()
    if planFrame then
        planFrame:Hide()
    end
    
    -- Restore main UI components
    SetMainUIVisible(true)
    
    -- Reset preview panel to show placeholder (clear any stale item data)
    local previewFrame = _G["HousingPreviewFrame"]
    if previewFrame then
        if previewFrame.details then
            previewFrame.details:Hide()
        end
        if previewFrame.placeholder then
            previewFrame.placeholder:Show()
        end
        previewFrame._currentItem = nil
        previewFrame._vendorInfo = nil
        previewFrame._trainerInfo = nil
        previewFrame._waypointInfo = nil
        previewFrame._waypointContext = nil
    end
end

function PlanUI:Toggle()
    if not self._parentFrame then
        print("|cFF8A7FD4HousingVendor:|r PlanUI: Not initialized")
        return
    end
    
    self:CreateFrame()
    if not planFrame then
        return
    end
    
    if planFrame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

function PlanUI:SetupEventListeners()
    local pm = GetPlanManager()
    if pm and pm.RegisterListener then
        pm:RegisterListener(listenerKey, function(event)
            if event == "plan_changed" or event == "plan_cleared" then
                if planFrame and planFrame:IsShown() then
                    PlanUI:Refresh()
                end
            end
        end)
    end

    local api = GetAuctionHouseAPI()
    if api and api.RegisterListener then
        api:RegisterListener(listenerKey, function(event)
            if event == "price_updated" or event == "scan_completed" or event == "scan_stopped" then
                if planFrame and planFrame:IsShown() then
                    PlanUI:Refresh()
                end
            end
        end)
    end

    local vapi = GetVendorPriceAPI()
    if vapi and vapi.RegisterListener then
        vapi:RegisterListener(listenerKey, function(event)
            if event == "vendor_price_updated" then
                if planFrame and planFrame:IsShown() then
                    PlanUI:Refresh()
                end
            end
        end)
    end
end

PlanUI:SetupEventListeners()

ns.PlanUI = PlanUI
_G.HousingPlanUI = PlanUI

return PlanUI
