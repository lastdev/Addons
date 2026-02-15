------------------------------------------------------------
-- PREVIEW PANEL UI - UI Creation Module
------------------------------------------------------------

local AddonName, HousingVendor = ...
local L = _G["HousingVendorL"] or {}

local PreviewPanelUI = {}
PreviewPanelUI.__index = PreviewPanelUI

local DATA_VERSION_LABEL = "Data v12.0.1.165617 Some Data Inaccuracy may occur"

local function GetTheme()
    return HousingTheme or {}
end

function PreviewPanelUI:CreateUI(parent, previewFrame)
    local theme = GetTheme()
    local colors = theme.Colors or {}
    
    -- Position on RIGHT side next to narrower item list
    previewFrame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -10, -190)
    previewFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 40)
    previewFrame:SetWidth(320)  -- Narrower preview panel for compact layout
    
    previewFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    local bgSecondary = HousingTheme.Colors.bgSecondary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    previewFrame:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.95)
    previewFrame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    previewFrame:Show()  -- Show by default with placeholder

    self:CreateHeader(previewFrame)
    self:CreateDetailsPanel(previewFrame)
end

function PreviewPanelUI:CreateHeader(previewFrame)
    local header = CreateFrame("Frame", nil, previewFrame, "BackdropTemplate")
    header:SetPoint("TOPLEFT", 0, 0)
    header:SetPoint("TOPRIGHT", 0, 0)
    header:SetHeight(100)
    
    local headerBg = header:CreateTexture(nil, "BACKGROUND")
    headerBg:SetAllPoints()
    headerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    headerBg:SetGradient("VERTICAL", 
        CreateColor(0.15, 0.10, 0.22, 0.8), 
        CreateColor(0.10, 0.07, 0.15, 0.6))
    
    previewFrame.header = header

    -- Icon + Name section (top)
    self:CreateIconAndName(previewFrame, header)
    
    -- Action buttons row (below icon+name)
    self:CreateActionButtons(previewFrame, header)
end

