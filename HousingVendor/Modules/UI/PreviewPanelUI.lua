------------------------------------------------------------
-- PREVIEW PANEL UI - UI Creation Module
------------------------------------------------------------

local AddonName, HousingVendor = ...
local L = _G["HousingVendorL"] or {}

local PreviewPanelUI = {}
PreviewPanelUI.__index = PreviewPanelUI

local function GetTheme()
    return HousingTheme or {}
end

function PreviewPanelUI:CreateUI(parent, previewFrame)
    local theme = GetTheme()
    local colors = theme.Colors or {}
    
    previewFrame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -10, -190)
    previewFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 40)
    previewFrame:SetWidth(460)
    
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
    previewFrame:Hide()

    self:CreateHeader(previewFrame)
    self:CreateModelViewer(previewFrame)
    self:CreateDetailsPanel(previewFrame)
    self:CreateMapButton(previewFrame)
end

function PreviewPanelUI:CreateHeader(previewFrame)
    local header = CreateFrame("Frame", nil, previewFrame, "BackdropTemplate")
    header:SetPoint("TOPLEFT", 0, 0)
    header:SetPoint("TOPRIGHT", 0, 0)
    header:SetHeight(70)
    
    local headerBg = header:CreateTexture(nil, "BACKGROUND")
    headerBg:SetAllPoints()
    headerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    headerBg:SetGradient("VERTICAL", 
        CreateColor(0.15, 0.10, 0.22, 0.8), 
        CreateColor(0.10, 0.07, 0.15, 0.6))
    
    previewFrame.header = header

    self:CreateWishlistButton(previewFrame, header)
    self:CreateIconAndName(previewFrame, header)
    self:CreateCollectionStatus(previewFrame, header)
end

function PreviewPanelUI:CreateWishlistButton(previewFrame, header)
    local wishlistButton = CreateFrame("Button", nil, previewFrame)
    wishlistButton:SetSize(36, 36)
    wishlistButton:SetPoint("TOPRIGHT", previewFrame, "TOPRIGHT", -10, -10)
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
    
    local iconContainer = CreateFrame("Frame", nil, header)
    iconContainer:SetSize(56, 56)
    iconContainer:SetPoint("LEFT", 12, 0)
    
    -- Border frame (avoid filling the entire background with the quality color)
    local borderFrame = CreateFrame("Frame", nil, iconContainer, "BackdropTemplate")
    borderFrame:SetAllPoints()
    -- Keep border behind the icon texture (avoid dark overlay).
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
    icon:SetSize(52, 52)
    icon:SetPoint("CENTER")
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    previewFrame.icon = icon
    
    local collectedCheck = iconContainer:CreateTexture(nil, "OVERLAY")
    collectedCheck:SetSize(32, 32)
    collectedCheck:SetPoint("CENTER")
    collectedCheck:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
    collectedCheck:Hide()
    previewFrame.collectedCheck = collectedCheck
    
    self:SetupIconTooltip(iconContainer, previewFrame)
    
    local name = header:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    name:SetPoint("LEFT", iconContainer, "RIGHT", 12, 8)
    name:SetPoint("RIGHT", -45, 0)
    name:SetJustifyH("LEFT")
    name:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    previewFrame.name = name

    local idText = header:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    idText:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -2)
    idText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    previewFrame.idText = idText
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

function PreviewPanelUI:CreateCollectionStatus(previewFrame, header)
    local textSecondary = HousingTheme.Colors.textSecondary
    local textPrimary = HousingTheme.Colors.textPrimary
    
    local collectionLbl = header:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    collectionLbl:SetPoint("TOPLEFT", previewFrame.idText, "BOTTOMLEFT", 0, -4)
    collectionLbl:SetText("Collection:")
    collectionLbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    
    local collectionVal = header:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    collectionVal:SetPoint("LEFT", collectionLbl, "RIGHT", 6, 0)
    collectionVal:SetWidth(60)
    collectionVal:SetJustifyH("LEFT")
    collectionVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    collectionVal.label = collectionLbl
    previewFrame.collectionValue = collectionVal
    
    local collectedLbl = header:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    collectedLbl:SetPoint("LEFT", collectionVal, "RIGHT", 15, 0)
    collectedLbl:SetText("Collected:")
    collectedLbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    
    local collectedVal = header:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    collectedVal:SetPoint("LEFT", collectedLbl, "RIGHT", 6, 0)
    collectedVal:SetJustifyH("LEFT")
    collectedVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    collectedVal.label = collectedLbl
    previewFrame.collectedValue = collectedVal
