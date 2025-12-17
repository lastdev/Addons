------------------------------------------------------------
-- PREVIEW PANEL - Midnight Theme Edition
-- Uses C_HousingCatalog API (100% accurate)
------------------------------------------------------------

local AddonName, HousingVendor = ...

local PreviewPanel = {}
PreviewPanel.__index = PreviewPanel

local previewFrame = nil
local L = _G["HousingVendorLocale"] or {}

-- Theme reference
local Theme = nil
local function GetTheme()
    if not Theme then
        Theme = HousingTheme or {}
    end
    return Theme
end

-- Tooltip scanner for getting full item information
local tooltipScanner = CreateFrame("GameTooltip", "HousingPreviewTooltipScanner", UIParent, "GameTooltipTemplate")
tooltipScanner:SetOwner(UIParent, "ANCHOR_NONE")

------------------------------------------------------------
-- SCAN TOOLTIP FOR ITEM INFORMATION
------------------------------------------------------------

function PreviewPanel:ScanTooltip(itemID)
    local result = {
        description = nil,
        useText = nil,
        collectionBonus = nil,
        sellPrice = nil,
        binding = nil,
        weight = nil,
        houseIcon = nil
    }
    
    local id = tonumber(itemID)
    if not id then return result end
    
    tooltipScanner:ClearLines()
    tooltipScanner:SetItemByID(id)
    
    -- Wait a bit for tooltip to populate (especially for icons)
    C_Timer.After(0.25, function()
        if not previewFrame or not previewFrame:IsShown() then return end
        
        -- Scan tooltip lines
    for i = 1, tooltipScanner:NumLines() do
            local leftText = _G["HousingPreviewTooltipScannerTextLeft" .. i]
            local leftTexture = _G["HousingPreviewTooltipScannerTexture" .. i]
            local rightTexture = _G["HousingPreviewTooltipScannerTexture" .. i .. "Right"]
            
        if leftText then
            local text = leftText:GetText()
            if text then
                    -- Weight
                    local weight = text:match("Weight:%s*(%d+)")
                if weight then
                        result.weight = tonumber(weight)
                        if previewFrame.weightValue and previewFrame.SetFieldValue then
                            previewFrame.SetFieldValue(previewFrame.weightValue, tostring(result.weight), previewFrame.weightValue.label)
                        end
                    end
                    
                    -- Description (italic text - usually flavor text)
                    local font = leftText:GetFont()
                    if font and tostring(font):find("Italic") then
                        if not result.description then
                            result.description = text
                            -- descriptionValue removed from layout
                        end
                    end
                    
                    -- Use text
                    if text:match("^Use:") then
                        result.useText = text
                    end
                    
                    -- Collection bonus
                    if text:match("Collection Bonus") or text:match("First%-Time") then
                        result.collectionBonus = text
                    end
                    
                    -- Sell price
                    if text:match("Sell Price:") then
                        result.sellPrice = text
                    end
                    
                    -- Binding
                    if text:match("Binds") then
                        result.binding = text
                end
            end
        end

            -- Check for house icon in textures (filter out weapon/armor icons)
            if leftTexture then
            local texture = leftTexture:GetTexture()
                if texture and texture ~= "" then
                    local textureStr = tostring(texture)
                    if not textureStr:find("INV_Weapon") and
                       not textureStr:find("INV_Sword") and
                       not textureStr:find("INV_Axe") and
                       not textureStr:find("INV_Mace") and
                       not textureStr:find("INV_Shield") and
                       not textureStr:find("INV_Helmet") and
                       not textureStr:find("INV_Armor") and
                       not textureStr:find("INV_Misc_QuestionMark") and
                       not textureStr:find("INV_Boots") and
                       not textureStr:find("INV_Gauntlets") and
                       not textureStr:find("INV_Shoulder") and
                       not textureStr:find("INV_Chest") then
                        if not result.houseIcon then
                            result.houseIcon = texture
                            -- Update UI
                            if previewFrame.houseIconValue then
                                if not previewFrame.houseIconTexture then
                                    local iconTex = previewFrame.details:CreateTexture(nil, "OVERLAY")
                                    iconTex:SetSize(20, 20)
                                    iconTex:SetPoint("LEFT", previewFrame.houseIconValue, "RIGHT", 5, 0)
                                    previewFrame.houseIconTexture = iconTex
                                end
                                previewFrame.houseIconTexture:SetTexture(texture)
                                previewFrame.houseIconTexture:Show()
                                if previewFrame.SetFieldValue then
                                    previewFrame.SetFieldValue(previewFrame.houseIconValue, "Yes", previewFrame.houseIconValue.label)
                                else
                                    previewFrame.houseIconValue:SetText("Yes")
                                end
            end
        end
    end
                end
            end
            
            if rightTexture then
                local texture = rightTexture:GetTexture()
                if texture and texture ~= "" then
                    local textureStr = tostring(texture)
                    if not textureStr:find("INV_Weapon") and
                       not textureStr:find("INV_Sword") and
                       not textureStr:find("INV_Axe") and
                       not textureStr:find("INV_Mace") and
                       not textureStr:find("INV_Shield") and
                       not textureStr:find("INV_Helmet") and
                       not textureStr:find("INV_Armor") and
                       not textureStr:find("INV_Misc_QuestionMark") and
                       not textureStr:find("INV_Boots") and
                       not textureStr:find("INV_Gauntlets") and
                       not textureStr:find("INV_Shoulder") and
                       not textureStr:find("INV_Chest") then
                        if not result.houseIcon then
                            result.houseIcon = texture
                            -- Update UI
                            if previewFrame.houseIconValue then
                                if not previewFrame.houseIconTexture then
                                    local iconTex = previewFrame.details:CreateTexture(nil, "OVERLAY")
                                    iconTex:SetSize(20, 20)
                                    iconTex:SetPoint("LEFT", previewFrame.houseIconValue, "RIGHT", 5, 0)
                                    previewFrame.houseIconTexture = iconTex
                                end
                                previewFrame.houseIconTexture:SetTexture(texture)
                                previewFrame.houseIconTexture:Show()
                                if previewFrame.SetFieldValue then
                                    previewFrame.SetFieldValue(previewFrame.houseIconValue, "Yes", previewFrame.houseIconValue.label)
                                else
                                    previewFrame.houseIconValue:SetText("Yes")
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
    
    -- Return initial result (weight and icon will be updated asynchronously)
    return result
end

------------------------------------------------------------
-- GET CATALOG DATA (delegates to HousingAPI)
------------------------------------------------------------

function PreviewPanel:GetCatalogData(itemID)
    if HousingAPI then
        return HousingAPI:GetCatalogData(itemID)
    end
    return {}
end

------------------------------------------------------------
-- INITIALIZE PREVIEW PANEL
------------------------------------------------------------

function PreviewPanel:Initialize(parent)
    self:CreateUI(parent)
end

-- Expose the underlying frame for anchoring other panels (e.g., ModelViewer)
function PreviewPanel:GetFrame()
    return previewFrame
end

------------------------------------------------------------
-- CREATE UI
------------------------------------------------------------

function PreviewPanel:CreateUI(parent)
    local theme = GetTheme()
    local colors = theme.Colors or {}
    
    --------------------------------------------------------
    -- MAIN FRAME (Midnight Theme)
    --------------------------------------------------------
    previewFrame = CreateFrame("Frame", "HousingPreviewFrame", parent, "BackdropTemplate")
    -- Position: Right side, below header and filters
    local previewTopOffset = -190  -- Adjusted for new filter height
    previewFrame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -10, previewTopOffset)
    previewFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 40)
    previewFrame:SetWidth(460)
    
    -- Midnight theme backdrop
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

    --------------------------------------------------------
    -- HEADER: ICON + NAME (Midnight Theme)
    --------------------------------------------------------
    local header = CreateFrame("Frame", nil, previewFrame, "BackdropTemplate")
    header:SetPoint("TOPLEFT", 0, 0)
    header:SetPoint("TOPRIGHT", 0, 0)
    header:SetHeight(70)
    
    -- Header background gradient
    local headerBg = header:CreateTexture(nil, "BACKGROUND")
    headerBg:SetAllPoints()
    headerBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    headerBg:SetGradient("VERTICAL", 
        CreateColor(0.15, 0.10, 0.22, 0.8), 
        CreateColor(0.10, 0.07, 0.15, 0.6))
    
    previewFrame.header = header

    -- Wishlist star button (no frame, just icon)
    local wishlistButton = CreateFrame("Button", nil, previewFrame)
    wishlistButton:SetSize(36, 36)
    wishlistButton:SetPoint("TOPRIGHT", previewFrame, "TOPRIGHT", -10, -10)
    wishlistButton:SetFrameLevel(previewFrame:GetFrameLevel() + 5)
    
    local wishlistIcon = wishlistButton:CreateTexture(nil, "ARTWORK")
    wishlistIcon:SetAllPoints(wishlistButton)  -- Fill entire button
    wishlistIcon:SetTexture("Interface\\Icons\\INV_ValentinesCandy")  -- Heart icon
    wishlistIcon:SetDesaturated(true)  -- Make it gray
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
                self.icon:SetDesaturated(true)  -- Gray
                -- Silently update wishlist
                -- print("|cFF8A7FD4HousingVendor:|r Removed from wishlist: " .. (item.name or "Unknown"))
            else
                HousingDB.wishlist[itemID] = true
                self.icon:SetTexture("Interface\\Icons\\INV_ValentinesCandy")
                self.icon:SetDesaturated(false)  -- Red/Pink
                -- Silently update wishlist
                -- print("|cFF8A7FD4HousingVendor:|r Added to wishlist: " .. (item.name or "Unknown"))
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

    -- Icon with quality border
    local iconContainer = CreateFrame("Frame", nil, header)
    iconContainer:SetSize(56, 56)
    iconContainer:SetPoint("LEFT", 12, 0)
    
    local iconBorder = iconContainer:CreateTexture(nil, "BACKGROUND")
    iconBorder:SetAllPoints()
    iconBorder:SetTexture("Interface\\Buttons\\WHITE8x8")
    iconBorder:SetVertexColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    previewFrame.iconBorder = iconBorder
    
    local icon = iconContainer:CreateTexture(nil, "ARTWORK")
    icon:SetSize(52, 52)
    icon:SetPoint("CENTER")
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    previewFrame.icon = icon
    
    -- Collected checkmark overlay (like item list)
    local collectedCheck = iconContainer:CreateTexture(nil, "OVERLAY")
    collectedCheck:SetSize(32, 32)
    collectedCheck:SetPoint("CENTER")
    collectedCheck:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
    collectedCheck:Hide()
    previewFrame.collectedCheck = collectedCheck
    
    -- Icon tooltip
    iconContainer:EnableMouse(true)
    iconContainer:SetScript("OnEnter", function(self)
        local item = previewFrame._currentItem
        if item and item.itemID then
            local itemID = tonumber(item.itemID)
            local isCollected = false
            if itemID and CollectionAPI then
                isCollected = CollectionAPI:IsItemCollected(itemID)
            end
            local isInWishlist = itemID and HousingDB and HousingDB.wishlist and HousingDB.wishlist[itemID]
            local catalogData = item._catalogData or {}
            
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(item.name or "Unknown Item", 1, 1, 1)
            
            -- Collection status
            if isCollected then
                GameTooltip:AddLine("Collected", 0.2, 1, 0.2)
            else
                GameTooltip:AddLine("Not Collected", 0.7, 0.7, 0.7)
            end
            
            if isInWishlist then
                GameTooltip:AddLine("Favorited", 1, 0.9, 0.2)
            end
            
            -- Cost information
            if item._costBreakdown and #item._costBreakdown > 0 then
                GameTooltip:AddLine(" ") -- Spacer
                for _, costStr in ipairs(item._costBreakdown) do
                    GameTooltip:AddLine("Cost: " .. costStr, 1, 0.82, 0)
                end
            end
            
            -- Profession information
            if item.profession then
                GameTooltip:AddLine(" ") -- Spacer
                local profText = "Profession: " .. item.profession
                GameTooltip:AddLine(profText, 0.4, 0.78, 1)
                
                -- Skill level requirement
                if item.professionSkillNeeded and item.professionSkillNeeded > 0 then
                    GameTooltip:AddLine("  Requires Level " .. item.professionSkillNeeded, 0.7, 0.7, 0.7)
                end
                
                -- Recipe name
                if item.professionSpellID then
                    local spellInfo = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(item.professionSpellID)
                    if spellInfo and spellInfo.name then
                        GameTooltip:AddLine("  Recipe: " .. spellInfo.name, 0.9, 0.9, 0.8)
                    end
                end
            end
            
            -- Achievement requirement
            local achievementText = item._apiAchievement or catalogData.achievement
            if achievementText and achievementText ~= "" then
                -- Parse achievement name from formatted text if needed
                if string.find(achievementText, "|n|cFFFFD200") then
                    achievementText = string.match(achievementText, "^([^|]+)") or achievementText
                end
                GameTooltip:AddLine(" ") -- Spacer
                GameTooltip:AddLine("Achievement: " .. achievementText, 1, 0.82, 0)
            end
            
            -- Quest requirement
            if catalogData.quest and catalogData.quest ~= "" then
                if not achievementText then
                    GameTooltip:AddLine(" ") -- Spacer
                end
                GameTooltip:AddLine("Quest: " .. catalogData.quest, 1, 0.82, 0)
            end
            
            -- Reputation requirement
            if catalogData.reputation and catalogData.reputation ~= "" then
                if not achievementText and not catalogData.quest then
                    GameTooltip:AddLine(" ") -- Spacer
                end
                GameTooltip:AddLine("Reputation: " .. catalogData.reputation, 1, 0.82, 0)
            end
            
            -- Renown requirement
            if catalogData.renown and catalogData.renown ~= "" then
                if not achievementText and not catalogData.quest and not catalogData.reputation then
                    GameTooltip:AddLine(" ") -- Spacer
                end
                GameTooltip:AddLine("Renown: " .. catalogData.renown, 1, 0.82, 0)
            end
            
            -- Event requirement
            if catalogData.event and catalogData.event ~= "" then
                GameTooltip:AddLine(" ") -- Spacer
                GameTooltip:AddLine("Event: " .. catalogData.event, 0.8, 0.4, 1)
            end
            
            -- Class requirement
            if catalogData.class and catalogData.class ~= "" then
                if not catalogData.event then
                    GameTooltip:AddLine(" ") -- Spacer
                end
                GameTooltip:AddLine("Class: " .. catalogData.class, 0.8, 0.4, 1)
            end
            
            -- Race requirement
            if catalogData.race and catalogData.race ~= "" then
                if not catalogData.event and not catalogData.class then
                    GameTooltip:AddLine(" ") -- Spacer
                end
                GameTooltip:AddLine("Race: " .. catalogData.race, 0.8, 0.4, 1)
            end
            
            GameTooltip:Show()
        end
    end)
    
    iconContainer:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    -- Name text (primary)
    local textPrimary = HousingTheme.Colors.textPrimary
    local name = header:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    name:SetPoint("LEFT", iconContainer, "RIGHT", 12, 8)
    name:SetPoint("RIGHT", -45, 0)
    name:SetJustifyH("LEFT")
    name:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    previewFrame.name = name

    -- ID and type text (secondary)
    local textMuted = HousingTheme.Colors.textMuted
    local textSecondary = HousingTheme.Colors.textSecondary
    local idText = header:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    idText:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -2)
    idText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    previewFrame.idText = idText
    
    -- Collection status (inline under Item ID, all left-aligned)
    local collectionLbl = header:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    collectionLbl:SetPoint("TOPLEFT", idText, "BOTTOMLEFT", 0, -4)
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

    --------------------------------------------------------
    -- 3D MODEL VIEWER (Integrated into panel)
    --------------------------------------------------------
    local modelContainer = CreateFrame("Frame", nil, previewFrame, "BackdropTemplate")
    modelContainer:SetPoint("TOP", header, "BOTTOM", 0, -8)
    modelContainer:SetPoint("LEFT", 8, 0)
    modelContainer:SetPoint("RIGHT", -8, 0)
    modelContainer:SetHeight(150)  -- Reduced from 180 to make room for larger fonts

    -- Model container backdrop
    modelContainer:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    local bgTertiary = HousingTheme.Colors.bgTertiary
    modelContainer:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.5)
    modelContainer:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.4)

    -- Toggle button for showing/hiding 3D preview
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
    local textPrimary = HousingTheme.Colors.textPrimary
    toggleText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    toggleModelButton.text = toggleText

    local accentPrimary = HousingTheme.Colors.accentPrimary
    local bgHover = HousingTheme.Colors.bgHover

    toggleModelButton:SetScript("OnEnter", function(self)
        self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], 0.9)
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    toggleModelButton:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.8)
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.6)
    end)

    -- 3D Model Scene (PlayerModel for compatibility)
    local modelFrame = CreateFrame("PlayerModel", nil, modelContainer)
    modelFrame:SetPoint("TOPLEFT", 2, -2)
    modelFrame:SetPoint("BOTTOMRIGHT", -2, 2)
    modelFrame:SetAlpha(1.0)
    
    -- Set up camera when model loads
    modelFrame:SetScript("OnModelLoaded", function(self)
        if self.MakeCurrentCameraCustom then
            self:MakeCurrentCameraCustom()
        end
        self:SetPosition(0, 0, 0)
        if self.SetCameraPosition then
            self:SetCameraPosition(0, 0, 4)
        end
        if self.SetCameraDistance then
            -- Zoom in by 25% (30 * 0.75 = 22.5)
            self:SetCameraDistance(22.5)
        end
    end)

    -- Store reference
    previewFrame.modelFrame = modelFrame
    previewFrame.modelContainer = modelContainer
    previewFrame.toggleModelButton = toggleModelButton
    previewFrame.modelVisible = true
    
    -- Store rotation and camera state
    local currentRotation = 0
    local cameraDistance = 22.5  -- Default zoom in by 25%
    
    -- 3D Model Controls (below model, only visible when model is shown)
    local controlsFrame = CreateFrame("Frame", nil, modelContainer)
    controlsFrame:SetPoint("BOTTOM", modelContainer, "BOTTOM", 0, 4)
    controlsFrame:SetSize(90, 18)
    controlsFrame:SetFrameLevel(modelContainer:GetFrameLevel() + 5)
    

    -- Rotate Left button
    local rotateLeftBtn = CreateFrame("Button", nil, controlsFrame)
    rotateLeftBtn:SetSize(18, 18)
    rotateLeftBtn:SetPoint("LEFT", controlsFrame, "LEFT", 0, 0)
    rotateLeftBtn:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
    rotateLeftBtn:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
    rotateLeftBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    rotateLeftBtn:SetScript("OnClick", function()
        currentRotation = currentRotation - 0.3
        modelFrame:SetFacing(currentRotation)
    end)
    rotateLeftBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Rotate Left", 1, 1, 1)
        GameTooltip:Show()
    end)
    rotateLeftBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    -- Rotate Right button
    local rotateRightBtn = CreateFrame("Button", nil, controlsFrame)
    rotateRightBtn:SetSize(18, 18)
    rotateRightBtn:SetPoint("LEFT", rotateLeftBtn, "RIGHT", 0, 0)
    rotateRightBtn:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
    rotateRightBtn:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
    rotateRightBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    rotateRightBtn:SetScript("OnClick", function()
        currentRotation = currentRotation + 0.3
        modelFrame:SetFacing(currentRotation)
    end)
    rotateRightBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Rotate Right", 1, 1, 1)
        GameTooltip:Show()
    end)
    rotateRightBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    -- Reset button
    local resetViewBtn = CreateFrame("Button", nil, controlsFrame)
    resetViewBtn:SetSize(18, 18)
    resetViewBtn:SetPoint("LEFT", rotateRightBtn, "RIGHT", 0, 0)
    resetViewBtn:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton")
    resetViewBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    resetViewBtn:SetScript("OnClick", function()
        currentRotation = 0
        cameraDistance = 22.5  -- Reset to default 25% zoom
        modelFrame:SetFacing(0)
        if modelFrame.SetCameraDistance then
            modelFrame:SetCameraDistance(cameraDistance)
        end
    end)
    resetViewBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Reset View", 1, 1, 1)
        GameTooltip:Show()
    end)
    resetViewBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    -- Zoom In button
    local zoomInBtn = CreateFrame("Button", nil, controlsFrame)
    zoomInBtn:SetSize(18, 18)
    zoomInBtn:SetPoint("LEFT", resetViewBtn, "RIGHT", 0, 0)
    zoomInBtn:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
    zoomInBtn:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
    zoomInBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    zoomInBtn:SetScript("OnClick", function()
        cameraDistance = cameraDistance - 2
        cameraDistance = math.max(1, math.min(cameraDistance, 30))
        if modelFrame.SetCameraDistance then
            modelFrame:SetCameraDistance(cameraDistance)
        end
    end)
    zoomInBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Zoom In", 1, 1, 1)
        GameTooltip:Show()
    end)
    zoomInBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    -- Zoom Out button
    local zoomOutBtn = CreateFrame("Button", nil, controlsFrame)
    zoomOutBtn:SetSize(18, 18)
    zoomOutBtn:SetPoint("LEFT", zoomInBtn, "RIGHT", 0, 0)
    zoomOutBtn:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
    zoomOutBtn:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
    zoomOutBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    zoomOutBtn:SetScript("OnClick", function()
        cameraDistance = cameraDistance + 2
        cameraDistance = math.max(1, math.min(cameraDistance, 30))
        if modelFrame.SetCameraDistance then
            modelFrame:SetCameraDistance(cameraDistance)
        end
    end)
    zoomOutBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Zoom Out", 1, 1, 1)
        GameTooltip:Show()
    end)
    zoomOutBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    previewFrame.modelControls = controlsFrame

    --------------------------------------------------------
    -- DETAILS FRAME (Midnight Theme - Below Model)
    --------------------------------------------------------
    local details = CreateFrame("Frame", nil, previewFrame)
    details:SetPoint("TOP", modelContainer, "BOTTOM", 0, -4)  -- Reduced gap from -8 to -4
    details:SetPoint("LEFT", 8, 0)
    details:SetPoint("RIGHT", -8, 0)
    details:SetPoint("BOTTOM", 80, 0)  -- Increased from 50 to give more space for wrapped text
    previewFrame.details = details

    -- Function to toggle model visibility
    local function ToggleModelVisibility()
        if previewFrame.modelVisible then
            -- Hide model and controls
            previewFrame.modelVisible = false
            modelContainer:SetHeight(0)
            modelFrame:Hide()
            controlsFrame:Hide()
            toggleText:SetText("Show 3D")
            -- Reposition details to attach to header
            details:ClearAllPoints()
            details:SetPoint("TOP", header, "BOTTOM", 0, -4)  -- Reduced gap from -8 to -4
            details:SetPoint("LEFT", 8, 0)
            details:SetPoint("RIGHT", -8, 0)
            details:SetPoint("BOTTOM", 80, 0)  -- Increased from 50 to give more space
        else
            -- Show model and controls
            previewFrame.modelVisible = true
            modelContainer:SetHeight(150)  -- Reduced from 180 to make room for larger fonts
            modelFrame:Show()
            controlsFrame:Show()
            toggleText:SetText("Hide 3D")
            -- Reload the current model if we have one stored
            if previewFrame._currentModelID and previewFrame._currentModelID > 0 then
                modelFrame:SetModel(previewFrame._currentModelID)
            end
            -- Reposition details to attach to model container
            details:ClearAllPoints()
            details:SetPoint("TOP", modelContainer, "BOTTOM", 0, -4)  -- Reduced gap from -8 to -4
            details:SetPoint("LEFT", 8, 0)
            details:SetPoint("RIGHT", -8, 0)
            details:SetPoint("BOTTOM", 80, 0)  -- Increased from 50 to give more space
        end
    end

    toggleModelButton:SetScript("OnClick", ToggleModelVisibility)
    previewFrame.ToggleModelVisibility = ToggleModelVisibility

    --------------------------------------------------------
    -- DETAIL FIELDS (Midnight Theme)
    --------------------------------------------------------
    local y = -2  -- Start higher to fit more content (was -5)
    local textSecondary = HousingTheme.Colors.textSecondary

    local function Header(text)
        local f = details:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        f:SetPoint("TOPLEFT", 5, y)
        f:SetText(text)
        f:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)  -- Moonlit blue
        y = y - 18  -- Slightly reduced spacing (was 20) to fit more content

        -- Add subtle divider line
        local divider = details:CreateTexture(nil, "ARTWORK")
        divider:SetPoint("TOPLEFT", 5, y + 2)
        divider:SetSize(400, 1)
        divider:SetTexture("Interface\\Buttons\\WHITE8x8")
        divider:SetVertexColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.4)
        y = y - 2  -- Tighter spacing (was 4)

        -- Store divider reference for hiding
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
        val:SetWordWrap(true)  -- Enable word wrapping
        val:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

        -- Store label reference for hiding
        val.label = lbl

        -- Add tooltip support
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

        y = y - 16  -- Slightly reduced spacing (was 18) to fit more content
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
        val:SetWordWrap(true)  -- Enable word wrapping for long text
        val:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

        -- Store label reference for hiding
        val.label = lbl

        -- Add tooltip support (supports both simple text and achievement/quest tooltips)
        val:SetScript("OnEnter", function(self)
            -- Check if we have an achievement ID to show achievement tooltip
            if self.achievementID then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetAchievementByID(self.achievementID)
                GameTooltip:Show()
            -- Check if we have a quest ID to show quest tooltip
            elseif self.questID then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink("quest:" .. self.questID)
                GameTooltip:Show()
            -- Fallback to simple text tooltip
            elseif self.tooltipText then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
                GameTooltip:Show()
        end
    end)
        val:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        y = y - 20  -- Slightly reduced for wrapping with larger font (was 24)
        return val
    end
    
    -- Helper function for inline vendor + cost display
    local function InlineVendorCost(vendorLabel)
        local lbl = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("TOPLEFT", 10, y)
        lbl:SetText(vendorLabel)
        lbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        -- Vendor value (left side)
        local vendorVal = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        vendorVal:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        vendorVal:SetWidth(180)
        vendorVal:SetJustifyH("LEFT")
        vendorVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        vendorVal.label = lbl
        
        -- Add tooltip support for vendor
        vendorVal:SetScript("OnEnter", function(self)
            if self.tooltipText then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
                GameTooltip:Show()
            end
        end)
        vendorVal:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        -- Cost label (middle)
        local costLbl = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        costLbl:SetPoint("LEFT", vendorVal, "RIGHT", 10, 0)
        costLbl:SetText("Cost:")
        costLbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        -- Cost value (right side)
        local costVal = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        costVal:SetPoint("LEFT", costLbl, "RIGHT", 8, 0)
        costVal:SetPoint("RIGHT", -10, 0)
        costVal:SetJustifyH("LEFT")
        costVal:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        costVal.label = costLbl
        
        -- Add tooltip support for cost
        costVal:SetScript("OnEnter", function(self)
            if self.tooltipText then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
                GameTooltip:Show()
            end
        end)
        costVal:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        y = y - 16  -- Slightly reduced spacing (was 18) to fit more content
        return vendorVal, costVal
    end
    
    -- Helper function for inline reputation display (label on left, value on right)
    local function InlineReputation(label)
        -- Label (left side)
        local lbl = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("TOPLEFT", 10, y)
        lbl:SetText(label)
        lbl:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)

        -- Value (right side)
        local val = details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        val:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        val:SetPoint("RIGHT", -10, 0)
        val:SetJustifyH("LEFT")
        val:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        val.label = lbl
        
        -- Add tooltip support
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

        y = y - 16  -- Slightly reduced spacing (was 18) to fit more content
        return val
    end

    -- Helper function to set field value and auto-hide if N/A
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
    previewFrame.SetFieldValue = SetFieldValue  -- Store for use in ShowItem

    -- Helper function to hide/show headers based on whether their section has visible fields
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
    previewFrame.UpdateHeaderVisibility = UpdateHeaderVisibility  -- Store for use in ShowItem

    -- Item Information (top section) - HIDDEN: redundant with list view
    -- previewFrame.basicInfoHeader = Header("Item Information")
    -- previewFrame.categoryValue = Line("Category:")
    -- previewFrame.subcategoryValue = Line("Subcategory:")
    -- previewFrame.sourceTypeValue = Line("Source:")
    -- previewFrame.collectionValue = Line("Status:")  -- Removed, using inline collection fields instead

    -- Vendor Information (includes faction, reputation, cost)
    previewFrame.vendorHeader = Header("Vendor")
    previewFrame.vendorValue, previewFrame.costValue = InlineVendorCost("Vendor:")
    previewFrame.factionValue = Line("Faction:")
    previewFrame.reputationValue = InlineReputation("Reputation:")
    previewFrame.renownValue = Line("Renown:")
    previewFrame.expansionValue = Line("Expansion:")
    previewFrame.zoneValue = Line("Zone:")
    -- previewFrame.coordsValue = Line("Coordinates:")  -- Removed: redundant with map button

    -- Profession Information (for crafted items)
    previewFrame.professionHeader = Header("Profession")
    previewFrame.professionValue = Line("Profession:")
    previewFrame.professionSkillValue = Line("Skill:")
    previewFrame.professionRecipeValue = Line("Recipe:")
    previewFrame.reagentsContainer = nil  -- Will create dynamically

    -- Other Requirements (quest and achievement share same position since only one shows at a time)
    previewFrame.requirementsHeader = Header("Requirements")
    local requirementsY = y  -- Save Y position for both quest and achievement
    previewFrame.questValue = LineWithTooltip("Quest:")
    y = requirementsY  -- Reset Y so achievement is at same position as quest
    previewFrame.achievementValue = LineWithTooltip("Achievement:")
    previewFrame.eventValue = Line("Event:")
    previewFrame.classValue = Line("Class:")
    previewFrame.raceValue = Line("Race:")

    -- Store these fields as nil (not used in compact layout)
    previewFrame.weightValue = nil
    previewFrame.houseIconValue = nil
    previewFrame.typeValue = nil
    previewFrame.apiRecordValue = nil
    previewFrame.apiAssetValue = nil
    previewFrame.apiSourceValue = nil

    --------------------------------------------------------
    -- MAP BUTTON (for coordinates) - Positioned next to wishlist button, no frame
    --------------------------------------------------------
    local mapBtn = CreateFrame("Button", nil, previewFrame)
    mapBtn:SetSize(36, 36)
    mapBtn:SetPoint("RIGHT", wishlistButton, "LEFT", -5, 0)
    mapBtn:SetFrameLevel(previewFrame:GetFrameLevel() + 5)

    mapBtn.icon = mapBtn:CreateTexture(nil,"ARTWORK")
    mapBtn.icon:SetAllPoints(mapBtn)  -- Fill entire button
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