function PreviewPanelUI:CreateActionButtons(previewFrame, header)
    -- Position in blue header area below item name/trainer info
    local buttonY = -68  -- In blue header area
    
    -- Create in right-to-left order so anchoring works correctly:
    -- 1. Wishlist button (rightmost)
    self:CreateWishlistButton(previewFrame, header, buttonY)
    
    -- 2. Materials button (anchored to wishlist button's left)
    self:CreateMaterialsButton(previewFrame, header, buttonY)
    
    -- 3. Waypoint button (anchored to materials button's left)
    self:CreateMapButton(previewFrame, header, buttonY)
    
    -- 4. 3D Model viewer button (anchored to waypoint button's left)
    self:Create3DModelButton(previewFrame, header, buttonY)
end

function PreviewPanelUI:CreateWishlistButton(previewFrame, header, yOffset)
    local wishlistButton = CreateFrame("Button", nil, header)
    wishlistButton:SetSize(28, 28)
    wishlistButton:SetPoint("TOPRIGHT", header, "TOPRIGHT", -10, yOffset or -65)
    wishlistButton:SetFrameLevel(previewFrame:GetFrameLevel() + 5)
    
    local wishlistIcon = wishlistButton:CreateTexture(nil, "ARTWORK")
    wishlistIcon:SetAllPoints(wishlistButton)
    wishlistIcon:SetTexture("Interface\\Icons\\INV_ValentinesCandy")
    wishlistIcon:SetDesaturated(true)
    wishlistButton.icon = wishlistIcon
    previewFrame.wishlistButton = wishlistButton
    
    local statusWarning = HousingTheme.Colors.statusWarning
    local accentPrimary = HousingTheme.Colors.accentPrimary
    
    wishlistButton:SetScript("OnClick", function(self, mouseButton)
        if mouseButton == "LeftButton" then
            local item = previewFrame._currentItem
            if not item or not item.itemID then return end
            
            local itemID = tonumber(item.itemID)
            if not itemID then return end
            
            if not HousingDB then HousingDB = {} end
            if not HousingDB.wishlist then HousingDB.wishlist = {} end
            
            if HousingDB.wishlist[itemID] then
                HousingDB.wishlist[itemID] = nil
                self.icon:SetTexture("Interface\\Icons\\INV_ValentinesCandy")
                self.icon:SetDesaturated(true)
            else
                HousingDB.wishlist[itemID] = true
                self.icon:SetTexture("Interface\\Icons\\INV_ValentinesCandy")
                self.icon:SetDesaturated(false)
            end
            
            if HousingItemList and HousingItemList.RefreshCollectionStatus then
                HousingItemList:RefreshCollectionStatus()
            end

            local mats = _G.HousingMaterialsTrackerUI
            if mats and mats.RefreshSoon then
                mats:RefreshSoon()
            end
        end
    end)
    
    wishlistButton:SetScript("OnEnter", function(self)
        local item = previewFrame._currentItem
        if item and item.itemID then
            local itemID = tonumber(item.itemID)
            local isInWishlist = itemID and HousingDB and HousingDB.wishlist and HousingDB.wishlist[itemID]
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            if isInWishlist then
                GameTooltip:SetText("Remove from Wishlist", statusWarning[1], statusWarning[2], statusWarning[3])
            else
                GameTooltip:SetText("Add to Wishlist", accentPrimary[1], accentPrimary[2], accentPrimary[3])
            end
            GameTooltip:Show()
        end
    end)
    
    wishlistButton:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
end

function PreviewPanelUI:CreateMaterialsButton(previewFrame, header, yOffset)
    local btn = CreateFrame("Button", nil, header)
    btn:SetSize(28, 28)
    btn:SetPoint("RIGHT", previewFrame.wishlistButton, "LEFT", -5, 0)
    btn:SetFrameLevel(previewFrame:GetFrameLevel() + 5)

    btn.icon = btn:CreateTexture(nil, "ARTWORK")
    btn.icon:SetAllPoints(btn)
    btn.icon:SetTexture("Interface\\Icons\\INV_Misc_Bag_10")
    previewFrame.materialsBtn = btn

    btn:SetScript("OnClick", function(_, mouseButton)
        local ui = _G.HousingMaterialsTrackerUI
        if not (ui and (ui.ShowForItem or ui.ShowWishlist)) then
            print("|cFFFF4040HousingVendor:|r MaterialsTrackerUI module not available")
            return
        end

        if mouseButton == "RightButton" then
            if ui.ToggleWishlist then
                ui:ToggleWishlist()
            else
                ui:ShowWishlist()
            end
            return
        end

        local item = previewFrame._currentItem
        local itemID = item and tonumber(item.itemID)
        if itemID and ui.ToggleForItem then
            ui:ToggleForItem(itemID)
        elseif itemID and ui.ShowForItem then
            ui:ShowForItem(itemID)
        else
            if ui.ToggleWishlist then
                ui:ToggleWishlist()
            else
                ui:ShowWishlist()
            end
        end
    end)

    btn:SetScript("OnEnter", function(self)
        self.icon:SetVertexColor(1, 1, 0)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("Materials Tracker", 1, 1, 1)
        GameTooltip:AddLine("Left-click: current item reagents", 0.9, 0.9, 0.9)
        GameTooltip:AddLine("Right-click: wishlist totals", 0.9, 0.9, 0.9)
        GameTooltip:Show()
    end)

    btn:SetScript("OnLeave", function(self)
        self.icon:SetVertexColor(1, 1, 1)
        GameTooltip:Hide()
    end)

    -- Materials button should always be visible
    -- btn:Hide()  -- REMOVED: Keep button visible
end

function PreviewPanelUI:CreateAchievementButton(previewFrame)
    local bgTertiary = HousingTheme.Colors.bgTertiary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    local textPrimary = HousingTheme.Colors.textPrimary
    local accentPrimary = HousingTheme.Colors.accentPrimary
    local bgHover = HousingTheme.Colors.bgHover

    local achievementBtn = CreateFrame("Button", nil, previewFrame, "BackdropTemplate")
    achievementBtn:SetSize(140, 22)
    achievementBtn:SetPoint("BOTTOMRIGHT", previewFrame, "BOTTOMRIGHT", -10, 10)
    achievementBtn:SetFrameLevel(previewFrame:GetFrameLevel() + 5)
    achievementBtn:Hide()

    achievementBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    achievementBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.8)
    achievementBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.6)

    local achievementText = achievementBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    achievementText:SetPoint("CENTER")
    achievementText:SetText("Achievement")
    achievementText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    achievementBtn.text = achievementText

    -- Keep achievement info visible, but do not open Blizzard UI when clicked.
    achievementBtn:EnableMouse(false)

    achievementBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], 0.9)
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("Achievement", accentPrimary[1], accentPrimary[2], accentPrimary[3])
        GameTooltip:AddLine("Achievement information for this item", 1, 1, 1, true)
        GameTooltip:Show()
    end)

    achievementBtn:SetScript("OnLeave", function()
        achievementBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.8)
        achievementBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.6)
        GameTooltip:Hide()
    end)

    previewFrame.achievementTrackBtn = achievementBtn
end