end

function PreviewPanelUI:CreateModelViewer(previewFrame)
    local borderPrimary = HousingTheme.Colors.borderPrimary
    local bgTertiary = HousingTheme.Colors.bgTertiary
    
    local modelContainer = CreateFrame("Frame", nil, previewFrame, "BackdropTemplate")
    modelContainer:SetPoint("TOP", previewFrame.header, "BOTTOM", 0, -8)
    modelContainer:SetPoint("LEFT", 8, 0)
    modelContainer:SetPoint("RIGHT", -8, 0)
    modelContainer:SetHeight(150)

    modelContainer:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    modelContainer:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.5)
    modelContainer:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.4)

    local toggleModelButton = self:CreateToggleButton(modelContainer)
    local modelFrame = self:CreateModelFrame(modelContainer)
    local controlsFrame = self:CreateModelControls(modelContainer, modelFrame)
    self:EnableModelMouseControls(modelFrame)
    
    previewFrame.modelFrame = modelFrame
    previewFrame.modelContainer = modelContainer
    previewFrame.toggleModelButton = toggleModelButton
    previewFrame.modelControls = controlsFrame
    -- Default 3D model to visible (restores prior behavior).
    previewFrame.modelVisible = true
    modelContainer:SetHeight(150)
    modelFrame:Show()
    controlsFrame:Show()
    if toggleModelButton and toggleModelButton.text then
        toggleModelButton.text:SetText("Hide 3D")
    end
end

function PreviewPanelUI:CreateToggleButton(modelContainer)
    local bgTertiary = HousingTheme.Colors.bgTertiary
    local borderPrimary = HousingTheme.Colors.borderPrimary
    local textPrimary = HousingTheme.Colors.textPrimary
    local accentPrimary = HousingTheme.Colors.accentPrimary
    local bgHover = HousingTheme.Colors.bgHover
    
    local toggleModelButton = CreateFrame("Button", nil, modelContainer, "BackdropTemplate")
    toggleModelButton:SetSize(80, 20)
    toggleModelButton:SetPoint("TOPRIGHT", -5, -5)
    toggleModelButton:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    toggleModelButton:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.8)
    toggleModelButton:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.6)

    local toggleText = toggleModelButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    toggleText:SetPoint("CENTER")
    toggleText:SetText("Hide 3D")
    toggleText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    toggleModelButton.text = toggleText

    toggleModelButton:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], 0.9)
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    toggleModelButton:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.8)
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.6)
    end)
    
    return toggleModelButton
end

function PreviewPanelUI:CreateModelFrame(modelContainer)
    local modelFrame = CreateFrame("PlayerModel", nil, modelContainer)
    modelFrame:SetPoint("TOPLEFT", 2, -2)
    modelFrame:SetPoint("BOTTOMRIGHT", -2, 2)
    modelFrame:SetAlpha(1.0)

    modelFrame._hvRotation = 0
    modelFrame._hvCameraDistance = 22.5
    modelFrame._hvCameraMin = 1
    modelFrame._hvCameraMax = 30
    modelFrame._hvPosX = 0
    modelFrame._hvPosY = 0
    modelFrame._hvPosZ = 0
    modelFrame._hvCamX = 0
    modelFrame._hvCamY = 0
    modelFrame._hvCamZ = 4

    function modelFrame:HV_Clamp(value, min, max)
        if value < min then return min end
        if value > max then return max end
        return value
    end

    function modelFrame:HV_ApplyView()
        if self.SetFacing then
            self:SetFacing(self._hvRotation or 0)
        end
        if self.SetPosition then
            self:SetPosition(self._hvPosX or 0, self._hvPosY or 0, self._hvPosZ or 0)
        end
        if self.SetCameraPosition then
            self:SetCameraPosition(self._hvCamX or 0, self._hvCamY or 0, self._hvCamZ or 4)
        end
        if self.SetCameraDistance then
            self:SetCameraDistance(self._hvCameraDistance or 22.5)
        end
    end

    function modelFrame:HV_ResetView()
        self._hvRotation = 0
        self._hvCameraDistance = 22.5
        self._hvPosX, self._hvPosY, self._hvPosZ = 0, 0, 0
        self._hvCamX, self._hvCamY, self._hvCamZ = 0, 0, 4
        self:HV_ApplyView()
    end

    modelFrame:SetScript("OnModelLoaded", function(self)
        if self.MakeCurrentCameraCustom then
            self:MakeCurrentCameraCustom()
        end
        self:HV_ResetView()
    end)

    return modelFrame
