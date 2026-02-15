-- Model Viewer Module
-- Replaces item list with 3D model preview (like Materials Tracker)

local ModelViewer = {}
ModelViewer.__index = ModelViewer
-- Make globally accessible for other modules (PreviewPanel, HousingUI)
_G["HousingModelViewer"] = ModelViewer

-- Import required libraries
local C_Timer = C_Timer or _G.C_Timer

-- Global state for rotation
local modelFrame = nil
local isInitialized = false
local currentRotation = 0
local currentPitch = 0  -- Vertical rotation
local currentRoll = 0   -- Tilt
local rotationSpeed = 0.5
local isDragging = false
local lastMouseX = 0
local lastMouseY = 0
local dragMode = nil  -- "yaw", "pitch", "roll"
local parentFrame = nil

-- Camera settings for better positioning
local cameraDistance = 4.0
local cameraPosition = { x = 0, y = 0, z = 0 }

-- Hide/show main UI (same pattern as MaterialsTrackerUI)
local function SetMainUIVisible(visible)
    -- Only hide/show item list - keep filters and nav buttons visible
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:SetShown(visible)
    end
    if _G["HousingItemListContainer"] then
        _G["HousingItemListContainer"]:SetShown(visible)
    end
    if _G["HousingItemListHeader"] then
        _G["HousingItemListHeader"]:SetShown(visible)
    end
    -- Keep filters visible
    -- Keep nav buttons visible
    -- Keep preview panel visible
end

-- Debug function (disabled to reduce spam)
local function DebugPrint(message)
    -- Silently discard debug messages
end

-- Helper to fit the model into the frame with proper centering
local function ApplyFitToFrame(actor, modelFileID)
    if not actor then return end
    
    -- Reset transformations
    currentScale = 1.0
    currentYaw = 0
    currentPitch = 0
    currentActor = actor
    
    -- Check if we have positioning data for this model
    local positionData = nil
    if modelFileID and HousingModelPositions then
        positionData = HousingModelPositions[tonumber(modelFileID)]
    end
    
    if positionData then
        -- Use custom positioning from HousingModelPositions
        DebugPrint(string.format("Using custom positioning for model %s", tostring(modelFileID)))
        
        actor:SetPosition(positionData.model_x, positionData.camera_y, positionData.model_z)
        
        -- Use zoom as scale (converted appropriately)
        local scale = positionData.zoom / 10.0  -- Adjust scale factor as needed
        currentScale = math.max(0.1, math.min(scale, 5.0))
        actor:SetScale(currentScale)
        
        DebugPrint(string.format("Custom position: x=%.2f, y=%.2f, z=%.2f, scale=%.2f",
            positionData.model_x, positionData.camera_y, positionData.model_z, currentScale))
    else
        -- Use default positioning
        actor:SetPosition(0, 0, 0)
        actor:SetScale(currentScale)
        DebugPrint("Using default positioning (no custom data)")
    end
    
    -- Reset rotations
    if actor.SetYaw then actor:SetYaw(0) end
    if actor.SetPitch then actor:SetPitch(0) end
    if actor.SetRoll then actor:SetRoll(0) end
    if actor.Show then actor:Show() end
    
    -- Try to auto-adjust the camera to fit the model
    if actor.SetCamera then
        pcall(function() 
            actor:SetCamera(0)  -- Use default camera
        end)
    end
    
    -- Debug: Check if actor is actually visible
    local isShown = actor:IsShown()
    local x, y, z = actor:GetPosition()
    local scale = actor:GetScale()
    
    DebugPrint(string.format("Actor setup: visible=%s, scale=%.2f, pos=(%.2f,%.2f,%.2f)",
        tostring(isShown), scale, x, y, z))
end