function PreviewPanelUI:CreateIconAndName(previewFrame, header)
    local borderPrimary = HousingTheme.Colors.borderPrimary
    local textPrimary = HousingTheme.Colors.textPrimary
    local textMuted = HousingTheme.Colors.textMuted
    local textSecondary = HousingTheme.Colors.textSecondary
    
    local iconContainer = CreateFrame("Frame", nil, header)
    iconContainer:SetSize(44, 44)
    iconContainer:SetPoint("TOPLEFT", 10, -10)
    
    -- Border frame
    local borderFrame = CreateFrame("Frame", nil, iconContainer, "BackdropTemplate")
    borderFrame:SetAllPoints()
    local containerLevel = iconContainer.GetFrameLevel and iconContainer:GetFrameLevel() or 1
    borderFrame:SetFrameLevel(math.max(0, (containerLevel or 1) - 1))
    borderFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    borderFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.8)
    borderFrame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    previewFrame.iconBorder = borderFrame
    
    local icon = iconContainer:CreateTexture(nil, "ARTWORK")
    icon:SetSize(40, 40)
    icon:SetPoint("CENTER")
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    previewFrame.icon = icon
    
    local collectedCheck = iconContainer:CreateTexture(nil, "OVERLAY")
    collectedCheck:SetSize(24, 24)
    collectedCheck:SetPoint("CENTER")
    collectedCheck:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
    collectedCheck:Hide()
    previewFrame.collectedCheck = collectedCheck
    
    self:SetupIconTooltip(iconContainer, previewFrame)
    
    local name = header:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    name:SetPoint("LEFT", iconContainer, "RIGHT", 8, 10)
    name:SetPoint("RIGHT", -10, 0)
    name:SetJustifyH("LEFT")
    name:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    previewFrame.name = name

    local idText = header:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    idText:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -2)
    idText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    previewFrame.idText = idText
    
    -- Collection status (compact, single line)
    local collectionLbl = header:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    collectionLbl:SetPoint("TOPLEFT", idText, "BOTTOMLEFT", 0, -2)
    collectionLbl:SetText("Collection:")
    collectionLbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    
    local collectionVal = header:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    collectionVal:SetPoint("LEFT", collectionLbl, "RIGHT", 4, 0)
    collectionVal:SetJustifyH("LEFT")
    collectionVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    collectionVal.label = collectionLbl
    previewFrame.collectionValue = collectionVal
    
    local collectedLbl = header:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    collectedLbl:SetPoint("LEFT", collectionVal, "RIGHT", 8, 0)
    collectedLbl:SetText("Collected:")
    collectedLbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    
    local collectedVal = header:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    collectedVal:SetPoint("LEFT", collectedLbl, "RIGHT", 4, 0)
    collectedVal:SetJustifyH("LEFT")
    collectedVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    collectedVal.label = collectedLbl
    previewFrame.collectedValue = collectedVal
    
    -- Recipe status (for profession items)
    local recipeLbl = header:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    recipeLbl:SetPoint("LEFT", collectedVal, "RIGHT", 8, 0)
    recipeLbl:SetText("Recipe:")
    recipeLbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

    local recipeVal = header:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    recipeVal:SetPoint("LEFT", recipeLbl, "RIGHT", 4, 0)
    recipeVal:SetJustifyH("LEFT")
    recipeVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    recipeVal.label = recipeLbl
    recipeVal:Hide()
    recipeLbl:Hide()
    previewFrame.recipeValue = recipeVal
end

function PreviewPanelUI:SetupIconTooltip(iconContainer, previewFrame)
    iconContainer:EnableMouse(true)
    iconContainer:SetScript("OnEnter", function(self)
        local item = previewFrame._currentItem
        if item and item.itemID then
            local itemID = tonumber(item.itemID)
            local isCollected = false
            if itemID and HousingCollectionAPI then
                isCollected = HousingCollectionAPI:IsItemCollected(itemID)
            end
            local isInWishlist = itemID and HousingDB and HousingDB.wishlist and HousingDB.wishlist[itemID]
            local catalogData = item._catalogData or {}
            
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(item.name or "Unknown Item", 1, 1, 1)
            
            if isCollected then
                GameTooltip:AddLine("Collected", 0.2, 1, 0.2)
            else
                GameTooltip:AddLine("Not Collected", 0.7, 0.7, 0.7)
            end
            
            if isInWishlist then
                GameTooltip:AddLine("Favorited", 1, 0.9, 0.2)
            end
            
            if item._costBreakdown and #item._costBreakdown > 0 then
                GameTooltip:AddLine(" ")
                for _, costStr in ipairs(item._costBreakdown) do
                    GameTooltip:AddLine("Cost: " .. costStr, 1, 0.82, 0)
                end
            end
            
            if item.profession then
                GameTooltip:AddLine(" ")
                local profText = "Profession: " .. item.profession
                GameTooltip:AddLine(profText, 0.4, 0.78, 1)
                
                if item.professionSkillNeeded and item.professionSkillNeeded > 0 then
                    GameTooltip:AddLine("  Requires Level " .. item.professionSkillNeeded, 0.7, 0.7, 0.7)
                end
                
                if item.professionSpellID then
                    local spellInfo = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(item.professionSpellID)
                    if spellInfo and spellInfo.name then
                        GameTooltip:AddLine("  Recipe: " .. spellInfo.name, 0.9, 0.9, 0.8)
                    end
                end
            end
            
            local achievementText = item._apiAchievement or catalogData.achievement
            if achievementText and achievementText ~= "" then
                if string.find(achievementText, "|n|cFFFFD200") then
                    achievementText = string.match(achievementText, "^([^|]+)") or achievementText
                end
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("Achievement: " .. achievementText, 1, 0.82, 0)
            end

            -- Use shared CleanText from DataManager.Util (moved to Shared.lua to eliminate duplication)
            local DataManager = _G["HousingDataManager"]
            local CleanText = (DataManager and DataManager.Util and DataManager.Util.CleanText)
                or function(text)
                    if not text or text == "" then return "" end
                    return text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|[Hh]", ""):gsub("|T[^|]*|t", ""):gsub("|n", " "):match("^%s*(.-)%s*$") or text
                end

            if catalogData.quest and catalogData.quest ~= "" then
                if not achievementText then
                    GameTooltip:AddLine(" ")
                end
                
                local cleanQuestText = CleanText(catalogData.quest)
                if cleanQuestText ~= "" then
                    GameTooltip:AddLine("Quest: " .. cleanQuestText, 1, 0.82, 0)
                end
            end
            
            if catalogData.reputation and catalogData.reputation ~= "" then
                if not achievementText and not catalogData.quest then
                    GameTooltip:AddLine(" ")
                end
                local cleanRepText = CleanText(catalogData.reputation)
                if cleanRepText ~= "" then
                    GameTooltip:AddLine("Reputation: " .. cleanRepText, 1, 0.82, 0)
                end
            end
            
            if catalogData.renown and catalogData.renown ~= "" then
                if not achievementText and not catalogData.quest and not catalogData.reputation then
                    GameTooltip:AddLine(" ")
                end
                local cleanRenownText = CleanText(catalogData.renown)
                if cleanRenownText ~= "" then
                    GameTooltip:AddLine("Renown: " .. cleanRenownText, 1, 0.82, 0)
                end
            end
            
            if catalogData.event and catalogData.event ~= "" then
                GameTooltip:AddLine(" ")
                local cleanEventText = CleanText(catalogData.event)
                if cleanEventText ~= "" then
                    GameTooltip:AddLine("Event: " .. cleanEventText, 0.8, 0.4, 1)
                end
            end
            
            if catalogData.class and catalogData.class ~= "" then
                if not catalogData.event then
                    GameTooltip:AddLine(" ")
                end
                local cleanClassText = CleanText(catalogData.class)
                if cleanClassText ~= "" then
                    GameTooltip:AddLine("Class: " .. cleanClassText, 0.8, 0.4, 1)
                end
            end
            
            if catalogData.race and catalogData.race ~= "" then
                if not catalogData.event and not catalogData.class then
                    GameTooltip:AddLine(" ")
                end
                local cleanRaceText = CleanText(catalogData.race)
                if cleanRaceText ~= "" then
                    GameTooltip:AddLine("Race: " .. cleanRaceText, 0.8, 0.4, 1)
                end
            end
            
            GameTooltip:Show()
        end
    end)
    
    iconContainer:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