end

function PreviewPanelUI:CreateModelControls(modelContainer, modelFrame)
    local controlsFrame = CreateFrame("Frame", nil, modelContainer)
    controlsFrame:SetPoint("BOTTOM", modelContainer, "BOTTOM", 0, 4)
    controlsFrame:SetSize(90, 18)
    controlsFrame:SetFrameLevel(modelContainer:GetFrameLevel() + 5)
    
    modelFrame._hvRotation = modelFrame._hvRotation or 0
    modelFrame._hvCameraDistance = modelFrame._hvCameraDistance or 22.5
    
    local rotateLeftBtn = CreateFrame("Button", nil, controlsFrame)
    rotateLeftBtn:SetSize(18, 18)
    rotateLeftBtn:SetPoint("LEFT", controlsFrame, "LEFT", 0, 0)
    rotateLeftBtn:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
    rotateLeftBtn:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
    rotateLeftBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    rotateLeftBtn:SetScript("OnClick", function()
        modelFrame._hvRotation = (modelFrame._hvRotation or 0) - 0.3
        modelFrame:HV_ApplyView()
    end)
    rotateLeftBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Rotate Left", 1, 1, 1)
        GameTooltip:Show()
    end)
    rotateLeftBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    local rotateRightBtn = CreateFrame("Button", nil, controlsFrame)
    rotateRightBtn:SetSize(18, 18)
    rotateRightBtn:SetPoint("LEFT", rotateLeftBtn, "RIGHT", 0, 0)
    rotateRightBtn:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
    rotateRightBtn:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
    rotateRightBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    rotateRightBtn:SetScript("OnClick", function()
        modelFrame._hvRotation = (modelFrame._hvRotation or 0) + 0.3
        modelFrame:HV_ApplyView()
    end)
    rotateRightBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Rotate Right", 1, 1, 1)
        GameTooltip:Show()
    end)
    rotateRightBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    local resetViewBtn = CreateFrame("Button", nil, controlsFrame)
    resetViewBtn:SetSize(18, 18)
    resetViewBtn:SetPoint("LEFT", rotateRightBtn, "RIGHT", 0, 0)
    resetViewBtn:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton")
    resetViewBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    resetViewBtn:SetScript("OnClick", function()
        if modelFrame.HV_ResetView then
            modelFrame:HV_ResetView()
        end
    end)
    resetViewBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Reset View", 1, 1, 1)
        GameTooltip:Show()
    end)
    resetViewBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    local zoomInBtn = CreateFrame("Button", nil, controlsFrame)
    zoomInBtn:SetSize(18, 18)
    zoomInBtn:SetPoint("LEFT", resetViewBtn, "RIGHT", 0, 0)
    zoomInBtn:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
    zoomInBtn:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
    zoomInBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    zoomInBtn:SetScript("OnClick", function()
        local nextDistance = (modelFrame._hvCameraDistance or 22.5) - 2
        modelFrame._hvCameraDistance = modelFrame:HV_Clamp(nextDistance, modelFrame._hvCameraMin or 1, modelFrame._hvCameraMax or 30)
        modelFrame:HV_ApplyView()
    end)
    zoomInBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Zoom In", 1, 1, 1)
        GameTooltip:Show()
    end)
    zoomInBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    local zoomOutBtn = CreateFrame("Button", nil, controlsFrame)
    zoomOutBtn:SetSize(18, 18)
    zoomOutBtn:SetPoint("LEFT", zoomInBtn, "RIGHT", 0, 0)
    zoomOutBtn:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
    zoomOutBtn:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
    zoomOutBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    zoomOutBtn:SetScript("OnClick", function()
        local nextDistance = (modelFrame._hvCameraDistance or 22.5) + 2
        modelFrame._hvCameraDistance = modelFrame:HV_Clamp(nextDistance, modelFrame._hvCameraMin or 1, modelFrame._hvCameraMax or 30)
        modelFrame:HV_ApplyView()
    end)
    zoomOutBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Zoom Out", 1, 1, 1)
        GameTooltip:Show()
    end)
    zoomOutBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    return controlsFrame
end