-- Initialize the model viewer
function ModelViewer:Initialize(parent)
    if isInitialized then return end
    
    parentFrame = parent
    DebugPrint("Initializing ModelViewer...")
    
    -- Get theme colors
    local HousingTheme = _G.HousingTheme or {}
    local colors = HousingTheme.Colors or {}
    local bgPrimary = colors.bgPrimary or { 0.10, 0.08, 0.15, 0.95 }
    local bgSecondary = colors.bgSecondary or { 0.14, 0.11, 0.20, 0.95 }
    local borderPrimary = colors.borderPrimary or { 0.35, 0.30, 0.50, 0.8 }
    local textPrimary = colors.textPrimary or { 0.92, 0.90, 0.96, 1.0 }
    local textSecondary = colors.textSecondary or { 0.70, 0.68, 0.78, 1.0 }
    local accentPrimary = colors.accentPrimary or { 0.70, 0.50, 0.95, 1.0 }
    local accentGold = colors.accentGold or { 1.0, 0.82, 0.0, 1.0 }
    
    -- Create main frame (replaces item list, same as MaterialsTrackerUI)
    modelFrame = CreateFrame("Frame", "HousingModelViewerFrame", parent, "BackdropTemplate")
    
    -- Position to replace item list (same as MaterialsTrackerUI)
    modelFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, -215)
    modelFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -370, 52)
    modelFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    modelFrame:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], bgPrimary[4])
    modelFrame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    modelFrame:Hide()
    
    -- Title bar (for buttons only, no title text)
    local titleBar = CreateFrame("Frame", nil, modelFrame)
    titleBar:SetPoint("TOP", 0, -10)
    titleBar:SetSize(390, 30)

    -- Back button (custom themed button)
    local backBtn = CreateFrame("Button", nil, modelFrame, "BackdropTemplate")
    backBtn:SetSize(70, 26)
    backBtn:SetPoint("TOPRIGHT", -15, -12)
    backBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    backBtn:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.9)
    backBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    
    local backText = backBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    backText:SetPoint("CENTER")
    backText:SetText("Back")
    backText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    backBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.4)
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    backBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.9)
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    end)
    backBtn:SetScript("OnClick", function()
        ModelViewer:Hide()
    end)
    modelFrame.backBtn = backBtn

    -- Reset View button (custom themed)
    local resetBtn = CreateFrame("Button", nil, titleBar, "BackdropTemplate")
    resetBtn:SetSize(85, 22)
    resetBtn:SetPoint("RIGHT", backBtn, "LEFT", -8, 0)
    resetBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    resetBtn:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.9)
    resetBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    
    local resetText = resetBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    resetText:SetPoint("CENTER")
    resetText:SetText("Reset View")
    resetText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    
    resetBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.4)
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    resetBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.9)
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    end)
    resetBtn:SetScript("OnClick", function()
        -- Reset all rotations
        currentRotation = 0
        currentPitch = 0
        currentRoll = 0
        modelFrame.cameraDistance = 4.0
        
        -- Reset model scene orientation
        if modelFrame.modelScene then
            modelFrame.modelScene:SetFacing(0)
            if modelFrame.modelScene.SetPitch then
                modelFrame.modelScene:SetPitch(0)
            end
            if modelFrame.modelScene.SetRoll then
                modelFrame.modelScene:SetRoll(0)
            end
            if modelFrame.modelScene.SetCameraDistance then
                modelFrame.modelScene:SetCameraDistance(4.0)
            end
        end
        
        DebugPrint("View reset to default position")
    end)
    modelFrame.resetBtn = resetBtn
    
    -- Debug info text (scrollable for long debug output)
    local debugScroll = CreateFrame("ScrollFrame", nil, modelFrame, "UIPanelScrollFrameTemplate")
    debugScroll:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 5, -5)
    debugScroll:SetPoint("TOPRIGHT", titleBar, "BOTTOMRIGHT", -25, -5)
    debugScroll:SetHeight(1)  -- Hide debug area
    debugScroll:Hide()  -- Don't show debug
    modelFrame.debugScroll = debugScroll
    
    local debugContent = CreateFrame("Frame", nil, debugScroll)
    debugContent:SetWidth(debugScroll:GetWidth() - 20)
    debugScroll:SetScrollChild(debugContent)
    
    local debugText = debugContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    debugText:SetPoint("TOPLEFT", 0, 0)
    debugText:SetPoint("RIGHT", 0, 0)
    debugText:SetJustifyH("LEFT")
    debugText:SetTextColor(0.8, 0.8, 0.5, 1)  -- Yellowish for debug
    debugText:SetWordWrap(true)
    modelFrame.debugText = debugText
    
    -- Store camera distance for zoom controls
    modelFrame.cameraDistance = 4.0
    
    -- Control buttons container - positioned at bottom of model frame
    local controlsFrame = CreateFrame("Frame", "HousingModelViewerControls", modelFrame)
    controlsFrame:SetPoint("BOTTOM", modelFrame, "BOTTOM", 0, 15)  -- Near bottom with small padding
    controlsFrame:SetSize(120, 24)
    controlsFrame:SetFrameStrata("HIGH")
    
    -- Themed background for controls
    local controlsBg = controlsFrame:CreateTexture(nil, "BACKGROUND")
    controlsBg:SetAllPoints()
    controlsBg:SetColorTexture(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.5)
    
    -- Rotate Left button
    local rotateLeftBtn = CreateFrame("Button", nil, controlsFrame)
    rotateLeftBtn:SetSize(24, 24)
    rotateLeftBtn:SetPoint("LEFT", controlsFrame, "LEFT", 3, 0)
    
    local rotateLeftIcon = rotateLeftBtn:CreateTexture(nil, "ARTWORK")
    rotateLeftIcon:SetAllPoints()
    rotateLeftIcon:SetTexture("Interface\\AddOns\\HousingVendor\\Data\\Media\\HousingCodex_Left.tga")
    
    rotateLeftBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    rotateLeftBtn:SetScript("OnClick", function()
        currentRotation = currentRotation - 0.3
        modelFrame.modelScene:SetFacing(currentRotation)
    end)
    rotateLeftBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Rotate Left", 1, 1, 1)
        GameTooltip:Show()
    end)
    rotateLeftBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Rotate Right button
    local rotateRightBtn = CreateFrame("Button", nil, controlsFrame)
    rotateRightBtn:SetSize(24, 24)
    rotateRightBtn:SetPoint("LEFT", rotateLeftBtn, "RIGHT", 2, 0)
    
    local rotateRightIcon = rotateRightBtn:CreateTexture(nil, "ARTWORK")
    rotateRightIcon:SetAllPoints()
    rotateRightIcon:SetTexture("Interface\\AddOns\\HousingVendor\\Data\\Media\\HousingCodex_Right.tga")
    
    rotateRightBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    rotateRightBtn:SetScript("OnClick", function()
        currentRotation = currentRotation + 0.3
        modelFrame.modelScene:SetFacing(currentRotation)
    end)
    rotateRightBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Rotate Right", 1, 1, 1)
        GameTooltip:Show()
    end)
    rotateRightBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Zoom In button
    local zoomInBtn = CreateFrame("Button", nil, controlsFrame)
    zoomInBtn:SetSize(24, 24)
    zoomInBtn:SetPoint("LEFT", rotateRightBtn, "RIGHT", 2, 0)
    
    local zoomInIcon = zoomInBtn:CreateTexture(nil, "ARTWORK")
    zoomInIcon:SetAllPoints()
    zoomInIcon:SetTexture("Interface\\AddOns\\HousingVendor\\Data\\Media\\HousingCodex_ZoomIn.tga")
    
    zoomInBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    zoomInBtn:SetScript("OnClick", function()
        local currentDist = modelFrame.cameraDistance or 4.0
        local newDist = currentDist - 1.5
        newDist = math.max(0.5, math.min(newDist, 30))
        modelFrame.cameraDistance = newDist
        if modelFrame.modelScene.SetCameraDistance then
            modelFrame.modelScene:SetCameraDistance(newDist)
        end
    end)
    zoomInBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Zoom In", 1, 1, 1)
        GameTooltip:Show()
    end)
    zoomInBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Zoom Out button
    local zoomOutBtn = CreateFrame("Button", nil, controlsFrame)
    zoomOutBtn:SetSize(24, 24)
    zoomOutBtn:SetPoint("LEFT", zoomInBtn, "RIGHT", 2, 0)
    
    local zoomOutIcon = zoomOutBtn:CreateTexture(nil, "ARTWORK")
    zoomOutIcon:SetAllPoints()
    zoomOutIcon:SetTexture("Interface\\AddOns\\HousingVendor\\Data\\Media\\HousingCodex_ZoomOut.tga")
    
    zoomOutBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    zoomOutBtn:SetScript("OnClick", function()
        local currentDist = modelFrame.cameraDistance or 4.0
        local newDist = currentDist + 1.5
        newDist = math.max(0.5, math.min(newDist, 30))
        modelFrame.cameraDistance = newDist
        if modelFrame.modelScene.SetCameraDistance then
            modelFrame.modelScene:SetCameraDistance(newDist)
        end
    end)
    zoomOutBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Zoom Out", 1, 1, 1)
        GameTooltip:Show()
    end)
    zoomOutBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    modelFrame.controlsFrame = controlsFrame
    controlsFrame:Show()
    
    -- Rotation Presets Panel (below controls)
    local presetsFrame = CreateFrame("Frame", "HousingModelViewerPresets", modelFrame, "BackdropTemplate")
    presetsFrame:SetPoint("TOP", controlsFrame, "BOTTOM", 0, -5)
    presetsFrame:SetSize(240, 60)
    presetsFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    presetsFrame:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.7)
    presetsFrame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.6)
    presetsFrame:SetFrameStrata("HIGH")
    
    -- Rotation Info Display
    local rotationLabel = presetsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    rotationLabel:SetPoint("TOP", 0, -5)
    rotationLabel:SetText("Rotation Controls")
    rotationLabel:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    
    local rotationInfo = presetsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    rotationInfo:SetPoint("TOP", rotationLabel, "BOTTOM", 0, -3)
    rotationInfo:SetText("Left: Pitch | Right: Yaw | Alt+Left: Roll")
    rotationInfo:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 0.8)
    modelFrame.rotationInfo = rotationInfo
    
    -- Preset buttons container
    local presetButtonsFrame = CreateFrame("Frame", nil, presetsFrame)
    presetButtonsFrame:SetPoint("BOTTOM", presetsFrame, "BOTTOM", 0, 5)
    presetButtonsFrame:SetSize(220, 24)
    
    -- Helper function to create preset buttons
    local function CreatePresetButton(parent, text, angle, offsetX)
        local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
        btn:SetSize(50, 20)
        btn:SetPoint("LEFT", parent, "LEFT", offsetX, 0)
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false,
            edgeSize = 1,
            insets = { left = 1, right = 1, top = 1, bottom = 1 }
        })
        btn:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], 0.9)
        btn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.7)
        
        local btnText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        btnText:SetPoint("CENTER")
        btnText:SetText(text)
        btnText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        
        btn:SetScript("OnEnter", function(self)
            self:SetBackdropColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.3)
            self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.9)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText("Rotate " .. angle .. "°", 1, 1, 1)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function(self)
            self:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], 0.9)
            self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.7)
            GameTooltip:Hide()
        end)
        
        return btn
    end
    
    -- Create preset buttons
    local btn45 = CreatePresetButton(presetButtonsFrame, "45°", 45, 5)
    btn45:SetScript("OnClick", function()
        currentRotation = currentRotation + math.rad(45)
        modelFrame.modelScene:SetFacing(currentRotation)
    end)
    
    local btn90 = CreatePresetButton(presetButtonsFrame, "90°", 90, 60)
    btn90:SetScript("OnClick", function()
        currentRotation = currentRotation + math.rad(90)
        modelFrame.modelScene:SetFacing(currentRotation)
    end)
    
    local btn180 = CreatePresetButton(presetButtonsFrame, "180°", 180, 115)
    btn180:SetScript("OnClick", function()
        currentRotation = currentRotation + math.rad(180)
        modelFrame.modelScene:SetFacing(currentRotation)
    end)
    
    local btnFlip = CreatePresetButton(presetButtonsFrame, "Flip", "V", 170)
    btnFlip:SetSize(45, 20)
    btnFlip:SetScript("OnClick", function()
        currentPitch = currentPitch + math.rad(180)
        if modelFrame.modelScene.SetPitch then
            modelFrame.modelScene:SetPitch(currentPitch)
        end
    end)
    btnFlip:SetScript("OnEnter", function(self)
        self:SetBackdropColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.3)
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.9)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Flip Vertically", 1, 1, 1)
        GameTooltip:Show()
    end)
    
    modelFrame.presetsFrame = presetsFrame
    presetsFrame:Show()
    
    -- Model viewer (use PlayerModel instead of ModelScene for simplicity)
    local modelScene = CreateFrame("PlayerModel", nil, modelFrame)
    modelScene:SetPoint("TOP", titleBar, "BOTTOM", 0, -10)  -- Start below title bar
    modelScene:SetPoint("LEFT", 10, 0)
    modelScene:SetPoint("RIGHT", -10, 0)
    modelScene:SetPoint("BOTTOM", controlsFrame, "TOP", 0, -5)  -- Stop above controls
    
    -- Simple background for the model scene
    local bg = modelScene:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.05, 0.05, 0.05, 0.9)
    
    -- Set up camera when model loads
    modelScene:SetScript("OnModelLoaded", function(self)
        if self.MakeCurrentCameraCustom then
            self:MakeCurrentCameraCustom()
        end
        self:SetPosition(0, 0, 0)
        if self.SetCameraPosition then
            self:SetCameraPosition(0, 0, 4)
        end
        if self.SetCameraDistance then
            self:SetCameraDistance(10)
        end
    end)
    
    modelFrame.modelScene = modelScene

    -- Interaction: Multi-button drag to rotate, mouse wheel to zoom
    modelScene:EnableMouse(true)
    modelScene:EnableMouseWheel(true)
    modelScene:RegisterForDrag("LeftButton", "RightButton")  -- Enable both buttons
    
    -- Mouse drag rotation with multiple modes
    modelScene:SetScript("OnMouseDown", function(self, button)
        if button == "RightButton" then
            -- Right-click: Horizontal rotation (yaw)
            dragMode = "yaw"
        elseif button == "LeftButton" then
            if IsAltKeyDown() then
                -- Alt+Left: Roll (tilt)
                dragMode = "roll"
            else
                -- Left-click: Vertical rotation (pitch)
                dragMode = "pitch"
            end
        else
            return
        end
        
        isDragging = true
        local scale = self:GetEffectiveScale()
        lastMouseX, lastMouseY = GetCursorPosition()
        lastMouseX = lastMouseX / scale
        lastMouseY = lastMouseY / scale

        self:SetScript("OnUpdate", function(sceneFrame)
            if not isDragging then
                sceneFrame:SetScript("OnUpdate", nil)
                return
            end
            
            local s = sceneFrame:GetEffectiveScale()
            local cursorX, cursorY = GetCursorPosition()
            local mouseX = cursorX / s
            local mouseY = cursorY / s
            
            -- Speed multiplier with Shift key
            local speedMult = IsShiftKeyDown() and 2.0 or 1.0
            
            if dragMode == "yaw" then
                -- Horizontal rotation
                local delta = (mouseX - lastMouseX) * 0.005 * speedMult
                currentRotation = currentRotation + delta
                sceneFrame:SetFacing(currentRotation)
                lastMouseX = mouseX
            elseif dragMode == "pitch" then
                -- Vertical rotation
                local delta = (mouseY - lastMouseY) * 0.005 * speedMult
                currentPitch = math.max(-1.5, math.min(1.5, currentPitch + delta))  -- Clamp pitch
                if sceneFrame.SetPitch then
                    sceneFrame:SetPitch(currentPitch)
                end
                lastMouseY = mouseY
            elseif dragMode == "roll" then
                -- Roll (tilt)
                local delta = (mouseX - lastMouseX) * 0.005 * speedMult
                currentRoll = currentRoll + delta
                if sceneFrame.SetRoll then
                    sceneFrame:SetRoll(currentRoll)
                end
                lastMouseX = mouseX
            end
        end)
    end)
    
    modelScene:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" or button == "LeftButton" then
            isDragging = false
            dragMode = nil
            self:SetScript("OnUpdate", nil)
        end
    end)

    modelScene:SetScript("OnHide", function(self)
        isDragging = false
        self:SetScript("OnUpdate", nil)
    end)

    -- Mouse wheel zoom
    modelScene:SetScript("OnMouseWheel", function(self, delta)
        -- Zoom by adjusting camera distance
        local currentDist = modelFrame.cameraDistance or 4.0
        local newDist = currentDist - (delta * 1.5)  -- Increased sensitivity
        newDist = math.max(0.5, math.min(newDist, 30))  -- Allow closer zoom
        modelFrame.cameraDistance = newDist
        
        if self.SetCameraDistance then
            self:SetCameraDistance(newDist)
        end
        
        DebugPrint(string.format("Zoom: distance=%.1f (delta=%d)", newDist, delta))
    end)
    
    -- Store reference
    _G["HousingModelViewer"] = ModelViewer
    
    isInitialized = true
    DebugPrint("ModelViewer initialized successfully")