end



function PreviewPanelUI:CreateDetailsPanel(previewFrame)
    local details = CreateFrame("Frame", nil, previewFrame)
    details:SetPoint("TOP", previewFrame.header, "BOTTOM", 0, -4)
    details:SetPoint("LEFT", 8, 0)
    details:SetPoint("RIGHT", -8, 0)
    details:SetPoint("BOTTOM", 80, 0)
    details:Hide()  -- Hide details initially until an item is selected
    previewFrame.details = details
    
    -- Create placeholder/welcome screen with Housing Codex logo
    local placeholder = CreateFrame("Frame", nil, previewFrame)
    placeholder:SetPoint("TOP", previewFrame.header, "BOTTOM", 0, -4)
    placeholder:SetPoint("LEFT", 8, 0)
    placeholder:SetPoint("RIGHT", -8, 0)
    placeholder:SetPoint("BOTTOM", 80, 0)
    
    -- Housing Vendor logo
    local logo = placeholder:CreateTexture(nil, "ARTWORK")
    logo:SetSize(280, 280)  -- Larger size to fill more of the panel
    logo:SetPoint("CENTER", 0, 10)  -- Slightly lower to center better
    logo:SetTexture("Interface\\AddOns\\HousingVendor\\Data\\Media\\HousingVendor.tga")
    logo:SetTexCoord(0.05, 0.95, 0.05, 0.95)  -- Less cropping to show more of the image
    placeholder.logo = logo
    
    -- Welcome text
    local welcomeText = placeholder:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    welcomeText:SetPoint("TOP", logo, "BOTTOM", 0, -20)
    welcomeText:SetText("Housing Vendor")
    local accentPrimary = HousingTheme.Colors.accentPrimary
    welcomeText:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    placeholder.welcomeText = welcomeText

    -- Data version text
    local dataVersionText = placeholder:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    dataVersionText:SetPoint("TOP", welcomeText, "BOTTOM", 0, -4)
    dataVersionText:SetText(DATA_VERSION_LABEL)
    local textMuted = HousingTheme.Colors.textMuted
    dataVersionText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    placeholder.dataVersionText = dataVersionText
    
    -- Subtitle text
    local subtitleText = placeholder:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    subtitleText:SetPoint("TOP", dataVersionText, "BOTTOM", 0, -6)
  
    local textSecondary = HousingTheme.Colors.textSecondary
    subtitleText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    placeholder.subtitleText = subtitleText
    
    previewFrame.placeholder = placeholder
    placeholder:Show()
    
    self:CreateDetailFields(previewFrame, details)
end