function PreviewPanelUI:EnableModelMouseControls(modelFrame)
    if not modelFrame then return end

    modelFrame:EnableMouse(true)
    modelFrame:EnableMouseWheel(true)

    local isRotating = false
    local isPanning = false
    local lastX, lastY = nil, nil

    local function GetCursorXY()
        local x, y = GetCursorPosition()
        local scale = UIParent and UIParent.GetEffectiveScale and UIParent:GetEffectiveScale() or 1
        return x / scale, y / scale
    end

    modelFrame:SetScript("OnMouseWheel", function(self, delta)
        if not self.SetCameraDistance or not self.HV_Clamp then return end
        local step = 1.5
        local nextDistance = (self._hvCameraDistance or 22.5) - (delta * step)
        self._hvCameraDistance = self:HV_Clamp(nextDistance, self._hvCameraMin or 1, self._hvCameraMax or 30)
        self:HV_ApplyView()
    end)

    modelFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            isRotating = true
        elseif button == "RightButton" then
            if IsShiftKeyDown and IsShiftKeyDown() then
                isRotating = true
            else
                isPanning = true
            end
        elseif button == "MiddleButton" then
            if self.HV_ResetView then
                self:HV_ResetView()
            end
            return
        else
            return
        end

        lastX, lastY = GetCursorXY()
        self:SetScript("OnUpdate", function(frame)
            local x, y = GetCursorXY()
            if not lastX or not lastY then
                lastX, lastY = x, y
                return
            end

            local dx = x - lastX
            local dy = y - lastY
            lastX, lastY = x, y

            if isRotating then
                frame._hvRotation = (frame._hvRotation or 0) - (dx * 0.01)
                frame:HV_ApplyView()
            elseif isPanning then
                frame._hvPosX = (frame._hvPosX or 0) + (dx * 0.0006)
                frame._hvPosZ = (frame._hvPosZ or 0) - (dy * 0.0006)
                frame:HV_ApplyView()
            end
        end)
    end)

    modelFrame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then
            isRotating = false
        elseif button == "RightButton" then
            isRotating = false
            isPanning = false
        end

        if not isRotating and not isPanning then
            self:SetScript("OnUpdate", nil)
            lastX, lastY = nil, nil
        end
    end)

    modelFrame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("3D Controls", 1, 1, 1)
        GameTooltip:AddLine("Mouse Wheel: Zoom", 0.9, 0.9, 0.9, true)
        GameTooltip:AddLine("Left Drag: Rotate", 0.9, 0.9, 0.9, true)
        GameTooltip:AddLine("Right Drag: Pan", 0.9, 0.9, 0.9, true)
        GameTooltip:AddLine("Shift + Right Drag: Rotate", 0.9, 0.9, 0.9, true)
        GameTooltip:AddLine("Middle Click: Reset", 0.9, 0.9, 0.9, true)
        GameTooltip:Show()
    end)

    modelFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    modelFrame:SetScript("OnHide", function(self)
        isRotating = false
        isPanning = false
        lastX, lastY = nil, nil
        self:SetScript("OnUpdate", nil)
        GameTooltip:Hide()
    end)
end

function PreviewPanelUI:CreateDetailsPanel(previewFrame)
    local details = CreateFrame("Frame", nil, previewFrame)
    if previewFrame.modelVisible then
        details:SetPoint("TOP", previewFrame.modelContainer, "BOTTOM", 0, -4)
    else
        details:SetPoint("TOP", previewFrame.header, "BOTTOM", 0, -4)
    end
    details:SetPoint("LEFT", 8, 0)
    details:SetPoint("RIGHT", -8, 0)
    details:SetPoint("BOTTOM", 80, 0)
    previewFrame.details = details
    
    self:SetupToggleModelFunction(previewFrame, details)
    self:CreateDetailFields(previewFrame, details)
end