end

-- Show model from catalog data (prioritize API data, fallback to ModelMapping)
function ModelViewer:ShowModel(catalogData, itemName, itemID)
    if not parentFrame then
        DebugPrint("ERROR: ModelViewer not initialized")
        return false
    end
    
    -- Create frame if needed
    if not modelFrame then
        self:Initialize(parentFrame)
    end
    
    if not modelFrame or not isInitialized then
        DebugPrint("ERROR: ModelViewer not initialized")
        return false
    end
    
    if not catalogData then
        DebugPrint("ERROR: No catalog data provided")
        return false
    end
    
    DebugPrint("=== ShowModel called ===")
    DebugPrint("Item Name: " .. (itemName or "Unknown"))
    DebugPrint("Item ID: " .. (itemID or "Unknown"))
    
    DebugPrint("API Data:")
    DebugPrint("  uiModelSceneID: " .. tostring(catalogData.uiModelSceneID or "nil"))
    DebugPrint("  asset: " .. tostring(catalogData.asset or "nil"))
    DebugPrint("  modelFileID (from catalog): " .. tostring(catalogData.modelFileID or "nil"))

    local hasModel = false
    local debugInfo = {}
    local sourceUsed = nil
    local modelFileID = nil
    
    -- Determine which model ID to use (simplified priority)
    if catalogData.asset and catalogData.asset > 0 then
        modelFileID = catalogData.asset
        sourceUsed = "API (asset)"
    elseif itemID and HousingAllItems then
        local numericItemID = tonumber(itemID)
        local decorData = numericItemID and HousingAllItems[numericItemID]
        if decorData then
            -- Format varies: {decorID, modelFileID, iconFileID} or {"Name", decorID, modelFileID, iconFileID}
            -- Check if first element is a string (item name) to determine offset
            if type(decorData[1]) == "string" then
                -- Format: {"Name", decorID, modelFileID, iconFileID}
                modelFileID = tonumber(decorData[3])
            else
                -- Format: {decorID, modelFileID, iconFileID}
                modelFileID = tonumber(decorData[2])
            end
            sourceUsed = "HousingAllItems (fallback)"
        end
    end
    
    table.insert(debugInfo, "Source: " .. (sourceUsed or "None"))
    table.insert(debugInfo, "ModelFileID: " .. tostring(modelFileID or "nil"))
    
    -- If we have a model ID, load it
    if modelFileID and modelFileID > 0 then
        -- Reset all rotations for new model
        currentRotation = 0
        currentPitch = 0
        currentRoll = 0
        modelFrame.cameraDistance = 4.0
        
        -- PlayerModel uses SetModel() instead of CreateActor
        modelFrame.modelScene:SetModel(modelFileID)
        modelFrame.modelScene:SetFacing(0)  -- Reset rotation
        modelFrame.modelScene:Show()
        
        table.insert(debugInfo, "Model set with ID: " .. modelFileID)
        hasModel = true
    else
        table.insert(debugInfo, "ERROR: No valid model ID")
    end
    
    -- Update debug text
    local debugString = "Debug Info:\n"
    if #debugInfo > 0 then
        debugString = debugString .. table.concat(debugInfo, "\n")
    else
        debugString = debugString .. "No model data available"
    end
    
    if hasModel then
        debugString = debugString .. "\n\nStatus: Model loaded successfully"
        if sourceUsed then
            debugString = debugString .. "\nSource: " .. sourceUsed
            if sourceUsed:match("static") then
                debugString = debugString .. "\nWARNING: Using static data - may be outdated!"
            else
                debugString = debugString .. "\nOK: Using current data"
            end
        end
    else
        debugString = debugString .. "\n\nStatus: No model could be loaded"
        debugString = debugString .. "\n\nTried:"
        debugString = debugString .. "\n1. API uiModelSceneID"
        debugString = debugString .. "\n2. API asset"
        debugString = debugString .. "\n3. HousingDecorData.lua"
        debugString = debugString .. "\n4. catalogData.modelFileID"
    end
    
    -- Update debug text and scroll to top
    if modelFrame.debugText then
        modelFrame.debugText:SetText(debugString)
        -- Resize debug content to fit text
        if modelFrame.debugScroll then
            local textHeight = modelFrame.debugText:GetStringHeight()
            modelFrame.debugText:GetParent():SetHeight(math.max(120, textHeight + 10))
            modelFrame.debugScroll:SetVerticalScroll(0)  -- Scroll to top
        end
    end
    
    -- Hide main UI and show model viewer (like MaterialsTrackerUI)
    SetMainUIVisible(false)
    modelFrame:Show()
    
    if hasModel then
        DebugPrint("ModelViewer shown - Model loaded successfully")
    else
        DebugPrint("ModelViewer shown - No model could be loaded (see debug info)")
    end
    
    return hasModel
end

-- Hide the model viewer and restore main UI
function ModelViewer:Hide()
    if modelFrame then
        -- Clear current actor
        if currentActor then
            currentActor:ClearModel()
            currentActor:Hide()
            currentActor = nil
        end

        modelFrame:Hide()
        DebugPrint("ModelViewer hidden and actor cleared")
    end
    
    -- Restore main UI (like MaterialsTrackerUI)
    SetMainUIVisible(true)
end

-- Toggle model viewer
function ModelViewer:Toggle()
    if modelFrame and modelFrame:IsShown() then
        self:Hide()
    else
        print("|cFFFF4040HousingVendor:|r Cannot toggle - use ShowModel() with item data")
    end
end

-- Check if model viewer is visible
function ModelViewer:IsVisible()
    return modelFrame and modelFrame:IsVisible() or false
end

return ModelViewer