function PreviewPanelUI:CreateDetailFields(previewFrame, details)
    local y = -2
    local textSecondary = HousingTheme.Colors.textSecondary
    local textPrimary = HousingTheme.Colors.textPrimary
    local accentPrimary = HousingTheme.Colors.accentPrimary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    
    local function Header(text)
        local f = details:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        f:SetPoint("TOPLEFT", 5, y)
        f:SetText(text)
        f:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
        y = y - 18

        local divider = details:CreateTexture(nil, "ARTWORK")
        divider:SetPoint("TOPLEFT", 5, y + 2)
        divider:SetPoint("TOPRIGHT", -5, y + 2)
        divider:SetHeight(1)
        divider:SetTexture("Interface\\Buttons\\WHITE8x8")
        divider:SetVertexColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.4)
        y = y - 2

        f.divider = divider

        return f
    end

    local function Line(label)
        local lbl = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("TOPLEFT", 10, y)
        lbl:SetText(label)
        lbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        local val = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        val:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        val:SetPoint("RIGHT", -10, 0)
        val:SetJustifyH("LEFT")
        val:SetWordWrap(true)
        val:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

        val.label = lbl

        val:SetScript("OnEnter", function(self)
            if self.tooltipText then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
                GameTooltip:Show()
            end
        end)
        val:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        y = y - 16
        return val
    end

    -- Stacked field: label on first line, value directly underneath (prevents wide values from colliding with right-column UI).
    local function LineStacked(label)
        local lbl = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("TOPLEFT", 10, y)
        lbl:SetText(label)
        lbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        local val = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        val:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 0, -2)
        val:SetWidth(240)
        val:SetJustifyH("LEFT")
        val:SetWordWrap(true)
        val:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

        val.label = lbl
        val._hvAnchorToSelf = true

        val:SetScript("OnEnter", function(self)
            if self.tooltipText then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
                GameTooltip:Show()
            end
        end)
        val:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        y = y - 32
        return val
    end

    local function LineWithTooltip(label)
        local lbl = details:CreateFontString(nil,"OVERLAY","GameFontNormal")
        lbl:SetPoint("TOPLEFT",10,y)
        lbl:SetText(label)
        lbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        local val = details:CreateFontString(nil,"OVERLAY","GameFontNormal")
        val:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        val:SetPoint("RIGHT", -10, 0)
        val:SetJustifyH("LEFT")
        val:SetWordWrap(true)
        val:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

        val.label = lbl

        y = y - 20
        return val
    end
    
    local function InlineVendorCost(vendorLabel)
        local lbl = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("TOPLEFT", 10, y)
        lbl:SetText(vendorLabel)
        lbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        local vendorVal = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        vendorVal:SetPoint("TOPRIGHT", -10, y)
        vendorVal:SetJustifyH("RIGHT")
        vendorVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        vendorVal.label = lbl

        local costLbl = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        costLbl:SetPoint("TOPLEFT", 10, y - 16)
        costLbl:SetText("Cost:")
        costLbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        local costVal = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        costVal:SetPoint("TOPRIGHT", -10, y - 16)
        costVal:SetJustifyH("RIGHT")
        costVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        costVal.label = costLbl

        y = y - 32
        return vendorVal, costVal
    end
    
    local function InlineReputation(label)
        local lbl = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("TOPLEFT", 10, y)
        lbl:SetText(label)
        lbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        local val = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        val:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        val:SetPoint("RIGHT", -10, 0)
        val:SetJustifyH("LEFT")
        val:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        val.label = lbl

        y = y - 16
        return val
    end

    local function SetFieldValue(field, value, label)
        if not field then return end
        if value and value ~= "N/A" and value ~= "" then
            field:SetText(value)
            field:Show()
            if label then label:Show() end
        else
            field:Hide()
            if label then label:Hide() end
        end
    end
    previewFrame.SetFieldValue = SetFieldValue

    local function UpdateHeaderVisibility(header, fields)
        if not header then return end
        local hasVisibleField = false
        for _, field in ipairs(fields) do
            if field and field:IsShown() then
                hasVisibleField = true
                break
            end
        end
        if hasVisibleField then
            header:Show()
            if header.divider then header.divider:Show() end
        else
            header:Hide()
            if header.divider then header.divider:Hide() end
        end
    end
    previewFrame.UpdateHeaderVisibility = UpdateHeaderVisibility

    previewFrame.vendorHeader = Header("Vendor")
    previewFrame.vendorValue, previewFrame.costValue = InlineVendorCost("Vendor:")
    previewFrame.ahPriceValue = LineStacked(L["BUY_ON_AH_CURRENT_PRICE"] or "Buy on AH:")
    previewFrame.factionValue = Line("Faction:")
    previewFrame.expansionValue = Line("Expansion:")
    previewFrame.zoneValue = Line("Zone:")
    previewFrame.professionHeader = Header("Profession")
    previewFrame.reputationValue = InlineReputation("Reputation:")

    -- Create reputation progress bar (hidden by default)
    local repBar = CreateFrame("StatusBar", nil, details)
    repBar:SetPoint("TOPLEFT", 10, y)
    repBar:SetSize(295, 12)
    repBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    repBar:SetStatusBarColor(0.2, 0.6, 1, 1)
    repBar:SetMinMaxValues(0, 1)
    repBar:SetValue(0)
    repBar:Hide()

    -- Background for progress bar
    local repBarBg = repBar:CreateTexture(nil, "BACKGROUND")
    repBarBg:SetAllPoints(repBar)
    repBarBg:SetColorTexture(0.1, 0.1, 0.1, 0.5)

    -- Text overlay on progress bar
    local repBarText = repBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    repBarText:SetPoint("CENTER", repBar, "CENTER", 0, 0)
    repBarText:SetTextColor(1, 1, 1, 1)
    repBar.text = repBarText

    previewFrame.reputationBar = repBar
    y = y - 16

    previewFrame.renownValue = Line("Renown:")
    -- Keep the Profession divider on the left column so it doesn't cut through the reagents list.
    if previewFrame.professionHeader and previewFrame.professionHeader.divider then
        previewFrame.professionHeader.divider:ClearAllPoints()
        previewFrame.professionHeader.divider:SetPoint("TOPLEFT", previewFrame.professionHeader, "BOTTOMLEFT", 0, -2)
        previewFrame.professionHeader.divider:SetPoint("TOPRIGHT", previewFrame.professionHeader, "BOTTOMLEFT", 240, -2)
    end
    previewFrame.professionValue = Line("Profession:")
    previewFrame.professionSkillValue = Line("Skill:")
    previewFrame.professionRecipeValue = Line("Recipe:")
    previewFrame.reagentsContainer = nil

    previewFrame.requirementsHeader = Header("Requirements")
    local requirementsY = y
    previewFrame.questValue = LineWithTooltip("Quest:")
    previewFrame.questGiverValue = LineWithTooltip("Quest Giver:")
    y = requirementsY
    previewFrame.achievementValue = LineWithTooltip("Achievement:")

    -- Create achievement progress bar (hidden by default)
    local achBar = CreateFrame("StatusBar", nil, details)
    achBar:SetPoint("TOPLEFT", 10, y)
    achBar:SetSize(295, 12)
    achBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    achBar:SetStatusBarColor(1.0, 0.5, 0.0, 1)  -- Orange by default
    achBar:SetMinMaxValues(0, 1)
    achBar:SetValue(0)
    achBar:Hide()

    -- Background for achievement progress bar
    local achBarBg = achBar:CreateTexture(nil, "BACKGROUND")
    achBarBg:SetAllPoints(achBar)
    achBarBg:SetColorTexture(0.1, 0.1, 0.1, 0.5)

    -- Text overlay on achievement progress bar
    local achBarText = achBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    achBarText:SetPoint("CENTER", achBar, "CENTER", 0, 0)
    achBarText:SetTextColor(1, 1, 1, 1)
    achBar.text = achBarText

    previewFrame.achievementBar = achBar
    y = y - 16

    previewFrame.eventValue = Line("Event:")
    previewFrame.classValue = Line("Class:")
    previewFrame.raceValue = Line("Race:")
    previewFrame.rewardTypeValue = Line("Reward Type:")
    previewFrame.sourceDetailsValue = Line("Details:")

    previewFrame.weightValue = nil
    previewFrame.houseIconValue = nil
    previewFrame.typeValue = nil
    previewFrame.apiRecordValue = nil
    previewFrame.apiAssetValue = nil
    previewFrame.apiSourceValue = nil

    function previewFrame:RelayoutProfessionAndRequirements()
        if not (self.details and self.professionHeader and self.requirementsHeader) then
            return
        end

        local function IsShown(f)
            return f and f.IsShown and f:IsShown()
        end

        local function LastShown(...)
            for i = 1, select("#", ...) do
                local f = select(i, ...)
                if IsShown(f) then
                    return f
                end
            end
            return nil
        end

        local vendorTail = LastShown(
            self.zoneValue,
            self.expansionValue,
            self.factionValue,
            self.ahPriceValue,
            self.costValue,
            self.vendorValue,
            self.renownValue,
            self.reputationBar,
            self.reputationValue
        )
        if not vendorTail then
            return
        end

        local vendorAnchor = vendorTail
        if vendorTail.label and IsShown(vendorTail.label) and not vendorTail._hvAnchorToSelf then
            vendorAnchor = vendorTail.label
        end

        if IsShown(self.professionHeader) then
            self.professionHeader:ClearAllPoints()
            self.professionHeader:SetPoint("TOPLEFT", vendorAnchor, "BOTTOMLEFT", -5, -12)
            if self.professionHeader.divider then
                self.professionHeader.divider:ClearAllPoints()
                self.professionHeader.divider:SetPoint("TOPLEFT", self.professionHeader, "BOTTOMLEFT", 0, -2)
                self.professionHeader.divider:SetPoint("TOPRIGHT", self.professionHeader, "BOTTOMLEFT", 240, -2)
            end

            local lineAnchor = self.professionHeader.divider or self.professionHeader
            local first = true

            local function PlaceLine(field, extraGap)
                if not (field and field.label and IsShown(field)) then
                    return false
                end

                local yOffset = first and (-10 - (extraGap or 0)) or (-16 - (extraGap or 0))
                first = false

                field.label:ClearAllPoints()
                field:ClearAllPoints()
                field.label:SetPoint("TOPLEFT", lineAnchor, "BOTTOMLEFT", 5, yOffset)
                field:SetPoint("LEFT", field.label, "RIGHT", 8, 0)
                field:SetPoint("RIGHT", self.details, "RIGHT", -10, 0)
                lineAnchor = field.label
                return true
            end

            PlaceLine(self.professionValue, 0)
            PlaceLine(self.professionSkillValue, 0)
            PlaceLine(self.professionRecipeValue, 0)

            -- Position reagents BELOW profession info, not at top
            if self.reagentsContainer and self.reagentsContainer.IsShown and self.reagentsContainer:IsShown() then
                -- Use lineAnchor which points to the last profession field placed
                if lineAnchor then
                    self.reagentsContainer:ClearAllPoints()
                    -- Position below the last profession line with spacing
                    self.reagentsContainer:SetPoint("TOPLEFT", lineAnchor, "BOTTOMLEFT", 0, -20)
                    self.reagentsContainer:SetPoint("RIGHT", self.details, "RIGHT", 0, 0)
                end
            end
        end

        local professionTail = LastShown(self.professionRecipeValue, self.professionSkillValue, self.professionValue, self.professionHeader)
        local professionAnchor = (professionTail and professionTail.label and IsShown(professionTail.label)) and professionTail.label or professionTail

        -- If reagents container is visible, use it as anchor for Requirements header
        -- Calculate the height of the reagents section based on number of reagent lines
        local requirementsBaseAnchor = professionAnchor or vendorAnchor
        local requirementsYOffset = -12

        if self.reagentsContainer and IsShown(self.reagentsContainer) then
            -- Count visible reagent lines to calculate proper offset
            local numReagents = 0
            if self.reagentsContainer.lines then
                for i, line in ipairs(self.reagentsContainer.lines) do
                    if line and line:IsShown() then
                        numReagents = numReagents + 1
                    end
                end
            end
            -- Each reagent line is ~22px, plus header ~18px, plus spacing
            local reagentsHeight = 18 + (numReagents * 22) + 10
            requirementsYOffset = -12 - reagentsHeight
        end

        if IsShown(self.requirementsHeader) and requirementsBaseAnchor then
            self.requirementsHeader:ClearAllPoints()
            self.requirementsHeader:SetPoint("TOPLEFT", requirementsBaseAnchor, "BOTTOMLEFT", -5, requirementsYOffset)
            if self.requirementsHeader.divider then
                local headerBottom = self.requirementsHeader:GetBottom()
                local detailsTop = self.details:GetTop()
                local dividerY = headerBottom - 2 - detailsTop
                self.requirementsHeader.divider:ClearAllPoints()
                self.requirementsHeader.divider:SetPoint("TOPLEFT", self.details, "TOPLEFT", 5, dividerY)
                self.requirementsHeader.divider:SetPoint("TOPRIGHT", self.details, "TOPRIGHT", -5, dividerY)
            end

            local reqAnchor = self.requirementsHeader.divider or self.requirementsHeader
            local reqFirst = true

            local function PlaceReq(field)
                if not (field and field.label and IsShown(field)) then
                    return false
                end

                local yOffset = reqFirst and -10 or -20
                reqFirst = false

                field.label:ClearAllPoints()
                field:ClearAllPoints()
                field.label:SetPoint("TOPLEFT", reqAnchor, "BOTTOMLEFT", 5, yOffset)
                field:SetPoint("LEFT", field.label, "RIGHT", 8, 0)
                field:SetPoint("RIGHT", self.details, "RIGHT", -10, 0)
                reqAnchor = field.label
                return true
            end

            PlaceReq(self.questValue)
            PlaceReq(self.questGiverValue)
            PlaceReq(self.achievementValue)

            if self.achievementBar and self.achievementBar.IsShown and self.achievementBar:IsShown() then
                local yOffset = reqFirst and -10 or -16
                self.achievementBar:ClearAllPoints()
                self.achievementBar:SetPoint("TOPLEFT", reqAnchor, "BOTTOMLEFT", 5, yOffset)
                reqAnchor = self.achievementBar
                reqFirst = false
            end

            -- Keep additional requirement-related lines tucked directly under the Requirements header.
            PlaceReq(self.rewardTypeValue)
            PlaceReq(self.sourceDetailsValue)
            PlaceReq(self.eventValue)
            PlaceReq(self.classValue)
            PlaceReq(self.raceValue)
        end
    end