function PreviewPanelUI:SetupToggleModelFunction(previewFrame, details)
    local function ToggleModelVisibility()
        if previewFrame.modelVisible then
            previewFrame.modelVisible = false
            previewFrame.modelContainer:SetHeight(0)
            previewFrame.modelFrame:Hide()
            previewFrame.modelControls:Hide()
            previewFrame.toggleModelButton.text:SetText("Show 3D")
            details:ClearAllPoints()
            details:SetPoint("TOP", previewFrame.header, "BOTTOM", 0, -4)
            details:SetPoint("LEFT", 8, 0)
            details:SetPoint("RIGHT", -8, 0)
            details:SetPoint("BOTTOM", 80, 0)
        else
            previewFrame.modelVisible = true
            previewFrame.modelContainer:SetHeight(150)
            previewFrame.modelFrame:Show()
            previewFrame.modelControls:Show()
            previewFrame.toggleModelButton.text:SetText("Hide 3D")
            if previewFrame._currentModelID and previewFrame._currentModelID > 0 then
                previewFrame.modelFrame:SetModel(previewFrame._currentModelID)
            end
            details:ClearAllPoints()
            details:SetPoint("TOP", previewFrame.modelContainer, "BOTTOM", 0, -4)
            details:SetPoint("LEFT", 8, 0)
            details:SetPoint("RIGHT", -8, 0)
            details:SetPoint("BOTTOM", 80, 0)
        end
    end

    previewFrame.toggleModelButton:SetScript("OnClick", ToggleModelVisibility)
    previewFrame.ToggleModelVisibility = ToggleModelVisibility
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
        divider:SetSize(400, 1)
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
        vendorVal:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        vendorVal:SetWidth(180)
        vendorVal:SetJustifyH("LEFT")
        vendorVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        vendorVal.label = lbl

        local costLbl = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        costLbl:SetPoint("LEFT", vendorVal, "RIGHT", 10, 0)
        costLbl:SetText("Cost:")
        costLbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        local costVal = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        costVal:SetPoint("LEFT", costLbl, "RIGHT", 8, 0)
        costVal:SetPoint("RIGHT", -10, 0)
        costVal:SetJustifyH("LEFT")
        costVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        costVal.label = costLbl

        y = y - 16
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
    previewFrame.factionValue = Line("Faction:")
    previewFrame.reputationValue = InlineReputation("Reputation:")

    -- Create reputation progress bar (hidden by default)
    local repBar = CreateFrame("StatusBar", nil, details)
    repBar:SetPoint("TOPLEFT", 10, y)
    repBar:SetSize(390, 12)
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
    previewFrame.expansionValue = Line("Expansion:")
    previewFrame.zoneValue = Line("Zone:")

    previewFrame.professionHeader = Header("Profession")
    previewFrame.professionValue = Line("Profession:")
    previewFrame.professionSkillValue = Line("Skill:")
    previewFrame.professionRecipeValue = Line("Recipe:")
    previewFrame.reagentsContainer = nil

    previewFrame.requirementsHeader = Header("Requirements")
    local requirementsY = y
    previewFrame.questValue = LineWithTooltip("Quest:")
    y = requirementsY
    previewFrame.achievementValue = LineWithTooltip("Achievement:")

    -- Create achievement progress bar (hidden by default)
    local achBar = CreateFrame("StatusBar", nil, details)
    achBar:SetPoint("TOPLEFT", 10, y)
    achBar:SetSize(390, 12)
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

    previewFrame.weightValue = nil
    previewFrame.houseIconValue = nil
    previewFrame.typeValue = nil
    previewFrame.apiRecordValue = nil
    previewFrame.apiAssetValue = nil
    previewFrame.apiSourceValue = nil
end

function PreviewPanelUI:CreateMapButton(previewFrame)
    local mapBtn = CreateFrame("Button", nil, previewFrame)
    mapBtn:SetSize(36, 36)
    mapBtn:SetPoint("RIGHT", previewFrame.wishlistButton, "LEFT", -5, 0)
    mapBtn:SetFrameLevel(previewFrame:GetFrameLevel() + 5)

    mapBtn.icon = mapBtn:CreateTexture(nil,"ARTWORK")
    mapBtn.icon:SetAllPoints(mapBtn)
    mapBtn.icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    previewFrame.mapBtn = mapBtn
    mapBtn:Hide()

    mapBtn:SetScript("OnClick", function()
        if previewFrame._vendorInfo and HousingWaypointManager then
            HousingWaypointManager:SetWaypoint(previewFrame._vendorInfo)
        end
    end)

    mapBtn:SetScript("OnEnter", function(btn)
        btn.icon:SetVertexColor(1,1,0)
        GameTooltip:SetOwner(btn,"ANCHOR_LEFT")
        GameTooltip:SetText("Set Waypoint")
        GameTooltip:Show()
    end)

    mapBtn:SetScript("OnLeave", function(btn)
        btn.icon:SetVertexColor(1,1,1)
        GameTooltip:Hide()
    end)
end

HousingVendor.PreviewPanelUI = PreviewPanelUI