------------------------------------------------------------
-- SHOW ITEM DATA
------------------------------------------------------------

function PreviewPanel:ShowItem(item)
    if not previewFrame then return end
    if not item or not item.itemID then return end

    previewFrame:Show()
    
    -- Store current item for wishlist button
    previewFrame._currentItem = item
    
    -- Get catalog data (primary source)
    local catalogData = self:GetCatalogData(item.itemID)
    
    -- Store catalog cost on item for icon tooltip access
    if catalogData and catalogData.cost then
        item._catalogCost = catalogData.cost
    end
    
    -- Store catalog data for tooltip access
    item._catalogData = catalogData
    
    -- Update wishlist button state
    if previewFrame.wishlistButton then
        local itemID = tonumber(item.itemID)
        local isInWishlist = itemID and HousingDB and HousingDB.wishlist and HousingDB.wishlist[itemID]
        if isInWishlist then
            previewFrame.wishlistButton.icon:SetTexture("Interface\\Icons\\INV_ValentinesCandy")
            previewFrame.wishlistButton.icon:SetDesaturated(false)  -- Red/Pink heart
        else
            previewFrame.wishlistButton.icon:SetTexture("Interface\\Icons\\INV_ValentinesCandy")
            previewFrame.wishlistButton.icon:SetDesaturated(true)  -- Gray heart
        end
    end
    
    -- Get catalog data (primary source)
    local catalogData = self:GetCatalogData(item.itemID)
    
    -- Get tooltip data for description and other info
    local tooltipData = self:ScanTooltip(item.itemID)

    --------------------------------------------------------
    -- NAME & ICON (with quality color)
    --------------------------------------------------------
    local name = catalogData.name or item.name or "Unknown Item"
    -- Apply quality color to name
    if catalogData.quality ~= nil then
        local qualityColors = {
            [0] = "|cff9d9d9d", -- Poor (gray)
            [1] = "|cffffffff", -- Common (white)
            [2] = "|cff1eff00", -- Uncommon (green)
            [3] = "|cff0070dd", -- Rare (blue)
            [4] = "|cffa335ee", -- Epic (purple)
            [5] = "|cffff8000", -- Legendary (orange)
        }
        local colorCode = qualityColors[catalogData.quality] or "|cffffffff"
        previewFrame.name:SetText(colorCode .. name .. "|r")
    else
        previewFrame.name:SetText(name)
    end

    local idText = "Item ID: " .. (item.itemID or "N/A")
    previewFrame.idText:SetText(idText)

    if catalogData.iconTexture then
        previewFrame.icon:SetTexture(catalogData.iconTexture)
    else
        previewFrame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
    
    -- Show/hide collected checkmark overlay
    local itemID = tonumber(item.itemID)
    local isCollected = false
    if itemID and CollectionAPI then
        isCollected = CollectionAPI:IsItemCollected(itemID)
    end
    if previewFrame.collectedCheck then
        if isCollected then
            previewFrame.collectedCheck:Show()
        else
            previewFrame.collectedCheck:Hide()
        end
    end

    --------------------------------------------------------
    -- CATEGORY & SUBCATEGORY - HIDDEN
    --------------------------------------------------------
    -- local category = nil
    -- if catalogData.categoryNames and #catalogData.categoryNames > 0 then
    --     category = table.concat(catalogData.categoryNames, ", ")
    -- end
    -- previewFrame.SetFieldValue(previewFrame.categoryValue, category, previewFrame.categoryValue.label)

    -- local subcategory = nil
    -- if catalogData.subcategoryNames and #catalogData.subcategoryNames > 0 then
    --     subcategory = table.concat(catalogData.subcategoryNames, ", ")
    -- end
    -- previewFrame.SetFieldValue(previewFrame.subcategoryValue, subcategory, previewFrame.subcategoryValue.label)

    --------------------------------------------------------
    -- SOURCE TYPE - HIDDEN
    --------------------------------------------------------
    -- local sourceType = nil
    -- local sourceText = item._apiSourceText or catalogData.sourceText

    -- -- Determine source type from sourceText or other data
    -- if catalogData.achievement or item._apiAchievement then
    --     sourceType = "Achievement"
    -- elseif catalogData.quest then
    --     sourceType = "Quest"
    -- elseif catalogData.vendor or sourceText and sourceText:find("Vendor:") then
    --     sourceType = "Vendor"
    -- elseif sourceText then
    --     -- Try to extract source type from sourceText
    --     if sourceText:find("Drop") or sourceText:find("Loot") then
    --         sourceType = "Drop"
    --     elseif sourceText:find("Crafted") or sourceText:find("Profession") then
    --         sourceType = "Crafted"
    --     elseif sourceText:find("Reputation") then
    --         sourceType = "Reputation"
    --     elseif sourceText:find("Event") or sourceText:find("Holiday") then
    --         sourceType = "Event"
    --     else
    --         sourceType = "Unknown"
    --     end
    -- end
    -- previewFrame.SetFieldValue(previewFrame.sourceTypeValue, sourceType, previewFrame.sourceTypeValue.label)

    --------------------------------------------------------
    -- LIMITED/SEASONAL AVAILABILITY - REMOVED (not needed)
    --------------------------------------------------------
    -- local limitedText = nil
    -- (code removed - availability detection logic not needed in display)
    -- previewFrame.SetFieldValue(previewFrame.limitedValue, limitedText, previewFrame.limitedValue.label)

    --------------------------------------------------------
    -- QUALITY - REMOVED (item name is already color-coded by quality)
    --------------------------------------------------------
    -- local qualityText = nil
    -- (code removed - quality is shown via item name color)
    -- previewFrame.SetFieldValue(previewFrame.qualityValue, qualityText, previewFrame.qualityValue.label)

    --------------------------------------------------------
    -- WEIGHT & HOUSE ICON (from tooltip, async) - REMOVED IN COMPACT LAYOUT
    --------------------------------------------------------
    -- These fields are not used in compact layout, skip them
    if previewFrame.weightValue then
        if tooltipData.weight then
            previewFrame.SetFieldValue(previewFrame.weightValue, tostring(tooltipData.weight), previewFrame.weightValue.label)
        else
            previewFrame.SetFieldValue(previewFrame.weightValue, nil, previewFrame.weightValue.label)
        end
    end

    if previewFrame.houseIconValue and tooltipData.houseIcon then
        -- Create texture if it doesn't exist
        if not previewFrame.houseIconTexture then
            local iconTex = previewFrame.details:CreateTexture(nil, "OVERLAY")
            iconTex:SetSize(20, 20)
            iconTex:SetPoint("LEFT", previewFrame.houseIconValue, "RIGHT", 5, 0)
            previewFrame.houseIconTexture = iconTex
        end
        previewFrame.houseIconTexture:SetTexture(tooltipData.houseIcon)
        previewFrame.houseIconTexture:Show()
        previewFrame.SetFieldValue(previewFrame.houseIconValue, "Yes", previewFrame.houseIconValue.label)
    elseif previewFrame.houseIconValue then
        previewFrame.SetFieldValue(previewFrame.houseIconValue, nil, previewFrame.houseIconValue.label)
        if previewFrame.houseIconTexture then
            previewFrame.houseIconTexture:Hide()
        end
    end

    --------------------------------------------------------
    -- DESCRIPTION (from tooltip) - REMOVED, not needed in compact layout
    --------------------------------------------------------
    -- local description = tooltipData.description
    -- previewFrame.SetFieldValue(previewFrame.descriptionValue, description, previewFrame.descriptionValue.label)

    --------------------------------------------------------
    -- EXPANSION (from API filter tags, fallback to item data)
    --------------------------------------------------------
    local expansionText = nil
    if HousingAPI and item.itemID then
        local apiExpansion = HousingAPI:GetExpansionFromFilterTags(item.itemID)
        if apiExpansion and apiExpansion ~= "" then
            expansionText = apiExpansion
            -- Add indicator for Midnight
            if expansionText == "Midnight" then
                expansionText = expansionText .. " (Not Yet Released)"
            end
        end
    end
    -- Fallback to item expansionName
    if not expansionText and item.expansionName and item.expansionName ~= "" then
        expansionText = item.expansionName
        if expansionText == "Midnight" then
            expansionText = expansionText .. " (Not Yet Released)"
        end
    end
    previewFrame.SetFieldValue(previewFrame.expansionValue, expansionText, previewFrame.expansionValue.label)
    if expansionText then
        previewFrame.expansionValue.tooltipText = L["TOOLTIP_INFO_EXPANSION"] or "The World of Warcraft expansion this item is from"
    end

    --------------------------------------------------------
    -- FACTION (Alliance, Horde, Neutral)
    --------------------------------------------------------
    local factionText = item.faction or "Neutral"
    -- Add color coding for faction
    if factionText == "Alliance" then
        factionText = "|cFF0070DD" .. factionText .. "|r"  -- Blue
    elseif factionText == "Horde" then
        factionText = "|cFFC41E3A" .. factionText .. "|r"  -- Red
    elseif factionText == "Neutral" then
        factionText = "|cFFFFD100" .. factionText .. "|r"  -- Gold
    end
    previewFrame.SetFieldValue(previewFrame.factionValue, factionText, previewFrame.factionValue.label)
    if factionText then
        previewFrame.factionValue.tooltipText = L["TOOLTIP_INFO_FACTION"] or "Which faction can purchase this item from the vendor"
    end

    --------------------------------------------------------
    -- VENDOR, ZONE, COST, COORDINATES
    --------------------------------------------------------
    -- Get vendor info from HousingAPI first, fallback to catalogData
    local vendor = nil
    local zone = nil
    local cost = catalogData.cost
    local costBreakdown = {}
    local coordsText = nil
    local apiCoords = nil
    local apiMapID = nil
    
    if HousingAPI and item.itemID then
        local itemID = tonumber(item.itemID)
        if itemID then
            local baseInfo = HousingAPI:GetDecorItemInfoFromItemID(itemID)
            if baseInfo and baseInfo.decorID then
                local decorID = baseInfo.decorID
                local vendorInfo = HousingAPI:GetDecorVendorInfo(decorID)
                if vendorInfo then
                    -- Get vendor name from API
                    if vendorInfo.name and vendorInfo.name ~= "" then
                        vendor = vendorInfo.name
                    end
                    
                    -- Get zone from API
                    if vendorInfo.zone and vendorInfo.zone ~= "" then
                        zone = vendorInfo.zone
                    end
                    
                    -- Get coordinates from API
                    if vendorInfo.coords and vendorInfo.coords.x and vendorInfo.coords.y then
                        apiCoords = string.format("%.1f, %.1f", vendorInfo.coords.x, vendorInfo.coords.y)
                        coordsText = apiCoords
                    end
                    if vendorInfo.mapID then
                        apiMapID = vendorInfo.mapID
                    end
                    
                    -- Get cost breakdown
                    if vendorInfo.cost and #vendorInfo.cost > 0 then
                        for _, costEntry in ipairs(vendorInfo.cost) do
                            if costEntry.currencyID == 0 then
                                -- Gold
                                local gold = costEntry.amount or 0
                                local goldText = ""
                                if gold >= 10000 then
                                    goldText = string.format("%.1fg", gold / 10000)
                                elseif gold >= 100 then
                                    goldText = string.format("%.1fs", gold / 100)
                                else
                                    goldText = gold .. "c"
                                end
                                table.insert(costBreakdown, goldText .. " gold")
                            elseif costEntry.currencyID then
                                -- Currency
                                local currencyName = "Currency #" .. costEntry.currencyID
                                local currencyInfo = HousingAPI:GetCurrencyInfo(costEntry.currencyID)
                                if currencyInfo and currencyInfo.name then
                                    currencyName = currencyInfo.name
                                end
                                table.insert(costBreakdown, (costEntry.amount or 0) .. " " .. currencyName)
                            elseif costEntry.itemID then
                                -- Item
                                local itemName = "Item #" .. costEntry.itemID
                                if C_Item and C_Item.GetItemInfo then
                                    local ok3, itemInfo = pcall(C_Item.GetItemInfo, costEntry.itemID)
                                    if ok3 and itemInfo and itemInfo.itemName then
                                        itemName = itemInfo.itemName
                                    end
                                end
                                table.insert(costBreakdown, (costEntry.amount or 0) .. "x " .. itemName)
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- Fallback to catalogData if API didn't provide vendor/zone
    if not vendor and catalogData.vendor then
        vendor = catalogData.vendor
    end
    if not zone and catalogData.zone then
        zone = catalogData.zone
        -- Format multiple zones: convert "Zone: XX Zone: YY" to multi-line display
        if zone:find("Zone:") then
            -- Replace "Zone:" separators with newlines for multi-zone display
            zone = zone:gsub("%s*Zone:%s*", "\n")
            -- Remove leading newline if present
            zone = zone:gsub("^\n", "")
        end
    end
    
    -- Fallback to item data for coordinates if API didn't provide them
    if not coordsText and item.vendorCoords and item.vendorCoords.x and item.vendorCoords.y then
        coordsText = string.format("%.1f, %.1f", item.vendorCoords.x, item.vendorCoords.y)
    end
    
    -- Parse reputation requirement from zone string (format: "Zone.Faction: Faction Name - Standing")
    local parsedReputation = nil
    if zone and zone:find("Faction:") then
        -- Match pattern: "ZoneName.Faction: FactionName - Standing" or "ZoneName Faction: FactionName - Standing"
        local actualZone, repInfo = zone:match("^(.-)%.?Faction:%s*(.+)$")
        if actualZone and repInfo then
            -- Extract faction name and required standing
            local factionName, requiredStanding = repInfo:match("^(.-)%s*%-%s*(.+)$")
            if factionName and requiredStanding then
                parsedReputation = repInfo
                
                -- Try to get player's current standing with this faction
                local repLevels = {[1]="Hated", [2]="Hostile", [3]="Unfriendly", [4]="Neutral", [5]="Friendly", [6]="Honored", [7]="Revered", [8]="Exalted"}
                local requiredLevel = 0
                for level, name in pairs(repLevels) do
                    if name == requiredStanding then
                        requiredLevel = level
                        break
                    end
                end
                
                -- Map faction names to IDs from HousingReputations
                local factionIDMap = {
                    ["Council of Exarchs"] = 1731,
                    ["Laughing Skull Orcs"] = 1708,
                    ["Steamwheedle Preservation Society"] = 1711,
                    ["Sha'tari Defense"] = 1710,
                    ["Vol'jin's Headhunters"] = 1681,
                    ["Frostwolf Orcs"] = 1445,
                    ["Wrynn's Vanguard"] = 1682,
                    ["Arakkoa Outcasts"] = 1515,
                    ["Highmountain Tribe"] = 1828,
                    ["The Nightfallen"] = 1859,
                    ["Dreamweavers"] = 1883,
                    ["Zandalari Empire"] = 2103,
                    ["Talanji's Expedition"] = 2156,
                    ["The Honorbound"] = 2160,
                    ["Proudmoore Admiralty"] = 2160,
                    ["Storm's Wake"] = 2162,
                    ["Order of Embers"] = 2161,
                }
                
                local factionID = factionIDMap[factionName]
                if factionID and C_Reputation and C_Reputation.GetFactionDataByID then
                    local factionData = C_Reputation.GetFactionDataByID(factionID)
                    if factionData and factionData.reaction then
                        local currentStanding = repLevels[factionData.reaction] or "Unknown"
                        
                        if requiredLevel > 0 then
                            if factionData.reaction >= requiredLevel then
                                parsedReputation = parsedReputation .. " |cFF00FF00(Met)|r"
                            else
                                parsedReputation = parsedReputation .. " |cFFFF0000(Need " .. requiredStanding .. ", currently " .. currentStanding .. ")|r"
                            end
                        end
                    end
                end
            end
            -- Update zone to just the actual zone name
            zone = actualZone
        end
    end

    -- Display vendor and zone
    previewFrame.SetFieldValue(previewFrame.vendorValue, vendor, previewFrame.vendorValue.label)
    if vendor then
        local tooltipText
        if coordsText then
            tooltipText = (L["TOOLTIP_INFO_VENDOR_WITH_COORDS"] or "NPC vendor who sells this item\n\nLocation: %s\nCoordinates: %s"):format(zone or "Unknown", coordsText)
        else
            tooltipText = L["TOOLTIP_INFO_VENDOR"] or "NPC vendor who sells this item"
        end
        previewFrame.vendorValue.tooltipText = tooltipText
    end
    
    previewFrame.SetFieldValue(previewFrame.zoneValue, zone, previewFrame.zoneValue.label)
    if zone then
        local tooltipText
        if coordsText then
            tooltipText = (L["TOOLTIP_INFO_ZONE_WITH_COORDS"] or "Zone where this vendor is located\n\nCoordinates: %s"):format(coordsText)
        else
            tooltipText = L["TOOLTIP_INFO_ZONE"] or "Zone where this vendor is located"
        end
        previewFrame.zoneValue.tooltipText = tooltipText
    end
    -- Coordinates removed - use map button instead
    
    -- Display cost (format from API breakdown if available, otherwise use catalogData)
    local costDisplay = cost
    if #costBreakdown > 0 then
        -- Use the first cost entry from breakdown as the main display
        costDisplay = costBreakdown[1]
        -- Store cost breakdown on item for icon tooltip
        item._costBreakdown = costBreakdown
    elseif not costDisplay and catalogData.cost then
        costDisplay = catalogData.cost
        -- Parse catalogData.cost into costBreakdown for tooltip
        if type(catalogData.cost) == "string" then
            -- Check if it's a simple number (gold amount in copper)
            local goldAmount = tonumber(catalogData.cost)
            if goldAmount then
                -- Convert copper to gold and format
                local gold = math.floor(goldAmount / 10000)
                local silver = math.floor((goldAmount % 10000) / 100)
                local copper = goldAmount % 100
                
                local goldText = ""
                if gold > 0 then
                    goldText = gold .. " Gold"
                    if silver > 0 then goldText = goldText .. " " .. silver .. " Silver" end
                    if copper > 0 then goldText = goldText .. " " .. copper .. " Copper" end
                elseif silver > 0 then
                    goldText = silver .. " Silver"
                    if copper > 0 then goldText = goldText .. " " .. copper .. " Copper" end
                else
                    goldText = copper .. " Copper"
                end
                
                table.insert(costBreakdown, goldText)
            else
                -- Complex cost string with icons/currencies
                for costStr in string.gmatch(catalogData.cost, "[^,]+") do
                    table.insert(costBreakdown, costStr)
                end
            end
            -- Store parsed breakdown on item for icon tooltip
            item._costBreakdown = costBreakdown
        end
    end
    
    if costDisplay and costDisplay ~= "" and costDisplay ~= "N/A" then
        previewFrame.costValue:SetText(costDisplay)
        previewFrame.costValue:Show()
        if previewFrame.costValue.label then
            previewFrame.costValue.label:Show()
        end
        
        -- Add tooltip with detailed cost breakdown (without icons)
        previewFrame.costValue:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Cost Details", 1, 1, 1)
            
            -- Parse and display each cost item without icons
            if #costBreakdown > 0 then
                for _, costStr in ipairs(costBreakdown) do
                    -- Strip texture tags and convert to readable text
                    local amount = costStr:match("(%d+)")
                    local readable = costStr
                    
                    -- Try to extract currency ID from cost string (format: |Hcurrency:ID|h)
                    local currencyID = costStr:match("|Hcurrency:(%d+)|h")
                    if currencyID then
                        currencyID = tonumber(currencyID)
                        if currencyID and HousingCurrencyTypes and HousingCurrencyTypes[currencyID] then
                            readable = amount .. " " .. HousingCurrencyTypes[currencyID]
                        else
                            -- Unknown currency ID, show generic
                            readable = amount .. " Currency (ID: " .. tostring(currencyID) .. ")"
                        end
                    -- Fall back to icon pattern matching
                    elseif costStr:find("INV_Garrison_Resource") then
                        readable = amount .. " Garrison Resources"
                    elseif costStr:find("INV_Misc_Coin_01") or costStr:find("money") then
                        readable = amount .. " Gold"
                    elseif costStr:find("INV_10_Gearupgrade_Valorstones") then
                        readable = amount .. " Valorstones"
                    elseif costStr:find("INV_Misc_Gem_Variety") then
                        readable = amount .. " Gems"
                    else
                        -- Strip all texture markup if we don't recognize it
                        readable = costStr:gsub("|T.-|t", "[Currency]")
                        readable = readable:gsub("|H.-|h", "")
                        readable = readable:gsub("|h", "")
                        readable = readable:gsub("|r", "")
                    end
                    
                    GameTooltip:AddLine(readable, 1, 0.82, 0)
                end
            else
                GameTooltip:AddLine("No detailed cost information", 0.7, 0.7, 0.7)
            end
            
            GameTooltip:Show()
        end)
        
        previewFrame.costValue:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
    else
        previewFrame.SetFieldValue(previewFrame.costValue, nil, previewFrame.costValue.label)
    end

    --------------------------------------------------------
    -- COLLECTION STATUS (use cached API data if available)
    --------------------------------------------------------
    local collectionText = nil
    local numPlaced = item._apiNumPlaced or catalogData.numPlaced or 0
    local numStored = item._apiNumStored or catalogData.numStored or 0
    local totalOwned = numPlaced + numStored

    -- Only show collection count if > 0
    if numPlaced > 0 then
        collectionText = string.format("Placed: %d", numPlaced)
        if numStored > 0 then
            collectionText = collectionText .. string.format(" | Stored: %d", numStored)
        end
    elseif numStored > 0 then
        collectionText = string.format("Stored: %d", numStored)
    elseif catalogData.quantity and catalogData.quantity > 0 then
        collectionText = string.format("Owned: %d", catalogData.quantity)
    end
    
    -- Show/hide collection field and reposition Collected label
    if collectionText and collectionText ~= "" then
        -- Have collection data - show it and position Collected after it
        previewFrame.SetFieldValue(previewFrame.collectionValue, collectionText, previewFrame.collectionValue.label)
        if previewFrame.collectedValue and previewFrame.collectedValue.label then
            previewFrame.collectedValue.label:ClearAllPoints()
            previewFrame.collectedValue.label:SetPoint("LEFT", previewFrame.collectionValue, "RIGHT", 15, 0)
        end
    else
        -- No collection data - hide Collection and position Collected at start
        if previewFrame.collectionValue then
            previewFrame.collectionValue:Hide()
            if previewFrame.collectionValue.label then
                previewFrame.collectionValue.label:Hide()
            end
        end
        if previewFrame.collectedValue and previewFrame.collectedValue.label then
            previewFrame.collectedValue.label:ClearAllPoints()
            previewFrame.collectedValue.label:SetPoint("TOPLEFT", previewFrame.idText, "BOTTOMLEFT", 0, -4)
        end
    end
    
    -- Collected status (from HousingAPI or catalog data)
    local collectedText = nil
    local favoriteText = nil
    local itemID = tonumber(item.itemID)
    
    -- Method 1: Check catalog data for numStored/numPlaced
    if catalogData.numStored or catalogData.numPlaced then
        local total = (catalogData.numStored or 0) + (catalogData.numPlaced or 0)
        if total > 0 then
            collectedText = "|cFF00FF00Yes|r (" .. total .. " owned)"
        else
            collectedText = "|cFFFF0000No|r"
        end
    end
    
    -- Method 2: Try HousingAPI if catalog didn't have data
    if not collectedText and HousingAPI and itemID then
        local baseInfo = HousingAPI:GetDecorItemInfoFromItemID(itemID)
        if baseInfo and baseInfo.decorID then
            local decorID = baseInfo.decorID
            
            -- Check collected status
            local isCollected = HousingAPI:IsDecorCollected(decorID)
            if isCollected ~= nil then
                collectedText = isCollected and "|cFF00FF00Yes|r" or "|cFFFF0000No|r"
            end
        end
    end
    
    -- Default values if still nil
    if not collectedText then
        collectedText = "Unknown"
    end
    
    previewFrame.SetFieldValue(previewFrame.collectedValue, collectedText, previewFrame.collectedValue.label)

    --------------------------------------------------------
    -- REQUIREMENTS (Quest, Achievement, Reputation, Renown, Profession, Event, Class, Race)
    --------------------------------------------------------
    local questText = nil
    local questID = catalogData.questID
    local achievementText = nil
    local achievementID = catalogData.achievementID
    local reputationText = nil
    local renownText = nil
    local professionText = nil
    local eventText = nil
    local classText = nil
    local raceText = nil

    -- Get requirements from HousingAPI
    if HousingAPI and item.itemID then
        local itemID = tonumber(item.itemID)
        if itemID then
            local baseInfo = HousingAPI:GetDecorItemInfoFromItemID(itemID)
            if baseInfo and baseInfo.decorID then
                local decorID = baseInfo.decorID
                local unlockInfo = HousingAPI:GetDecorUnlockRequirements(decorID)

                if unlockInfo then
                    -- Quest requirement
                    if unlockInfo.questID then
                        questID = unlockInfo.questID
                        questText = "Quest #" .. questID
                        local questInfo = HousingAPI:GetQuestInfo(questID)
                        if questInfo and questInfo.title then
                            questText = questInfo.title
                        end
                    end

                    -- Achievement requirement
                    if unlockInfo.achievementID then
                        achievementID = unlockInfo.achievementID
                        achievementText = "Achievement #" .. achievementID
                        local achievementInfo = HousingAPI:GetAchievementInfo(achievementID)
                        if achievementInfo and achievementInfo.title then
                            achievementText = achievementInfo.title
                        end
                    end

                    -- Reputation requirement
                    if unlockInfo.reputationFactionID and unlockInfo.reputationLevel then
                        local factionName = "Faction #" .. unlockInfo.reputationFactionID
                        local factionInfo = HousingAPI:GetFactionInfoByID(unlockInfo.reputationFactionID)
                        if factionInfo and factionInfo.name then
                            factionName = factionInfo.name
                        end
                        local repLevels = {[1]="Hated", [2]="Hostile", [3]="Unfriendly", [4]="Neutral", [5]="Friendly", [6]="Honored", [7]="Revered", [8]="Exalted"}
                        local repLevel = repLevels[unlockInfo.reputationLevel] or ("Level " .. tostring(unlockInfo.reputationLevel))
                        reputationText = factionName .. " - " .. repLevel
                        
                        -- Get player's current rep status
                        local currentStanding, currentValue, maxValue
                        if C_Reputation and C_Reputation.GetFactionDataByID then
                            local factionData = C_Reputation.GetFactionDataByID(unlockInfo.reputationFactionID)
                            if factionData then
                                currentStanding = factionData.reaction or 0
                                currentValue = factionData.currentReactionThreshold or 0
                                maxValue = factionData.nextReactionThreshold or 1
                                
                                -- Check if player meets requirement
                                if currentStanding >= unlockInfo.reputationLevel then
                                    reputationText = reputationText .. " |cFF00FF00(Met)|r"
                                else
                                    local currentRepName = repLevels[currentStanding] or "Unknown"
                                    reputationText = reputationText .. " |cFFFF0000(Need " .. repLevel .. ", currently " .. currentRepName .. ")|r"
                                end
                            end
                        end
                    end

                    -- Renown requirement
                    if unlockInfo.renownLevel then
                        renownText = "Renown Level " .. tostring(unlockInfo.renownLevel)
                        
                        -- Get player's current renown (requires majorFactionID)
                        if unlockInfo.majorFactionID and C_MajorFactions and C_MajorFactions.GetMajorFactionData then
                            local majorFactionData = C_MajorFactions.GetMajorFactionData(unlockInfo.majorFactionID)
                            if majorFactionData and majorFactionData.renownLevel then
                                if majorFactionData.renownLevel >= unlockInfo.renownLevel then
                                    renownText = renownText .. " |cFF00FF00(Met - Currently Renown " .. majorFactionData.renownLevel .. ")|r"
                                else
                                    renownText = renownText .. " |cFFFF0000(Need Renown " .. unlockInfo.renownLevel .. ", currently " .. majorFactionData.renownLevel .. ")|r"
                                end
                            end
                        end
                    end

                    -- Profession requirement
                    if unlockInfo.professionLevel then
                        professionText = "Profession Level " .. tostring(unlockInfo.professionLevel)
                    end

                    -- Event requirement
                    if unlockInfo.eventRequirement then
                        eventText = unlockInfo.eventRequirement
                    end

                    -- Class requirement
                    if unlockInfo.classRequirement then
                        local classInfo = C_CreatureInfo and C_CreatureInfo.GetClassInfo and C_CreatureInfo.GetClassInfo(unlockInfo.classRequirement)
                        classText = classInfo and classInfo.className or ("Class ID " .. tostring(unlockInfo.classRequirement))
                    end

                    -- Race requirement
                    if unlockInfo.raceRequirement then
                        local raceInfo = C_CreatureInfo and C_CreatureInfo.GetRaceInfo and C_CreatureInfo.GetRaceInfo(unlockInfo.raceRequirement)
                        raceText = raceInfo and raceInfo.raceName or ("Race ID " .. tostring(unlockInfo.raceRequirement))
                    end
                end
            end
        end
    end

    -- Fallback to catalogData if API didn't provide data
    if not questText and catalogData.quest then
        questText = catalogData.quest
    end
    if not achievementText then
        achievementText = item._apiAchievement or catalogData.achievement
        -- Parse achievement name from formatted text if needed
        if achievementText and string.find(achievementText, "|n|cFFFFD200") then
            achievementText = string.match(achievementText, "^([^|]+)") or achievementText
        end
    end
    if not reputationText and catalogData.reputation then
        reputationText = catalogData.reputation
    end
    if not renownText and catalogData.renown then
        renownText = catalogData.renown
    end
    if not professionText and catalogData.profession then
        professionText = catalogData.profession
    end
    
    -- Enhanced profession information (for Profession Information section)
    local professionName = nil
    local professionSkillText = nil
    local professionRecipeText = nil

    if not professionText and item.profession then
        professionName = item.profession

        -- Build skill text with current player skill level
        local currentSkill, maxSkill
        if item.professionSkillNeeded and item.professionSkillNeeded > 0 then
            -- Try to get player's current profession skill
            if C_TradeSkillUI and C_TradeSkillUI.GetProfessionInfo then
                -- Map profession names to IDs (approximate)
                local profMap = {
                    ["Alchemy"] = 171, ["Blacksmithing"] = 164, ["Cooking"] = 185,
                    ["Enchanting"] = 333, ["Engineering"] = 202, ["Herbalism"] = 182,
                    ["Inscription"] = 773, ["Jewelcrafting"] = 755, ["Leatherworking"] = 165,
                    ["Mining"] = 186, ["Skinning"] = 393, ["Tailoring"] = 197
                }
                local profID = profMap[item.profession]
                if profID then
                    for _, professionID in ipairs(C_TradeSkillUI.GetAllProfessionTradeSkillLines() or {}) do
                        local profInfo = C_TradeSkillUI.GetProfessionInfo(professionID)
                        if profInfo and profInfo.professionID == profID then
                            currentSkill = profInfo.skillLevel or 0
                            maxSkill = profInfo.maxSkillLevel or 0
                            break
                        end
                    end
                end
            end
            
            if currentSkill then
                if currentSkill >= item.professionSkillNeeded then
                    professionSkillText = item.professionSkill .. " - Level " .. item.professionSkillNeeded .. " |cFF00FF00(Met - Currently " .. currentSkill .. "/" .. maxSkill .. ")|r"
                else
                    professionSkillText = item.professionSkill .. " - Level " .. item.professionSkillNeeded .. " |cFFFF0000(Need " .. item.professionSkillNeeded .. ", currently " .. currentSkill .. "/" .. maxSkill .. ")|r"
                end
            elseif item.professionSkill then
                professionSkillText = item.professionSkill .. " - Level " .. item.professionSkillNeeded
            else
                professionSkillText = "Level " .. item.professionSkillNeeded
            end
        elseif item.professionSkill then
            professionSkillText = item.professionSkill
        end

        -- Get recipe name from spellID (what you craft)
        if item.professionSpellID then
            local spellInfo = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(item.professionSpellID)
            if spellInfo and spellInfo.name then
                professionRecipeText = spellInfo.name
            end
        elseif item.professionRecipeID then
            -- Fallback: try getting recipe info if available
            if C_TradeSkillUI and C_TradeSkillUI.GetRecipeInfo then
                local recipeInfo = C_TradeSkillUI.GetRecipeInfo(item.professionRecipeID)
                if recipeInfo and recipeInfo.name then
                    professionRecipeText = recipeInfo.name
                end
            end
        end

        -- Build combined text for backwards compatibility
        professionText = professionName
        if professionSkillText then
            professionText = professionText .. " (" .. professionSkillText .. ")"
        end
        if professionRecipeText then
            professionText = professionText .. "\n" .. professionRecipeText
        end
    elseif catalogData.profession then
        professionName = catalogData.profession
        professionText = catalogData.profession
    end
    
    if not eventText and catalogData.event then
        eventText = catalogData.event
    end
    if not classText and catalogData.class then
        classText = catalogData.class
    end
    if not raceText and catalogData.race then
        raceText = catalogData.race
    end

    -- Set quest value with tooltip
    if questText and questText ~= "" and questText ~= "N/A" then
        previewFrame.questValue:SetText(questText)
        previewFrame.questValue:Show()
        if previewFrame.questValue.label then previewFrame.questValue.label:Show() end

        if questID then
            previewFrame.questValue.questID = questID
            previewFrame.questValue:SetScript("OnEnter", function(self)
                if self.questID then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetHyperlink("quest:" .. self.questID)
                    GameTooltip:Show()
                end
            end)
            previewFrame.questValue:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
        end
    else
        previewFrame.SetFieldValue(previewFrame.questValue, nil, previewFrame.questValue.label)
    end

    -- Set achievement value with tooltip
    if achievementText and achievementText ~= "" and achievementText ~= "N/A" then
        previewFrame.achievementValue:SetText(achievementText)
        previewFrame.achievementValue:Show()
        if previewFrame.achievementValue.label then previewFrame.achievementValue.label:Show() end

        if achievementID then
            previewFrame.achievementValue.achievementID = achievementID
            previewFrame.achievementValue:SetScript("OnEnter", function(self)
                if self.achievementID then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetAchievementByID(self.achievementID)
                    GameTooltip:Show()
                end
            end)
            previewFrame.achievementValue:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
        end
    else
        previewFrame.SetFieldValue(previewFrame.achievementValue, nil, previewFrame.achievementValue.label)
    end

    -- Set reputation value (use parsed reputation from zone if available)
    if parsedReputation and not reputationText then
        reputationText = parsedReputation
    end
    
    -- Update reputation display with color-coded status
    if reputationText and reputationText ~= "" and reputationText ~= "N/A" then
        -- Strip any existing color codes from reputationText for parsing
        local cleanText = reputationText:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("%(Met%)", ""):gsub("%(Need[^)]+%)", "")
        
        -- Parse faction name and required standing
        -- Format can be: "FactionName - Standing" or "FactionName - Requires Standing - CurrentStanding (...)"
        local factionName, requiredStanding = nil, nil
        
        -- Try "Requires" pattern first (most common format: "FactionName - Requires Standing - ...")
        factionName, requiredStanding = cleanText:match("^(.-)%s*%-%s*Requires%s+(%w+)")
        
        -- If that didn't work, try simple "FactionName - Standing" pattern (no "Requires")
        if not factionName or not requiredStanding then
            factionName, requiredStanding = cleanText:match("^(.-)%s*%-%s*(%w+)$")
        end
        
        -- Clean up whitespace
        if factionName then
            factionName = factionName:match("^%s*(.-)%s*$")
        end
        if requiredStanding then
            requiredStanding = requiredStanding:match("^%s*(.-)%s*$")
        end
        
        if factionName and requiredStanding then
            -- Get faction ID from mapping
            local factionID = HousingVendorFactionIDs and HousingVendorFactionIDs[factionName]
            
            -- Also try the hardcoded map from earlier parsing
            if not factionID then
                local factionIDMap = {
                    ["Council of Exarchs"] = 1731,
                    ["Laughing Skull Orcs"] = 1708,
                    ["Steamwheedle Preservation Society"] = 1711,
                    ["Sha'tari Defense"] = 1710,
                    ["Vol'jin's Headhunters"] = 1681,
                    ["Frostwolf Orcs"] = 1445,
                    ["Wrynn's Vanguard"] = 1682,
                    ["Arakkoa Outcasts"] = 1515,
                    ["Highmountain Tribe"] = 1828,
                    ["The Nightfallen"] = 1859,
                    ["Dreamweavers"] = 1883,
                    ["Zandalari Empire"] = 2103,
                    ["Talanji's Expedition"] = 2156,
                    ["The Honorbound"] = 2160,
                    ["Proudmoore Admiralty"] = 2160,
                    ["Storm's Wake"] = 2162,
                    ["Order of Embers"] = 2161,
                }
                factionID = factionIDMap[factionName]
            end
            
            local displayText = ""
            local requirementMet = false
            
            if factionID and C_Reputation and C_Reputation.GetFactionDataByID then
                local factionData = C_Reputation.GetFactionDataByID(factionID)
                if factionData and factionData.reaction then
                    local repLevels = {[1]="Hated", [2]="Hostile", [3]="Unfriendly", [4]="Neutral", [5]="Friendly", [6]="Honored", [7]="Revered", [8]="Exalted"}
                    local currentStanding = repLevels[factionData.reaction] or "Unknown"
                    
                    -- Calculate progress within current standing
                    local current = factionData.currentReactionThreshold or 0
                    local min = factionData.currentStanding or 0
                    local max = factionData.nextReactionThreshold or min + 1
                    
                    -- Check if requirement is met - normalize requiredStanding for comparison
                    local requiredLevel = 0
                    local requiredStandingClean = requiredStanding:gsub("^Requires%s+", ""):gsub("^%s+", ""):gsub("%s+$", "")
                    
                    for level, name in pairs(repLevels) do
                        if name:lower() == requiredStandingClean:lower() then
                            requiredLevel = level
                            break
                        end
                    end
                    
                    -- If we found a required level, check if requirement is met
                    if requiredLevel > 0 then
                        requirementMet = (factionData.reaction >= requiredLevel)
                    else
                        -- Couldn't parse required level, assume not met
                        requirementMet = false
                    end
                    
                    -- Color code the faction name: green if met, red if not
                    local colorCode = requirementMet and "|cFF00FF00" or "|cFFFF0000"
                    local coloredFactionName = colorCode .. factionName .. "|r"
                    
                    -- Build progress text with color coding
                    local progressText = currentStanding .. " (" .. (current - min) .. "/" .. (max - min) .. ")"
                    
                    if requirementMet then
                        progressText = "|cFF00FF00" .. progressText .. "|r"  -- Green for met
                    else
                        progressText = "|cFFFF0000" .. progressText .. "|r"  -- Red for not met
                    end
                    
                    displayText = coloredFactionName .. " - Requires " .. requiredStandingClean .. " - " .. progressText
                else
                    -- No faction data, show without color
                    displayText = factionName .. " - Requires " .. requiredStanding .. " - Unknown"
                end
            else
                -- No faction ID found, show without color
                displayText = factionName .. " - Requires " .. requiredStanding .. " - Unknown"
            end
            
            previewFrame.SetFieldValue(previewFrame.reputationValue, displayText, previewFrame.reputationValue.label)
            if displayText then
                previewFrame.reputationValue.tooltipText = L["TOOLTIP_INFO_REPUTATION"] or "Reputation requirement to purchase this item from the vendor"
            end
        else
            previewFrame.SetFieldValue(previewFrame.reputationValue, reputationText, previewFrame.reputationValue.label)
            if reputationText then
                previewFrame.reputationValue.tooltipText = L["TOOLTIP_INFO_RENOWN"] or "Reputation requirement to purchase this item from the vendor"
            end
        end
    else
        previewFrame.SetFieldValue(previewFrame.reputationValue, nil, previewFrame.reputationValue.label)
    end

    -- Set renown value
    previewFrame.SetFieldValue(previewFrame.renownValue, renownText, previewFrame.renownValue.label)
    if renownText then
        previewFrame.renownValue.tooltipText = L["TOOLTIP_INFO_RENOWN"] or "Renown level required with a major faction to unlock this item"
    end

    -- Set profession values (separate fields for Profession Information section)
    previewFrame.SetFieldValue(previewFrame.professionValue, professionName, previewFrame.professionValue.label)
    if professionName then
        previewFrame.professionValue.tooltipText = L["TOOLTIP_INFO_PROFESSION"] or "The profession required to craft this item"
    end
    
    previewFrame.SetFieldValue(previewFrame.professionSkillValue, professionSkillText, previewFrame.professionSkillValue.label)
    if professionSkillText then
        previewFrame.professionSkillValue.tooltipText = L["TOOLTIP_INFO_PROFESSION_SKILL"] or "Skill level required in this profession to craft the item"
    end
    
    previewFrame.SetFieldValue(previewFrame.professionRecipeValue, professionRecipeText, previewFrame.professionRecipeValue.label)
    if professionRecipeText then
        previewFrame.professionRecipeValue.tooltipText = L["TOOLTIP_INFO_PROFESSION_RECIPE"] or "The recipe or pattern name for crafting this item"
    end

    -- Display reagents for profession items
    local itemID = tonumber(item.itemID)
    local reagentData = itemID and HousingVendor.ProfessionReagents and HousingVendor.ProfessionReagents:GetReagents(itemID)
    
    -- Get theme colors for reagent display
    local theme = GetTheme()
    local colors = theme.colors or {}
    local textPrimary = HousingTheme.Colors.textPrimary
    local textSecondary = HousingTheme.Colors.textSecondary
    local accentPrimary = HousingTheme.Colors.accentPrimary
    
    -- Hide existing reagents container
    if previewFrame.reagentsContainer then
        previewFrame.reagentsContainer:Hide()
        if previewFrame.reagentsContainer.header then
            previewFrame.reagentsContainer.header:Hide()
        end
        for _, line in pairs(previewFrame.reagentsContainer.lines or {}) do
            line:Hide()
        end
    end
    
    if reagentData and reagentData.reagents and #reagentData.reagents > 0 then
        -- Create container if needed (positioned on RIGHT side of panel)
        if not previewFrame.reagentsContainer then
            local container = CreateFrame("Frame", nil, previewFrame.details)
            container:SetWidth(210)
            container:SetHeight(1)
            container.lines = {}
            previewFrame.reagentsContainer = container
        end
        
        local container = previewFrame.reagentsContainer
        -- Position container on the RIGHT side, aligned with profession header
        container:ClearAllPoints()
        container:SetPoint("TOPRIGHT", previewFrame.details, "TOPRIGHT", -10, (previewFrame.professionHeader:GetTop() - previewFrame.details:GetTop()))
        container:Show()
        
        -- Create header if needed
        if not container.header then
            local header = previewFrame.details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            header:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)
            header:SetWidth(200)
            header:SetJustifyH("LEFT")
            header:SetText("Reagents:")
            header:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)  -- Match Profession/Vendor header color
            container.header = header
        end
        container.header:Show()
        
        -- Display each reagent (single column on right side)
        local yOffset = -18  -- Increased spacing for larger font
        for i, reagent in ipairs(reagentData.reagents) do
            if not container.lines[i] then
                local line = previewFrame.details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                line:SetJustifyH("LEFT")
                line:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
                container.lines[i] = line
            end
            
            local line = container.lines[i]
            line:ClearAllPoints()
            line:SetPoint("TOPRIGHT", container.header, "BOTTOMRIGHT", 0, yOffset)
            line:SetWidth(200)
            
            -- Get item name for reagent using API
            local reagentName = nil
            if C_Item and C_Item.GetItemNameByID then
                reagentName = C_Item.GetItemNameByID(reagent.id)
            end
            
            -- Fallback to GetItemInfo if GetItemNameByID not available
            if not reagentName and C_Item and C_Item.GetItemInfo then
                reagentName = C_Item.GetItemInfo(reagent.id)
            end
            
            -- If still no name, cache the item and show placeholder
            if not reagentName then
                reagentName = "Loading..."
                -- Request item info to cache it
                C_Item.RequestLoadItemDataByID(reagent.id)
                -- Retry after a delay
                C_Timer.After(0.5, function()
                    local name = C_Item.GetItemNameByID(reagent.id)
                    if name and line then
                        line:SetText(reagent.amount .. "x " .. name)
                    end
                end)
            end
            
            line:SetText(reagent.amount .. "x " .. reagentName)
            line:Show()
            yOffset = yOffset - 14
        end
        
        -- Hide unused lines
        for i = #reagentData.reagents + 1, #container.lines do
            container.lines[i]:Hide()
        end
        
        -- Adjust container height
        container:SetHeight(math.abs(yOffset) + 14)
    end

    -- Set event value
    previewFrame.SetFieldValue(previewFrame.eventValue, eventText, previewFrame.eventValue.label)
    if eventText then
        previewFrame.eventValue.tooltipText = L["TOOLTIP_INFO_EVENT"] or "Special event or holiday when this item is available"
    end

    -- Set class value
    previewFrame.SetFieldValue(previewFrame.classValue, classText, previewFrame.classValue.label)
    if classText then
        previewFrame.classValue.tooltipText = L["TOOLTIP_INFO_CLASS"] or "This item can only be used by this class"
    end

    -- Set race value
    previewFrame.SetFieldValue(previewFrame.raceValue, raceText, previewFrame.raceValue.label)
    if raceText then
        previewFrame.raceValue.tooltipText = L["TOOLTIP_INFO_RACE"] or "This item can only be used by this race"
    end

    --------------------------------------------------------
    -- UPDATE HEADER VISIBILITY (hide headers when all fields in section are empty)
    --------------------------------------------------------
    -- Item Information section is hidden (redundant with list view)
    -- previewFrame.UpdateHeaderVisibility(previewFrame.basicInfoHeader, {
    --     previewFrame.categoryValue,
    --     previewFrame.subcategoryValue,
    --     previewFrame.sourceTypeValue,
    --     previewFrame.collectionValue
    -- })

    previewFrame.UpdateHeaderVisibility(previewFrame.vendorHeader, {
        previewFrame.vendorValue,
        previewFrame.factionValue,
        previewFrame.reputationValue,
        previewFrame.renownValue,
        previewFrame.costValue,
        previewFrame.expansionValue,
        previewFrame.zoneValue
        -- Removed coordsValue - redundant with map button
    })

    previewFrame.UpdateHeaderVisibility(previewFrame.professionHeader, {
        previewFrame.professionValue,
        previewFrame.professionSkillValue,
        previewFrame.professionRecipeValue,
        previewFrame.reagentsContainer
    })

    previewFrame.UpdateHeaderVisibility(previewFrame.requirementsHeader, {
        previewFrame.questValue,
        previewFrame.achievementValue,
        previewFrame.eventValue,
        previewFrame.classValue,
        previewFrame.raceValue
    })

    --------------------------------------------------------
    -- MAP BUTTON (use API vendor info first)
    --------------------------------------------------------
    -- Prefer API vendor info for map/coords; fallback to item data
    local waypointData = nil
    if apiMapID and coordsText then
        -- Extract x,y from coordsText "24.7, 43.9"
        local x, y = coordsText:match("([%d%.]+),%s*([%d%.]+)")
        if x and y then
            waypointData = {
                vendorCoords = {x = tonumber(x), y = tonumber(y)},
                mapID = apiMapID,
                vendorName = vendor or "Vendor",
                zoneName = zone or "Unknown"
            }
        end
    elseif item.vendorCoords and item.mapID and item.vendorCoords.x and item.vendorCoords.y then
        waypointData = {
            vendorCoords = item.vendorCoords,
            mapID = item.mapID,
            vendorName = vendor or "Vendor",
            zoneName = zone or "Unknown"
        }
    end
    
    if waypointData then
        previewFrame._vendorInfo = waypointData
        previewFrame.mapBtn:Show()
    else
        previewFrame.mapBtn:Hide()
    end

    --------------------------------------------------------
    -- 3D MODEL PREVIEW (integrated into info panel)
    --------------------------------------------------------
    -- Get model file ID and store it
    local modelFileID = catalogData and (catalogData.asset or catalogData.modelFileID)
    previewFrame._currentModelID = modelFileID
    
    if previewFrame.modelFrame and modelFileID and previewFrame.modelVisible then
        previewFrame.modelContainer:Show()

        if modelFileID > 0 then
            -- PlayerModel uses SetModel() directly
            previewFrame.modelFrame:SetModel(modelFileID)
        else
            -- No model available, hide the container
            previewFrame.modelContainer:Hide()
        end
    elseif previewFrame.modelContainer then
        previewFrame.modelContainer:Hide()
    end
end

------------------------------------------------------------
-- Make globally accessible
------------------------------------------------------------
_G["HousingPreviewPanel"] = PreviewPanel

return PreviewPanel