end

function PreviewPanelUI:CreateMapButton(previewFrame, header, yOffset)
    local mapBtn = CreateFrame("Button", nil, header)
    mapBtn:SetSize(28, 28)
    mapBtn:SetPoint("RIGHT", previewFrame.materialsBtn, "LEFT", -5, 0)
    mapBtn:SetFrameLevel(previewFrame:GetFrameLevel() + 5)

    mapBtn.icon = mapBtn:CreateTexture(nil,"ARTWORK")
    mapBtn.icon:SetAllPoints(mapBtn)
    mapBtn.icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    previewFrame.mapBtn = mapBtn

    mapBtn:SetScript("OnClick", function()
        local info = previewFrame._waypointInfo or previewFrame._vendorInfo or previewFrame._trainerInfo
        if info and HousingWaypointManager then
            -- If vendor marker is enabled, let it handle setting the waypoint so we don't double-print routes.
            if HousingDB and HousingDB.settings and HousingDB.settings.enableVendorMarker then
                -- Only show markers for actual vendors (not profession trainers).
                if info == previewFrame._vendorInfo and HousingVendorMarker and previewFrame._vendorInfo and previewFrame._vendorInfo.npcID then
                    local vendorName = previewFrame._vendorInfo.vendorName or previewFrame._vendorInfo.name or "Vendor"
                    local npcID = previewFrame._vendorInfo.npcID

                    -- Only show if NPC ID is valid (not "None" or empty)
                    if npcID and npcID ~= "None" and npcID ~= "" and tonumber(npcID) then
                        local coords = {
                            x = previewFrame._vendorInfo.coords and previewFrame._vendorInfo.coords.x or previewFrame._vendorInfo.x,
                            y = previewFrame._vendorInfo.coords and previewFrame._vendorInfo.coords.y or previewFrame._vendorInfo.y,
                            mapID = (previewFrame._vendorInfo.coords and previewFrame._vendorInfo.coords.mapID) or previewFrame._vendorInfo.mapID
                        }
                        HousingVendorMarker:ShowForVendor(vendorName, npcID, coords)
                        return
                    end
                end
            end

            HousingWaypointManager:SetWaypoint(info)
        else
            print("|cFFE63946HousingVendor:|r No coordinate data available for this item.")
        end
    end)

    mapBtn:SetScript("OnEnter", function(btn)
        btn.icon:SetVertexColor(1,1,0)
        GameTooltip:SetOwner(btn,"ANCHOR_LEFT")
        if previewFrame._waypointContext == "trainer" then
            GameTooltip:SetText("Set Waypoint (Trainer)")
        elseif previewFrame._waypointContext == "questNPC" then
            GameTooltip:SetText("Set Waypoint (Quest Giver)")
        else
            GameTooltip:SetText("Set Waypoint")
        end
        GameTooltip:Show()
    end)

    mapBtn:SetScript("OnLeave", function(btn)
        btn.icon:SetVertexColor(1,1,1)
        GameTooltip:Hide()
    end)
end

function PreviewPanelUI:Create3DModelButton(previewFrame, header, yOffset)
    local modelBtn = CreateFrame("Button", nil, header)
    modelBtn:SetSize(28, 28)
    modelBtn:SetPoint("RIGHT", previewFrame.mapBtn, "LEFT", -5, 0)
    modelBtn:SetFrameLevel(previewFrame:GetFrameLevel() + 5)

    modelBtn.icon = modelBtn:CreateTexture(nil, "ARTWORK")
    modelBtn.icon:SetAllPoints(modelBtn)
    modelBtn.icon:SetTexture("Interface\\AddOns\\HousingVendor\\Data\\Media\\HousingCodex_3DModel.tga")
    previewFrame.modelBtn = modelBtn

    modelBtn:SetScript("OnClick", function()
        local item = previewFrame._currentItem
        if not item or not item.itemID then return end
        
        -- Get catalog data (which contains the model info)
        local catalogData = item._catalogData
        if not catalogData then
            -- Try to get it from the preview panel
            if HousingVendor and HousingVendor.PreviewPanelData and HousingVendor.PreviewPanelData.GetCatalogData then
                catalogData = HousingVendor.PreviewPanelData:GetCatalogData(item.itemID)
            end
        end
        
        if not catalogData or not catalogData.asset or catalogData.asset == 0 then
            -- Check HousingDB.iconCache as fallback
            local modelID = nil
            if HousingDB and HousingDB.iconCache and HousingDB.iconCache[item.itemID] then
                modelID = HousingDB.iconCache[item.itemID]
            end
            
            if modelID and modelID ~= 0 then
                -- Create minimal catalog data with the model ID
                catalogData = { asset = modelID }
            else
                print("|cFFFF4040HousingVendor:|r No 3D model found for this item.")
                return
            end
        end
        
        -- Show the 3D model viewer
        if HousingModelViewer and HousingModelViewer.ShowModel then
            HousingModelViewer:ShowModel(catalogData, item.name or "Unknown", item.itemID)
        else
            print("|cFFFF4040HousingVendor:|r 3D Model Viewer not available.")
        end
    end)

    modelBtn:SetScript("OnEnter", function(btn)
        btn.icon:SetVertexColor(1, 1, 0)
        GameTooltip:SetOwner(btn, "ANCHOR_LEFT")
        GameTooltip:SetText("View 3D Model")
        GameTooltip:AddLine("Opens a window to view this item in 3D.", 0.85, 0.85, 0.85, true)
        GameTooltip:Show()
    end)

    modelBtn:SetScript("OnLeave", function(btn)
        btn.icon:SetVertexColor(1, 1, 1)
        GameTooltip:Hide()
    end)
end

HousingVendor.PreviewPanelUI = PreviewPanelUI
